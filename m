Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A83C433EF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 15:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351661AbiFAPIe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 11:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344567AbiFAPId (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 11:08:33 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BF66D181
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 08:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654096112; x=1685632112;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fuagikzvvtVyMgUz+mDdyt7LK8mwaU6vI3ICVHqSELU=;
  b=j+85ZDSmXI0bdbP2E2xwfLxtBaYZyFBrBowWI7MsbS/TB9FGB2jIVNr0
   yzF4K/DR/v53mGtso2soald2GnPIlWF17isc3gla4zgx4Epwqah7opZoh
   1DyogkkFRI+1JO2AocCBJpS7yUI4y3H+UmNbF53RDiv7TkBBJZ4fXifpC
   bHrxbotxizuLITc7azBM+SlN9+SXdTvqlitZLeEvYk2VVzPnfPp3W7LDG
   pmdHY0F29PDxafOPSy2ycDwUNr0S4EE+FxBjNulDuz95EbGkGYFEjlxue
   wladZBk3mqqj7HDV3hsdG627/TT4CSsEWFbjS7Ig3Pdc+u044fdSmsvdp
   A==;
X-IronPort-AV: E=Sophos;i="5.91,268,1647273600"; 
   d="scan'208";a="200754445"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jun 2022 23:08:31 +0800
IronPort-SDR: s+t/lu5F3788LyxPFd4FHkp/y3/UgwUsh3H/o0yHoNJBfeHVrHcywKNy8hzWkc1tpfnTTw256h
 PBclc/y/PQ9nJXmJ/noU8FTLCfpK6q2Y0d88XI8p5d4WCmvbxQSdo9lEp7w79vnB+6MmFRG+os
 porUMAi9Wx6qGg6cX8RH/4T5qsnrQuCs+BOy14wwzVJtkX/XwkdRO7jVPTj6ROC1SprrJukN/2
 JwlgANF7MTZ+vWzEQwvaPZ9AibEQe6TAKaTtmiqQSAxoYgC0nGoieTBSHuotXGqFB1fLqDkdu3
 WL9mGIUAPidlKbkEH1Rf+aSA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jun 2022 07:27:44 -0700
IronPort-SDR: DpAZiEkZG5YB7gI1dpS+StJuMmMywIuXYA7vDfcLj54RH0L9iYBxUmXiP+R6zzRrgPPSgczggI
 njXkfGPjE48/nxtV3g5aRuhs6X0Ii9QwE5H6PcYm8N4p6OvUcGmFm9m7XZZBYiKHvZ+lRXI2bZ
 KQUuRXeoBQPcDWIcr6b6xI49TxtQHKMmaz4HcsvwRuOqhVf0/Kf+mwTwU3SKnh2hSwNACmGTlC
 NmbVLQU8eNHne37V2T/p9SvLzZBa1LXBMHyniKfhqJSYnNmbFk1cEMQBEwYhjMk0qAOPk7Dfog
 /B8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jun 2022 08:08:32 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LCswb2Fcvz1SVnx
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 08:08:31 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1654096110; x=1656688111; bh=fuagikzvvtVyMgUz+mDdyt7LK8mwaU6vI3I
        CVHqSELU=; b=Pengv4eVrg4+2VRaJ25Tv0Kz4Swfmewg0Oa9fKHeRGpAzq5w/w+
        ax1T2UR4bTJW0Zh2DrUkqk4mZdVuq6U7LaF25PmWI6uD6NwlU7ZzZgqyF0oqsAse
        Wi7m2c5LTXO9h39hPk8Gy8TiFoqJWLXr3LzxeGDBoJGsK1lA4k+6JO5FZBu4sAF5
        efPRGtAW6ihOcF0jLvp1gWuYs0yOnf6ifFo+jygsDh818Gb+7NSFeIoaSPAhAB0d
        a4r4oNdqs+VqIp2tMrffdT2kydXd6sCvvZ1fh1+ouH1o0s4gGkzFOHPmWh8+HsXV
        IRGN/D/hPILyLAgyaZ/VY4x4bxExhgVIg+A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OgkDrErTV4QD for <linux-block@vger.kernel.org>;
        Wed,  1 Jun 2022 08:08:30 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LCswY5DfPz1Rvlc;
        Wed,  1 Jun 2022 08:08:29 -0700 (PDT)
Message-ID: <cadb5688-cfba-3311-52d4-533f6afab96e@opensource.wdc.com>
Date:   Thu, 2 Jun 2022 00:08:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] block: fix default IO priority handling again
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <20220601132347.13543-1-jack@suse.cz>
 <20220601145110.18162-3-jack@suse.cz>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220601145110.18162-3-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/06/01 23:51, Jan Kara wrote:
> Commit e70344c05995 ("block: fix default IO priority handling")
> introduced an inconsistency in get_current_ioprio() that tasks without
> IO context return IOPRIO_DEFAULT priority while tasks with freshly
> allocated IO context will return 0 (IOPRIO_CLASS_NONE/0) IO priority.
> Tasks without IO context used to be rare before 5a9d041ba2f6 ("block:
> move io_context creation into where it's needed") but after this commit
> they became common because now only BFQ IO scheduler setups task's IO
> context. Similar inconsistency is there for get_task_ioprio() so this
> inconsistency is now exposed to userspace and userspace will see
> different IO priority for tasks operating on devices with BFQ compared
> to devices without BFQ. Furthemore the changes done by commit
> e70344c05995 change the behavior when no IO priority is set for BFQ IO
> scheduler which is also documented in ioprio_set(2) manpage - namely
> that tasks without set IO priority will use IO priority based on their
> nice value.
> 
> So make sure we default to IOPRIO_CLASS_NONE as used to be the case
> before commit e70344c05995. Also cleanup alloc_io_context() to
> explicitely set this IO priority for the allocated IO context.
> 
> Fixes: e70344c05995 ("block: fix default IO priority handling")
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  block/blk-ioc.c        | 2 ++
>  include/linux/ioprio.h | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index df9cfe4ca532..63fc02042408 100644
> --- a/block/blk-ioc.c
> +++ b/block/blk-ioc.c
> @@ -247,6 +247,8 @@ static struct io_context *alloc_io_context(gfp_t gfp_flags, int node)
>  	INIT_HLIST_HEAD(&ioc->icq_list);
>  	INIT_WORK(&ioc->release_work, ioc_release_fn);
>  #endif
> +	ioc->ioprio = IOPRIO_DEFAULT;
> +
>  	return ioc;
>  }
>  
> diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
> index 774bb90ad668..d9dc78a15301 100644
> --- a/include/linux/ioprio.h
> +++ b/include/linux/ioprio.h
> @@ -11,7 +11,7 @@
>  /*
>   * Default IO priority.
>   */
> -#define IOPRIO_DEFAULT	IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_BE_NORM)
> +#define IOPRIO_DEFAULT	IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0)

"man ioprio_set" says:

IOPRIO_CLASS_BE (2)
This is the best-effort scheduling class, which is the default for any process
that hasn't set  a  specific I/O  priority.

Which is why patch e70344c05995 introduced IOPRIO_DEFAULT definition using the
BE class, to have the kernel in sync with the manual.

The different ioprio leading to no BIO merging is definitely a problem but this
patch is not really fixing anything in my opinion. It simply gets back to the
previous "all 0s" ioprio initialization, which do not show the places where we
actually have missing ioprio initialization to IOPRIO_DEFAULT.

Isn't it simply that IOPRIO_DEFAULT should be set as the default for any bio
being allocated (in bio_alloc ?) before it is setup and inherits the user io
priority ? Otherwise, the bio io prio is indeed IOPRIO_CLASS_NONE/0 and changing
IOPRIO_DEFAULT to that value removes the differences you observed.

>  
>  /*
>   * Check that a priority value has a valid class.


-- 
Damien Le Moal
Western Digital Research
