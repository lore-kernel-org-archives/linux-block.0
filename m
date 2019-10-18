Return-Path: <SRS0=h0yA=YL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD6DCA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 16:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D988222BD
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 16:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LGWAAEx6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390022AbfJRQUz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:20:55 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33585 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388711AbfJRQUz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Oct 2019 12:20:55 -0400
Received: by mail-oi1-f194.google.com with SMTP id a15so5722611oic.0
        for <linux-block@vger.kernel.org>; Fri, 18 Oct 2019 09:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CJxuQG0BQgHyGgtpaav96f0qtJ4vYTs6JXRupHe9rUE=;
        b=LGWAAEx6MZAzc9dzt9oN1f2ExEoXtK7S2YsAJhWPy9Xmms0v+eV0/7qkaRvCjIZRBC
         4MMmJzuMhhkR9RzW2PXtTDJ0mMDTMJPsWAh4igmcz4LjlpfvOGD2TFhhvPObNDvfL+0O
         ElH7Wo0GuNo2cHkOo23i4mD8TwFFSUSt7NZpk5dq2hhPI35+BMjuTTXQ5tx2FH6BxtKv
         5uOQLIrAGLcvfgMzLFJt30cKGEzFR6KQTxsMa7FZ1lIMA5wFua4+UJzegsnU6ZliGLq1
         KgKIygo9j8/y8W1R9QzTZRNPBbHzKPTWDW3+iMpe/75w1dI58+AQxRSciVsr16S+xwut
         2Jng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CJxuQG0BQgHyGgtpaav96f0qtJ4vYTs6JXRupHe9rUE=;
        b=uRugFJ/7ltskm7cuooOzzlowDIW9qbfZSMzXvR177ZYjlwTc75cKJBhC3oRCZWMUZ9
         BD/BI2gsrglNh0pTFb2eiCnBF0WHvlRheYs6IjkOv5Qt3RS/323EFffJ9PXbexII2NK2
         4I+pIT/PQyohJ+hFY2C+bAGnqVNaKOwmKUkoI4KrYZUPXN28wEYY0Wze/8hhvscMeGU8
         L4OPF1q3cVHdJLKgapHqYHWXwe+vCtKld41GF+rtZVbORjCZehEpInlciP2rYq3ut7Rq
         VEwKsLh7KklK4CkGHUAMo7gM2xltGNyOz2zIAqSPRM9521wyxKevLD5KWavkTx23IT0m
         Ehvg==
X-Gm-Message-State: APjAAAUJrNp3AsBPo663UhmDzQrPZ8uQ91P++iaQNEBMJA6O2phr3qEG
        q+Z4uXsYDHG10nEJ9EHimmLzBI8kZXP5IjRNCTlAiw==
X-Google-Smtp-Source: APXvYqx0bQwNAgJj+cQuGTCR/WcIDlBQaNntTb0JVhBwUywPcqQA8qdhdEdrWk/uuYCxOADoSvNimq3NFNaj5PqSKAk=
X-Received: by 2002:aca:5c06:: with SMTP id q6mr8880521oib.175.1571415653813;
 Fri, 18 Oct 2019 09:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191017212858.13230-1-axboe@kernel.dk> <20191017212858.13230-2-axboe@kernel.dk>
 <CAG48ez0G2y0JS9=S2KmePO3xq-5DuzgovrLFiX4TJL-G897LCA@mail.gmail.com>
 <0fb9d9a0-6251-c4bd-71b0-6e34c6a1aab8@kernel.dk> <CAG48ez181=JoYudXee0KbU0vDZ=EbxmgB7q0mmjaA0gyp6MFBQ@mail.gmail.com>
 <a54329d5-a128-3ccd-7a12-f6cadaa20dbf@kernel.dk> <CAG48ez1SDQNHjgFku4ft4qw9hdv1g6-sf7-dxuU_tJSx+ofV-w@mail.gmail.com>
 <dbcf874d-8484-9c27-157a-c2752181acb5@kernel.dk> <CAG48ez3KwaQ3DVH1VoWxFWTG2ZfCQ6M0oyv5vZqkLgY0QDEdiw@mail.gmail.com>
 <a8fb7a1f-69c7-bf2a-b3dd-7886077d234b@kernel.dk> <572f40fb-201c-99ce-b3f5-05ff9369b895@kernel.dk>
In-Reply-To: <572f40fb-201c-99ce-b3f5-05ff9369b895@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 18 Oct 2019 18:20:27 +0200
Message-ID: <CAG48ez12pteHyZasU8Smup-0Mn3BWNMCVjybd1jvXsPrJ7OmYg@mail.gmail.com>
Subject: Re: [PATCH 1/3] io_uring: add support for async work inheriting files table
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 18, 2019 at 5:55 PM Jens Axboe <axboe@kernel.dk> wrote:
> On 10/18/19 9:00 AM, Jens Axboe wrote:
> > On 10/18/19 8:52 AM, Jann Horn wrote:
> >> On Fri, Oct 18, 2019 at 4:43 PM Jens Axboe <axboe@kernel.dk> wrote:
> >>>
> >>> On 10/18/19 8:40 AM, Jann Horn wrote:
> >>>> On Fri, Oct 18, 2019 at 4:37 PM Jens Axboe <axboe@kernel.dk> wrote:
> >>>>>
> >>>>> On 10/18/19 8:34 AM, Jann Horn wrote:
> >>>>>> On Fri, Oct 18, 2019 at 4:01 PM Jens Axboe <axboe@kernel.dk> wrote:
> >>>>>>> On 10/17/19 8:41 PM, Jann Horn wrote:
> >>>>>>>> On Fri, Oct 18, 2019 at 4:01 AM Jens Axboe <axboe@kernel.dk> wrote:
> >>>>>>>>> This is in preparation for adding opcodes that need to modify files
> >>>>>>>>> in a process file table, either adding new ones or closing old ones.
> >>>>>> [...]
> >>>>>>> Updated patch1:
> >>>>>>>
> >>>>>>> http://git.kernel.dk/cgit/linux-block/commit/?h=for-5.5/io_uring-test&id=df6caac708dae8ee9a74c9016e479b02ad78d436
> >>>>>>
> >>>>>> I don't understand what you're doing with old_files in there. In the
> >>>>>> "s->files && !old_files" branch, "current->files = s->files" happens
> >>>>>> without holding task_lock(), but current->files and s->files are also
> >>>>>> the same already at that point anyway. And what's the intent behind
> >>>>>> assigning stuff to old_files inside the loop? Isn't that going to
> >>>>>> cause the workqueue to keep a modified current->files beyond the
> >>>>>> runtime of the work?
> >>>>>
> >>>>> I simply forgot to remove the old block, it should only have this one:
> >>>>>
> >>>>> if (s->files && s->files != cur_files) {
> >>>>>            task_lock(current);
> >>>>>            current->files = s->files;
> >>>>>            task_unlock(current);
> >>>>>            if (cur_files)
> >>>>>                    put_files_struct(cur_files);
> >>>>>            cur_files = s->files;
> >>>>> }
> >>>>
> >>>> Don't you still need a put_files_struct() in the case where "s->files
> >>>> == cur_files"?
> >>>
> >>> I want to hold on to the files for as long as I can, to avoid unnecessary
> >>> shuffling of it. But I take it your worry here is that we'll be calling
> >>> something that manipulates ->files? Nothing should do that, unless
> >>> s->files is set. We didn't hide the workqueue ->files[] before this
> >>> change either.
> >>
> >> No, my worry is that the refcount of the files_struct is left too
> >> high. From what I can tell, the "do" loop in io_sq_wq_submit_work()
> >> iterates over multiple instances of struct sqe_submit. If there are
> >> two sqe_submit instances with the same ->files (each holding a
> >> reference from the get_files_struct() in __io_queue_sqe()), then:
> >>
> >> When processing the first sqe_submit instance, current->files and
> >> cur_files are set to $user_files.
> >> When processing the second sqe_submit instance, nothing happens
> >> (s->files == cur_files).
> >> After the loop, at the end of the function, put_files_struct() is
> >> called once on $user_files.
> >>
> >> So get_files_struct() has been called twice, but put_files_struct()
> >> has only been called once. That leaves the refcount too high, and by
> >> repeating this, an attacker can make the refcount wrap around and then
> >> cause a use-after-free.
> >
> > Ah now I see what you are getting at, yes that's clearly a bug! I wonder
> > how we best safely can batch the drops. We can track the number of times
> > we've used the same files, and do atomic_sub_and_test() in a
> > put_files_struct_many() type addition. But that would leave us open to
> > the issue you describe, where someone could maliciously overflow the
> > files ref count.
> >
> > Probably not worth over-optimizing, as long as we can avoid the
> > current->files task lock/unlock and shuffle.
> >
> > I'll update the patch.
>
> Alright, this incremental on top should do it. And full updated patch
> here:
>
> http://git.kernel.dk/cgit/linux-block/commit/?h=for-5.5/io_uring-test&id=40449c5a3d3b16796fa13e9469c69d62986e961c
>
> Let me know what you think.

Ignoring the locking elision, basically the logic is now this:

static void io_sq_wq_submit_work(struct work_struct *work)
{
        struct io_kiocb *req = container_of(work, struct io_kiocb, work);
        struct files_struct *cur_files = NULL, *old_files;
        [...]
        old_files = current->files;
        [...]
        do {
                struct sqe_submit *s = &req->submit;
                [...]
                if (cur_files)
                        /* drop cur_files reference; borrow lifetime must
                         * end before here */
                        put_files_struct(cur_files);
                /* move reference ownership to cur_files */
                cur_files = s->files;
                if (cur_files) {
                        task_lock(current);
                        /* current->files borrows reference from cur_files;
                         * existing borrow from previous loop ends here */
                        current->files = cur_files;
                        task_unlock(current);
                }

                [call __io_submit_sqe()]
                [...]
        } while (req);
        [...]
        /* existing borrow ends here */
        task_lock(current);
        current->files = old_files;
        task_unlock(current);
        if (cur_files)
                /* drop cur_files reference; borrow lifetime must
                 * end before here */
                put_files_struct(cur_files);
}

If you run two iterations of this loop, with a first element that has
a ->files pointer and a second element that doesn't, then in the
second run through the loop, the reference to the files_struct will be
dropped while current->files still points to it; current->files is
only reset after the loop has ended. If someone accesses
current->files through procfs directly after that, AFAICS you'd get a
use-after-free.
