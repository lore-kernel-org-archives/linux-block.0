Return-Path: <SRS0=f8eR=XW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99FCC4360C
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 12:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4B4217D7
	for <linux-block@archiver.kernel.org>; Fri, 27 Sep 2019 12:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="OAHrzWxT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfI0MEa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Sep 2019 08:04:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41707 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfI0MEa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Sep 2019 08:04:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id h7so2428820wrw.8
        for <linux-block@vger.kernel.org>; Fri, 27 Sep 2019 05:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b2iw2VtLufxj11Fm0JlU+oavXCSMSBn9EwsIJtM7DtQ=;
        b=OAHrzWxT684cRT2Q/GTvTyymCyaxbdc3nQoVxzq/XX9VR9tXPlxFdVgH2Pp+hIPefl
         TxNiF7v3ZhzgHyFnOVJyXPPWQ2dJwAlvy9BYwbVZBS6QplsQvJ1teUCC/aNAB7dLWW6Y
         qsidadUVKJej3zS9PlKQ5rp1JfzZfkCOjgBMzt4Juf/ySTZeSQyyjGksG/JTmEacFRjv
         5hAiEf/nXBNcteBkTdwq9drth/z3IdldXHHwR0YQaYe8DA0slzWylW6QpKTwUNS93hmT
         v8r0J7DuMNB39x2GbNbRN2BnLOGb7FjereolHc7XhgT1aQQxK2A2i5pTUtMmE2AneqTl
         vmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b2iw2VtLufxj11Fm0JlU+oavXCSMSBn9EwsIJtM7DtQ=;
        b=CZCcPxYbi/oHlXZz/6SyyGmm2VKbnNlaCc5s0tBKY1xiWOHfCcI0IZrw1sxnBGKg3+
         pb4GpVcYQqEq8xfVAPwPUSoTDlBGdFxiVVJxuH9hBziRMZg+FI1p/XhH1kEOD6u7E+5S
         Wmms3d38bSK43QMxunIdR5mTu7qqlZct7EN8feT4G15XmXpNTeJLQjNjpYyo8OAS+GMB
         MytEXc1Zhq6i3xq6+iGmjGu+3fy7hIsOPGDzOgINSDInyvCxkaLDSPJt3Jkg+7JnzGdU
         hiueh+XrO7fKnQCD1e+9XLUPPsm2bTTfHKUC3Wek1xoalrwS6Rn8Lgh/H0vysK7He/fL
         OMmg==
X-Gm-Message-State: APjAAAUuM3zUd6Hf1kTFb3xKl1Ity7UH1YpWHXOZWAdUmDwDByXEzfU0
        FnIg041WeGBU8RoIApvvDTgJstDo6ZAY9Rq9RY7r+w==
X-Google-Smtp-Source: APXvYqxCJWbMzmW/zWMBktqKGLPDSSJau0EgT0yLx2A6eOZ1Kxv0eu+UGP4dL/ncofnLK8C52TUhPso+IYZ67eKl9T8=
X-Received: by 2002:adf:f406:: with SMTP id g6mr2574100wro.325.1569585868528;
 Fri, 27 Sep 2019 05:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-10-jinpuwang@gmail.com>
 <c0ca07e9-2864-b1a2-1b78-b9f1de5702c0@acm.org>
In-Reply-To: <c0ca07e9-2864-b1a2-1b78-b9f1de5702c0@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 27 Sep 2019 14:04:17 +0200
Message-ID: <CAMGffEnqC0peHr9W8y077YLZPC0+RzSJ4c8Z3q23eVgvFp1y3A@mail.gmail.com>
Subject: Re: [PATCH v4 09/25] ibtrs: server: private header with server
 structs and functions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 24, 2019 at 1:21 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 6/20/19 8:03 AM, Jack Wang wrote:
> > +static inline const char *ibtrs_srv_state_str(enum ibtrs_srv_state state)
> > +{
> > +     switch (state) {
> > +     case IBTRS_SRV_CONNECTING:
> > +             return "IBTRS_SRV_CONNECTING";
> > +     case IBTRS_SRV_CONNECTED:
> > +             return "IBTRS_SRV_CONNECTED";
> > +     case IBTRS_SRV_CLOSING:
> > +             return "IBTRS_SRV_CLOSING";
> > +     case IBTRS_SRV_CLOSED:
> > +             return "IBTRS_SRV_CLOSED";
> > +     default:
> > +             return "UNKNOWN";
> > +     }
> > +}
>
> Since this function is not in the hot path, please move it into a .c file.
Ok.
>
> > +/* See ibtrs-log.h */
> > +#define TYPES_TO_SESSNAME(obj)                                               \
> > +     LIST(CASE(obj, struct ibtrs_srv_sess *, s.sessname))
>
> Please remove this macro and pass 'sessname' explicitly to logging
> functions.
Ok.
>
> Thanks,
>
> Bart.
Thanks!
