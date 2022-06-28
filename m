Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63950C43334
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 17:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiF1Roo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 13:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbiF1Ron (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 13:44:43 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7159465F4
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 10:44:42 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id c205so12648736pfc.7
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 10:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vmx3dWiK+p+1LEESJLJo3J9eRTy6x3i3ziXNZo+AP+o=;
        b=P0vHQDtjsBUd/v64sgFCOYAClS90kBzOnjyjQvuKm1EudKzx0Ac14HBelQOw3nYaD3
         IXYks+9GgeNFCj6ze/RDidmwnBYjMFrtXi5XVfUkM7KPXaeV6X2ZK70eUvQ3+YL8RUKB
         MAb6UeUagSGAS3U0f3pW1Cmgbtt/Tx0ZBkCMd3XmjMYrRz3nO6sq7l23jVc3Y5HqfdCW
         FAZYiNasrET79uA9J+H7ELX4gxsF++oiXED9ER4DEgcajhrOulghspdtvFA7CENfwPEy
         nuMF7TgxZXU3WUer9jkVFv3J8uJu+n2hzyZWllUJtp+t3yYySRGNwhIhgsI03essw/aQ
         9YNw==
X-Gm-Message-State: AJIora/MFahbQpwnq83QIX/M+8Mvr1VT7Dp3px3VL4VQ9HEmyrTegh3j
        cpBmtED23miPsvPf7i1XGsg=
X-Google-Smtp-Source: AGRyM1sPVslnpL5O/YL7Vs4UAMnxU3xUbdmTGXQRzE0yosA1QH4bDAnUI2gJe+4soCVd+0R6wwuWsw==
X-Received: by 2002:a63:7844:0:b0:40c:9792:5d6d with SMTP id t65-20020a637844000000b0040c97925d6dmr18142529pgc.360.1656438281523;
        Tue, 28 Jun 2022 10:44:41 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:3879:b18f:db0d:205? ([2620:15c:211:201:3879:b18f:db0d:205])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902710400b00162037fbb68sm9560137pll.215.2022.06.28.10.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 10:44:40 -0700 (PDT)
Message-ID: <5026ae37-85fc-b7c0-d1e7-efbaaaaa0959@acm.org>
Date:   Tue, 28 Jun 2022 10:44:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 8/8] nvme: Enable pipelining of zoned writes
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
References: <20220627234335.1714393-1-bvanassche@acm.org>
 <20220627234335.1714393-9-bvanassche@acm.org>
 <YrpyeemonjF3Lv/z@kbusch-mbp.dhcp.thefacebook.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <YrpyeemonjF3Lv/z@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/27/22 20:16, Keith Busch wrote:
> On Mon, Jun 27, 2022 at 04:43:35PM -0700, Bart Van Assche wrote:
>> @@ -854,6 +854,12 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
>>   	if (req->cmd_flags & REQ_RAHEAD)
>>   		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
>>   
>> +	if (blk_queue_pipeline_zoned_writes(req->q) &&
>> +	    blk_rq_is_seq_zone_write(req))
>> +		nvme_req(req)->max_retries =
>> +			min(0UL + type_max(typeof(nvme_req(req)->max_retries)),
>> +			    nvme_req(req)->max_retries + req->q->nr_requests);
> 
> I can't make much sense of what the above is trying to accomplish. This
> reevaluates max_retries every time the request is retried, and the new
> max_retries is based on the previous max_retries?

Hi Keith,

Thanks for your question. It made me realize that the above code should be
moved. How about replacing patch 8/8 with the (untested) patch below?

Thanks,

Bart.


Subject: [PATCH] nvme: Enable pipelining of zoned writes

Enabling pipelining for zoned writes. Increase the number of retries
for zoned writes to the maximum number of outstanding commands per hardware
queue.


diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index aeeaca1c3197..6a0b824a343f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -630,10 +630,15 @@ EXPORT_SYMBOL_NS_GPL(nvme_put_ns, NVME_TARGET_PASSTHRU);

  static inline void nvme_clear_nvme_request(struct request *req)
  {
+	u32 max_retries = nvme_max_retries;
+
  	nvme_req(req)->status = 0;
  	nvme_req(req)->retries = 0;
  	nvme_req(req)->flags = 0;
-	nvme_req(req)->max_retries = nvme_max_retries;
+	if (blk_queue_pipeline_zoned_writes(req->q) &&
+	    blk_rq_is_seq_zone_write(req))
+		max_retries += req->q->nr_requests;
+	nvme_req(req)->max_retries = min(0xffU, max_retries);
  	req->rq_flags |= RQF_DONTPREP;
  }

diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 9f81beb4df4e..0b10db3b8d3a 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -54,6 +54,8 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
  	struct nvme_id_ns_zns *id;
  	int status;

+	blk_queue_flag_set(QUEUE_FLAG_PIPELINE_ZONED_WRITES, ns->queue);
+
  	/* Driver requires zone append support */
  	if ((le32_to_cpu(log->iocs[nvme_cmd_zone_append]) &
  			NVME_CMD_EFFECTS_CSUPP)) {
