Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6209C433DF
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 22:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1B752054F
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 22:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="qnuaqcZy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731194AbgEMW07 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 18:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731084AbgEMW07 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 18:26:59 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC462C061A0E
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 15:26:58 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id x20so957317ejb.11
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 15:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5gtvWq/MeF/6oEmnw1qXQmZlv3KNk4h6BjoEUKhO/AI=;
        b=qnuaqcZyt8F/fu6JacXR348SsoSa3Tm7AzZNuvdyRoTov1keyBvQu8pXUwf75HxiOf
         Kp75KOKoGDVG9AVOlHoBHnEOZ+aGnlYmnNxamZckzNM5gr/kauOLnvq8RbJVSj57g1cw
         9NN4htlh7EN6fcqVbepwUivXJDqDlyuHYUdtHPY21wxmzjXy/ZgI5w7jQM2uM22NfFtA
         q8lS8JkKuJziplyt33amkKJeLTRetS+ezNJTjHtj9SEkChz+0OHqn2TMVceqrJ2eD/4/
         0tsEvnEt2hykkPAkDhJ48WHxBHzBhAZBdTwTt86tywE0BQeuxSyyhNQdkXE9MGPz7xQ5
         Snkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5gtvWq/MeF/6oEmnw1qXQmZlv3KNk4h6BjoEUKhO/AI=;
        b=jm0rt7o8Zwgymjm3/YieTL5DVW8YIZolcBh8OiuFGYmFNzaZ7xpKN63aMnU27mhl0M
         lod9KPftM5TtQH9Y7dBB/HcHwPeLSQsmTnvCovR5U0qC+kRjoBrdh1SNFgzr/jLWCYi+
         4savXk2mo9bEj6/lvp4ueUmnXeydpEYfNIER+VSK12vu6pSP72paC1EJGsvUZSXXNCzl
         ra2J2Zia1UdatcIcCeNh4uWElGHpAArlOVKtBrQy5SqbCOCeBt3E2wJmQ7NrN7dD4L49
         3duK0jidPRjft/JOgnll3YJDJ0oqWatFEJab09V5e/C9TPe4rDYZ2Cw/V+hbj6JaDv0s
         xzXw==
X-Gm-Message-State: AOAM530ZIO6Lr6D4UsvhgrYm2YHKojlCG3jDLL7UZ+89tL+6aq/uU/d6
        dvV8o/dmug/kjy9UBpUX8yqi4isPufW5lJE29diOkA==
X-Google-Smtp-Source: ABdhPJz1YkZyiu1OaSAVXpO2AAQnxlh/qNnka1A5+jaiVwuM2r/ADoB+8k1+qusteX+AGprilg7rK2SWSnm96LhSDK4=
X-Received: by 2002:a17:906:1f8b:: with SMTP id t11mr1180169ejr.201.1589408817417;
 Wed, 13 May 2020 15:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200508161517.252308-1-hch@lst.de> <CAPcyv4j3gVqrZWCCc2Q-6JizGAQXW0b+R1BcvWCZOvzaukGLQg@mail.gmail.com>
 <20200509082352.GB21834@lst.de> <CAPcyv4ggb7_rwzGbhHNXSHd+jjSpZC=+DMEztY6Cu8Bc=ZNzag@mail.gmail.com>
 <20200512080820.GA2336@lst.de>
In-Reply-To: <20200512080820.GA2336@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 13 May 2020 15:26:45 -0700
Message-ID: <CAPcyv4iWB=ZMmpc1aWfpJabSbCdvB28dCeSp_xj7AZMfbF_rjg@mail.gmail.com>
Subject: Re: remove a few uses of ->queuedata
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Jim Paris <jim@jtan.com>,
        Geoff Levand <geoff@infradead.org>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-m68k@lists.linux-m68k.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-bcache@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 12, 2020 at 1:08 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Sat, May 09, 2020 at 08:07:14AM -0700, Dan Williams wrote:
> > > which are all used in the I/O submission path (generic_make_request /
> > > generic_make_request_checks).  This is mostly a prep cleanup patch to
> > > also remove the pointless queue argument from ->make_request - then
> > > ->queue is an extra dereference and extra churn.
> >
> > Ah ok. If the changelogs had been filled in with something like "In
> > preparation for removing @q from make_request_fn, stop using
> > ->queuedata", I probably wouldn't have looked twice.
> >
> > For the nvdimm/ driver updates you can add:
> >
> >     Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> >
> > ...or just let me know if you want me to pick those up through the nvdimm tree.
>
> I'd love you to pick them up through the nvdimm tree.  Do you want
> to fix up the commit message yourself?

Will do, thanks.
