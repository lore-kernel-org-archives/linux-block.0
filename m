Return-Path: <SRS0=PH3O=VQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0E1C76195
	for <linux-block@archiver.kernel.org>; Fri, 19 Jul 2019 13:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E746920873
	for <linux-block@archiver.kernel.org>; Fri, 19 Jul 2019 13:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Eq21zHlT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbfGSNM6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jul 2019 09:12:58 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43783 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbfGSNM6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jul 2019 09:12:58 -0400
Received: by mail-io1-f67.google.com with SMTP id k20so58232949ios.10
        for <linux-block@vger.kernel.org>; Fri, 19 Jul 2019 06:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s91tKYIQeKJmNASGzuZv62jiVZtvz7cNLDd/Mhsd4sI=;
        b=Eq21zHlTIxuHyTj24874Uia3TBD6JWRoJBGL8HEpwLYwO0hdt4FpurhceTYVlMceuu
         sP9U8EaERO10hICk89qjaOP5X4UzWG+rM0z9WeO4UO1DgkioRYhU6vqTH+tugxhSOPwE
         MvP+eupf7S88R3RtL/u5B0LFSxabJCoHMbqeDX3C9TtSYw9REmt8wJJp5u2M5ICuc8ru
         PamhdpDm4iWuSCqYszFDWpnsLqlvZxLA72wOdzY3n0iFPxBFh4/enjoHLMni5AowZyfU
         OcRwWSpjcAXnFHQ0V+Yet0W4wc/RYIZzTH1oHviTAcdEhfd3Zd82+LEvr0KbPwUiFZAI
         I2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s91tKYIQeKJmNASGzuZv62jiVZtvz7cNLDd/Mhsd4sI=;
        b=qAAUcfcRVy/xk10GPo981Qr80dyJvIGu2OHQt3A6xoGMYAEMuT1G9q7kv2t/wyugqn
         YHrWXQoLlmrjN+o1EBKdqOERbIeSEkhVfxYelZ7V9cFbZpW8fm4rdA8RDHuUgT7utota
         XCHDZAOYWwlAHxFFHySjgma+sGunskUnJ0xj7clJKW5ksuGYNTPsCqDMPPEt0Bh97Ja4
         mHnHiBQpUSmFN4CQxBSzcIwLv92yhOedtuYFgR5ZYG6FQdEKYLIXpyOE435xcxwJe5qK
         oSh4iZa7XZLK7r7pVdkzIiq7fMOaP/HDDpdNdLAJnW8Gw2DacknaFeDtNl9Vei8aRL3F
         k6sQ==
X-Gm-Message-State: APjAAAUVX6WMeLjXNnVvYi/XcDW4PIFs9y0YtyoVVOBkm3xCaQZAbvbL
        lMqq3STy7lJ8HxSKlK3BkMIj3NyhoIyLg8Pqt3UA
X-Google-Smtp-Source: APXvYqx1oWVR2cuAetmaPy1R06U3aM9TtEWw/74jY3DbA4y4W2lGaVACp9491HJ2avHInLSMczhmXCExrEmelimPS54=
X-Received: by 2002:a6b:f216:: with SMTP id q22mr10710978ioh.65.1563541977484;
 Fri, 19 Jul 2019 06:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
 <20190709110036.GQ7034@mtr-leonro.mtl.com> <CAD9gYJL=fo4Oa2hmU4WZgQrzypRbzoPrrFjNQKP2EZFXYxYNCA@mail.gmail.com>
 <20190709120606.GB3436@mellanox.com> <CAMGffE=T+FVfVzV5cCtVrm_6ikdJ9pjpFsPgx+t0EUpegoZELQ@mail.gmail.com>
 <20190709131932.GI3436@mellanox.com> <1cd86f4b-7cd1-4e00-7111-5c8e09ba06be@grimberg.me>
In-Reply-To: <1cd86f4b-7cd1-4e00-7111-5c8e09ba06be@grimberg.me>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Fri, 19 Jul 2019 15:12:46 +0200
Message-ID: <CAHg0HuxJn8Uv7jJKyTd36udqvMF+ajECjpOhnTJcnHV_PFrdRg@mail.gmail.com>
Subject: Re: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        Jinpu Wang <jinpuwang@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        Roman Pen <r.peniaev@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Sagi,

thanks a lot for the information. We are doing the right thing
regarding the invalidation (your 2f122e4f5107), but we do use
unsignalled sends and need to fix that. Please correct me if I'm
wrong: The patches (b4b591c87f2b, b4b591c87f2b) fix the problem that
if the ack from target is lost for some reason, the initiators HCA
will resend it even after the request is completed.
But doesn't the same problem persist also other way around: for the
lost acks from client? I mean, target is did a send for the "read"
IOs; client completed the request (after invalidation, refcount
dropped to 0, etc), but the ack is not delivered to the HCA of the
target, so the target will also resend it. This seems unfixable, since
the client can't possible know if the server received his ack or not?
Doesn't the problem go away, if rdma_conn_param.retry_count is just set to 0?

Thanks for your help,
Best,
Danil.

On Tue, Jul 9, 2019 at 11:27 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> >> Thanks Jason for feedback.
> >> Can you be  more specific about  "the invalidation model for MR was wrong"
> >
> > MR's must be invalidated before data is handed over to the block
> > layer. It can't leave MRs open for access and then touch the memory
> > the MR covers.
>
> Jason is referring to these fixes:
> 2f122e4f5107 ("nvme-rdma: wait for local invalidation before completing
> a request")
> 4af7f7ff92a4 ("nvme-rdma: don't complete requests before a send work
> request has completed")
> b4b591c87f2b ("nvme-rdma: don't suppress send completions")
