Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338D1C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 20:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C1320818
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 20:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oj3pVrYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbfBUUzV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Feb 2019 15:55:21 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:43255 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfBUUzV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Feb 2019 15:55:21 -0500
Received: by mail-lj1-f170.google.com with SMTP id z20so24173749ljj.10
        for <linux-block@vger.kernel.org>; Thu, 21 Feb 2019 12:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7f5dY23Ixo8KbyBp60lvy5k1KUZqwfyvQdRYk0gl/3c=;
        b=oj3pVrYieKSRR3OjLo7k1eWHeouTpvpKOqw0OSeLljrZZP55Xvc+DybADJXxPAAFba
         OQ0w0ab63OU4SSHCfcnVbSLT7e7YyHCYfulB0ETdMwwgQwG7f3BsCni5Yq/CY1xqNzV3
         KnlTmMGDel3BGE8N/akhAjQzz8YZqzOZVjaD0f/H7wAoc96xLJ7cYL53mPwbx1hlqis9
         Te6HHKQ/hXqPy8rkvA7bRdLrodPGYvE5hgnuBpbZ8/IHlM+rCNK/K35isgwT81HuN0+R
         3VagpQZnauslkbhuYkrc5yNp7kE3sQ8aA0v9369R0GCnju1Tr86Xmg2jFP9gBJM+0VkC
         GHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7f5dY23Ixo8KbyBp60lvy5k1KUZqwfyvQdRYk0gl/3c=;
        b=nSrfWgxg+Ke37oW/5g4DBvBjdswcLAiFpGP3PYdY6Zkq5s5DdXcz4a+9Ri5Iy227DI
         pCgjvnmsFwGJ66NsKr3xJ/iK8/GPG+2sgGeBeJlB8qUIGjuQUP8WRRsoFgqzSjrVYcxs
         nszfcQKVSYCTcjM1oFSyIUqj4q1PNzwAOaMS9oJVfXXkD/t44NeliH6Ac5+mZYhZ6lZZ
         pb0CvxYILUFozB/wdrsBzyLNZnzsKp9u+kplDRRiMdru/nhLG6tp3AAyT8rHnzpHG0D/
         GA3pnzuV0OPn2zYjClXqX5m0UZifmtCFSVBrDSp7G7WzHC1/ENbhnxdQb4ie4WKcC9d/
         nJRA==
X-Gm-Message-State: AHQUAub8cuZZJpgssxsFDHrHoYgcAQ4Eaqffx+TqGDCtCJnXXEKxw1m5
        tHtPM96yC9RaVimjt5Zqafo/tZVQgmySzZnNFoGHoQ==
X-Google-Smtp-Source: AHgI3Ib/+PsN9ADBnKav6S4GLxnBz4BYbX9W6uIaJxR4qDMVE8YNA7J8bZMXvVt+MRFFuUKWzTjWmMmxshYzN380nr4=
X-Received: by 2002:a2e:6a18:: with SMTP id f24mr262903ljc.97.1550782517777;
 Thu, 21 Feb 2019 12:55:17 -0800 (PST)
MIME-Version: 1.0
References: <1545261885.185366.488.camel@acm.org> <a45c9931-ce8b-0ac8-f304-412c6042eff9@kernel.dk>
 <372d2960-ff0c-1135-28f9-23eea8670463@oracle.com> <ccf50ee5-ff34-39a0-d7eb-3853fee55a4c@kernel.dk>
 <6ae35005-7ba9-91e1-f315-d128f410c12c@kernel.dk> <1545328865.185366.508.camel@acm.org>
 <bd78b521-d0d4-22ec-ff7f-2d70709ca742@kernel.dk> <b9c3bd7c-9e82-7300-d525-0bd72ed66f66@kernel.dk>
 <1545339362.185366.511.camel@acm.org> <e7d6d857-b20a-245c-c6c7-fb9b110215e9@kernel.dk>
 <1545340987.185366.515.camel@acm.org> <120bb59a-af93-7d8c-9afc-7087973632bf@kernel.dk>
 <1545341470.185366.519.camel@acm.org> <61515137-0565-e3b7-e6de-554af7d49753@kernel.dk>
 <1545342043.185366.523.camel@acm.org> <60b4819c-4c19-a4e3-41f3-e21b0544c9a4@kernel.dk>
 <68c73daa-10e7-29da-b890-bf167ec164c2@kernel.dk> <1545344398.185366.531.camel@acm.org>
 <1864f5b8-cf64-a406-a3e0-9f5124ff95b5@kernel.dk> <a04dee3c-f355-4d28-caa4-21c7265ccae4@kernel.dk>
 <5869f2ed-dc65-135f-f12f-c14a1184125e@kernel.dk> <71fb9eff-43eb-24aa-fb67-be56a3a97983@kernel.dk>
 <1550187391.31902.87.camel@acm.org> <CAE=gft5H83gC2ay63druSr4sCznrXKvKd=FCTXpx_c2F3Z+icA@mail.gmail.com>
 <1550594889.31902.126.camel@acm.org>
In-Reply-To: <1550594889.31902.126.camel@acm.org>
From:   Evan Green <evgreen@google.com>
Date:   Thu, 21 Feb 2019 12:54:41 -0800
Message-ID: <CAE=gft73F3jYwfxL3udhHFPa-12PjbH_8C1Los9x-Z56MjG=bQ@mail.gmail.com>
Subject: Re: v4.20-rc6: Sporadic use-after-free in bt_iter()
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 19, 2019 at 8:48 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Fri, 2019-02-15 at 10:29 -0800, Evan Green wrote:
> > I got all turned around while trying to understand this fix, and I'll
> > admit it's probably just me. It looks like you're trying to use an rcu
> > lock to prevent the iter functions from racing with free. Is that
> > true? But then the race at least as I understand it wasn't that there
> > was a free in-flight, it's that the free had happened a long time ago,
> > and there was still a stale value in tags->rqs[bitnr]. So maybe
> > there's some other issue that part is solving?
> >
> > And then it looks like you added a new struct where tags->rqs was so
> > that you could compare hctx->queue without reaching through rq. I have
> > no idea if that's sufficient to prevent stale accesses through rq.
> > Since you're changing multiple values I think where you populate that
> > structure you'd at least need to do something like: clear rq, barrier,
> > set hctx, barrier, set rq. But like Bart said, that's probably not the
> > right way to go.
> >
> > Finally, I didn't really get why the conditional in
> > blk_mq_rq_inflight() changed. Is that guarding against some other
> > identified problem, or just an additional check you can do when you
> > convert rqs into a struct?
> >
> > It looks like blk_mq_free_rqs() might be the magic function I was
> > looking for earlier. Would it be possible to just clear tags[rq->tag]
> > for each static_rq? Or is it possible for rqs from one set to end up
> > in the tags array of another set? (Which would make what I just
> > suggested insufficient).
>
> Hi Evan,
>
> Multiple request queues can share a single tag set. Examples of use cases
> are NVMe namespaces associated with the same NVMe controller and SCSI LUNs
> associated with the same SCSI host. The code that allocates a request not
> only marks a tag as allocated but also updates the rqs[] array in the
> tag set (see also blk_mq_get_request()). The code that iterates over a
> tag set examines both the tag bitmap and the rqs[] array. The code that
> allocates requests and the code that iterates over requests are not
> serialized against each other. That is why the association of a tag with a
> request queue can change while iterating over a tag set.
>
> Another race condition is that a request can be allocated or freed while
> iterating over a tag set.

Oh, true. The iter code was trying (unsuccessfully) to guard against
allocations with its if (rq && rq->q ...), but I hadn't thought about
in-progress frees.

>
> Fixing these race conditions would require a locking mechanism and I think
> the performance overhead of such a locking mechanism is larger than
> acceptable. So code that iterates over requests either must be able to
> handle such race conditions or must suspend request processing before it
> iterates over requests.
>
> This is why I'm in favor of only modifying blk_mq_free_rqs() such that the
> memory in which the tags are stored is delayed until a grace period has
> occurred.

This makes sense to me for the purpose of not racing with an
in-progress free. I just can't fully prove to myself that it solves
the stale tags entry, since unless we clear the entry in the tags
array it seems like there could maybe still be stale entries. Maybe
I'll get it in the next change.

Jens, keep me in the loop if you send another patch please.
-Evan
