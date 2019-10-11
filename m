Return-Path: <SRS0=5xwa=YE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0591BC47404
	for <linux-block@archiver.kernel.org>; Fri, 11 Oct 2019 03:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7ADD21A4A
	for <linux-block@archiver.kernel.org>; Fri, 11 Oct 2019 03:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DqIsSMVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfJKD0Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Oct 2019 23:26:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33940 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfJKD0Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Oct 2019 23:26:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id b128so5220055pfa.1
        for <linux-block@vger.kernel.org>; Thu, 10 Oct 2019 20:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nk2URU+Kictbae/z38YX10i+Uy5KJiahp9yeE8le4SE=;
        b=DqIsSMVw/NU8HPrvbWuhW181yeA/WvYk7o1HCHu4s0ZSoTOjXJzaZzItToFgKCTlpm
         hQKNyMJngkmloLa/yXlIe5aYpQTIMWIOHOFgFdd8PonaVgk48H0AxxYv9/wC3i4xIuUr
         zaWYhZupNBQaUKMZZeiIs6H16w5g9NXhNgTDyDcs+zZEVoReIBgZ01WEXu5HdiOKxl/3
         oIbZxjaLkwZlpGKupepmA62xWejKXAUQ4H5agh89IeY/ruFlFq/IG+0JzkXKmfysZave
         ROikgNmulHWD/XjX+SowzHLz3+VZx08Gj99drkOyAchokJkeHDvEubJV8oyKU783fCuJ
         CP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nk2URU+Kictbae/z38YX10i+Uy5KJiahp9yeE8le4SE=;
        b=Gh1BXFSblkjiVHTyt/G7jSKoQVtznP1/yoNl1CRmgE+0goYpnViAH1xfxQmVvBeuGf
         ih55Uke5DPoUPjjZrAHffHRQYk9by/lILSfNiqCGTA/X0eh31ImV5LcQ67cvfjBjzczI
         pE3NGKUwfhGziR0WaA8/KhGAEsEp/IQjZNd2g/2FiroFOGxL4faWxz3wta4eKTd037jP
         8819ubn1lPd8JKv7priPc3eDDXzI8Zpx/gHtLvIa0XZtsHF14gnGwUvVgFAa5t+oPXmf
         VHRIAZSNadowUozOvwO45beNoZT3yXrxB4mgH+ziP8nzKgsqHZ+Ci3T8oqn3/WhrDvbQ
         MR2g==
X-Gm-Message-State: APjAAAW39XP1MBmXr8P6txqRVA4IndQZRIrlVnu3RvnchZ/LH4JaC1rR
        DwT5ID8geX0G+FDgiptaGuM8J3kZlTeDNQ==
X-Google-Smtp-Source: APXvYqyF8catp0cq6CkqRXjCIBOs91oMeZmhIHCWrq1HXi17wkizi4OAZK97yK5QO/Xv/jmngnLbrQ==
X-Received: by 2002:a63:f854:: with SMTP id v20mr14054539pgj.92.1570764381938;
        Thu, 10 Oct 2019 20:26:21 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id u7sm8241927pfn.61.2019.10.10.20.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 20:26:20 -0700 (PDT)
Subject: Re: [PATCH 1/2] io_uring: make the logic clearer for
 io_sequence_defer
From:   Jens Axboe <axboe@kernel.dk>
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     yangerkun <yangerkun@huawei.com>, linux-block@vger.kernel.org
References: <20191009011959.2203-1-liuyun01@kylinos.cn>
 <7af32ce6-dc8f-6683-2b99-95eefb598bff@huawei.com>
 <597dc8a4-b9db-f0b7-21b5-12050f07e766@kernel.dk>
 <544E51DB-7774-4DDF-A897-7A957AE2CDEB@kylinos.cn>
 <6e1c1450-4317-7acf-dfa0-40977de4b8ea@kernel.dk>
Message-ID: <31d425f0-4111-1aaa-641a-86fe528764f7@kernel.dk>
Date:   Thu, 10 Oct 2019 21:26:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6e1c1450-4317-7acf-dfa0-40977de4b8ea@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/10/19 9:17 PM, Jens Axboe wrote:
> On 10/10/19 9:06 PM, Jackie Liu wrote:
>>
>>
>>> 2019年10月11日 10:35，Jens Axboe <axboe@kernel.dk> 写道：
>>>
>>> On 10/10/19 8:24 PM, yangerkun wrote:
>>>>
>>>>
>>>> On 2019/10/9 9:19, Jackie Liu wrote:
>>>>> __io_get_deferred_req is used to get all defer lists, including defer_list
>>>>> and timeout_list, but io_sequence_defer should be only cares about the sequence.
>>>>>
>>>>> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
>>>>> ---
>>>>>     fs/io_uring.c | 13 +++++--------
>>>>>     1 file changed, 5 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>>>> index 8a0381f1a43b..8ec2443eb019 100644
>>>>> --- a/fs/io_uring.c
>>>>> +++ b/fs/io_uring.c
>>>>> @@ -418,9 +418,7 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
>>>>>     static inline bool io_sequence_defer(struct io_ring_ctx *ctx,
>>>>>     				     struct io_kiocb *req)
>>>>>     {
>>>>> -	/* timeout requests always honor sequence */
>>>>> -	if (!(req->flags & REQ_F_TIMEOUT) &&
>>>>> -	    (req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
>>>>> +	if ((req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
>>>>>     		return false;
>>>>>
>>>>>     	return req->sequence != ctx->cached_cq_tail + ctx->rings->sq_dropped;
>>>>> @@ -435,12 +433,11 @@ static struct io_kiocb *__io_get_deferred_req(struct io_ring_ctx *ctx,
>>>>>     		return NULL;
>>>>>
>>>>>     	req = list_first_entry(list, struct io_kiocb, list);
>>>>> -	if (!io_sequence_defer(ctx, req)) {
>>>>> -		list_del_init(&req->list);
>>>>> -		return req;
>>>>> -	}
>>>>> +	if (!(req->flags & REQ_F_TIMEOUT) && io_sequence_defer(ctx, req))
>>>>> +		return NULL;
>>>> Hi,
>>>>
>>>> For timeout req, we should also compare the sequence to determine to
>>>> return NULL or the req. But now we will return req directly. Actually,
>>>> no need to compare req->flags with REQ_F_TIMEOUT.
>>>
>>> Yes, not sure how I missed this, the patch is broken as-is. I will kill
>>> it, cleanup can be done differently.
>>
>> Sorry for miss it, I don't wanna change the logic, it's not my
>> original meaning.
> 
> No worries, mistakes happen.
> 
>> Personal opinion, timeout list should not be mixed with defer_list,
>> which makes the code more complicated and difficult to understand.
> 
> Not sure why you feel they are mixed? They are in separate lists, but
> they share using the sequence logic. In that respet they are really not
> that different, the sequence will trigger either one of them. Either as
> a timeout, or as a "can now be issued". Hence the code handling them is
> both shared and identical.
> 
> I do agree that the check could be cleaner, which is probably how the
> mistake in this patch happened in the first place.

I think we should just make it clear if the sequence checking is for
one of the paths - we don't want to defer anything based on a timeout,
just the timeout itself. That will also take care of the issue that
yangerkun brought up.

-- 
Jens Axboe

