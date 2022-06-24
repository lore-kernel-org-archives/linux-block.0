Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D52C43334
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 00:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiFXATn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 20:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiFXATm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 20:19:42 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6172B5DC1B
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 17:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656029982; x=1687565982;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VVrLpZ1DQDIlZPtz67Ui7YNmHGN+YD4bydF/8n1O8tc=;
  b=PeLSm3VWWoFkWMd4hzkeb5ltfxua/LoBX1PKKmG8mn177ABJq+av3Qmm
   MGUQf+XVwNTT0js8Xo76hRLJMuefDzKl7mZ08gOQGkpiUaumdqIDu71zx
   vl3dIfqzdd//thrsfl1pJuIyqaPfzac4KV/Pm3WVO95882787pwpFtJt7
   K2ByKSnOXdveUiTgqCkZ5xNgmd3i6miUQ4HOUi/A3QwigjUnjv3V9j/Dj
   972FUhnh3tiXblOg1yT2dQIYmkLzlbJJCkI6kJ6gbfp2JSc85LK+eYouS
   TUxT7ClNCBIzhNMc4/3k+EPlbFCgt79AGqOnOi6BYEUGP0Y7O5ivWSQHF
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,217,1650902400"; 
   d="scan'208";a="204716475"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2022 08:19:41 +0800
IronPort-SDR: TgSixXX1xI4oRR481oqa2HHhylSMkHsGgeVe/rw+wsH8/qahnWzX34rNNTD9GlcFO/3x8+wHmK
 zjSSapHjfnw82eNFosyzFsKGhVcMUKW3+oRcBTkfyYrXwTYuBJf7kVZeNYZv9NLYzVDfDWLlpr
 XFx7QERKfxuHHW4I1XVyQfr0LtfUqkCYyjqmzB+DMILLkarD6Va2I8zhEQJyvDeeStgov+ZjWR
 XYegzbAUfyrQcrEsJZO7/Uh3D7HJl1OJXE0Z2u/6ZXN2m4Ubxf1A0hhaY9PprBCATk3ntzMjQh
 hl4BqVyhKCQF1KLcwYZhDXzq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 16:37:26 -0700
IronPort-SDR: 2tqXsmLT8jws/krxkT1xXzxIGhUU1QRyuevaohgfwSC3sX0Y5CGgLrI75bhnaxbjie7VXOx1j6
 Qf0XWjH5f2bUiaIFqVfPjEWRkM6nSe5SzcpnLhAmQtklyn9v9BhSuCx6QawZu4QQvR3EyLQh+K
 UIoJ6PgB7XThCbPcDbE2q9ughg9bUP1ZNfbN2IUen2f7F6E4zW4RFTmZxClp78/d51SYVhF1Eo
 HEIsRyJYb43OUF14G9A4AeEPXKg34Acr1pXcgwlIxFfU8E8UAa4NaLeplqaBqhXDPsgay7AfgQ
 u3Y=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 17:19:40 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LTd6N1zjCz1Rwnm
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 17:19:40 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656029979; x=1658621980; bh=VVrLpZ1DQDIlZPtz67Ui7YNmHGN+YD4bydF
        /8n1O8tc=; b=JgHczfUbA+5x5ZUlEOCUAyTFFWyvBEZRGWscjgC5tIzK4jMNnn1
        rYS6S8Cw1fSEW8AlDduEd1q0Bxz4Ov0COfvMgkb2Vjr8IQJfzEPNkpVdh6s1lW1I
        AYIPPZhnDMLWmrh7H2/hpqRlH7cwqBwNC/0V/Siy76KF5JNoJ4zf9olFosLLYLy5
        xRuh90hRW9TosNMTM4sA+GtHuxAPGpG6C5V3pnVXy8iK4W/5vxC50UyACMgCYNSI
        Tva32e9NlWidn/TLJBUl4Q4TrkqvX+PeFmnxcBB0MiVQii8XXYpljd8MD1dp19aJ
        3CYRmilsLd0C5baprQ9VQkRPvOBXG3FOtNw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 26rovVNc0kx6 for <linux-block@vger.kernel.org>;
        Thu, 23 Jun 2022 17:19:39 -0700 (PDT)
Received: from [10.225.163.93] (unknown [10.225.163.93])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LTd6L5028z1RtVk;
        Thu, 23 Jun 2022 17:19:38 -0700 (PDT)
Message-ID: <3dff0f28-587e-c6f6-474e-718dc999be3a@opensource.wdc.com>
Date:   Fri, 24 Jun 2022 09:19:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 3/6] block: Introduce a request queue flag for
 pipelining zoned writes
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20220623232603.3751912-1-bvanassche@acm.org>
 <20220623232603.3751912-4-bvanassche@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220623232603.3751912-4-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/24/22 08:26, Bart Van Assche wrote:
> Writes in sequential write required zones must happen at the write
> pointer. Even if the submitter of the write commands (e.g. a filesystem)
> submits writes for sequential write required zones in order, the block
> layer or the storage controller may reorder these write commands.
> 
> The zone locking mechanism in the mq-deadline I/O scheduler serializes
> write commands for sequential zones. Some but not all storage controllers
> require this serialization. Introduce a new flag such that block drivers
> can request pipelining of writes for sequential write required zones.
> 
> An example of a storage controller standard that requires write
> serialization is AHCI (Advanced Host Controller Interface). Submitting
> commands to AHCI controllers happens by writing a bit pattern into a
> register. Each set bit corresponds to an active command. This mechanism
> does not preserve command ordering information.
> 
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  include/linux/blkdev.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 2904100d2485..fcaa06b9c65a 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -581,6 +581,8 @@ struct request_queue {
>  #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
>  #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
>  #define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
> +/* Writes for sequential write required zones may be pipelined. */
> +#define QUEUE_FLAG_PIPELINE_ZONED_WRITES 31
>  
>  #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
>  				 (1 << QUEUE_FLAG_SAME_COMP) |		\
> @@ -624,6 +626,11 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
>  #define blk_queue_nowait(q)	test_bit(QUEUE_FLAG_NOWAIT, &(q)->queue_flags)
>  #define blk_queue_sq_sched(q)	test_bit(QUEUE_FLAG_SQ_SCHED, &(q)->queue_flags)
>  
> +static inline bool blk_queue_pipeline_zoned_writes(struct request_queue *q)
> +{
> +	return test_bit(QUEUE_FLAG_PIPELINE_ZONED_WRITES, &(q)->queue_flags);
> +}
> +

Since this flag will be set by an LLD to indicate that the LLD can handle
zoned write commands in order, I would suggest a different name. Something
like: QUEUE_FLAG_ORDERED_ZONED_WRITES ? And well, if the LLD says it can
do that for zoned writes, it likely means that it would be the same for
any command, so the flag could be generalized and named
QUEUE_FLAG_ORDERED_CMD or something like that.

>  extern void blk_set_pm_only(struct request_queue *q);
>  extern void blk_clear_pm_only(struct request_queue *q);
>  


-- 
Damien Le Moal
Western Digital Research
