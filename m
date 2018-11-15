Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE79C43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 09:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2AC20825
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 09:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C2AC20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbeKOTLc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:11:32 -0500
Received: from verein.lst.de ([213.95.11.211]:40662 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728719AbeKOTLc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 14:11:32 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2A5A268D52; Thu, 15 Nov 2018 10:04:35 +0100 (CET)
Date:   Thu, 15 Nov 2018 10:04:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        drbd-dev@lists.linbit.com
Subject: Re: [PATCH 04/16] block: use atomic bitops for ->queue_flags
Message-ID: <20181115090435.GA14370@lst.de>
References: <20181114160219.28328-1-hch@lst.de> <20181114160219.28328-5-hch@lst.de> <ddb96188-b2dd-6aaf-90f5-7eb5889691f8@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddb96188-b2dd-6aaf-90f5-7eb5889691f8@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 15, 2018 at 07:55:02AM +0100, Hannes Reinecke wrote:
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   block/blk-core.c       | 54 ++++++----------------------------------
>>   block/blk-mq.c         |  2 +-
>>   block/blk-settings.c   | 10 +++-----
>>   block/blk-sysfs.c      | 28 +++++++++------------
>>   block/blk.h            | 56 ------------------------------------------
>>   include/linux/blkdev.h |  1 -
>>   6 files changed, 24 insertions(+), 127 deletions(-)
>>
> I wonder if we can't remove the 'blk_queue_flag_XXX' helpers and replace 
> them with inlines ...

I'd prefer to just open code the *bit helpers as that is a lot more
reasonable.  But that is quite a lot of churn, so I'll only do that if
I get previous buy-in to that idea, and preferably in a separate series.
