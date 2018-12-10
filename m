Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3850AC07E85
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 01:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18992081C
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 01:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0O/Q3NfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18992081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbeLJB1N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Dec 2018 20:27:13 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38356 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbeLJB1N (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Dec 2018 20:27:13 -0500
Received: by mail-pg1-f193.google.com with SMTP id g189so4187249pgc.5
        for <linux-block@vger.kernel.org>; Sun, 09 Dec 2018 17:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0dkZmg8O8JvyV2dwERJbFRWuJ8cAGDXjXjdCBN7aqnM=;
        b=0O/Q3NfYm3hCnHk8QiaK99To7X3QD0i6V6InvF9a2ju34YQCT0glkacbCYwAuLIYfW
         mGSSct+YqK1VLsbIj8x1HkQiwEBlyQlw7psLHU0MNaJr7ned9oc8uEhrSD8bueTsyQkK
         +6WM3E91ua6NnWGfTJPLQwMwEf8ldO8F+63XD3hrB5c+Hm8EZ9rntcwtXjrQUC9PM7Hp
         yZKTk/2SMNde0X4vtP1vFrQfTPsvy5CCFB8bu3tP+85pw1FkI1WzHeqZpy9rQdw0OTLy
         p0B4e5ewDyIVRSD76b2JhkZRA+ue/YV2w5M7y0puG1nkHxpOPFTjo6VdAvfmsGOrkjIb
         Lo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0dkZmg8O8JvyV2dwERJbFRWuJ8cAGDXjXjdCBN7aqnM=;
        b=ruwllXLvG7701By4yskDHE6Zo9Sop10h736ExxoT+w4/s8sa54KzZbgFwElVgRohrO
         644K1tWuUl87AKqjBCndXylcI6pHprevGmhqDLko9vRnZneEhIIb9dWK60YHpZUt+clS
         irLJ/ehV3iPmGnBh0UeqvKIpqwccRWYTBB5TrN2iKZ2TRkEF8+GVImNffXwDiUM3xfvj
         zWub2bd5Tww4LNxybrj1gU52qlW09ce60XQc4dKgu92gP8AqVQPxCBvdplSq0vChY2c6
         51lPNHPlDoKNYvJcLqz7Xmzo3cnU3HK1ry5afKQcSxWk5wa85GFCGlvYWAB3KkI4aQaU
         xx7g==
X-Gm-Message-State: AA+aEWbGOig4lGX0ZMdjvX2sOWjU1Y9ukbMGnsWISBRr+sE7gs6J2hSj
        sakBeNbI1GUkHXvpaAJMZHmWoQ==
X-Google-Smtp-Source: AFSGD/WO0ABEXp0L2ifThdnSsCvkpZMI/n6z+sDZZAW2+EadpzzB2qItiYSf5Z0cqn4LNoFnntjV3Q==
X-Received: by 2002:a63:f241:: with SMTP id d1mr9278799pgk.2.1544405231957;
        Sun, 09 Dec 2018 17:27:11 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id g26sm12477833pfh.61.2018.12.09.17.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 17:27:10 -0800 (PST)
Subject: Re: [PATCH V11 0/4] blk-mq: refactor code of issue directly
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1544152185-32667-1-git-send-email-jianchao.w.wang@oracle.com>
 <b2bcbb76-af6f-7660-2bc3-9796338cccff@kernel.dk>
 <0adf3419-bcce-93d8-51fb-aee7cbb5ae17@oracle.com>
 <16205e68-aa5e-c59d-364e-4164a0e51dc7@kernel.dk>
 <f052c016-e521-9f12-f4e5-d65f3814643a@kernel.dk>
 <a59a3a1d-94fb-938d-7ddf-969185cd5b48@oracle.com>
 <1e183b77-2c4d-71ff-b019-2b1070d2ed6b@kernel.dk>
 <38eb7c50-dfad-d9cb-f8ab-a8f5250b0ed7@oracle.com>
 <bd99f969-5eed-5365-6aa1-ce9b85dc84d6@kernel.dk>
 <6432264f-57e9-d405-079e-21c0aa17b08e@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7a827e9b-7f52-6073-94b8-105288ee289a@kernel.dk>
Date:   Sun, 9 Dec 2018 18:27:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6432264f-57e9-d405-079e-21c0aa17b08e@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/9/18 6:18 PM, jianchao.wang wrote:
> 
> 
> On 12/7/18 11:47 AM, Jens Axboe wrote:
>> On 12/6/18 8:46 PM, jianchao.wang wrote:
>>>
>>>
>>> On 12/7/18 11:42 AM, Jens Axboe wrote:
>>>> On 12/6/18 8:41 PM, jianchao.wang wrote:
>>>>>
>>>>>
>>>>> On 12/7/18 11:34 AM, Jens Axboe wrote:
>>>>>> On 12/6/18 8:32 PM, Jens Axboe wrote:
>>>>>>> On 12/6/18 8:26 PM, jianchao.wang wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 12/7/18 11:16 AM, Jens Axboe wrote:
>>>>>>>>> On 12/6/18 8:09 PM, Jianchao Wang wrote:
>>>>>>>>>> Hi Jens
>>>>>>>>>>
>>>>>>>>>> Please consider this patchset for 4.21.
>>>>>>>>>>
>>>>>>>>>> It refactors the code of issue request directly to unify the interface
>>>>>>>>>> and make the code clearer and more readable.
>>>>>>>>>>
>>>>>>>>>> This patch set is rebased on the recent for-4.21/block and add the 1st
>>>>>>>>>> patch which inserts the non-read-write request to hctx dispatch
>>>>>>>>>> list to avoid to involve merge and io scheduler when bypass_insert
>>>>>>>>>> is true, otherwise, inserting is ignored, BLK_STS_RESOURCE is returned
>>>>>>>>>> and the caller will fail forever.
>>>>>>>>>>
>>>>>>>>>> The 2nd patch refactors the code of issue request directly to unify the
>>>>>>>>>> helper interface which could handle all the cases.
>>>>>>>>>>
>>>>>>>>>> The 3rd patch make blk_mq_sched_insert_requests issue requests directly
>>>>>>>>>> with 'bypass' false, then it needn't to handle the non-issued requests
>>>>>>>>>> any more.
>>>>>>>>>>
>>>>>>>>>> The 4th patch replace and kill the blk_mq_request_issue_directly.
>>>>>>>>>
>>>>>>>>> Sorry to keep iterating on this, but let's default to inserting to
>>>>>>>>> the dispatch list if we ever see busy from a direct dispatch. I'm fine
>>>>>>>>> with doing that for 4.21, as suggested by Ming, I just didn't want to
>>>>>>>>> fiddle with it for 4.20. This will prevent any merging on the request
>>>>>>>>> going forward, which I think is a much safer default.
>>>>>>>>>
>>>>>>>>> You do this already for some cases. Let's do it unconditionally for
>>>>>>>>> a request that was ever subjected to ->queue_rq() and we didn't either
>>>>>>>>> error or finish after the fact.
>>>>>>>>>
>>>>>>>> I have done it in this version if I get your point correctly.
>>>>>>>> Please refer to the following fragment in the 2nd patch.
>>>>>>>>
>>>>>>>> +	/*
>>>>>>>> +	 * If the request is issued unsuccessfully with
>>>>>>>> +	 * BLK_STS_DEV_RESOURCE or BLK_STS_RESOURCE, insert
>>>>>>>> +	 * the request to hctx dispatch list due to attached
>>>>>>>> +	 * lldd resource.
>>>>>>>> +	 */
>>>>>>>> +	force = true;
>>>>>>>> +	ret = __blk_mq_issue_directly(hctx, rq, cookie, last);
>>>>>>>> +out_unlock:
>>>>>>>> +	hctx_unlock(hctx, srcu_idx);
>>>>>>>> +out:
>>>>>>>> +	switch (ret) {
>>>>>>>> +	case BLK_STS_OK:
>>>>>>>> +		break;
>>>>>>>> +	case BLK_STS_DEV_RESOURCE:
>>>>>>>> +	case BLK_STS_RESOURCE:
>>>>>>>> +		if (force) {
>>>>>>>> +			blk_mq_request_bypass_insert(rq, run_queue);
>>>>>>>> +			ret = bypass ? BLK_STS_OK : ret;
>>>>>>>> +		} else if (!bypass) {
>>>>>>>> +			blk_mq_sched_insert_request(rq, false,
>>>>>>>> +						    run_queue, false);
>>>>>>>> +		}
>>>>>>>> +		break;
>>>>>>>> +	default:
>>>>>>>
>>>>>>> You are right, I missed that you set force = true before doing the
>>>>>>> issue. So this looks good to me!
>>>>>>
>>>>>> I applied your series. With this, we should be good to remove the
>>>>>> REQ_NOMERGE logic that was added for the corruption case, and the
>>>>>> blk_rq_can_direct_dispatch() as well?
>>>>>>
>>>>>
>>>>> Yes, it should be that.
>>>>> Every thing rejected by .queue_rq is ended or inserted into hctx dispatch
>>>>> list. And also direct-issue path is unified with normal path.
>>>>
>>>> Why are we doing that return value dance, depending on whether this
>>>> is a bypass insert or not? That seems confusing.
>>>>
>>>
>>> For the 'bypass == false' case, it need to know whether the request is issued
>>> successfully. This is for the 3rd patch.
>>> I used to use the returned cookie to identify the result, but you don't like it.
>>> So I have to use this return value.
>>
>> Makes sense, but could probably do with a comment. I'm going to let the
>> series float for a day or two to ensure others get a chance to review it,
>> then we can move forward.
>>
> 
> Do I need a respin about the comment ?

I pulled in the two fixes from this week, so it would probably need a
respin on top of that.

-- 
Jens Axboe

