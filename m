Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Subject: [PATCH 14/19] nvme: make nvme_get_log_ext available
Date: Mon, 26 Feb 2018 14:17:13 +0100
Message-Id: <1519651038-16845-15-git-send-email-javier@cnexlabs.com>
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

TWFrZSBudm1lX2dldF9sb2dfZXh0IGF2YWlsYWJsZSBvdXRzaWRlIG9mIGNvcmUuYy4KClRoaXMg
aXMgaW4gcHJlcGFyYXRpb24gZm9yIHVzaW5nIGl0IGluIGxpZ2h0bnZtLmMKClNpZ25lZC1vZmYt
Ynk6IEphdmllciBHb256w6FsZXogPGphdmllckBjbmV4bGFicy4+Ci0tLQogZHJpdmVycy9udm1l
L2hvc3QvbnZtZS5oIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9udm1lLmggYi9kcml2ZXJzL252bWUvaG9zdC9u
dm1lLmgKaW5kZXggMWNhMDhmNDk5M2JhLi41MDVmNzk3ZjhjNmMgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvbnZtZS9ob3N0L252bWUuaAorKysgYi9kcml2ZXJzL252bWUvaG9zdC9udm1lLmgKQEAgLTM5
Niw2ICszOTYsOSBAQCBpbnQgbnZtZV9yZXNldF9jdHJsKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwp
OwogaW50IG52bWVfZGVsZXRlX2N0cmwoc3RydWN0IG52bWVfY3RybCAqY3RybCk7CiBpbnQgbnZt
ZV9kZWxldGVfY3RybF9zeW5jKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpOwogCitpbnQgbnZtZV9n
ZXRfbG9nX2V4dChzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLCBzdHJ1Y3QgbnZtZV9ucyAqbnMsCisJ
CSAgICAgdTggbG9nX3BhZ2UsIHZvaWQgKmxvZywgc2l6ZV90IHNpemUsIHNpemVfdCBvZmZzZXQp
OworCiBleHRlcm4gY29uc3Qgc3RydWN0IGF0dHJpYnV0ZV9ncm91cCBudm1lX25zX2lkX2F0dHJf
Z3JvdXA7CiBleHRlcm4gY29uc3Qgc3RydWN0IGJsb2NrX2RldmljZV9vcGVyYXRpb25zIG52bWVf
bnNfaGVhZF9vcHM7CiAKLS0gCjIuNy40CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtbnZtZQo=
