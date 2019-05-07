Return-Path: <SRS0=61bd=TH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEC9C004C9
	for <linux-block@archiver.kernel.org>; Tue,  7 May 2019 08:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9744F20B7C
	for <linux-block@archiver.kernel.org>; Tue,  7 May 2019 08:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfEGItI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 May 2019 04:49:08 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:34011 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfEGItI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 May 2019 04:49:08 -0400
Received: by mail-wr1-f51.google.com with SMTP id f7so10789236wrq.1
        for <linux-block@vger.kernel.org>; Tue, 07 May 2019 01:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eDqWezXMALgcwT8s3H6PEODX+jJb0aIcO1v12Ssi1bc=;
        b=Jnisgqe0XH3mQgWmvjEdo2hnEPsalPAtbG4yTLxYr6IXL78by1O32FOoUr6kIqGkT4
         jJErW5zvT4+XsBxl8YmAwg09IVOihSoQuS01/ZlXsOgBKiaAq/Pb468ghA7enQ80F3ty
         gPkK8VmT2RHZQG7BQIemgnw2NhBLMi5b/3cwvSkBi2xOrN2WAOQXm7BuJCFjPYEI40e+
         vi89peUudld3wnpAJGgjAQhAA6UcAMcHeD9DpMrr++l0iKyXiDQG8Ueqo82etJulq/PA
         gb+WIljXJ8gMDP1PVBHqJARConEfYclVHC8hI/4I+cMjSDzGeRApLz80MhkoJ4rScWqD
         TNug==
X-Gm-Message-State: APjAAAWvyI0FcApZSRqd3RIRPhS0QYx/sAq8AOTbbt9CkdrZnDhactvL
        8SyzJtiqtvmNGhpw7EQNmwOk+MrU3MMiggV4WWLMng==
X-Google-Smtp-Source: APXvYqyBWsiJINBU5xtijGWkwXIOzI1HRrMl+F3lMjtbgV5GJHcWzPpfd3oGScFrpc7M708L5NaRTzNDu2iBbA77twQ=
X-Received: by 2002:adf:f108:: with SMTP id r8mr11467848wro.221.1557218946960;
 Tue, 07 May 2019 01:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <4a484c50-ef29-2db9-d581-557c2ea8f494@gmail.com> <20190507071021.wtm25mxx2as6babr@work>
In-Reply-To: <20190507071021.wtm25mxx2as6babr@work>
From:   Jan Tulak <jtulak@redhat.com>
Date:   Tue, 7 May 2019 10:48:55 +0200
Message-ID: <CACj3i71HdW0ys_YujGFJkobMmZAZtEPo7B2tgZjEY8oP_T9T6g@mail.gmail.com>
Subject: Re: Testing devices for discard support properly
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Ric Wheeler <ricwheeler@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 7, 2019 at 9:10 AM Lukas Czerner <lczerner@redhat.com> wrote:
>
> On Mon, May 06, 2019 at 04:56:44PM -0400, Ric Wheeler wrote:
> >
...
> >
> > * Whole device discard at the block level both for a device that has been
> > completely written and for one that had already been trimmed
>
> Yes, usefull. Also note that a long time ago when I've done the testing
> I noticed that after a discard request, especially after whole device
> discard, the read/write IO performance went down significanly for some
> drives. I am sure things have changed, but I think it would be
> interesting to see how does it behave now.
>
> >
> > * Discard performance at the block level for 4k discards for a device that
> > has been completely written and again the same test for a device that has
> > been completely discarded.
> >
> > * Same test for large discards - say at a megabyte and/or gigabyte size?
>
> From my testing (again it was long time ago and things probably changed
> since then) most of the drives I've seen had largely the same or similar
> timing for discard request regardless of the size (hence, the conclusion
> was the bigger the request the better). A small variation I did see
> could have been explained by kernel implementation and discard_max_bytes
> limitations as well.
>
> >
> > * Same test done at the device optimal discard chunk size and alignment
> >
> > Should the discard pattern be done with a random pattern? Or just
> > sequential?
>
> I think that all of the above will be interesting. However there are two
> sides of it. One is just pure discard performance to figure out what
> could be the expectations and the other will be "real" workload
> performance. Since from my experience discard can have an impact on
> drive IO performance beyond of what's obvious, testing mixed workload
> (IO + discard) is going to be very important as well. And that's where
> fio workloads can come in (I actually do not know if fio already
> supports this or not).
>

And:

On Tue, May 7, 2019 at 10:22 AM Nikolay Borisov <nborisov@suse.com> wrote:
> I have some vague recollection this was brought up before but how sure
> are we that when a discard request is sent down to disk and a response
> is returned the actual data has indeed been discarded. What about NCQ
> effects i.e "instant completion" while doing work in the background. Or
> ignoring the discard request altogether?


As Nikolay writes in the other thread, I too have a feeling that there
have been a discard-related discussion at LSF/MM before. And if I
remember, there were hints that the drives (sometimes) do asynchronous
trim after returning a success. Which would explain the similar time
for all sizes and IO drop after trim.

So, I think that the mixed workload (IO + discard) is a pretty
important part of the whole topic and a pure discard test doesn't
really tell us anything, at least for some drives.

Jan



-- 
Jan Tulak
