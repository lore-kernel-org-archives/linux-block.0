Return-Path: <SRS0=t5UG=4W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF1EC3F2D1
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 13:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E60208C3
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 13:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="OCfN8uho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgCENiM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Mar 2020 08:38:12 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:35905 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgCENiM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Mar 2020 08:38:12 -0500
Received: by mail-il1-f193.google.com with SMTP id b17so5040865iln.3
        for <linux-block@vger.kernel.org>; Thu, 05 Mar 2020 05:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KiApMWEDHxnOhBvvVyZsuR3dqipfMmsChaKxG3d2+kQ=;
        b=OCfN8uhoUyBu9z3uTzwYl+YzmINVCAzP+LWtoU+4xskqcK7yrikiyqsS6Ll6DvTFv+
         Rqi080TXXTt1gGGAK1Tfj4gV/I4mdBogW9LOCaES1HahaIBz7spKEAHelsCMcptOOzSP
         ffG23d6Ngkt1anlfKwCQJLECBij1RL8FAqHj+uZ9m0eyN/zc0CBLWGoR8DFuTfD/sRr2
         pJ7M4dwuUz9Z/Tnq5lcZHdJ4m0VhaW0se3CvbynVPkyUGHaw9sbBimni9vB40TFzjoF4
         OrzRd6sD6+9Yg4Wjp9S/rRt9m8kzUDAf+4LqmkAxyYq5GlX+atu/xIC5MIVUQPNErTGc
         D5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KiApMWEDHxnOhBvvVyZsuR3dqipfMmsChaKxG3d2+kQ=;
        b=HZ04M7+67eF+p1GGuERQi0Kl8hxGCG3uUJDf+bUvSPBnwG5l+hrs4bfPXYU1xVlO7e
         Mr7amnPi9uv9AP5DANrB658vGijoPHfCWYVcrlABwAZCUJJODGFSxEeVg1xPZr74DBwc
         twcc19HdNHPaUJKYV+g0Vy4K4UwqYFOXclq4E+0E25w0tRWzclUA0OioVgcaOxOxoaes
         EB514+WjDCzhJKiNf7ZTA0bR+lfNeQlQz8A+P5SbMufXPt0rN+/LJ8f8fWanpqOujwJt
         tJh26CezWkNb/bpPzKaeai0ajaS9oRZKvR3JfUy+aDPMy2Ofb6nsAXWMsEoqYL68JYhJ
         B6NA==
X-Gm-Message-State: ANhLgQ0HCsD+S+cExRkwen4Yk1rWafRAjPxUT+LMkzcE+j12ilawTACg
        Wvxj+WN2Razt35crma4Nmrk6jWe9OeM3xHf6xIwc8Q==
X-Google-Smtp-Source: ADFU+vvBY2rBx4ruOSMcOjobCb0gd4sgwtTXfphEfkID2CT5qwZSrAHBz/aWPj2ijf1E0uoGA8LlSc3GdoX0fLMr/XQ=
X-Received: by 2002:a92:670f:: with SMTP id b15mr8172209ilc.71.1583415490320;
 Thu, 05 Mar 2020 05:38:10 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-7-jinpuwang@gmail.com>
 <c3c8fbcc-0028-9b23-8eff-3b5f1f60e652@acm.org> <CAHg0HuxJgjQca3Vy7nbcVKs0bUoj=-Uqoa5DOzYoqRHQ6Vph7A@mail.gmail.com>
 <597777e7-ac5a-5fc4-c1f7-3ffa5876a6f2@acm.org> <CAMGffEmbV1YL4O860EswBKm2UHBYP_cgqMFYFVc2AdHnAFeu+g@mail.gmail.com>
 <20200304164903.GF31668@ziepe.ca> <CAMGffEncbGXhFLDxZJp957c7vmV4vCaTZFUVKwqDROFikCTLPg@mail.gmail.com>
 <20200305132748.GH31668@ziepe.ca>
In-Reply-To: <20200305132748.GH31668@ziepe.ca>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 5 Mar 2020 14:37:59 +0100
Message-ID: <CAMGffEkYvTit0Zv6HMDaUgo8kLEOLs_8vex7p1qgVeUDUxa4XA@mail.gmail.com>
Subject: Re: [PATCH v9 06/25] RDMA/rtrs: client: main functionality
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 5, 2020 at 2:27 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Mar 05, 2020 at 12:26:01PM +0100, Jinpu Wang wrote:
>
> > We have to admit, the code snip is from null_blk, get_tag function,
> > not invented by us.
> > the get_cpu/put_cpu was added to get/save the current cpu_id, which
> > can be removed around the do-while loop.,
> > we only need to raw_smp_processor_id to get current cpu, we use it
> > later to pick which connection to use.
>
> Be careful copying crazy core code into drivers..
>
> > > You have to do something to provably guarantee the send q cannot
> > > overflow. send q overflow is defined as calling post_send before a
> > > poll_cq has confirmed space is available for send.
>
> > Shouldn't the cq api handle that already,  with IB_POLL_SOFTIRQ,
> > poll cq is done on very softirq run, so send queue space should be reclaimed
> > fast enough, with IB_POLL_WORKQUEUE, when cq->com_handler get called,
> > the ib_cq_poll_work will do the poll_cq, together with extra
> > send_queue size reserved,
> > the send queue can not overflow!
>
> Somehow that doesn't sound like 'provably guarentee' - that is some
> statistical argument..
Could you give an example which meets the "provably guarantee",
seems most of the driver is based on the cq API.
>
> Jason
Thanks!
