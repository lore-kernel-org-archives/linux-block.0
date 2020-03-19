Return-Path: <SRS0=6FHI=5E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE49CC4332E
	for <linux-block@archiver.kernel.org>; Thu, 19 Mar 2020 13:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2146208D6
	for <linux-block@archiver.kernel.org>; Thu, 19 Mar 2020 13:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bt1M/sl5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgCSN1W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:27:22 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:36344 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730883AbgCSN1U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Mar 2020 09:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584624440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r2w2/6ACcfMX5JG5bZCNs7r8k97CeG70/2Lis7zPsEQ=;
        b=bt1M/sl5SW/s6/CJ2v3uQkbgZKsNjZWXNNJYIDWtd5xGcNSyYXNDjcd2DkasOnn3SjHkIw
        fxIVW98ivJJi4l2TUZKg/7/CxJGsrbbn05sa1+kvijKsBL5kb4450sYvqIcWxg0simHvB0
        ZmyI/ZMlOXsdnlvSTQtuw2B14DAsVGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-mMGMFlC1Mz2N2aKEDdPxAg-1; Thu, 19 Mar 2020 09:27:14 -0400
X-MC-Unique: mMGMFlC1Mz2N2aKEDdPxAg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FB3E1857C01;
        Thu, 19 Mar 2020 13:27:13 +0000 (UTC)
Received: from localhost (ovpn-113-148.ams2.redhat.com [10.36.113.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 565FB100164D;
        Thu, 19 Mar 2020 13:27:10 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
        Stefan Metzmacher <metze@samba.org>
Subject: [PATCH liburing 2/2] spec: add ./configure --libdevdir= for development package files
Date:   Thu, 19 Mar 2020 13:26:58 +0000
Message-Id: <20200319132658.8552-3-stefanha@redhat.com>
In-Reply-To: <20200319132658.8552-1-stefanha@redhat.com>
References: <20200319132658.8552-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

VGhlIGRldmVsb3BtZW50IHBhY2thZ2UgZmlsZXMgKC0tbGliZGV2ZGlyPSkgaGF2ZSBiZWVuIHNl
cGFyYXRlZCBmcm9tCnRoZSBsaWJyYXJ5IHJ1bnRpbWUgcGFja2FnZSBmaWxlcyAoLS1saWJkaXI9
KS4gIE1ha2Ugc3VyZSB0byBzZXQKLS1saWJkZXZkaXI9IHNvIHg4Nl82NCBGZWRvcmEgUlBNcyBh
cmUgYnVpbHQgZm9yIC91c3IvbGliNjQgaW5zdGVhZCBvZgovdXNyL2xpYi4KCkNjOiBTdGVmYW4g
TWV0em1hY2hlciA8bWV0emVAc2FtYmEub3JnPgpGaXhlczogM2U2M2FmNGYyNTJlMWRmYzJjYjcz
Njg2M2Q4ZGI0YTM4MjFmNDhlNAogICAgICAgKCJGaXggbGlidXJpbmcuc28gc3ltbGluayBzb3Vy
Y2UgaWYgbGliZGlyICE9IGxpYmRldmRpciIpClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6
aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiBsaWJ1cmluZy5zcGVjIHwgMiArLQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvbGli
dXJpbmcuc3BlYyBiL2xpYnVyaW5nLnNwZWMKaW5kZXggOTg3OTQ2ZC4uMTY2NWM3YyAxMDA2NDQK
LS0tIGEvbGlidXJpbmcuc3BlYworKysgYi9saWJ1cmluZy5zcGVjCkBAIC0yNiw3ICsyNiw3IEBA
IGZvciB0aGUgTGludXgtbmF0aXZlIGlvX3VyaW5nLgogCiAlYnVpbGQKICVzZXRfYnVpbGRfZmxh
Z3MKLS4vY29uZmlndXJlIC0tcHJlZml4PSV7X3ByZWZpeH0gLS1saWJkaXI9LyV7X2xpYmRpcn0g
LS1tYW5kaXI9JXtfbWFuZGlyfSAtLWluY2x1ZGVkaXI9JXtfaW5jbHVkZWRpcn0KKy4vY29uZmln
dXJlIC0tcHJlZml4PSV7X3ByZWZpeH0gLS1saWJkaXI9LyV7X2xpYmRpcn0gLS1saWJkZXZkaXI9
LyV7X2xpYmRpcn0gLS1tYW5kaXI9JXtfbWFuZGlyfSAtLWluY2x1ZGVkaXI9JXtfaW5jbHVkZWRp
cn0KIAogJW1ha2VfYnVpbGQKIAotLSAKMi4yNC4xCgo=

