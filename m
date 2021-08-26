Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748CFC432BE
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 19:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43E3860FD8
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 19:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhHZTdq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Aug 2021 15:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhHZTdq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Aug 2021 15:33:46 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E4EC061757
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 12:32:58 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id a13so5167276iol.5
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 12:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fVlVtAt0nhSKqe6EHxaA4r0rPGqbx90ob3t969FR/z8=;
        b=m5vXiMuJnx4QzbuGtY2ww+ufcfwqQwJ7AJi7WcLAtHDg4LGwgIZH6YnlbsehIiPeod
         vU9KTRvSbRsYGbMN8Ubbm2g+s1l2zoclnsM707sPXUBt+aqV2kMhNJ2tp/zElsxIuAxw
         7WnR6C2WFm5gVINFvt0I+n0qlppdmqKGQigLcP4qY0yebRHCOUMeme/aUnaHubi9HKe8
         VZTZk4zj0v2ddOwsYO7ZEk+/XGPCrPUUV13RuwtufVTj1UjjTZ3Qn2FkV0ffL/iLkjZB
         09yq0Bmdw5G4SLnRzV+BJxfdbmcQdCs+E4J22+DLorOB+ogQWcL0I9OFFJ+NnohMKEUD
         GkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fVlVtAt0nhSKqe6EHxaA4r0rPGqbx90ob3t969FR/z8=;
        b=YlFAUfjiH+aGF+8Q3kzjStC2xtNGL+YgP98Z5vMJ/vA0RK0hY0F4xj6BgwTmlYgf0I
         ijWuJ/qKhZiz6EEp4u2aYDB3hU8A7/X54J4/vgvWi6CPNcC3VITS2+27ACKiZ338EoOC
         BgohJ5R7eVKu7QcdKVkbyi4d1fbcfNVVLaB8cgoo2dL0q5K8BQFWtXMgJ2RUPwSeEZ4C
         kfWfqRNepEl/Hv06W6yPbnze4yAZSehmm+zVRFBZJMhWAi/+xClZCjc88SvhaScDs4pY
         akj67AqR3nrjzjy1YYXOavsW+hxIsBoqDlW+pQa/1UeSoB7ZMnijOU0fLiuQWNDOf35F
         NsSw==
X-Gm-Message-State: AOAM5333g9/Joztm1c9kRdMIeFrGnSxtdzhuadDYBATix3xFSZ2DuV7C
        trWOU67s3gfWu8wNWbK2jCruqA==
X-Google-Smtp-Source: ABdhPJwo30ZF8Z5P9TDAFcs8vL3or90W6Sd2LfS3NrRmdDSeUqwsAgUWjIwnmq/cD/FIcCcul2dLEA==
X-Received: by 2002:a5d:8588:: with SMTP id f8mr4268409ioj.46.1630006378249;
        Thu, 26 Aug 2021 12:32:58 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id s6sm1930040iow.1.2021.08.26.12.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 12:32:57 -0700 (PDT)
Subject: Re: [PATCH] block/mq-deadline: Speed up the dispatch of low-priority
 requests
To:     Bart Van Assche <bvanassche@acm.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-block <linux-block@vger.kernel.org>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>
References: <20210826144039.2143-1-thunder.leizhen@huawei.com>
 <fc1f2664-fc4f-7b3e-5542-d9e4800a5bde@acm.org>
 <537620de-646d-e78e-ccb8-4105bac398b3@kernel.dk>
 <82612be1-d61e-1ad5-8fb5-d592a5bc4789@kernel.dk>
 <a1c76c24-5013-02b4-85f1-2d2896cca6dd@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ae882282-7a15-5746-0c54-ff3f5435c022@kernel.dk>
Date:   Thu, 26 Aug 2021 13:32:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a1c76c24-5013-02b4-85f1-2d2896cca6dd@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/26/21 1:17 PM, Bart Van Assche wrote:
> On 8/26/21 11:45 AM, Jens Axboe wrote:
>> Bart, either we fix this up ASAP and get rid of the percpu counters in
>> the hot path, or we revert this patch.
> 
> I'm at home taking care of my son because he is sick.

Take care of that, always more important than the kernel :-)

> Do you want to wait for Zhen to post a fixed version of his patch or do you
> want me to fix his patch?

To be a bit proactive, I queued up a revert. Messing with it at this
point is making me a bit nervous. If the final patch ends up looking
clean enough, then we can still go that route. But it really has to be
unequivocally done this late in the game...

-- 
Jens Axboe

