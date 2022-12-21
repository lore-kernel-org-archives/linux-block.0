Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FA8C4332F
	for <linux-block@archiver.kernel.org>; Wed, 21 Dec 2022 14:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbiLUOPg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Dec 2022 09:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbiLUOP1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Dec 2022 09:15:27 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A739248EE
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 06:15:23 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id x22so37068319ejs.11
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 06:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SMVy3OUddSJwF96CPiXZ2tBpIM5xXUul9JOqAQTf3xU=;
        b=RuQKjaSc5/F3YXI2MV113Lta4dCmnWkEhNsdgaAj4X6AuKi3k4DIZU6nE11pN+ju/b
         vIf+omg1Wa/4nwL4aKWE8XWlpkiJLzIhJFDNgH94+EdbvXIw6oJCzsxl3FOOGrJ52sGq
         iv/SPj0cLMkzHOJx2qqcHORbf+cvTQZLnpE+U4FkQgmWfF8R2aApsXr/LPTvAJsfhWui
         W6v/1WyayAC8r94G8XvWpDW4UcJIn9ZPofbuF6jnEmMig7whlfHEQkkJ2cJqX7R7aTtc
         UmYodUn1YljpuI/Ug0M8zpCAHNIKqCxtLeCjYm2NixbaVe82hbTThAs33G6q3P+yef1C
         Xoiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SMVy3OUddSJwF96CPiXZ2tBpIM5xXUul9JOqAQTf3xU=;
        b=z0o5hMh157eGciTcOboOiY7SajSIVMYunE2I5R29DjS9RMrCmaGW3bgy1A46EZlBAn
         QuXdzlnatpAsYmeLxKiTvzLmXUvMTeuzIw8RafTkRNxU8H3hU2gDNUgKJuqQh5whILi4
         LVnOUWGnUgDGSxyPxxqtMEbqhot2qhHfEvifqoK3uOyFjvD+HEyEDGuSk5uKoKSEwyCU
         v8qhfSQuUECo+fHDa8BVAuMhk29y00Q6r4R7OfnGDqsz1J/FisV3Gu1V6R6TdNLjGtjo
         ZsmwKwyeNP5QVoKJyHhxKC1Ai51/E3PdkIFM/mhb+xKdDjycvu8Z2+EcbiMYzwvMhDJR
         HQ7g==
X-Gm-Message-State: AFqh2koklZOyDFObcoWX8gnkgttrtYMRR6wUILjWMkbC+15PnLiYyx2B
        xfVtOedGw9qEdfwkMCVsLckPJiZ4xVwMAS3N2p+K+Jppczs=
X-Google-Smtp-Source: AMrXdXu29NPg5n1rurrLcU9CvB3z09vpGPusGVHlCGCnG/bTftrfJORneuxk2H6g0xPcIdCJxI+Of+g0b2KSRvTPsEw=
X-Received: by 2002:a17:906:285a:b0:7b2:af38:ef00 with SMTP id
 s26-20020a170906285a00b007b2af38ef00mr201709ejc.546.1671632122026; Wed, 21
 Dec 2022 06:15:22 -0800 (PST)
MIME-Version: 1.0
References: <20221220153613.21675-1-suwan.kim027@gmail.com>
 <20221220153613.21675-3-suwan.kim027@gmail.com> <Y6LkfrTVV/M2eye/@infradead.org>
 <Y6MOF7CMJ1AZEzoC@localhost.localdomain>
In-Reply-To: <Y6MOF7CMJ1AZEzoC@localhost.localdomain>
From:   Suwan Kim <suwan.kim027@gmail.com>
Date:   Wed, 21 Dec 2022 23:15:10 +0900
Message-ID: <CAFNWusY=z=rhPxuLnFpPKRfuJWMEtPomysm9LLvb8WvK2y2+jg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] virtio-blk: support completion batching for the
 IRQ path
To:     Christoph Hellwig <hch@infradead.org>
Cc:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 21, 2022 at 10:46 PM Suwan Kim <suwan.kim027@gmail.com> wrote:
>
> On Wed, Dec 21, 2022 at 02:48:30AM -0800, Christoph Hellwig wrote:
> > > +           if (likely(!blk_should_fake_timeout(req->q)) &&
> > > +                   !blk_mq_complete_request_remote(req) &&
> > > +                   !blk_mq_add_to_batch(req, iob, vbr->status,
> > > +                                           virtblk_complete_batch))
> >
> > One tab indents for line continuations are really confusing.  Please
> > make this:
> >
> >               if (likely(!blk_should_fake_timeout(req->q)) &&
> >                   !blk_mq_complete_request_remote(req) &&
> >                   !blk_mq_add_to_batch(req, iob, vbr->status,
> >                                        virtblk_complete_batch))
> >
> > > +   found = virtblk_handle_req(vq, iob);
> > >
> > >     if (found)
> >
> > You can drop the found variable here now:
> >
> >       if (virtblk_handle_req(vq, iob))
> >               blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
> >
>

Ah, virtblk_poll() should return found to indicate whether a request
was processed. I'll leave this as is.

Regards,
Suwan Kim
