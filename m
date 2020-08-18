Return-Path: <SRS0=KeVv=B4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A147AC433DF
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 03:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82AFE207DE
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 03:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgHRD3l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Aug 2020 23:29:41 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:35293 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726429AbgHRD3k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Aug 2020 23:29:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U66bqht_1597721377;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U66bqht_1597721377)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 Aug 2020 11:29:37 +0800
Date:   Tue, 18 Aug 2020 11:29:37 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 5/5] block: Remove __blk_mq_sched_bio_merge()
 helper
Message-ID: <20200818032937.GA46480@VM20190228-100.tbsite.net>
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
References: <cover.1597637287.git.baolin.wang@linux.alibaba.com>
 <4ad0888df567a8bd75676b618ad87147c634d7b0.1597637287.git.baolin.wang@linux.alibaba.com>
 <20200817063241.GE12248@lst.de>
 <20200817121408.GD79836@VM20190228-100.tbsite.net>
 <20200817122608.GB2213@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817122608.GB2213@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 17, 2020 at 02:26:08PM +0200, Christoph Hellwig wrote:
> On Mon, Aug 17, 2020 at 08:14:08PM +0800, Baolin Wang wrote:
> > On Mon, Aug 17, 2020 at 08:32:41AM +0200, Christoph Hellwig wrote:
> > > On Mon, Aug 17, 2020 at 12:09:19PM +0800, Baolin Wang wrote:
> > > > The blk_mq_sched_bio_merge() just wrap the __blk_mq_sched_bio_merge(), and
> > > > no other places will use __blk_mq_sched_bio_merge(). Thus we can combine
> > > > these 2 similar functions into one function.
> > > 
> > > I think the idea was to avoid the function call for the nomerges fast
> > > path.  Not sure if that is really worth it.
> > 
> > Um, no places will use __blk_mq_sched_bio_merge(), not sure if it is a
> > good choice we still keep an unused and similar function?
> 
> Well, blk_mq_sched_bio_merge calls __blk_mq_sched_bio_merge, after
> performing two fast path checks.

What I mean is blk_mq_sched_bio_merge() just wrap the
__blk_mq_sched_bio_merge(), and no other users will call
__blk_mq_sched_bio_merge(). Anyway, I will drop this patch
as you suggested.

