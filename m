Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2ED1C6FA99
	for <linux-block@archiver.kernel.org>; Tue,  7 Mar 2023 12:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjCGMbz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Mar 2023 07:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjCGMby (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 07:31:54 -0500
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDE274DFC
        for <linux-block@vger.kernel.org>; Tue,  7 Mar 2023 04:31:50 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id k37so7687940wms.0
        for <linux-block@vger.kernel.org>; Tue, 07 Mar 2023 04:31:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678192309;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLelsIhbKWpc5yapdbqbzgpAdEx7KGy/2HW3dZElm4A=;
        b=nvkadfR8euJL2EoVZFnydy7VT+b/PAcZ09HjrHctzx7cJLQVrq0RTyDcR9uSRrzVP0
         CHHftczPAdMk00K5S3UUlVkZwGdls1X5tvwnRUjLLmcgnn6R0CRwNfwXQUKHsuc3CdGK
         Ihvi3MZBqSjxoaQktt7Qa4KNv/96Wu/N/vhfkzSEWUoFYFF0QQkn6YYa8A4bSQXLgApG
         rcsqCooTxNuqpY7RuuX/ZwEHSZCzzJbXn4tIuJY5uUqdH8DrIWKdiCcR4QtmeKI+vp71
         phk/egqy8t2WU4+L8EQBk1Qnm+fANvib1+dyYSezmmzUuVKxhUfX3k69KLgGM58hsHU0
         GQEg==
X-Gm-Message-State: AO0yUKV/QkDCDG7UykvuNpBwRkE0Wliy8ft5RaqXZKbt6AavnT6fJ/Lf
        BY8IJgjLoBBV9FTZe4WAb0I=
X-Google-Smtp-Source: AK7set8uO67EW1fFLUJ3WLSFMzfQAPt+Do3v9sT5ZOc4T+FkfRRyHSR19PbfeUIDoJ+LDUPeDme5UA==
X-Received: by 2002:a05:600c:1c1f:b0:3e7:f108:6456 with SMTP id j31-20020a05600c1c1f00b003e7f1086456mr11640006wms.0.1678192309494;
        Tue, 07 Mar 2023 04:31:49 -0800 (PST)
Received: from [10.100.102.14] (46-116-231-83.bb.netvision.net.il. [46.116.231.83])
        by smtp.gmail.com with ESMTPSA id o33-20020a05600c512100b003e209186c07sm19403727wms.19.2023.03.07.04.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 04:31:49 -0800 (PST)
Message-ID: <aeb59707-00ad-bc57-9f91-ef5757de9294@grimberg.me>
Date:   Tue, 7 Mar 2023 14:31:48 +0200
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
 <4faf272f-470e-1c2d-d23e-752ccbb01a31@grimberg.me>
 <ZAcqj9tM8/Dq9MNn@ovpn-8-16.pek2.redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZAcqj9tM8/Dq9MNn@ovpn-8-16.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/7/23 14:14, Ming Lei wrote:
> On Tue, Mar 07, 2023 at 01:39:27PM +0200, Sagi Grimberg wrote:
>>
>>
>> On 3/6/23 23:49, Ming Lei wrote:
>>> On Mon, Mar 06, 2023 at 04:21:08PM +0200, Sagi Grimberg wrote:
>>>>
>>>>
>>>> On 3/4/23 01:13, Ming Lei wrote:
>>>>> When investigating one customer report on warning in nvme_setup_discard,
>>>>> we observed the controller(nvme/tcp) actually exposes
>>>>> queue_max_discard_segments(req->q) == 1.
>>>>>
>>>>> Obviously the current code can't handle this situation, since contiguity
>>>>> merge like normal RW request is taken.
>>>>>
>>>>> Fix the issue by building range from request sector/nr_sectors directly.
>>>>>
>>>>> Fixes: b35ba01ea697 ("nvme: support ranged discard requests")
>>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>>> ---
>>>>>     drivers/nvme/host/core.c | 28 +++++++++++++++++++---------
>>>>>     1 file changed, 19 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>>> index c2730b116dc6..d4be525f8100 100644
>>>>> --- a/drivers/nvme/host/core.c
>>>>> +++ b/drivers/nvme/host/core.c
>>>>> @@ -781,16 +781,26 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
>>>>>     		range = page_address(ns->ctrl->discard_page);
>>>>>     	}
>>>>> -	__rq_for_each_bio(bio, req) {
>>>>> -		u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
>>>>> -		u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
>>>>> -
>>>>> -		if (n < segments) {
>>>>> -			range[n].cattr = cpu_to_le32(0);
>>>>> -			range[n].nlb = cpu_to_le32(nlb);
>>>>> -			range[n].slba = cpu_to_le64(slba);
>>>>> +	if (queue_max_discard_segments(req->q) == 1) {
>>>>> +		u64 slba = nvme_sect_to_lba(ns, blk_rq_pos(req));
>>>>> +		u32 nlb = blk_rq_sectors(req) >> (ns->lba_shift - 9);
>>>>> +
>>>>> +		range[0].cattr = cpu_to_le32(0);
>>>>> +		range[0].nlb = cpu_to_le32(nlb);
>>>>> +		range[0].slba = cpu_to_le64(slba);
>>>>> +		n = 1;
>>>>> +	} else {
>>>>> +		__rq_for_each_bio(bio, req) {
>>>>> +			u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
>>>>> +			u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
>>>>> +
>>>>> +			if (n < segments) {
>>>>> +				range[n].cattr = cpu_to_le32(0);
>>>>> +				range[n].nlb = cpu_to_le32(nlb);
>>>>> +				range[n].slba = cpu_to_le64(slba);
>>>>> +			}
>>>>> +			n++;
>>>>>     		}
>>>>> -		n++;
>>>>>     	}
>>>>>     	if (WARN_ON_ONCE(n != segments)) {
>>>>
>>>>
>>>> Maybe just set segments to min(blk_rq_nr_discard_segments(req),
>>>> queue_max_discard_segments(req->q)) and let the existing code do
>>>> its thing?
>>>
>>> What is the existing code for applying min()?
>>
>> Was referring to this:
>> --
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 3345f866178e..dbc402587431 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -781,6 +781,7 @@ static blk_status_t nvme_setup_discard(struct nvme_ns
>> *ns, struct request *req,
>>                  range = page_address(ns->ctrl->discard_page);
>>          }
>>
>> +       segments = min(segments, queue_max_discard_segments(req->q));
> 
> That can't work.
> 
> In case of queue_max_discard_segments(req->q) == 1, the request still
> can have more than one bios since the normal merge is taken for discard
> IOs.

Ah, I see, the bios are contiguous though right?
We could add a contiguity check in the loop and conditionally
increment n, but maybe that would probably be more complicated...
