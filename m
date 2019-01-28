Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E543C282CD
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 22:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5862183F
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 22:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kymIw2Zi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfA1WDy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 17:03:54 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35471 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbfA1WDx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 17:03:53 -0500
Received: by mail-it1-f196.google.com with SMTP id p197so1010348itp.0
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 14:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KCUixYSM0JtB2PM5YmnNOfcBYzQIgjQuxrZKD8ZHEcU=;
        b=kymIw2ZiyoBTUhDlDEwUay2aZ/7E7XE7HfmhQ7wysRTslI88h59YdIVpAQ+E8tevPT
         vawG4K9UyJU6nfKjDMp7MT2Abp7ENHLHX3MyDpO+Wm80PinoNjQ0nx8gABFyZIHh5bEr
         dxkoMWbs92owvwKEQRY+uG7iZFkeCok7sNZ59dRDv9ONRIbpBmCgtKVsMB1mUfU9UoDn
         suAXYUgOOlCtQVGfHprh7LCkDIAiADdm6idI9WYu0IQ6/R/EbljSdf6KRYvj5tfpgnvT
         D2wqyWwwZ9rJf6L5AL89NrQNnHVTt5BnPSJpCpPZ43Bx3TZkdBzR8O9BZbNmeRG8lBIR
         mq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KCUixYSM0JtB2PM5YmnNOfcBYzQIgjQuxrZKD8ZHEcU=;
        b=eeJzDP9Pwc9EWAY/rdhL3pJbO3h63N1WqAr74daUEMl9X690TCE5250dUTy2eMEd4G
         aCEb80kFcc8b96mijMR8E6tszZrOYyxMuGqjysBWj1jm1GMLDz5pPepBg62pGrcsIzFP
         diRrY36yXqnKK6s4Oiy1dslYE7SJHDIOMOcdT5GTGR6Y49pgT91ZrNP4oA22C8WxQUjY
         6w9xgdft2/imrgf9+n1T7t0Okq7SMFsMpwokbpCgoVDRw2hX8cRBuHox9nB175D+Jald
         pHma5P3CDMv1tHiytvBftin0e4WtHvRl/O2VpqyH0z7IhiQMw7YrUuB9lbLcP/tRSS96
         sJEA==
X-Gm-Message-State: AJcUukcaymFd4lggo18FkZ4H5RUD1hFAhrKfdUG5XKMij7MDy3lZM2VW
        DbDY1NJc40XCbP778beiZVEB5w==
X-Google-Smtp-Source: ALg8bN4t99gZHNnF/6jTERWBQ+E442Olo2e2ZtdqcjPBrEHx7qkAkD+6p7eLAavd7GOv+9DW2cUIXA==
X-Received: by 2002:a24:390a:: with SMTP id l10mr11209097ita.0.1548713032029;
        Mon, 28 Jan 2019 14:03:52 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r21sm13549734ioc.18.2019.01.28.14.03.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 14:03:51 -0800 (PST)
Subject: Re: [PATCH 09/18] io_uring: use fget/fput_many() for file references
To:     Jann Horn <jannh@google.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
References: <20190128213538.13486-1-axboe@kernel.dk>
 <20190128213538.13486-10-axboe@kernel.dk>
 <CAG48ez0WzBEG5w5faFZ_DjU_62aTT=iBEPHEdYZuyq-LGRJtPw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1e235e71-b988-fac1-ea85-9a9d5f70ef5d@kernel.dk>
Date:   Mon, 28 Jan 2019 15:03:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez0WzBEG5w5faFZ_DjU_62aTT=iBEPHEdYZuyq-LGRJtPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/19 2:56 PM, Jann Horn wrote:
> On Mon, Jan 28, 2019 at 10:36 PM Jens Axboe <axboe@kernel.dk> wrote:
>> Add a separate io_submit_state structure, to cache some of the things
>> we need for IO submission.
>>
>> One such example is file reference batching. io_submit_state. We get as
>> many references as the number of sqes we are submitting, and drop
>> unused ones if we end up switching files. The assumption here is that
>> we're usually only dealing with one fd, and if there are multiple,
>> hopefuly they are at least somewhat ordered. Could trivially be extended
>> to cover multiple fds, if needed.
>>
>> On the completion side we do the same thing, except this is trivially
>> done just locally in io_iopoll_reap().
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
> [...]
>> +/*
>> + * Get as many references to a file as we have IOs left in this submission,
>> + * assuming most submissions are for one file, or at least that each file
>> + * has more than one submission.
>> + */
>> +static struct file *io_file_get(struct io_submit_state *state, int fd)
>> +{
>> +       if (!state)
>> +               return fget(fd);
>> +
>> +       if (state->file) {
>> +               if (state->fd == fd) {
>> +                       state->used_refs++;
>> +                       state->ios_left--;
>> +                       return state->file;
>> +               }
>> +               io_file_put(state, NULL);
>> +       }
>> +       state->file = fget_many(fd, state->ios_left);
>> +       if (!state->file)
>> +               return NULL;
> 
> This looks wrong.
> 
> Looking at "[PATCH 05/18] Add io_uring IO interface", as far as I can
> tell, io_ring_submit() is called via __io_uring_enter() <-
> sys_io_uring_enter() with an unchecked argument "unsigned int
> to_submit" that is then, in this patch, stored in state->ios_left and
> then used here. On a 32-bit platform, file->f_count is only 32 bits
> wide, so I think you can then trivially overflow the reference count,
> leading to use-after-free. Am I missing something?

No, that is possible. Since we cap the SQ ring entries at 4k, I think
we should just validate to_submit/min_complete against those numbers.
That would also solve this overflow.

-- 
Jens Axboe

