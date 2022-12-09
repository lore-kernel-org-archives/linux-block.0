Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7595FC4332F
	for <linux-block@archiver.kernel.org>; Fri,  9 Dec 2022 01:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiLIBqL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Dec 2022 20:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiLIBqJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Dec 2022 20:46:09 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B78D92301
        for <linux-block@vger.kernel.org>; Thu,  8 Dec 2022 17:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670550369; x=1702086369;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XTiN2sIKIG3nGeB11c5KGlQQNx+mIfr34pi/QYArEGQ=;
  b=O8ktQWTECgTaIgxKv7VZL3MQN2CETpTbRIUATyIDHuid0KcyHrq2LFnv
   o/KWXG8cVVorTD0Wg41kcolcozwvX8bRhQgLdhhsNWxvUWKlWaLBiLLHJ
   JhW6ai+IvOT5tSv7mLSqqJ0w+niCX8YtYNNx4QFJw6sk43EaHPRh0wKQs
   2sWy8gwmHCy0CsYyFOSgSp+pRWSV3mKpVt9jstlkh/KUEeeRNg0yeAIr/
   R1vbm8GaYpONwFLOhLb2gSKEDx+Xws3zXzMf5JWOPTM8rrSbSfXvANaol
   bC0J6xeaHxGV/tDrbWjCDyVOKUyVd05twiKpaiDRVX0btfanTrNqbydpa
   g==;
X-IronPort-AV: E=Sophos;i="5.96,228,1665417600"; 
   d="scan'208";a="322601497"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2022 09:46:07 +0800
IronPort-SDR: DURKbpxFiTLUJhddDagC0lyZ7SpusU8+5EjUsxnkIE4r3BVHt8X3qkmplj4U1c3OWJdXdds4Fa
 F28k67GKgLWmEeVBOQyGDlQK4cT/C/YldeHhDrquo6ByGG8fgVtD5rJcDCC4OkE/PlPdAN2fiC
 N4ISDXPAPmbCrwKVZcG348uZk9XIkjSbdi/31SqVhVI7rynVDaLrHak9vkipES4elEz3/L33TL
 hlt7IQQiAQ9DBHMljoxSVCHnNi7PPCdm9hs6BE1iKil/FSdSdC6XHzGbyYn11sMrWIrVH5QF1G
 zRk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Dec 2022 17:04:36 -0800
IronPort-SDR: 0KrPK8eafjWAa6BA2GALVxzIoxzQjwb+0hpGcBwAcVYFvmnJgTzrLQAV7Duc+uwVdCiOmVQ7tU
 XzZXs0ZfXN53kSkErdkebZ8uok0i2KhOobZokb6V56eRITrhdgwMVVWHNEkC02XEfBkLz26vdu
 EQwu8sZ2N8hmxM2ZJxwrJzWnlLpb075USPHLv4qyubMFXXXaPG8dvLiCYKDxqt51wM38H7O39t
 HWj4vifC7/lAAsk7PB2yG7YI33qZeutFtj/OLXi3jYI1BBhfa0cUJ6qEsgIikJEFTOEP9JbdUw
 bSc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Dec 2022 17:46:08 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NSv4Z67xlz1RwtC
        for <linux-block@vger.kernel.org>; Thu,  8 Dec 2022 17:46:06 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670550365; x=1673142366; bh=XTiN2sIKIG3nGeB11c5KGlQQNx+mIfr34pi
        /QYArEGQ=; b=Tstr7M50L/ynXzMXY0G+asPqEABEV61zYPWXH+Y2MqEcLtAtxdA
        iwk9+i4zVTZ/++69FqszRKzJ9/vTqI5Tr2vfx7/r23I73CAkW/4QnMuLWG5DHqEB
        Eo7ZCkxELrzWgi8D2r4zA7tBR7417fv5Uq7CK0Mc4vTqbpx3lS95/yFEdrdBo32X
        FMHBF0dB7RzENSLql8OiiVoGELNA/yrEhGtgmO9gLe7HaYazh/Ml8Mtxa6Ewk1fL
        MOW1BSsck6nK7dJiudjPSlltdFh/urZhsP6LNwam4C6CKydQ4uI9Zx1YlAEvlu7k
        7Q6IJH7mPzi1RpMOH2zEXSmW/TbOy4VBkGQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QBJIWxYQ4XoF for <linux-block@vger.kernel.org>;
        Thu,  8 Dec 2022 17:46:05 -0800 (PST)
Received: from [10.225.163.85] (unknown [10.225.163.85])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NSv4X4gpYz1RvLy;
        Thu,  8 Dec 2022 17:46:04 -0800 (PST)
Message-ID: <2678a347-188a-1f2a-27ec-67e7caa38175@opensource.wdc.com>
Date:   Fri, 9 Dec 2022 10:46:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V9 7/8] block, bfq: inject I/O to underutilized actuators
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Davide Zini <davidezini2@gmail.com>
References: <20221208104351.35038-1-paolo.valente@linaro.org>
 <20221208104351.35038-8-paolo.valente@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221208104351.35038-8-paolo.valente@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/8/22 19:43, Paolo Valente wrote:
> From: Davide Zini <davidezini2@gmail.com>
> 
> The main service scheme of BFQ for sync I/O is serving one sync
> bfq_queue at a time, for a while. In particular, BFQ enforces this
> scheme when it deems the latter necessary to boost throughput or
> to preserve service guarantees. Unfortunately, when BFQ enforces
> this policy, only one actuator at a time gets served for a while,
> because each bfq_queue contains I/O only for one actuator. The
> other actuators may remain underutilized.
> 
> Actually, BFQ may serve (inject) extra I/O, taken from other
> bfq_queues, in parallel with that of the in-service queue. This
> injection mechanism may provide the ground for dealing also with
> the above actuator-underutilization problem. Yet BFQ does not take
> the actuator load into account when choosing which queue to pick
> extra I/O from. In addition, BFQ may happen to inject extra I/O
> only when the in-service queue is temporarily empty.
> 
> In view of these facts, this commit extends the
> injection mechanism in such a way that the latter:
> (1) takes into account also the actuator load;
> (2) checks such a load on each dispatch, and injects I/O for an
>     underutilized actuator, if there is one and there is I/O for it.
> 
> To perform the check in (2), this commit introduces a load
> threshold, currently set to 4.  A linear scan of each actuator is
> performed, until an actuator is found for which the following two
> conditions hold: the load of the actuator is below the threshold,
> and there is at least one non-in-service queue that contains I/O
> for that actuator. If such a pair (actuator, queue) is found, then
> the head request of that queue is returned for dispatch, instead
> of the head request of the in-service queue.
> 
> We have set the threshold, empirically, to the minimum possible
> value for which an actuator is fully utilized, or close to be
> fully utilized. By doing so, injected I/O 'steals' as few
> drive-queue slots as possibile to the in-service queue. This
> reduces as much as possible the probability that the service of
> I/O from the in-service bfq_queue gets delayed because of slot
> exhaustion, i.e., because all the slots of the drive queue are
> filled with I/O injected from other queues (NCQ provides for 32
> slots).
> 
> This new mechanism also counters actuator underutilization in the
> case of asymmetric configurations of bfq_queues. Namely if there
> are few bfq_queues containing I/O for some actuators and many
> bfq_queues containing I/O for other actuators. Or if the
> bfq_queues containing I/O for some actuators have lower weights
> than the other bfq_queues.
> 
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> Signed-off-by: Davide Zini <davidezini2@gmail.com>

[...]

> @@ -4792,22 +4799,69 @@ bfq_choose_bfqq_for_injection(struct bfq_data *bfqd)
>  			else
>  				limit = in_serv_bfqq->inject_limit;
>  
> -			if (bfqd->rq_in_driver < limit) {
> +			if (bfqd->tot_rq_in_driver < limit) {
>  				bfqd->rqs_injected = true;
>  				return bfqq;
>  			}
>  		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct bfq_queue *
> +bfq_find_active_bfqq_for_actuator(struct bfq_data *bfqd, int idx)
> +{
> +	struct bfq_queue *bfqq = NULL;

I do not think that you need the NULL initialization here.

> +
> +	if (bfqd->in_service_queue &&
> +	    bfqd->in_service_queue->actuator_idx == idx)
> +		return bfqd->in_service_queue;
> +
> +	list_for_each_entry(bfqq, &bfqd->active_list[idx], bfqq_list) {
> +		if (!RB_EMPTY_ROOT(&bfqq->sort_list) &&
> +			bfq_serv_to_charge(bfqq->next_rq, bfqq) <=
> +				bfq_bfqq_budget_left(bfqq)) {
> +			return bfqq;
> +		}
> +	}
>  
>  	return NULL;
>  }

Otherwise looks OK.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

