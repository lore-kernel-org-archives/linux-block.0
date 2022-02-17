Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E09AC433EF
	for <linux-block@archiver.kernel.org>; Thu, 17 Feb 2022 00:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbiBQAJH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 19:09:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiBQAJH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 19:09:07 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD652A0D5F
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 16:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645056533; x=1676592533;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dN0Dme1pLGy6NKqKSX3mGddvFmappVjthUY5anAyBoA=;
  b=V6NX+PoikU6wmryvZ/8J+Ke7IER7+Af8H7xD4WNlK5lhm/b45dS9vuYI
   alLwyhdBmH5K2tDv54cLKrYMcjywRTESnf6Fr6aedLrClHtdAe2zlSXmn
   QyT2Egx0VuBgg6NABNE58FNih4H0k69W0Xllww+7noaxif6CVLko+Hcie
   gyqDy1fOqDQbFTYeUNcG37uhaWhQWT2eAjBMZRzqghmYytMU/H7Nb4ejd
   +j925a0Um6bFQDf3Y2VXLr6lC4672N5Kb1m//+vu++7mPYQZcFHtO+IEL
   /bDlliOAUly9sfrEr19OpdfeFuS3E815Mi+B290VODbnFHkk2j5Cm5SYA
   w==;
X-IronPort-AV: E=Sophos;i="5.88,374,1635177600"; 
   d="scan'208";a="305039253"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2022 08:08:52 +0800
IronPort-SDR: p7879wqsCZkliiCl/gGs7oYjGFx0lp9uD1bGSszUQXwoWYTZRO0rErPD045yZ3+0IRZJbbbUEg
 3MjhR7bA6EmsiDvpu86XIbKKEpr9j/hDFLX8O/YeXeS3Md3Rciptf1QOOFYDLmxO4nUILyeWU4
 117fXpehM6JOOnU2sMphEHAbPtVY9q0MC+PMxvZXP9Gj2iNA2mn2xB0Wzc980caZ9SXKwC8YWt
 bzSEAf7i0JWw4YcU/2V6uT0S1F2brvLBUTHhLcEDbDLHFOqQwNcJSg8z60ceMctzyvERx0/3fm
 bX5HUipmvIRw97/o3sX8UGQW
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 15:41:39 -0800
IronPort-SDR: cTBMIaeRfLIpL0+IBOfcLfvJgnQai2P/XnEZWc00MWMXEHEAbZo6AaeBLmgPrhbM2GvuYii3v7
 yzC7MqUt1Q9LAbadsOCp751lzkexzJuBXfwxxEAPXkEtBJpYLqrgSGV/4IdYk8YjHF5UJa8cIE
 UYivqKLFEGhKJY+dBSM39bxg/slfpKKMeHj2WCcfA/Nm1mROE62mBa8y20Po7lXSZiAtKkKGAh
 VIc6Cj8t1cetI7WYRuJF9r8L57tBxSy8CkHj15S0gEuSbnHdZghVSrBDsoJQifnAxKnIZwyZKh
 8Dg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 16:08:52 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JzZtX2Rt7z1SVp2
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 16:08:52 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645056531; x=1647648532; bh=dN0Dme1pLGy6NKqKSX3mGddvFmappVjthUY
        5anAyBoA=; b=qKbJRg3JTGmipB+IApQGqJGJST8ToDkl/THPMji2MOEALYGySaU
        +vx6Zz+UYeOEaCpqpUNaWzx0ApB+rf97zYx4U2sYh5L3MnXoOf80FlfU5Gs+QuhH
        ipNZ5oALGN4Ei5GQifJEoZLfFPH8F3sricKFfbJuxoHDnTuvAtF+/Tlled504qL1
        wvHdIGueCvGpRzeqP/sKFxGVeXiJ2g+ADJtukjTs0obdK06jy/bcbR4RRDPciZ6y
        hqiOo76gkEGPxjyofa822gtTVAWruLrP4a9pYkUiTkPoDY3V48bqQjlm5B6aSHt8
        TNfv7N+nIo2vBnwOuTxEN4FNdgOj3e+OjEg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MqvGMzrOUDPn for <linux-block@vger.kernel.org>;
        Wed, 16 Feb 2022 16:08:51 -0800 (PST)
Received: from [10.225.163.73] (unknown [10.225.163.73])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JzZtV41qZz1Rwrw;
        Wed, 16 Feb 2022 16:08:50 -0800 (PST)
Message-ID: <97c6e1a0-2526-0b96-8f26-bba5d14d9784@opensource.wdc.com>
Date:   Thu, 17 Feb 2022 09:08:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2 1/1] null_blk: remove hardcoded alloc_cmd() parameter
Content-Language: en-US
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, ming.lei@redhat.com, shinichiro.kawasaki@wdc.com
References: <20220216172945.31124-1-kch@nvidia.com>
 <20220216172945.31124-2-kch@nvidia.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220216172945.31124-2-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/17/22 02:29, Chaitanya Kulkarni wrote:
> Only caller of alloc_cmd() is null_submit_bio() unconditionally sets
> second parameter to true and that is statically hard-coded in null_blk.
> There is no point in having statically hardcoded function parameter.
> 
> Remove the unnecessary parameter can_wait and adjust the code so it
> can retain existing behavior of waiting when we don't get valid
> nullb_cmd from __alloc_cmd() in alloc_cmd().
> 
> The restructured code avoids multiple return statements, multiple
> calls to __alloc_cmd() and resulting a fast path call to
> prepare_to_wait() due to removal of first alloc_cmd() call.
> 
> Follow the pattern that we have in bio_alloc() to set the structure
> members in the structure allocation function in alloc_cmd() and pass
> bio to initialize newly allocated cmd->bio member.
> 
> Follow the pattern in copy_to_nullb() to use result of one function call
> (null_cache_active()) to be used as a parameter to another function call
> (null_insert_page()), use result of alloc_cmd() as a first parameter to
> the null_handle_cmd() in null_submit_bio() function. This allow us to
> remove the local variable cmd on stack in null_submit_bio() that is in
> fast path.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/block/null_blk/main.c | 29 ++++++++++++-----------------
>  1 file changed, 12 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 90b6bd2a114b..29e183719e77 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -720,26 +720,25 @@ static struct nullb_cmd *__alloc_cmd(struct nullb_queue *nq)
>  	return NULL;
>  }
>  
> -static struct nullb_cmd *alloc_cmd(struct nullb_queue *nq, int can_wait)
> +static struct nullb_cmd *alloc_cmd(struct nullb_queue *nq, struct bio *bio)
>  {
>  	struct nullb_cmd *cmd;
>  	DEFINE_WAIT(wait);
>  
> -	cmd = __alloc_cmd(nq);
> -	if (cmd || !can_wait)
> -		return cmd;
> -
>  	do {
> -		prepare_to_wait(&nq->wait, &wait, TASK_UNINTERRUPTIBLE);
> +		/*
> +		 * This avoids multiple return statements, multiple calls to
> +		 * __alloc_cmd() and a fast path call to prepare_to_wait().
> +		 */
>  		cmd = __alloc_cmd(nq);
> -		if (cmd)
> -			break;
> -
> +		if (cmd) {
> +			cmd->bio = bio;
> +			return cmd;
> +		}
> +		prepare_to_wait(&nq->wait, &wait, TASK_UNINTERRUPTIBLE);
>  		io_schedule();
> +		finish_wait(&nq->wait, &wait);
>  	} while (1);
> -
> -	finish_wait(&nq->wait, &wait);
> -	return cmd;
>  }
>  
>  static void end_cmd(struct nullb_cmd *cmd)
> @@ -1477,12 +1476,8 @@ static void null_submit_bio(struct bio *bio)
>  	sector_t nr_sectors = bio_sectors(bio);
>  	struct nullb *nullb = bio->bi_bdev->bd_disk->private_data;
>  	struct nullb_queue *nq = nullb_to_queue(nullb);
> -	struct nullb_cmd *cmd;
> -
> -	cmd = alloc_cmd(nq, 1);
> -	cmd->bio = bio;
>  
> -	null_handle_cmd(cmd, sector, nr_sectors, bio_op(bio));
> +	null_handle_cmd(alloc_cmd(nq, bio), sector, nr_sectors, bio_op(bio));
>  }
>  
>  static bool should_timeout_request(struct request *rq)

I would have preferred the simple while () {} loop I suggested (this do
{ } while (1) is ugly...) but anyway, looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>


-- 
Damien Le Moal
Western Digital Research
