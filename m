Return-Path: <SRS0=zyEp=R5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5174FC10F05
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 14:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FBD20856
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 14:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XVVr9M6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbfCZOR1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:17:27 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:33107 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfCZOR1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Mar 2019 10:17:27 -0400
Received: by mail-it1-f195.google.com with SMTP id v8so2927399itf.0
        for <linux-block@vger.kernel.org>; Tue, 26 Mar 2019 07:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9aPTWbji5R5ZFrlaEGImvL5Rga/Q6axt0J4jjzESFQY=;
        b=XVVr9M6GRXnnRp709mtgCpeG4Dh0V3FcL6dc+bI6uCLvGQTyhVXHPpqsGadiETLOna
         S2Ie0PIcujwWIVfuKGSWhwG1PTmmYELqKpFGJv+rvZ36bm6UYkFk3/jiDk6F3Ms6nh0d
         KaZH45CQQatgEk9MuAjHFte0NGurvP39cNEfFnb/AmExGEoqNiC2ohqXkQ498rN1vU4a
         qkWZTqwKP2J6rsemYC7heQZjzuLq3QH5Lgkhnl9f6Mlmtd8T+bYDn+J3aoV4TYYs6Ib6
         8Lv7HjNyMNTj2r53Bi7tqBALdYrJlYet+RGxI6F9o9Cf/3Deuev0O/9i2ATSGRGfS1Xc
         Rcog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9aPTWbji5R5ZFrlaEGImvL5Rga/Q6axt0J4jjzESFQY=;
        b=gCRw+5jXeq7UdtVQ2hD+0GSqi4knO4KGO/cJp67rnGfydn2fdxnlUDgQLWIo/DlfoN
         N2UNXM2cc5V7P0Qld4Xib+FF35ELsUjifa1fvgOP7migGga7/PT6WPC+nroO+zH+NHfc
         VbRYawkTb8t5FskNqu07Jc4gplyM9HjZsHkwIqnLvU7Hobn70/PLfugZ0KaUtXWZpoYM
         Vf56Ynzvsbnz5aAzidRWzi9pqvcuuGAKTpxJ8pvBKDd1xixgRBVpDYQ0lhHAKi3+NHOx
         j0jjRNNsFhxtmnxzSZNIDxuIgwX4e6rlnBGsMV6cBBLHo4m5EQSWiUqh0G26Mp2cpBOI
         OAtw==
X-Gm-Message-State: APjAAAXJBbhkIz47zmTEMMAskPbX+h61XaVi6mhrv+tnzmsf6A57Bf9k
        ii8joWafYAtJYYCunxdhm6TPOw==
X-Google-Smtp-Source: APXvYqz6p+qO4/ZGQanAGH5KyF2mdWz1O8RRUTnNOdfnwR6UETbr0Beb1eE6Du0Nk9NHAQ19zlbkeQ==
X-Received: by 2002:a02:9831:: with SMTP id t46mr20707845jaj.140.1553609846220;
        Tue, 26 Mar 2019 07:17:26 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f132sm8188593ioa.76.2019.03.26.07.17.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 07:17:24 -0700 (PDT)
Subject: Re: [PATCH V2 8/8] blk-mq: remove blk_mq_tagset_busy_iter
To:     Hannes Reinecke <hare@suse.de>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     linux-block@vger.kernel.org, jsmart2021@gmail.com,
        sagi@grimberg.me, josef@toxicpanda.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, jthumshirn@suse.de, hch@lst.de,
        bvanassche@acm.org
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
 <1553492318-1810-9-git-send-email-jianchao.w.wang@oracle.com>
 <47fe0e2a-f427-0e3e-e15b-a9e2bffb502f@suse.de>
 <f9d22543-65d1-e473-e3ab-deefa2d6e884@oracle.com>
 <15fa9443-776b-bb75-0e20-538609d34eba@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5b5442f9-eb31-c7fa-822b-9e7b1a1d188c@kernel.dk>
Date:   Tue, 26 Mar 2019 08:17:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <15fa9443-776b-bb75-0e20-538609d34eba@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/25/19 2:25 AM, Hannes Reinecke wrote:
> On 3/25/19 8:37 AM, jianchao.wang wrote:
>> Hi Hannes
>>
>> On 3/25/19 3:18 PM, Hannes Reinecke wrote:
>>> On 3/25/19 6:38 AM, Jianchao Wang wrote:
>>>> As nobody uses blk_mq_tagset_busy_iter, remove it.
>>>>
>>>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>>>> ---
>>>>    block/blk-mq-tag.c     | 95 --------------------------------------------------
>>>>    include/linux/blk-mq.h |  2 --
>>>>    2 files changed, 97 deletions(-)
>>>>
>>> Please, don't.
>>>
>>> I'm currently implementing reserved commands for SCSI and reworking
>>> the SCSI error handling where I rely on this interface quite
>>> heavily.
>>
>>
>> blk_mq_tagset_busy_iter could access some stale requests which maybe
>> freed due to io scheduler switching, request_queue cleanup (shared
>> tagset) when there is someone submits io and gets driver tag. When io
>> scheduler attached, even quiesce request_queue won't work.
>>
>> If this patchset is accepted, blk_mq_tagset_busy_iter could be
>> replaced with blk_mq_queue_inflight_tag_iter which needs to be
>> invoked by every request_queue that shares the tagset.
>>
> The point is, at that time I do _not_ have a request queue to work
> with.
> 
> Most SCSI drivers have a host-wide shared tagset, which is used by all
> request queues on that host.  Iterating over the shared tagset is far
> more efficient than to traverse over all devices and the attached
> request queues.
> 
> If I had to traverse all request queues I would need to add additional
> locking to ensure this traversal is race-free, making it a really
> cumbersome interface to use.
> 
> Plus the tagset iter is understood to be used only in cases where I/O
> is stopped from the upper layers (ie no new I/O will be submitted).
> So here we only need to protect against I/O being completed, which is
> not what this patchset is about.
> 
> So my objection still stands: Please, don't.

We can't just keep an interface that's hard to use correctly just
because you have something pending for that. Jianchao has good
suggestions for you on how to proceed.

-- 
Jens Axboe

