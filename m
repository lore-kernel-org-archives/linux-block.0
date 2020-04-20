Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DF8C3815B
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 07:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFE6F21473
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 07:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="W+Lw7ol4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgDTHCW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 03:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726067AbgDTHCV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 03:02:21 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1E8C061A0F
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 00:02:20 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id b12so9752856ion.8
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 00:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4A6SxKXFQeFuhZ520Fb1Z9inEFcHWLahAvurgebovF0=;
        b=W+Lw7ol4m5Pp+NIVMJifky+1tJ056gHvBlIzI1UvOcpw8Yumgvyzcvn6nFcbX0LEER
         4fMjbfmI0ptIQDXcBAidLHxY/aCtNggnRh1S3f8/eaaiwmRPXSRuCF/WuC30kAh4UArN
         GSZNpwkC6Zu3V/30Uf7BbKw0qTpeG7BiIAvAZh+LxwJoRTwZ9VsHMo8s5KuXga8TCSAC
         V6S88oFbwUBYh78lEXHzKwrbXir6I4IknN+5PaLhE37DKBv3LC+eQB9c8QCFLcQ2tSRq
         r4WB9ULhz/OUJCfP7bT+4cskcnxNlWXGGo+9tymT11QVCQxs559aGPCS2Js99DEqbPRR
         DN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4A6SxKXFQeFuhZ520Fb1Z9inEFcHWLahAvurgebovF0=;
        b=MQ6e+XbzXq7JiAdVTaTWoZUZDU/lZC46M2yltxR3EZONj/vTMTGjEhz2fSX+m59O/Q
         sf17lh9w3CC81XF0RT+bnpzPgXP/1h/f4ipHgjOO7o5IxkUMtdaJ/ulxqkOGY4z9MvjI
         oWOWYZbTLyK8xnjL9iooSUxb72Wtg6qbORScCE03waaANZ2Or9ViN5ojH9oyST6ZVQBO
         iQI7YR51KqJhuMxjcw7SrQy0kq6eA/ULK5woZrs1ycGzqr9aoq6MAm6p1k0Enu56aLKV
         ukkbg88Dg4XU3vhzWosrjPFo/AUywbwzmEvCjDPQITcAWJitm48KFkW/v74E4zqBwAZn
         oQjQ==
X-Gm-Message-State: AGi0PubNxAoEBrzsGpW3ZL0GL7JXhnirgU+toEba8hNbySAfmcWMBDGm
        tNSqvL7jjU9mhGH1WQDgNVn1fE4434daAipvTG0vJw==
X-Google-Smtp-Source: APiQypL3kqmc36Z8nDaWOeggnqdyC0h9bl6lWidbucVAtp/7nrpTjRikTAly3Zvg8/ynoYSstspKecnSjdnY+aEryDM=
X-Received: by 2002:a02:1a82:: with SMTP id 124mr13459829jai.37.1587366139636;
 Mon, 20 Apr 2020 00:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
 <20200415092045.4729-19-danil.kipnis@cloud.ionos.com> <2827b679-70f5-3026-605a-14f2cc89aaab@acm.org>
In-Reply-To: <2827b679-70f5-3026-605a-14f2cc89aaab@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 20 Apr 2020 09:02:11 +0200
Message-ID: <CAMGffEn7JEfoZVopMCZzUEdWWBPG=Y=4P59=5zVm4dy4=agrSg@mail.gmail.com>
Subject: Re: [PATCH v12 18/25] block/rnbd: client: sysfs interface functions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 19, 2020 at 1:18 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 4/15/20 2:20 AM, Danil Kipnis wrote:
> > This is the sysfs interface to rnbd block devices on client side:
> >
> >    /sys/class/rnbd-client/ctl/
> >      |- map_device
> >      |  *** maps remote device
> >      |
> >      |- devices/
> >         *** all mapped devices
> >
> >    /sys/block/rnbd<N>/rnbd/
> >      |- unmap_device
> >      |  *** unmaps device
> >      |
> >      |- state
> >      |  *** device state
> >      |
> >      |- session
> >      |  *** session name
> >      |
> >      |- mapping_path
> >         *** path of the dev that was mapped on server
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>
Thanks Bart!
