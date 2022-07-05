Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DF4C43334
	for <linux-block@archiver.kernel.org>; Tue,  5 Jul 2022 02:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbiGEC1M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Jul 2022 22:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbiGEC1L (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Jul 2022 22:27:11 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDAB1274E
        for <linux-block@vger.kernel.org>; Mon,  4 Jul 2022 19:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656988030; x=1688524030;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H9XI8GruQ80NCeMld+98UNkxXwXGjKj3wo7+vopk20s=;
  b=auKl5w3+Q6lw6exPV8dvayKEP1LRzZOQ/EfEG9XTP2994JLhmDuiM8gS
   v7V41x7Mhmxo0PTNSM8QZIOi7XlIZ7zsy/fYhwUyghB490QfEqbCJTEXo
   8lJKyVOQFayo5TqIfS1qC7hBfwInUmA9fycnOOW5yLhKu55cyUL9udcL1
   2F8UJ8p+KMurBQvSYWCeVrO1qqbJkZQy1W65Lr5VQ5rlSTf0RC4JaXrEm
   W0vRgJWSw2MLp4VQ/IS7i37rB01E+TZqdILD2/8VqRwusIBzLfmky3PQz
   NTykPxBBXZWV8ZqpCCpzND69Za/yaiy49Cmoy1mL/gu/DpjdnFlX8f+5I
   A==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650902400"; 
   d="scan'208";a="203465172"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2022 10:27:09 +0800
IronPort-SDR: 5Uw/pv+T4mV6NFvkDJYNAyZHGYqAAELorAWN5QV7iY62l6dx7HY6Iqko7Lj7BEuUzW7jTsB9Wu
 c5KMCZAzlpNHtuLcfihsqh8yqADCH9GdoW57nm3Uy5/Y+UIPN1+EFRaHHsfSY5GRGUIT3AWgzD
 4HUVl4hMlpSsWu+b4JQs+QZLViJwwjB+xqqoftfxbK8lGo7N5jB5LmhMm7mTAC3ftKB/ZQFDZj
 8iodwS8zHjXV8vdvxiaEugPsnP8wKPMFOoPLMbe8odU0+BVtOwki9YybxhXUg+7YGHDOAayS+I
 JlUTuBB1BjdKKjS7NnEenJ0X
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 18:49:00 -0700
IronPort-SDR: YCN/KAs9V7MIM6Q1T7qKpFuSnLqsaJ6Rd0lUX6lw9BKcjfw+bqFRfHA4orm+86aW+VIRlMcEF5
 sdB3eAZmi2jaAuCJuu5XGoEiHuWBKjZgdzELbILOD9bj1M22z9EWPMoCXBfmgaIn7ONQ5xT17R
 N4pEUBkR0ug1w3XBsI/uDAkckd4qKIBRBBNx0KMr6XP1JUDlL8AzTELvSsJ0BUy7VC9rwkKkjt
 PIQIAUvkysyXoOkVqY8fBNe4Qda533zIJ2Qnx7iR5Nl2vNmOueCBxvElC1O0PiJFMxdW+bKZHF
 HCw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:27:10 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LcRQP2VbRz1Rw4L
        for <linux-block@vger.kernel.org>; Mon,  4 Jul 2022 19:27:09 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656988028; x=1659580029; bh=H9XI8GruQ80NCeMld+98UNkxXwXGjKj3wo7
        +vopk20s=; b=FykuHavTbjLln/rzw6hHJnsJWiQiK4Bp5Bwd7PXUrGvFyrSqpKy
        /MDqTAPyF74GlvBoR5VH0X3hIYITFUoyFC5HxfLx53PKhbq7QllTG2WxqpsAtuUS
        pqz+nRXfUJew1yl2LLxnDj59Kfwm39JsPwCd3r+RsjB2vbjMw0E+4XDGrVt8+GKY
        j8dm37bkdxm/DAd+AEqiP1AKqwi8nuxfcxfRpxVmi3KaG68vgjJXYyBMPO5RJWwO
        V9ZafDo1BC6f++rTc8MPRZJVg9orOeFc8UWSl5+y59Is8Jk/fXuulk8g9BwUez+o
        yay5SdI7AHLaN6fJ6/xiKfbDJtZiXrzKnCA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dHYCtjtpl-7F for <linux-block@vger.kernel.org>;
        Mon,  4 Jul 2022 19:27:08 -0700 (PDT)
Received: from [10.225.163.105] (unknown [10.225.163.105])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LcRQN0bjRz1RtVk;
        Mon,  4 Jul 2022 19:27:07 -0700 (PDT)
Message-ID: <2938c7b0-aeb5-f540-1c07-58551c449a3c@opensource.wdc.com>
Date:   Tue, 5 Jul 2022 11:27:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 02/17] block: call blk_queue_free_zone_bitmaps from
 disk_release
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20220704124500.155247-1-hch@lst.de>
 <20220704124500.155247-3-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220704124500.155247-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/4/22 21:44, Christoph Hellwig wrote:
> The zone bitmaps are only used for non-passthrough I/O, so free them as
> soon as the disk is released.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-sysfs.c | 2 --
>  block/genhd.c     | 1 +
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 58cb9cb9f48cd..7590810cf13fc 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -776,8 +776,6 @@ static void blk_release_queue(struct kobject *kobj)
>  	blk_free_queue_stats(q->stats);
>  	kfree(q->poll_stat);
>  
> -	blk_queue_free_zone_bitmaps(q);
> -
>  	if (queue_is_mq(q))
>  		blk_mq_release(q);
>  
> diff --git a/block/genhd.c b/block/genhd.c
> index b1fb7e058b9cc..d0bdeb93e922c 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1165,6 +1165,7 @@ static void disk_release(struct device *dev)
>  
>  	disk_release_events(disk);
>  	kfree(disk->random);
> +	blk_queue_free_zone_bitmaps(disk->queue);
>  	xa_destroy(&disk->part_tbl);
>  
>  	disk->queue->disk = NULL;

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
