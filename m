Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B3BC433FE
	for <linux-block@archiver.kernel.org>; Mon, 21 Nov 2022 00:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiKUAUK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Nov 2022 19:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiKUAUJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Nov 2022 19:20:09 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26231F2C4
        for <linux-block@vger.kernel.org>; Sun, 20 Nov 2022 16:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668990008; x=1700526008;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6xnCc066eoOiPC/hwdxQVuzfZ7GU35QFPhwakWaxBnE=;
  b=rRv/UXwGT4oWVaZPdPTga4sGsHeMeEIWW9YrutP3H+HFkaPmb189yAe2
   qWTWWX6auPBIxMGba0gZ3mW4fwLjC2cTLWz8qlCP324TdGX8FxU9PQ7IT
   gkUQqV533rncIf40taSL04LZg+Pt9aUjxUtq55LvsBMktbjFbvuSsKWGw
   iICCXzz3T3GKyBrjBygJiUqLlBzD3VIxE6BSPfjpwl1k9Xq+mDMiUng+v
   iDjQCjVtKLFrfTzWEBE0D0k5Zb3/G1ZEl6lSkwDaYGF9pkJ7SVgU81Lpi
   hnqdbQ4RT3sLOUudmT/YcPqL3nwxZ/6PmwcvxVhkGqpHUfrRfkdIKDeu4
   A==;
X-IronPort-AV: E=Sophos;i="5.96,180,1665417600"; 
   d="scan'208";a="321085188"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2022 08:20:07 +0800
IronPort-SDR: 0E0fca+BafPy53nKZPHKWuHZHGhM8KeF8qzK5ioZ9TPiShScfhJd83iJjty186J8IDe2QMw+yx
 WmZ8CRttq4wEhqBz/cGjNRF6P1gDvuLYFYne/Pz2I99BTDpFizHdjbqcC9l24rOKw0eZLYIolb
 a15jm9QrKIPg/heCiinprTteqdRoKCkdXydZrM3mPQDO6hi1Ke7eEjRJsqEkHLhYq7rMdTh7Z9
 M817ecmKmGYETkh1umzgAOPLKIYS32pEGqeltbnJxuW+PYGF32sOvjBH3qyM7PCoL/U2GIcZVl
 CT0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2022 15:33:14 -0800
IronPort-SDR: 6PE43HRSkqmMbjSeyHJNI0LJ+igm7bmv6BhWDzq1iJn4swbMNVhT1qsDU6o7DiASDB9a7tPHV3
 3Jm1CC9B9rwUOUC8xHbyLR2hUSznl2XR1C8QuRMx6fGP9OASWnZZJpeGTwR8IlN6ekSORRPN4M
 2XFMX1YlDNicIXRYhAEAcB6zT5A3Ps7Csayr8iXIlhPSjQKojd8aIESLgofWwbFxnTR4zS0sVN
 3MceTmDC6tPGXBjrffCK12Le58KI+x4fgCgXNV1QjW7BJGfepGLFPKxnt5BKDvVVJAXZYVrcOU
 rYU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2022 16:20:07 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NFp1f5cLhz1Rwt8
        for <linux-block@vger.kernel.org>; Sun, 20 Nov 2022 16:20:06 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668990006; x=1671582007; bh=6xnCc066eoOiPC/hwdxQVuzfZ7GU35QFPhw
        akWaxBnE=; b=KTN0kKsJTcc9K0BKZJ8YrN8W+FtEjA82NV69sXpA02nM5B5H2K9
        k1LOl4S60Nl6+c88MiKpz0b2n2wNHUwW4LqIkzP47a/lO4aQXDXC8Z87o0ZpXJdt
        1OMB9+CmcscYn0msMKuj0EiR1RsXjd8e3/RVh7aIGxJbogE4Fusl6/YMDBFwj8nM
        LRwTHopv7l6t5S6J7gO+tIHLI9oAiIB2s0xwELIwPVULolbU1328aGS65TfQeYq4
        0sj5d2ZbugGVN7SqbYpDBfYjJIGxMu+89NVdBwVqK8gHdQ80ve4tcKTDm5rkzSCn
        Z8UjOw8jT+v4DNYV3f4f7eyh5jLluuwu3FQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3GEayQSZupgy for <linux-block@vger.kernel.org>;
        Sun, 20 Nov 2022 16:20:06 -0800 (PST)
Received: from [10.225.163.53] (unknown [10.225.163.53])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NFp1d0qBXz1RvLy;
        Sun, 20 Nov 2022 16:20:04 -0800 (PST)
Message-ID: <f23d1a4a-cdf9-3ab3-d2ec-fe55f5d06915@opensource.wdc.com>
Date:   Mon, 21 Nov 2022 09:20:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V6 2/8] block, bfq: forbid stable merging of queues
 associated with different actuators
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com
References: <20221103162623.10286-1-paolo.valente@linaro.org>
 <20221103162623.10286-3-paolo.valente@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221103162623.10286-3-paolo.valente@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/22 01:26, Paolo Valente wrote:
> If queues associated with different actuators are merged, then control
> is lost on each actuator. Therefore some actuator may be
> underutilized, and throughput may decrease. This problem cannot occur
> with basic queue merging, because the latter is triggered by spatial
> locality, and sectors for different actuators are not close to each
> other. Yet it may happen with stable merging. To address this issue,
> this commit prevents stable merging from occurring among queues
> associated with different actuators.
> 
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> ---
>  block/bfq-iosched.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 5c69394bbb65..ec4b0e70265f 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -5705,9 +5705,13 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
>  	 * it has been set already, but too long ago, then move it
>  	 * forward to bfqq. Finally, move also if bfqq belongs to a
>  	 * different group than last_bfqq_created, or if bfqq has a
> -	 * different ioprio or ioprio_class. If none of these
> -	 * conditions holds true, then try an early stable merge or
> -	 * schedule a delayed stable merge.
> +	 * different ioprio, ioprio_class or actuator_idx. If none of
> +	 * these conditions holds true, then try an early stable merge
> +	 * or schedule a delayed stable merge. As for the condition on
> +	 * actuator_idx, the reason is that, if queues associated with
> +	 * different actuators are merged, then control is lost on
> +	 * each actuator. Therefore some actuator may be
> +	 * underutilized, and throughput may decrease.
>  	 *
>  	 * A delayed merge is scheduled (instead of performing an
>  	 * early merge), in case bfqq might soon prove to be more
> @@ -5725,7 +5729,8 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
>  			bfqq->creation_time) ||
>  		bfqq->entity.parent != last_bfqq_created->entity.parent ||
>  		bfqq->ioprio != last_bfqq_created->ioprio ||
> -		bfqq->ioprio_class != last_bfqq_created->ioprio_class)
> +		bfqq->ioprio_class != last_bfqq_created->ioprio_class ||
> +		bfqq->actuator_idx != last_bfqq_created->actuator_idx)
>  		*source_bfqq = bfqq;
>  	else if (time_after_eq(last_bfqq_created->creation_time +
>  				 bfqd->bfq_burst_interval,

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

