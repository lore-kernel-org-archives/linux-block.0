Return-Path: <SRS0=aEt0=ZG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A51C432C3
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 14:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B4B20706
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 14:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfKNObb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Nov 2019 09:31:31 -0500
Received: from verein.lst.de ([213.95.11.211]:39901 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbfKNObb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Nov 2019 09:31:31 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 667B668B05; Thu, 14 Nov 2019 15:31:28 +0100 (CET)
Date:   Thu, 14 Nov 2019 15:31:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 4/5] block: fix bdev_disk_changed for non-partitioned
 devices
Message-ID: <20191114143128.GA1591@lst.de>
References: <20191106151439.30056-1-hch@lst.de> <20191106151439.30056-5-hch@lst.de> <20191114140716.GI28486@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114140716.GI28486@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 14, 2019 at 03:07:16PM +0100, Jan Kara wrote:
> I'd just note that e.g. drivers/scsi/sr.c or drivers/scsi/sd.c already call
> revalidate_disk() on device open so it seems a bit stupid to call it again
> just a bit later. But that's not really a new thing, this patch just makes
> it universal.

That whole area is a bit of a mess, including how the whole
->revalidate_disk callback works, and how we have a complicated events
mechanism, but then also md as the only remaining user of the legacy
->media_changed method.  I have a few idea on how to sort some of that
out, but it's going to take a while.
