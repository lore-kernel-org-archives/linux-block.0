Return-Path: <SRS0=ti8e=YB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDDDC10F14
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 21:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82911218DE
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 21:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cZ00oFaz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731165AbfJHVWt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Oct 2019 17:22:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40682 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730674AbfJHVWs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Oct 2019 17:22:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id d26so10996696pgl.7
        for <linux-block@vger.kernel.org>; Tue, 08 Oct 2019 14:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=OG8y2yjqwcKyZ/0narkDeEHuCiN7kZU2ER/a4tyXpjE=;
        b=cZ00oFazORyAP9YjioGS8LdNPbIVdIVSxZIsbl4iOaaEbk7CvginJ2/mcC2/hKtOEe
         dx1qmpsmLTpAJTzJGk3avzTODwmj9xceYd0E4NJiof0QpaCTg+egKW3cDFANqKkNrj03
         3sk3Wcv2RdfGnmDY5/1yjao+NU2iOLxsn8AIeOy0AzLJ5HrbNuaHRAV4jZBcAI1FSUd/
         lybraYAHIi9Ld9+QYnLUgIrP/9JEhYsCOrM2s7Qe5MtnFG/GggkQoHyMJ9Y+HsQ9Qnls
         xbYHlGbVAmaR+qKyqnK2ws5NQx966ujYvW1x4Mx0ZqdyFtbz9wCIvRdMe3Dr1IkCkOzU
         0RSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OG8y2yjqwcKyZ/0narkDeEHuCiN7kZU2ER/a4tyXpjE=;
        b=rCL0Z1mi+F4LuW62MdPnsQRqBxisztkZcpbhs2X8VHckuMnvOd9qHmM0MjRyymDRdZ
         IQQqs6miNTwuVqepTEbzMDdhdSZifwMIulAVV6RiC1BOjsv3Bss9+yNlPqu/ql5czJir
         1ggjaZnuN+e1ONvvTOD/gFLZqHZd+hxa1czGu3UeE8f94Tfh/bKyCD+vDz6BPknAXtDv
         VgYUo971tyrKTNimIcsEFWnFESozldjWV8oR9YTGfCc8pTZ7tghcLGp8xSY2Lz/NqM8+
         ztBK4k59r25ZUTId2LP09QKWltXUKOmB+TSDvWNpKf0bpx1I6sLKYcBUUwz95efC40vm
         I1yw==
X-Gm-Message-State: APjAAAXDOxLKPE/Q4bU5Fs6gsi10n5E3X+XwtFwJY2i1GZ2hv20TOvA/
        gT0inwzG98nHKucCK9gjCBX8kA==
X-Google-Smtp-Source: APXvYqwEdHimHTD5NsKMKOHzTqFuq6gAtn676HiYi2DorhC6h2nYJCaCg4y4iFAlmNtBDPAA8k9DVg==
X-Received: by 2002:a62:5ac3:: with SMTP id o186mr40660pfb.20.1570569766467;
        Tue, 08 Oct 2019 14:22:46 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id k65sm138117pga.94.2019.10.08.14.22.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 14:22:45 -0700 (PDT)
Subject: Re: [PATCH] io_uring: remove wait loop spurious wakeups
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <936cd758d6c694fe1b8b9de050e24cfecdc2e60d.1570489620.git.asml.silence@gmail.com>
 <e11a0716-eb18-4ce3-9902-3247beafe65a@kernel.dk>
 <d035bb1b-e6f0-77db-a434-1761b0a7a142@gmail.com>
 <62a8a6c7-9c5b-c9a4-9c73-c77db87c6637@kernel.dk>
 <99bfb7aa-6980-fc14-32f7-a479dea63eb4@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a1f8de23-fcad-7252-cbd4-8f5e617056cd@kernel.dk>
Date:   Tue, 8 Oct 2019 15:22:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <99bfb7aa-6980-fc14-32f7-a479dea63eb4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/8/19 2:58 PM, Pavel Begunkov wrote:
> On 08/10/2019 20:00, Jens Axboe wrote:
>> On 10/8/19 10:43 AM, Pavel Begunkov wrote:
>>> On 08/10/2019 06:16, Jens Axboe wrote:
>>>> On 10/7/19 5:18 PM, Pavel Begunkov (Silence) wrote:
>>>>> From: Pavel Begunkov <asml.silence@gmail.com>
>>>>>
>>>>> Any changes interesting to tasks waiting in io_cqring_wait() are
>>>>> commited with io_cqring_ev_posted(). However, io_ring_drop_ctx_refs()
>>>>> also tries to do that but with no reason, that means spurious wakeups
>>>>> every io_free_req() and io_uring_enter().
>>>>>
>>>>> Just use percpu_ref_put() instead.
>>>>
>>>> Looks good, this is a leftover from when the ctx teardown used
>>>> the waitqueue as well.
>>>>
>>> BTW, is there a reason for ref-counting in struct io_kiocb? I understand
>>> the idea behind submission reference, but don't see any actual part
>>> needing it.
>>
>> In short, it's to prevent the completion running before we're done with
>> the iocb on the submission side.
> 
> Yep, that's what I expected. Perhaps I missed something, but what I've
> seen following code paths all the way down, it either
> 1. gets error / completes synchronously and then frees req locally
> 2. or passes it further (e.g. async list) and never accesses it after

As soon as the IO is passed on, it can complete. In fact, it can complete
even _before_ that call returns. That's the issue. Obviously this isn't
true for purely polled IO, but it is true for IRQ based IO.

-- 
Jens Axboe

