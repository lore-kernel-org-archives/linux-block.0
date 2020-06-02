Return-Path: <SRS0=F1yh=7P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39287C433DF
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 06:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B11D2077D
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 06:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbgFBGw3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jun 2020 02:52:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:41372 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbgFBGw3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Jun 2020 02:52:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6795AAC12;
        Tue,  2 Jun 2020 06:52:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 51E891E1282; Tue,  2 Jun 2020 08:52:27 +0200 (CEST)
Date:   Tue, 2 Jun 2020 08:52:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/4] blktrace: use rcu calls to access q->blk_trace
Message-ID: <20200602065227.GC19165@quack2.suse.cz>
References: <20200602013208.4325-1-chaitanya.kulkarni@wdc.com>
 <20200602013208.4325-2-chaitanya.kulkarni@wdc.com>
 <8c176b63-8a3b-7086-083a-dde931c52012@acm.org>
 <BYAPR04MB49656977FE2595A87946147C868B0@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB49656977FE2595A87946147C868B0@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 02-06-20 03:10:42, Chaitanya Kulkarni wrote:
> On 6/1/20 7:27 PM, Bart Van Assche wrote:
> > On 2020-06-01 18:32, Chaitanya Kulkarni wrote:
> >> Since request queue's blk_trace member is been markds as __rcu,
> >> replace xchg() and cmdxchg() calls with appropriate rcu API.
> >> This removes the sparse warnings.
> > This patch looks like a subset of a patch that was posted a few days ago
> > by Jan Kara? See also
> > https://lore.kernel.org/linux-block/20200528092910.11118-1-jack@suse.cz/.
> > 
> > Bart.
> > 
> 
> Thanks for pointing out. I think my patch maintains the goto labels and
> keeps the original code flow with two calls as mentioned in the patch
> description. Maybe we can merge both patches keeping Jan as an Original 
> author since his patch was sent first ?

Yes, my patch also removes the unnecessary atomic operations besides fixing
the sparse warnings. I'll rebase it on top of Luis' patches [1] which conflict
with it and resend it.

								Honza

[1] https://lore.kernel.org/linux-block/20200516031956.2605-1-mcgrof@kernel.org/
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
