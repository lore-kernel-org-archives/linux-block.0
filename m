Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB505C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 23:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA9D32184D
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 23:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IDm2zoSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfA2Xox (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:44:53 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34363 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbfA2Xox (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 18:44:53 -0500
Received: by mail-pf1-f194.google.com with SMTP id h3so10487501pfg.1
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 15:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w8cJr99XJLPwz1+tE/NaP1ZhKUWthEYLgUbG8sWkKgM=;
        b=IDm2zoSaA+edS9zuH+C0xCgXxgAab4TffbBktAZK2zQ1Ny1cN6V3BeM+ERANKYHTRH
         83FcDnY2IJ4nQQr3wf29zLcQvocp3WoZHRrvIn4AStsfXoZmLm4GuRmlESJuPKe5h8mb
         m4EAeYXYoTGk1bzl5rC3ZZJBvldVmI+EaYD0HG6J2y5gZPJ9Nuj9Rdi5kV2Zu9wY4eRT
         ET8wRyVQFMgWwCl/CI/xZG7UrIaF4IUI7YYpgP4GFZGMfl4BwBGod39Nrqj5+hTh9KGz
         qdm52KS4F4gM5ASTY0mJL4hSPDLpyvTAbp1L8fSYZVANChiAj83FeaayyZhekd2w3eVy
         Fuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w8cJr99XJLPwz1+tE/NaP1ZhKUWthEYLgUbG8sWkKgM=;
        b=giDY+MoLKOG8+DD7bj+OaFD5adEzwNefQbV7DUdJYrWI32JbA6Ky3UxGy12Qi5AqUc
         jT/NruPvbjkOS2F0nYmi4cO+2y+DYT2gTb/Sf1vFEd0QdDWGcZjzIoXHVfIfDvtUyM0A
         PmWDxnK1vvy/g3KftXRhG0w6IzSfZn618B3pMmuOmw26wkita/uzCw3BEgOX8QDi4t7r
         iqpIfDbfFlZNhzCltCfjNjh6HcDAtsFzGz82sO7QHqezStBRmojNum/NHSQvcjBnSP8G
         Zfl6GXpq9Wk0Y/Z4MJedBoZgtECPVpCvjw83enNSm/YyHc9xH+5lTCLIyRAnzCqNv5Sh
         ZQ1Q==
X-Gm-Message-State: AJcUukd31mqN6DSauoCGLr76RNiQk24jBQhMQn2fYDD731UEJhuK0zDg
        su4dhaXLhjx5q9HhwMvMLaMx+A==
X-Google-Smtp-Source: ALg8bN7W1G0ze/4Hvx9vZG7oyhcx+7NfbUN9BpC7xLrLqZSTHHMagrfyQjCTwnmTKHCYxMiqi+IsRw==
X-Received: by 2002:a63:7f4f:: with SMTP id p15mr25774617pgn.296.1548805491805;
        Tue, 29 Jan 2019 15:44:51 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id q5sm63334805pfi.165.2019.01.29.15.44.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 15:44:50 -0800 (PST)
Subject: Re: [PATCH 09/18] io_uring: use fget/fput_many() for file references
To:     Jann Horn <jannh@google.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
References: <20190129192702.3605-1-axboe@kernel.dk>
 <20190129192702.3605-10-axboe@kernel.dk>
 <CAG48ez3_1mY1Fb91Q3H-S2+4OiMsV5F9v78JX+YMjWqLteHpzw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bceb5e2b-9634-1296-a2a9-ed521f0e31d4@kernel.dk>
Date:   Tue, 29 Jan 2019 16:44:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez3_1mY1Fb91Q3H-S2+4OiMsV5F9v78JX+YMjWqLteHpzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/29/19 4:31 PM, Jann Horn wrote:
> On Tue, Jan 29, 2019 at 8:27 PM Jens Axboe <axboe@kernel.dk> wrote:
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
> [...]
>> +static void io_file_put(struct io_submit_state *state, struct file *file)
>> +{
>> +       if (!state) {
>> +               fput(file);
>> +       } else if (state->file) {
>> +               int diff = state->has_refs - state->used_refs;
>> +
>> +               if (diff)
>> +                       fput_many(state->file, diff);
>> +               state->file = NULL;
>> +       }
>> +}
> 
> Hmm, this function confuses me.
> The state==NULL path works as I'd expect, it calls fput() on the file.
> But if `state!=NULL && state->file==NULL`, it does nothing, it never
> uses `file`.
> And if `state->file!=NULL`, it drops the excess bias on the file's
> refcount, but it doesn't drop the current reference - and again
> without even looking at `file`.
> 
> So when io_prep_rw() uses io_file_get() to grab a reference on a file
> it hasn't seen before, it will acquire `ios_left` references and
> actually use one of them; then if it goes through the out_fput error
> path, it goes through the path for `state->file!=NULL`, drops
> `ios_left-1` references (leaving the refcount elevated by 1), and
> forgets about the file?

I'll take a look, it's not impossible there's an off-by-one there.

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
>> +
>> +       state->fd = fd;
>> +       state->has_refs = state->ios_left;
>> +       state->used_refs = 1;
>> +       state->ios_left--;
>> +       return state->file;
>> +}
>> +
>>  static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>> -                     bool force_nonblock)
>> +                     bool force_nonblock, struct io_submit_state *state)
>>  {
>>         struct io_ring_ctx *ctx = req->ctx;
>>         struct kiocb *kiocb = &req->rw;
>> @@ -487,7 +560,7 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>>         int fd, ret;
>>
>>         fd = READ_ONCE(sqe->fd);
>> -       kiocb->ki_filp = fget(fd);
>> +       kiocb->ki_filp = io_file_get(state, fd);
>>         if (unlikely(!kiocb->ki_filp))
>>                 return -EBADF;
>>         kiocb->ki_pos = READ_ONCE(sqe->off);
>> @@ -528,7 +601,7 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>>         }
>>         return 0;
>>  out_fput:
>> -       fput(kiocb->ki_filp);
>> +       io_file_put(state, kiocb->ki_filp);
>>         return ret;
>>  }
> [...]
>> +static void io_submit_state_start(struct io_submit_state *state,
>> +                                 struct io_ring_ctx *ctx, unsigned max_ios)
> 
> There are various places in your series where you use raw "unsigned"
> instead of "unsigned int"; when I run your tree through checkpatch.pl,
> it complains about that and a few other things. Please fix the
> checkpatch warnings (except for warnings where you know that they
> shouldn't apply here for some reason).

Using unsigned is just fine, it's the same thing. checkpatch.pl
complains about a lot of stuff that doesn't matter, that's one of them.
I don't mind fixing valid warnings, but this particular one is just
noise.

-- 
Jens Axboe

