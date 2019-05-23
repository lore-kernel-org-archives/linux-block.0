Return-Path: <SRS0=5kok=TX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1609C04AAC
	for <linux-block@archiver.kernel.org>; Thu, 23 May 2019 03:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686132089E
	for <linux-block@archiver.kernel.org>; Thu, 23 May 2019 03:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsZCituC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfEWDsS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 May 2019 23:48:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35015 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfEWDsS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 May 2019 23:48:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id m3so4531770wrv.2
        for <linux-block@vger.kernel.org>; Wed, 22 May 2019 20:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9qtPMnAUUVQgci1L2Z8R7wqj8qtMP67aZO3w68PXuYY=;
        b=UsZCituCCHizoLhMBuwTw58FdovqthjyHeFfbnaIAEHePM4xiV8iXQNxUZtDW36tkv
         xt931Fl1AVRkShYYVP2qa7mkfUW9jrDALhABWXc8ECk1ql6cBmn4FdsL4LGSo6Q078T7
         2o3/Y8QCO2nUUZZiL7oyasPxE5pN3zzXTTGScIUCXVYQlEdZWKXBqKe+5t3ZpJsRtzQQ
         SfnnklJ9btAMgwEjKK9zqJOfk2pVtEmKjfdpxofwcX/X3VC6BsMYhDQIvLlLh72Gbcj1
         fWhUgH0zQ52p0erv2AJTWrRuBpXP9Isz+b+bCHrh83vszdxPdFAl0js0XfZpDnD9sMMx
         gszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9qtPMnAUUVQgci1L2Z8R7wqj8qtMP67aZO3w68PXuYY=;
        b=ji6Qr3daYua50UWltuSi0rPG07elh4zSq+zS6D6XgoeCGQhAFDr9ujq5RcP/WFmKZ+
         poIr6xJ2fUad4c9ZOy0zKBlcr3XX3Ivsvjhkpj9O9I4IYkXCn9uZEfr6d1wDefqbpF83
         OtMtHzYAHP/0AG3F0y7qskHUKXvkqJ4pjq8UMrr+tu/duHgRYfJpxt1Wj9SvsND6ZbBU
         ZJLN6lee/ZGgfihnRjZdW+6VQ2ZQtZ8zRH10bfoX/nSxYMMxYk/qgTHF9QNIlc1hK6K9
         wNR9qrjO2is3eYh8DXDXzkxc3Zk/3mezyZ9YpXJ9g2idy8wPhiVX61GeBPx/uX6uTqJz
         r5ng==
X-Gm-Message-State: APjAAAWrw//RuI/pn/aWomX6hSwd9FyoG+BUiWe6lBHca45tUlbhryu/
        yG2Q31SVZYmJhYQ3Ukb408CDU7inKIGRpBIz7ew=
X-Google-Smtp-Source: APXvYqxAZkETQPBeg5GixiQ49yu9hFZ7S87hWBAUJuAEc7NyD6irLPboiv//euadZDuGYTlhkwKP+LNiYfkH2qiwN3g=
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr57456214wrk.293.1558583297037;
 Wed, 22 May 2019 20:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190522174812.5597-1-keith.busch@intel.com> <20190523032925.GA10601@ming.t460p>
In-Reply-To: <20190523032925.GA10601@ming.t460p>
From:   Keith Busch <keith.busch@gmail.com>
Date:   Wed, 22 May 2019 21:48:10 -0600
Message-ID: <CAOSXXT45jyLrKZ56QOPGWFyajtSvgPQcT+f2nj95n9Eowb44FA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Reset timeout for paused hardware
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-nvme <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 22, 2019, 9:29 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Wed, May 22, 2019 at 11:48:10AM -0600, Keith Busch wrote:
> > Hardware may temporarily stop processing commands that have
> > been dispatched to it while activating new firmware. Some target
> > implementation's paused state time exceeds the default request expiry,
> > so any request dispatched before the driver could quiesce for the
> > hardware's paused state will time out, and handling this may interrupt
> > the firmware activation.
> >
> > This two-part series provides a way for drivers to reset dispatched
> > requests' timeout deadline, then uses this new mechanism from the nvme
> > driver's fw activation work.
>
> Just wondering why not freeze IO queues before updating FW?


Yeah, that's a good question. A FW update may have been initiated out
of band or from another host entirely. The driver can't count on
preparing for hardware pausing command processing before it's
happened, but we'll always find out asynchronously after it's too late
to freeze.
