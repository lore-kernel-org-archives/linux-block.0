Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99963C433FE
	for <linux-block@archiver.kernel.org>; Mon, 21 Nov 2022 00:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiKUAZF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Nov 2022 19:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiKUAZF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Nov 2022 19:25:05 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6962720F58
        for <linux-block@vger.kernel.org>; Sun, 20 Nov 2022 16:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668990303; x=1700526303;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R4+tON5zVpIFLrMqzwE1JpewvZsCKpABmNelC+vfl+8=;
  b=hqOK9v6bOV2Qd1onpXFdG76B1upADR+C6C0CFt8waBDxujqA5oqanjLr
   YtAnmY49JjmA+2uP/E+UXNVacxVRcQvMi0XH9R4JjB0qAqIRmGI7G0IIh
   ACfI5UjdZqgH3fUZAfZA4G3zu0R4V7ZnqTLE/pjmnCmK8nXPT08SGWX/3
   CMq5OOp8fZwru9BM6v+3yH9GoaNVq8BdtsYnltAtSsQL2oa4+EOFmak5o
   u9lm+pckO65e5Z/F292zeY4Gbvabr6DsVS/CaMHS0kaW7y8hsYndBzdjy
   D/Io7s8fitXEp/mamuD0MbKUOSzLlVxZB6WGphDlvBXEMGdIHl6wsvE7Z
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,180,1665417600"; 
   d="scan'208";a="221896480"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2022 08:25:01 +0800
IronPort-SDR: yRVj5R1MIwbzfDwid8mgd21bgMJrgh4Qu2C84ySbehL3cN6b98UFtvqk7luLKxXherijv22H0z
 94NOjuLtbKI6Z+K00hZIaEmDAv+1KBUAxvunD1UXszdbnHhNZKmIX3oieadoTEp/HOH6W5/2LT
 mag9NSb6cneSTIY1H4rCk/CIHuafnakb0UfgEgn5DzCa/jpbjCFm5+dzxHJaHnZLSX775rMyLg
 FPTvflKUbYAXPs5et+GXi2P1LC9z9QXTcRCf8ZtWuU+V5Dyu7BcwWVQFHg1wVFlEqo3AU5hSkU
 gHg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2022 15:38:08 -0800
IronPort-SDR: Zz3yf3t1EUROzKS7tvH/7MVltSXv+OZCDT0Wq+OUEycykrRSNVq8exkmFV9UjqGeNS4EOWEi4q
 +TRWuDsiNc7kcF6bXoyNH65U4uIfguvqAt0e+Th//qQm0zWuL8ukjMTRu8Tkk80xg4lWTaoDJ1
 ldg5M1iq20QZmGsP6qD+Qh8JAbu0VgxbGSq/iArEMeAY87SAw52kXTqqSNVc4tuPQdSsFh8lg7
 7fTt1Q+xwMv2DdBxjtOLHpmLzw6wfe7qJvHPdPrnWoj1WIK0yfiNU5arwT3xGBBXDoeh78yvUH
 /co=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2022 16:25:01 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NFp7J53btz1Rwt8
        for <linux-block@vger.kernel.org>; Sun, 20 Nov 2022 16:25:00 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668990298; x=1671582299; bh=R4+tON5zVpIFLrMqzwE1JpewvZsCKpABmNe
        lC+vfl+8=; b=ILBy/fvh/gj6TQPuT8uTPjyeef/RCmHuRIzaDV84BVkTg7ielem
        cABVe9yhFVtg/vHzHzu3hnzQcT15SfASEUd7MdbB3Fo/fkEbpwieZ1OwX2iC1wiJ
        P/8kCUZkAZlOrJpZnjXkLuBoRKUHYAakgllHSMKPAYXsq+g6WTvf99ee6KfV0Ihx
        D54prEGyiypoxoutq83HDkksNkvg7suvL1NUBGhnyuy1eHGNRtCHmlbYRY95c330
        lKPkFGm7+98sl7mxcJKxXRmW7R/ti8Hu4CsdSa3pTNVIQzFs/YOu62Fym/LRPsah
        dzaRnD/vwLEzwnBQRZFCDT4+ky0kt66pw2Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3VD8R8HRj_eZ for <linux-block@vger.kernel.org>;
        Sun, 20 Nov 2022 16:24:58 -0800 (PST)
Received: from [10.225.163.53] (unknown [10.225.163.53])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NFp7D3W0kz1RvLy;
        Sun, 20 Nov 2022 16:24:56 -0800 (PST)
Message-ID: <e046c4dd-9090-6f5a-b28d-717821cba632@opensource.wdc.com>
Date:   Mon, 21 Nov 2022 09:24:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V6 3/8] block, bfq: move io_cq-persistent bfqq data into a
 dedicated struct
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        Gianmarco Lusvardi <glusvardi@posteo.net>,
        Giulio Barabino <giuliobarabino99@gmail.com>,
        Emiliano Maccaferri <inbox@emilianomaccaferri.com>
References: <20221103162623.10286-1-paolo.valente@linaro.org>
 <20221103162623.10286-4-paolo.valente@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221103162623.10286-4-paolo.valente@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/22 01:26, Paolo Valente wrote:
> With a multi-actuator drive, a process may get associated with multiple
> bfq_queues: one queue for each of the N actuators. So, the bfq_io_cq
> data structure must be able to accommodate its per-queue persistent
> information for N queues. Currently it stores this information for
> just one queue, in several scalar fields.
> 
> This is a preparatory commit for moving to accommodating persistent
> information for N queues. In particular, this commit packs all the
> above scalar fields into a single data structure. Then there is now
> only one fieldi, in bfq_io_cq, that stores all the above information. This

s/fieldi/field

Other than that, looks OK to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> scalar field will then be turned into an array by a following commit.
> 
> Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Gianmarco Lusvardi <glusvardi@posteo.net>
> Signed-off-by: Giulio Barabino <giuliobarabino99@gmail.com>
> Signed-off-by: Emiliano Maccaferri <inbox@emilianomaccaferri.com>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> ---
>  block/bfq-iosched.c | 129 +++++++++++++++++++++++++-------------------
>  block/bfq-iosched.h |  52 ++++++++++--------
>  2 files changed, 105 insertions(+), 76 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index ec4b0e70265f..01528182c0c5 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -404,9 +404,10 @@ void bic_set_bfqq(struct bfq_io_cq *bic,
>  	 * we cancel the stable merge if
>  	 * bic->stable_merge_bfqq == bfqq.
>  	 */
> +	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
>  	bic->bfqq[is_sync][actuator_idx] = bfqq;
>  
> -	if (bfqq && bic->stable_merge_bfqq == bfqq) {
> +	if (bfqq && bfqq_data->stable_merge_bfqq == bfqq) {
>  		/*
>  		 * Actually, these same instructions are executed also
>  		 * in bfq_setup_cooperator, in case of abort or actual
> @@ -415,9 +416,9 @@ void bic_set_bfqq(struct bfq_io_cq *bic,
>  		 * did so, we would nest even more complexity in this
>  		 * function.
>  		 */
> -		bfq_put_stable_ref(bic->stable_merge_bfqq);
> +		bfq_put_stable_ref(bfqq_data->stable_merge_bfqq);
>  
> -		bic->stable_merge_bfqq = NULL;
> +		bfqq_data->stable_merge_bfqq = NULL;
>  	}
>  }
>  
> @@ -1174,38 +1175,40 @@ static void
>  bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
>  		      struct bfq_io_cq *bic, bool bfq_already_existing)
>  {
> +	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
>  	unsigned int old_wr_coeff = 1;
>  	bool busy = bfq_already_existing && bfq_bfqq_busy(bfqq);
>  
> -	if (bic->saved_has_short_ttime)
> +	if (bfqq_data->saved_has_short_ttime)
>  		bfq_mark_bfqq_has_short_ttime(bfqq);
>  	else
>  		bfq_clear_bfqq_has_short_ttime(bfqq);
>  
> -	if (bic->saved_IO_bound)
> +	if (bfqq_data->saved_IO_bound)
>  		bfq_mark_bfqq_IO_bound(bfqq);
>  	else
>  		bfq_clear_bfqq_IO_bound(bfqq);
>  
> -	bfqq->last_serv_time_ns = bic->saved_last_serv_time_ns;
> -	bfqq->inject_limit = bic->saved_inject_limit;
> -	bfqq->decrease_time_jif = bic->saved_decrease_time_jif;
> +	bfqq->last_serv_time_ns = bfqq_data->saved_last_serv_time_ns;
> +	bfqq->inject_limit = bfqq_data->saved_inject_limit;
> +	bfqq->decrease_time_jif = bfqq_data->saved_decrease_time_jif;
>  
> -	bfqq->entity.new_weight = bic->saved_weight;
> -	bfqq->ttime = bic->saved_ttime;
> -	bfqq->io_start_time = bic->saved_io_start_time;
> -	bfqq->tot_idle_time = bic->saved_tot_idle_time;
> +	bfqq->entity.new_weight = bfqq_data->saved_weight;
> +	bfqq->ttime = bfqq_data->saved_ttime;
> +	bfqq->io_start_time = bfqq_data->saved_io_start_time;
> +	bfqq->tot_idle_time = bfqq_data->saved_tot_idle_time;
>  	/*
>  	 * Restore weight coefficient only if low_latency is on
>  	 */
>  	if (bfqd->low_latency) {
>  		old_wr_coeff = bfqq->wr_coeff;
> -		bfqq->wr_coeff = bic->saved_wr_coeff;
> +		bfqq->wr_coeff = bfqq_data->saved_wr_coeff;
>  	}
> -	bfqq->service_from_wr = bic->saved_service_from_wr;
> -	bfqq->wr_start_at_switch_to_srt = bic->saved_wr_start_at_switch_to_srt;
> -	bfqq->last_wr_start_finish = bic->saved_last_wr_start_finish;
> -	bfqq->wr_cur_max_time = bic->saved_wr_cur_max_time;
> +	bfqq->service_from_wr = bfqq_data->saved_service_from_wr;
> +	bfqq->wr_start_at_switch_to_srt =
> +		bfqq_data->saved_wr_start_at_switch_to_srt;
> +	bfqq->last_wr_start_finish = bfqq_data->saved_last_wr_start_finish;
> +	bfqq->wr_cur_max_time = bfqq_data->saved_wr_cur_max_time;
>  
>  	if (bfqq->wr_coeff > 1 && (bfq_bfqq_in_large_burst(bfqq) ||
>  	    time_is_before_jiffies(bfqq->last_wr_start_finish +
> @@ -1878,7 +1881,7 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
>  	wr_or_deserves_wr = bfqd->low_latency &&
>  		(bfqq->wr_coeff > 1 ||
>  		 (bfq_bfqq_sync(bfqq) &&
> -		  (bfqq->bic || RQ_BIC(rq)->stably_merged) &&
> +		  (bfqq->bic || RQ_BIC(rq)->bfqq_data.stably_merged) &&
>  		   (*interactive || soft_rt)));
>  
>  	/*
> @@ -2902,6 +2905,7 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  		     void *io_struct, bool request, struct bfq_io_cq *bic)
>  {
>  	struct bfq_queue *in_service_bfqq, *new_bfqq;
> +	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
>  
>  	/* if a merge has already been setup, then proceed with that first */
>  	if (bfqq->new_bfqq)
> @@ -2923,21 +2927,21 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  		 * stable merging) also if bic is associated with a
>  		 * sync queue, but this bfqq is async
>  		 */
> -		if (bfq_bfqq_sync(bfqq) && bic->stable_merge_bfqq &&
> +		if (bfq_bfqq_sync(bfqq) && bfqq_data->stable_merge_bfqq &&
>  		    !bfq_bfqq_just_created(bfqq) &&
>  		    time_is_before_jiffies(bfqq->split_time +
>  					  msecs_to_jiffies(bfq_late_stable_merging)) &&
>  		    time_is_before_jiffies(bfqq->creation_time +
>  					   msecs_to_jiffies(bfq_late_stable_merging))) {
>  			struct bfq_queue *stable_merge_bfqq =
> -				bic->stable_merge_bfqq;
> +				bfqq_data->stable_merge_bfqq;
>  			int proc_ref = min(bfqq_process_refs(bfqq),
>  					   bfqq_process_refs(stable_merge_bfqq));
>  
>  			/* deschedule stable merge, because done or aborted here */
>  			bfq_put_stable_ref(stable_merge_bfqq);
>  
> -			bic->stable_merge_bfqq = NULL;
> +			bfqq_data->stable_merge_bfqq = NULL;
>  
>  			if (!idling_boosts_thr_without_issues(bfqd, bfqq) &&
>  			    proc_ref > 0) {
> @@ -2946,10 +2950,10 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  					bfq_setup_merge(bfqq, stable_merge_bfqq);
>  
>  				if (new_bfqq) {
> -					bic->stably_merged = true;
> +					bfqq_data->stably_merged = true;
>  					if (new_bfqq->bic)
> -						new_bfqq->bic->stably_merged =
> -									true;
> +						new_bfqq->bic->bfqq_data.stably_merged =
> +							true;
>  				}
>  				return new_bfqq;
>  			} else
> @@ -3048,6 +3052,7 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
>  {
>  	struct bfq_io_cq *bic = bfqq->bic;
> +	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
>  
>  	/*
>  	 * If !bfqq->bic, the queue is already shared or its requests
> @@ -3057,18 +3062,21 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
>  	if (!bic)
>  		return;
>  
> -	bic->saved_last_serv_time_ns = bfqq->last_serv_time_ns;
> -	bic->saved_inject_limit = bfqq->inject_limit;
> -	bic->saved_decrease_time_jif = bfqq->decrease_time_jif;
> -
> -	bic->saved_weight = bfqq->entity.orig_weight;
> -	bic->saved_ttime = bfqq->ttime;
> -	bic->saved_has_short_ttime = bfq_bfqq_has_short_ttime(bfqq);
> -	bic->saved_IO_bound = bfq_bfqq_IO_bound(bfqq);
> -	bic->saved_io_start_time = bfqq->io_start_time;
> -	bic->saved_tot_idle_time = bfqq->tot_idle_time;
> -	bic->saved_in_large_burst = bfq_bfqq_in_large_burst(bfqq);
> -	bic->was_in_burst_list = !hlist_unhashed(&bfqq->burst_list_node);
> +	bfqq_data->saved_last_serv_time_ns = bfqq->last_serv_time_ns;
> +	bfqq_data->saved_inject_limit = bfqq->inject_limit;
> +	bfqq_data->saved_decrease_time_jif = bfqq->decrease_time_jif;
> +
> +	bfqq_data->saved_weight = bfqq->entity.orig_weight;
> +	bfqq_data->saved_ttime = bfqq->ttime;
> +	bfqq_data->saved_has_short_ttime =
> +		bfq_bfqq_has_short_ttime(bfqq);
> +	bfqq_data->saved_IO_bound = bfq_bfqq_IO_bound(bfqq);
> +	bfqq_data->saved_io_start_time = bfqq->io_start_time;
> +	bfqq_data->saved_tot_idle_time = bfqq->tot_idle_time;
> +	bfqq_data->saved_in_large_burst = bfq_bfqq_in_large_burst(bfqq);
> +	bfqq_data->was_in_burst_list =
> +		!hlist_unhashed(&bfqq->burst_list_node);
> +
>  	if (unlikely(bfq_bfqq_just_created(bfqq) &&
>  		     !bfq_bfqq_in_large_burst(bfqq) &&
>  		     bfqq->bfqd->low_latency)) {
> @@ -3081,17 +3089,21 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
>  		 * to bfqq, so that to avoid that bfqq unjustly fails
>  		 * to enjoy weight raising if split soon.
>  		 */
> -		bic->saved_wr_coeff = bfqq->bfqd->bfq_wr_coeff;
> -		bic->saved_wr_start_at_switch_to_srt = bfq_smallest_from_now();
> -		bic->saved_wr_cur_max_time = bfq_wr_duration(bfqq->bfqd);
> -		bic->saved_last_wr_start_finish = jiffies;
> +		bfqq_data->saved_wr_coeff = bfqq->bfqd->bfq_wr_coeff;
> +		bfqq_data->saved_wr_start_at_switch_to_srt =
> +			bfq_smallest_from_now();
> +		bfqq_data->saved_wr_cur_max_time =
> +			bfq_wr_duration(bfqq->bfqd);
> +		bfqq_data->saved_last_wr_start_finish = jiffies;
>  	} else {
> -		bic->saved_wr_coeff = bfqq->wr_coeff;
> -		bic->saved_wr_start_at_switch_to_srt =
> +		bfqq_data->saved_wr_coeff = bfqq->wr_coeff;
> +		bfqq_data->saved_wr_start_at_switch_to_srt =
>  			bfqq->wr_start_at_switch_to_srt;
> -		bic->saved_service_from_wr = bfqq->service_from_wr;
> -		bic->saved_last_wr_start_finish = bfqq->last_wr_start_finish;
> -		bic->saved_wr_cur_max_time = bfqq->wr_cur_max_time;
> +		bfqq_data->saved_service_from_wr =
> +			bfqq->service_from_wr;
> +		bfqq_data->saved_last_wr_start_finish =
> +			bfqq->last_wr_start_finish;
> +		bfqq_data->saved_wr_cur_max_time = bfqq->wr_cur_max_time;
>  	}
>  }
>  
> @@ -5413,6 +5425,7 @@ static void bfq_exit_icq(struct io_cq *icq)
>  	unsigned long flags;
>  	unsigned int act_idx;
>  	unsigned int num_actuators;
> +	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
>  
>  	/*
>  	 * bfqd is NULL if scheduler already exited, and in that case
> @@ -5432,8 +5445,8 @@ static void bfq_exit_icq(struct io_cq *icq)
>  		num_actuators = BFQ_MAX_ACTUATORS;
>  	}
>  
> -	if (bic->stable_merge_bfqq)
> -		bfq_put_stable_ref(bic->stable_merge_bfqq);
> +	if (bfqq_data->stable_merge_bfqq)
> +		bfq_put_stable_ref(bfqq_data->stable_merge_bfqq);
>  
>  	for (act_idx = 0; act_idx < num_actuators; act_idx++) {
>  		bfq_exit_icq_bfqq(bic, true, act_idx);
> @@ -5624,13 +5637,14 @@ bfq_do_early_stable_merge(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  {
>  	struct bfq_queue *new_bfqq =
>  		bfq_setup_merge(bfqq, last_bfqq_created);
> +	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
>  
>  	if (!new_bfqq)
>  		return bfqq;
>  
>  	if (new_bfqq->bic)
> -		new_bfqq->bic->stably_merged = true;
> -	bic->stably_merged = true;
> +		new_bfqq->bic->bfqq_data.stably_merged = true;
> +	bfqq_data->stably_merged = true;
>  
>  	/*
>  	 * Reusing merge functions. This implies that
> @@ -5699,6 +5713,7 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
>  		&bfqd->last_bfqq_created;
>  
>  	struct bfq_queue *last_bfqq_created = *source_bfqq;
> +	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
>  
>  	/*
>  	 * If last_bfqq_created has not been set yet, then init it. If
> @@ -5760,7 +5775,7 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
>  			/*
>  			 * Record the bfqq to merge to.
>  			 */
> -			bic->stable_merge_bfqq = last_bfqq_created;
> +			bfqq_data->stable_merge_bfqq = last_bfqq_created;
>  		}
>  	}
>  
> @@ -6681,6 +6696,7 @@ static struct bfq_queue *bfq_get_bfqq_handle_split(struct bfq_data *bfqd,
>  {
>  	unsigned int act_idx = bfq_actuator_index(bfqd, bio);
>  	struct bfq_queue *bfqq = bic_to_bfqq(bic, is_sync, act_idx);
> +	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
>  
>  	if (likely(bfqq && bfqq != &bfqd->oom_bfqq))
>  		return bfqq;
> @@ -6694,12 +6710,12 @@ static struct bfq_queue *bfq_get_bfqq_handle_split(struct bfq_data *bfqd,
>  
>  	bic_set_bfqq(bic, bfqq, is_sync, act_idx);
>  	if (split && is_sync) {
> -		if ((bic->was_in_burst_list && bfqd->large_burst) ||
> -		    bic->saved_in_large_burst)
> +		if ((bfqq_data->was_in_burst_list && bfqd->large_burst) ||
> +		    bfqq_data->saved_in_large_burst)
>  			bfq_mark_bfqq_in_large_burst(bfqq);
>  		else {
>  			bfq_clear_bfqq_in_large_burst(bfqq);
> -			if (bic->was_in_burst_list)
> +			if (bfqq_data->was_in_burst_list)
>  				/*
>  				 * If bfqq was in the current
>  				 * burst list before being
> @@ -6788,6 +6804,7 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
>  	struct bfq_queue *bfqq;
>  	bool new_queue = false;
>  	bool bfqq_already_existing = false, split = false;
> +	struct bfq_iocq_bfqq_data *bfqq_data;
>  
>  	if (unlikely(!rq->elv.icq))
>  		return NULL;
> @@ -6811,15 +6828,17 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
>  	bfqq = bfq_get_bfqq_handle_split(bfqd, bic, bio, false, is_sync,
>  					 &new_queue);
>  
> +	bfqq_data = &bic->bfqq_data;
> +
>  	if (likely(!new_queue)) {
>  		/* If the queue was seeky for too long, break it apart. */
>  		if (bfq_bfqq_coop(bfqq) && bfq_bfqq_split_coop(bfqq) &&
> -			!bic->stably_merged) {
> +			!bfqq_data->stably_merged) {
>  			struct bfq_queue *old_bfqq = bfqq;
>  
>  			/* Update bic before losing reference to bfqq */
>  			if (bfq_bfqq_in_large_burst(bfqq))
> -				bic->saved_in_large_burst = true;
> +				bfqq_data->saved_in_large_burst = true;
>  
>  			bfqq = bfq_split_bfqq(bic, bfqq);
>  			split = true;
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index bfcbd8ea9000..f2e8ab91951c 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -411,27 +411,9 @@ struct bfq_queue {
>  };
>  
>  /**
> - * struct bfq_io_cq - per (request_queue, io_context) structure.
> - */
> -struct bfq_io_cq {
> -	/* associated io_cq structure */
> -	struct io_cq icq; /* must be the first member */
> -	/*
> -	 * Matrix of associated process queues: first row for async
> -	 * queues, second row sync queues. Each row contains one
> -	 * column for each actuator. An I/O request generated by the
> -	 * process is inserted into the queue pointed by bfqq[i][j] if
> -	 * the request is to be served by the j-th actuator of the
> -	 * drive, where i==0 or i==1, depending on whether the request
> -	 * is async or sync. So there is a distinct queue for each
> -	 * actuator.
> -	 */
> -	struct bfq_queue *bfqq[2][BFQ_MAX_ACTUATORS];
> -	/* per (request_queue, blkcg) ioprio */
> -	int ioprio;
> -#ifdef CONFIG_BFQ_GROUP_IOSCHED
> -	uint64_t blkcg_serial_nr; /* the current blkcg serial */
> -#endif
> +* struct bfq_data - bfqq data unique and persistent for associated bfq_io_cq
> +*/
> +struct bfq_iocq_bfqq_data {
>  	/*
>  	 * Snapshot of the has_short_time flag before merging; taken
>  	 * to remember its value while the queue is merged, so as to
> @@ -486,6 +468,34 @@ struct bfq_io_cq {
>  	struct bfq_queue *stable_merge_bfqq;
>  
>  	bool stably_merged;	/* non splittable if true */
> +};
> +
> +/**
> + * struct bfq_io_cq - per (request_queue, io_context) structure.
> + */
> +struct bfq_io_cq {
> +	/* associated io_cq structure */
> +	struct io_cq icq; /* must be the first member */
> +	/*
> +	 * Matrix of associated process queues: first row for async
> +	 * queues, second row sync queues. Each row contains one
> +	 * column for each actuator. An I/O request generated by the
> +	 * process is inserted into the queue pointed by bfqq[i][j] if
> +	 * the request is to be served by the j-th actuator of the
> +	 * drive, where i==0 or i==1, depending on whether the request
> +	 * is async or sync. So there is a distinct queue for each
> +	 * actuator.
> +	 */
> +	struct bfq_queue *bfqq[2][BFQ_MAX_ACTUATORS];
> +	/* per (request_queue, blkcg) ioprio */
> +	int ioprio;
> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
> +	uint64_t blkcg_serial_nr; /* the current blkcg serial */
> +#endif
> +
> +	/* persistent data for associated synchronous process queue */
> +	struct bfq_iocq_bfqq_data bfqq_data;
> +
>  	unsigned int requests;	/* Number of requests this process has in flight */
>  };
>  

-- 
Damien Le Moal
Western Digital Research

