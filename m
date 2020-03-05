Return-Path: <SRS0=t5UG=4W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6517EC3F2D1
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 13:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DEE02073B
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 13:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q1P/g+wM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgCENy7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Mar 2020 08:54:59 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:34221 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgCENy7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Mar 2020 08:54:59 -0500
Received: by mail-qv1-f67.google.com with SMTP id o18so2437751qvf.1
        for <linux-block@vger.kernel.org>; Thu, 05 Mar 2020 05:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6shA/MnYAo64Iv5nNYwoW40lynjB702RbgFxOYlHj2Q=;
        b=Q1P/g+wM9TAuJRxT1OM8LC1VO26zCTX1t3mMVBWgsuEFH+kp9TXP1E7IihdcBzTcG4
         23txlMlVQ10BsN5iNh0FvFdY+jJauX9XYLoe3EdTcKZ+qT3ghLp+EZyKJlIi/HGd0qv+
         euwnkS1EvnM6pKJ8Yc4aCudQny584wRqPEIhyulAPq9cVqg1ZWpZefM3exWWSeR+o+dU
         rWPuqDaBHUCs9Xa7rudNAwZ4EsXQtxkz9pCEAYwtpCEAhyOd8JAPJHDEOWNCUcx3CikT
         zCU0RaBvtCdc2l9OrthUALIbUMAsAY/sc73wchRhmF1u3LPQSIFfIa3NpR2k7gZz4BZA
         /gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6shA/MnYAo64Iv5nNYwoW40lynjB702RbgFxOYlHj2Q=;
        b=Fb7DLPca5KBdXb3am7fIgFouBONuUPTnvPr2V0+5LykvcxvTEPjr1tCMeq+lyQMG01
         AHQjXkXhc7p+zpnsd7ZwzZvpbYyxpvFr9YrNXbQ/dD2F2rQbxTNGhnFg2PRGOm4nZ7sN
         d9Ue4GCE7XdEhMKuKY0OTqxYVPz0thNvHy1gsOWObjFBT6rY8XQjHJIV2f0Bt1gs/TCN
         i7AerDmaeJgefofAiAV1jF2L4zbP5OVmtbqFscm3iqxULCPhZHvWWwxglM96LDXefRqL
         eGpyhghDlog67Z13IpWjMt//odsQZ5EKADcNd9Z6T4mkyUZMPU67hklqI2TWj2ONke3z
         m07A==
X-Gm-Message-State: ANhLgQ2r3WSq0XGxcZL8E0CUVZ/HlInFuq2EnC8cojAoAdbMvKTD69yn
        oWvkBcJJYzSTGciOO6YhqJLcTg==
X-Google-Smtp-Source: ADFU+vvS68RTysru2IhFJZQRzpof/V4eDEbpw9z05fwXzj39bktxl0rtF7uWkg8rjyFsXiElRPIpSg==
X-Received: by 2002:a0c:ca94:: with SMTP id a20mr6313765qvk.150.1583416496798;
        Thu, 05 Mar 2020 05:54:56 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id w204sm3081864qkb.133.2020.03.05.05.54.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Mar 2020 05:54:56 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j9qxj-0005JD-Of; Thu, 05 Mar 2020 09:54:55 -0400
Date:   Thu, 5 Mar 2020 09:54:55 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
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
Subject: Re: [PATCH v9 06/25] RDMA/rtrs: client: main functionality
Message-ID: <20200305135455.GI31668@ziepe.ca>
References: <20200221104721.350-1-jinpuwang@gmail.com>
 <20200221104721.350-7-jinpuwang@gmail.com>
 <c3c8fbcc-0028-9b23-8eff-3b5f1f60e652@acm.org>
 <CAHg0HuxJgjQca3Vy7nbcVKs0bUoj=-Uqoa5DOzYoqRHQ6Vph7A@mail.gmail.com>
 <597777e7-ac5a-5fc4-c1f7-3ffa5876a6f2@acm.org>
 <CAMGffEmbV1YL4O860EswBKm2UHBYP_cgqMFYFVc2AdHnAFeu+g@mail.gmail.com>
 <20200304164903.GF31668@ziepe.ca>
 <CAMGffEncbGXhFLDxZJp957c7vmV4vCaTZFUVKwqDROFikCTLPg@mail.gmail.com>
 <20200305132748.GH31668@ziepe.ca>
 <CAMGffEkYvTit0Zv6HMDaUgo8kLEOLs_8vex7p1qgVeUDUxa4XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEkYvTit0Zv6HMDaUgo8kLEOLs_8vex7p1qgVeUDUxa4XA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 05, 2020 at 02:37:59PM +0100, Jinpu Wang wrote:
> On Thu, Mar 5, 2020 at 2:27 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Thu, Mar 05, 2020 at 12:26:01PM +0100, Jinpu Wang wrote:
> >
> > > We have to admit, the code snip is from null_blk, get_tag function,
> > > not invented by us.
> > > the get_cpu/put_cpu was added to get/save the current cpu_id, which
> > > can be removed around the do-while loop.,
> > > we only need to raw_smp_processor_id to get current cpu, we use it
> > > later to pick which connection to use.
> >
> > Be careful copying crazy core code into drivers..
> >
> > > > You have to do something to provably guarantee the send q cannot
> > > > overflow. send q overflow is defined as calling post_send before a
> > > > poll_cq has confirmed space is available for send.
> >
> > > Shouldn't the cq api handle that already,  with IB_POLL_SOFTIRQ,
> > > poll cq is done on very softirq run, so send queue space should be reclaimed
> > > fast enough, with IB_POLL_WORKQUEUE, when cq->com_handler get called,
> > > the ib_cq_poll_work will do the poll_cq, together with extra
> > > send_queue size reserved,
> > > the send queue can not overflow!
> >
> > Somehow that doesn't sound like 'provably guarentee' - that is some
> > statistical argument..
> Could you give an example which meets the "provably guarantee",
> seems most of the driver is based on the cq API.

You are supposed to directly keep track of completions and not issue
sends until completions are seen.

Jason
