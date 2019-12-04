Return-Path: <SRS0=bBnE=Z2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E242C43603
	for <linux-block@archiver.kernel.org>; Wed,  4 Dec 2019 11:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B54D2077B
	for <linux-block@archiver.kernel.org>; Wed,  4 Dec 2019 11:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HttAVzen"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfLDLbi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:31:38 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23128 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727268AbfLDLbh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Dec 2019 06:31:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575459096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xTDoIQCDWc04bEeEOPRoMDlaYO5/Q0x1SpcVY5KhfsE=;
        b=HttAVzenmqtlbKvbl5DVBPem+4bp/BIV13aMx2KFUk4pu2eR0NfN85tYoLeMclp0g69605
        XQKB+TKYo2cWpMbivg/WV6K+E1yIb/3EDF2dMVO7V6zxiYQ5R270rfbMHRJyRjMgRFXdYZ
        ubm0/8QewcX+gi31SCAdismYWOzHJqA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-vybgjO3uOXGT1SDZvKso7w-1; Wed, 04 Dec 2019 06:31:33 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0A80800EB7;
        Wed,  4 Dec 2019 11:31:32 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96A685C1B0;
        Wed,  4 Dec 2019 11:31:29 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/2] brd: remove max_hw_sectors queue limit
Date:   Wed,  4 Dec 2019 19:31:14 +0800
Message-Id: <20191204113115.17818-2-ming.lei@redhat.com>
In-Reply-To: <20191204113115.17818-1-ming.lei@redhat.com>
References: <20191204113115.17818-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: vybgjO3uOXGT1SDZvKso7w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now we depend on blk_queue_split() to respect most of queue limit
(the only one exception could be dma alignment), however
blk_queue_split() isn't used for brd, so this limit isn't respected
since v4.3.

Also max_hw_sectors limit doesn't play a big role for brd, which is
added since brd is added to tree for unknown reason.

So remove it.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/brd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index c548a5a6c1a0..c2e5b2ad88bc 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -382,7 +382,6 @@ static struct brd_device *brd_alloc(int i)
 =09=09goto out_free_dev;
=20
 =09blk_queue_make_request(brd->brd_queue, brd_make_request);
-=09blk_queue_max_hw_sectors(brd->brd_queue, 1024);
=20
 =09/* This is so fdisk will align partitions on 4k, because of
 =09 * direct_access API needing 4k alignment, returning a PFN
--=20
2.20.1

