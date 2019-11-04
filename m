Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16CCCA9EB5
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 14:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A428E218BA
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 14:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QzVDcp7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfKDONE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:13:04 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35987 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbfKDONE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Nov 2019 09:13:04 -0500
Received: by mail-io1-f67.google.com with SMTP id s3so14739010ioe.3
        for <linux-block@vger.kernel.org>; Mon, 04 Nov 2019 06:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=drwMKjKDvjrnZaTt9fJDP755iODz77vZn/nO53mrJKU=;
        b=QzVDcp7B7vbDSj+tG86Jo/8GRXUczMnyLTLb7k72YTCw9/J2le0XUkuLxUf5FOlbxT
         GBxvFnSN0ptLWAFybFgJxavXBFjiPEuHgNUmHq5zqoH60YqCJoTdXCm5eHMv+WrR+nND
         n1UYNuCIl90yE7xAZ4nqqpusdD3XCpfeCh+/z1uCfve+o4MvdRFi88gAHVSE4TM91CF6
         u+1xRM07XcLMI6Pt1lvvj5f801BGqgA52AKBS6BgzWsouK6Pu2YHVyJ9RI0Uj9SFwYLC
         aXJYvjOc51npJ4RmkMhwkrm1VGnl2MnRq59a2h/Sj2fWMukkgcXZF+YTbH7nELDF0fTz
         Fl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=drwMKjKDvjrnZaTt9fJDP755iODz77vZn/nO53mrJKU=;
        b=KAfm/67fmEw3XIN4jFYUjLe/bP54RzM7P+IVjKTVvpOIykT783NMqUIxFsvr+E7Wwv
         7RojxpZWvwZnMkaj8iCS6HpbH0yLEfl1U+comiAyahZmIkek92htKQgqoO6HaKtOgkAC
         /B6t0cXew2pjyM87GY2ffzEEYI1wcUiQlv5O3VGYyxaeMJVzkWP7BJ9d/v/3qz9XzsFI
         0KEaLTKvtSY6b135yLHh5E86fRS9dEXcV/HkGjUugEucWTntPBgsfwLbN5kAbEbTJW4S
         nnuRUt3XjhJNfFsWVnUL98viJBlAfDCoS2MNO4syfZYcOmuJ/AMSoevBJPd1tmeNQbl8
         CRZw==
X-Gm-Message-State: APjAAAUI+ko6RaBjLHyp+uD7mLyXolA+SRMEtWjyVLrg2Np6oHcjdxzX
        CKZ7H+rcHhggciTOQUnfgi6t9lKnCQ5VsA==
X-Google-Smtp-Source: APXvYqzPW3xIGknp4X+SpcAg8JFZgClmTI+WxcADY21W/e2aAO9J+f1c9bU5Kn9ONJH5ysGoaxcT8Q==
X-Received: by 2002:a02:9084:: with SMTP id x4mr15315991jaf.76.1572876782635;
        Mon, 04 Nov 2019 06:13:02 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a11sm1905389ilb.72.2019.11.04.06.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 06:13:01 -0800 (PST)
Subject: Re: [PATCH] blk-mq: avoid sysfs buffer overflow by too many CPU cores
To:     Hannes Reinecke <hare@suse.de>, Ming Lei <tom.leiming@gmail.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20191102080215.20223-1-ming.lei@redhat.com>
 <BYAPR04MB574951ACBF23CBDA280282A0867C0@BYAPR04MB5749.namprd04.prod.outlook.com>
 <CACVXFVO3MafpBcufM+eYZM5A-Yip5JGSqiC4kOgejVNnTNjYOA@mail.gmail.com>
 <a7100fe3-fe27-407a-8237-27dc31df59d0@kernel.dk>
 <6eaff732-a4df-3465-c9f5-427bfb5caa20@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f640f80d-2c4f-8318-a68e-6a0a6f9f2c01@kernel.dk>
Date:   Mon, 4 Nov 2019 07:13:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6eaff732-a4df-3465-c9f5-427bfb5caa20@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/3/19 11:57 PM, Hannes Reinecke wrote:
> On 11/4/19 2:56 AM, Jens Axboe wrote:
>> On 11/3/19 4:57 PM, Ming Lei wrote:
>>> On Sun, Nov 3, 2019 at 8:28 AM Chaitanya Kulkarni
>>> <Chaitanya.Kulkarni@wdc.com> wrote:
>>>>
>>>> Ming,
>>>>
>>>> On 11/02/2019 01:02 AM, Ming Lei wrote:
>>>>> It is reported that sysfs buffer overflow can be triggered in case
>>>>> of too many CPU cores(>841 on 4K PAGE_SIZE) when showing CPUs of
>>>>> hctx via/sys/block/$DEV/mq/$N/cpu_list.
>>>>>
>>>>> So use snprintf for avoiding the potential buffer overflow.
>>>>>
>>>>> This version doesn't change the attribute format, and simply stop
>>>>> to show CPU number if the buffer is to be overflow.
>>>>
>>>> Does it make sense to also add a print or WARN_ON in case of overflow ?
>>>
>>> Yes, it does, could you cook a patch for that?
>>
>> No it doesn't. The WARN_ON brings absolutely nothing. If you're using
>> a script, it gets the same values out and doesn't see the warning. If
>> it's a human cat'ing it, they will probably already realize that
>> we're missing CPUs. Or maybe not even see the warning. It's useless.
>>
>> We should either make this seqfile, or just kill the file. Those are
>> the only two options that make any sense.
>>
> I'd rather retain that file; it proved really useful when debugging
> interrupt affinity issues.

Care to take a look at converting to seq_file?

-- 
Jens Axboe

