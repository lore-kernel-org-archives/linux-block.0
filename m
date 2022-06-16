Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBE5C433EF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 03:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346547AbiFPDOi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 23:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348016AbiFPDOh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 23:14:37 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D997936E0F
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 20:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655349276; x=1686885276;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=99AETx/1Vc8KHzsE72Hefkm3AykmP+KUWO5chPkQj+k=;
  b=YGkc20gPn91ZNvajv+X4KiS7OyiXH4ATAAFKpyspV78JREIXkTPUQDUV
   V6QEejwnV/8stLxPRAh4G3uHaBWf3GIj/jx5BEXQhv3loJd9egV5lME59
   84/dPEIhcq1Q2bL0tIYEAJhaRq8f8FfGcWTCMfkVkCPNuASeh2vVwJuIg
   wGjnoCcp5F2bDY9scaOVGpUfnb6YIIkaBLUWDGTa4pbL+ZEVAhORI+pIS
   FWxPvMIG5TGVIer35MbgrqXOkE10GcpuMnjSRg7KYC/foots0P82X5U5L
   bdRXRhbxvH8MHttw9pNDGb4YWNlulKXbHWPqXjQIPwACqvWj3Z//Gbd/f
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,302,1647273600"; 
   d="scan'208";a="204050252"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2022 11:14:36 +0800
IronPort-SDR: t65NVgR+C29y5XqpXYGLMXQ6QHCRU15vEYT1xwRbO6781Pov9rhhpqlrKKTcSEyHQjBiHXx6zE
 KCdZPrmaOcD+8Sen7mN0R6Eyi922YYmPJUBN0j1JRdh94cGxsHtOYKuzj13QvN9bbdmqOQvttG
 1fzEwjVZckssE9g6aC7emRWJChYtnRJjnJTEoAGiOm2Y/ckAyDUrE76wSSrP95MDjAXsWx4/gN
 sd5i3SZeh/UE/7IqjTGES4u0QSwWyb6bjmDZjI4pqTLT6TTpdbbRMSUlb/LdIQAiSRdnvG8vIJ
 e2S/OofYf+rZqsexFm27vxgq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 19:37:24 -0700
IronPort-SDR: 4MOJkP94VqtEho5QqWx3wrf+5T1zqKacO1ARrOdglVP/Rrxc28BoUA1sDOb/Au4ngnxePEudUR
 nwPk+X9Dgyl3bwnryzxNQy3/N5lT4Vs1/ZCj1v9H6ST9rl3lxCfRXJ7NGMnSdo7dLeGxeu62ck
 7+UIx0QMiI0JScNcTYX4txaMnswfZAaWlOLE9kUPohjrEtsH/oUQS9+PvQiUk16qE99OV6HGk2
 XEFnhR4zXO/g6lGAAK3nXtRMR0GB8uhY4drWWUMVnk9CiXuTwMJw+pA8z7r0KfJN5t2JQPmZS8
 Fms=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 20:14:36 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LNnMt4Jryz1SHwl
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 20:14:34 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655349274; x=1657941275; bh=99AETx/1Vc8KHzsE72Hefkm3AykmP+KUWO5
        chPkQj+k=; b=exNniC5fj0GQbY2EzKIEuvngTZmDG6fytySzoCzM9AsAiAWrtyE
        fKsQ9OjN8hstGLp4ZMXiPlRQD7+a+U1d9DrAuV0sdbMuti6vJ2hLrBZS5Ygio3Se
        YsaM0zvnq93619IcVd3kfvxYNvUrUMmfZQ+hftv6gTbvnKVJn7IBLvnLiboba/Y7
        9KipSRdIHEaGz2pfdPKUbo1a3EVtjqyNpXHaM8E6kCXUKUondpy77Esmdp+4XwmT
        nL1SLkQSWc0N793hmz1wg75pmWzOO4zjE1E7DLue8EGZcWOWcAVd0QHQIGsZben4
        eYvIP18wHz8e4/NCI1F498CMvsmqSzmTwRA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uVYFOsS11XJ3 for <linux-block@vger.kernel.org>;
        Wed, 15 Jun 2022 20:14:34 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LNnMs12WKz1Rvlc;
        Wed, 15 Jun 2022 20:14:32 -0700 (PDT)
Message-ID: <0f6e149e-b93f-1236-23a7-f7b8fa9719a1@opensource.wdc.com>
Date:   Thu, 16 Jun 2022 12:14:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 6/8] blk-ioprio: Convert from rqos policy to direct call
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Niklas Cassel <Niklas.Cassel@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20220615160437.5478-1-jack@suse.cz>
 <20220615161616.5055-6-jack@suse.cz>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220615161616.5055-6-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/16/22 01:16, Jan Kara wrote:
> Convert blk-ioprio handling from a rqos policy to a direct call from
> blk_mq_submit_bio(). Firstly, blk-ioprio is not a much of a rqos policy
> anyway, it just needs a hook in bio submission path to set the bio's IO
> priority. Secondly, the rqos .track hook gets actually called too late
> for blk-ioprio purposes and introducing a special rqos hook just for
> blk-ioprio looks even weirder.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>   block/blk-cgroup.c |  1 +
>   block/blk-ioprio.c | 50 +++++-----------------------------------------
>   block/blk-ioprio.h |  9 +++++++++
>   block/blk-mq.c     |  8 ++++++++
>   4 files changed, 23 insertions(+), 45 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 764e740b0c0f..6906981563f8 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1299,6 +1299,7 @@ int blkcg_init_queue(struct request_queue *q)
>   	ret = blk_iolatency_init(q);
>   	if (ret) {
>   		blk_throtl_exit(q);
> +		blk_ioprio_exit(q);
>   		goto err_destroy_all;
>   	}
>   
> diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
> index 3f605583598b..c00060a02c6e 100644
> --- a/block/blk-ioprio.c
> +++ b/block/blk-ioprio.c
> @@ -181,17 +181,12 @@ static struct blkcg_policy ioprio_policy = {
>   	.pd_free_fn	= ioprio_free_pd,
>   };
>   
> -struct blk_ioprio {
> -	struct rq_qos rqos;
> -};
> -
> -static void blkcg_ioprio_track(struct rq_qos *rqos, struct request *rq,
> -			       struct bio *bio)
> +void blkcg_set_ioprio(struct bio *bio)
>   {
>   	struct ioprio_blkcg *blkcg = ioprio_blkcg_from_bio(bio);
>   	u16 prio;
>   
> -	if (blkcg->prio_policy == POLICY_NO_CHANGE)
> +	if (!blkcg || blkcg->prio_policy == POLICY_NO_CHANGE)

See my comment on patch 8.

>   		return;
>   
>   	/*
> @@ -207,49 +202,14 @@ static void blkcg_ioprio_track(struct rq_qos *rqos, struct request *rq,
>   		bio->bi_ioprio = prio;
>   }
>   
> -static void blkcg_ioprio_exit(struct rq_qos *rqos)
> +void blk_ioprio_exit(struct request_queue *q)
>   {
> -	struct blk_ioprio *blkioprio_blkg =
> -		container_of(rqos, typeof(*blkioprio_blkg), rqos);
> -
> -	blkcg_deactivate_policy(rqos->q, &ioprio_policy);
> -	kfree(blkioprio_blkg);
> +	blkcg_deactivate_policy(q, &ioprio_policy);
>   }
>   
> -static struct rq_qos_ops blkcg_ioprio_ops = {
> -	.track	= blkcg_ioprio_track,
> -	.exit	= blkcg_ioprio_exit,
> -};
> -
>   int blk_ioprio_init(struct request_queue *q)
>   {
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
>   }
>   
>   static int __init ioprio_init(void)
> diff --git a/block/blk-ioprio.h b/block/blk-ioprio.h
> index a7785c2f1aea..5a1eb550e178 100644
> --- a/block/blk-ioprio.h
> +++ b/block/blk-ioprio.h
> @@ -6,14 +6,23 @@
>   #include <linux/kconfig.h>
>   
>   struct request_queue;
> +struct bio;
>   
>   #ifdef CONFIG_BLK_CGROUP_IOPRIO
>   int blk_ioprio_init(struct request_queue *q);
> +void blk_ioprio_exit(struct request_queue *q);
> +void blkcg_set_ioprio(struct bio *bio);
>   #else
>   static inline int blk_ioprio_init(struct request_queue *q)
>   {
>   	return 0;
>   }
> +static inline void blk_ioprio_exit(struct request_queue *q)
> +{
> +}
> +static inline void blkcg_set_ioprio(struct bio *bio)
> +{
> +}
>   #endif
>   
>   #endif /* _BLK_IOPRIO_H_ */
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e9bf950983c7..67a7bfa58b7c 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -42,6 +42,7 @@
>   #include "blk-stat.h"
>   #include "blk-mq-sched.h"
>   #include "blk-rq-qos.h"
> +#include "blk-ioprio.h"
>   
>   static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
>   
> @@ -2790,6 +2791,11 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
>   	return rq;
>   }
>   
> +static void bio_set_ioprio(struct bio *bio)
> +{
> +	blkcg_set_ioprio(bio);
> +}
> +
>   /**
>    * blk_mq_submit_bio - Create and send a request to block device.
>    * @bio: Bio pointer.
> @@ -2830,6 +2836,8 @@ void blk_mq_submit_bio(struct bio *bio)
>   
>   	trace_block_getrq(bio);
>   
> +	bio_set_ioprio(bio);
> +
>   	rq_qos_track(q, rq, bio);
>   
>   	blk_mq_bio_to_request(rq, bio, nr_segs);


-- 
Damien Le Moal
Western Digital Research
