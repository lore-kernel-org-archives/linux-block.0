Return-Path: <SRS0=fuqo=B3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE52CC433E1
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 12:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE9E32072E
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 12:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgHQMON (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Aug 2020 08:14:13 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:33611 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726530AbgHQMOM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Aug 2020 08:14:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U61eDPb_1597666448;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U61eDPb_1597666448)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 17 Aug 2020 20:14:08 +0800
Date:   Mon, 17 Aug 2020 20:14:08 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 5/5] block: Remove __blk_mq_sched_bio_merge()
 helper
Message-ID: <20200817121408.GD79836@VM20190228-100.tbsite.net>
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
References: <cover.1597637287.git.baolin.wang@linux.alibaba.com>
 <4ad0888df567a8bd75676b618ad87147c634d7b0.1597637287.git.baolin.wang@linux.alibaba.com>
 <20200817063241.GE12248@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817063241.GE12248@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 17, 2020 at 08:32:41AM +0200, Christoph Hellwig wrote:
> On Mon, Aug 17, 2020 at 12:09:19PM +0800, Baolin Wang wrote:
> > The blk_mq_sched_bio_merge() just wrap the __blk_mq_sched_bio_merge(), and
> > no other places will use __blk_mq_sched_bio_merge(). Thus we can combine
> > these 2 similar functions into one function.
> 
> I think the idea was to avoid the function call for the nomerges fast
> path.  Not sure if that is really worth it.

Um, no places will use __blk_mq_sched_bio_merge(), not sure if it is a
good choice we still keep an unused and similar function?

Thanks for all your good suggestion.

