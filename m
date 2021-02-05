Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02935C433E6
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 07:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC0B64F70
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 07:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhBEHbz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Feb 2021 02:31:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34336 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231565AbhBEHbt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Feb 2021 02:31:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612510221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D6Iob4dGvjRCmRzXFDoiMGK6DSQ4lJ9nfBHdsJ9JxOg=;
        b=deWbUXRwgQi5Jz4U06A1JZ8U3W7B7udzCkERMU/geEYOMBYbUdiNLvHKYHu1e/kljTKWsN
        rGzrxIjU9tHkUIfSWYctZvGDK0S5Q18nW/wifAiRPFW4jfysfSbvYuh2vUNu7eD8Wvh9BV
        mIgwQg6i6ztig7KLRntRW8f/z+kp7WQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-f47qj8x4M56wM1N6eJn1qA-1; Fri, 05 Feb 2021 02:30:19 -0500
X-MC-Unique: f47qj8x4M56wM1N6eJn1qA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F1061020C25;
        Fri,  5 Feb 2021 07:30:18 +0000 (UTC)
Received: from T590 (ovpn-13-14.pek2.redhat.com [10.72.13.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C523060C6C;
        Fri,  5 Feb 2021 07:30:12 +0000 (UTC)
Date:   Fri, 5 Feb 2021 15:30:07 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Ewan D . Milne" <emilne@redhat.com>
Subject: Re: [PATCH 2/2] block: avoid to drop & re-add partitions if
 partitions aren't changed
Message-ID: <20210205073007.GA1519884@T590>
References: <20210205021708.1498711-1-ming.lei@redhat.com>
 <20210205021708.1498711-3-ming.lei@redhat.com>
 <20210205071429.GA28033@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205071429.GA28033@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 05, 2021 at 08:14:29AM +0100, Christoph Hellwig wrote:
> On Fri, Feb 05, 2021 at 10:17:08AM +0800, Ming Lei wrote:
> > block ioctl(BLKRRPART) always drops current partitions and adds
> > partitions again, even though there isn't any change in partitions table.
> > 
> > ioctl(BLKRRPART) may be called by systemd-udevd and some disk utilities
> > frequently.
> 
> Err, why?  We should probably fix udev to not do stupid things first.

It is one standard syscall, and the command is just for re-read
partition table, and it can be called by any application, fdisk
calls it too even though no any change done on the disk data,
same with parted, and there should be more.

	#define BLKRRPART  _IO(0x12,95) /* re-read partition table */

IMO, this syscall isn't supposed to drop partitions if user doesn't
touch the partition table, do you think it is one sane behavior to
drop partitions at will?

-- 
Ming

