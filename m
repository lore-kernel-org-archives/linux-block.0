Return-Path: <SRS0=yWXY=D3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2ABC433DF
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 08:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD793222C8
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 08:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IjTfdRhz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388335AbgJTIQe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Oct 2020 04:16:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30915 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387520AbgJTIQd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Oct 2020 04:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603181792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=iD5tQvHTqKLoAi7pndkIycrmVyIwHvsj4w4tynMZ8Rs=;
        b=IjTfdRhzjT1HyDOcsPU6Dxy7aUFmBzazHexVkD94QljFHkD/nExuuHZDG7vHvHmZ6Pz4T3
        0wNt2hVk6jj4mPlzP1AeO4CylGQfEQ9xArHkeeXYlbXux+UQ31onxokd05A06a1eIK26hy
        rUQxHR5vp73HIQ75t1MXkXtm/RuVu7E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-zmM6PZHUP924s6O97wiclg-1; Tue, 20 Oct 2020 04:16:30 -0400
X-MC-Unique: zmM6PZHUP924s6O97wiclg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E5C8EDBC0;
        Tue, 20 Oct 2020 08:16:28 +0000 (UTC)
Received: from lxbceph1.gsslab.pek2.redhat.com (vm37-120.gsslab.pek2.redhat.com [10.72.37.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09F855D9D2;
        Tue, 20 Oct 2020 08:16:25 +0000 (UTC)
From:   xiubli@redhat.com
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     nbd@other.debian.org, linux-block@vger.kernel.org,
        jdillama@redhat.com, mgolub@suse.de, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH 0/2] nbd: fix use-after-freed and double lock bugs
Date:   Tue, 20 Oct 2020 04:16:13 -0400
Message-Id: <20201020081615.240305-1-xiubli@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>


Xiubo Li (2):
  nbd: fix use-after-freed crash for nbd->recv_workq
  nbd: fix double lock for nbd->config_lock

 drivers/block/nbd.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

-- 
2.18.4

