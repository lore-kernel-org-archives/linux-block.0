Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394D9C54EBE
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 23:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjAIXhi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 18:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238098AbjAIXhF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 18:37:05 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71E1DE4
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 15:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673307421; x=1704843421;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r83Nnsqu9M/kvqBLJIckjjV6WwcBVbCR6ow75bb1Zzk=;
  b=VyCs93fhljTuo6GzlTnylMRk/q4IoVNmQSsiYxxodrY17kWdUBjnYWd/
   3E6oud7DpJQFgfeX8i5E0AovIBSRDbJUIird3wnYAC91qSg04NLqtorKq
   uFftzeXamLeEWCUZkVKouGTlLvrQ+jIOIa4Dg51PwR6oC+TAkOKTCC6z6
   /wmOIdhSusS6dfqNZgWZEHFnyeD+yb1U7JgvLLzWycmK41OjmVoM0jyOz
   OiDZ3IbEJhIsI3dxrwqjCohSf/O5WwLKbwuRXfZm9RLlMY9OBRWc69kp/
   uwcselnXBfdsYbbu3i9gR0HPp8IEudOyLllkOlhfxZGxsjUuQan2ohx3E
   w==;
X-IronPort-AV: E=Sophos;i="5.96,313,1665417600"; 
   d="scan'208";a="332395591"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 07:37:01 +0800
IronPort-SDR: BfjqRABABcbaHKfopZVqLQQ4PmltKkNJIIGD1YRGI9BBGIcCB1zbCCC1/TKJJOmO74aWvOB9G0
 1jMLyBarDyneGQtH/monV+0F2wn537FREqejw51cTZ3OQje4VavtNsBMVVa3JvU3ex7QizhYT5
 Zh3LFsuz1yqEKMn2xQiejvUOQwkFplapSgRZ/thko7WRsqQf8fGBVcFVHNl0T20LIwaDJVkzFV
 GmREOD1Unp2gL9XYCvrtxy5R86I5c9TxL15xDgdlJ5hVrctU9c0lbvbBkurtJiB/n0c2pSZFcQ
 i3o=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2023 14:54:52 -0800
IronPort-SDR: nAFxkdXCt72U9GD+NfFLnPAe6b76VKeHXYG6Lk2CuXAsFAatAA1BclkaPzQ7H66Ej0THzaZzlV
 CO4Ya8hcJRm8+pQVGPTSxwm7yoeTfO3Oia+84snZOigJS442H5edezf6ZfErf4AInspHtb1chx
 S8fEq+FQAGOySsfV+g4+NbtRzs/PFWDkWo6ZDvM7cUH28V4++5RNYVbgfQ7WBvEZJrtcGA9iif
 hr8IIyhQ0J2PamYa8UkT+Hfazi3Dv9qczXWWJJXsGM20GJDjoGSxa+LwIg1zW+L6xD4iE+F93F
 tKA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2023 15:37:03 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NrVhs2w7Kz1Rwrq
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 15:37:01 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673307420; x=1675899421; bh=r83Nnsqu9M/kvqBLJIckjjV6WwcBVbCR6ow
        75bb1Zzk=; b=oPXywDiD6XYFt145ZRUZL1nKuyJ5fA5+kqXJbgZ0qVwbNwfq5di
        AigyDFUAJmj0dv2ogkZskPcfnlNj/mp8u9XjfNLv1eskiafy5ltu9Hd272Yke+su
        e9i8/8HidscMQ/hYdOgLeqXfqieijVmdOroexU8qQXC1o++4X2EAAJMjPXTmiRfU
        IEtD+tUcmUiOzFGOSR0myoK8O/PXyj6yejnIpRvyeq0r4AhsUYatuW95+H94Tp9K
        hlGF8jY6A91c88UrvG/OAbO78zhSS1Yynm33gTFyWjzK7Q4q81MBs0UGdWPSO4gq
        OSV851qqHA/7SYfeWjiG1qGAuJSIKzrJSrw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MZHIhppeYfXP for <linux-block@vger.kernel.org>;
        Mon,  9 Jan 2023 15:37:00 -0800 (PST)
Received: from [10.225.163.12] (unknown [10.225.163.12])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NrVhr06vVz1RvLy;
        Mon,  9 Jan 2023 15:36:59 -0800 (PST)
Message-ID: <ecf73d9b-812d-3e35-7c45-61950f6ce1c4@opensource.wdc.com>
Date:   Tue, 10 Jan 2023 08:36:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/8] block: Document blk_queue_zone_is_seq() and
 blk_rq_zone_is_seq()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>
References: <20230109232738.169886-1-bvanassche@acm.org>
 <20230109232738.169886-2-bvanassche@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230109232738.169886-2-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/10/23 08:27, Bart Van Assche wrote:
> Since it is nontrivial to figure out how disk_zone_is_seq() and
> blk_rq_zone_is_seq() handle sequential write preferred zones, document
> this.
> 
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  include/linux/blk-mq.h | 7 +++++++
>  include/linux/blkdev.h | 9 +++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 779fba613bd0..6735db1ad24d 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -1155,6 +1155,13 @@ static inline unsigned int blk_rq_zone_no(struct request *rq)
>  	return disk_zone_no(rq->q->disk, blk_rq_pos(rq));
>  }
>  
> +/**
> + * blk_rq_zone_is_seq() - Whether a request is for a sequential zone.
> + * @rq: Request pointer.
> + *
> + * Return: true if and only if blk_rq_pos(@rq) refers either to a sequential
> + * write required or to a sequential write preferred zone.

May be change this to "...blk_rq_pos(@rq) is targeting either a sequential
write required zone or a sequential write preferred zone."

> + */
>  static inline unsigned int blk_rq_zone_is_seq(struct request *rq)
>  {
>  	return disk_zone_is_seq(rq->q->disk, blk_rq_pos(rq));
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index b87ed829ab94..ef93e848b1fd 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -672,6 +672,15 @@ static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
>  	return sector >> ilog2(disk->queue->limits.chunk_sectors);
>  }
>  
> +/**
> + * disk_zone_is_seq() - Whether a logical block is in a sequential zone.
> + * @disk: Disk pointer.
> + * @sector: Offset from start of block device in 512 byte units.
> + *
> + * Return: true if and only if @disk refers to a zoned block device and
> + * @sector refers either to a sequential write required or a sequential
> + * write preferred zone.

May be change this to "...and @sector is contained either in a sequential
write required zone or a sequential write preferred zone."

> + */
>  static inline bool disk_zone_is_seq(struct gendisk *disk, sector_t sector)
>  {
>  	if (!blk_queue_is_zoned(disk->queue))

With that fixed,

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

