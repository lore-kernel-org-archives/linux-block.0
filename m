Return-Path: <SRS0=6FHI=5E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEECC4332B
	for <linux-block@archiver.kernel.org>; Thu, 19 Mar 2020 13:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78174208C3
	for <linux-block@archiver.kernel.org>; Thu, 19 Mar 2020 13:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ffVmot7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbgCSN1Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:27:16 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:58632 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730866AbgCSN1P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Mar 2020 09:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584624434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uRkL3QSA3idhoaiRNIaGFi9VKkb+LyjBAvAT0ll/y1Q=;
        b=ffVmot7/+uawIDGov2JHU1A3YdgtbFxE/JhZXq/6zdCi9FWZto7lfItIdVZNJpRviH6Gsv
        I4S+yk/E3ua5DwDcFjjIA2y65edeGWx6Ykdd0P3z7oY8PZBZApZDSMi3B6fa/onCHeqeaC
        lfnL2Cgrynr5askWU1KqnBb/bCq6RLw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-hwJZwrh2PJSNGcUYE_NMjQ-1; Thu, 19 Mar 2020 09:27:09 -0400
X-MC-Unique: hwJZwrh2PJSNGcUYE_NMjQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B984C86A073;
        Thu, 19 Mar 2020 13:27:08 +0000 (UTC)
Received: from localhost (ovpn-113-148.ams2.redhat.com [10.36.113.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64F7E5C1A2;
        Thu, 19 Mar 2020 13:27:04 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH liburing 1/2] spec: use "or" instead of "/" in License line
Date:   Thu, 19 Mar 2020 13:26:57 +0000
Message-Id: <20200319132658.8552-2-stefanha@redhat.com>
In-Reply-To: <20200319132658.8552-1-stefanha@redhat.com>
References: <20200319132658.8552-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

cnBtbGludCBvbiBGZWRvcmEgMzEgY29tcGxhaW5zIGFib3V0ICJMR1BMdjIrIC8gTUlUIiBiZWNh
dXNlICIvIiBpcyBub3QKYWxsb3dlZC4gIFVzZSAib3IiIGluc3RlYWQuCgpGaXhlczogNzgzODMx
YTA1NDhkM2M3MDJiZDE4NzQ2YjVmNDI1MTA2ZjEwZTA5MAogICAgICAgKCJJbmNsdWRlIE1JVCBu
b3RpY2UgaW4gcnBtIHNwZWMgYW5kIGRlYmlhbiBwYWNrYWdlIGZpbGUiKQpTaWduZWQtb2ZmLWJ5
OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogbGlidXJpbmcuc3Bl
YyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL2xpYnVyaW5nLnNwZWMgYi9saWJ1cmluZy5zcGVjCmluZGV4IGIwOWM2ZTEu
Ljk4Nzk0NmQgMTAwNjQ0Ci0tLSBhL2xpYnVyaW5nLnNwZWMKKysrIGIvbGlidXJpbmcuc3BlYwpA
QCAtMiw3ICsyLDcgQEAgTmFtZTogbGlidXJpbmcKIFZlcnNpb246IDAuNgogUmVsZWFzZTogMSV7
P2Rpc3R9CiBTdW1tYXJ5OiBMaW51eC1uYXRpdmUgaW9fdXJpbmcgSS9PIGFjY2VzcyBsaWJyYXJ5
Ci1MaWNlbnNlOiBMR1BMdjIrIC8gTUlUCitMaWNlbnNlOiBMR1BMdjIrIG9yIE1JVAogU291cmNl
MDogaHR0cHM6Ly9icmljay5rZXJuZWwuZGsvc25hcHMvJXtuYW1lfS0le3ZlcnNpb259LnRhci5n
egogU291cmNlMTogaHR0cHM6Ly9icmljay5rZXJuZWwuZGsvc25hcHMvJXtuYW1lfS0le3ZlcnNp
b259LnRhci5nei5hc2MKIFVSTDogaHR0cHM6Ly9naXQua2VybmVsLmRrL2NnaXQvbGlidXJpbmcv
Ci0tIAoyLjI0LjEKCg==

