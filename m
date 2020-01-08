Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C97AC33C99
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 02:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CEF32075A
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 02:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyiIEaj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgAHC7O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 21:59:14 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37399 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgAHC7O (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 21:59:14 -0500
Received: by mail-pf1-f195.google.com with SMTP id p14so857893pfn.4
        for <linux-block@vger.kernel.org>; Tue, 07 Jan 2020 18:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3XTsihOM+7EQ3RJVF7YKBo+3NphotgLfQnI/lgYV8n0=;
        b=cyiIEaj2EuZDlg6EpgxTjvsvtnN/v/ZhqcxUwwVG/AVr/qq8+/S9YPyD/L33XS4lHO
         V+saRzsjID2IQhbBWuMGwgSmqzLNGWqbsHmiT6MBEC7BHMDhldpP6SVA5MvuhQrlDnIM
         1uJ7YOqPcH51sCV6xroTAhWpRhyQ+16WzglE19skVi0ZDySJ14RKHnFWBlR5cBZr7o4q
         eYrblynZtkXPBUTgYAqq/zhhinAr9/ilm4v2j3NQk717jetTK2bQUI/vzGGNmno8/h8p
         3Y/q2UKSZ0tV2s+MDeKJj4E/HS9FGQs8/BC0L8WkiP/CLo7zU+7Vnczfpi9FTPxcJbM0
         2pbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3XTsihOM+7EQ3RJVF7YKBo+3NphotgLfQnI/lgYV8n0=;
        b=k09qCPio+howomtsICSwWG3YuzXKyJqjF5hf8gydkroqh6nDcY91NYa9S2Lfx1tJ6R
         d2MLY6Cgym7ITuqCaRqtWEmQ78PQszQSuIK6Hg+gMD20pcEjTpVLXlq8mWfQTmVXvlCV
         mFjLHNJgfLqixuYeU2xaQyz99fmyLeQHw1XEmne1oMxVCiz5sR5O7cSa1ud2f0FbxMnA
         a8zyP/0E3fnSrKMBQvx4sDiPvKdRyPdqwfd0aZB6RcBlxL3G7kTQzS8n2eOqG46RnwRG
         ONmp+orqH1qMgmfFg4dpzMhxD7gS4Y9B6x8OjAMjwfUEztsk6KBjXECA0n4sNYrzGL46
         hrrQ==
X-Gm-Message-State: APjAAAVFL3Fsrpx5W77FTlw28/F7JjXygMq2FoXVPAVRSamxPNNUJjk9
        5wmWxwF+IcfqnwPwFzx0QxNfKg6l
X-Google-Smtp-Source: APXvYqwDaZmy7GxZOlCGyyXJEnZPT7bt8bBdguzglG6JCFic9y19bUk870yP4X7DWXXkH15BC79ePQ==
X-Received: by 2002:a63:f814:: with SMTP id n20mr2910742pgh.318.1578452352476;
        Tue, 07 Jan 2020 18:59:12 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q12sm955375pfh.158.2020.01.07.18.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 18:59:11 -0800 (PST)
Subject: Re: [PATCH] block: fix get_max_segment_size() overflow on 32bit arch
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20200108012526.26731-1-ming.lei@redhat.com>
 <BYAPR04MB581614236B3088415240723AE73E0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <a5fa8b59-6685-d914-6163-1d515777300b@kernel.dk>
 <BYAPR04MB5816C3DA0641956670F2B323E73E0@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <be4b6c8b-b05b-edfe-0e42-a43015f8295e@roeck-us.net>
Date:   Tue, 7 Jan 2020 18:59:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5816C3DA0641956670F2B323E73E0@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/7/20 6:38 PM, Damien Le Moal wrote:
> On 2020/01/08 11:34, Jens Axboe wrote:
>> On 1/7/20 7:06 PM, Damien Le Moal wrote:
>>> On 2020/01/08 10:25, Ming Lei wrote:
>>>> Commit 429120f3df2d starts to take account of segment's start dma address
>>>> when computing max segment size, and data type of 'unsigned long'
>>>> is used to do that. However, the segment mask may be 0xffffffff, so
>>>> the figured out segment size may be overflowed because DMA address can
>>>> be 64bit on 32bit arch.
>>>>
>>>> Fixes the issue by using 'unsigned long long' to compute max segment
>>>> size.
>>>>
>>>> Fixes: 429120f3df2d ("block: fix splitting segments on boundary masks")
>>>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>>>> Tested-by: Guenter Roeck <linux@roeck-us.net>
>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>> ---
>>>>   block/blk-merge.c | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>>>> index 347782a24a35..b0fcc72594cb 100644
>>>> --- a/block/blk-merge.c
>>>> +++ b/block/blk-merge.c
>>>> @@ -159,12 +159,12 @@ static inline unsigned get_max_io_size(struct request_queue *q,
>>>>   
>>>>   static inline unsigned get_max_segment_size(const struct request_queue *q,
>>>>   					    struct page *start_page,
>>>> -					    unsigned long offset)
>>>> +					    unsigned long long offset)
>>>>   {
>>>>   	unsigned long mask = queue_segment_boundary(q);
>>>>   
>>>>   	offset = mask & (page_to_phys(start_page) + offset);
>>>
>>> Shouldn't mask be an unsigned long long too for this to give the
>>> expected correct result ?
>>
>> Don't think so, and the seg boundary is a ulong to begin with as well.
>>
> 
> I was referring to 32bits arch were ulong is 32bits. So we would have
> 
> offset = 32bits & 64bits;
> 
> with the patch applied. But I am not sure how gcc handles that and if
> this can be a problem.
> 

Type extension is well defined in the C standard.

The underlying problem here is that mask is 0xffffffff, and
page_to_phys(start_page) as well as offset are sometimes 0.
In this situation, mask - offset + 1 is 0 if offset is a 32 bit
variable, and 0x100000000 if offset is a 64 bit variable.
In the first case, this results in a wrong maximum segment
size of 0.

Guenter
