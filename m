Return-Path: <SRS0=Jk+C=3L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3DDC2D0DB
	for <linux-block@archiver.kernel.org>; Wed, 22 Jan 2020 13:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0297220678
	for <linux-block@archiver.kernel.org>; Wed, 22 Jan 2020 13:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Z6DdYqcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgAVNMb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:12:31 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:34343 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgAVNMb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jan 2020 08:12:31 -0500
Received: by mail-il1-f195.google.com with SMTP id s15so5149810iln.1
        for <linux-block@vger.kernel.org>; Wed, 22 Jan 2020 05:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uYeXMdsihSMOwiHXkfhLlg4c7EzfuiC7mnui5sXJKk0=;
        b=Z6DdYqcBuBUYQDjIrMOct7lsz84rBvUXRWdqLtrCodlo+0eBrPX8lCuNEDnCheI8OE
         n880QRXu6SHOmaI778zTUBym7BggXNwQ2oXbbZSpWThYowUQNjMoVD+tS8cPdcFoBaaj
         3HIfTiXb4fceWvlvdSHrHpMRaVGVWUwZEyK1ct3Mv917Yd44cbJyN0NTyvO3+nva1zIu
         8HYvPDGJ7BLw33A3pRc9sPUrXOjygcRAFLFp41bUfoT9Q7aMlpfx7Xu3+7LrrI1aKLqU
         e588GQsRUqjQ+tRduymqyaFHXmSR65WfIAVb87AU8D0iL9VqWMinwStBz6qDv+tcLJB2
         8+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uYeXMdsihSMOwiHXkfhLlg4c7EzfuiC7mnui5sXJKk0=;
        b=B1S3j+qcx4A5/QiNtqYJV+8JstwoG5s1XFpy8PRd1qkPVF4z8+FPJSYGchZSsgJA9i
         0OsM+AU70o14JJYRc+TtrUlxNdhpkRXgeaLAinreJtBj7Aelx7u927s0qRSjPPimd4nd
         rtKfTxrPeO4JuTWpKM1ziXwSJYilIK9Fs2kBL9/pukCsPfEaQh7LMINwJAw5dak2hv6M
         Q5x0K8HeFQBfESHPD7bHvcGSjIGxbRZZC7Sll2Fmfg+Zy9fJ9iec8lrFfkOnCZwNf4yc
         IBZuc6KIAIccVVOiClQgaYOKW4r2u1aB6zjzZLhYbqwuqJG3h70t5QKZl0TAP6xsGeGB
         ImcA==
X-Gm-Message-State: APjAAAWzYa6hlDaJLXsTRvL5zgDGIbqx27jKaCJSjcjmH4VSNtpbEC+r
        p6Qa9DrHU9duasUJDaZEc1X7lTOHrJ6c2qJ0K4YcwA==
X-Google-Smtp-Source: APXvYqx5fw2Xsj3AGQSmRszVP61ZNxriWWG6c9kYX6VETrDzQ0tPB4qXM+fnsecAYtT2MSsRderZSrJCRKz1z9yvLBo=
X-Received: by 2002:a05:6e02:4d2:: with SMTP id f18mr7650379ils.54.1579698750114;
 Wed, 22 Jan 2020 05:12:30 -0800 (PST)
MIME-Version: 1.0
References: <20200116125915.14815-1-jinpuwang@gmail.com> <20200116125915.14815-18-jinpuwang@gmail.com>
 <20200120134815.GH51881@unreal> <CAMGffEkt1v+OkWOZfFBitYpqYHxB2+RHSjZbbLBZFPSuRXPMXQ@mail.gmail.com>
 <20200122122548.GB7018@unreal>
In-Reply-To: <20200122122548.GB7018@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 22 Jan 2020 14:12:19 +0100
Message-ID: <CAMGffEmpRvruSn6iz6EfgfAjE9xrnsihwPaQU8Ft9e7qLD5avw@mail.gmail.com>
Subject: Re: [PATCH v7 17/25] block/rnbd: client: main functionality
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 22, 2020 at 1:25 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Wed, Jan 22, 2020 at 12:22:43PM +0100, Jinpu Wang wrote:
> > > > +/**
> > > > + * rnbd_get_cpu_qlist() - finds a list with HW queues to be rerun
> > > > + * @sess:    Session to find a queue for
> > > > + * @cpu:     Cpu to start the search from
> > > > + *
> > > > + * Description:
> > > > + *     Each CPU has a list of HW queues, which needs to be rerun.  If a list
> > > > + *     is not empty - it is marked with a bit.  This function finds first
> > > > + *     set bit in a bitmap and returns corresponding CPU list.
> > > > + */
> > > > +static struct rnbd_cpu_qlist *
> > > > +rnbd_get_cpu_qlist(struct rnbd_clt_session *sess, int cpu)
> > > > +{
> > > > +     int bit;
> > > > +
> > > > +     /* First half */
> > > > +     bit = find_next_bit(sess->cpu_queues_bm, nr_cpu_ids, cpu);
> > >
> > > Is it protected by any lock?
> > We hold requeue_lock when set/clear bit, and disable preemption via
> > get_cpu_ptr when find_next_bit.
> > even it fails to get latest bit, it just cause an rerun the queue.
>
> It is not clear here at all.
>
> > >
> > > > +     if (bit < nr_cpu_ids) {
> > > > +             return per_cpu_ptr(sess->cpu_queues, bit);
> > > > +     } else if (cpu != 0) {
> > > > +             /* Second half */
> > > > +             bit = find_next_bit(sess->cpu_queues_bm, cpu, 0);
> > > > +             if (bit < cpu)
> > > > +                     return per_cpu_ptr(sess->cpu_queues, bit);
> > > > +     }
> > > > +
> > > > +     return NULL;
> > > > +}
> > > > +
> > > > +static inline int nxt_cpu(int cpu)
> > > > +{
> > > > +     return (cpu + 1) % nr_cpu_ids;
> > > > +}
> > > > +
> > > > +/**
> > > > + * rnbd_rerun_if_needed() - rerun next queue marked as stopped
> > > > + * @sess:    Session to rerun a queue on
> > > > + *
> > > > + * Description:
> > > > + *     Each CPU has it's own list of HW queues, which should be rerun.
> > > > + *     Function finds such list with HW queues, takes a list lock, picks up
> > > > + *     the first HW queue out of the list and requeues it.
> > > > + *
> > > > + * Return:
> > > > + *     True if the queue was requeued, false otherwise.
> > > > + *
> > > > + * Context:
> > > > + *     Does not matter.
> > > > + */
> > > > +static inline bool rnbd_rerun_if_needed(struct rnbd_clt_session *sess)
> > >
> > > No inline function in C files.
> > First time saw such request, there are so many inline functions in C
>
> 15) The inline disease
> https://elixir.bootlin.com/linux/latest/source/Documentation/process/coding-style.rst#L882
ok, will review the inline usage, and drop some.
>
> > files across the tree
> > grep inline drivers/infiniband/core/*.c
> > drivers/infiniband/core/addr.c:static inline bool
> > ib_nl_is_good_ip_resp(const struct nlmsghdr *nlh)
> > drivers/infiniband/core/cma.c:static inline u8 cma_get_ip_ver(const
> > struct cma_hdr *hdr)
> > drivers/infiniband/core/cma.c:static inline void cma_set_ip_ver(struct
> > cma_hdr *hdr, u8 ip_ver)
> > drivers/infiniband/core/cma.c:static inline void release_mc(struct kref *kref)
> > drivers/infiniband/core/cma.c:static inline struct sockaddr
> > *cma_src_addr(struct rdma_id_private *id_priv)
> > drivers/infiniband/core/cma.c:static inline struct sockaddr
> > *cma_dst_addr(struct rdma_id_private *id_priv)
> >
> > >
> > > > +{
> > > > +     struct rnbd_queue *q = NULL;
> > > > +     struct rnbd_cpu_qlist *cpu_q;
> > > > +     unsigned long flags;
> > > > +     int *cpup;
> > > > +
> > > > +     /*
> > > > +      * To keep fairness and not to let other queues starve we always
> > > > +      * try to wake up someone else in round-robin manner.  That of course
> > > > +      * increases latency but queues always have a chance to be executed.
> > > > +      */
> > > > +     cpup = get_cpu_ptr(sess->cpu_rr);
> > > > +     for (cpu_q = rnbd_get_cpu_qlist(sess, nxt_cpu(*cpup)); cpu_q;
> > > > +          cpu_q = rnbd_get_cpu_qlist(sess, nxt_cpu(cpu_q->cpu))) {
> > > > +             if (!spin_trylock_irqsave(&cpu_q->requeue_lock, flags))
> > > > +                     continue;
> > > > +             if (likely(test_bit(cpu_q->cpu, sess->cpu_queues_bm))) {
> > >
> > > Success oriented approach please.
> > sorry, I don't quite get your point.
>
> The flows are better to be written:
> if (err)
>   return or conitnue
> <...>
> do_something
>
> in your case
> if (!test_bit(...))
>  continue;
> do_work_here.
In our case,
 if we failed to get requeue_lock, we continue to next cpu_q and do the work
I guess you miss read the code.

Thanks
