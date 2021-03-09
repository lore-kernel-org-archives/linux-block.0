Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393AFC433DB
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 14:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E30FC651A2
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 14:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhCIOTq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Mar 2021 09:19:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23245 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229689AbhCIOTT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Mar 2021 09:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615299558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=LUg1jqK7RnPVJq6pqE7OlGiUTDB2BStoCM3qs5/HhGk=;
        b=XIEwRBTCQ/tdweKBoCk7cC7qHYFbU18UDinz76h6uhyeoZEKfsVK+nnqs+BhNLJb+TtARq
        U7vRHQ/DIKLtzHVmIrf8+H//7ABo5AEYAnp1Pv915Zv8cYjnB4IJm0CFdyunfIUaUr2xTV
        caR0eNzk8pBvb18x+lZQVjXw9dL7N0Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-YSZ-1U_fPCizHgur4nWibw-1; Tue, 09 Mar 2021 09:19:16 -0500
X-MC-Unique: YSZ-1U_fPCizHgur4nWibw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B34EE26868;
        Tue,  9 Mar 2021 14:19:15 +0000 (UTC)
Received: from localhost (ovpn-115-70.ams2.redhat.com [10.36.115.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B85160C13;
        Tue,  9 Mar 2021 14:19:15 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Jeff Moyer <jmoyer@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 0/2] spec: liburing-2.0 updates
Date:   Tue,  9 Mar 2021 14:19:11 +0000
Message-Id: <20210309141913.262131-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

VXBkYXRlIHRoZSBsaWJ1cmluZy5zcGVjIGZpbGUgc28gdGhlIGxpYnVyaW5nLnBjIHBrZy1jb25m
aWcgZmlsZSBhbmQgcnBtcw0KcmVwb3J0IHZlcnNpb24gMi4wIGluc3RlYWQgb2YgMC43Lg0KDQpT
dGVmYW4gSGFqbm9jemkgKDIpOg0KICBzcGVjOiBidW1wIHZlcnNpb24gdG8gMi4wDQogIHNwZWM6
IGFkZCBleHBsaWNpdCBidWlsZCBkZXBlbmRlbmN5IG9uIG1ha2UNCg0KIGxpYnVyaW5nLnNwZWMg
fCAzICsrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cg0KLS0gDQoyLjI5LjINCg0K

