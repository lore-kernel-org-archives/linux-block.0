Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E907C433EF
	for <linux-block@archiver.kernel.org>; Mon, 15 Nov 2021 20:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27C0263238
	for <linux-block@archiver.kernel.org>; Mon, 15 Nov 2021 20:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347191AbhKOUj3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Nov 2021 15:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349292AbhKOUGV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Nov 2021 15:06:21 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C7BC061766;
        Mon, 15 Nov 2021 11:23:35 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id r132so13281383pgr.9;
        Mon, 15 Nov 2021 11:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=qOdfviDawrnQEmhpbh1EywiWPqwK+XMcwjxkSzr6gBk=;
        b=HEkPVJxufusC0xGDUimU2ECSru8wAVsuOgcAa8mlub4XtZUF5G3IcbwWQX055kI0vN
         fBqpLpMOyLtDlrWfXIabCgTjMqIQ1Kwr1qOlgn/DD0v/67O2U/NhM2gNFom2rhtrqQmG
         guHygzAopddmSAnLOH/zFdVNaCIbJYhs7lO1D8epA2ZJxfx1aSplQWN9olV5TsZcn8jX
         rpUJJI8oSA+cE1QK6veuJ1Waakhw9taGs43e5/VLg88jPSq1RClcTnSmXB/GTqUj/A9R
         D4YOtQHsi0l8U3Ty9uMJRcbhsmXS15HC+pl780dd1n8ucfwz2YUyEmQ0cRRuP5llYNYr
         d2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=qOdfviDawrnQEmhpbh1EywiWPqwK+XMcwjxkSzr6gBk=;
        b=s9Gn6kSEqsUrCwI75mnQTBEC7W552PIQ9a1pIT1l2KVYZEimNyNiUHXD09/GsHnl56
         kPPW2Lhanszmc97N70eCRFMDFU/5PkGeu2/MsxfpDOzNM6TDouJyfRAwN+AeDatgfs5r
         JXbcrOtmwOWFVthCSqn2DRt0hwm3yv0bdMs1AaMftr2KGMyhlGED6J1xbxzvdwwWXhkc
         5mn6nW5MFbCn3V16oIfrEu4rrJ+XPoUYQv8otxPc3zQMQliF6tvAiXl6WZ/U3OAxy3f1
         JziSVIkdaSYdQofm+r1gd9gd4SlHdDnv3WltWm+aOLMNn4c4zf47OQ8DJVGcYPwmzmQj
         1PRg==
X-Gm-Message-State: AOAM531KxCh5TLEo30mwIvBv2UPR1j06R/EG0tXvy7Br7DrAA1/W2PLp
        6AmTpaqBt4rG30x7PHUkLF/ccPQAbbw=
X-Google-Smtp-Source: ABdhPJwjTnI3d8c95mBsQVyrQZ2iPHzV2zKNNllAo0wR0AEqNf1JWUnfLlHrZ4LFO1foDav+Q+JZxA==
X-Received: by 2002:aa7:9004:0:b0:4a2:e58e:9442 with SMTP id m4-20020aa79004000000b004a2e58e9442mr952983pfo.24.1637004215201;
        Mon, 15 Nov 2021 11:23:35 -0800 (PST)
Received: from [10.1.1.26] (222-155-101-117-fibre.sparkbb.co.nz. [222.155.101.117])
        by smtp.gmail.com with ESMTPSA id a23sm4871537pgl.37.2021.11.15.11.23.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Nov 2021 11:23:34 -0800 (PST)
Subject: Re: [PATCH 4/5] block: move queue enter logic into
 blk_mq_submit_bio()
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Ming Lei <ming.lei@redhat.com>
References: <461c4758-2675-1d11-ac8a-6f25ef01d781@kernel.dk>
 <YYQr3jl3avsuOUAJ@infradead.org>
 <3d29a5ce-aace-6198-3ea9-e6f603e74aa1@kernel.dk>
 <YYQuyt2/y1MgzRi0@infradead.org>
 <87ee0091-9c2f-50e8-c8f2-dcebebb9de48@kernel.dk>
 <alpine.DEB.2.22.394.2111111350150.2780761@ramsan.of.borg>
 <YY0eVnbjmHmPZ3M4@T590>
 <CAMuHMdWTiF3MpcwHc=jCGLoBtTngzXTLHsYSYKPyfLBFBn8B2g@mail.gmail.com>
 <YY01hzAuvmeMxO+0@T590> <17ce59ff-bc8c-e8c8-22e1-96605440629a@kernel.dk>
 <YY246bCP+wKw0Z2c@T590>
 <CAMuHMdV30yvjam8i0Z4Nsu=e1YhPaRb4E1bAtw7=268v6TnrJg@mail.gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <ee78b20c-36f0-408d-87d0-b8b75a66110d@gmail.com>
Date:   Tue, 16 Nov 2021 08:23:27 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdV30yvjam8i0Z4Nsu=e1YhPaRb4E1bAtw7=268v6TnrJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/11/21 20:51, Geert Uytterhoeven wrote:
[...]
>>>>>> BTW, today I just found that hang in blk_mq_freeze_queue_wait() is
>>>>>> caused by commit 900e080752025f00, and the following patch can fix it:
>>>>>>
>>>>>> - blk-mq: don't grab ->q_usage_counter in blk_mq_sched_bio_merge
>>>>>>
>>>>>> https://lore.kernel.org/linux-block/20211111085650.GA476@lst.de/T/#m759b88fda094a65ebf29bc81b780967cdaf9cf28
>>>>>>
>>>>>> Maybe you can try the above patch.
>>>>>
>>>>> Thanks! I have applied both patches, but it doesn't make a difference.
>>>>
>>>> Thanks for your test!
>>>>
>>>> Can you try the following patch?
>
> [...]
>
>>> That's definitely a real fix, akin to the other pre-enter variants, this
>>> one just post checks. Geert, can you give this a whirl?
>
> With both of
>
>     blk-mq: don't grab ->q_usage_counter in blk_mq_sched_bio_merge
>     blk-mq: rename blk_attempt_bio_merge
>
> applied, and the version above, I no longer saw the error, but the
> boot sometimes hangs after:
>
>     ext3 filesystem being remounted at / supports timestamps until
> 2038 (0x7fffffff)
>
> I don't know how easy that is to trigger: it hung on my first try, but
> the second and third tries it booted fully into old Debian userspace.
>
>>> Ming, would you mind sending this as a real patch?
>>
>> The above patch may not be enough, since submit_bio_checks() is done in
>> case of using cached request, so how about the following patch(un-tested)?
>
> Worked fine in five subsequent boots. Thanks!
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

For good measure: block-5.16-2021-11-13 tested fine running IO stress 
tests on a mix of IDE and SCSI disks, only one of those supporting DPO/FUA.

Using

WARN_ON(rq->cmd_flags & REQ_FUA && !sdkp->DPOFUA);

in sd.c:sd_setup_read_write_cmnd(), nothing seen in the logs.

Cheers,

	Michael


>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
>
