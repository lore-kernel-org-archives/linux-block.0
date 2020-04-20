Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F26C3A5A0
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 06:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC7A721473
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 06:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="VqkENRhP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgDTGw1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 02:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725896AbgDTGw0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 02:52:26 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77102C061A0F
        for <linux-block@vger.kernel.org>; Sun, 19 Apr 2020 23:52:25 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id x2so7347488ilp.13
        for <linux-block@vger.kernel.org>; Sun, 19 Apr 2020 23:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/F/zV1JGwLIRMB54WRyhqQKlp9+/VLvBYQvEIujoXX4=;
        b=VqkENRhPB9R/kCQ3O9qvUQESenmhBXdb6yly7yyPmcdrsC5lrFQVEdRRFRJX7n/y98
         34oY7kyHqjlgCXTMiBVq3bQ70NULShByzn8HaVLRcR2oDinnnFheRxwILRCaO9yYtIyE
         wJ9W6cZpw4X0mGtZS1jvENMV+nYER/WHX9YoD82ld0gm6o43LNZoqjfJuTo0MgPAYpZj
         W+nSD3gZH8vZmujvmM8fKds3CJL3pRbnrtNFY+qyoyAz7KJ94BCELylu291z7mgpEmlh
         fGdpQh0rWDAvcUEOcBfQlI+UumV81sR2+jB4Slsh2AbxgOAL/J2h4Cxf6tv4hpNHYgWe
         h4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/F/zV1JGwLIRMB54WRyhqQKlp9+/VLvBYQvEIujoXX4=;
        b=DYW1086DBNy0rjpBM51PyGmxqwwuf3Ppv8kvrvSzZ0+SFa9BVFHtcIYjnTvjEQXEcb
         B9v3br8+BXHofOfaIPFvGNGMSvNAa7HGSsv0Wvt0UxBMCnfXLlEZBWASjuGyTXUir090
         uRrRsUyuvwvioUtzgfEUWnLhHYyRQk6zqgnDgDwDkW1K2kQue8zQwRVAK4CrE+LxHS1X
         y8eMy8Qq8yyNOZBw69ZV2Uwp+99TdR2A8Lm6tLE/Dp96FH5AHzoseakgNsM28q4ENu9s
         50TfZ31xzcqNGP+FlEVfH7+IQhUo59yhLspJspt8QyDNArjV7anOu8HstmaD4u5pmfok
         P58A==
X-Gm-Message-State: AGi0PuZAjW0wzpiy4jv9HoA5KfsiZsrdpsbLa7Z/ZvIEu+7huSQztjs0
        78N//RTjGf6TmKibPq0owdAVwtO6kIdXunMADX6ljg==
X-Google-Smtp-Source: APiQypIEgyNRuGxSxsUssAa3+zhYUa9Oi/Adhns9pj8iPzaFLdOgsPi7M3ozljhEiupcojPDlg+/yDBQTnALfcYfsY4=
X-Received: by 2002:a92:485b:: with SMTP id v88mr14338041ila.271.1587365544816;
 Sun, 19 Apr 2020 23:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
 <20200415092045.4729-21-danil.kipnis@cloud.ionos.com> <e6c0d434-2dac-4a41-912b-bf09d5d98a0c@acm.org>
In-Reply-To: <e6c0d434-2dac-4a41-912b-bf09d5d98a0c@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 20 Apr 2020 08:52:16 +0200
Message-ID: <CAMGffEnjR52Km-SNp5NNSYXVLzEobU0pdwTTo4u0oe57GdEUQg@mail.gmail.com>
Subject: Re: [PATCH v12 20/25] block/rnbd: server: main functionality
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

On Sun, Apr 19, 2020 at 1:34 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 4/15/20 2:20 AM, Danil Kipnis wrote:
> > This is main functionality of rnbd-server module, which handles RTRS
> > events and rnbd protocol requests, like map (open) or unmap (close)
> > device.  Also server side is responsible for processing incoming IBTRS
> > IO requests and forward them to local mapped devices.
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>
Thanks Bart!
