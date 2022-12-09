Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149EBC4332F
	for <linux-block@archiver.kernel.org>; Fri,  9 Dec 2022 01:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiLIBju (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Dec 2022 20:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiLIBjt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Dec 2022 20:39:49 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059C779C3F
        for <linux-block@vger.kernel.org>; Thu,  8 Dec 2022 17:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670549987; x=1702085987;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M6QdSScwkgnPPa2HAQN35MPiKz4GT+GPIMIfvnunvrc=;
  b=DJLgvFEacdtmyBxoZbNAyO3o/aMJL7F5xkM45WsEL9is/UnG2MB1KiV1
   rxKuTXbgYwO1ftePJ53zUob/KWoETugngMzf6yQ7AK4hfnWl5hJlmQTVt
   D88Nr+eR399mnjzyuETbhM8nScPYXBzjMAdFp8ZI1+cRaeunuO3QeJeW0
   XD1s55VBxVmIbuUf8/uY+XeBj3O3+FBW8IemEgdyArfzNacfSYmBrX+7/
   S375xrAC1bJvd7FBxDE0goRVK7rAJAIGL6NIl4vmyjWkmdWGAvRDz8dhR
   019uiqqgdydQ85wRkZhl/RLIC3SC8SRtFydDnMXzGEOIbHbreKJ9OompJ
   g==;
X-IronPort-AV: E=Sophos;i="5.96,228,1665417600"; 
   d="scan'208";a="216449922"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2022 09:39:47 +0800
IronPort-SDR: o8HbHbXi6JUYFNaW64416ujQ0A2vyjDT6nlK4ZhGH9sH/ddqtRnibChz8G8AKYS9kX3dOv/5Ke
 MTTg5fZt8Ah61WBYl9OktFZe6MxBuEvWEikiAKfFoOG7fV8XjHMxUXXw7fTrcl0FA2o6RgkXJj
 v0Pph2e2XKnfqOp8xwLm97wkxBvxE7r/LhQDV49w0oE1vqvV4Ln5jFgKvEfcGwfYQSfElpqm67
 gowPFS2XhGYS40QEZXRaV882+LOX45rv4ttsoaA8YPQB1HpF8dWA6lVXzEG1DcSxLrJvJcog1l
 HO8=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Dec 2022 16:58:16 -0800
IronPort-SDR: 0xcHt4OzfL9BxCU3N7IpAPk/u0vNVwPRnJF1adlHhqN/TGk8nR8rMiyZ0gOH+dr6T3WWuvRRjj
 OGlNd5ypVxBhxbNo/loS3crmnnb6MjYVjTvzmAZ9Adm0vhyqelFbFPV7tv54jGEfyBvlPw4jpS
 DxYc5zINielAGC5985ZnlP6bGUDcQ5ANJdb2L2uYIcbHwxqQ1APBTY9j23oI0RfffldhHVQ4oZ
 EV9Zkl9o3kvx3yPxIyvaVfhaCvfuog5OZxZm74Nsuq8CKUl6tP4ISC5HPDjK/AuBUWs+lypK5z
 Z+w=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Dec 2022 17:39:48 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NStxH0GVNz1Rwt8
        for <linux-block@vger.kernel.org>; Thu,  8 Dec 2022 17:39:47 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670549986; x=1673141987; bh=M6QdSScwkgnPPa2HAQN35MPiKz4GT+GPIMI
        fvnunvrc=; b=FEljMCNLraoa+2tLSXBDCBuxyO6Y3shBGtcnBX6B+2oe4CMKhYW
        HrM6TALjVEY8v6VsisWHAMiPszm3v2xuiZ79Gm1gB30jyzJg5vtKCS5O+rKnp/DS
        ImP7YOAdgG7hwp4kG74tL/EUEonpbIspqfTH1cB3JJLX2rTpbwuSAxubazldeAOO
        NYUWp0409hT3gzicojwjebygHhdL4UnzTOeGH9OMwtrD0tt0idMWL1ybMDTqkLHn
        TdvNuFj9o/c/MrXUacPNzO+yb8CZAduzL0thvpQoOi3GgldGrtTa/IQClIvGQ+fF
        /NAoUTmewoPvoy7vhP06aiWRFlRzoHm9Gnw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lLg29aUXsEtv for <linux-block@vger.kernel.org>;
        Thu,  8 Dec 2022 17:39:46 -0800 (PST)
Received: from [10.225.163.85] (unknown [10.225.163.85])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NStxD5RDLz1RvLy;
        Thu,  8 Dec 2022 17:39:44 -0800 (PST)
Message-ID: <c074f125-97d7-d3b2-2976-b69b852a0069@opensource.wdc.com>
Date:   Fri, 9 Dec 2022 10:39:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V9 6/8] block, bfq: retrieve independent access ranges
 from request queue
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, Federico Gavioli <f.gavioli97@gmail.com>
References: <20221208104351.35038-1-paolo.valente@linaro.org>
 <20221208104351.35038-7-paolo.valente@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221208104351.35038-7-paolo.valente@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/8/22 19:43, Paolo Valente wrote:
> From: Federico Gavioli <f.gavioli97@gmail.com>
> 
> This patch implements the code to gather the content of the
> independent_access_ranges structure from the request_queue and copy
> it into the queue's bfq_data. This copy is done at queue initialization.
> 
> We copy the access ranges into the bfq_data to avoid taking the queue
> lock each time we access the ranges.
> 
> This implementation, however, puts a limit to the maximum independent
> ranges supported by the scheduler. Such a limit is equal to the constant
> BFQ_MAX_ACTUATORS. This limit was placed to avoid the allocation of
> dynamic memory.
> 
> Co-developed-by: Rory Chen <rory.c.chen@seagate.com>
> Signed-off-by: Rory Chen <rory.c.chen@seagate.com>
> Signed-off-by: Federico Gavioli <f.gavioli97@gmail.com>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> ---
>  block/bfq-iosched.c | 60 +++++++++++++++++++++++++++++++++++++++------
>  block/bfq-iosched.h |  8 +++++-
>  2 files changed, 59 insertions(+), 9 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index dcecba3c6e23..957ce61faaf2 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -1839,10 +1839,25 @@ static bool bfq_bfqq_higher_class_or_weight(struct bfq_queue *bfqq,
>   */
>  static unsigned int bfq_actuator_index(struct bfq_data *bfqd, struct bio *bio)
>  {
> -	/*
> -	 * Multi-actuator support not complete yet, so always return 0
> -	 * for the moment (to keep incomplete mechanisms off).
> -	 */
> +	unsigned int i;
> +	sector_t end;
> +
> +	/* no search needed if one or zero ranges present */
> +	if (bfqd->num_actuators == 1)
> +		return 0;
> +
> +	/* bio_end_sector(bio) gives the sector after the last one */
> +	end = bio_end_sector(bio) - 1;
> +
> +	for (i = 0; i < bfqd->num_actuators; i++) {
> +		if (end >= bfqd->sector[i] &&
> +		    end < bfqd->sector[i] + bfqd->nr_sectors[i])
> +			return i;
> +	}
> +
> +	WARN_ONCE(true,
> +		  "bfq_actuator_index: bio sector out of ranges: end=%llu\n",
> +		  end);
>  	return 0;
>  }
>  
> @@ -7160,6 +7175,8 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
>  {
>  	struct bfq_data *bfqd;
>  	struct elevator_queue *eq;
> +	unsigned int i;
> +	struct blk_independent_access_ranges *ia_ranges = q->disk->ia_ranges;
>  
>  	eq = elevator_alloc(q, e);
>  	if (!eq)
> @@ -7202,12 +7219,39 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
>  
>  	bfqd->queue = q;
>  
> +	bfqd->num_actuators = 1;
>  	/*
> -	 * Multi-actuator support not complete yet, unconditionally
> -	 * set to only one actuator for the moment (to keep incomplete
> -	 * mechanisms off).
> +	 * If the disk supports multiple actuators, copy independent
> +	 * access ranges from the request queue structure.
>  	 */
> -	bfqd->num_actuators = 1;
> +	spin_lock_irq(&q->queue_lock);
> +	if (ia_ranges) {
> +		/*
> +		 * Check if the disk ia_ranges size exceeds the current bfq
> +		 * actuator limit.
> +		 */
> +		if (ia_ranges->nr_ia_ranges > BFQ_MAX_ACTUATORS) {
> +			pr_crit("nr_ia_ranges higher than act limit: iars=%d, max=%d.\n",
> +				ia_ranges->nr_ia_ranges, BFQ_MAX_ACTUATORS);
> +			pr_crit("Falling back to single actuator mode.\n");
> +		} else {
> +			bfqd->num_actuators = ia_ranges->nr_ia_ranges;
> +
> +			for (i = 0; i < bfqd->num_actuators; i++) {
> +				bfqd->sector[i] = ia_ranges->ia_range[i].sector;
> +				bfqd->nr_sectors[i] =
> +					ia_ranges->ia_range[i].nr_sectors;
> +			}
> +		}
> +	}
> +
> +	/* Otherwise use single-actuator dev info */
> +	if (bfqd->num_actuators == 1) {
> +		bfqd->sector[0] = 0;
> +		bfqd->nr_sectors[0] =
> +			bdev_nr_sectors(dev_to_bdev(disk_to_dev(q->disk)));

get_capacity(q->disk) would be simpler.

> +	}
> +	spin_unlock_irq(&q->queue_lock);
>  
>  	INIT_LIST_HEAD(&bfqd->dispatch);
>  
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 1450990dba32..953980de6b4b 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -810,7 +810,13 @@ struct bfq_data {
>  	 * case of single-actuator drives.
>  	 */
>  	unsigned int num_actuators;
> -
> +	/*
> +	 * Disk independent access ranges for each actuator
> +	 * in this device.
> +	 */
> +	sector_t sector[BFQ_MAX_ACTUATORS];
> +	sector_t nr_sectors[BFQ_MAX_ACTUATORS];
> +	struct blk_independent_access_range ia_ranges[BFQ_MAX_ACTUATORS];
>  };
>  
>  enum bfqq_state_flags {

With the nit above fixed,

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

