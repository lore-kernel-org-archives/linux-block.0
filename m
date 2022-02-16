Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924A2C433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 10:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiBPKXS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 05:23:18 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbiBPKXR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 05:23:17 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F2365808
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 02:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645006985; x=1676542985;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l4AFwXW7MVNZupf53sqqLCkxfedT33Nz59gVDc8IAhI=;
  b=fj/VF5QfuOCJfQ7kXbe2wUTlJgWQLso0UBppUWQ1xNsqj1CYnUvLdAMk
   zFFsLblz3FasGWXOUOTnOj5ZsFFu1VxMV1q6FqopjLHxxtOryHgp+WYcx
   aAmLVDwpBI1Xdcod8TkUwbEhg+AX3uJrVQ8teLFFkJgvKJNNiiPOvzQss
   lj4MLuBeFgyiV6AmI56Fr+5AEdpSvUIMFhPNgMPojhynmzYzgLuBNG9jF
   aqA2Ecvs02yN38ad5wACZWbdaXPg5x2+W8BKeBtoubdp3+FLF33/y23Uw
   X28Y2Km/yN//QAGMNHfiIOZ4NxWkqAAJZm1I2si4IpxM5NfeaiK2orB+E
   A==;
X-IronPort-AV: E=Sophos;i="5.88,373,1635177600"; 
   d="scan'208";a="194062769"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Feb 2022 18:23:04 +0800
IronPort-SDR: w2kOVNfSBItSP2WJXNcm2DxIDHO4f0xDB5K+QlbWblaWCm87kxDx9UkVcx530jsj9weyYP2KeQ
 Xj9VyarS50qZqDfA2Shrocr/39PVwfAvkB4GlIFDw2HwicYP0WdK9STwt8e4v7MWIlLVCqCUEn
 EitmAMTMt4Zm9OJVk+vmSSWO6Lu7eBxye5eO8gdmLk2bFeWt2vGAkIHkKHtumwCgfXKQURlBPB
 tSyfcNFp8GG8X/485z1/F6qUxboZauWOaCjhI4EGlM0gwY2kjR6Bkaw7f7ni3mZU8pgfWYFMdh
 loO0fkJnoGXakFEteT1Nob+0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 01:54:44 -0800
IronPort-SDR: PvvD3btchuq8bFAt1o+fSXTSmUr9ydZiKy84HUS8gE4g/SEyxQ9nXy332//evVfVffPlgWupKE
 DTzpQv2yQAW/lP4B40bYAVEIMP1v85wjLxnqwEkOig2OiqxujRGL9aH7pPR8+Zf7bonQKWcJj1
 8ylT+KW4VN5QcUO6t1ILRkUMCnQofXQKiE4k0Shv1AtYQ0A+dQmQooL1BR3wszb++PyeYAwyuF
 6gP6f2SVLT/NNyrdoi2tqRDj4CVLvnZ4L9O0q8QpJ0IqxK75EjzUjIzzZj20MAB7crdwjzmCtJ
 Q/A=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 02:23:04 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JzDYg4f6wz1SVp3
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 02:23:03 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645006983; x=1647598984; bh=l4AFwXW7MVNZupf53sqqLCkxfedT33Nz59g
        VDc8IAhI=; b=nOk6KAZFeP68vK36mii76zziT4J21EDyYPFbWSr/PhsR4/ps1r9
        XbTnHIjGbrxeN5sd1lY6Lt/s34IvzordkwkcRfHKRGLVRKaCo605sABVCsZVlJLW
        G3Xw1B0zJ2zjgT14RkTkcoSzUj/dP/e8hFkF66eJIIC5rdqqCHux61jwIj0Ds0e+
        CSnnQsBhAMcVD8PVaRzdGdzAwIaiXNl+ZlpRndexXKaTpDW4gR2MbwRo59IEPFGo
        WGWA91SnuBTJNNXLP7pFJtZpfQFa8MBhog2oYnAyRpKZzfi4Gqdwcw58unbGtzTQ
        G5znwLoPBQ8d1qg824dxuVP/gj9DWcoh/Mg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FJoQT810Kdp9 for <linux-block@vger.kernel.org>;
        Wed, 16 Feb 2022 02:23:03 -0800 (PST)
Received: from [10.225.163.73] (unknown [10.225.163.73])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JzDYf0v32z1Rwrw;
        Wed, 16 Feb 2022 02:23:01 -0800 (PST)
Message-ID: <3ec98d01-6b9e-77d7-aa29-9f7c4ff21d4d@opensource.wdc.com>
Date:   Wed, 16 Feb 2022 19:23:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] null_blk: remove local var & init cmd in alloc_cmd
Content-Language: en-US
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, ming.lei@redhat.com, shinichiro.kawasaki@wdc.com,
        damien.lemoal@wdc.com
References: <20220216093020.175351-1-kch@nvidia.com>
 <20220216093020.175351-3-kch@nvidia.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220216093020.175351-3-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/16/22 18:30, Chaitanya Kulkarni wrote:
> Follow the pattern what we have in bio_alloc() to set the structure

s/what/that

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
>  drivers/block/null_blk/main.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index d78fc3edb22e..e19340f686a8 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -719,7 +719,7 @@ static struct nullb_cmd *__alloc_cmd(struct nullb_queue *nq)
>  	return NULL;
>  }
>  
> -static struct nullb_cmd *alloc_cmd(struct nullb_queue *nq)
> +static struct nullb_cmd *alloc_cmd(struct nullb_queue *nq, struct bio *bio)
>  {
>  	struct nullb_cmd *cmd;
>  	DEFINE_WAIT(wait);
> @@ -730,8 +730,10 @@ static struct nullb_cmd *alloc_cmd(struct nullb_queue *nq)
>  		 * __alloc_cmd() and a fast path call to prepare_to_wait().
>  		 */
>  		cmd = __alloc_cmd(nq);
> -		if (cmd)
> +		if (cmd) {
> +			cmd->bio = bio;
>  			return cmd;
> +		}
>  		prepare_to_wait(&nq->wait, &wait, TASK_UNINTERRUPTIBLE);
>  		io_schedule();
>  		finish_wait(&nq->wait, &wait);
> @@ -1473,12 +1475,8 @@ static void null_submit_bio(struct bio *bio)
>  	sector_t nr_sectors = bio_sectors(bio);
>  	struct nullb *nullb = bio->bi_bdev->bd_disk->private_data;
>  	struct nullb_queue *nq = nullb_to_queue(nullb);
> -	struct nullb_cmd *cmd;
> -
> -	cmd = alloc_cmd(nq);
> -	cmd->bio = bio;
>  
> -	null_handle_cmd(cmd, sector, nr_sectors, bio_op(bio));
> +	null_handle_cmd(alloc_cmd(nq, bio), sector, nr_sectors, bio_op(bio));
>  }
>  
>  static bool should_timeout_request(struct request *rq)

Since patch 1 rewrite this function already, you could squash this patch
into it, replacing the can_wait argument with the bio argument.


-- 
Damien Le Moal
Western Digital Research
