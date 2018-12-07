Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4BDC07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 03:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1AD2082B
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 03:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="l5syHDpL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1AD2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbeLGDmd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 22:42:33 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46841 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeLGDmc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 22:42:32 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so1073520pgp.13
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 19:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PRLk5oWb9dP5b3xlPgZxdfJer+uCyI27EzVWMWm0yEg=;
        b=l5syHDpL0OdtpD6FkdOud2/+Z9SGeU/GlvBxKZ+0eBrtKmOHeXlmV9RwdsKxD9rhuG
         wkBIV6I96aoBY/q/Wx7GeUOjdqRIsjwwgD/bxrXeEY+tFrsUHviKOzW3aBtiINQBtG1O
         Yb1TZ0rLiJ8RwV6ad6FJ1repZENCqeNoQXGfuUIjPeTmlpUKgD8X8sYD+ByHjs0r3F5g
         u3O47VtX8L78lY7aNBbAWHwpmHxwrbsJjl0LJm16J6PdyzmKP3sw/9Lw7Qc/lVC+asqH
         xnA8DfIhtneBBsxVz3HggYXZXPXpSbwWyeIrDraF2JYI7Xb/8P+llPqzAhGtA5W2QqLi
         +VbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PRLk5oWb9dP5b3xlPgZxdfJer+uCyI27EzVWMWm0yEg=;
        b=X6cMTBVu9zspWVAZp4HzumLSpDxRNPWisTYqzY4oGmXo0yBfIcK1pzo7DNnw3XH5tp
         LubuvC9+OpaUlGHIX4BP8Zlxiu3jE18vkyazBDHFiusleD6edT5UxGrK3MYtnac6nHjS
         QPSG2r0REqv/6qsnZH2ziqF0JMWPZb3Tj0Z1IMPNxk6ZebEMsTEfhvGt/p/fzxY0dBoJ
         BbM/ID6oDIJ1D4Z9wWd995848mwKj2jIIm12/vDt1jLyjFMdGbkTiDiciWLe2msaD4Ey
         12Cb9dkF1o5ajdYdcVaDpt7Mv482xiVXjpDbrTKw/I2/JD7ZDnqJhCSjy+6KCGmb7VUR
         YYgw==
X-Gm-Message-State: AA+aEWbUmPMaDcUwJScAoJWIs74rQUbTyK/0fEiNIHdbdRrduD03WoIn
        ZqJoIE/760alnCW44oxvfTmhiQ==
X-Google-Smtp-Source: AFSGD/UOWOIA0YlUAJKiBQB0eb8SCgHT+eteCQda35+VusheTiJlOb14PE14+BSK6brNxlUomS7VPQ==
X-Received: by 2002:a62:f5da:: with SMTP id b87mr646168pfm.253.1544154151772;
        Thu, 06 Dec 2018 19:42:31 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id l22sm3125490pfj.179.2018.12.06.19.42.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 19:42:30 -0800 (PST)
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1e183b77-2c4d-71ff-b019-2b1070d2ed6b@kernel.dk>
Date:   Thu, 6 Dec 2018 20:42:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <a59a3a1d-94fb-938d-7ddf-969185cd5b48@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 8:41 PM, jianchao.wang wrote:
> 
> 
> On 12/7/18 11:34 AM, Jens Axboe wrote:
>> On 12/6/18 8:32 PM, Jens Axboe wrote:
>>> On 12/6/18 8:26 PM, jianchao.wang wrote:
>>>>
>>>>
>>>> On 12/7/18 11:16 AM, Jens Axboe wrote:
>>>>> On 12/6/18 8:09 PM, Jianchao Wang wrote:
>>>>>> Hi Jens
>>>>>>
>>>>>> Please consider this patchset for 4.21.
>>>>>>
>>>>>> It refactors the code of issue request directly to unify the interface
>>>>>> and make the code clearer and more readable.
>>>>>>
>>>>>> This patch set is rebased on the recent for-4.21/block and add the 1st
>>>>>> patch which inserts the non-read-write request to hctx dispatch
>>>>>> list to avoid to involve merge and io scheduler when bypass_insert
>>>>>> is true, otherwise, inserting is ignored, BLK_STS_RESOURCE is returned
>>>>>> and the caller will fail forever.
>>>>>>
>>>>>> The 2nd patch refactors the code of issue request directly to unify the
>>>>>> helper interface which could handle all the cases.
>>>>>>
>>>>>> The 3rd patch make blk_mq_sched_insert_requests issue requests directly
>>>>>> with 'bypass' false, then it needn't to handle the non-issued requests
>>>>>> any more.
>>>>>>
>>>>>> The 4th patch replace and kill the blk_mq_request_issue_directly.
>>>>>
>>>>> Sorry to keep iterating on this, but let's default to inserting to
>>>>> the dispatch list if we ever see busy from a direct dispatch. I'm fine
>>>>> with doing that for 4.21, as suggested by Ming, I just didn't want to
>>>>> fiddle with it for 4.20. This will prevent any merging on the request
>>>>> going forward, which I think is a much safer default.
>>>>>
>>>>> You do this already for some cases. Let's do it unconditionally for
>>>>> a request that was ever subjected to ->queue_rq() and we didn't either
>>>>> error or finish after the fact.
>>>>>
>>>> I have done it in this version if I get your point correctly.
>>>> Please refer to the following fragment in the 2nd patch.
>>>>
>>>> +	/*
>>>> +	 * If the request is issued unsuccessfully with
>>>> +	 * BLK_STS_DEV_RESOURCE or BLK_STS_RESOURCE, insert
>>>> +	 * the request to hctx dispatch list due to attached
>>>> +	 * lldd resource.
>>>> +	 */
>>>> +	force = true;
>>>> +	ret = __blk_mq_issue_directly(hctx, rq, cookie, last);
>>>> +out_unlock:
>>>> +	hctx_unlock(hctx, srcu_idx);
>>>> +out:
>>>> +	switch (ret) {
>>>> +	case BLK_STS_OK:
>>>> +		break;
>>>> +	case BLK_STS_DEV_RESOURCE:
>>>> +	case BLK_STS_RESOURCE:
>>>> +		if (force) {
>>>> +			blk_mq_request_bypass_insert(rq, run_queue);
>>>> +			ret = bypass ? BLK_STS_OK : ret;
>>>> +		} else if (!bypass) {
>>>> +			blk_mq_sched_insert_request(rq, false,
>>>> +						    run_queue, false);
>>>> +		}
>>>> +		break;
>>>> +	default:
>>>
>>> You are right, I missed that you set force = true before doing the
>>> issue. So this looks good to me!
>>
>> I applied your series. With this, we should be good to remove the
>> REQ_NOMERGE logic that was added for the corruption case, and the
>> blk_rq_can_direct_dispatch() as well?
>>
> 
> Yes, it should be that.
> Every thing rejected by .queue_rq is ended or inserted into hctx dispatch
> list. And also direct-issue path is unified with normal path.

Why are we doing that return value dance, depending on whether this
is a bypass insert or not? That seems confusing.

-- 
Jens Axboe

