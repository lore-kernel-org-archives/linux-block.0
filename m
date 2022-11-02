Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73291C4167B
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 16:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiKBQWm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 12:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiKBQVu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 12:21:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D17831EF2
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 09:15:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 261F8B8236B
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 16:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530F3C433C1;
        Wed,  2 Nov 2022 16:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667405695;
        bh=vwl2VTeve3Xkrx8QwDCL6dYcQSS7wLBVkNExwcsa92o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SsSuZl8F45jaOQAhfa1yZowJ+JqHOMY+BsNsGDL+gA7j3FWkWwnZvrgxADy7zSriW
         XaW4+yNDiTiCQrD1nWPm0OHL3psWwVORIcR+krQjA//nnbsfCYWMiSCn8qk+k11lBW
         MUrx4NzS3gNZ6JKIq/8zs20gKbvM7qKV3kzBHmsMiz1E7dv9Hs5s3BDR/7h5D025TI
         1G8SyTTAorq2/+pc5cXkq1JHhztCxgaYHmT8M6fDMhIjY51pz5RDUov0sq645j02nM
         w6EsP6gMvFMM8SvyhUNDZoOjhZ1SJnUuJzQuVaBhHDYhoS1tpqiiM3bL4c5C3HKzEi
         Hu0Ai2gpZ74LQ==
Date:   Wed, 2 Nov 2022 10:14:52 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Dmitrii Tcvetkov <me@demsh.org>
Subject: Re: Regression: wrong DIO alignment check with dm-crypt
Message-ID: <Y2KXfNZzwPZBJRTW@kbusch-mbp.dhcp.thefacebook.com>
References: <Y2Hf08vIKBkl5tu0@sol.localdomain>
 <Y2KEH6OZ0MDf5cSh@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2KEH6OZ0MDf5cSh@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 02, 2022 at 08:52:15AM -0600, Keith Busch wrote:
> [Cc'ing Dmitrii, who also reported the same issue]
> 
> On Tue, Nov 01, 2022 at 08:11:15PM -0700, Eric Biggers wrote:
> > Hi,
> > 
> > I happened to notice the following QEMU bug report:
> > 
> > https://gitlab.com/qemu-project/qemu/-/issues/1290
> > 
> > I believe it's a regression from the following kernel commit:
> > 
> >     commit b1a000d3b8ec582da64bb644be633e5a0beffcbf
> >     Author: Keith Busch <kbusch@kernel.org>
> >     Date:   Fri Jun 10 12:58:29 2022 -0700
> > 
> >         block: relax direct io memory alignment
> > 
> > The bug is that if a dm-crypt device is set up with a crypto sector size (and
> > thus also a logical_block_size) of 4096, then the block layer now lets through
> > direct I/O requests to dm-crypt when the user buffer has only 512-byte
> > alignment, instead of the 4096-bytes expected by dm-crypt in that case.  This is
> > because the dma_alignment of the device-mapper device is only 511 bytes.
> > 
> > This has two effects in this case:
> > 
> >     - The error code for DIO with a misaligned buffer is now EIO, instead of
> >       EINVAL as expected and documented.  This is because the I/O reaches
> >       dm-crypt instead of being rejected by the block layer.
> > 
> >     - STATX_DIOALIGN reports 512 bytes for stx_dio_mem_align, instead of the
> >       correct value of 4096.  (Technically not a regression since STATX_DIOALIGN
> >       is new in v6.1, but still a bug.)
> > 
> > Any thoughts on what the correct fix is here?  Maybe the device-mapper layer
> > needs to set dma_alignment correctly?  Or maybe the block layer needs to set it
> > to 'logical_block_size - 1' by default?
> 
> I think the quick fix is to have the device mapper override the default
> queue stacking limits to align the dma mask to logical block size.

This is what I'm coming up with. Only compile tested (still setting up
an enviroment to actually run it).

---
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 159c6806c19b..9334e58a4c9f 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -43,6 +43,7 @@
 #include <linux/device-mapper.h>
 
 #include "dm-audit.h"
+#include "dm-core.h"
 
 #define DM_MSG_PREFIX "crypt"
 
@@ -3615,7 +3616,9 @@ static int crypt_iterate_devices(struct dm_target *ti,
 
 static void crypt_io_hints(struct dm_target *ti, struct queue_limits *limits)
 {
+	struct mapped_device *md = dm_table_get_md(ti->table);
 	struct crypt_config *cc = ti->private;
+	struct request_queue *q = md->queue;
 
 	/*
 	 * Unfortunate constraint that is required to avoid the potential
@@ -3630,6 +3633,8 @@ static void crypt_io_hints(struct dm_target *ti, struct queue_limits *limits)
 	limits->physical_block_size =
 		max_t(unsigned, limits->physical_block_size, cc->sector_size);
 	limits->io_min = max_t(unsigned, limits->io_min, cc->sector_size);
+
+	blk_queue_dma_alignment(q, limits->logical_block_size - 1);
 }
 
 static struct target_type crypt_target = {
--
