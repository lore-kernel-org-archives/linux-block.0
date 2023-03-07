Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2E8C678D5
	for <linux-block@archiver.kernel.org>; Tue,  7 Mar 2023 11:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjCGLrc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Mar 2023 06:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjCGLrO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 06:47:14 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D85D7E780
        for <linux-block@vger.kernel.org>; Tue,  7 Mar 2023 03:45:32 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h14so11799331wru.4
        for <linux-block@vger.kernel.org>; Tue, 07 Mar 2023 03:45:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678189170;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z4AqwyhsogAdfB7Yjm5ZST+aFqwS9AWOEAodjAAj1F0=;
        b=FAV23g8QfpRYnyfRKrNe6ImrYnlziOROw2qv4QvMIfXO0q8OcGsl+1MzZj7EB9U6cG
         c87WZmCFM3ClbXfoThjE/il4Wb4Iqr2ZYd28Cu8sH2UpiU8iYqc4XbevPjI1GCbdt0OS
         kx9K5GcnU04iMqpjX/VkZLSTYhpXa8YQEWsP5E+Ku5Cjpp5cqdcfZ+HtWBh0/DLvUqXJ
         qh0gTIZOYdsxpz+vBABFgxxKX3Ae50ZbTWOw0il2ps/B42zHnyxudyc5NzF04ZxpKN7s
         NAfymKAdr6a53yom7ASbmtHAXawdxNIC/eocMWCmFRPedTbN64A/YHxUio9DqaD8wiPQ
         zY2Q==
X-Gm-Message-State: AO0yUKXnJKnyntvS2Y38eJ/sdwoXTY11NYxGcE13LVU2vW8mbG7ocDFk
        QmFb+pHpU2y2E23loLXelvo=
X-Google-Smtp-Source: AK7set8eJVSEc0/8WKaRaPkWBnGkf/MjXS+9QcfOSwlNwtAmO08KHIPwyo5i2Ffin4dQV64YxUH3YQ==
X-Received: by 2002:adf:d4c6:0:b0:2c8:207d:c10e with SMTP id w6-20020adfd4c6000000b002c8207dc10emr7925212wrk.1.1678189169592;
        Tue, 07 Mar 2023 03:39:29 -0800 (PST)
Received: from [10.100.102.14] (46-116-231-83.bb.netvision.net.il. [46.116.231.83])
        by smtp.gmail.com with ESMTPSA id x8-20020adff648000000b002c3dc4131f5sm12467949wrp.18.2023.03.07.03.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 03:39:29 -0800 (PST)
Message-ID: <4faf272f-470e-1c2d-d23e-752ccbb01a31@grimberg.me>
Date:   Tue, 7 Mar 2023 13:39:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] nvme: fix handling single range discard request
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20230303231345.119652-1-ming.lei@redhat.com>
 <125e291a-5225-6565-e800-e6bdb6be35f3@grimberg.me>
 <ZAZfzT02hNQ6bb8P@ovpn-8-26.pek2.redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZAZfzT02hNQ6bb8P@ovpn-8-26.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/6/23 23:49, Ming Lei wrote:
> On Mon, Mar 06, 2023 at 04:21:08PM +0200, Sagi Grimberg wrote:
>>
>>
>> On 3/4/23 01:13, Ming Lei wrote:
>>> When investigating one customer report on warning in nvme_setup_discard,
>>> we observed the controller(nvme/tcp) actually exposes
>>> queue_max_discard_segments(req->q) == 1.
>>>
>>> Obviously the current code can't handle this situation, since contiguity
>>> merge like normal RW request is taken.
>>>
>>> Fix the issue by building range from request sector/nr_sectors directly.
>>>
>>> Fixes: b35ba01ea697 ("nvme: support ranged discard requests")
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>    drivers/nvme/host/core.c | 28 +++++++++++++++++++---------
>>>    1 file changed, 19 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index c2730b116dc6..d4be525f8100 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -781,16 +781,26 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
>>>    		range = page_address(ns->ctrl->discard_page);
>>>    	}
>>> -	__rq_for_each_bio(bio, req) {
>>> -		u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
>>> -		u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
>>> -
>>> -		if (n < segments) {
>>> -			range[n].cattr = cpu_to_le32(0);
>>> -			range[n].nlb = cpu_to_le32(nlb);
>>> -			range[n].slba = cpu_to_le64(slba);
>>> +	if (queue_max_discard_segments(req->q) == 1) {
>>> +		u64 slba = nvme_sect_to_lba(ns, blk_rq_pos(req));
>>> +		u32 nlb = blk_rq_sectors(req) >> (ns->lba_shift - 9);
>>> +
>>> +		range[0].cattr = cpu_to_le32(0);
>>> +		range[0].nlb = cpu_to_le32(nlb);
>>> +		range[0].slba = cpu_to_le64(slba);
>>> +		n = 1;
>>> +	} else {
>>> +		__rq_for_each_bio(bio, req) {
>>> +			u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
>>> +			u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
>>> +
>>> +			if (n < segments) {
>>> +				range[n].cattr = cpu_to_le32(0);
>>> +				range[n].nlb = cpu_to_le32(nlb);
>>> +				range[n].slba = cpu_to_le64(slba);
>>> +			}
>>> +			n++;
>>>    		}
>>> -		n++;
>>>    	}
>>>    	if (WARN_ON_ONCE(n != segments)) {
>>
>>
>> Maybe just set segments to min(blk_rq_nr_discard_segments(req),
>> queue_max_discard_segments(req->q)) and let the existing code do
>> its thing?
> 
> What is the existing code for applying min()?

Was referring to this:
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3345f866178e..dbc402587431 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -781,6 +781,7 @@ static blk_status_t nvme_setup_discard(struct 
nvme_ns *ns, struct request *req,
                 range = page_address(ns->ctrl->discard_page);
         }

+       segments = min(segments, queue_max_discard_segments(req->q));
         __rq_for_each_bio(bio, req) {
                 u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
                 u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
--
