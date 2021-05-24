Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_BASE64_TEXT,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DAFC04FF3
	for <linux-block@archiver.kernel.org>; Mon, 24 May 2021 15:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DC1561940
	for <linux-block@archiver.kernel.org>; Mon, 24 May 2021 15:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbhEXPnu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 May 2021 11:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20081 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234245AbhEXPl6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 May 2021 11:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621870830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cHrEWrzKvp8OeehV8eIQU5KqWgRThf3d5ftzEVleMDU=;
        b=AM+Dc2/higWOQJuSLZH5x/BBIyoWIhoYGtFz7eDyv7+IRkWgNAg9baDgeGPmXRuL8mJkcw
        jBbdhu+jtz1wZD/u5e7TkbGSizav4L1jngw8vXi967jfWMr/GTk9i4ErqfJKHiCC3A88Sc
        mNQ3f7g3lrmW0AdeFvD+513zXF6YOhQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-DfRJUhi3MwuAanAh8ymHoQ-1; Mon, 24 May 2021 11:40:28 -0400
X-MC-Unique: DfRJUhi3MwuAanAh8ymHoQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 487621927800;
        Mon, 24 May 2021 15:40:27 +0000 (UTC)
Received: from localhost (ovpn-113-244.ams2.redhat.com [10.36.113.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F1295C257;
        Mon, 24 May 2021 15:40:21 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     Xie Yongji <xieyongji@bytedance.com>,
        Christoph Hellwig <hch@lst.de>,
        "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2] virtio-blk: limit seg_max to a safe value
Date:   Mon, 24 May 2021 16:40:20 +0100
Message-Id: <20210524154020.98195-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

VGhlIHN0cnVjdCB2aXJ0aW9fYmxrX2NvbmZpZyBzZWdfbWF4IHZhbHVlIGlzIHJlYWQgZnJvbSB0
aGUgZGV2aWNlIGFuZAppbmNyZW1lbnRlZCBieSAyIHRvIGFjY291bnQgZm9yIHRoZSByZXF1ZXN0
IGhlYWRlciBhbmQgc3RhdHVzIGJ5dGUKZGVzY3JpcHRvcnMgYWRkZWQgYnkgdGhlIGRyaXZlci4K
CkluIHByZXBhcmF0aW9uIGZvciBzdXBwb3J0aW5nIHVudHJ1c3RlZCB2aXJ0aW8tYmxrIGRldmlj
ZXMsIHByb3RlY3QKYWdhaW5zdCBpbnRlZ2VyIG92ZXJmbG93IGFuZCBsaW1pdCB0aGUgdmFsdWUg
dG8gYSBzYWZlIG1heGltdW0uCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZh
bmhhQHJlZGhhdC5jb20+Ci0tLQp2MjoKICogTGltaXQgdG8gYSB2aXJ0aW8tc3BlY2lmaWMgdmFs
dWUgaW5zdGVhZCBvZiB1c2luZyBTR19NQVhfU0VHTUVOVFMKICAgW0NocmlzdG9waF0KLS0tCiBk
cml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYyB8IDggKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA3
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Jsb2Nr
L3ZpcnRpb19ibGsuYyBiL2RyaXZlcnMvYmxvY2svdmlydGlvX2Jsay5jCmluZGV4IGI5ZmEzZWY1
YjU3Yy4uMTYzNWQ0Mjg5MjAyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsu
YworKysgYi9kcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYwpAQCAtMjEsNiArMjEsOSBAQAogI2Rl
ZmluZSBWUV9OQU1FX0xFTiAxNgogI2RlZmluZSBNQVhfRElTQ0FSRF9TRUdNRU5UUyAyNTZ1CiAK
Ky8qIFRoZSBtYXhpbXVtIG51bWJlciBvZiBzZyBlbGVtZW50cyB0aGF0IGZpdCBpbnRvIGEgdmly
dHF1ZXVlICovCisjZGVmaW5lIFZJUlRJT19CTEtfTUFYX1NHX0VMRU1TIDMyNzY4CisKIHN0YXRp
YyBpbnQgbWFqb3I7CiBzdGF0aWMgREVGSU5FX0lEQSh2ZF9pbmRleF9pZGEpOwogCkBAIC03Mjgs
NyArNzMxLDEwIEBAIHN0YXRpYyBpbnQgdmlydGJsa19wcm9iZShzdHJ1Y3QgdmlydGlvX2Rldmlj
ZSAqdmRldikKIAlpZiAoZXJyIHx8ICFzZ19lbGVtcykKIAkJc2dfZWxlbXMgPSAxOwogCi0JLyog
V2UgbmVlZCBhbiBleHRyYSBzZyBlbGVtZW50cyBhdCBoZWFkIGFuZCB0YWlsLiAqLworCS8qIFBy
ZXZlbnQgaW50ZWdlciBvdmVyZmxvd3MgYW5kIGhvbm9yIG1heCB2cSBzaXplICovCisJc2dfZWxl
bXMgPSBtaW5fdCh1MzIsIHNnX2VsZW1zLCBWSVJUSU9fQkxLX01BWF9TR19FTEVNUyAtIDIpOwor
CisJLyogV2UgbmVlZCBleHRyYSBzZyBlbGVtZW50cyBhdCBoZWFkIGFuZCB0YWlsLiAqLwogCXNn
X2VsZW1zICs9IDI7CiAJdmRldi0+cHJpdiA9IHZibGsgPSBrbWFsbG9jKHNpemVvZigqdmJsayks
IEdGUF9LRVJORUwpOwogCWlmICghdmJsaykgewotLSAKMi4zMS4xCgo=

