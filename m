Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CB1C4332F
	for <linux-block@archiver.kernel.org>; Fri,  9 Dec 2022 01:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiLIBah (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Dec 2022 20:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiLIBae (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Dec 2022 20:30:34 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8DE86F47
        for <linux-block@vger.kernel.org>; Thu,  8 Dec 2022 17:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670549429; x=1702085429;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z+MB6BKbERAk/aU/VdmESjhXVsEOrKd+g9suaVcIVzs=;
  b=TFRF0re1KwkDFD4BmJ37XiFbrpJ2mFLjB7tKWQrsgQyaaFWKbK8w/gz/
   KFNVU23LzhDSGOYhlRsWdGhEN2MMeRfjq00YNOmWcKskz2APUC0HySkTs
   ulm8VXnsE5/PtBYljyYcUnmqyOim2dyNBWH1Qsn8dtudrNroeEZ4cilmn
   lywXYZoNqMV/6Au6yA8xfUdLszkzunnxQvUU/6xvyFpSMD71MqB97xD89
   34iLlpnpC2cQiaoNw+fSk5fAxSgSCXTPJpPm+mnJ5/55wXXQXkFatp7In
   sVFDVRWnduOCZ5TRHjQF9neG9HWmEfyXRUEWydMeDJQ6UiP34ZuXDjnA7
   g==;
X-IronPort-AV: E=Sophos;i="5.96,228,1665417600"; 
   d="scan'208";a="330328949"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2022 09:30:27 +0800
IronPort-SDR: yZgElUO005QpZNNTDxkseEgClsLCIymnrGa5nfyPex73OqiFhmbwJLWVEs7m6pzGo/ZUy0Jv2U
 3I6b8I8/CSMQ3dK0IjOvWLx8J/QACfIhdlRBeCsGLdLuXV8u9Jz7A0gd4UWcLPtQNd0KAIRSkc
 w/k7gBbare5CZBo+s8xu5IXXoXQcTofxcFaM74pRBoi3xrftDwv9j7lxCmlzXR7X65RUBD5i24
 yxuT1mVhefYiT0Em89SeWeeak7JymdxKM7x7AhqOZvIm4MS2BCtKLp1BInm985CWi4wTFUapa2
 3Lg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Dec 2022 16:48:55 -0800
IronPort-SDR: Jivlyu3PgpiN6lVeACqVvl2tXWwlCaJDvz3UIMJ14SNXYfpFM9BnG2xDAMyLRZ/Yxj8ygrwa+/
 Hn+g/wyVWWcDCkRKaNn2mnIfOyqBtHCLlYTbNhAqGGJwA72RYpgKVV2Htn4To072LpIgCQ1B1h
 rOyK49EVU1jTZJ3TjeHeJBBcOAOdBrI+zyPeEXU4be+fXTHsBCnITM30fIR+Rrgd8b63CDiRhd
 ob0Y+6PRPYqQlXvYyxCNe2CJuXyXQIjfy8YDdr3Tt+FiBkpmDeaNeCzNDiHdBFEkLp5pAK1nKn
 Exc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Dec 2022 17:30:27 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NStkV6bfkz1Rwtl
        for <linux-block@vger.kernel.org>; Thu,  8 Dec 2022 17:30:26 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670549425; x=1673141426; bh=Z+MB6BKbERAk/aU/VdmESjhXVsEOrKd+g9s
        uaVcIVzs=; b=o2qNqd7qAEIYwB0IRQG3i2PEuyxzBJAsHxHRUkyL+6aE6sxRQB2
        3SEpm5dWS6gyBSya+aFhg5dCp+EHlv8GVmjNHYkUhASIDoH9pBdBmo7sB57qbS6k
        El9f4DNYPYcfSCLLutju/A3rwU0md2NdVB7GKYVuHmjeEUwpU0KYZvydwh4JjI5O
        AuqX277Ql/3t6kPJy6u0l0Lh3RqB0Xr+X9EUTpWVA5157lUN7C/NgdKRNYkAOHek
        CFfsmBBzSLlnrvBH8SDZtE2sYsLlQv6k9OA1ueoR6YJlV/JOSr0A5KdwxoKlgr9A
        HFkeJAWf42CpNsVKp571KSnllnerdzPlMkw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hqm4_LFL7eJc for <linux-block@vger.kernel.org>;
        Thu,  8 Dec 2022 17:30:25 -0800 (PST)
Received: from [10.225.163.85] (unknown [10.225.163.85])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NStkR4tBBz1RvLy;
        Thu,  8 Dec 2022 17:30:23 -0800 (PST)
Message-ID: <49aa8a40-938f-50c2-990e-04cf743e3b19@opensource.wdc.com>
Date:   Fri, 9 Dec 2022 10:30:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V9 4/8] block, bfq: turn bfqq_data into an array in
 bfq_io_cq
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Gabriele Felici <felicigb@gmail.com>,
        Gianmarco Lusvardi <glusvardi@posteo.net>,
        Giulio Barabino <giuliobarabino99@gmail.com>,
        Emiliano Maccaferri <inbox@emilianomaccaferri.com>
References: <20221208104351.35038-1-paolo.valente@linaro.org>
 <20221208104351.35038-5-paolo.valente@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221208104351.35038-5-paolo.valente@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/8/22 19:43, Paolo Valente wrote:
> When a bfq_queue Q is merged with another queue, several pieces of
> information are saved about Q. These pieces are stored in the
> bfqq_data field in the bfq_io_cq data structure of the process
> associated with Q.
> 
> Yet, with a multi-actuator drive, a process may get associated with
> multiple bfq_queues: one queue for each of the N actuators. Each of
> these queues may undergo a merge. So, the bfq_io_cq data structure
> must be able to accommodate the above information for N queues.
> 
> This commit solves this problem by turning the bfqq_data scalar field
> into an array of N elements (and by changing code so as to handle
> this array).
> 
> This solution is written under the assumption that bfq_queues
> associated with different actuators cannot be cross-merged. This
> assumption holds naturally with basic queue merging: the latter is
> triggered by spatial locality, and sectors for different actuators are
> not close to each other (apart from the corner case of the last
> sectors served by a given actuator and the first sectors served by the
> next actuator). As for stable cross-merging, the assumption here is
> that it is disabled.
> 
> Signed-off-by: Gabriele Felici <felicigb@gmail.com>
> Signed-off-by: Gianmarco Lusvardi <glusvardi@posteo.net>
> Signed-off-by: Giulio Barabino <giuliobarabino99@gmail.com>
> Signed-off-by: Emiliano Maccaferri <inbox@emilianomaccaferri.com>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> ---
>  block/bfq-iosched.c | 95 +++++++++++++++++++++++++++------------------
>  block/bfq-iosched.h | 12 ++++--
>  2 files changed, 65 insertions(+), 42 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 0d6b35ef3d3f..18e2b8f75435 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -406,7 +406,7 @@ void bic_set_bfqq(struct bfq_io_cq *bic,
>  	 * we cancel the stable merge if
>  	 * bic->stable_merge_bfqq == bfqq.
>  	 */
> -	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
> +	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data[actuator_idx];
>  
>  	if (is_sync)
>  		bic->bfqq[1][actuator_idx] = bfqq;
> @@ -1181,9 +1181,10 @@ static void
>  bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
>  		      struct bfq_io_cq *bic, bool bfq_already_existing)
>  {
> -	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data;
>  	unsigned int old_wr_coeff = 1;
>  	bool busy = bfq_already_existing && bfq_bfqq_busy(bfqq);
> +	unsigned int a_idx = bfqq->actuator_idx;
> +	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data[a_idx];
>  
>  	if (bfqq_data->saved_has_short_ttime)
>  		bfq_mark_bfqq_has_short_ttime(bfqq);
> @@ -1899,7 +1900,9 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
>  	wr_or_deserves_wr = bfqd->low_latency &&
>  		(bfqq->wr_coeff > 1 ||
>  		 (bfq_bfqq_sync(bfqq) &&
> -		  (bfqq->bic || RQ_BIC(rq)->bfqq_data.stably_merged) &&
> +		  (bfqq->bic ||
> +		   RQ_BIC(rq)->bfqq_data[bfq_actuator_index(bfqd, rq->bio)]
> +		   .stably_merged) &&

very weird line split here...

>  		   (*interactive || soft_rt)));
>  
>  	/*
> @@ -2888,6 +2891,35 @@ static bool bfq_may_be_close_cooperator(struct bfq_queue *bfqq,
>  static bool idling_boosts_thr_without_issues(struct bfq_data *bfqd,
>  					     struct bfq_queue *bfqq);
>  
> +static struct bfq_queue *
> +bfq_setup_stable_merge(struct bfq_data *bfqd, struct bfq_queue *bfqq,
> +		       struct bfq_queue *stable_merge_bfqq,
> +		       struct bfq_iocq_bfqq_data *bfqq_data)
> +{
> +	int proc_ref = min(bfqq_process_refs(bfqq),
> +			   bfqq_process_refs(stable_merge_bfqq));
> +
> +	if (!idling_boosts_thr_without_issues(bfqd, bfqq) &&
> +	    proc_ref > 0) {

If you reverse the if condition and return NULL here you can save one tab
indent level for the hunk below (no need for an else after a return).

> +		/* next function will take at least one ref */
> +		struct bfq_queue *new_bfqq =
> +			bfq_setup_merge(bfqq, stable_merge_bfqq);
> +
> +		if (new_bfqq) {
> +			bfqq_data->stably_merged = true;
> +			if (new_bfqq->bic) {
> +				unsigned int new_a_idx = new_bfqq->actuator_idx;
> +				struct bfq_iocq_bfqq_data *new_bfqq_data =
> +					&new_bfqq->bic->bfqq_data[new_a_idx];
> +
> +				new_bfqq_data->stably_merged = true;
> +			}
> +		}
> +		return new_bfqq;
> +	} else
> +		return NULL;
> +}

Otherwise, looks OK.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

