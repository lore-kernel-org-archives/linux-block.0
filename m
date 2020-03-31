Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C2FC43331
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBED20658
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="JZYOLuFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgCaJZs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:25:48 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33503 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729950AbgCaJZs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 05:25:48 -0400
Received: by mail-io1-f67.google.com with SMTP id o127so20979412iof.0
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2020 02:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dgvMDDhThjaROj+XyCbfwyfC/pKcEAvrZy4EYNbMoJg=;
        b=JZYOLuFqtdxwwa61K5jEn89fE3mnfJ4zOEC1+/RZ2Za+wdY7J26+x5TKJhVx+8Pbr3
         M544KBicEgBE5cG2UFME1O8+sndbtBz7U4PDMj0Ut098A0Wc98ioZtkNUnXR6aHzvGtx
         ZO2xF+jLA/+4MbYDFUMObKlWgaBb/5ys1SgcLp+DLBbnRxugynraYrxkOWjcqrP+WIio
         TtRaqSVjlwMA9Yr65cgWNYJEqnc1sQhmqr6d649Dk5vhY+KPINDZahU9w8qbzhgW/yXk
         0nbrehJH1xFa+mZuoRmYdMH7uBT77JhH+JKdRs6PWIUxTFk6lwqUkxrFJE5YkN12W5G7
         7RaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dgvMDDhThjaROj+XyCbfwyfC/pKcEAvrZy4EYNbMoJg=;
        b=GUxl5hzBgMfUjeW9WObkXmxk+ncmoN0Ln+XeqH+7fdWLClqU1RL2nbHgMVzmMgN9RC
         ojQnXFiaZB5l+nAlB2Y9NzvJr7EKHDHxSU24uSOZ3p82/LeKN+ekc/Be7PUdK+ljjzN4
         0lK5Yzz/N1YJpXau9DfAh609OAXNFnebGmQxaL6uclvBpZ6ZYgPsvz5OE82CpuQxAWha
         0mmplVe9MEDdoTAa2twGkAvoVk/VAtfYKWKjptqjfeEq2zCwOJRpVyNR49LptuhWnXDP
         yu8yXsXPlJ5e9LXjb87ShPa7x59jiivDw5I3lLgiGKKuxzF9nyegZxUYH4+QdF/FkAMB
         swdQ==
X-Gm-Message-State: ANhLgQ0ezDCk3n3nONXtEVK5U5bLwvoGOv1fsJjtRwiVIvXH4VzYE4PO
        2fBJtxsYpLMzBVDkozHlstXNK/RFbaoDZ+6+cLjR1A==
X-Google-Smtp-Source: ADFU+vu4TdmyEcsfEHMn5Mag9Mq/Yq+eZYHJ7KcexkzThTebIOzew33m4dkOJdQloFfnQ2D8sLIeIzz3vHVjNiDL4AQ=
X-Received: by 2002:a02:3b0d:: with SMTP id c13mr15197757jaa.85.1585646746793;
 Tue, 31 Mar 2020 02:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-19-jinpu.wang@cloud.ionos.com> <27b4e9a5-826f-d323-3d19-3f64c79e03eb@acm.org>
In-Reply-To: <27b4e9a5-826f-d323-3d19-3f64c79e03eb@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 31 Mar 2020 11:25:36 +0200
Message-ID: <CAMGffEmWPyBAHWJpkVvWuptgoX0tw4rs4jJH1TuJ0jRrkMBdYQ@mail.gmail.com>
Subject: Re: [PATCH v11 18/26] block/rnbd: client: main functionality
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 28, 2020 at 5:59 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-03-20 05:16, Jack Wang wrote:
> > +     /*
> > +      * Nothing was found, establish rtrs connection and proceed further.
> > +      */
> > +     sess->rtrs = rtrs_clt_open(&rtrs_ops, sessname,
> > +                                  paths, path_cnt, RTRS_PORT,
> > +                                  sizeof(struct rnbd_iu),
> > +                                  RECONNECT_DELAY, BMAX_SEGMENTS,
> > +                                  MAX_RECONNECTS);
>
> Is the server port number perhaps hardcoded in the above code?
Yes, we should have introduced a module parameter for rnbd-clt too, so
if admin changes port_nr, it's possible to change it also on rnbd-clt.

Thanks Bart!
