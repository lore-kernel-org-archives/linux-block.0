Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752D8C433EF
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 00:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiFXAK6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 20:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFXAK5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 20:10:57 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151205D103
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 17:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656029456; x=1687565456;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KT02orYlnD94eaX4GVyV1h6GM+pvoAGs0x7JE1ciOW0=;
  b=g/P9nrID6EOCaEJatwDm3e4cxTwvj0xI9NMspN3poVjFUAxRqgr8Ma/U
   tj1HpUm83X+wppv9zffuBKVKyrJOmO/+9TSg4ROsKWMIGjvQlDR6Uj5N8
   /wEx1Q1dGHGdVXjnNtPRo1zeif5WqTURihA7LJs7vXB3zVoFlX27GaVAY
   JC/M1EkGZEd2xrp7SRQIuJ67MmESKH6Y/faakBbm3I+xhpoA7EltGd6rK
   8fj3mZGwveHdKNiFcACnRm7jrPOjaAZUsJA3vauO8BSozSCb43KAY9Wjd
   FIAAfDWgOp5U943P9CHtg4zir7ymM2OLnZNW6+/Twy6DnYL3HTxsfizl3
   g==;
X-IronPort-AV: E=Sophos;i="5.92,217,1650902400"; 
   d="scan'208";a="208831501"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2022 08:10:56 +0800
IronPort-SDR: z7ZXVUPwIJnYxQZE0K45Id+ZBrTfGV8jtteBv/yuMFEvyLSqMg8JXJCsnobCvN0gJNg1INMl8a
 MS2O8RV4gmHBMn7B0r8+W8JC90LyDzCs7q4uQ9s6sN0xLdd+jIj+FNeh402F+QhSGpIB2XyqfU
 6NUZib9wvHXpov+m1yOK8/Ud7hkVxA5pgxHXM5Kme486RPYafJ9BSWqCoRqxXsYGQEfCyvESPG
 LMflLuDbOmYTa9AXLrMDe4yJH9mThhLEd4Zfigc/AcXNhTzWXRR0ZgMUvJlqdhkxzqY/Vws7hf
 jRMjosRM1HnxCDzqy2qBTUrV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 16:28:41 -0700
IronPort-SDR: AsU+t9BYUREtXRbB8cTRdOwmE+rX8nzYJ2dElzuS3aWWABU0QXBgOLf/s6WdSPQIRLQuVvoZx2
 l23y7YoZRzUNha4c25/Q+ZgFv3HKbsD3Q9gEonzovHmRkRqxBWS29ADMq+z0AK1GSJtMh6CTgt
 N096QiHSnFSvFcAkuMFRyqJ1M1OPbemsngzEelpcXyJriXoTBBo/KFJ5kXlQp2+h668BYT6Zd/
 5cJBx2OxCFIXOrl68fCE/0zx/0RHVHmcfqHEaP0ijYGCJdeRy1wsHIbW9G3aYlkqc8IxN6lKqQ
 mvI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 17:10:57 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LTcwJ0Fnkz1Rwnx
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 17:10:56 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656029455; x=1658621456; bh=KT02orYlnD94eaX4GVyV1h6GM+pvoAGs0x7
        JE1ciOW0=; b=OWxgJ5V5ysEuXZzy1u+IkOq/9AJRbouOrL6VjmPkObijg0xFJcQ
        JXPQSXZ+fGmNitdBYtrFjsZyHFApd7Zy1g/HmBXtXDUa30HIY8GtBbjFEtGWupgD
        iHBIu+OAi/A2QBMyFV2AoDlSsUO/jgZlhItwLwFrQGBFYiqj77kAxaSzkYxaiP3U
        xru/EjAVuk+00wWD595kB/+iBFFzTnZfTzrJoDI+Z3D1euVI7aDWTLjj0q6FxWgS
        Db5BdONgvzcCFSCSbXi8eflRJLMa5tGitQGfsvGLKHhsnL0mds1JyHI/LOEKpKGV
        Jyj+sOADz8Rc2LBmooD9AIYDyd35zDWNU5w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DxlHrqAn7rPn for <linux-block@vger.kernel.org>;
        Thu, 23 Jun 2022 17:10:55 -0700 (PDT)
Received: from [10.225.163.93] (unknown [10.225.163.93])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LTcwG3fdbz1RtVk;
        Thu, 23 Jun 2022 17:10:54 -0700 (PDT)
Message-ID: <08b2ed02-d0b6-4dbb-a944-7ff2d91724a7@opensource.wdc.com>
Date:   Fri, 24 Jun 2022 09:10:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/6] block: Document blk_queue_zone_is_seq() and
 blk_rq_zone_is_seq()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20220623232603.3751912-1-bvanassche@acm.org>
 <20220623232603.3751912-2-bvanassche@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220623232603.3751912-2-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/24/22 08:25, Bart Van Assche wrote:
> Since it is nontrivial to figure out how blk_queue_zone_is_seq() and
> blk_rq_zone_is_seq() handle sequential write preferred zones, document
> this.
> 
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  include/linux/blk-mq.h | 7 +++++++
>  include/linux/blkdev.h | 9 +++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index e2d9daf7e8dd..909d47e34b7c 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -1124,6 +1124,13 @@ static inline unsigned int blk_rq_zone_no(struct request *rq)
>  	return blk_queue_zone_no(rq->q, blk_rq_pos(rq));
>  }
>  
> +/**
> + * blk_rq_zone_is_seq() - Whether a request is for a sequential zone.
> + * @rq: Request pointer.
> + *
> + * Return: true if and only if blk_rq_pos(@rq) refers either to a sequential
> + * write required or a sequential write preferred zone.
> + */
>  static inline unsigned int blk_rq_zone_is_seq(struct request *rq)
>  {
>  	return blk_queue_zone_is_seq(rq->q, blk_rq_pos(rq));
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 92b3bffad328..2904100d2485 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -688,6 +688,15 @@ static inline unsigned int blk_queue_zone_no(struct request_queue *q,
>  	return sector >> ilog2(q->limits.chunk_sectors);
>  }
>  
> +/**
> + * blk_queue_zone_is_seq() - Whether a logical block is in a sequential zone.
> + * @q: Request queue pointer.
> + * @sector: Offset from start of block device in 512 byte units.
> + *
> + * Return: true if and only if @q is associated with a zoned block device and
> + * @sector refers either to a sequential write required or a sequential write
> + * preferred zone.
> + */
>  static inline bool blk_queue_zone_is_seq(struct request_queue *q,
>  					 sector_t sector)
>  {


-- 
Damien Le Moal
Western Digital Research
