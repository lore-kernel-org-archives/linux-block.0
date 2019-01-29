Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A63BC282CF
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 02:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD02D2177E
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 02:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="j6FNKIG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfA2CVc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 21:21:32 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44207 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfA2CVc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 21:21:32 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so8058603pgr.11
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 18:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IIiS9N17iG5OlUwhjaXic+KwwT90wvpRnJgT4+DsptY=;
        b=j6FNKIG8DV78OFxeeTRCrvJeQrK2hM2+Fuk145McOJMrsJWnRk15hWhV3ZZBKUOtU9
         fCqF5cKCcBJYBeKO3ydNxg1Ug/YMP4sD3sPb95URWJzooszcf3LaMKaK8MEn4g/gr2aC
         3ZhfBDaOqvvepCqd04EPNDfI/zyAVWZgDA2BFFHATXuACZCefFRNopeWP2JMIeonPvZu
         tZXbhR2So4meZccRCGO9LsdABzc3Ny6pvtg+OTnXyXdUIS7B9HydDYNf89o4n1iF6oFp
         TF9nx+luuQ+joOZibIee0KMZdkc/tDdVoBm++z8pFNo+DEUs5+ghpZYdktWm4JRDfM99
         f6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IIiS9N17iG5OlUwhjaXic+KwwT90wvpRnJgT4+DsptY=;
        b=IiXt7qokW6mDlUtj4D8EkQZhaeRw2jWJLx68UiQ1Iw6AlGjo6WDLhLmYRnPDbY6yHJ
         VyNFgnPTwJO5kuZOSfPell4eX6LuFCMhH2VE0RkiGSvg+zCsXL+R0BOBDQTE5klTEIiY
         XGrE4a1Nz5+yYAHWc4W0X2tct6xzoinefem74CS42w6f8yg+okdKrDu84XjN59MEaXnm
         7SgtoruNtfTAl/+wa3YIX9PWn/Wz0tjBKT92l8NPz56Mhxo0rQgsUuAvI6VjcVWtvQ+P
         SR2ZyTvj2LAySRwJO7opdyRe3LHVN6fY9KB8KIA1GHFpsr7EON8hhex5AW1f06s1rCol
         Fn0Q==
X-Gm-Message-State: AJcUuke81uv8uj8HViUSztr+Fea0Qba3ClxptySxegevdaENoZUYz5kr
        36DHROGi1uorWK2yBxD+JHdocg==
X-Google-Smtp-Source: ALg8bN7FOte7i/svy2IjzoECAkSCJWNRYXLGN+RDhZvqxexYmqAHCKtmLJOLUmWLuRbJAqreMPjLMA==
X-Received: by 2002:a63:f844:: with SMTP id v4mr21852419pgj.82.1548728491122;
        Mon, 28 Jan 2019 18:21:31 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id m19sm62348560pgn.35.2019.01.28.18.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 18:21:29 -0800 (PST)
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Jann Horn <jannh@google.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
References: <20190128213538.13486-1-axboe@kernel.dk>
 <20190128213538.13486-6-axboe@kernel.dk>
 <CAG48ez1qxZLfJzK95kjh0RiQ6kvZLbQhr6Dr0EjBNQB6Fr7NXQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6ade41f5-1b21-51ec-91f3-d55b77a7c6c1@kernel.dk>
Date:   Mon, 28 Jan 2019 19:21:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez1qxZLfJzK95kjh0RiQ6kvZLbQhr6Dr0EjBNQB6Fr7NXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/19 6:07 PM, Jann Horn wrote:
> On Mon, Jan 28, 2019 at 10:35 PM Jens Axboe <axboe@kernel.dk> wrote:
>> The submission queue (SQ) and completion queue (CQ) rings are shared
>> between the application and the kernel. This eliminates the need to
>> copy data back and forth to submit and complete IO.
> [...]
>> +static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
>> +{
>> +       struct io_sq_ring *ring = ctx->sq_ring;
>> +       unsigned head;
>> +
>> +       /*
>> +        * The cached sq head (or cq tail) serves two purposes:
>> +        *
>> +        * 1) allows us to batch the cost of updating the user visible
>> +        *    head updates.
>> +        * 2) allows the kernel side to track the head on its own, even
>> +        *    though the application is the one updating it.
>> +        */
>> +       head = ctx->cached_sq_head;
>> +       smp_rmb();
>> +       if (head == READ_ONCE(ring->r.tail))
>> +               return false;
>> +
>> +       head = ring->array[head & ctx->sq_mask];
>> +       if (head < ctx->sq_entries) {
>> +               s->index = head;
>> +               s->sqe = &ctx->sq_sqes[head];
> 
> ring->array can be mapped writable into userspace, right? If so: This
> looks like a double-read issue; the compiler might assume that
> ring->array is not modified concurrently and perform separate memory
> accesses for the "if (head < ctx->sq_entries)" check and the
> "&ctx->sq_sqes[head]" computation. Please use READ_ONCE()/WRITE_ONCE()
> for all accesses to memory that userspace could concurrently modify in
> a malicious way.
> 
> There have been some pretty severe security bugs caused by missing
> READ_ONCE() annotations around accesses to shared memory; see, for
> example, https://www.blackhat.com/docs/us-16/materials/us-16-Wilhelm-Xenpwn-Breaking-Paravirtualized-Devices.pdf
> . Slides 35-48 show how the code "switch (op->cmd)", where "op" is a
> pointer to shared memory, allowed an attacker to break out of a Xen
> virtual machine because the compiler generated multiple memory
> accesses.

Thanks, I'll update these to use READ/WRITE_ONCE.

>> +               ctx->cached_sq_head++;
>> +               return true;
>> +       }
>> +
>> +       /* drop invalid entries */
>> +       ctx->cached_sq_head++;
>> +       ring->dropped++;
>> +       smp_wmb();
>> +       return false;
>> +}
> [...]
>> +SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
>> +               u32, min_complete, u32, flags, const sigset_t __user *, sig,
>> +               size_t, sigsz)
>> +{
>> +       struct io_ring_ctx *ctx;
>> +       long ret = -EBADF;
>> +       struct fd f;
>> +
>> +       f = fdget(fd);
>> +       if (!f.file)
>> +               return -EBADF;
>> +
>> +       ret = -EOPNOTSUPP;
>> +       if (f.file->f_op != &io_uring_fops)
>> +               goto out_fput;
> 
> Oh, by the way: If you feel like it, maybe you could add a helper
> fdget_typed(int fd, struct file_operations *f_op), or something like
> that, so that there is less boilerplate code for first doing fdget(),
> then checking ->f_op, and then coding an extra bailout path for that?
> But that doesn't really have much to do with your patchset, feel free
> to ignore this comment.

That's not a bad idea, I think this is a fairly common code pattern.
I'll look into it.

-- 
Jens Axboe

