Return-Path: <SRS0=DCcP=XU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68752C4360D
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 21:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2D220872
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 21:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="M4/nOM1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfIYVpY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Sep 2019 17:45:24 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46901 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfIYVpY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Sep 2019 17:45:24 -0400
Received: by mail-io1-f67.google.com with SMTP id c6so762552ioo.13
        for <linux-block@vger.kernel.org>; Wed, 25 Sep 2019 14:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5YnAd2hbbiFfZjlnLspPAcJzKkr4SBt0pt5/+PtSi2k=;
        b=M4/nOM1IUWTN3v5+IXgTZCwwgI2FVgKFld63loo0EKcCSofpeNYK1R2h2Io/6iZ2Ix
         LlW5PakuA8a1J6/ECVvC79/O3rFr3/0RVRVXuSwJd6sQMBHXYm6nMLnIq175gL0+UY3+
         PtX9CqQkwNl3gCL+Sh9uSJBXrYA6mA7GSdyQgMUa0kcnueWbsrLftlzlrDbXp2kxJude
         I4Gf7smuxxaRN71Y+xJ655Z2EGE1hZQfpieWF08qbKzAvNYutwAUlbNbRkX9OPMKBMFp
         gyfVrDXbEUlIjs2qYquV0z6H/Jqvtou+diAHQq/F8V0CsUS126nXE/UpqbGzdjhs8Tmp
         dzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5YnAd2hbbiFfZjlnLspPAcJzKkr4SBt0pt5/+PtSi2k=;
        b=RqJjBQch+DXfyMNaboztrFnmckqc4BWryLagYhSDknwSsuq+Cqe9AzdhjPkVXeiqg1
         X0na8ckK6jspUKAtUPnhI0zpwieES0227RAm1sNChrgcg2edtRMcOdh632XPDJM/yKj6
         eVQ/lW1oBOE1Elv2lMSRcDgg7IIe1x7cUW52I60yQTp90uBSL00xu60BgEzblI+YncBd
         Br+/Nzo3hXxsQtABHMccBeyGQom4cwoQWzVFt09H9PZjZY6fzOD0Z8tRBht2qtoh+cBQ
         zy3keV10lvc2+61T2tQiy9/R4ViS2pwViFXw+daZKwFkTyxDpuCd/fbpFihJnfUY82pG
         ooyQ==
X-Gm-Message-State: APjAAAVp4/jIQ4sHwekKvRxDzATFwYSX027YWxZgHiPjvSyoz9CIlB7s
        U5lhbAFfuRMTu8iQzGMoKXKkuWQA8rPTbd32l+cf
X-Google-Smtp-Source: APXvYqw0ccNZEIROG3IIPrGUzl41LerraXkXkCrPR3thgpwx37Mo5BDqkV9OSQLDDVYNCL1+UIEgoxwJN2dLstSC5Dc=
X-Received: by 2002:a92:1508:: with SMTP id v8mr1872894ilk.116.1569447923241;
 Wed, 25 Sep 2019 14:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-4-jinpuwang@gmail.com>
 <7f62b16a-6e6c-ad05-46d4-05514ffaeaba@acm.org>
In-Reply-To: <7f62b16a-6e6c-ad05-46d4-05514ffaeaba@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Wed, 25 Sep 2019 23:45:12 +0200
Message-ID: <CAHg0HuzsMK1Rg4mpFv2GwOnmsicR843qDMX+LKWDDn4-kV-eew@mail.gmail.com>
Subject: Re: [PATCH v4 03/25] ibtrs: private headers with IBTRS protocol
 structs and helpers
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 24, 2019 at 12:50 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 6/20/19 8:03 AM, Jack Wang wrote:
> > +#define P1 )
> > +#define P2 ))
> > +#define P3 )))
> > +#define P4 ))))
> > +#define P(N) P ## N
> > +
> > +#define CAT(a, ...) PRIMITIVE_CAT(a, __VA_ARGS__)
> > +#define PRIMITIVE_CAT(a, ...) a ## __VA_ARGS__
> > +
> > +#define LIST(...)                                            \
> > +     __VA_ARGS__,                                            \
> > +     ({ unknown_type(); NULL; })                             \
> > +     CAT(P, COUNT_ARGS(__VA_ARGS__))                         \
> > +
> > +#define EMPTY()
> > +#define DEFER(id) id EMPTY()
> > +
> > +#define _CASE(obj, type, member)                             \
> > +     __builtin_choose_expr(                                  \
> > +     __builtin_types_compatible_p(                           \
> > +             typeof(obj), type),                             \
> > +             ((type)obj)->member
> > +#define CASE(o, t, m) DEFER(_CASE)(o, t, m)
> > +
> > +/*
> > + * Below we define retrieving of sessname from common IBTRS types.
> > + * Client or server related types have to be defined by special
> > + * TYPES_TO_SESSNAME macro.
> > + */
> > +
> > +void unknown_type(void);
> > +
> > +#ifndef TYPES_TO_SESSNAME
> > +#define TYPES_TO_SESSNAME(...) ({ unknown_type(); NULL; })
> > +#endif
> > +
> > +#define ibtrs_prefix(obj)                                    \
> > +     _CASE(obj, struct ibtrs_con *,  sess->sessname),        \
> > +     _CASE(obj, struct ibtrs_sess *, sessname),              \
> > +     TYPES_TO_SESSNAME(obj)                                  \
> > +     ))
>
> No preprocessor voodoo please. Please remove all of the above and modify
> the logging statements such that these pass the proper name string as
> first argument to logging macros.

Hi Bart,

do you think it would make sense we first submit a new patchset for
IBTRS (with the changes you suggested plus closed security problem)
and later submit a separate one for IBNBD only?

Thank you,
Danil
