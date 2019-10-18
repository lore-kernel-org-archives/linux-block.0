Return-Path: <SRS0=h0yA=YL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF72CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 15:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A1D21897
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 15:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dRwIXQLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408729AbfJRPA5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:00:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40678 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388225AbfJRPA5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Oct 2019 11:00:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id x127so4060370pfb.7
        for <linux-block@vger.kernel.org>; Fri, 18 Oct 2019 08:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/+oVECngHD65X+9K2fj3Gmg+fBpkD78y/9jiIlTXSvM=;
        b=dRwIXQLHmfE1hvQQ7M+Ri+JCzfjSfSFQTVVav22PaGx/bJ48BTx0zXDnR8THmMPJp3
         qjcE33Tg9gUYelKyp1EEosrF9glEPQ/CYhr8xmDjz77LTOsgdvHekDhppOeApV1puSfb
         QBkZ8MmHDEMZfOVouW8CwJ7BXxY+RwdiBfIi62tnCIzqMiDGUtAxeN1hNdg35Je+AOqF
         VNXRsy8lOn9lnUJhmt9zy+rHUBQkt3NEBjg6QS25DybR7+fFYuoNxsqVeDL1KSU9j2DB
         lngXLx3ggQ/sGZbiA994pGPV620EFUB0gCMuojhFSVr50Z336rckrgsGHMWTWW6tkKqM
         UQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/+oVECngHD65X+9K2fj3Gmg+fBpkD78y/9jiIlTXSvM=;
        b=kB0WktCFbAv3/P0pLdgM/nHKaSrKImvQ65v68bHyq1ASLOIJ7b+a5muVVIhUNaPKhK
         EX77HWkYTdsFomPS1V0jqTtN6q2fL7tAGBrzMDkgQMMpkNdZXsM2JEbFRc8JahwQr77Y
         XrhK+aclm73qyzGuTtT4bMDq1f0/+u0cX5R8p/g0ed+qXgTBW9j1nLkignr9N8jLGb3h
         017X+qIRjDvqExkI9VAgVpbiAajeWus6l5yP+DaqYzny3vMnt2+WpAVEmTlRHHMt5CAm
         du0fGWXDOGdlttyAmh3OKbu/0OWRCLNSDRP9mLKbYAuOm3SZfR+07Gvxocc6dx8Hf3JG
         QvXw==
X-Gm-Message-State: APjAAAVPGyEncY5J8l+Wtr9d9QD0Y8kmyXI5aai+vhj+QUrn/WVxi7EV
        2Wu362934VowTF/8q5/bw2vee+GiZX1EQw==
X-Google-Smtp-Source: APXvYqyeK09uK4GA0//Rm50Y3DXBAggJKMB5nDg5zMgeTG4cAMhOLguZ0xaO/XujgFuiu4y3e6sy6g==
X-Received: by 2002:a65:689a:: with SMTP id e26mr10667305pgt.346.1571410856155;
        Fri, 18 Oct 2019 08:00:56 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id u11sm8977817pgo.65.2019.10.18.08.00.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 08:00:54 -0700 (PDT)
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
 <a54329d5-a128-3ccd-7a12-f6cadaa20dbf@kernel.dk>
 <CAG48ez1SDQNHjgFku4ft4qw9hdv1g6-sf7-dxuU_tJSx+ofV-w@mail.gmail.com>
 <dbcf874d-8484-9c27-157a-c2752181acb5@kernel.dk>
 <CAG48ez3KwaQ3DVH1VoWxFWTG2ZfCQ6M0oyv5vZqkLgY0QDEdiw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a8fb7a1f-69c7-bf2a-b3dd-7886077d234b@kernel.dk>
Date:   Fri, 18 Oct 2019 09:00:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez3KwaQ3DVH1VoWxFWTG2ZfCQ6M0oyv5vZqkLgY0QDEdiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/18/19 8:52 AM, Jann Horn wrote:
> On Fri, Oct 18, 2019 at 4:43 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 10/18/19 8:40 AM, Jann Horn wrote:
>>> On Fri, Oct 18, 2019 at 4:37 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> On 10/18/19 8:34 AM, Jann Horn wrote:
>>>>> On Fri, Oct 18, 2019 at 4:01 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>> On 10/17/19 8:41 PM, Jann Horn wrote:
>>>>>>> On Fri, Oct 18, 2019 at 4:01 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>>>> This is in preparation for adding opcodes that need to modify files
>>>>>>>> in a process file table, either adding new ones or closing old ones.
>>>>> [...]
>>>>>> Updated patch1:
>>>>>>
>>>>>> http://git.kernel.dk/cgit/linux-block/commit/?h=for-5.5/io_uring-test&id=df6caac708dae8ee9a74c9016e479b02ad78d436
>>>>>
>>>>> I don't understand what you're doing with old_files in there. In the
>>>>> "s->files && !old_files" branch, "current->files = s->files" happens
>>>>> without holding task_lock(), but current->files and s->files are also
>>>>> the same already at that point anyway. And what's the intent behind
>>>>> assigning stuff to old_files inside the loop? Isn't that going to
>>>>> cause the workqueue to keep a modified current->files beyond the
>>>>> runtime of the work?
>>>>
>>>> I simply forgot to remove the old block, it should only have this one:
>>>>
>>>> if (s->files && s->files != cur_files) {
>>>>           task_lock(current);
>>>>           current->files = s->files;
>>>>           task_unlock(current);
>>>>           if (cur_files)
>>>>                   put_files_struct(cur_files);
>>>>           cur_files = s->files;
>>>> }
>>>
>>> Don't you still need a put_files_struct() in the case where "s->files
>>> == cur_files"?
>>
>> I want to hold on to the files for as long as I can, to avoid unnecessary
>> shuffling of it. But I take it your worry here is that we'll be calling
>> something that manipulates ->files? Nothing should do that, unless
>> s->files is set. We didn't hide the workqueue ->files[] before this
>> change either.
> 
> No, my worry is that the refcount of the files_struct is left too
> high. From what I can tell, the "do" loop in io_sq_wq_submit_work()
> iterates over multiple instances of struct sqe_submit. If there are
> two sqe_submit instances with the same ->files (each holding a
> reference from the get_files_struct() in __io_queue_sqe()), then:
> 
> When processing the first sqe_submit instance, current->files and
> cur_files are set to $user_files.
> When processing the second sqe_submit instance, nothing happens
> (s->files == cur_files).
> After the loop, at the end of the function, put_files_struct() is
> called once on $user_files.
> 
> So get_files_struct() has been called twice, but put_files_struct()
> has only been called once. That leaves the refcount too high, and by
> repeating this, an attacker can make the refcount wrap around and then
> cause a use-after-free.

Ah now I see what you are getting at, yes that's clearly a bug! I wonder
how we best safely can batch the drops. We can track the number of times
we've used the same files, and do atomic_sub_and_test() in a
put_files_struct_many() type addition. But that would leave us open to
the issue you describe, where someone could maliciously overflow the
files ref count.

Probably not worth over-optimizing, as long as we can avoid the
current->files task lock/unlock and shuffle.

I'll update the patch.

-- 
Jens Axboe

