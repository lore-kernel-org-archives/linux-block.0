Return-Path: <SRS0=EH6z=5C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E4CC18E5B
	for <linux-block@archiver.kernel.org>; Tue, 17 Mar 2020 06:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E15220724
	for <linux-block@archiver.kernel.org>; Tue, 17 Mar 2020 06:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="N+hu/2zA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgCQGqe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Mar 2020 02:46:34 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33641 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgCQGqe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Mar 2020 02:46:34 -0400
Received: by mail-io1-f65.google.com with SMTP id o127so7370413iof.0
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2020 23:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UYc3TqkNGARcihTDAYzSKGoHrmWkzfgJOC6Y58NUrpc=;
        b=N+hu/2zAKNgKvmerOz044tLkpjMolltoWQlN7wOIPUYjGuDpB5wZNhgSS34hHEqQWv
         oHnJc09wpl2ccm0KIofGOc3rbcYWr8pUSU/rVKMARhEFFCsboZvv1gNS3GQlLZkjv8Bt
         FomJpxoG8wKb4ZG7QY6EmDqRO0D6zBpEatNNgftHQYt2Z4o/p/fJBle1KDU0DpkOwJRs
         w9mETcZR3+rNS9mqFaQ7IWi6QmfdVynEGyLBoe5bR4wzpp/+3EYetYvxBmnhun+gV9Ar
         YYsBS7zk0uB95OIrd6dYAa6ZDBZmvhRmhVrXuJtugOSpu75Ojxdf9SY/bPb+ga1snsNa
         kqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UYc3TqkNGARcihTDAYzSKGoHrmWkzfgJOC6Y58NUrpc=;
        b=DpMrdV6MLHOKBTQTqoH5SJSdQG9n2lBN1SoS5ZdnMZ/IHZN+3hrNvh+gUgLwESAIfH
         SFZXcFvat0z28l9N3bfIzV7uAn1tQFpJiFPmh7cZAfR6p99V4+vfew1r5GZd1eUWpTT2
         X/mwHbuID59QvITDqiNUyyY+cIsz3/Xyik+IRcbDrlBfPCP0ix2VCowCRXnIO3xjdCpk
         n8kKWEEXBOZQz5yYfJA6MoBe44Awy/KzawEvVP+soNt5pIZOkIpxGAPwPgUi5nDi1+qs
         5rqRUsKhQXYJv4jxqKvZmj7ZvdZbXUkR1KdUtvNV5iOpRb4KF0Iki1AFKv4va4RoXc3s
         KgfQ==
X-Gm-Message-State: ANhLgQ0Lw9NdtsHC2YM2x7iq3/f92Tm7vCf3UVQyRfRACbOk/GO7XIEo
        CWPyv1UYC7xA7jRevcXSVvArh3Q4ZT2SgDffy7Cx
X-Google-Smtp-Source: ADFU+vvrJkz+Uz4cFJ9sI2/Gf19IjPXpR5Pn4uoVRuBjMcCgfYfd7klv6NKwh0+PSO2J6OC1zGbD+2wDtzpuvOM3OcI=
X-Received: by 2002:a02:cb8b:: with SMTP id u11mr3609156jap.57.1584427593155;
 Mon, 16 Mar 2020 23:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
 <20200311161240.30190-7-jinpu.wang@cloud.ionos.com> <20200311190156.GH31668@ziepe.ca>
 <CAHg0HuziyOuUZ48Rp5S_-A9osB==UFOTfWH0+35omiqVjogqww@mail.gmail.com>
 <20200312172517.GU31668@ziepe.ca> <CAHg0HuxmjWu2V6gN=OTsv3v6aYxDkQN=z4F4gMYAu5Wwvp1qGg@mail.gmail.com>
 <20200313122546.GC31668@ziepe.ca>
In-Reply-To: <20200313122546.GC31668@ziepe.ca>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Tue, 17 Mar 2020 07:46:16 +0100
Message-ID: <CAHg0Huy1UUduAGX8Qq0QG-+WkR8suAP9n2wiQUwK=dq3F0ZrOw@mail.gmail.com>
Subject: Re: [PATCH v10 06/26] RDMA/rtrs: client: main functionality
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 13, 2020 at 1:25 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Fri, Mar 13, 2020 at 01:18:23PM +0100, Danil Kipnis wrote:
> > > > > calling rcu list iteration without holding rcu_lock is wrong
> > > > This function (add_path) along with the corresponding
> > > > remove_path_from_arr() are the only functions modifying the
> > > > paths_list. In both functions paths_mutex is taken so that they are
> > > > serialized. Since the modification of the paths_list is protected by
> > > > the mutex, the rcu_read_lock is superfluous here.
> > >
> > > Then don't use the _rcu functions.
> > We need to traverse rcu list in the update-side of the code. According
> > to the whatisRCU.rst "if list_for_each_entry_rcu() instance might be
> > used by update-side code...then an additional lockdep expression can
> > be added to its list of arguments..." The would be our case since we
> > always hold a lock when doing this, but I don't see a corresponding
> > API. We can just surround the statement with
> > rcu_readlock/rcu_readunlock to avoid the warning.
>
> The only case where you can avoid RCU is if the code is already
> holding a lock preventing writes to the list, in which case you use
> the normal list iterator.
>
> > > > > > +     /*
> > > > > > +      * @pcpu paths can still point to the path which is going to be
> > > > > > +      * removed, so change the pointer manually.
> > > > > > +      */
> > > > > > +     for_each_possible_cpu(cpu) {
> > > > > > +             struct rtrs_clt_sess __rcu **ppcpu_path;
> > > > > > +
> > > > > > +             ppcpu_path = per_cpu_ptr(clt->pcpu_path, cpu);
> > > > > > +             if (rcu_dereference(*ppcpu_path) != sess)
> > > > >
> > > > > calling rcu_dereference without holding rcu_lock is wrong.
> > > > We only need a READ_ONCE semantic here. ppcpu_path is pointing to the
> > > > last path used for an IO and is used for the round robin multipath
> > > > policy. I guess the call can be changed to rcu_dereference_raw to
> > > > avoid rcu_lockdep warning. The round-robin algorithm has been reviewed
> > > > by Paul E. McKenney, he wrote a litmus test for it:
> > > > https://lkml.org/lkml/2018/5/28/2080.
> > >
> > > You can't call rcu expecting functions without holding the rcu lock -
> > > use READ_ONCE/etc if that is what is really going on
>
> > Look's people are using rcu_dereference_protected when dereferencing
> > rcu pointer in update-side and have an explicit lock to protect it, as
> > we do. Will dig into it next week.
>
> Yes, that is right too
>
> > > > > > +static void rtrs_clt_add_path_to_arr(struct rtrs_clt_sess *sess,
> > > > > > +                                   struct rtrs_addr *addr)
> > > > > > +{
> > > > > > +     struct rtrs_clt *clt = sess->clt;
> > > > > > +
> > > > > > +     mutex_lock(&clt->paths_mutex);
> > > > > > +     clt->paths_num++;
> > > > > > +
> > > > > > +     /*
> > > > > > +      * Firstly increase paths_num, wait for GP and then
> > > > > > +      * add path to the list.  Why?  Since we add path with
> > > > > > +      * !CONNECTED state explanation is similar to what has
> > > > > > +      * been written in rtrs_clt_remove_path_from_arr().
> > > > > > +      */
> > > > > > +     synchronize_rcu();
> > > > >
> > > > > This makes no sense to me. RCU readers cannot observe the element in
> > > > > the list without also observing paths_num++
> > > > Paths_num is only used to make sure a reader doesn't look for a
> > > > CONNECTED path in the list for ever - instead he makes at most
> > > > paths_num attempts. The reader can in fact observe paths_num++ without
> > > > observing new element in the paths_list, but this is OK. When adding a
> > > > new path we first increase the paths_num and them add the element to
> > > > the list to make sure the reader will also iterate over it. When
> > > > removing the path - the logic is opposite: we first remove element
> > > > from the list and only then decrement the paths_num.
> > >
> > > I don't understand how this explains why synchronize_rcu would be need
> > > here.
> > It is needed here so that readers who read the old (smaller) value of
> > paths_num and are iterating over the list of paths will have a chance
> > to reach the new path we are about to insert. Basically it is here to
> > be symmetrical with the removal procedure: remove path,
> > syncronize_rcu, path_num--.
>
> How do readers see the paths_num before it is inserted into the list?
We increase paths_num and insert element into the list while holding
paths_mutex. The readers only do rcu_readlock and rcu_readunlock when
iterating over the list, they do not take the paths_mutex, so there is
a window where they can see the increased paths_num, but the element
isn't yet in the list...

>
> Jason
