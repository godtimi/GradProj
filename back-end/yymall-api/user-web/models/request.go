package models

import (
	"github.com/golang-jwt/jwt/v5"
)

type CustomClaims struct {
	ID          uint   `json:"id"`
	NickName    string `json:"nick_name"`
	AuthorityId uint   `json:"authority_id"`
	jwt.RegisteredClaims
}

func (c CustomClaims) GetExpirationTime() (*jwt.NumericDate, error) {
	return c.RegisteredClaims.GetExpirationTime()
}

func (c CustomClaims) GetIssuedAt() (*jwt.NumericDate, error) {
	return c.RegisteredClaims.GetIssuedAt()
}

func (c CustomClaims) GetNotBefore() (*jwt.NumericDate, error) {
	return c.RegisteredClaims.GetNotBefore()
}

func (c CustomClaims) GetIssuer() (string, error) {
	return c.RegisteredClaims.GetIssuer()
}

func (c CustomClaims) GetSubject() (string, error) {
	return c.RegisteredClaims.GetSubject()
}

func (c CustomClaims) GetAudience() (jwt.ClaimStrings, error) {
	return c.RegisteredClaims.GetAudience()
}
