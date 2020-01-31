Return-Path: <SRS0=MKaG=3U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78221C35240
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 17:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F63217BA
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 17:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jmx0SJKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgAaRt2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Jan 2020 12:49:28 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:39023 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgAaRt2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Jan 2020 12:49:28 -0500
Received: by mail-qv1-f65.google.com with SMTP id y8so3651819qvk.6
        for <linux-block@vger.kernel.org>; Fri, 31 Jan 2020 09:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t9FfkXkAT6xKBWkUXQbIOJ6JHX49jFODgFWHOIXBg1w=;
        b=jmx0SJKHL82uuWWrWuhMCkRoxrAOJfz64tmdhZdmh1hLQuP1YeEkGaWa/H7fjf8+sS
         TFNFvUVezrA1pC6ZHE8pYBnAT4+hrlpcrmnNBUQAYh1HwwZ5ew3zvwioG1ejLiOfrGVJ
         Ztn5zNIXk9k4sKUC7yKfgjq3yJWJQ6k1t73SSQAluTairCgNauvLd9u4/D0mJdgI70ZT
         38l1zp51JNmgdVZOHKxRkRxHfrdA7ZGL4NUQTDA3NwbecAhkQuiGKwf0p6dMXhKu+FbI
         od8THO3UKZ/6RzYbVResrvUbG/J3QhnI/HW/GqQ5gFoMed6TkaW/4M5epvDJBVdQOIGZ
         mbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t9FfkXkAT6xKBWkUXQbIOJ6JHX49jFODgFWHOIXBg1w=;
        b=JcbZMs7V7/sB0Z4su2u7Y8ekUvKavO06unh3X/AvAxuWN7HrPBVz2qbhsLaFPtm1GP
         h6XGNuw7McN9IhsVbtwSIStzMk3KgFVXYDnk+lDTOsCr5gTartkp0JksedyyWKewtrt1
         VLMmR288Ae/Is/dnvLn9ezRRybJLejuZigpmLE07Y8irL1h/gHS9lTPnrOeAlr6LE6wX
         k+dQoGsbXZganP6NUHXTEWjGadvbO//Tp+RCvpQC531oxtSx2v5jr/EEEU5NgplCqp/m
         6DlZ//MCxzfq2d8X5cV2+9+4k2xdaFCwK7HVzfzZFQkOoQha7NsE8itRhnOlUx/j8SXq
         8duQ==
X-Gm-Message-State: APjAAAVxlp63EOM2mF+StcofaDIKMNNdUh+AcDD86qnhR15O4BrndqhG
        SN3WBLKcEYOX/mTaKhWcirT5rg==
X-Google-Smtp-Source: APXvYqxeyK8QHeaGgorwgPTzP0+Uj1Tk6KOymggyxz+kne/OqiozqVi6c8guKYnfHLFuAbROOKFP+A==
X-Received: by 2002:a0c:bf0b:: with SMTP id m11mr11612357qvi.63.1580492967433;
        Fri, 31 Jan 2020 09:49:27 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id t29sm4833535qkm.27.2020.01.31.09.49.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Jan 2020 09:49:27 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ixaQ2-00035N-GO; Fri, 31 Jan 2020 13:49:26 -0400
Date:   Fri, 31 Jan 2020 13:49:26 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>, rpenyaev@suse.de
Subject: Re: [PATCH v8 00/25] RTRS (former IBTRS) RDMA Transport Library and
 RNBD (former IBNBD) RDMA Network Block Device
Message-ID: <20200131174926.GC29820@ziepe.ca>
References: <20200124204753.13154-1-jinpuwang@gmail.com>
 <CAHg0HuzLLHqp_76ThLhUdHGG_986Oxvvr15h_13T12eEWjyAxA@mail.gmail.com>
 <20200131165421.GB29820@ziepe.ca>
 <f657d371-3b23-e4b2-50b3-db47cd521e1f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f657d371-3b23-e4b2-50b3-db47cd521e1f@kernel.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 31, 2020 at 10:04:10AM -0700, Jens Axboe wrote:
> On 1/31/20 9:54 AM, Jason Gunthorpe wrote:
> > On Fri, Jan 31, 2020 at 05:50:44PM +0100, Danil Kipnis wrote:
> >> Hi Doug, Hi Jason, Hi Jens, Hi All,
> >>
> >> since we didn't get any new comments for the V8 prepared by Jack a
> >> week ago do you think rnbd/rtrs could be merged in the current merge
> >> window?
> > 
> > No, the cut off for something large like this would be rc4ish
> 
> Since it's been around for a while, I would have taken it in a bit
> later than that. But not now, definitely too late. If folks are
> happy with it, we can get it queued for 5.7.

I'm still sore from taking the last big driver too late and getting
about 2 weeks of little bug fixes from all the cross-arch compilation
and what not :)

Jason
