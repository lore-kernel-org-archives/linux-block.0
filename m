Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Subject: [PATCH 16/19] lightnvm: define chunk states
Date: Mon, 26 Feb 2018 14:17:15 +0100
Message-Id: <1519651038-16845-17-git-send-email-javier@cnexlabs.com>
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

RGVmaW5lIGNodW5rIHN0YXRlcyBhcyBnaXZlbiBpbiB0aGUgMi4wIHNwZWMuIEFsc28sIGFkZCBh
biBleHRyYSBjaHVuawpzdGF0ZSB0aGF0IHNpZ25hbHMgdGhhdCB0aGUgY2h1bmsgaXMgaW4gdXNl
IGJ5IHRoZSBob3N0LiBUaGlzIGFsbG93cyBmb3IKdGhlIGNodW5rIG1ldGFkYXRhIHRvIGJlICJv
d25lZCIgYnkgYSB0YXJnZXQgd2hlbiBhY3RpdmUsIHRodXMKY29tcGxldGluZyB0aGUgY2h1bmsg
c3RhdGUgbWFjaGluZSBmcm9tIHRoZSBob3N0IHBlcnNwZWN0aXZlIGFuZApmYWNpbGl0YXRpbmcg
c2FuaXR5IGNoZWNrcy4gVGhpcyBzdGF0ZSBpcyB0cmFuc3BhcmVudCBmb3IgdGhlIGRldmljZS4K
ClNpZ25lZC1vZmYtYnk6IEphdmllciBHb256w6FsZXogPGphdmllckBjbmV4bGFicy5jb20+Ci0t
LQogaW5jbHVkZS9saW51eC9saWdodG52bS5oIHwgMTQgKysrKysrKysrKysrKysKIDEgZmlsZSBj
aGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9saWdo
dG52bS5oIGIvaW5jbHVkZS9saW51eC9saWdodG52bS5oCmluZGV4IDc3NmZmZGMyZTEzNy4uNzQ4
MzBkNWRiZDZlIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2xpZ2h0bnZtLmgKKysrIGIvaW5j
bHVkZS9saW51eC9saWdodG52bS5oCkBAIC0yMzIsNiArMjMyLDIwIEBAIHN0cnVjdCBudm1fYWRk
cl9mb3JtYXQgewogCXU2NAlyc3ZfbWFza1syXTsKIH07CiAKK2VudW0geworCS8qIENodW5rIHN0
YXRlcyAqLworCU5WTV9DSEtfU1RfRlJFRSA9CTEgPDwgMCwKKwlOVk1fQ0hLX1NUX0NMT1NFRCA9
CTEgPDwgMSwKKwlOVk1fQ0hLX1NUX09QRU4gPQkxIDw8IDIsCisJTlZNX0NIS19TVF9PRkZMSU5F
ID0JMSA8PCAzLAorCU5WTV9DSEtfU1RfSE9TVF9VU0UgPQkxIDw8IDcsCisKKwkvKiBDaHVuayB0
eXBlcyAqLworCU5WTV9DSEtfVFBfV19TRVEgPQkxIDw8IDAsCisJTlZNX0NIS19UUF9XX1JBTiA9
CTEgPDwgMSwKKwlOVk1fQ0hLX1RQX1NaX1NQRUMgPQkxIDw8IDQsCit9OworCiAvKgogICogTm90
ZTogVGhlIHN0cnVjdHVyZSBzaXplIGlzIGxpbmtlZCB0byBudm1lX252bV9jaGtfbWV0YSBzdWNo
IHRoYXQgdGhlIHNhbWUKICAqIGJ1ZmZlciBjYW4gYmUgdXNlZCB3aGVuIGNvbnZlcnRpbmcgZnJv
bSBsaXR0bGUgZW5kaWFuIHRvIGNwdSBhZGRyZXNzaW5nLgotLSAKMi43LjQKCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcg
bGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
