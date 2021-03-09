Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_BASE64_TEXT,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A95EC433E0
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 14:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2886165208
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 14:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhCIOTq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Mar 2021 09:19:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56462 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230035AbhCIOTY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Mar 2021 09:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615299563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZI9s9EUogQPpBAqXoVO26EonsWSYgOg7aq/rKPniaWE=;
        b=D+08TmyUnS8nVRSJeS3xOW5Ux5bu/X5logqOBG3pVIC5sEHWf3FQFp84KRgbcorXAYVx7J
        WMbmVT0r8mnvBu1yPsoHfEvd/9VUzB7uVyxDcWLTaSzoaJVTsW1+I5VN/oInky32nv/lZA
        9aMX4f0WntiU6hL6HbJpfZoUCl613T8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-MAamp_1KPsuF_yuTkVzKzg-1; Tue, 09 Mar 2021 09:19:21 -0500
X-MC-Unique: MAamp_1KPsuF_yuTkVzKzg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99C6684E20A;
        Tue,  9 Mar 2021 14:19:20 +0000 (UTC)
Received: from localhost (ovpn-115-70.ams2.redhat.com [10.36.115.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E11F760CF0;
        Tue,  9 Mar 2021 14:19:16 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Jeff Moyer <jmoyer@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 1/2] spec: bump version to 2.0
Date:   Tue,  9 Mar 2021 14:19:12 +0000
Message-Id: <20210309141913.262131-2-stefanha@redhat.com>
In-Reply-To: <20210309141913.262131-1-stefanha@redhat.com>
References: <20210309141913.262131-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

VGhlIHNoYXJlZCBsaWJyYXJ5IGlzIG5vdyBsaWJ1cmluZy5zby4yIGJ1dCB0aGUgcGtnY29uZmln
IGFuZCBycG0gZmlsZXMKc3RpbGwgc2F5IDAuNy4gRXhpc3RpbmcgYmluYXJpZXMgbGluayBhZ2Fp
bnN0IGxpYnVyaW5nLnNvLjEgYW5kIHdpbGwgbm90CmF1dG9tYXRpY2FsbHkgcGljayB1cCB0aGUg
bmV3IGxpYnVyaW5nLnNvLjIgc2hhcmVkIGxpYnJhcnkuCgpVcGRhdGUgdGhlIHZlcnNpb24gbnVt
YmVyIGluIGxpYnVyaW5nLnNwZWMgc28KClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8
c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiBsaWJ1cmluZy5zcGVjIHwgMiArLQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvbGlidXJp
bmcuc3BlYyBiL2xpYnVyaW5nLnNwZWMKaW5kZXggZmE0ZDk3MC4uODYwNzA3NCAxMDA2NDQKLS0t
IGEvbGlidXJpbmcuc3BlYworKysgYi9saWJ1cmluZy5zcGVjCkBAIC0xLDUgKzEsNSBAQAogTmFt
ZTogbGlidXJpbmcKLVZlcnNpb246IDAuNworVmVyc2lvbjogMi4wCiBSZWxlYXNlOiAxJXs/ZGlz
dH0KIFN1bW1hcnk6IExpbnV4LW5hdGl2ZSBpb191cmluZyBJL08gYWNjZXNzIGxpYnJhcnkKIExp
Y2Vuc2U6IChHUEx2MiB3aXRoIGV4Y2VwdGlvbnMgYW5kIExHUEx2MispIG9yIE1JVAotLSAKMi4y
OS4yCgo=

