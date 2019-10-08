Return-Path: <SRS0=ti8e=YB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E257C4360C
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 17:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E721D218AC
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 17:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gB1e0Pwf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfJHRAX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Oct 2019 13:00:23 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36220 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfJHRAX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Oct 2019 13:00:23 -0400
Received: by mail-io1-f65.google.com with SMTP id b136so38075959iof.3
        for <linux-block@vger.kernel.org>; Tue, 08 Oct 2019 10:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jjX9NlOHpquC/Sfta8LEcd2OkeJi//hJzKxsmDBzbTE=;
        b=gB1e0PwfuyEBf0jsz8o+5nHpb3VXP4nLO2wfWhWGC/75vX90xaUYLZ4CufQ5pwgEWA
         f8a5GGESkScrhfUAFIM4IFRh3V0WAhqgs+Kmk3mWHKL2rEcI8HlIY1LfgTOQlCc6tP0b
         h6jT5o5L+wV1miWcBWTMdBUybHf6EcVoGjHdL13bcBnoLCFVA7KP3/9aIKvJX2MQkxAr
         KYwxpGBGlnQ94spt/znvnB8E6DmZI+mw4LA5Oa6tJhfgzhsDywolVaDeuQ3f/MFzOt/d
         1Xug10qjK5BsETha8IW6lHS6mIO8JkOX/87sj4GVcyu7dCn/AzcS+9IUP00iMTOvuWoK
         IKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jjX9NlOHpquC/Sfta8LEcd2OkeJi//hJzKxsmDBzbTE=;
        b=nkXpntrvZEieAribpl80Q6FcoQD0nwW70qso3AXBsVdFO21P54Bm+R3J9CTWrtHt7v
         EvjUeGeZWr/yxa0aEfKcipeSYl4EI50A5LNwQ29DSvHRwYjL2ZFT+L6JTMYoj2wY7tlY
         11jPrqzbgwAih4ej5M7zMXuoDX+zl85uj23tQ3Ig1htendwFR5QFJ6REb6jZlRWjyV4x
         M5sQ2mSjwm0RvnZcWfy+E1qinNSbNx2cjSbMO0fVMt/lXlNok3GLOe6aaJzSDBD1ovkd
         xvFpWhGvfRHftqrNKNW61Yure2bk4RjDdpsh6y2v9OcSqqEzZn5dqAKj3u57dT7h67dV
         iNUg==
X-Gm-Message-State: APjAAAUHr5dTZK+16qazxNjmJjNPDIg4wtGqJUe+XE4gK9rU0GGLPrMx
        z9ZmgfbRa22v1ZdpkR0F0kvyIg==
X-Google-Smtp-Source: APXvYqwAmqmBluQAIhWf2f/0FiXxNwozNzClbWMkH8dbk0HE2IO35d/M6WcDFO4TLIqY5dwZ5O2cxg==
X-Received: by 2002:a5d:9c4c:: with SMTP id 12mr29014127iof.276.1570554022169;
        Tue, 08 Oct 2019 10:00:22 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r2sm9402226ila.52.2019.10.08.10.00.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 10:00:20 -0700 (PDT)
Subject: Re: [PATCH] io_uring: remove wait loop spurious wakeups
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <936cd758d6c694fe1b8b9de050e24cfecdc2e60d.1570489620.git.asml.silence@gmail.com>
 <e11a0716-eb18-4ce3-9902-3247beafe65a@kernel.dk>
 <d035bb1b-e6f0-77db-a434-1761b0a7a142@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <62a8a6c7-9c5b-c9a4-9c73-c77db87c6637@kernel.dk>
Date:   Tue, 8 Oct 2019 11:00:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d035bb1b-e6f0-77db-a434-1761b0a7a142@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/8/19 10:43 AM, Pavel Begunkov wrote:
> On 08/10/2019 06:16, Jens Axboe wrote:
>> On 10/7/19 5:18 PM, Pavel Begunkov (Silence) wrote:
>>> From: Pavel Begunkov <asml.silence@gmail.com>
>>>
>>> Any changes interesting to tasks waiting in io_cqring_wait() are
>>> commited with io_cqring_ev_posted(). However, io_ring_drop_ctx_refs()
>>> also tries to do that but with no reason, that means spurious wakeups
>>> every io_free_req() and io_uring_enter().
>>>
>>> Just use percpu_ref_put() instead.
>>
>> Looks good, this is a leftover from when the ctx teardown used
>> the waitqueue as well.
>>
> BTW, is there a reason for ref-counting in struct io_kiocb? I understand
> the idea behind submission reference, but don't see any actual part
> needing it.

In short, it's to prevent the completion running before we're done with
the iocb on the submission side.

> Tested with another ref-counting patch and got +5-8% to
> nops performance.
> 
> 


-- 
Jens Axboe

