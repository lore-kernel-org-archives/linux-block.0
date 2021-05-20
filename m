Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_BASE64_TEXT,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E397C433B4
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 14:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17668608FE
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 14:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237492AbhETOP5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 10:15:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32205 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243629AbhETOOz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 10:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621520013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EQLmeFAYlSq9MUn0ggB4grwFyWkzklNm3btxmw1JEAk=;
        b=aYewR6HJe8vzqcwNxcxLIaC1CXppMWd+wz6ErOs4uDpvv3hMvhayT2YR0w4DJwuNZ3k/YG
        ay2foquf2tHgc0zeUYpS+rtAx37CjYQim0UORQrYiuhfobygxoG3ZDD1z9h5Qc2Yad21Zl
        Zi1rXSWXnyNSm6u1Il3inn++HBG7tsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-LqypewjZMVWBZWKdzJlFSw-1; Thu, 20 May 2021 10:13:31 -0400
X-MC-Unique: LqypewjZMVWBZWKdzJlFSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A646872FFE;
        Thu, 20 May 2021 14:13:30 +0000 (UTC)
Received: from localhost (ovpn-115-223.ams2.redhat.com [10.36.115.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71E7719718;
        Thu, 20 May 2021 14:13:19 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, slp@redhat.com,
        sgarzare@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 1/3] virtio: add virtioqueue_more_used()
Date:   Thu, 20 May 2021 15:13:03 +0100
Message-Id: <20210520141305.355961-2-stefanha@redhat.com>
In-Reply-To: <20210520141305.355961-1-stefanha@redhat.com>
References: <20210520141305.355961-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

QWRkIGFuIEFQSSB0byBjaGVjayB3aGV0aGVyIHRoZXJlIGFyZSBwZW5kaW5nIHVzZWQgYnVmZmVy
cy4gVGhlcmUgaXMKYWxyZWFkeSBhIHNpbWlsYXIgQVBJIGNhbGxlZCB2aXJ0cXVldWVfcG9sbCgp
IGJ1dCBpdCBvbmx5IHdvcmtzIHRvZ2V0aGVyCndpdGggdmlydHF1ZXVlX2VuYWJsZV9jYl9wcmVw
YXJlKCkuIFRoZSBwYXRjaGVzIHRoYXQgZm9sbG93IGFkZCBibGstbXEKLT5wb2xsKCkgc3VwcG9y
dCB0byB2aXJ0aW9fYmxrIGFuZCB0aGV5IG5lZWQgdG8gY2hlY2sgZm9yIHVzZWQgYnVmZmVycwp3
aXRob3V0IHJlLWVuYWJsaW5nIHZpcnRxdWV1ZSBjYWxsYmFja3MsIHNvIGludHJvZHVjZSBhbiBB
UEkgZm9yIGl0LgoKU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRo
YXQuY29tPgotLS0KIGluY2x1ZGUvbGludXgvdmlydGlvLmggICAgICAgfCAgMiArKwogZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDE3ICsrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNo
YW5nZWQsIDE5IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZpcnRp
by5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW8uaAppbmRleCBiMTg5NGUwMzIzZmEuLmM2YWQwZjI1
ZjQxMiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC92aXJ0aW8uaAorKysgYi9pbmNsdWRlL2xp
bnV4L3ZpcnRpby5oCkBAIC02Myw2ICs2Myw4IEBAIGJvb2wgdmlydHF1ZXVlX2tpY2tfcHJlcGFy
ZShzdHJ1Y3QgdmlydHF1ZXVlICp2cSk7CiAKIGJvb2wgdmlydHF1ZXVlX25vdGlmeShzdHJ1Y3Qg
dmlydHF1ZXVlICp2cSk7CiAKK2Jvb2wgdmlydHF1ZXVlX21vcmVfdXNlZChjb25zdCBzdHJ1Y3Qg
dmlydHF1ZXVlICp2cSk7CisKIHZvaWQgKnZpcnRxdWV1ZV9nZXRfYnVmKHN0cnVjdCB2aXJ0cXVl
dWUgKnZxLCB1bnNpZ25lZCBpbnQgKmxlbik7CiAKIHZvaWQgKnZpcnRxdWV1ZV9nZXRfYnVmX2N0
eChzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdW5zaWduZWQgaW50ICpsZW4sCmRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
YwppbmRleCA3MWUxNmI1M2U5YzEuLjdjM2RhNzVkYTQ2MiAxMDA2NDQKLS0tIGEvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYworKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCkBA
IC0yMDMyLDYgKzIwMzIsMjMgQEAgc3RhdGljIGlubGluZSBib29sIG1vcmVfdXNlZChjb25zdCBz
dHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSkKIAlyZXR1cm4gdnEtPnBhY2tlZF9yaW5nID8gbW9y
ZV91c2VkX3BhY2tlZCh2cSkgOiBtb3JlX3VzZWRfc3BsaXQodnEpOwogfQogCisvKioKKyAqIHZp
cnRxdWV1ZV9tb3JlX3VzZWQgLSBjaGVjayBpZiB0aGVyZSBhcmUgdXNlZCBidWZmZXJzIHBlbmRp
bmcKKyAqIEBfdnE6IHRoZSBzdHJ1Y3QgdmlydHF1ZXVlIHdlJ3JlIHRhbGtpbmcgYWJvdXQuCisg
KgorICogUmV0dXJucyB0cnVlIGlmIHRoZXJlIGFyZSB1c2VkIGJ1ZmZlcnMsIGZhbHNlIG90aGVy
d2lzZS4gTWF5IGJlIGNhbGxlZCBhdAorICogdGhlIHNhbWUgdGltZSBhcyBvdGhlciB2aXJ0cXVl
dWUgb3BlcmF0aW9ucywgYnV0IGFjdHVhbGx5IGNhbGxpbmcKKyAqIHZpcnRxdWV1ZV9nZXRfYnVm
KCkgcmVxdWlyZXMgc2VyaWFsaXphdGlvbiBzbyBiZSBtaW5kZnVsIG9mIHRoZSByYWNlIGJldHdl
ZW4KKyAqIGNhbGxpbmcgdmlydHF1ZXVlX21vcmVfdXNlZCgpIGFuZCB2aXJ0cXVldWVfZ2V0X2J1
ZigpLgorICovCitib29sIHZpcnRxdWV1ZV9tb3JlX3VzZWQoY29uc3Qgc3RydWN0IHZpcnRxdWV1
ZSAqX3ZxKQoreworCXN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7CisK
KwlyZXR1cm4gbW9yZV91c2VkKHZxKTsKK30KK0VYUE9SVF9TWU1CT0xfR1BMKHZpcnRxdWV1ZV9t
b3JlX3VzZWQpOworCiBpcnFyZXR1cm5fdCB2cmluZ19pbnRlcnJ1cHQoaW50IGlycSwgdm9pZCAq
X3ZxKQogewogCXN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7Ci0tIAoy
LjMxLjEKCg==

