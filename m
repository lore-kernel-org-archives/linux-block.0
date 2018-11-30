Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6839C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 21:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8961C20660
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 21:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="G/WL4rXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8961C20660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbeLAI1R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 03:27:17 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37429 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLAI1R (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Dec 2018 03:27:17 -0500
Received: by mail-io1-f66.google.com with SMTP id f14so214639iol.4
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 13:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wWAdRv5ZpsfGX1kym4jW6l9pcXLNOIu3iG7CEUasE4o=;
        b=G/WL4rXUO2/Ouv50HhWNtB/p2wMvmnqDp6ICO/+oR0WSUM/hfbjDXs0ooVzF1Ct4zD
         IqSZBwdjcJswhMmJSRW09LJCnR8SweC05iugULLL7MzMzKlyGWhvebrM7QfwLzCdi6Qs
         Pak51Z96x0OvLPobcVTX5VPspD5QFaL0vxxJPIA/zeze4Ec8f3OmjmhE5Vcs8S6nnv2j
         RYz7Gczhol4Im/hlYUMMw6jQni0E5zQf7BCsXl6udAHyJ8iHtYCEGkyZrCtoMrT5DM5t
         3rklCytkaOjNLzEZYsndoU1bdaCo8v04pZ4bvNrNDIXWxsAjQ/v7oocpGqNIst9MU4Ga
         VRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wWAdRv5ZpsfGX1kym4jW6l9pcXLNOIu3iG7CEUasE4o=;
        b=D8X9U+ri2arKL/72QLyyVLue3s89vt3HSBoGUv4b2iOzuJr/TCsZCCMH9UbZWQwdc/
         RrHsHlCHODPmiToXe9p45pLDf32IZ2LFNXbjXEEjiYJCSN/2NIWTAx0lqGf1wecNumoF
         lmvW34Rg/Ep10WXmeScTSM2EH5O6sh7atMs2aE79qgufwRYwNjQaqOpBpu5GnhzVKf2G
         0qak4owW8F7cxukT5NCqAL+xtvP44VsVkr6/91roTPx9N/qmsOYTK5/m8tJqRC3lN5lD
         Pvbomp+Nt89VjvVkbFD7sCnmG+7pMPR1k0Q8cWBFzQab4syTuYJFDXJLg3jIsBnww026
         aLCA==
X-Gm-Message-State: AA+aEWbWUY8HbX/1H+Ypq7ERicryYqY9CmHM8EO3281NX2fWzCRvSYqO
        mAu9ylHhJjaSuYcWEiNPcbBfFA==
X-Google-Smtp-Source: AFSGD/VHJ4Sp0vV8qkTwhem985WhDt6c8kxElS6EQnwPsu6zzC7Ye4vRviVLRXytTfmSmyY5ukzOgQ==
X-Received: by 2002:a6b:6b0d:: with SMTP id g13mr5880618ioc.18.1543612600525;
        Fri, 30 Nov 2018 13:16:40 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m132sm161965itm.26.2018.11.30.13.16.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 13:16:39 -0800 (PST)
Subject: Re: [PATCH 24/27] block: implement bio helper to add iter kvec pages
 to bio
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, hch@lst.de
References: <20181130165646.27341-1-axboe@kernel.dk>
 <20181130165646.27341-25-axboe@kernel.dk>
 <20181130192102.GP2217@ZenIV.linux.org.uk>
 <6e42d763-9c94-6b84-7099-f5ef5964404c@kernel.dk>
 <1545b364-df01-51e7-1786-56dde7c49b5d@kernel.dk>
 <20181130211117.GQ2217@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <07803d69-84cc-bb39-686f-2f50874ea184@kernel.dk>
Date:   Fri, 30 Nov 2018 14:16:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130211117.GQ2217@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/18 2:11 PM, Al Viro wrote:
> On Fri, Nov 30, 2018 at 01:32:21PM -0700, Jens Axboe wrote:
>> On 11/30/18 1:15 PM, Jens Axboe wrote:
>>> On 11/30/18 12:21 PM, Al Viro wrote:
>>>> On Fri, Nov 30, 2018 at 09:56:43AM -0700, Jens Axboe wrote:
>>>>> For an ITER_KVEC, we can just iterate the iov and add the pages
>>>>> to the bio directly.
>>>>
>>>>> +		page = virt_to_page(kv->iov_base);
>>>>> +		size = bio_add_page(bio, page, kv->iov_len,
>>>>> +					offset_in_page(kv->iov_base));
>>>>
>>>> Who said that you *can* do virt_to_page() on those?  E.g. vmalloc()'ed
>>>> addresses are fine for ITER_KVEC, etc.
>>>
>>> Then how do you set up a kvec based iter with memory you can safely
>>> DMA to/from?
>>
>> Would this make you happy:
>>
>> if (!is_vmalloc_addr(kv->iov_base))
>>         page = virt_to_page(kv->iov_base);
>> else
>>         page = vmalloc_to_page(kv->iov_base);
> 
> Free advice: don't ever let Linus see anything along those lines.  Results
> tend to be colourful...

We already have those lines in the kernel, XFS for instance. Al, could you
please try to be helpful instead of being deliberately obtuse?

Examples of being helpful:

1) Informing the sender of why something is a bad idea, instead of just
   saying it's a bad idea.

2) Making helpful suggestions to improve the current situation.


-- 
Jens Axboe

