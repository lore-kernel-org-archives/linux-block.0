Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_BASE64_TEXT,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9ECC433B4
	for <linux-block@archiver.kernel.org>; Tue, 18 May 2021 15:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E4516108B
	for <linux-block@archiver.kernel.org>; Tue, 18 May 2021 15:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344081AbhERPFj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 May 2021 11:05:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33415 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343903AbhERPFj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 May 2021 11:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621350260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+bQ9SJNaGOJTT/Ip80Zm/iZNd8qbzj+zVIqxvcFO7kk=;
        b=ILlMI3q4qZlrnSHC34onWRzM8pMVORuGF9Z2Y0ICE0UwlWDiqOl8YvWELRQwitN563UoK1
        YMvHXtEdGsvqNY9OBjDGnHV59C1Q4WXgeBsojlFjUUZXWMLHYphg/vQHrp0fQNgJkNK6bU
        p0QzRp/+R3JNi2qd2pa0j6FRHS0Pr6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-1QKLHYpSO2i-ljSdkmC-mw-1; Tue, 18 May 2021 11:04:19 -0400
X-MC-Unique: 1QKLHYpSO2i-ljSdkmC-mw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D21048049CD;
        Tue, 18 May 2021 15:04:17 +0000 (UTC)
Received: from localhost (ovpn-115-196.ams2.redhat.com [10.36.115.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 369EA5D9C0;
        Tue, 18 May 2021 15:04:17 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     jasowang@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Xie Yongji <xieyongji@bytedance.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] virtio-blk: limit seg_max to a safe value
Date:   Tue, 18 May 2021 16:04:15 +0100
Message-Id: <20210518150415.152730-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

VGhlIHN0cnVjdCB2aXJ0aW9fYmxrX2NvbmZpZyBzZWdfbWF4IHZhbHVlIGlzIHJlYWQgZnJvbSB0
aGUgZGV2aWNlIGFuZAppbmNyZW1lbnRlZCBieSAyIHRvIGFjY291bnQgZm9yIHRoZSByZXF1ZXN0
IGhlYWRlciBhbmQgc3RhdHVzIGJ5dGUKZGVzY3JpcHRvcnMgYWRkZWQgYnkgdGhlIGRyaXZlci4K
CkluIHByZXBhcmF0aW9uIGZvciBzdXBwb3J0aW5nIHVudHJ1c3RlZCB2aXJ0aW8tYmxrIGRldmlj
ZXMsIHByb3RlY3QKYWdhaW5zdCBpbnRlZ2VyIG92ZXJmbG93IGFuZCBsaW1pdCB0aGUgdmFsdWUg
dG8gYSBzYWZlIG1heGltdW0KKFNHX01BWF9TRUdNRU5UUykuCgpTaWduZWQtb2ZmLWJ5OiBTdGVm
YW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogZHJpdmVycy9ibG9jay92aXJ0
aW9fYmxrLmMgfCA1ICsrKystCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMgYi9kcml2
ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYwppbmRleCBiOWZhM2VmNWI1N2MuLjRkZmQ1ZmM3YWVlYSAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMKKysrIGIvZHJpdmVycy9ibG9j
ay92aXJ0aW9fYmxrLmMKQEAgLTcyOCw3ICs3MjgsMTAgQEAgc3RhdGljIGludCB2aXJ0YmxrX3By
b2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQogCWlmIChlcnIgfHwgIXNnX2VsZW1zKQog
CQlzZ19lbGVtcyA9IDE7CiAKLQkvKiBXZSBuZWVkIGFuIGV4dHJhIHNnIGVsZW1lbnRzIGF0IGhl
YWQgYW5kIHRhaWwuICovCisJLyogUHJldmVudCBpbnRlZ2VyIG92ZXJmbG93cyBhbmQgZXhjZXNz
aXZlIGJsay1tcSByZXEgY21kX3NpemUgKi8KKwlzZ19lbGVtcyA9IG1pbl90KHUzMiwgc2dfZWxl
bXMsIFNHX01BWF9TRUdNRU5UUyk7CisKKwkvKiBXZSBuZWVkIGV4dHJhIHNnIGVsZW1lbnRzIGF0
IGhlYWQgYW5kIHRhaWwuICovCiAJc2dfZWxlbXMgKz0gMjsKIAl2ZGV2LT5wcml2ID0gdmJsayA9
IGttYWxsb2Moc2l6ZW9mKCp2YmxrKSwgR0ZQX0tFUk5FTCk7CiAJaWYgKCF2YmxrKSB7Ci0tIAoy
LjMxLjEKCg==

