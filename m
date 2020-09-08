Return-Path: <SRS0=nGx8=CR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AF1C433E2
	for <linux-block@archiver.kernel.org>; Tue,  8 Sep 2020 19:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F512166E
	for <linux-block@archiver.kernel.org>; Tue,  8 Sep 2020 19:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RhCmDFzl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731981AbgIHTtK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731605AbgIHTtG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Sep 2020 15:49:06 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21C3C061573
        for <linux-block@vger.kernel.org>; Tue,  8 Sep 2020 12:49:05 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id j2so642690ioj.7
        for <linux-block@vger.kernel.org>; Tue, 08 Sep 2020 12:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hunciBGEHrTyQWlaX8a60LpGpU2syQhqwCcb0lWbpY8=;
        b=RhCmDFzlmOovzp/cgEV8Tdi5b5UnFoCcFlrdL0z06Evaju8ZFpb2lLCsQoqoH8xH/x
         hwEQi4cNbOaOYa980t7gpVkmkflezv2wGYd5RAHfJf2PWVJnJSHMlCj0G55kiFAMiIni
         tZ2jGR+2aCaiKBBfZ92Qvc+VBqeioQ7oDrhcdoJ/44n6WuXvHQxTMNl3WZlDcgRdpbjv
         ocnxvL+rhXftlpO8nRtIxg+4JkiJb97TCA8OIQVuPM5YW/ito51eYemRgQxh/Mqweq3h
         pNVE9QymHny2pKY0qQuH7J3xH2tUgPqvy675WcmoroHewH+kqeh+MTEx/fqDddHkinim
         IJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hunciBGEHrTyQWlaX8a60LpGpU2syQhqwCcb0lWbpY8=;
        b=Rj0464tfHDZycfkMaHUYyJ8QtItpR/lXeJqx6TqctTjmT72uk24Si1vlt5HV5Sxzyq
         /4s3Khq/bBUTMpeRA/J/Br5AMGmSF3JuDUpTAL3OHgk9NJTiUwlkdpagXUwP9M7D8c31
         KXKVMV+qikZ1ll02XIOaNzAnrkc1IJ2KuCsz1fgFsA/e5HLOJJVPDr3WYs0naHZS81bc
         oNp7I2HDtzVslN4QGXPUdj8iC5t7ppceBZPgUquE/kQXpgGRdT0iJPKgLb4Ikw62mgK4
         6NW5s9mt67Sk1+l5dPpFfkvXgkjaEX0EV9GkwvIk4Qyw8YfJnWpdmBwWs6O66HLAK+6Z
         Ux9g==
X-Gm-Message-State: AOAM530cr7bZeSqA/Z0m+sFiiz1UjAn40D1jNi3LJzZ7tY48LlLCtJXj
        ukhOpE6LFztZRdN/qY9kLPfevw==
X-Google-Smtp-Source: ABdhPJynwfwcxk2rXYGMk/nuGSlsgauBldB4RUwnFSEnqseAQxFjI8JPDpYHbA2wBoT0bSeWk646Fg==
X-Received: by 2002:a6b:8d57:: with SMTP id p84mr442932iod.206.1599594544809;
        Tue, 08 Sep 2020 12:49:04 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d1sm57038ila.67.2020.09.08.12.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 12:49:04 -0700 (PDT)
Subject: Re: [PATCH] kyber: Fix crash in kyber_finish_request()
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Yang Yang <yang.yang@vivo.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, onlyfever@icloud.com
References: <20200907074346.5383-1-yang.yang@vivo.com>
 <8b714da7-97b2-f8d2-4be7-c192130c33af@kernel.dk>
 <20200908190009.GA142421@relinquished.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <51e9345b-7c65-e35b-148f-bc9c5e1f7dcf@kernel.dk>
Date:   Tue, 8 Sep 2020 13:49:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908190009.GA142421@relinquished.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/8/20 1:00 PM, Omar Sandoval wrote:
> On Mon, Sep 07, 2020 at 10:41:16AM -0600, Jens Axboe wrote:
>> CC Omar
>>
>> On 9/7/20 1:43 AM, Yang Yang wrote:
>>> Kernel crash when requeue flush request.
>>> It can be reproduced as below:
>>>
>>> [    2.517297] Unable to handle kernel paging request at virtual address ffffffd8071c0b00
>>> ...
>>> [    2.517468] pc : clear_bit+0x18/0x2c
>>> [    2.517502] lr : sbitmap_queue_clear+0x40/0x228
>>> [    2.517503] sp : ffffff800832bc60 pstate : 00c00145
>>> ...
>>> [    2.517599] Process ksoftirqd/5 (pid: 51, stack limit = 0xffffff8008328000)
>>> [    2.517602] Call trace:
>>> [    2.517606]  clear_bit+0x18/0x2c
>>> [    2.517619]  kyber_finish_request+0x74/0x80
>>> [    2.517627]  blk_mq_requeue_request+0x3c/0xc0
>>> [    2.517637]  __scsi_queue_insert+0x11c/0x148
>>> [    2.517640]  scsi_softirq_done+0x114/0x130
>>> [    2.517643]  blk_done_softirq+0x7c/0xb0
>>> [    2.517651]  __do_softirq+0x208/0x3bc
>>> [    2.517657]  run_ksoftirqd+0x34/0x60
>>> [    2.517663]  smpboot_thread_fn+0x1c4/0x2c0
>>> [    2.517667]  kthread+0x110/0x120
>>> [    2.517669]  ret_from_fork+0x10/0x18
>>>
>>> Signed-off-by: Yang Yang <yang.yang@vivo.com>
>>> ---
>>>  block/kyber-iosched.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
>>> index a38c5ab103d1..af73afe7a05c 100644
>>> --- a/block/kyber-iosched.c
>>> +++ b/block/kyber-iosched.c
>>> @@ -611,6 +611,9 @@ static void kyber_finish_request(struct request *rq)
>>>  {
>>>  	struct kyber_queue_data *kqd = rq->q->elevator->elevator_data;
>>>  
>>> +	if (unlikely(!(rq->rq_flags & RQF_ELVPRIV)))
>>> +		return;
>>> +
>>>  	rq_clear_domain_token(kqd, rq);
>>>  }
>>>  
>>>
> 
> It looks like BFQ also has this check. Wouldn't it make more sense to
> check it in blk-mq, like we do for .finish_request() in
> blk_mq_free_request()? Something along these lines:

Yeah I think so, that's much better than working around it in the
consumer of it.

-- 
Jens Axboe

