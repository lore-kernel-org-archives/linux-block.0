Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE1EC07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 03:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F62A2082D
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 03:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="x0J3U+zj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F62A2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeLGDei (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 22:34:38 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37118 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGDei (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 22:34:38 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so1162330plr.4
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 19:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wYYVI1ZQvqHTNSyFIOkP+j90ajmQeZj7B5YbyYFFvhM=;
        b=x0J3U+zjEMawL0idEB7cFaja3XK2XoF2zzC/KP1vwVUpkMVwW2wYKtBEmYcgzzsGpQ
         5+zjX/Ss1oljMDkmzqq3vloVVYNJ+9rHDKwJ0miw8lXdFjB9n4cx+rwleVbjkAnqQHb/
         HrwHyMW+/Ku9qpYrLA43vjkOZNo3l5Wz3VxQygMe0CfNt9epRbHc9BCfQcQHxKgdEvQQ
         N/S5qFwA+2iogITUoa00zzqnuyPMX2kZF2ZOGL6jrbhu9UXHfNP/FVbp3QuTeTkwfjdM
         nfzzaOMAblyD007lq4PhaZOBXiYEW4Oc4gH/Q+5PBpe5h6/pxAxEOHTrFS+hVD8YYwES
         fjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wYYVI1ZQvqHTNSyFIOkP+j90ajmQeZj7B5YbyYFFvhM=;
        b=t7HUb3tbOlQ+eQM+nohr9WPHrqlDEvmLKY0UEZva1+Q+jUuaO6DHwr0sxqBjvWnkPi
         0lvYPNJCIxCYymN7lTHwThfPbekrzO2Vc3F0qt/M/6kJlu8xUvrD+sJQ80vMOhVFBKM2
         sn74oJTGdKOD38jQB5c5F9z/ggm6A1QgjmNn0ccYGlMCzNMiKyccdI9ToRqhud2rbNyx
         w4/XubEUZQjWwiRKjZeydFavHShE7eQftwCoIwWBMoG1JdAxQA8YfobU7+eyhCyqOOm5
         N+W0PsjYddldlhixeNWBshBXs/M4Vc7Pn0+V9ytjtBqqiMMfIVVTNuD13kA3JwXcs9rh
         DA8A==
X-Gm-Message-State: AA+aEWYAytTBJHTZhZEYipKNlqQ/skagOxPFK68mVFr7PRmU7XtBBT4a
        qPSzeGlgXjO6maW52IxmaA9kjOAcmF0=
X-Google-Smtp-Source: AFSGD/XlZ25pIYCgTUW0+pWL77cq782G/X2/H4chWFbnSHZSdfEHVSVk6LXwR0+JYqiL/Hb76iQOxg==
X-Received: by 2002:a17:902:3064:: with SMTP id u91mr583616plb.325.1544153678007;
        Thu, 06 Dec 2018 19:34:38 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id w11sm1792963pgk.16.2018.12.06.19.34.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 19:34:37 -0800 (PST)
Subject: Re: [PATCH V11 0/4] blk-mq: refactor code of issue directly
From:   Jens Axboe <axboe@kernel.dk>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1544152185-32667-1-git-send-email-jianchao.w.wang@oracle.com>
 <b2bcbb76-af6f-7660-2bc3-9796338cccff@kernel.dk>
 <0adf3419-bcce-93d8-51fb-aee7cbb5ae17@oracle.com>
 <16205e68-aa5e-c59d-364e-4164a0e51dc7@kernel.dk>
Message-ID: <f052c016-e521-9f12-f4e5-d65f3814643a@kernel.dk>
Date:   Thu, 6 Dec 2018 20:34:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <16205e68-aa5e-c59d-364e-4164a0e51dc7@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 8:32 PM, Jens Axboe wrote:
> On 12/6/18 8:26 PM, jianchao.wang wrote:
>>
>>
>> On 12/7/18 11:16 AM, Jens Axboe wrote:
>>> On 12/6/18 8:09 PM, Jianchao Wang wrote:
>>>> Hi Jens
>>>>
>>>> Please consider this patchset for 4.21.
>>>>
>>>> It refactors the code of issue request directly to unify the interface
>>>> and make the code clearer and more readable.
>>>>
>>>> This patch set is rebased on the recent for-4.21/block and add the 1st
>>>> patch which inserts the non-read-write request to hctx dispatch
>>>> list to avoid to involve merge and io scheduler when bypass_insert
>>>> is true, otherwise, inserting is ignored, BLK_STS_RESOURCE is returned
>>>> and the caller will fail forever.
>>>>
>>>> The 2nd patch refactors the code of issue request directly to unify the
>>>> helper interface which could handle all the cases.
>>>>
>>>> The 3rd patch make blk_mq_sched_insert_requests issue requests directly
>>>> with 'bypass' false, then it needn't to handle the non-issued requests
>>>> any more.
>>>>
>>>> The 4th patch replace and kill the blk_mq_request_issue_directly.
>>>
>>> Sorry to keep iterating on this, but let's default to inserting to
>>> the dispatch list if we ever see busy from a direct dispatch. I'm fine
>>> with doing that for 4.21, as suggested by Ming, I just didn't want to
>>> fiddle with it for 4.20. This will prevent any merging on the request
>>> going forward, which I think is a much safer default.
>>>
>>> You do this already for some cases. Let's do it unconditionally for
>>> a request that was ever subjected to ->queue_rq() and we didn't either
>>> error or finish after the fact.
>>>
>> I have done it in this version if I get your point correctly.
>> Please refer to the following fragment in the 2nd patch.
>>
>> +	/*
>> +	 * If the request is issued unsuccessfully with
>> +	 * BLK_STS_DEV_RESOURCE or BLK_STS_RESOURCE, insert
>> +	 * the request to hctx dispatch list due to attached
>> +	 * lldd resource.
>> +	 */
>> +	force = true;
>> +	ret = __blk_mq_issue_directly(hctx, rq, cookie, last);
>> +out_unlock:
>> +	hctx_unlock(hctx, srcu_idx);
>> +out:
>> +	switch (ret) {
>> +	case BLK_STS_OK:
>> +		break;
>> +	case BLK_STS_DEV_RESOURCE:
>> +	case BLK_STS_RESOURCE:
>> +		if (force) {
>> +			blk_mq_request_bypass_insert(rq, run_queue);
>> +			ret = bypass ? BLK_STS_OK : ret;
>> +		} else if (!bypass) {
>> +			blk_mq_sched_insert_request(rq, false,
>> +						    run_queue, false);
>> +		}
>> +		break;
>> +	default:
> 
> You are right, I missed that you set force = true before doing the
> issue. So this looks good to me!

I applied your series. With this, we should be good to remove the
REQ_NOMERGE logic that was added for the corruption case, and the
blk_rq_can_direct_dispatch() as well?

-- 
Jens Axboe

