Return-Path: <SRS0=bBnE=Z2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159F2C43603
	for <linux-block@archiver.kernel.org>; Wed,  4 Dec 2019 11:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C551220637
	for <linux-block@archiver.kernel.org>; Wed,  4 Dec 2019 11:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b1U01LQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfLDLbd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:31:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31415 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727268AbfLDLbd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Dec 2019 06:31:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575459092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=86iOrCf+fjgJXTL0q9zY36Kx+OCgJTjE59sw1EZ0KnY=;
        b=b1U01LQUnj4gI7ins6nlxlbR3qkv9MAyS5hZ87svQS+FPuzhpb6D5YG+zgrV5SW+FXIOvt
        vpQYk7etANkfHlMxK9ailrkuOeVXqpl779PLwCCCq8G981onZW0M85VxZ93VIUoCkCfZE1
        6Dzb+zb6rkOOp7morYkKRWehf3AJiSA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-v31SF5KNNL-uh4Zp3jh9_g-1; Wed, 04 Dec 2019 06:31:28 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CF4ADBA5;
        Wed,  4 Dec 2019 11:31:27 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9DD2569184;
        Wed,  4 Dec 2019 11:31:22 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Stephen Rust <srust@blockbridge.com>
Subject: [PATCH 0/2] brd: remove max_hw_sectors limit and warn on un-aligned buffer
Date:   Wed,  4 Dec 2019 19:31:13 +0800
Message-Id: <20191204113115.17818-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: v31SF5KNNL-uh4Zp3jh9_g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The 1st patch removes max_hw_sectors queue limit.

The 2nd one adds warning on un-aligned buffer.


Ming Lei (2):
  brd: remove max_hw_sectors queue limit
  brd: warn on un-aligned buffer

 drivers/block/brd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Cc: Stephen Rust <srust@blockbridge.com>

--=20
2.20.1

