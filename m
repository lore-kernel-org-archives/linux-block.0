Return-Path: <SRS0=fuqo=B3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BF3C433E1
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 12:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A443D2072E
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 12:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgHQMG5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Aug 2020 08:06:57 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:48752 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727895AbgHQMG5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Aug 2020 08:06:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U60TDk9_1597666014;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U60TDk9_1597666014)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 17 Aug 2020 20:06:55 +0800
Date:   Mon, 17 Aug 2020 20:06:54 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 2/5] block: Remove redundant
 blk_mq_sched_allow_merge() validation
Message-ID: <20200817120654.GA79836@VM20190228-100.tbsite.net>
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
References: <cover.1597637287.git.baolin.wang@linux.alibaba.com>
 <b9d51f4bc9f0ff4ec3b8fb7fa6dc366afd69290e.1597637287.git.baolin.wang@linux.alibaba.com>
 <20200817062224.GB12248@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817062224.GB12248@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 17, 2020 at 08:22:24AM +0200, Christoph Hellwig wrote:
> On Mon, Aug 17, 2020 at 12:09:16PM +0800, Baolin Wang wrote:
> > Only software queue and kyber IO scheduler will call blk_mq_bio_list_merge()
> > to merge a bio, and kyber IO scheduler did not implement the ops->allow_merge().
> 
> Please line wrap your changelogs after 73 characters.

Sure.

> 
> > Thus we can remove the redundant blk_mq_sched_allow_merge() in
> > blk_mq_bio_list_merge() function.
> 
> This seems potentially dangerous, and I don't think it really buys
> us much.

OK. I can remove this in next version.

