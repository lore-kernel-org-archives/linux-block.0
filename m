Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120CDC43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 06:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B2E223DD
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 06:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B2E223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbeKOQ5n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 11:57:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:56532 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726960AbeKOQ5n (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 11:57:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7DB1DAFE1;
        Thu, 15 Nov 2018 06:51:08 +0000 (UTC)
Subject: Re: [PATCH 02/16] block: remove deadline __deadline manipulation
 helpers
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        drbd-dev@lists.linbit.com
References: <20181114160219.28328-1-hch@lst.de>
 <20181114160219.28328-3-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <d324f6ee-ea0d-3cb6-17dd-c7c1f250b6a2@suse.de>
Date:   Thu, 15 Nov 2018 07:51:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181114160219.28328-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/14/18 5:02 PM, Christoph Hellwig wrote:
> No users left since the removal of the legacy request interface, we can
> remove all the magic bit stealing now and make it a normal field.
> 
> But use WRITE_ONCE/READ_ONCE on the new deadline field, given that we
> don't seem to have any mechanism to guarantee a new value actually
> gets seen by other threads.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-mq.c         |  4 ++--
>   block/blk-timeout.c    |  8 +++++---
>   block/blk.h            | 35 -----------------------------------
>   include/linux/blkdev.h |  4 +---
>   4 files changed, 8 insertions(+), 43 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
