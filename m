Return-Path: <SRS0=h0yA=YL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E784ACA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 14:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF58222BD
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 14:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="v3xOPITZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393103AbfJROhn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:37:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33766 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392990AbfJROhm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Oct 2019 10:37:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id i76so3509547pgc.0
        for <linux-block@vger.kernel.org>; Fri, 18 Oct 2019 07:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FZFKjNas5im/hGi/Vyul2YDjZ3cKsj+DpRyrRQrG0vA=;
        b=v3xOPITZ2m2R8/MWnfbG3rNxc/E1SXrHPaKvr9n42g0eVHn9aqEdJnKCDi9UJ+WI5u
         OxWRdcAOW4wLMIq9yENn6RYgMHWdf+AkcOXcvCU/ytJJBTjyUXR5HUMjh2765HOQUzMr
         hyN6reqhdxbFeXqFSrFza59xzzFYA7qQ/CEceffK3GZwNW/iO3ATQL4Yg0E9Y01tPW60
         qsI06tzRe+OCzHvsq66iScY8CZvZurxACiYi0XGpvhYG3vbh0hecw32XgU0o01S7yxZh
         PNCc5XgHubOLlL4XqB0ZFcJkanLMidDaSNx/aYLEhzL1BNExQWZCqrke5s6De02AiyU0
         sh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FZFKjNas5im/hGi/Vyul2YDjZ3cKsj+DpRyrRQrG0vA=;
        b=AeSIdLek1pQOSc4xKEb8x4bwyfIC5tFESkUfUOSimw20TbeR1gz/b5j3JPMLySAyHY
         w6dopAoI4ZNnZpjJ2gJG0AIXDeAmGNxTHeZEWFwXKZGO8SFrT7k4qy0WlmGlJ7W69Rl3
         mdSOCNCGA4lUnidLEqC/jZS8ofbdGwxlaxNIR6hemYybz2v9mP+ps7LHP5btpjaqmU9L
         MPfigsGm2FngVX8wgjyyXh3Ov5rU5byMGfPJhoo/5Um/g8UL8pGEikpL1/SkqCwOcRUA
         aPQYLmlcrr2oTUY802m5VAO0KZiEKOqO3u1/tVnIvevWryaXPZR/IFy+SWGOPivdfnck
         Ig+w==
X-Gm-Message-State: APjAAAVAhPTEOmukX5/+q2wOcd0zC2errnkHEpDhJtrEu6+omgQeS8UC
        pCyhXQxRZvPU+oeW7HMPUhg7wA==
X-Google-Smtp-Source: APXvYqwVxFQed8WDQwPsmyP5UChFG2awvfIYonA90kgYQMb14rR68QUhw87fih9E/STg/OisMJXeEg==
X-Received: by 2002:a62:b419:: with SMTP id h25mr6544pfn.52.1571409461652;
        Fri, 18 Oct 2019 07:37:41 -0700 (PDT)
Received: from ?IPv6:2620:10d:c081:1131::1120? ([2620:10d:c090:180::e16a])
        by smtp.gmail.com with ESMTPSA id m4sm6009462pjs.8.2019.10.18.07.37.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 07:37:40 -0700 (PDT)
Subject: Re: [PATCH 1/3] io_uring: add support for async work inheriting files
 table
To:     Jann Horn <jannh@google.com>
Cc:     linux-block@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>
References: <20191017212858.13230-1-axboe@kernel.dk>
 <20191017212858.13230-2-axboe@kernel.dk>
 <CAG48ez0G2y0JS9=S2KmePO3xq-5DuzgovrLFiX4TJL-G897LCA@mail.gmail.com>
 <0fb9d9a0-6251-c4bd-71b0-6e34c6a1aab8@kernel.dk>
 <CAG48ez181=JoYudXee0KbU0vDZ=EbxmgB7q0mmjaA0gyp6MFBQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a54329d5-a128-3ccd-7a12-f6cadaa20dbf@kernel.dk>
Date:   Fri, 18 Oct 2019 08:37:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez181=JoYudXee0KbU0vDZ=EbxmgB7q0mmjaA0gyp6MFBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/18/19 8:34 AM, Jann Horn wrote:
> On Fri, Oct 18, 2019 at 4:01 PM Jens Axboe <axboe@kernel.dk> wrote:
>> On 10/17/19 8:41 PM, Jann Horn wrote:
>>> On Fri, Oct 18, 2019 at 4:01 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>> This is in preparation for adding opcodes that need to modify files
>>>> in a process file table, either adding new ones or closing old ones.
> [...]
>> Updated patch1:
>>
>> http://git.kernel.dk/cgit/linux-block/commit/?h=for-5.5/io_uring-test&id=df6caac708dae8ee9a74c9016e479b02ad78d436
> 
> I don't understand what you're doing with old_files in there. In the
> "s->files && !old_files" branch, "current->files = s->files" happens
> without holding task_lock(), but current->files and s->files are also
> the same already at that point anyway. And what's the intent behind
> assigning stuff to old_files inside the loop? Isn't that going to
> cause the workqueue to keep a modified current->files beyond the
> runtime of the work?

I simply forgot to remove the old block, it should only have this one:

if (s->files && s->files != cur_files) {                        
        task_lock(current);                                     
        current->files = s->files;                              
        task_unlock(current);                                   
        if (cur_files)                                          
                put_files_struct(cur_files);                    
        cur_files = s->files;                                   
}

-- 
Jens Axboe

