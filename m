Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20995C433E9
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 16:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E2264F7C
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 16:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhBCQyy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Feb 2021 11:54:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:51032 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230229AbhBCQyt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Feb 2021 11:54:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CB4C5AC45;
        Wed,  3 Feb 2021 16:54:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4A8BA1E14C4; Wed,  3 Feb 2021 17:54:04 +0100 (CET)
Date:   Wed, 3 Feb 2021 17:54:04 +0100
From:   Jan Kara <jack@suse.cz>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 0/2 v3] blk-mq: Improve performance of non-mq IO
 schedulers with multiple HW queues
Message-ID: <20210203165404.GE7094@quack2.suse.cz>
References: <20210111164717.21937-1-jack@suse.cz>
 <7afa35b2-cf35-a149-d325-3ad2ae8d8935@kernel.dk>
 <8b871c07-a516-36ae-75c2-7d0a153ea753@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b871c07-a516-36ae-75c2-7d0a153ea753@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 03-02-21 16:18:59, John Garry wrote:
> On 25/01/2021 01:20, Jens Axboe wrote:
> > On 1/11/21 9:47 AM, Jan Kara wrote:
> > > Hello!
> > > 
> > > This patch series aims to fix a regression we've noticed on our test grid when
> > > support for multiple HW queues in megaraid_sas driver was added during the 5.10
> > > cycle (103fbf8e4020 scsi: megaraid_sas: Added support for shared host tagset
> > > for cpuhotplug). The commit was reverted in the end for other reasons but I
> > > believe the fundamental problem still exists for any other similar setup.
> 
> That commit made it into 5.11-rc, and other SCSI HBA expose HW queues in
> 5.10 and earlier. But then this series is targeted at 5.12.
> 
> Question: can we consider backport this series just due to performance issue
> regression? I'd say no, but maybe someone strongly disagrees with me ...

I also don't consider my series a stable tree material. The setup of
multiple HW queues with BFQ IO scheduler isn't really very common...

								Honza

> 
> Thanks,
> John
> 
> > The
> > > problem manifests when the storage card supports multiple hardware queues
> > > however storage behind it is slow (single rotating disk in our case) and so
> > > using IO scheduler such as BFQ is desirable. See the second patch for details.
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
