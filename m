Return-Path: <SRS0=Jk+C=3L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0483C32771
	for <linux-block@archiver.kernel.org>; Wed, 22 Jan 2020 22:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6C424676
	for <linux-block@archiver.kernel.org>; Wed, 22 Jan 2020 22:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rubrik.com header.i=@rubrik.com header.b="BHGbEq/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgAVWO6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jan 2020 17:14:58 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41213 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgAVWO6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jan 2020 17:14:58 -0500
Received: by mail-ed1-f67.google.com with SMTP id c26so1236142eds.8
        for <linux-block@vger.kernel.org>; Wed, 22 Jan 2020 14:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ivmc17qPjTOOAuUdzhqNiqR3zEltW4LD9LqEEw1NDNw=;
        b=BHGbEq/xaTtLBIiUeon/GNcbdWlI+7FVjS/M0NfxKqobePV6XrgRZAVxC7sFgJeS+m
         8C6wFjwngO8ckFW8+WAWYmGuP5wLWoVclrtsVZQVShlYM99aeSuHeFlp8pSMXs9E4haj
         q7ga8RD9O4sdIJcomQCo0SRBDvpSN8D+Ubxvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ivmc17qPjTOOAuUdzhqNiqR3zEltW4LD9LqEEw1NDNw=;
        b=qUaUxgq7h+nBdPGiPeRhN07jGOFpeT+tXcos+9GF6WY7T15okljmj1HvMbmcoIjt/i
         AOuUMNnitPP10ZTe+VLWsidVKFDipk5ZGTiphLD+kv51rYNuOsmLtzSdK0FvbuutEZhp
         XJ81SWsD0yINLHST3fD6Gp3RabizZdnnOU5Cud0KfkShumAVslgJap14EC0rM3ehNlNk
         YVOFWevxSeqFo8VNR7XkyG3pS6qvkVhz40IbMzN6kLWkckHvXa2pQqyVTQT/iEDLvEfG
         3s+RATlfAMQ/ipUx2Pqyo8N0lMRb+/n11sXeA3K0M/b61DUqqKgWDXuIobpUuXnmck42
         Kehg==
X-Gm-Message-State: APjAAAWzUe+bdBEPn/fyAK4Ntgt1C76hPQhppTRoaF5c5Jnt43jAeXFQ
        BreIwWc9VOQQLmGa6mMnHdPJZEcmfNEbiLiPAn+/
X-Google-Smtp-Source: APXvYqxxAuRSkM5R1WZRCKGlRoM2YkP6Eh1GVm/iglEYBdOipSXefg/OrjW34vBWhT4TlVnYCqP9Qz5nPT1dU6vh8eo=
X-Received: by 2002:a17:906:8298:: with SMTP id h24mr4434543ejx.64.1579731297154;
 Wed, 22 Jan 2020 14:14:57 -0800 (PST)
MIME-Version: 1.0
References: <DM6PR04MB5754D8E261B4200AA62D442D860D0@DM6PR04MB5754.namprd04.prod.outlook.com>
 <20200121201014.52345-1-muraliraja.muniraju@rubrik.com> <19d3397e-f820-bae0-7e4f-93bafe7ce166@acm.org>
In-Reply-To: <19d3397e-f820-bae0-7e4f-93bafe7ce166@acm.org>
From:   Muraliraja Muniraju <muraliraja.muniraju@rubrik.com>
Date:   Wed, 22 Jan 2020 14:14:46 -0800
Message-ID: <CAByjrT-08OQPtf0ejsaBni6VGkSNGHmFmT_yp1_4H0oi-TBsPQ@mail.gmail.com>
Subject: Re: Re [PATCH] Adding multiple workers to the loop device.
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I see there was a submission that was done sometime ago to use
workqueues and was reverted
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e03a3d7a94e2485b6e2fa3fb630b9b3a30b65718
Hence used the approach of multiple workers this way. The current
change by default uses the default behaviour of 1 worker and one can
program the number of workers needed as a ioctl to scale as needed.

On Tue, Jan 21, 2020 at 8:01 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-01-21 12:10, muraliraja.muniraju wrote:
> > +     for (i = 0; i < lo->num_loop_workers; i++) {
> > +             kthread_init_worker(&(lo->workers[i]));
> > +             lo->worker_tasks[i] = kthread_run(
> > +                             loop_kthread_worker_fn, &(lo->workers[i]),
> > +                             "loop%d(%d)", lo->lo_number, i);
> > +             if (IS_ERR((lo->worker_tasks[i])))
> > +                     goto err;
> > +             set_user_nice(lo->worker_tasks[i], MIN_NICE);
> > +     }
>
> Unless if there is a really good reason, the workqueue mechanism should
> be used instead of creating kthreads. And again unless if there is a
> really good reason, one of the system workqueues (e.g. system_wq) should
> be used instead of creating dedicated workqueues.
>
> Bart.
