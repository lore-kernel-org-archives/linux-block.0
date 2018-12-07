Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054A6C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 03:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA9B20892
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 03:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="w7SLfpnm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA9B20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbeLGDrR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 22:47:17 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37058 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeLGDrQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 22:47:16 -0500
Received: by mail-pf1-f196.google.com with SMTP id y126so1242705pfb.4
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 19:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w35DSk4qfnRK16yaEcR4sBBBm709E4JKITl908+WQOY=;
        b=w7SLfpnmtzd6XCFkvZ4FJAxwooekL+CKf4JtjIKFqa+H3WNrjn0YxPfBEbW9xOfv96
         Bz4IsT6adXY/HiOS0ESTbS6IYV2WxLHVG49G6b9b8BOuiyMlyFxTmxygBCPshyM6mgvy
         KBkjkjulFq0PdUdLuAAJqoHozYSNZB4Z1Z9JJkWTXxV8ZrwQOU+6dQ4BpzV2oKOSzdtH
         7QFTwMgppibomrbN45sl021qwOLRxEYn7hV7kqIKk89R487KP7GQcc1DLpiU4g222Dr7
         F7h5ZkGOWB1Ouo/iM7jK9MtJtZUUKKi04QtpDVpwovwxjzm1sgKvM0M5axqJ7vyhWDzb
         akqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w35DSk4qfnRK16yaEcR4sBBBm709E4JKITl908+WQOY=;
        b=ZuSaI7mGEEkHe5c810G1AaF8VPXd/OazklKyg2lyjCuPPAsisqpYryHOZfd+ozYiuH
         tC5bybx/yVSV4FtyzBUx2KQbnEV05kUaMczJRcf3b1+59ksJrpKSB74HnZm640fQFMkv
         QblwpwY/bPhUa/tMMCuBcgxrTOUxhT8HOR+txboEYiRIZqxrlROtAM8sCTSjvm5kfzpD
         nzi97w2tIMfyLMxHnGlvDSCWtwK39k13zw4dH3aQT+/IlCKocSA8MkVE0r+X3mf9Hhsu
         1VJFJFFDh1+A03ifysfHPShD55uFQlc2G28+bVoyv77zQlrkH1MicCpoLOg/hW9A8JYc
         X0AA==
X-Gm-Message-State: AA+aEWZyT9U+wAEobGJchR0FxqEziEy5Mg81pdQ0ssUg+4IkPrvSK4dk
        f4R/6v36YVcOZLYEuT435QZPEw==
X-Google-Smtp-Source: AFSGD/UEfRlBVBBzwdqrLiHrud/dLEkqZbmobZUrmKHv3l9+/BcxCW/jB2KAkV5p/yXuSxHWZwM+GQ==
X-Received: by 2002:a63:8e43:: with SMTP id k64mr582535pge.346.1544154435776;
        Thu, 06 Dec 2018 19:47:15 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u29sm2178451pgn.23.2018.12.06.19.47.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 19:47:14 -0800 (PST)
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bd99f969-5eed-5365-6aa1-ce9b85dc84d6@kernel.dk>
Date:   Thu, 6 Dec 2018 20:47:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <38eb7c50-dfad-d9cb-f8ab-a8f5250b0ed7@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 8:46 PM, jianchao.wang wrote:
> 
> 
> On 12/7/18 11:42 AM, Jens Axboe wrote:
>> On 12/6/18 8:41 PM, jianchao.wang wrote:
>>>
>>>
>>> On 12/7/18 11:34 AM, Jens Axboe wrote:
>>>> On 12/6/18 8:32 PM, Jens Axboe wrote:
>>>>> On 12/6/18 8:26 PM, jianchao.wang wrote:
>>>>>>
>>>>>>
>>>>>> On 12/7/18 11:16 AM, Jens Axboe wrote:
>>>>>>> On 12/6/18 8:09 PM, Jianchao Wang wrote:
>>>>>>>> Hi Jens
>>>>>>>>
>>>>>>>> Please consider this patchset for 4.21.
>>>>>>>>
>>>>>>>> It refactors the code of issue request directly to unify the interface
>>>>>>>> and make the code clearer and more readable.
>>>>>>>>
>>>>>>>> This patch set is rebased on the recent for-4.21/block and add the 1st
>>>>>>>> patch which inserts the non-read-write request to hctx dispatch
>>>>>>>> list to avoid to involve merge and io scheduler when bypass_insert
>>>>>>>> is true, otherwise, inserting is ignored, BLK_STS_RESOURCE is returned
>>>>>>>> and the caller will fail forever.
>>>>>>>>
>>>>>>>> The 2nd patch refactors the code of issue request directly to unify the
>>>>>>>> helper interface which could handle all the cases.
>>>>>>>>
>>>>>>>> The 3rd patch make blk_mq_sched_insert_requests issue requests directly
>>>>>>>> with 'bypass' false, then it needn't to handle the non-issued requests
>>>>>>>> any more.
>>>>>>>>
>>>>>>>> The 4th patch replace and kill the blk_mq_request_issue_directly.
>>>>>>>
>>>>>>> Sorry to keep iterating on this, but let's default to inserting to
>>>>>>> the dispatch list if we ever see busy from a direct dispatch. I'm fine
>>>>>>> with doing that for 4.21, as suggested by Ming, I just didn't want to
>>>>>>> fiddle with it for 4.20. This will prevent any merging on the request
>>>>>>> going forward, which I think is a much safer default.
>>>>>>>
>>>>>>> You do this already for some cases. Let's do it unconditionally for
>>>>>>> a request that was ever subjected to ->queue_rq() and we didn't either
>>>>>>> error or finish after the fact.
>>>>>>>
>>>>>> I have done it in this version if I get your point correctly.
>>>>>> Please refer to the following fragment in the 2nd patch.
>>>>>>
>>>>>> +	/*
>>>>>> +	 * If the request is issued unsuccessfully with
>>>>>> +	 * BLK_STS_DEV_RESOURCE or BLK_STS_RESOURCE, insert
>>>>>> +	 * the request to hctx dispatch list due to attached
>>>>>> +	 * lldd resource.
>>>>>> +	 */
>>>>>> +	force = true;
>>>>>> +	ret = __blk_mq_issue_directly(hctx, rq, cookie, last);
>>>>>> +out_unlock:
>>>>>> +	hctx_unlock(hctx, srcu_idx);
>>>>>> +out:
>>>>>> +	switch (ret) {
>>>>>> +	case BLK_STS_OK:
>>>>>> +		break;
>>>>>> +	case BLK_STS_DEV_RESOURCE:
>>>>>> +	case BLK_STS_RESOURCE:
>>>>>> +		if (force) {
>>>>>> +			blk_mq_request_bypass_insert(rq, run_queue);
>>>>>> +			ret = bypass ? BLK_STS_OK : ret;
>>>>>> +		} else if (!bypass) {
>>>>>> +			blk_mq_sched_insert_request(rq, false,
>>>>>> +						    run_queue, false);
>>>>>> +		}
>>>>>> +		break;
>>>>>> +	default:
>>>>>
>>>>> You are right, I missed that you set force = true before doing the
>>>>> issue. So this looks good to me!
>>>>
>>>> I applied your series. With this, we should be good to remove the
>>>> REQ_NOMERGE logic that was added for the corruption case, and the
>>>> blk_rq_can_direct_dispatch() as well?
>>>>
>>>
>>> Yes, it should be that.
>>> Every thing rejected by .queue_rq is ended or inserted into hctx dispatch
>>> list. And also direct-issue path is unified with normal path.
>>
>> Why are we doing that return value dance, depending on whether this
>> is a bypass insert or not? That seems confusing.
>>
> 
> For the 'bypass == false' case, it need to know whether the request is issued
> successfully. This is for the 3rd patch.
> I used to use the returned cookie to identify the result, but you don't like it.
> So I have to use this return value.

Makes sense, but could probably do with a comment. I'm going to let the
series float for a day or two to ensure others get a chance to review it,
then we can move forward.

-- 
Jens Axboe

