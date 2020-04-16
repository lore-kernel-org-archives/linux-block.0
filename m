Return-Path: <SRS0=Ef4g=6A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E13C2BB55
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 12:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1541621973
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 12:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635398AbgDPMbr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:31:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:50842 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439151AbgDPMbn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Apr 2020 08:31:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9FD7FAC6D;
        Thu, 16 Apr 2020 12:31:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 155541E1250; Thu, 16 Apr 2020 14:31:40 +0200 (CEST)
Date:   Thu, 16 Apr 2020 14:31:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, Yufen Yu <yuyufen@huawei.com>,
        axboe@kernel.dk, tj@kernel.org, bvanassche@acm.org, tytso@mit.edu,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] bdi: add a ->dev_name field to struct
 backing_dev_info
Message-ID: <20200416123140.GN23739@quack2.suse.cz>
References: <20200416071519.807660-1-hch@lst.de>
 <20200416071519.807660-4-hch@lst.de>
 <5bfcd35a-2463-3769-be93-911c4e3c38bb@huawei.com>
 <20200416120223.GI23739@quack2.suse.cz>
 <20200416121901.GA26483@lst.de>
 <20200416122235.GA26982@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416122235.GA26982@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 16-04-20 14:22:35, Christoph Hellwig wrote:
> On Thu, Apr 16, 2020 at 02:19:01PM +0200, Christoph Hellwig wrote:
> > On Thu, Apr 16, 2020 at 02:02:23PM +0200, Jan Kara wrote:
> > > Yes, that can indeed happen. E.g. I remember that drivers/scsi/sd.c calls
> > > device_add_disk() + del_gendisk() repeatedly for one request_queue and that
> > > would result in leaking the name (and possibly cause use-after-free
> > > issues).
> > 
> > Sd calls device_add_disk once in ->probe, and del_gendisk once in
> > sd_remove.  Note that sd_probe allocates a new scsi_disk structure and
> > a new gendisk everytime, but it does indeed reuse the request_queue
> > and thus bdi.
> > 
> > > I think dev_name has to be just a static array inside
> > > backing_dev_info which gets overwritten on reregistration. The question is
> > > how big should be this array... Some grepping shows that 40 bytes should be
> > > enough for everybody except fs/vboxsf/super.c which puts 'fc->source' into
> > > the name which can be presumably rather large. Anyway, I'd make it 40 and
> > > just truncate it case in case it does not fit. bdi_dev_name() is used for
> > > informational purposes anyway...
> > 
> > We could just make it a variable sized array at the end of the structure
> > and size it based on the len.
> 
> Which doesn't always work as the size might not always be the same.
> But I think the fundamental problem is that we are trying to re-register
> previous unregistered bdis.  We really should not have bdi_alloc
> separate from bdi_register and solve this properly.

Yes, that would be easier then but it seems like a much larger change
because currently bdi is disassociated from request_queue only in
__blk_release_queue() (blk_exit_queue()). I guess the separate bdi
registration / deregistration is partially a leftover from times when bdi
was still embedded in request_queue but now it's difficult to undo it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
