Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19682CA90AF
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 13:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 504E62054F
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 13:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="lT1SmIiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388131AbgEMNtO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 09:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387795AbgEMNtN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 09:49:13 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F3EC061A0C
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 06:49:13 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id v5so9593975lfp.13
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 06:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dNRjVusiQR0m8ObDJasAniiwjGsfLhZSJItKMA1wtWo=;
        b=lT1SmIiRfh/M7ufVVskYrskIw70xhs5ozf7aqW6I4XdUc2PF1Jfz/VnN3U2OKlbGBG
         uiXpMTyWTP27DCO+LF1v62OO+ez/U6NV5GJprTm6JwGPDdNwG2CANtbfESjurw1ac3dp
         3hQfHFrOjudX9KR106oYVr03N1k1UExGO53F/trhMW44w96UX5G4tatRvsrb5vdoQtmR
         ENFNdIsBzh7h45NU8oIUDGcgi3AAeLEYO+y6YbDX1ZFg7GzXh7SAhBr+F4Jt0TpkF5uk
         27RjNLz5tqFbfZClHdhCBvxWmN/hHf8S6HzYNfMtZN0keetxTPxwoCmYFzZ7IuNMSJ1w
         lU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNRjVusiQR0m8ObDJasAniiwjGsfLhZSJItKMA1wtWo=;
        b=mxaCB2LBZeUXLHCdjOXniGkpDwqE4Kk0vLbQq2tSCMVpIFHFRSK7Du1ErOgrqS8+uW
         qBF6nzpEQH5749lV+E3wxNQZOXIIX+q+JPHd6oMQn3swThggKxPb2ezI6/v2VwzHenbc
         9/Xfjtt+mqPO6Gic2no8wqrpV999Tm2Oyv+k6yaCtOLlRTFqZNfXUECzTo7yGnXWReqm
         EzTOBWmAvynRuEW18K3YL8qPW6VWb5Nb9gbFLdP1xq6BZLwZjs8zaK/CoQ+ZyXrZuF/Z
         eeHMIQqGr5dhoHLriFjqD+x6bLyx+H92wgqdttX38d8Hs2kDSNuwCH7Ub+l6sZToxz4r
         SyEw==
X-Gm-Message-State: AOAM5316weieHrp6rtffvFWlN+hOfXRlX10saZ4yNo02rgzgpDdOFdo2
        1XzLysdRG6FhCFoCmrh3SVra/iUvurUPyiY1pG3Xwg==
X-Google-Smtp-Source: ABdhPJxDIlOiKQEjNVjIYYuRWZVqAtm0VIiXHSumjO4vIkHQpJkCx+MCtUc4lBL6USUR7ZeCUOs5rEQuTMiJ2UuvZcE=
X-Received: by 2002:a19:7104:: with SMTP id m4mr14624165lfc.75.1589377751720;
 Wed, 13 May 2020 06:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200429140341.13294-1-maco@android.com> <20200429140341.13294-11-maco@android.com>
 <CAB0TPYHwor85-fWKu+OMT-1ys2L7OSqVoReJRzNOMAE0xK+yzg@mail.gmail.com>
 <1f3064a9-105f-02bb-6a1a-eb9875d292e3@kernel.dk> <4416f60a-6050-5067-6881-0ee9ef944669@kernel.dk>
 <CAB0TPYHikHc3tTTQcUOOZsYZmqNxGtthpkPX_z6dKgy+V8kovg@mail.gmail.com> <20200513102256.GA2087@lst.de>
In-Reply-To: <20200513102256.GA2087@lst.de>
From:   Martijn Coenen <maco@android.com>
Date:   Wed, 13 May 2020 15:49:00 +0200
Message-ID: <CAB0TPYHBJTykz-x1nHPYK+ELzOhFu-7RgvKbdorqfbqmGcFqgA@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] loop: Add LOOP_CONFIGURE ioctl
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Narayan Kamath <narayan@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, kernel-team@android.com,
        Martijn Coenen <maco@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 13, 2020 at 12:22 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, May 13, 2020 at 09:07:43AM +0200, Martijn Coenen wrote:
> > On Wed, May 13, 2020 at 4:30 AM Jens Axboe <axboe@kernel.dk> wrote:
> > > > Looks acceptable to me, but I'm getting a failure applying it to
> > > > for-5.8/drivers on this patch:
> > > >
> > > > Applying: loop: Refactor loop_set_status() size calculation
> > > >
> > > > So you'll probably want to respin on the right branch.
> >
> > This series depends on a separate bugfix I sent to LKML earlier - see
> > https://lkml.org/lkml/2020/3/31/755 . I mentioned it in [00/10] of
> > this series, but perhaps I should have just included that patch.
> >
> > I just verified that patch + this series still applies cleanly on your
> > for-5.8/drivers tree, but if you prefer I send a v5 with that patch
> > going first let me know.
>
> You probably want to resend with the fix includes as the first patch.
> And drop the truncation check now that we figured out that we don't
> actually need it.

Just sent v5, thanks!

Martijn
