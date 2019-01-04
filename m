Return-Path: <SRS0=wxXg=PM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2833AC43387
	for <linux-block@archiver.kernel.org>; Fri,  4 Jan 2019 21:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F110D2087F
	for <linux-block@archiver.kernel.org>; Fri,  4 Jan 2019 21:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfADVIF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Jan 2019 16:08:05 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35564 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbfADVIF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Jan 2019 16:08:05 -0500
Received: by mail-ot1-f66.google.com with SMTP id 81so33190693otj.2
        for <linux-block@vger.kernel.org>; Fri, 04 Jan 2019 13:08:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bf0tjBogKC3N+i5mJerhy334QANhHpEOC3Ft77hcXII=;
        b=ZQodKwtxJdxWfgL86l9pJDmuAU4y8zsJAZ6M4cW120L2KXf+2uuQqGyoGGJ9nfRopX
         uTPs7IFOra8X5ZpTrXmRdsog93+tiMWunlTYl8w2C5v9Ytk1f8ypTp1u9rGsrlEoA24L
         /BwSXme2EQYBOkC5mioLy1Oaa7qQpznlPPiLodEKvdPcN8bzFdijEc6544c5RuwdKWi/
         meRipsBc13nK5RYzMeoduYB6IXn4IYrBkOsrwbopr3H3XjgY7nN5dhCWpdhLEnP8sSes
         iW4pVUTqjwW9qJ1RcIauMbD7BCG7OZx2MxVLm7HDgUwbFGeaI1Ew/B6mzB/lKxdYweVr
         gIkw==
X-Gm-Message-State: AJcUukf63HWwklL8zS44d4lmsknQbg+MPaczAeuj7XQ1SEI/fbvgakZV
        yN7xPDZK7yBxWsJ12pIoDgnLwpDoH+LidEz01aGrEw==
X-Google-Smtp-Source: ALg8bN7cI0eQSAPEAgyqDCtGCeCIW0NZuOIywY6W5QHznbcAXTJGrSWKi2BjGec28TrHDGFE2Pmp5mfecJf15wN0Ae0=
X-Received: by 2002:a9d:728a:: with SMTP id t10mr33963606otj.216.1546636084473;
 Fri, 04 Jan 2019 13:08:04 -0800 (PST)
MIME-Version: 1.0
References: <20190104154243.3538-1-jpittman@redhat.com> <1546620417.163063.45.camel@acm.org>
 <CA+RJvhyfKrLwFkxAOxqAW=Mthu5HaF_JU6_rgKLjL07uD8TM+g@mail.gmail.com> <1546634973.83374.4.camel@acm.org>
In-Reply-To: <1546634973.83374.4.camel@acm.org>
From:   John Pittman <jpittman@redhat.com>
Date:   Fri, 4 Jan 2019 16:07:53 -0500
Message-ID: <CA+RJvhwjxL2rCgsUYQzU9FtTUsCL2Q-QbubFJr6YGOVBrbPxAQ@mail.gmail.com>
Subject: Re: [PATCH] null_blk: add zoned config support information
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks Bart, I appreciate it.

On Fri, Jan 4, 2019 at 3:49 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Fri, 2019-01-04 at 15:37 -0500, John Pittman wrote:
> > Thanks Bart; I made the changes and sent them in as a v2, I'm sure you
> > already saw.  I have a quick, unrelated question if you have a moment.
> > In testing the null_blk driver, I found that trim commands sent by fio
> > were rejected due to lack of support.  Tracking down Shaohua's commit
> > 306eb6b4a ("nullb: support discard"), he mentions that "discard makes
> > sense for memory backed disk".  Just to see what would happen, I
> > edited the source to make discard a configurable parameter at
> > modprobe, and after the edit & build, the trim commands submitted
> > fine.  Does this sort of change make sense?  I mean the ability to do
> > discard to null_blk without it being memory backed;  solely for
> > testing/benchmarking purposes.  I haven't found any good instructions
> > on creating a memory backed or discard enabled null_blk device from
> > the command line, so I assume a higher level driver would have to hook
> > in and enable these features manually.  Thanks for your time and any
> > information.
>
> Hi John,
>
> Jens as the block layer maintainer has the last word about this. Personally
> I would welcome that functionality. Before discard functionality was removed
> from the brd driver I used the brd driver to test the discard functionality
> in storage target stacks. If discard functionality would be added to the
> null_blk driver then that would make it possible to use that driver for
> testing the discard functionality in e.g. LIO. See also commit f09a06a193d9
> ("brd: remove discard support").
>
> I'm not sure that we need a modprobe parameter to enable or disable trim
> functionality in the null_blk driver. I'm fine with always enabling trim
> functionality in that driver.
>
> Bart.
