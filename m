Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Subject: [PATCH 06/19] lightnvm: pblk: check for supported version
Date: Mon, 26 Feb 2018 14:17:05 +0100
Message-Id: <1519651038-16845-7-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
References: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org,
 =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

QXQgdGhpcyBwb2ludCwgb25seSAxLjIgc3BlYyBpcyBzdXBwb3J0ZWQsIHRodXMgY2hlY2sgZm9y
IGl0LiBBbHNvLApzaW5jZSBkZXZpY2Utc2lkZSBMMlAgaXMgb25seSBzdXBwb3J0ZWQgaW4gdGhl
IDEuMiBzcGVjLCBtYWtlIHN1cmUgdG8Kb25seSBjaGVjayBpdHMgdmFsdWUgdW5kZXIgMS4yLgoK
U2lnbmVkLW9mZi1ieTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyQGNuZXhsYWJzLmNvbT4KLS0t
CiBkcml2ZXJzL2xpZ2h0bnZtL3BibGstaW5pdC5jIHwgMTAgKysrKysrKystLQogMSBmaWxlIGNo
YW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2xpZ2h0bnZtL3BibGstaW5pdC5jIGIvZHJpdmVycy9saWdodG52bS9wYmxrLWluaXQuYwpp
bmRleCA5NWVjYjBlYzczNmIuLjZlMDU2Nzk3MWNmNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9saWdo
dG52bS9wYmxrLWluaXQuYworKysgYi9kcml2ZXJzL2xpZ2h0bnZtL3BibGstaW5pdC5jCkBAIC05
OTAsOSArOTkwLDE1IEBAIHN0YXRpYyB2b2lkICpwYmxrX2luaXQoc3RydWN0IG52bV90Z3RfZGV2
ICpkZXYsIHN0cnVjdCBnZW5kaXNrICp0ZGlzaywKIAlzdHJ1Y3QgcGJsayAqcGJsazsKIAlpbnQg
cmV0OwogCi0JaWYgKGRldi0+Z2VvLmMuZG9tICYgTlZNX1JTUF9MMlApIHsKKwlpZiAoZ2VvLT5j
LnZlcnNpb24gIT0gTlZNX09DU1NEX1NQRUNfMTIpIHsKKwkJcHJfZXJyKCJwYmxrOiBPQ1NTRCB2
ZXJzaW9uIG5vdCBzdXBwb3J0ZWQgKCV1KVxuIiwKKwkJCQkJCQlnZW8tPmMudmVyc2lvbik7CisJ
CXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOworCX0KKworCWlmIChnZW8tPmMudmVyc2lvbiA9PSBO
Vk1fT0NTU0RfU1BFQ18xMiAmJiBnZW8tPmMuZG9tICYgTlZNX1JTUF9MMlApIHsKIAkJcHJfZXJy
KCJwYmxrOiBob3N0LXNpZGUgTDJQIHRhYmxlIG5vdCBzdXBwb3J0ZWQuICgleClcbiIsCi0JCQkJ
CQkJZGV2LT5nZW8uYy5kb20pOworCQkJCQkJCWdlby0+Yy5kb20pOwogCQlyZXR1cm4gRVJSX1BU
UigtRUlOVkFMKTsKIAl9CiAKLS0gCjIuNy40CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtbnZtZQo=
