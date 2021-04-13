Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2850DC433ED
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 15:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB3E6613B8
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 15:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345601AbhDMPDz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Apr 2021 11:03:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54846 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345591AbhDMPDv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Apr 2021 11:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618326211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Bt8EIkbFjk1rFc17+/fNBv57ahjZWmhXLRdzCsXZB1c=;
        b=cmGYTRRUbkxd/NgZNksM3Y/9iwbKGe8WQX/oTdkpukvAVYTvlCqBQ+TfwoTQZMe6OYQg7x
        DPd6UVHthvZGz/Hgs2oCU6Ho2mOQC6u+pm19NiRTYXE8+t2a/D94N1dzgI0UkAN4Gv1yrB
        WHzjrfSyREouN7/UYThaeTsgpVSymGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-9p7Ue2JWNDe_RjaGIagM_w-1; Tue, 13 Apr 2021 11:03:28 -0400
X-MC-Unique: 9p7Ue2JWNDe_RjaGIagM_w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E5D41B2C984;
        Tue, 13 Apr 2021 15:03:27 +0000 (UTC)
Received: from localhost (ovpn-115-75.ams2.redhat.com [10.36.115.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E02335D9DE;
        Tue, 13 Apr 2021 15:03:20 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     libc-alpha@sourceware.org, Jens Axboe <axboe@kernel.dk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>
Subject: [PATCH liburing] examples/ucontext-cp.c: cope with variable SIGSTKSZ
Date:   Tue, 13 Apr 2021 16:03:19 +0100
Message-Id: <20210413150319.764600-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

VGhlIHNpemUgb2YgQyBhcnJheXMgYXQgZmlsZSBzY29wZSBtdXN0IGJlIGNvbnN0YW50LiBUaGUg
Zm9sbG93aW5nCmNvbXBpbGVyIGVycm9yIG9jY3VycyB3aXRoIHJlY2VudCB1cHN0cmVhbSBnbGli
YyAoMi4zMy45MDAwKToKCiAgQ0MgdWNvbnRleHQtY3AKICB1Y29udGV4dC1jcC5jOjMxOjIzOiBl
cnJvcjogdmFyaWFibHkgbW9kaWZpZWQg4oCYc3RhY2tfYnVm4oCZIGF0IGZpbGUgc2NvcGUKICAz
MSB8ICAgICAgICAgdW5zaWduZWQgY2hhciBzdGFja19idWZbU0lHU1RLU1pdOwogICAgIHwgICAg
ICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fgogIG1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MjY6
IHVjb250ZXh0LWNwXSBFcnJvciAxCgpUaGUgZm9sbG93aW5nIGdsaWJjIGNvbW1pdCBjaGFuZ2Vk
IFNJR1NUS1NaIGZyb20gYSBjb25zdGFudCB2YWx1ZSB0byBhCnZhcmlhYmxlOgoKICBjb21taXQg
NmM1N2QzMjA0ODQ5ODhlODdlNDQ2ZTJlNjBjZTQyODE2YmY1MWQ1MwogIEF1dGhvcjogSC5KLiBM
dSA8aGpsLnRvb2xzQGdtYWlsLmNvbT4KICBEYXRlOiAgIE1vbiBGZWIgMSAxMTowMDozOCAyMDIx
IC0wODAwCgogICAgc3lzY29uZjogQWRkIF9TQ19NSU5TSUdTVEtTWi9fU0NfU0lHU1RLU1ogW0Ja
ICMyMDMwNV0KICAuLi4KICArIyBkZWZpbmUgU0lHU1RLU1ogc3lzY29uZiAoX1NDX1NJR1NUS1Na
KQoKQWxsb2NhdGUgdGhlIHN0YWNrIGJ1ZmZlciBleHBsaWNpdGx5IHRvIGF2b2lkIGRlY2xhcmlu
ZyBhbiBhcnJheSBhdCBmaWxlCnNjb3BlLgoKQ2M6IEguSi4gTHUgPGhqbC50b29sc0BnbWFpbC5j
b20+ClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4K
LS0tClBlcmhhcHMgdGhlIGdsaWJjIGNoYW5nZSBuZWVkcyB0byBiZSByZXZpc2VkIGJlZm9yZSBy
ZWxlYXNpbmcgZ2xpYmMgMi4zNApzaW5jZSBpdCBtaWdodCBicmVhayBhcHBsaWNhdGlvbnMuIFRo
YXQncyB1cCB0byB0aGUgZ2xpYmMgZm9sa3MuIEl0CmRvZXNuJ3QgaHVydCBmb3IgbGlidXJpbmcg
dG8gdGFrZSBhIHNhZmVyIGFwcHJvYWNoIHRoYXQgY29wZXMgd2l0aCB0aGUKU0lHU1RLU1ogY2hh
bmdlIGluIGFueSBjYXNlLgotLS0KIGV4YW1wbGVzL3Vjb250ZXh0LWNwLmMgfCAxMiArKysrKysr
KystLS0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZXhhbXBsZXMvdWNvbnRleHQtY3AuYyBiL2V4YW1wbGVzL3Vjb250ZXh0LWNw
LmMKaW5kZXggMGIyYTZiNS4uZWEwYzkzNCAxMDA2NDQKLS0tIGEvZXhhbXBsZXMvdWNvbnRleHQt
Y3AuYworKysgYi9leGFtcGxlcy91Y29udGV4dC1jcC5jCkBAIC0yOCw3ICsyOCw3IEBACiAKIHR5
cGVkZWYgc3RydWN0IHsKIAlzdHJ1Y3QgaW9fdXJpbmcgKnJpbmc7Ci0JdW5zaWduZWQgY2hhciBz
dGFja19idWZbU0lHU1RLU1pdOworCXVuc2lnbmVkIGNoYXIgKnN0YWNrX2J1ZjsKIAl1Y29udGV4
dF90IGN0eF9tYWluLCBjdHhfZm5ldzsKIH0gYXN5bmNfY29udGV4dDsKIApAQCAtMTE1LDggKzEx
NSwxMyBAQCBzdGF0aWMgaW50IHNldHVwX2NvbnRleHQoYXN5bmNfY29udGV4dCAqcGN0eCwgc3Ry
dWN0IGlvX3VyaW5nICpyaW5nKQogCQlwZXJyb3IoImdldGNvbnRleHQiKTsKIAkJcmV0dXJuIC0x
OwogCX0KLQlwY3R4LT5jdHhfZm5ldy51Y19zdGFjay5zc19zcCA9ICZwY3R4LT5zdGFja19idWY7
Ci0JcGN0eC0+Y3R4X2ZuZXcudWNfc3RhY2suc3Nfc2l6ZSA9IHNpemVvZihwY3R4LT5zdGFja19i
dWYpOworCXBjdHgtPnN0YWNrX2J1ZiA9IG1hbGxvYyhTSUdTVEtTWik7CisJaWYgKCFwY3R4LT5z
dGFja19idWYpIHsKKwkJcGVycm9yKCJtYWxsb2MiKTsKKwkJcmV0dXJuIC0xOworCX0KKwlwY3R4
LT5jdHhfZm5ldy51Y19zdGFjay5zc19zcCA9IHBjdHgtPnN0YWNrX2J1ZjsKKwlwY3R4LT5jdHhf
Zm5ldy51Y19zdGFjay5zc19zaXplID0gU0lHU1RLU1o7CiAJcGN0eC0+Y3R4X2ZuZXcudWNfbGlu
ayA9ICZwY3R4LT5jdHhfbWFpbjsKIAogCXJldHVybiAwOwpAQCAtMTc0LDYgKzE3OSw3IEBAIHN0
YXRpYyB2b2lkIGNvcHlfZmlsZV93cmFwcGVyKGFyZ3VtZW50c19idW5kbGUgKnBidW5kbGUpCiAJ
ZnJlZShpb3YuaW92X2Jhc2UpOwogCWNsb3NlKHBidW5kbGUtPmluZmQpOwogCWNsb3NlKHBidW5k
bGUtPm91dGZkKTsKKwlmcmVlKHBidW5kbGUtPnBjdHgtPnN0YWNrX2J1Zik7CiAJZnJlZShwYnVu
ZGxlLT5wY3R4KTsKIAlmcmVlKHBidW5kbGUpOwogCi0tIAoyLjMwLjIKCg==

