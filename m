Return-Path: <SRS0=5K92=V6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC331C32750
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 08:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D1C20644
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 08:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404117AbfHBIZI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Aug 2019 04:25:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:39662 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726164AbfHBIZH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Aug 2019 04:25:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 493B7AE6D;
        Fri,  2 Aug 2019 08:25:06 +0000 (UTC)
Subject: Re: [PATCH V2 2/4] blk-zoned: implement REQ_OP_ZONE_RESET_ALL
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     bvanassche@acm.org, osandov@fb.com, dennisszhou@gmail.com,
        sagi@grimberg.me, axboe@kernel.dk, dennis@kernel.org,
        tj@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com,
        ming.lei@redhat.com, Hannes Reinecke <hare@suse.com>,
        jthumshirn@suse.de, damien.lemoal@wdc.com
References: <20190801172638.4060-1-chaitanya.kulkarni@wdc.com>
 <20190801172638.4060-3-chaitanya.kulkarni@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 mQINBE6KyREBEACwRN6XKClPtxPiABx5GW+Yr1snfhjzExxkTYaINHsWHlsLg13kiemsS6o7
 qrc+XP8FmhcnCOts9e2jxZxtmpB652lxRB9jZE40mcSLvYLM7S6aH0WXKn8bOqpqOGJiY2bc
 6qz6rJuqkOx3YNuUgiAxjuoYauEl8dg4bzex3KGkGRuxzRlC8APjHlwmsr+ETxOLBfUoRNuE
 b4nUtaseMPkNDwM4L9+n9cxpGbdwX0XwKFhlQMbG3rWA3YqQYWj1erKIPpgpfM64hwsdk9zZ
 QO1krgfULH4poPQFpl2+yVeEMXtsSou915jn/51rBelXeLq+cjuK5+B/JZUXPnNDoxOG3j3V
 VSZxkxLJ8RO1YamqZZbVP6jhDQ/bLcAI3EfjVbxhw9KWrh8MxTcmyJPn3QMMEp3wpVX9nSOQ
 tzG72Up/Py67VQe0x8fqmu7R4MmddSbyqgHrab/Nu+ak6g2RRn3QHXAQ7PQUq55BDtj85hd9
 W2iBiROhkZ/R+Q14cJkWhzaThN1sZ1zsfBNW0Im8OVn/J8bQUaS0a/NhpXJWv6J1ttkX3S0c
 QUratRfX4D1viAwNgoS0Joq7xIQD+CfJTax7pPn9rT////hSqJYUoMXkEz5IcO+hptCH1HF3
 qz77aA5njEBQrDRlslUBkCZ5P+QvZgJDy0C3xRGdg6ZVXEXJOQARAQABtCpIYW5uZXMgUmVp
 bmVja2UgKFN1U0UgTGFicykgPGhhcmVAc3VzZS5kZT6JAkEEEwECACsCGwMFCRLMAwAGCwkI
 BwMCBhUIAgkKCwQWAgMBAh4BAheABQJOisquAhkBAAoJEGz4yi9OyKjPOHoQAJLeLvr6JNHx
 GPcHXaJLHQiinz2QP0/wtsT8+hE26dLzxb7hgxLafj9XlAXOG3FhGd+ySlQ5wSbbjdxNjgsq
 FIjqQ88/Lk1NfnqG5aUTPmhEF+PzkPogEV7Pm5Q17ap22VK623MPaltEba+ly6/pGOODbKBH
 ak3gqa7Gro5YCQzNU0QVtMpWyeGF7xQK76DY/atvAtuVPBJHER+RPIF7iv5J3/GFIfdrM+wS
 BubFVDOibgM7UBnpa7aohZ9RgPkzJpzECsbmbttxYaiv8+EOwark4VjvOne8dRaj50qeyJH6
 HLpBXZDJH5ZcYJPMgunghSqghgfuUsd5fHmjFr3hDb5EoqAfgiRMSDom7wLZ9TGtT6viDldv
 hfWaIOD5UhpNYxfNgH6Y102gtMmN4o2P6g3UbZK1diH13s9DA5vI2mO2krGz2c5BOBmcctE5
 iS+JWiCizOqia5Op+B/tUNye/YIXSC4oMR++Fgt30OEafB8twxydMAE3HmY+foawCpGq06yM
 vAguLzvm7f6wAPesDAO9vxRNC5y7JeN4Kytl561ciTICmBR80Pdgs/Obj2DwM6dvHquQbQrU
 Op4XtD3eGUW4qgD99DrMXqCcSXX/uay9kOG+fQBfK39jkPKZEuEV2QdpE4Pry36SUGfohSNq
 xXW+bMc6P+irTT39VWFUJMcSuQINBE6KyREBEACvEJggkGC42huFAqJcOcLqnjK83t4TVwEn
 JRisbY/VdeZIHTGtcGLqsALDzk+bEAcZapguzfp7cySzvuR6Hyq7hKEjEHAZmI/3IDc9nbdh
 EgdCiFatah0XZ/p4vp7KAelYqbv8YF/ORLylAdLh9rzLR6yHFqVaR4WL4pl4kEWwFhNSHLxe
 55G56/dxBuoj4RrFoX3ynerXfbp4dH2KArPc0NfoamqebuGNfEQmDbtnCGE5zKcR0zvmXsRp
 qU7+caufueZyLwjTU+y5p34U4PlOO2Q7/bdaPEdXfpgvSpWk1o3H36LvkPV/PGGDCLzaNn04
 BdiiiPEHwoIjCXOAcR+4+eqM4TSwVpTn6SNgbHLjAhCwCDyggK+3qEGJph+WNtNU7uFfscSP
 k4jqlxc8P+hn9IqaMWaeX9nBEaiKffR7OKjMdtFFnBRSXiW/kOKuuRdeDjL5gWJjY+IpdafP
 KhjvUFtfSwGdrDUh3SvB5knSixE3qbxbhbNxmqDVzyzMwunFANujyyVizS31DnWC6tKzANkC
 k15CyeFC6sFFu+WpRxvC6fzQTLI5CRGAB6FAxz8Hu5rpNNZHsbYs9Vfr/BJuSUfRI/12eOCL
 IvxRPpmMOlcI4WDW3EDkzqNAXn5Onx/b0rFGFpM4GmSPriEJdBb4M4pSD6fN6Y/Jrng/Bdwk
 SQARAQABiQIlBBgBAgAPBQJOiskRAhsMBQkSzAMAAAoJEGz4yi9OyKjPgEwQAIP/gy/Xqc1q
 OpzfFScswk3CEoZWSqHxn/fZasa4IzkwhTUmukuIvRew+BzwvrTxhHcz9qQ8hX7iDPTZBcUt
 ovWPxz+3XfbGqE+q0JunlIsP4N+K/I10nyoGdoFpMFMfDnAiMUiUatHRf9Wsif/nT6oRiPNJ
 T0EbbeSyIYe+ZOMFfZBVGPqBCbe8YMI+JiZeez8L9JtegxQ6O3EMQ//1eoPJ5mv5lWXLFQfx
 f4rAcKseM8DE6xs1+1AIsSIG6H+EE3tVm+GdCkBaVAZo2VMVapx9k8RMSlW7vlGEQsHtI0FT
 c1XNOCGjaP4ITYUiOpfkh+N0nUZVRTxWnJqVPGZ2Nt7xCk7eoJWTSMWmodFlsKSgfblXVfdM
 9qoNScM3u0b9iYYuw/ijZ7VtYXFuQdh0XMM/V6zFrLnnhNmg0pnK6hO1LUgZlrxHwLZk5X8F
 uD/0MCbPmsYUMHPuJd5dSLUFTlejVXIbKTSAMd0tDSP5Ms8Ds84z5eHreiy1ijatqRFWFJRp
 ZtWlhGRERnDH17PUXDglsOA08HCls0PHx8itYsjYCAyETlxlLApXWdVl9YVwbQpQ+i693t/Y
 PGu8jotn0++P19d3JwXW8t6TVvBIQ1dRZHx1IxGLMn+CkDJMOmHAUMWTAXX2rf5tUjas8/v2
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <25a389c9-88d7-43b8-44da-61331143a2b4@suse.de>
Date:   Fri, 2 Aug 2019 10:25:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190801172638.4060-3-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/1/19 7:26 PM, Chaitanya Kulkarni wrote:
> This implements REQ_OP_ZONE_RESET_ALL as a special case of the block
> device zone reset operations where we just simply issue bio with the
> newly introduced req op.
> 
> We issue this req op when the number of sectors is equal to the device's
> partition's number of sectors and device has no partitions.
> 
> We also add support so that blk_op_str() can print the new reset-all
> zone operation.
> 
> This patch also adds a generic make request check for newly
> introduced REQ_OP_ZONE_RESET_ALL req_opf. We simply return error
> when queue is zoned and reset-all flag is not set for
> REQ_OP_ZONE_RESET_ALL.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  block/blk-core.c  |  5 +++++
>  block/blk-zoned.c | 39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index d0cc6e14d2f0..1b53ab56228b 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -129,6 +129,7 @@ static const char *const blk_op_name[] = {
>  	REQ_OP_NAME(DISCARD),
>  	REQ_OP_NAME(SECURE_ERASE),
>  	REQ_OP_NAME(ZONE_RESET),
> +	REQ_OP_NAME(ZONE_RESET_ALL),
>  	REQ_OP_NAME(WRITE_SAME),
>  	REQ_OP_NAME(WRITE_ZEROES),
>  	REQ_OP_NAME(SCSI_IN),

I wonder if this shouldn't be moved to the previous patch ...

> @@ -931,6 +932,10 @@ generic_make_request_checks(struct bio *bio)
>  		if (!blk_queue_is_zoned(q))
>  			goto not_supported;
>  		break;
> +	case REQ_OP_ZONE_RESET_ALL:
> +		if (!blk_queue_is_zoned(q) || !blk_queue_zone_resetall(q))
> +			goto not_supported;
> +		break;
>  	case REQ_OP_WRITE_ZEROES:
>  		if (!q->limits.max_write_zeroes_sectors)
>  			goto not_supported;
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 6c503824ba3f..4bc5f260248a 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -202,6 +202,42 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
>  }
>  EXPORT_SYMBOL_GPL(blkdev_report_zones);
>  
> +/*
> + * Special case of zone reset operation to reset all zones in one command,
> + * useful for applications like mkfs.
> + */
> +static int __blkdev_reset_all_zones(struct block_device *bdev, gfp_t gfp_mask)
> +{
> +	struct bio *bio = bio_alloc(gfp_mask, 0);
> +	int ret;
> +
> +	/* across the zones operations, don't need any sectors */
> +	bio_set_dev(bio, bdev);
> +	bio_set_op_attrs(bio, REQ_OP_ZONE_RESET_ALL, 0);
> +
> +	ret = submit_bio_wait(bio);
> +	bio_put(bio);
> +
> +	return ret;
> +}
> +
> +static inline bool blkdev_allow_reset_all_zones(struct block_device *bdev,
> +						sector_t nr_sectors)
> +{
> +	if (!blk_queue_zone_resetall(bdev_get_queue(bdev)))
> +		return false;
> +
> +	if (nr_sectors != part_nr_sects_read(bdev->bd_part))
> +		return false;
> +	/*
> +	 * REQ_OP_ZONE_RESET_ALL can be executed only if the block device is
> +	 * the entire disk, that is, if the blocks device start offset is 0 and
> +	 * its capacity is the same as the entire disk.
> +	 */
> +	return get_start_sect(bdev) == 0 &&
> +	       part_nr_sects_read(bdev->bd_part) == get_capacity(bdev->bd_disk);
> +}
> +
>  /**
>   * blkdev_reset_zones - Reset zones write pointer
>   * @bdev:	Target block device
> @@ -235,6 +271,9 @@ int blkdev_reset_zones(struct block_device *bdev,
>  		/* Out of range */
>  		return -EINVAL;
>  
> +	if (blkdev_allow_reset_all_zones(bdev, nr_sectors))
> +		return  __blkdev_reset_all_zones(bdev, gfp_mask);
> +
>  	/* Check alignment (handle eventual smaller last zone) */
>  	zone_sectors = blk_queue_zone_sectors(q);
>  	if (sector & (zone_sectors - 1))
> 
But anyway:

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
