Return-Path: <SRS0=9GNQ=6H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDD9C54FCB
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 12:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78FE82077D
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 12:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGETPAGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgDWMh3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Apr 2020 08:37:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60628 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726840AbgDWMh3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Apr 2020 08:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587645447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+XlBFNq2TljiIz7UMQVRidAnnXkCvE8Tn9pzuRMdxJE=;
        b=KGETPAGZxzZWjKfc9ds35wzFNfCghTI9gsRYfEmHKVPhA8jEOfZz7uHGjxusjElANNaswf
        3c3QNiFUvHjai6xTFBzDYL1btpbFd5sN+V57r+j+rRo8+udZHW7We48yKnC9xgEWjhnOm4
        QiS0ZzdwwcshliVDScCzf1Er38c56+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-RqunHNMFNlqYJD41EtgEXw-1; Thu, 23 Apr 2020 08:37:26 -0400
X-MC-Unique: RqunHNMFNlqYJD41EtgEXw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F0F61800D51;
        Thu, 23 Apr 2020 12:37:25 +0000 (UTC)
Received: from localhost (ovpn-114-230.ams2.redhat.com [10.36.114.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2FA8B5D70A;
        Thu, 23 Apr 2020 12:37:18 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Lance Digby <ldigby@redhat.com>
Subject: [PATCH] virtio-blk: handle block_device_operations callbacks after hot unplug
Date:   Thu, 23 Apr 2020 13:37:17 +0100
Message-Id: <20200423123717.139141-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

QSB2aXJ0aW9fYmxrIGJsb2NrIGRldmljZSBjYW4gc3RpbGwgYmUgcmVmZXJlbmNlZCBhZnRlciBo
b3QgdW5wbHVnIGJ5CnVzZXJzcGFjZSBwcm9jZXNzZXMgdGhhdCBob2xkIHRoZSBmaWxlIGRlc2Ny
aXB0b3IuICBJbiB0aGlzIGNhc2UKdmlydGJsa19nZXRnZW8oKSBjYW4gYmUgaW52b2tlZCBhZnRl
ciB2aXJ0YmxrX3JlbW92ZSgpIHdhcyBjYWxsZWQuICBGb3IKZXhhbXBsZSwgYSBwcm9ncmFtIHRo
YXQgaGFzIC9kZXYvdmRiIG9wZW4gY2FuIGNhbGwgaW9jdGwoSERJT19HRVRHRU8pCmFmdGVyIGhv
dCB1bnBsdWcuCgpGaXggdGhpcyBieSBjbGVhcmluZyB2YmxrLT5kaXNrLT5wcml2YXRlX2RhdGEg
YW5kIGNoZWNraW5nIHRoYXQgdGhlCnZpcnRpb19ibGsgZHJpdmVyIGluc3RhbmNlIGlzIHN0aWxs
IGFyb3VuZCBpbiB2aXJ0YmxrX2dldGdlbygpLgoKTm90ZSB0aGF0IHRoZSB2aXJ0YmxrX2dldGdl
bygpIGZ1bmN0aW9uIGl0c2VsZiBpcyBndWFyYW50ZWVkIHRvIHJlbWFpbgppbiBtZW1vcnkgYWZ0
ZXIgaG90IHVucGx1ZyBiZWNhdXNlIHRoZSB2aXJ0aW9fYmxrIG1vZHVsZSByZWZjb3VudCBpcwpz
dGlsbCBoZWxkIHdoaWxlIGEgYmxvY2sgZGV2aWNlIHJlZmVyZW5jZSBleGlzdHMuCgpPcmlnaW5h
bGx5LWJ5OiBMYW5jZSBEaWdieSA8bGRpZ2J5QHJlZGhhdC5jb20+ClNpZ25lZC1vZmYtYnk6IFN0
ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiBkcml2ZXJzL2Jsb2NrL3Zp
cnRpb19ibGsuYyB8IDUgKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYyBiL2RyaXZlcnMvYmxvY2svdmly
dGlvX2Jsay5jCmluZGV4IDkzNDY4YjdjNjcwMS4uYjUwY2RmMzdhNmY3IDEwMDY0NAotLS0gYS9k
cml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYworKysgYi9kcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsu
YwpAQCAtMzAwLDYgKzMwMCwxMCBAQCBzdGF0aWMgaW50IHZpcnRibGtfZ2V0Z2VvKHN0cnVjdCBi
bG9ja19kZXZpY2UgKmJkLCBzdHJ1Y3QgaGRfZ2VvbWV0cnkgKmdlbykKIHsKIAlzdHJ1Y3Qgdmly
dGlvX2JsayAqdmJsayA9IGJkLT5iZF9kaXNrLT5wcml2YXRlX2RhdGE7CiAKKwkvKiBEcml2ZXIg
aW5zdGFuY2UgaGFzIGJlZW4gcmVtb3ZlZCAqLworCWlmICghdmJsaykKKwkJcmV0dXJuIC1FTk9U
VFk7CisKIAkvKiBzZWUgaWYgdGhlIGhvc3QgcGFzc2VkIGluIGdlb21ldHJ5IGNvbmZpZyAqLwog
CWlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmJsay0+dmRldiwgVklSVElPX0JMS19GX0dFT01FVFJZ
KSkgewogCQl2aXJ0aW9fY3JlYWQodmJsay0+dmRldiwgc3RydWN0IHZpcnRpb19ibGtfY29uZmln
LApAQCAtODM1LDYgKzgzOSw3IEBAIHN0YXRpYyB2b2lkIHZpcnRibGtfcmVtb3ZlKHN0cnVjdCB2
aXJ0aW9fZGV2aWNlICp2ZGV2KQogCXZkZXYtPmNvbmZpZy0+cmVzZXQodmRldik7CiAKIAlyZWZj
ID0ga3JlZl9yZWFkKCZkaXNrX3RvX2Rldih2YmxrLT5kaXNrKS0+a29iai5rcmVmKTsKKwl2Ymxr
LT5kaXNrLT5wcml2YXRlX2RhdGEgPSBOVUxMOwogCXB1dF9kaXNrKHZibGstPmRpc2spOwogCXZk
ZXYtPmNvbmZpZy0+ZGVsX3Zxcyh2ZGV2KTsKIAlrZnJlZSh2YmxrLT52cXMpOwotLSAKMi4yNS4x
Cgo=

