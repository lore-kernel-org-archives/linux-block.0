Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62818C43331
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 14:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345652071A
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 14:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="IOsqcPnG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbgCaOUo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 10:20:44 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45192 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729891AbgCaOUo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 10:20:44 -0400
Received: by mail-io1-f65.google.com with SMTP id y14so4754578iol.12
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2020 07:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GnPaVP2gBEwIPF8mfzd93scGAf3j/qK6lXY3ypX3mqA=;
        b=IOsqcPnGJWgJtyx5ZJEg50LRaTrvcqPJSh8Oc2lGtJrVisHrPyv6fnOUThIjlm/FhJ
         qSEEAEevksq9P/kXVty+lyn0fAeOBpV3zEIce5Q4gxAep4lSYigsedPKZe91E067pnXj
         uiJFL/QboomYq3hjkOx1FTEcIQ6kQ7salGCqKhwzjCt/mbOuvZS7Z/zQ16KUtIa/k/Fl
         4F/U7yyjI9LBczfSR00otULe1kQshZ06YE5blDAask2QIocxQzlb3SRvU9A3IDSST32S
         1k70f3/fozO6EB6/YoUmD0mPYTnAe30BEQHB8c0Q1+Vv6K5tlzYmFEBmzmiidMnLalsE
         FNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GnPaVP2gBEwIPF8mfzd93scGAf3j/qK6lXY3ypX3mqA=;
        b=QQkKEOTJC0T4kHF1MsEottV8KQ8Pur5UoYTbt/Zq97Yalrv9zDxYw2xFQJR9FtE+pL
         62GRpxmM1Zl8AOmf5Mf2CzQg2Rwkx24bJ6rMgfynv5F7Z2o8GZFSxORtNo6s18vH687m
         6pSq4bxQIYll37NuEnxkQzbU0aB+FMHZBxYZ0MKgcQudY3z+UHA2ndB0VLFfI9T4o0v1
         R0HjVC+kIVJ6gOPq0T+OkUJYOqOIRDgaEB60yQp3ySv67ImNgAhrYUFvyBvQGKCmT5ol
         FQBKAlggeEoFPUmrx7t/fjpQZ46Ijy9pbM2di7WeMw9OCe6SUS0BiDiVHTbxfQ2aMaaN
         3dUw==
X-Gm-Message-State: ANhLgQ0sHyD3+eAe9w5v4icFl7kDgsVeBKmpS4E8PA1sgZey4i5s6Uy6
        pxMudhqoGbQRB7o1+p0Vx5g3v1wAD2MG93SNHk58RQ==
X-Google-Smtp-Source: ADFU+vtVgS5vr/ydr7uBVhvdFJEto7dqmOE9+vHSWzFR4/gsD6YOozE+HaVT0inaiIKDNDfNkaiVxO02iNO9/4BjTRI=
X-Received: by 2002:a05:6638:a99:: with SMTP id 25mr16588167jas.37.1585664443040;
 Tue, 31 Mar 2020 07:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-19-jinpu.wang@cloud.ionos.com> <27b4e9a5-826f-d323-3d19-3f64c79e03eb@acm.org>
 <CAMGffEmWPyBAHWJpkVvWuptgoX0tw4rs4jJH1TuJ0jRrkMBdYQ@mail.gmail.com> <a02887c4-2e54-3b55-612a-29721b44eb7b@acm.org>
In-Reply-To: <a02887c4-2e54-3b55-612a-29721b44eb7b@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 31 Mar 2020 16:20:32 +0200
Message-ID: <CAMGffEkeVHm57DgTD_tXQNjuNx152PmGLum-cNS1X6x=5eysGg@mail.gmail.com>
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

On Tue, Mar 31, 2020 at 4:13 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 3/31/20 2:25 AM, Jinpu Wang wrote:
> > On Sat, Mar 28, 2020 at 5:59 AM Bart Van Assche <bvanassche@acm.org> wrote:
> >>
> >> On 2020-03-20 05:16, Jack Wang wrote:
> >>> +     /*
> >>> +      * Nothing was found, establish rtrs connection and proceed further.
> >>> +      */
> >>> +     sess->rtrs = rtrs_clt_open(&rtrs_ops, sessname,
> >>> +                                  paths, path_cnt, RTRS_PORT,
> >>> +                                  sizeof(struct rnbd_iu),
> >>> +                                  RECONNECT_DELAY, BMAX_SEGMENTS,
> >>> +                                  MAX_RECONNECTS);
> >>
> >> Is the server port number perhaps hardcoded in the above code?
> >
> > Yes, we should have introduced a module parameter for rnbd-clt too, so
> > if admin changes port_nr, it's possible to change it also on rnbd-clt.
>
> What if someone decides to use different port numbers for different rnbd
> servers? Shouldn't the port number be configurable per connection
> instead of making it a kernel module parameter? How about extracting the
> destination port number from the address string like srp_parse_in() does?

Probably we should do both, the per connection destination setting can
over right the module parameter if both exist.
>
> Thanks,
>
> Bart.
Thanks Bart!
