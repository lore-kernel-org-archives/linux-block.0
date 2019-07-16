Return-Path: <SRS0=S2CA=VN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BAFC7618F
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 14:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7062C20693
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 14:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kKT1eELV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfGPOKf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jul 2019 10:10:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40098 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfGPOKe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jul 2019 10:10:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so9174185pfp.7
        for <linux-block@vger.kernel.org>; Tue, 16 Jul 2019 07:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OGTaCRpcOlsIreOgbY4VLatPjT+BC9ttZsKDBEIstn8=;
        b=kKT1eELVJoVyH1ra6NKCjTBv53yrehn2UiSkkNX3y+b1wkHCBrLc6rD9JVdIdu1yUG
         QU0pDZVlBJUbbh3MlDjD/2Llk8g/Ol91LCxa7T4oZeivQPgmOsRz9RvTmE/jU1azwVpi
         As8gji/UJp2qsupSpkkFpoRmEIdajWDy5DY+CttaA/JZgQn+cXrpRSmEaWnJsy4HGpIf
         6fqamseq7KI31rmW/9rSJZq6oe4IzQvJvqGYG9+O4A/C9Zhscnsjtolgd0EXZZ4CNsqL
         1rjLCCnO0L+cqiQBN9tma9N8hz8hNiPc8/ApHD2KoyAwM15WvtOML4Zz8/ows7UxBP93
         bjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OGTaCRpcOlsIreOgbY4VLatPjT+BC9ttZsKDBEIstn8=;
        b=bFwWNTdI7caWBiZcIxFfaxTXlCXdE4P5RN5YDWokZ0y+tr6J5YyB7XuxjeU5McV4Z/
         sfOSiO1RqmBa0DBMMcdGHIowoJchFIbsM1AAYSFb5l+HettFhmEkDNdHbgNM5ErxDHVE
         85+c8YzgeGKcNQdILxGV8kExlRsH7X1ldHW9hiyr99MWiP1xadUGTCDg9/wvJoI+hp1h
         0fToeKj+nDACxoUqdIoOeGwMFrNtnUB/TmwsST+4/Wtf9WW0VKIlUIPwdC7Quhe8wRzE
         WlnXCOqVv1itGHmEjOGoTIXt28kDvHmNA0D/GTRZAPwh2ajl/Yc/PlBIgqGYBeUO/7rv
         PBVw==
X-Gm-Message-State: APjAAAVP8lTyRGPTXU0xB0HiJ7DxPhojLO23bxBBXiVc8tOAquqILdB8
        gPoOonHAylcHyTXV5rhWOM5ECfXePSY=
X-Google-Smtp-Source: APXvYqzhrRfh3iCyZKWz20nDkdINJG4kUjKTUHHzcEOL328LyzL3EHEskhEffvYoJNYSD2NGIXbzJw==
X-Received: by 2002:a17:90a:cb97:: with SMTP id a23mr36005236pju.67.1563286233699;
        Tue, 16 Jul 2019 07:10:33 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id m20sm12085361pff.79.2019.07.16.07.10.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 07:10:32 -0700 (PDT)
Subject: Re: [PATCH 2/2] io_uring: fix the judging condition in
 io_sequence_defer
To:     Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Cc:     linux-block@vger.kernel.org
References: <20190713035826.2987-1-liuzhengyuan@kylinos.cn>
 <20190713035826.2987-2-liuzhengyuan@kylinos.cn>
 <13f62d22-1a99-0c29-cd4c-8808223fbc68@kernel.dk>
 <5d2be620.1c69fb81.fff62.8eeeSMTPIN_ADDED_BROKEN@mx.google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <310ddf1b-03f3-6bb5-65d0-b57e129b08bd@kernel.dk>
Date:   Tue, 16 Jul 2019 08:10:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <5d2be620.1c69fb81.fff62.8eeeSMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/14/19 8:34 PM, Zhengyuan Liu wrote:
> 
> On 7/14/19 5:43 AM, Jens Axboe wrote:
>> On 7/12/19 9:58 PM, Zhengyuan Liu wrote:
>>> sq->cached_sq_head and cq->cached_cq_tail are both unsigned int.
>>> if cached_sq_head gets overflowed before cached_cq_tail, then we
>>> may miss a barrier req. As cached_cq_tail moved always following
>>> cached_sq_head, the NQ should be enough.
>> This (and the previous patch) looks fine to me, just wondering if
>> you had a test case showing this issue?
>>
> Hi.
> 
> Actually I don't have a real test case,  but I have emulated a test case
> and showed the issue.
> 
> Let's preset those count to close overflowed status at the begin:
> 
>         @@ -2979,6 +2987,10 @@ static int io_allocate_scq_urings(struct
> io_ring_ctx *ctx,
>             cq_ring->ring_entries = p->cq_entries;
>             ctx->cq_mask = cq_ring->ring_mask;
>             ctx->cq_entries = cq_ring->ring_entries;
> +
> +          ctx->cached_sq_head = ctx->sq_ring->r.head =
> ctx->sq_ring->r.tail = 0xfffffff8;
> +          ctx->cached_cq_tail = ctx->cq_ring->r.head =
> ctx->cq_ring->r.tail = 0xfffffff8
> +
>             return 0;
>      }
> 
> And queue serveral sqes  following a io_uring_enter like this:
> 
>       write1 write2 ... write8  barrier write9 write10
> 
> Then we can miss the barrier almost every time.

No problem, just curious if you had a test case, since then I'd add
it to the arsenal.

I've applied this one, thank you.

-- 
Jens Axboe

