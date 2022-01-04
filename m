Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2404C433F5
	for <linux-block@archiver.kernel.org>; Tue,  4 Jan 2022 18:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbiADSGg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jan 2022 13:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236097AbiADSGf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jan 2022 13:06:35 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8384CC061785
        for <linux-block@vger.kernel.org>; Tue,  4 Jan 2022 10:06:35 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id j17so34963911qtx.2
        for <linux-block@vger.kernel.org>; Tue, 04 Jan 2022 10:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5RKu6IuIqmq49BMD5LnbgPbbKed9H3mhBHP0VD+Ye6c=;
        b=bH4v26yxUQjm4cWLarxsSFK/FSUA8Cq83MSbqyvKKF+U9ssGI1t2wukWVezRWXF+k8
         bA6zREUN7SV3pUebV8HpwG1hWpByR6BmTqOwgbDXiazflHJR0u9dMDlZjSTgpG5OK8MG
         +P42EAdzFtNxR1Tw94FqApCZKqC6Kmf1y9wCb5QB7rWK/tNmv5EiAIOeqHmDQqeqbyBy
         Oq4+Wn8Bg0by3/GBN5H8PhT13vghmvuEQtXWgCnpIUl7xo/u1dukfdhUwZl0pSiDKMky
         FNiQPKrZhCODpn9HBG/6lAvePDaU90LwfqeSEBH9HFWV8CLUuc3klImHvvp+tj3WC1Ar
         0OMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5RKu6IuIqmq49BMD5LnbgPbbKed9H3mhBHP0VD+Ye6c=;
        b=4Q/rlkrTQr+XlJlmd+BVySaOv5FD7LL/6UddtmdvdtsC/pufeMcGvrd+jeyT/VecL2
         46QGfBMIHAHMkTDUnBXj6IrtYxpxtOmX1XpJKSmTqvpagojgfcS4uNJDbNKa2HwKL7ys
         iuauiRcSJveRoVrM9FFzF9u7y9oYNdIuwQwqyKAzc7LmCv26PRfuqwvGXnXMoHXwAvkz
         C3yxPl+nXJDJxtqmMrmBAskzAmKPWQ2bM7noLykqhOAu7b8kKuKjFpfwqC20UeWT8H6A
         f8bD6C0pyTicCyZ/HlAIdgKW0AF+srbFuz9yxGhB9CZstxItl1jMQnJtGxJ9DTiLAMfB
         5frg==
X-Gm-Message-State: AOAM531OXahdYZvb1YN/wwtWqX4ZOBlcBddKrl9iR7n+2Jqi8MTtRcwj
        QnsOJoxZGh9FmOYydHOJ2q6BOQ==
X-Google-Smtp-Source: ABdhPJzqTxALsN0VOvXgTQUjtVYXWrX+86Lp+vIhivpHeE975eTN2g/Nkq+f9gnjkysW6xhZ9C+Bzg==
X-Received: by 2002:ac8:674d:: with SMTP id n13mr44576838qtp.491.1641319594564;
        Tue, 04 Jan 2022 10:06:34 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i6sm3044186qtx.22.2022.01.04.10.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 10:06:33 -0800 (PST)
Date:   Tue, 4 Jan 2022 13:06:32 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nbd: Don't use workqueue to handle recv work
Message-ID: <YdSMqKXv0PUkAwfl@localhost.localdomain>
References: <20211227091241.103-1-xieyongji@bytedance.com>
 <Ycycda8w/zHWGw9c@infradead.org>
 <CACycT3usfTdzmK=gOsBf3=-0e8HZ3_0ZiBJqkWb_r7nki7xzYA@mail.gmail.com>
 <YdMgCS1RMcb5V2RJ@localhost.localdomain>
 <CACycT3vYt0XNV2GdjKjDS1iyWieY_OV4h=W1qqk_AAAahRZowA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACycT3vYt0XNV2GdjKjDS1iyWieY_OV4h=W1qqk_AAAahRZowA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 04, 2022 at 01:31:47PM +0800, Yongji Xie wrote:
> On Tue, Jan 4, 2022 at 12:10 AM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Thu, Dec 30, 2021 at 12:01:23PM +0800, Yongji Xie wrote:
> > > On Thu, Dec 30, 2021 at 1:35 AM Christoph Hellwig <hch@infradead.org> wrote:
> > > >
> > > > On Mon, Dec 27, 2021 at 05:12:41PM +0800, Xie Yongji wrote:
> > > > > The rescuer thread might take over the works queued on
> > > > > the workqueue when the worker thread creation timed out.
> > > > > If this happens, we have no chance to create multiple
> > > > > recv threads which causes I/O hung on this nbd device.
> > > >
> > > > If a workqueue is used there aren't really 'receive threads'.
> > > > What is the deadlock here?
> > >
> > > We might have multiple recv works, and those recv works won't quit
> > > unless the socket is closed. If the rescuer thread takes over those
> > > works, only the first recv work can run. The I/O needed to be handled
> > > in other recv works would be hung since no thread can handle them.
> > >
> >
> > I'm not following this explanation.  What is the rescuer thread you're talking
> 
> https://www.kernel.org/doc/html/latest/core-api/workqueue.html#c.rescuer_thread
> 

Ahhh ok now I see, thanks, I didn't know this is how this worked.

So what happens is we do the queue_work(), this needs to do a GFP_KERNEL
allocation internally, we are unable to satisfy this, and thus the work gets
pushed onto the rescuer thread.

Then the rescuer thread can't be used in the future because it's doing this long
running thing.

I think the correct thing to do here is simply drop the WQ_MEM_RECLAIM bit.  It
makes sense for workqueue's that are handling the work of short lived works that
are in the memory reclaim path.  That's not what these workers are doing, yes
they are in the reclaim path, but they run the entire time the device is up.
The actual work happens as they process incoming requests.  AFAICT
WQ_MEM_RECLAIM doesn't affect the actual allocations that the worker thread
needs to do, which is what I think the intention was in using WQ_MEM_RECLAIM,
which isn't really what it's used for.

tl;dr, just remove thee WQ_MEM_RECLAIM flag completely and I think that's good
enough?  Thanks,

Josef
