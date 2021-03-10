Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4599C433DB
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 16:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F05364EE6
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 16:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhCJQAm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Mar 2021 11:00:42 -0500
Received: from mail-pg1-f175.google.com ([209.85.215.175]:33608 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbhCJQAS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Mar 2021 11:00:18 -0500
Received: by mail-pg1-f175.google.com with SMTP id g4so11679179pgj.0;
        Wed, 10 Mar 2021 08:00:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gTwMkf5H85+AwIlFCgASM8JJ1kngo6AI9p9ZpfcgmvM=;
        b=CAt2F3o0M6XE4dp9Kft/xeRH12Q/olpkXCb9CbLblL3PC08AZxKXtVX7cOuILUSVLh
         VxG/+l0XtVFQvrEAO2y3CaY+Bv8DMcwsSQ3E/04YK+FUu/skUGMU2Js2vLj+hOCCuoWQ
         xL5sj6RJ5JGbsJdvrOjsXW99wzBh0HlXawQtT27WDV2VWMKexhkNMF8fR8C9zWA/Qjpi
         kJMXOV9gbgxWpdywxEuLBXsqIoYsXoBKTxORzwkR4EfF4h80djEHn31PKfaQhURuFFyd
         EMIvaW2f87FA0KKFuLQ3n35IgORHhSUL9/7VvJSHOGljyJ/DcQVN/qsOLZuGUN+GTWja
         qxdw==
X-Gm-Message-State: AOAM530I2MCmWSFI7KF8JCiLyHqnVHIe0MJ1X21ziLSDBgqPrPsHcWYZ
        jySsGs+qa8F62ErA503iU3o=
X-Google-Smtp-Source: ABdhPJzYaAiDo16QBex9Hx61wACPHtVnR6G+3O/k+FP7ujOKH9OcLSBf06d2695CDMfDyGpQnPsrYw==
X-Received: by 2002:a65:5281:: with SMTP id y1mr3289962pgp.12.1615392017618;
        Wed, 10 Mar 2021 08:00:17 -0800 (PST)
Received: from [192.168.50.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id l22sm2661790pjl.14.2021.03.10.08.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 08:00:16 -0800 (PST)
Subject: Re: [RFC PATCH v3 3/3] blk-mq: Lockout tagset iterator when exiting
 elevator
To:     John Garry <john.garry@huawei.com>, hare@suse.de,
        ming.lei@redhat.com, axboe@kernel.dk, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        pragalla@codeaurora.org, kashyap.desai@broadcom.com,
        yuyufen@huawei.com
References: <1614957294-188540-1-git-send-email-john.garry@huawei.com>
 <1614957294-188540-4-git-send-email-john.garry@huawei.com>
 <48a3cf78-3f6d-c13c-bca2-1f8277817b45@acm.org>
 <9c9360bf-7ca9-5c8f-c61d-441044f9c78f@huawei.com>
 <784a3686-cb54-561d-740c-30e0b3f46df8@acm.org>
 <f60dc68f-9206-2bfb-950e-cb312f1c4c8b@huawei.com>
 <de3dec73-c8fc-d14f-5bbb-7023ccc6b57e@acm.org>
 <b4e39d48-3524-ac34-c20e-0dadcf15e3d6@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <b74dc9ef-0db1-eb27-e2a7-c26e3dbd527a@acm.org>
Date:   Wed, 10 Mar 2021 08:00:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <b4e39d48-3524-ac34-c20e-0dadcf15e3d6@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/10/21 12:52 AM, John Garry wrote:
> On 09/03/2021 19:21, Bart Van Assche wrote:
>> Regarding this patch series, I have shared the feedback I wanted to
>> share so I would appreciate it if someone else could also take a look.
> 
> So I can incorporate any changes and suggestions so far and send a 
> non-RFC version - that may get more attention if none extra comes.
> 
> As mentioned on the cover letter, if patch 2+3/3 are accepted, then 
> patch 1/3 could be simplified. But I plan to leave as is.
> 
> BTW, any issue with putting your suggested-by on patch 2/3?

Hi John,

I have added my Reviewed-by to patch 2/3.

Regarding the other two patches in this series: I do not agree with 
patch 3/3. As I have explained, I am concerned that that patch breaks 
existing block drivers.

Are patches 1/3 and 3/3 necessary? Or in other words, is patch 2/3 
sufficient to fix the use-after-free?

Thanks,

Bart.
