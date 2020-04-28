Return-Path: <SRS0=S1TO=6M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51013C83001
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 14:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BAAF206D8
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 14:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkwpHfOU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgD1Oa0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:30:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50840 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727124AbgD1OaY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 10:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588084222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LJYJOxQhIE1fE/bXXB2iJgsNhh+MEvSLEyy2mGQqHm4=;
        b=dkwpHfOUNAc/9/+/P5faIOfR6MPB0eB5SKoc52W8F9J0tm5UkjNsMYKSaFtIhJssv9+Y6k
        Rqg/sd/YkM5jXkteMzct/FeC3Jw/WD4C9o1TMbs0SRuSTDJPcnOnTvb+/q9rVvIJSIbncQ
        dLFdxFZjaVXdeRZA5Vz1EYN0AnNmIWE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-YWug8AwhN2qI8cWogNqfqg-1; Tue, 28 Apr 2020 10:30:17 -0400
X-MC-Unique: YWug8AwhN2qI8cWogNqfqg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 277D81005510;
        Tue, 28 Apr 2020 14:30:16 +0000 (UTC)
Received: from localhost (ovpn-115-22.ams2.redhat.com [10.36.115.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 319AB60CD3;
        Tue, 28 Apr 2020 14:30:09 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Lance Digby <ldigby@redhat.com>
Subject: [PATCH v2] virtio-blk: handle block_device_operations callbacks after hot unplug
Date:   Tue, 28 Apr 2020 15:30:09 +0100
Message-Id: <20200428143009.107645-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

QSB1c2Vyc3BhY2UgcHJvY2VzcyBob2xkaW5nIGEgZmlsZSBkZXNjcmlwdG9yIHRvIGEgdmlydGlv
X2JsayBkZXZpY2UgY2FuCnN0aWxsIGludm9rZSBibG9ja19kZXZpY2Vfb3BlcmF0aW9ucyBhZnRl
ciBob3QgdW5wbHVnLiAgRm9yIGV4YW1wbGUsIGEKcHJvZ3JhbSB0aGF0IGhhcyAvZGV2L3ZkYiBv
cGVuIGNhbiBjYWxsIGlvY3RsKEhESU9fR0VUR0VPKSBhZnRlciBob3QKdW5wbHVnIHRvIGludm9r
ZSB2aXJ0YmxrX2dldGdlbygpLgoKSW50cm9kdWNlIGEgcmVmZXJlbmNlIGNvdW50IGluIHN0cnVj
dCB2aXJ0aW9fYmxrIHNvIHRoYXQgaXRzIGxpZmV0aW1lCmNvdmVycyBib3RoIHZpcnRpb19kcml2
ZXIgcHJvYmUvcmVtb3ZlIGFuZCBibG9ja19kZXZpY2Vfb3BlcmF0aW9ucwpvcGVuL3JlbGVhc2Ug
dXNlcnMuICBUaGlzIGVuc3VyZXMgdGhhdCBibG9ja19kZXZpY2Vfb3BlcmF0aW9ucyBmdW5jdGlv
bnMKbGlrZSB2aXJ0YmxrX2dldGdlbygpIGNhbiBzYWZlbHkgYWNjZXNzIHN0cnVjdCB2aXJ0aW9f
YmxrLgoKQWRkIHJlbW92ZV9tdXRleCB0byBwcmV2ZW50IGJsb2NrX2RldmljZV9vcGVyYXRpb25z
IGZ1bmN0aW9ucyBmcm9tCmFjY2Vzc2luZyB2YmxrLT52ZGV2IGR1cmluZyB2aXJ0YmxrX3JlbW92
ZSgpIGFuZCBsZXQgdGhlIHNhZmVseSBjaGVjawpmb3IgIXZibGstPnZkZXYgYWZ0ZXIgdmlydGJs
a19yZW1vdmUoKSByZXR1cm5zLgoKU3dpdGNoaW5nIHRvIGEgcmVmZXJlbmNlIGNvdW50IGFsc28g
c29sdmVzIHRoZSB2ZF9pbmRleF9pZGEgbGVhayB3aGVyZQp2ZGEsIHZkYiwgdmRjLCBldGMgaW5k
aWNlcyB3ZXJlIGxvc3Qgd2hlbiB0aGUgZGV2aWNlIHdhcyBob3QgdW5wbHVnZ2VkCndoaWxlIHRo
ZSBibG9jayBkZXZpY2Ugd2FzIHN0aWxsIG9wZW4uCgpSZXBvcnRlZC1ieTogTGFuY2UgRGlnYnkg
PGxkaWdieUByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZh
bmhhQHJlZGhhdC5jb20+Ci0tLQpJZiBzb21lb25lIGhhcyBhIHNpbXBsZXIgc29sdXRpb24gcGxl
YXNlIGxldCBtZSBrbm93LiAgSSBsb29rZWQgYXQKdmFyaW91cyBhcHByb2FjaGVzIGluY2x1ZGlu
ZyByZXVzaW5nIGRldmljZV9sb2NrKCZ2YmxrLT52ZGV2LmRldikgYnV0CnRoZXkgd2VyZSBtb3Jl
IGNvbXBsZXggYW5kIGV4dGVuZGluZyB0aGUgbGlmZXRpbWUgb2YgdmlydGlvX2RldmljZSBhZnRl
cgpyZW1vdmUoKSBoYXMgYmVlbiBjYWxsZWQgc2VlbXMgcXVlc3Rpb25hYmxlLgotLS0KIGRyaXZl
cnMvYmxvY2svdmlydGlvX2Jsay5jIHwgODUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA3NyBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svdmlydGlvX2Jsay5jIGIvZHJpdmVycy9ibG9j
ay92aXJ0aW9fYmxrLmMKaW5kZXggOTM0NjhiN2M2NzAxLi4zZGQ1M2I0NDVjYzEgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvYmxvY2svdmlydGlvX2Jsay5jCisrKyBiL2RyaXZlcnMvYmxvY2svdmlydGlv
X2Jsay5jCkBAIC00NCw2ICs0NCwxMyBAQCBzdHJ1Y3QgdmlydGlvX2JsayB7CiAJLyogUHJvY2Vz
cyBjb250ZXh0IGZvciBjb25maWcgc3BhY2UgdXBkYXRlcyAqLwogCXN0cnVjdCB3b3JrX3N0cnVj
dCBjb25maWdfd29yazsKIAorCS8qCisJICogVHJhY2tzIHJlZmVyZW5jZXMgZnJvbSBibG9ja19k
ZXZpY2Vfb3BlcmF0aW9ucyBvcGVuL3JlbGVhc2UgYW5kCisJICogdmlydGlvX2RyaXZlciBwcm9i
ZS9yZW1vdmUgc28gdGhpcyBvYmplY3QgY2FuIGJlIGZyZWVkIG9uY2Ugbm8KKwkgKiBsb25nZXIg
aW4gdXNlLgorCSAqLworCXJlZmNvdW50X3QgcmVmczsKKwogCS8qIFdoYXQgaG9zdCB0ZWxscyB1
cywgcGx1cyAyIGZvciBoZWFkZXIgJiB0YWlsZXIuICovCiAJdW5zaWduZWQgaW50IHNnX2VsZW1z
OwogCkBAIC01Myw2ICs2MCw5IEBAIHN0cnVjdCB2aXJ0aW9fYmxrIHsKIAkvKiBudW0gb2YgdnFz
ICovCiAJaW50IG51bV92cXM7CiAJc3RydWN0IHZpcnRpb19ibGtfdnEgKnZxczsKKworCS8qIFBy
b3ZpZGVzIG11dHVhbCBleGNsdXNpb24gd2l0aCB2aXJ0YmxrX3JlbW92ZSgpLiAqLworCXN0cnVj
dCBtdXRleCByZW1vdmVfbXV0ZXg7CiB9OwogCiBzdHJ1Y3QgdmlydGJsa19yZXEgewpAQCAtMjk1
LDEwICszMDUsNTQgQEAgc3RhdGljIGludCB2aXJ0YmxrX2dldF9pZChzdHJ1Y3QgZ2VuZGlzayAq
ZGlzaywgY2hhciAqaWRfc3RyKQogCXJldHVybiBlcnI7CiB9CiAKK3N0YXRpYyB2b2lkIHZpcnRi
bGtfZ2V0KHN0cnVjdCB2aXJ0aW9fYmxrICp2YmxrKQoreworCXJlZmNvdW50X2luYygmdmJsay0+
cmVmcyk7Cit9CisKK3N0YXRpYyB2b2lkIHZpcnRibGtfcHV0KHN0cnVjdCB2aXJ0aW9fYmxrICp2
YmxrKQoreworCWlmIChyZWZjb3VudF9kZWNfYW5kX3Rlc3QoJnZibGstPnJlZnMpKSB7CisJCWlk
YV9zaW1wbGVfcmVtb3ZlKCZ2ZF9pbmRleF9pZGEsIHZibGstPmluZGV4KTsKKwkJbXV0ZXhfZGVz
dHJveSgmdmJsay0+cmVtb3ZlX211dGV4KTsKKwkJa2ZyZWUodmJsayk7CisJfQorfQorCitzdGF0
aWMgaW50IHZpcnRibGtfb3BlbihzdHJ1Y3QgYmxvY2tfZGV2aWNlICpiZCwgZm1vZGVfdCBtb2Rl
KQoreworCXN0cnVjdCB2aXJ0aW9fYmxrICp2YmxrID0gYmQtPmJkX2Rpc2stPnByaXZhdGVfZGF0
YTsKKwlpbnQgcmV0ID0gLUVOWElPOworCisJbXV0ZXhfbG9jaygmdmJsay0+cmVtb3ZlX211dGV4
KTsKKworCWlmICh2YmxrLT52ZGV2KSB7CisJCXZpcnRibGtfZ2V0KHZibGspOworCQlyZXQgPSAw
OworCX0KKworCW11dGV4X3VubG9jaygmdmJsay0+cmVtb3ZlX211dGV4KTsKKwlyZXR1cm4gcmV0
OworfQorCitzdGF0aWMgdm9pZCB2aXJ0YmxrX3JlbGVhc2Uoc3RydWN0IGdlbmRpc2sgKmRpc2ss
IGZtb2RlX3QgbW9kZSkKK3sKKwlzdHJ1Y3QgdmlydGlvX2JsayAqdmJsayA9IGRpc2stPnByaXZh
dGVfZGF0YTsKKworCXZpcnRibGtfcHV0KHZibGspOworfQorCiAvKiBXZSBwcm92aWRlIGdldGdl
byBvbmx5IHRvIHBsZWFzZSBzb21lIG9sZCBib290bG9hZGVyL3BhcnRpdGlvbmluZyB0b29scyAq
Lwogc3RhdGljIGludCB2aXJ0YmxrX2dldGdlbyhzdHJ1Y3QgYmxvY2tfZGV2aWNlICpiZCwgc3Ry
dWN0IGhkX2dlb21ldHJ5ICpnZW8pCiB7CiAJc3RydWN0IHZpcnRpb19ibGsgKnZibGsgPSBiZC0+
YmRfZGlzay0+cHJpdmF0ZV9kYXRhOworCWludCByZXQgPSAtRU5YSU87CisKKwltdXRleF9sb2Nr
KCZ2YmxrLT5yZW1vdmVfbXV0ZXgpOworCisJaWYgKCF2YmxrLT52ZGV2KSB7CisJCWdvdG8gb3V0
OworCX0KIAogCS8qIHNlZSBpZiB0aGUgaG9zdCBwYXNzZWQgaW4gZ2VvbWV0cnkgY29uZmlnICov
CiAJaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2YmxrLT52ZGV2LCBWSVJUSU9fQkxLX0ZfR0VPTUVU
UlkpKSB7CkBAIC0zMTQsMTEgKzM2OCwxNyBAQCBzdGF0aWMgaW50IHZpcnRibGtfZ2V0Z2VvKHN0
cnVjdCBibG9ja19kZXZpY2UgKmJkLCBzdHJ1Y3QgaGRfZ2VvbWV0cnkgKmdlbykKIAkJZ2VvLT5z
ZWN0b3JzID0gMSA8PCA1OwogCQlnZW8tPmN5bGluZGVycyA9IGdldF9jYXBhY2l0eShiZC0+YmRf
ZGlzaykgPj4gMTE7CiAJfQotCXJldHVybiAwOworCisJcmV0ID0gMDsKK291dDoKKwltdXRleF91
bmxvY2soJnZibGstPnJlbW92ZV9tdXRleCk7CisJcmV0dXJuIHJldDsKIH0KIAogc3RhdGljIGNv
bnN0IHN0cnVjdCBibG9ja19kZXZpY2Vfb3BlcmF0aW9ucyB2aXJ0YmxrX2ZvcHMgPSB7CiAJLm93
bmVyICA9IFRISVNfTU9EVUxFLAorCS5vcGVuID0gdmlydGJsa19vcGVuLAorCS5yZWxlYXNlID0g
dmlydGJsa19yZWxlYXNlLAogCS5nZXRnZW8gPSB2aXJ0YmxrX2dldGdlbywKIH07CiAKQEAgLTY1
NSw2ICs3MTUsMTAgQEAgc3RhdGljIGludCB2aXJ0YmxrX3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2
aWNlICp2ZGV2KQogCQlnb3RvIG91dF9mcmVlX2luZGV4OwogCX0KIAorCS8qIFRoaXMgcmVmZXJl
bmNlIGlzIGRyb3BwZWQgaW4gdmlydGJsa19yZW1vdmUoKS4gKi8KKwlyZWZjb3VudF9zZXQoJnZi
bGstPnJlZnMsIDEpOworCW11dGV4X2luaXQoJnZibGstPnJlbW92ZV9tdXRleCk7CisKIAl2Ymxr
LT52ZGV2ID0gdmRldjsKIAl2YmxrLT5zZ19lbGVtcyA9IHNnX2VsZW1zOwogCkBAIC04MjAsOCAr
ODg0LDEyIEBAIHN0YXRpYyBpbnQgdmlydGJsa19wcm9iZShzdHJ1Y3QgdmlydGlvX2RldmljZSAq
dmRldikKIHN0YXRpYyB2b2lkIHZpcnRibGtfcmVtb3ZlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2
ZGV2KQogewogCXN0cnVjdCB2aXJ0aW9fYmxrICp2YmxrID0gdmRldi0+cHJpdjsKLQlpbnQgaW5k
ZXggPSB2YmxrLT5pbmRleDsKLQlpbnQgcmVmYzsKKworCS8qCisJICogVmlydHF1ZXVlIHByb2Nl
c3NpbmcgaXMgc3RvcHBlZCBzYWZlbHkgaGVyZSBidXQgbXV0dWFsIGV4Y2x1c2lvbiBpcworCSAq
IG5lZWRlZCBmb3IgYmxvY2tfZGV2aWNlX29wZXJhdGlvbnMuCisJICovCisJbXV0ZXhfbG9jaygm
dmJsay0+cmVtb3ZlX211dGV4KTsKIAogCS8qIE1ha2Ugc3VyZSBubyB3b3JrIGhhbmRsZXIgaXMg
YWNjZXNzaW5nIHRoZSBkZXZpY2UuICovCiAJZmx1c2hfd29yaygmdmJsay0+Y29uZmlnX3dvcmsp
OwpAQCAtODM0LDE1ICs5MDIsMTYgQEAgc3RhdGljIHZvaWQgdmlydGJsa19yZW1vdmUoc3RydWN0
IHZpcnRpb19kZXZpY2UgKnZkZXYpCiAJLyogU3RvcCBhbGwgdGhlIHZpcnRxdWV1ZXMuICovCiAJ
dmRldi0+Y29uZmlnLT5yZXNldCh2ZGV2KTsKIAotCXJlZmMgPSBrcmVmX3JlYWQoJmRpc2tfdG9f
ZGV2KHZibGstPmRpc2spLT5rb2JqLmtyZWYpOworCS8qIFZpcnRxdWV1ZSBhcmUgc3RvcHBlZCwg
bm90aGluZyBjYW4gdXNlIHZibGstPnZkZXYgYW55bW9yZS4gKi8KKwl2YmxrLT52ZGV2ID0gTlVM
TDsKKwogCXB1dF9kaXNrKHZibGstPmRpc2spOwogCXZkZXYtPmNvbmZpZy0+ZGVsX3Zxcyh2ZGV2
KTsKIAlrZnJlZSh2YmxrLT52cXMpOwotCWtmcmVlKHZibGspOwogCi0JLyogT25seSBmcmVlIGRl
dmljZSBpZCBpZiB3ZSBkb24ndCBoYXZlIGFueSB1c2VycyAqLwotCWlmIChyZWZjID09IDEpCi0J
CWlkYV9zaW1wbGVfcmVtb3ZlKCZ2ZF9pbmRleF9pZGEsIGluZGV4KTsKKwltdXRleF91bmxvY2so
JnZibGstPnJlbW92ZV9tdXRleCk7CisKKwl2aXJ0YmxrX3B1dCh2YmxrKTsKIH0KIAogI2lmZGVm
IENPTkZJR19QTV9TTEVFUAotLSAKMi4yNS4zCgo=

