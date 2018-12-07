Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2628EC07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 03:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA112082D
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 03:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mvxEd1wF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA112082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbeLGDcK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 22:32:10 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37011 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeLGDcJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 22:32:09 -0500
Received: by mail-pg1-f194.google.com with SMTP id 80so1081801pge.4
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 19:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eDbrGrtMGzX23Lhnt+kuraVrwrm8L9n7EjAQYnzC2Vg=;
        b=mvxEd1wFLzkEQx9EPRWesV7bwgvNGz/eVYsNYyA3C0hDZNzd/I3PZ+msHX6WTeLx7a
         S2rYwZJkkPSMY70rJahBZTiJ2kpHPlezva5hORcX6qmlLb3WaYYpqUeS18Oe3LKUnTLJ
         dAraXijmNsFNRvJwa81KWwo6MvGR2fY71R4LIZ8w0lLbaa1YPZwIWCEW14bdRIL91i+S
         kNIMu1ILYrf3APV56KX/6KoEKyu5GqJXU7mmxIH+zp5LDZ/xUJmJn9rGk8YXa/l0jYxZ
         qyiVaKl9yGDJNKKew/Yq8hWvfRVHpfs4BBORXPNSHIsxnkaZbCmWEPsbJFdtLnprLkPn
         HXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eDbrGrtMGzX23Lhnt+kuraVrwrm8L9n7EjAQYnzC2Vg=;
        b=UHxDyd8kJHVoz7qGvje4lAKo1XeUfFqZpMymXM01MEacqkrxtK87TrEYCQisURKoB9
         5Rck/bEFgu27oVWo2tIa8FVsaW0AMKa8/eB/+0kfvsvZTEBeUH09uklnD/x4/ReYQ8eq
         mcfj4sKWpdnFm2j/l4UwO2BjtqtFmgH+8AZbPnTxOQna3iSnBQPk8r60KeJ/7hXGjHHK
         ZNDcCMUVVadiEGMnybIRrHLP8+j20EmiBX4nCmmKvrLJUWttyDI9sb0FnIhDKj3K2rp/
         O84n7jk7ROZGY4Jsg7rCeBJAkKkEirkokV+fHpY2lOKIpQMMjq8ZPcNqkCM+fzW1LZXX
         hHHA==
X-Gm-Message-State: AA+aEWZds6Jto8L4UHGPqC2XzDf6t7FMzIPcX5dwGzq0PbQJFeka/hU6
        /XUnxRPf4rj4HgV/j5xJEgLr5g==
X-Google-Smtp-Source: AFSGD/WcPCktL6B4U0UqeEcLjPIOCA7IY0BZZM6FIsjrA4jrrPwiDtJR7LApYLzaMlZ3jYR6Z1Pe5g==
X-Received: by 2002:a62:3241:: with SMTP id y62mr647391pfy.178.1544153529257;
        Thu, 06 Dec 2018 19:32:09 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id i193sm2041671pgc.22.2018.12.06.19.32.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 19:32:07 -0800 (PST)
Subject: Re: [PATCH V11 0/4] blk-mq: refactor code of issue directly
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1544152185-32667-1-git-send-email-jianchao.w.wang@oracle.com>
 <b2bcbb76-af6f-7660-2bc3-9796338cccff@kernel.dk>
 <0adf3419-bcce-93d8-51fb-aee7cbb5ae17@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <16205e68-aa5e-c59d-364e-4164a0e51dc7@kernel.dk>
Date:   Thu, 6 Dec 2018 20:32:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <0adf3419-bcce-93d8-51fb-aee7cbb5ae17@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 8:26 PM, jianchao.wang wrote:
> 
> 
> On 12/7/18 11:16 AM, Jens Axboe wrote:
>> On 12/6/18 8:09 PM, Jianchao Wang wrote:
>>> Hi Jens
>>>
>>> Please consider this patchset for 4.21.
>>>
>>> It refactors the code of issue request directly to unify the interface
>>> and make the code clearer and more readable.
>>>
>>> This patch set is rebased on the recent for-4.21/block and add the 1st
>>> patch which inserts the non-read-write request to hctx dispatch
>>> list to avoid to involve merge and io scheduler when bypass_insert
>>> is true, otherwise, inserting is ignored, BLK_STS_RESOURCE is returned
>>> and the caller will fail forever.
>>>
>>> The 2nd patch refactors the code of issue request directly to unify the
>>> helper interface which could handle all the cases.
>>>
>>> The 3rd patch make blk_mq_sched_insert_requests issue requests directly
>>> with 'bypass' false, then it needn't to handle the non-issued requests
>>> any more.
>>>
>>> The 4th patch replace and kill the blk_mq_request_issue_directly.
>>
>> Sorry to keep iterating on this, but let's default to inserting to
>> the dispatch list if we ever see busy from a direct dispatch. I'm fine
>> with doing that for 4.21, as suggested by Ming, I just didn't want to
>> fiddle with it for 4.20. This will prevent any merging on the request
>> going forward, which I think is a much safer default.
>>
>> You do this already for some cases. Let's do it unconditionally for
>> a request that was ever subjected to ->queue_rq() and we didn't either
>> error or finish after the fact.
>>
> I have done it in this version if I get your point correctly.
> Please refer to the following fragment in the 2nd patch.
> 
> +	/*
> +	 * If the request is issued unsuccessfully with
> +	 * BLK_STS_DEV_RESOURCE or BLK_STS_RESOURCE, insert
> +	 * the request to hctx dispatch list due to attached
> +	 * lldd resource.
> +	 */
> +	force = true;
> +	ret = __blk_mq_issue_directly(hctx, rq, cookie, last);
> +out_unlock:
> +	hctx_unlock(hctx, srcu_idx);
> +out:
> +	switch (ret) {
> +	case BLK_STS_OK:
> +		break;
> +	case BLK_STS_DEV_RESOURCE:
> +	case BLK_STS_RESOURCE:
> +		if (force) {
> +			blk_mq_request_bypass_insert(rq, run_queue);
> +			ret = bypass ? BLK_STS_OK : ret;
> +		} else if (!bypass) {
> +			blk_mq_sched_insert_request(rq, false,
> +						    run_queue, false);
> +		}
> +		break;
> +	default:

You are right, I missed that you set force = true before doing the
issue. So this looks good to me!

-- 
Jens Axboe

