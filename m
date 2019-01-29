Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6977AC282CD
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 02:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352002148E
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 02:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RWqC3RC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfA2CXD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 21:23:03 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45504 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfA2CXD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 21:23:03 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so8907577pfd.12
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 18:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TT6/hWWxWhEGi9hTXu5mLayoevlV6l+nEIPYuOgZ/UI=;
        b=RWqC3RC0n/puM19Rrmiwp8+BeQVGWpvnnQ/VAt2PRlV7tpU+lSb0UcceU5ZrOW7DkX
         GHDYPbVPNNYBm+zVNjcgFZLNQvlUMva2wltKVPsAPvEuxfw+IDLejMHsu/VsOoM8l56k
         YzkRi52tEJAB0HZGoYCQ5z3Cj8qYDpH9jLhFGSDlQCKsT7b+NhQyMuvXeALjdZcunDET
         NUSN6qqy7ZIO6QbfYqAIXEUdk2WEu9R9Z9HXvtsc5SRpJxTcNn7uEyTfg0GRww8VIHJW
         rP4IAaEcJ0FieEMMj0MO41xjcMUW4v2uQ1sv5zH8ycuMQ1OXZcfQPnJqgczY6T/to8G5
         WusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TT6/hWWxWhEGi9hTXu5mLayoevlV6l+nEIPYuOgZ/UI=;
        b=Sf49CLscmDzPSv1XFwy2HCWFKOXBrtcHKJNyluuE6WtE8IRkT49qrvzYPuY0NSZHa1
         XeRHcAkMYX69pX2eUO0tgwUw3bHdDHqB7bva2l10LvhbIx9i2OHNdMyRc8oBOm8Eoo/2
         dclUxVW4kSSJEj3Bkb7pb+9jowZtH6mWZVnQGBRdi/KAUuE1SrzkayZpV10XsmCA+Svo
         CsqGfADWXAXI7COxaj2WNtDN2Lh8zNMuKMX5cOiWlCe5e91gH85y5Fovo8PrPVucbUDl
         KI4eSkrg5ZvdLwR+mwkpEjm5f8JJG6OuOp1v418lv0AMe3a9EC4EADEN3yODE1OP2Cb4
         TPQg==
X-Gm-Message-State: AJcUukf3Sg0BmW+0HzXMc+lcHeSPs9f+pq5U40KpYIgpw81nSH0BpzVS
        MksWu3WsgS6bDS7xRS/V0snJJw==
X-Google-Smtp-Source: ALg8bN6lu9pspucSt2znkXjJRAMC8b6+4W2qBlzwo+NR2Dv9URqMVIzGRIBxjqqWiPpC6Jlt/zetMg==
X-Received: by 2002:a62:670f:: with SMTP id b15mr24148568pfc.212.1548728582782;
        Mon, 28 Jan 2019 18:23:02 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id z127sm64806150pfb.80.2019.01.28.18.23.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 18:23:01 -0800 (PST)
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Jann Horn <jannh@google.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
References: <20190128213538.13486-1-axboe@kernel.dk>
 <20190128213538.13486-6-axboe@kernel.dk>
 <CAG48ez2gvgBUKNihnjEWeBv1WZiXWwfxcA2Wf90n8GHLket2Mg@mail.gmail.com>
 <9170f97f-bea3-04b9-71db-a0f250d1f610@kernel.dk>
 <CAG48ez1NoSVeb19acpi4g2hP3Ft02E1_rOFir_qpsCtgXiSv9A@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <61583262-dcab-1653-d3ab-bfe2cf969e3b@kernel.dk>
Date:   Mon, 28 Jan 2019 19:23:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez1NoSVeb19acpi4g2hP3Ft02E1_rOFir_qpsCtgXiSv9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/19 6:32 PM, Jann Horn wrote:
> On Tue, Jan 29, 2019 at 2:31 AM Jens Axboe <axboe@kernel.dk> wrote:
>> On 1/28/19 6:29 PM, Jann Horn wrote:
>>> On Mon, Jan 28, 2019 at 10:35 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>> The submission queue (SQ) and completion queue (CQ) rings are shared
>>>> between the application and the kernel. This eliminates the need to
>>>> copy data back and forth to submit and complete IO.
>>> [...]
>>>> +static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx)
>>>> +{
>>>> +       struct io_kiocb *req;
>>>> +
>>>> +       /* safe to use the non tryget, as we're inside ring ref already */
>>>> +       percpu_ref_get(&ctx->refs);
>>>
>>> Is that true? In the path io_sq_thread() -> io_submit_sqes() ->
>>> io_submit_sqe() -> io_get_req(), I don't see anything that's already
>>> holding a reference for you. Is the worker thread holding a reference
>>> somewhere that I'm missing?
>>
>> If the thread is alive, then the ctx is alive. Before we drop the last
>> ref to the ctx (and kill it), we wait for the thread to exit.
> 
> Where in __io_uring_register() are you waiting for the thread to exit
> before killing it? As far as I can tell, you come straight in from
> syscall context, take a mutex, and do percpu_ref_kill().

I was just referring to the regular shutdown path. You are right, for
the later io_uring_register() more care needs to be taken. I'll just
switch to the tryget, it's not like the non-try is a big cycle saver
by any stretch.

-- 
Jens Axboe

