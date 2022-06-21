Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B88C43334
	for <linux-block@archiver.kernel.org>; Tue, 21 Jun 2022 00:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244840AbiFUABE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 20:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244334AbiFUABD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 20:01:03 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7077113D4A
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 17:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655769661; x=1687305661;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GnJChMROEAiDcxFVp5mm5CesZFms76gSDLuLYoCHrmw=;
  b=fSXz2JqyyWnrllPQociw78FO/+chr6MgMlRfBGiIpBkPpgJR1Av3RjpL
   P0DVFPDf11V9cCrrngd6sbt6QIslKluGuQagTFLqz2YIxKdK3/LTE2T3j
   mRlYfadwtV2OlT+nj1qXiXcs/0pCB6V+kFDBVM5Yd3jaybKCSNXFcD8e2
   BnNzxa96jhGg47YVCxOgLplOtKyV9480SesHzqiPrnNoffBmXx4522i1F
   vo2+ETtyv0DOQT/qB74QmIxBLDzCa2+0ZKW44tUMuk8LzKW2RhwWxl8Ca
   u2n+HAKL6dSocI/v7GIpTp7NGpzs/54BXMn1Q2o4X5b+p4odJ9bOWMn5z
   g==;
X-IronPort-AV: E=Sophos;i="5.92,207,1650902400"; 
   d="scan'208";a="202364428"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2022 08:01:00 +0800
IronPort-SDR: SCU6T+lQtmuPkArNBPU5sQFUsURmg61IHR98T5ai6Yg/x2X6vYJv+ghkIh89LzCHUVWVKKtpDB
 VHF8DChdp1BwHYWweWI0DrYQ0B8VLzfQgrnNpj8SvJsdky57A298X+oV3hQAMdtiLad78PbAdR
 1+a54aRpSKA4l9Urghr16kYbb+dundGQb2hKzNFxcYDoOGgYXP+d9ft/4lyswnG6Ymlj0QHRZi
 RgDCF8qBuwiWYS8s70C9Hwhv+WbrXDNvIrrSyRtmK1DNtwW4x1GHZULRmhbSs/8mcpXsLb0jHC
 9IkR9Osl5+8Q77dDNr1yw+q1
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 16:19:09 -0700
IronPort-SDR: m9ERCDtJKG72c9wtlJ/bUjQ8N/0daMki4AfF3VgYFCFgM2njeaBZH8tpyd6LazYaCgdQ94QLzW
 cYlYgxqrrHEMflFMgOIb4k0cY3ynLmyntCoA/EPXUV1HOoGMFKZZX/em2+QQ8l9E3IT7jJbZYL
 j0GlDQs6b6GT+7dyooFLliVmqxfjzwKcYYKRTT4B4PKC+RQnMZYWRxa+/YBowXRe015Ug5fUfy
 W+FZjKCJVKjF+QVWTnBCOXoWhGBwZp2WXGoE6i80lE8DSAI86q0YdRYC7+YGXb2ITpkwj83Gja
 2mU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 17:01:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LRmrD4L22z1SVny
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 17:01:00 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655769659; x=1658361660; bh=GnJChMROEAiDcxFVp5mm5CesZFms76gSDLu
        LYoCHrmw=; b=Jrs/rfF7GnqMp6euBxKMA4bk1rtckoczLn1iVsae2K25OauC8TC
        vkg/vdyw0lAnPxLX4a1hFO7yEkHKUlcAk3puU8hMa0u6Nlun27CK1kJOVdOYncSm
        iGg2sB2nbKPnZizgbWsr34wrHf1SATcGZz4KGmIGxe/Fh/ibYZsRIoqAA9ZRlUBd
        wwOt90oi4fulrXZgrTSnlP8Oa/QREY7yZZS6KgqVm1ji4aIXWrOWLebDmyySy9+l
        CP/7Vhwujz99K4ZmRNUfTfVrCk+hNLXpmehYnM0TPj0ywd+qu4VCgy0Def0Jtm6G
        NLjyxK9FOOXYTfkMO/cBGdXdxi1s2IPrnww==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 10c1kPk3n6-Q for <linux-block@vger.kernel.org>;
        Mon, 20 Jun 2022 17:00:59 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LRmrC05Spz1Rvlc;
        Mon, 20 Jun 2022 17:00:58 -0700 (PDT)
Message-ID: <188bc396-70ce-5423-b42c-9056e34fb46f@opensource.wdc.com>
Date:   Tue, 21 Jun 2022 09:00:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 6/8] blk-ioprio: Convert from rqos policy to direct call
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
References: <20220620160726.19798-1-jack@suse.cz>
 <20220620161153.11741-6-jack@suse.cz>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220620161153.11741-6-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/22 01:11, Jan Kara wrote:
> Convert blk-ioprio handling from a rqos policy to a direct call from
> blk_mq_submit_bio(). Firstly, blk-ioprio is not a much of a rqos policy

s/not a much/not much

> anyway, it just needs a hook in bio submission path to set the bio's IO
> priority. Secondly, the rqos .track hook gets actually called too late
> for blk-ioprio purposes and introducing a special rqos hook just for
> blk-ioprio looks even weirder.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  block/blk-cgroup.c |  1 +
>  block/blk-ioprio.c | 50 +++++-----------------------------------------
>  block/blk-ioprio.h |  9 +++++++++
>  block/blk-mq.c     |  8 ++++++++
>  4 files changed, 23 insertions(+), 45 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 764e740b0c0f..6906981563f8 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1299,6 +1299,7 @@ int blkcg_init_queue(struct request_queue *q)
>  	ret = blk_iolatency_init(q);
>  	if (ret) {
>  		blk_throtl_exit(q);
> +		blk_ioprio_exit(q);
>  		goto err_destroy_all;
>  	}
>  
> diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
> index 3f605583598b..c00060a02c6e 100644
> --- a/block/blk-ioprio.c
> +++ b/block/blk-ioprio.c
> @@ -181,17 +181,12 @@ static struct blkcg_policy ioprio_policy = {
>  	.pd_free_fn	= ioprio_free_pd,
>  };
>  
> -struct blk_ioprio {
> -	struct rq_qos rqos;
> -};
> -
> -static void blkcg_ioprio_track(struct rq_qos *rqos, struct request *rq,
> -			       struct bio *bio)
> +void blkcg_set_ioprio(struct bio *bio)
>  {
>  	struct ioprio_blkcg *blkcg = ioprio_blkcg_from_bio(bio);
>  	u16 prio;
>  
> -	if (blkcg->prio_policy == POLICY_NO_CHANGE)
> +	if (!blkcg || blkcg->prio_policy == POLICY_NO_CHANGE)
>  		return;
>  
>  	/*
> @@ -207,49 +202,14 @@ static void blkcg_ioprio_track(struct rq_qos *rqos, struct request *rq,
>  		bio->bi_ioprio = prio;
>  }
>  
> -static void blkcg_ioprio_exit(struct rq_qos *rqos)
> +void blk_ioprio_exit(struct request_queue *q)
>  {
> -	struct blk_ioprio *blkioprio_blkg =
> -		container_of(rqos, typeof(*blkioprio_blkg), rqos);
> -
> -	blkcg_deactivate_policy(rqos->q, &ioprio_policy);
> -	kfree(blkioprio_blkg);
> +	blkcg_deactivate_policy(q, &ioprio_policy);
>  }
>  
> -static struct rq_qos_ops blkcg_ioprio_ops = {
> -	.track	= blkcg_ioprio_track,
> -	.exit	= blkcg_ioprio_exit,
> -};
> -
>  int blk_ioprio_init(struct request_queue *q)
>  {
> -	struct blk_ioprio *blkioprio_blkg;
> -	struct rq_qos *rqos;
> -	int ret;
> -
> -	blkioprio_blkg = kzalloc(sizeof(*blkioprio_blkg), GFP_KERNEL);
> -	if (!blkioprio_blkg)
> -		return -ENOMEM;
> -
> -	ret = blkcg_activate_policy(q, &ioprio_policy);
> -	if (ret) {
> -		kfree(blkioprio_blkg);
> -		return ret;
> -	}
> -
> -	rqos = &blkioprio_blkg->rqos;
> -	rqos->id = RQ_QOS_IOPRIO;
> -	rqos->ops = &blkcg_ioprio_ops;
> -	rqos->q = q;
> -
> -	/*
> -	 * Registering the rq-qos policy after activating the blk-cgroup
> -	 * policy guarantees that ioprio_blkcg_from_bio(bio) != NULL in the
> -	 * rq-qos callbacks.
> -	 */
> -	rq_qos_add(q, rqos);
> -
> -	return 0;
> +	return blkcg_activate_policy(q, &ioprio_policy);
>  }
>  
>  static int __init ioprio_init(void)
> diff --git a/block/blk-ioprio.h b/block/blk-ioprio.h
> index a7785c2f1aea..5a1eb550e178 100644
> --- a/block/blk-ioprio.h
> +++ b/block/blk-ioprio.h
> @@ -6,14 +6,23 @@
>  #include <linux/kconfig.h>
>  
>  struct request_queue;
> +struct bio;
>  
>  #ifdef CONFIG_BLK_CGROUP_IOPRIO
>  int blk_ioprio_init(struct request_queue *q);
> +void blk_ioprio_exit(struct request_queue *q);
> +void blkcg_set_ioprio(struct bio *bio);
>  #else
>  static inline int blk_ioprio_init(struct request_queue *q)
>  {
>  	return 0;
>  }
> +static inline void blk_ioprio_exit(struct request_queue *q)
> +{
> +}
> +static inline void blkcg_set_ioprio(struct bio *bio)
> +{
> +}
>  #endif
>  
>  #endif /* _BLK_IOPRIO_H_ */
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e9bf950983c7..67a7bfa58b7c 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -42,6 +42,7 @@
>  #include "blk-stat.h"
>  #include "blk-mq-sched.h"
>  #include "blk-rq-qos.h"
> +#include "blk-ioprio.h"
>  
>  static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
>  
> @@ -2790,6 +2791,11 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
>  	return rq;
>  }
>  
> +static void bio_set_ioprio(struct bio *bio)
> +{
> +	blkcg_set_ioprio(bio);
> +}

Nit: Make this inline ?

> +
>  /**
>   * blk_mq_submit_bio - Create and send a request to block device.
>   * @bio: Bio pointer.
> @@ -2830,6 +2836,8 @@ void blk_mq_submit_bio(struct bio *bio)
>  
>  	trace_block_getrq(bio);
>  
> +	bio_set_ioprio(bio);
> +
>  	rq_qos_track(q, rq, bio);
>  
>  	blk_mq_bio_to_request(rq, bio, nr_segs);

Apart from the nit, looks good to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
