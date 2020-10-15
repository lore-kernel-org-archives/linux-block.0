Return-Path: <SRS0=w0su=DW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6C2C43457
	for <linux-block@archiver.kernel.org>; Thu, 15 Oct 2020 14:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62C06218AC
	for <linux-block@archiver.kernel.org>; Thu, 15 Oct 2020 14:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TKpn88v+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbgJOOh4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Oct 2020 10:37:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:45352 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728888AbgJOOhz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Oct 2020 10:37:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602772673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fyAdftOWPrn+xC9V3oziST8/L7BPDtEvR1vWQr/edYo=;
        b=TKpn88v+tlHuc50Ohx8tQdnLNWyltTr3kRUlCiFRMIiRw5JoK3h+kl0jroxGx8ajrdnqig
        hajS55X8gQIZxT1Ok5V/Jmb8v3EWIgbKZpPAXSSC/GhHePh1LGd/RWE/f5gXaszt5DqU+w
        KSo1AK0tMG061dn3oGjEoWnb1+RXGZQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 61299ACDB;
        Thu, 15 Oct 2020 14:37:53 +0000 (UTC)
Subject: Re: [PATCH 2/2] xen/blkback: turn the cache purge percent into a
 parameter
To:     Roger Pau Monne <roger.pau@citrix.com>,
        linux-kernel@vger.kernel.org
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        SeongJae Park <sjpark@amazon.de>,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        "J . Roeleveld" <joost@antarean.org>
References: <20201015142416.70294-1-roger.pau@citrix.com>
 <20201015142416.70294-3-roger.pau@citrix.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <0b7da9e1-6c59-5b8d-52aa-6293568613d1@suse.com>
Date:   Thu, 15 Oct 2020 16:37:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201015142416.70294-3-roger.pau@citrix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 15.10.20 16:24, Roger Pau Monne wrote:
> Assume that reads and writes to the variable will be atomic. The worse
> that could happen is that one of the purges removes a partially
> written percentage of grants, but the cache itself will recover.
> 
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> ---
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: SeongJae Park <sjpark@amazon.de>
> Cc: xen-devel@lists.xenproject.org
> Cc: linux-block@vger.kernel.org
> Cc: J. Roeleveld <joost@antarean.org>
> Cc: Jürgen Groß <jgross@suse.com>
> ---
>   Documentation/ABI/testing/sysfs-driver-xen-blkback | 9 +++++++++
>   drivers/block/xen-blkback/blkback.c                | 7 +++++--
>   2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-xen-blkback b/Documentation/ABI/testing/sysfs-driver-xen-blkback
> index 776f25d335ca..7de791ad61f9 100644
> --- a/Documentation/ABI/testing/sysfs-driver-xen-blkback
> +++ b/Documentation/ABI/testing/sysfs-driver-xen-blkback
> @@ -45,3 +45,12 @@ Description:
>                   to be executed periodically. This parameter controls the time
>                   interval between consecutive executions of the purge mechanism
>                   is set in ms.
> +
> +What:           /sys/module/xen_blkback/parameters/lru_percent_clean
> +Date:           October 2020
> +KernelVersion:  5.10
> +Contact:        Roger Pau Monné <roger.pau@citrix.com>
> +Description:
> +                When the persistent grants list is full we will remove unused
> +                grants from the list. The percent number of grants to be
> +                removed at each LRU execution.
> diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
> index 6ad9b76fdb2b..772852d45a5a 100644
> --- a/drivers/block/xen-blkback/blkback.c
> +++ b/drivers/block/xen-blkback/blkback.c
> @@ -127,7 +127,10 @@ MODULE_PARM_DESC(lru_internval,
>    * from the list. The percent number of grants to be removed at each LRU
>    * execution.
>    */
> -#define LRU_PERCENT_CLEAN 5
> +static unsigned int lru_percent_clean = 5;
> +module_param_named(lru_percent_clean, lru_percent_clean, uint, 0644);
> +MODULE_PARM_DESC(lru_percent_clean,
> +		 "Percentage of persistent grants to remove from the cache when full");
>   
>   /* Run-time switchable: /sys/module/blkback/parameters/ */
>   static unsigned int log_stats;
> @@ -404,7 +407,7 @@ static void purge_persistent_gnt(struct xen_blkif_ring *ring)
>   	    !ring->blkif->vbd.overflow_max_grants)) {
>   		num_clean = 0;
>   	} else {
> -		num_clean = (max_pgrants / 100) * LRU_PERCENT_CLEAN;
> +		num_clean = (max_pgrants / 100) * lru_percent_clean;

Hmm, wouldn't it be better to use (max_grants * lru_percent_clean) / 100
here in order to support max_grants values less than 100?


Juergen
