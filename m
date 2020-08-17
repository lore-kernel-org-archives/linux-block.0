Return-Path: <SRS0=fuqo=B3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439DFC433E1
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 06:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A0F6207DF
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 06:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgHQGco (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Aug 2020 02:32:44 -0400
Received: from verein.lst.de ([213.95.11.211]:55205 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgHQGco (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Aug 2020 02:32:44 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3436067357; Mon, 17 Aug 2020 08:32:42 +0200 (CEST)
Date:   Mon, 17 Aug 2020 08:32:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de,
        baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 5/5] block: Remove __blk_mq_sched_bio_merge()
 helper
Message-ID: <20200817063241.GE12248@lst.de>
References: <cover.1597637287.git.baolin.wang@linux.alibaba.com> <4ad0888df567a8bd75676b618ad87147c634d7b0.1597637287.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ad0888df567a8bd75676b618ad87147c634d7b0.1597637287.git.baolin.wang@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 17, 2020 at 12:09:19PM +0800, Baolin Wang wrote:
> The blk_mq_sched_bio_merge() just wrap the __blk_mq_sched_bio_merge(), and
> no other places will use __blk_mq_sched_bio_merge(). Thus we can combine
> these 2 similar functions into one function.

I think the idea was to avoid the function call for the nomerges fast
path.  Not sure if that is really worth it.
