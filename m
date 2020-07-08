Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B95C433E0
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 09:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9296620760
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 09:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGl/WIZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgGHJwt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:52:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40740 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728633AbgGHJws (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 8 Jul 2020 05:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594201966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6V8Oz5oNbBNYHGaUxQlqOMJ8nneWj3NedlDP095R8VY=;
        b=eGl/WIZhUUh/79+gXtp5O7CmrLvXI9B1/PxsH2w32Up7gqPBNRphBRzFjFSAOP4aKhEgTx
        /yCBsnkQhxaRhgsRd67IWor9wTZ0zLSLZps7l2u0ZlOaQMaZdcnIHB3FV3rjWvk/JaNoc0
        sH+Z1FHyjuJLetk+SrY1tWuYiHYvRBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-Bsw_o1xKPLqDe9uBIuLWLg-1; Wed, 08 Jul 2020 05:52:43 -0400
X-MC-Unique: Bsw_o1xKPLqDe9uBIuLWLg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E04318CB720;
        Wed,  8 Jul 2020 09:52:42 +0000 (UTC)
Received: from T590 (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DDFAC7FE8B;
        Wed,  8 Jul 2020 09:52:36 +0000 (UTC)
Date:   Wed, 8 Jul 2020 17:52:32 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: loop: delete partitions after clearing &
 changing fd
Message-ID: <20200708095232.GB3321276@T590>
References: <20200707084552.3294693-1-ming.lei@redhat.com>
 <20200707084552.3294693-3-ming.lei@redhat.com>
 <20200707175312.GB3730@lst.de>
 <20200708091318.GA3321276@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708091318.GA3321276@T590>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 08, 2020 at 05:13:18PM +0800, Ming Lei wrote:
> On Tue, Jul 07, 2020 at 07:53:12PM +0200, Christoph Hellwig wrote:
> > On Tue, Jul 07, 2020 at 04:45:52PM +0800, Ming Lei wrote:
> > > After clearing fd or changing fd, we have to delete old partitions,
> > > otherwise they may become ghost partitions.
> > > 
> > > Fix this issue by clearing GENHD_FL_NO_PART_SCAN during calling
> > > bdev_disk_changed() which won't drop old partitions if GENHD_FL_NO_PART_SCAN
> > > isn't set.
> > 
> > I don't think messing with GENHD_FL_NO_PART_SCAN is a good idea, as
> > that will also cause an actual partition scan.  But except for historic
> > reasons I can't think of a good idea to even check for
> > GENHD_FL_NO_PART_SCAN in blk_drop_partitions.
> 
> I think it is safe to not check it in blk_drop_partitions(), how about
> the following patch?
> 
> From a20209464c367c338beee5555f2cb5c8e8ad9f78 Mon Sep 17 00:00:00 2001
> From: Ming Lei <ming.lei@redhat.com>
> Date: Wed, 8 Jul 2020 16:07:19 +0800
> Subject: [PATCH] block: always remove partitions in blk_drop_partitions()
> 
> So far blk_drop_partitions() only removes partitions when
> disk_part_scan_enabled() return true. This way can make ghost partition on
> loop device after changing/clearing FD in case that PARTSCAN is disabled.
> 
> Fix this issue by always removing partitions in blk_drop_partitions(), and
> this way is correct because:
> 
> 1) only loop, mmc and GENHD_FL_HIDDEN disks(nvme multipath) may set
> GENHD_FL_NO_PART_SCAN
> 
> 2) GENHD_FL_HIDDEN disks doesn't expose disk to block device fs, and
> bdev_disk_changed()/blk_drop_partitions() won't be called for this kind of
> disk
> 
> 3) for mmc, if GENHD_FL_NO_PART_SCAN is set, no any partitions can be added
> for this kind of disk, so blk_drop_partitions() basically does nothing no
> matter if GENHD_FL_NO_PART_SCAN is set or not because disk_max_parts(disk) <= 1
> 
> 4) for loop, bdev_disk_changed() is called in two cases: one is set fd and set
> status, when there shouldn't be any partitions; another is clearing/changing fd,
> we need to remove old partitions and re-read new partitions if there are and
> PART_SCAN is enabled.

BTW, the partitions shouldn't have been added, but ioctl(BLKPG, BLKPG_ADD_PARTITION)
doesn't check GENHD_FL_NO_PART_SCAN, so the partitions are added.

However, changing ioctl(BLKPG, BLKPG_ADD_PARTITION) might break some userspace.

Thanks,
Ming

