Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58E0C282CD
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 01:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A422F2177E
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 01:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PKo8KZwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfA2BdQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 20:33:16 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33211 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfA2BdQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 20:33:16 -0500
Received: by mail-oi1-f194.google.com with SMTP id c206so14880449oib.0
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 17:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJxRb0HvYg+SiC5NlgauEhjbhjnEqtqV8iD2DVOZBVo=;
        b=PKo8KZwdgiSCzRlpRXLJffcE4VJ+YxaX7bsNV7qefVjfxPAqhVEIg0A0AAC+LaoAs3
         Mq3KqkFOEl0hWBWFUte8T6Upkf1kF78CWC4tozp8q+PSb+mN5YWM1sMTii0bSTnml/Wt
         4G+pH+DV+FPMQtI5ruXonvn+vMOOO0Mrwxh1lb7Zpmq14s455h6zBH+oy5RnwCpcbccb
         g8+iHN7ObmKoxhP4C2w7pScjd9n1qoqWr+KLqch5JS8m17bRRHzgL/Y4GJopmtb17W1h
         Tul69qlQxue+JRYQ4GBdw9ZheUgVLrsu4OcBWaBylxapVylRO+9p7XxhyUgk3EBxNjsR
         ZDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJxRb0HvYg+SiC5NlgauEhjbhjnEqtqV8iD2DVOZBVo=;
        b=DiALAebqpIYVFnDKOosTElHg/R7zha6ihzgwsbyJRbWAVyjytMudcrTTMs4hCJcp3Y
         zRFl/aWaSYPH1hKy77pk8qmIrg1/f1ppxotANK8XJbmEhKTZ6vwx2zg4oT93V1da3rkc
         kxSIqXUOElpRfPV/sIVcr3Jq/SjVO95vfZVG83o2L1YqiwqomxhZHEbiSWKWUhzCkBmP
         S6VC+BOjEuC7zVACPms1D5MyTe2d0OQNARm0WzzhuRtpE/zWj0SmDKHL/kMeaSjE7lP3
         lW0qN3+udo8KJyMyONpLD0zNiv8nTt/nGHivXDAXV/DGmmwvLhq4N8wTA0jsbJvKT0KH
         rlpw==
X-Gm-Message-State: AHQUAubnYVkiJ2TuSgP9Kxzy9lNXNd/b9M6/2A1p72HuJoABvyAAvHII
        BA+dXD/c1IhCFyaWwnXaxjfEFJuEqFRqskJZUgYTCA==
X-Google-Smtp-Source: ALg8bN7oh0zVqsP0WyQ0+fm0x1b31OEXMuT9xxSKr76OlUo/BlYQ48lmlF7QF5jGRm9Zq9mZn1YIsEoD2Rd1pWcBxpk=
X-Received: by 2002:aca:c43:: with SMTP id i3mr8021303oiy.157.1548725595790;
 Mon, 28 Jan 2019 17:33:15 -0800 (PST)
MIME-Version: 1.0
References: <20190128213538.13486-1-axboe@kernel.dk> <20190128213538.13486-6-axboe@kernel.dk>
 <CAG48ez2gvgBUKNihnjEWeBv1WZiXWwfxcA2Wf90n8GHLket2Mg@mail.gmail.com> <9170f97f-bea3-04b9-71db-a0f250d1f610@kernel.dk>
In-Reply-To: <9170f97f-bea3-04b9-71db-a0f250d1f610@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 29 Jan 2019 02:32:49 +0100
Message-ID: <CAG48ez1NoSVeb19acpi4g2hP3Ft02E1_rOFir_qpsCtgXiSv9A@mail.gmail.com>
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 29, 2019 at 2:31 AM Jens Axboe <axboe@kernel.dk> wrote:
> On 1/28/19 6:29 PM, Jann Horn wrote:
> > On Mon, Jan 28, 2019 at 10:35 PM Jens Axboe <axboe@kernel.dk> wrote:
> >> The submission queue (SQ) and completion queue (CQ) rings are shared
> >> between the application and the kernel. This eliminates the need to
> >> copy data back and forth to submit and complete IO.
> > [...]
> >> +static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx)
> >> +{
> >> +       struct io_kiocb *req;
> >> +
> >> +       /* safe to use the non tryget, as we're inside ring ref already */
> >> +       percpu_ref_get(&ctx->refs);
> >
> > Is that true? In the path io_sq_thread() -> io_submit_sqes() ->
> > io_submit_sqe() -> io_get_req(), I don't see anything that's already
> > holding a reference for you. Is the worker thread holding a reference
> > somewhere that I'm missing?
>
> If the thread is alive, then the ctx is alive. Before we drop the last
> ref to the ctx (and kill it), we wait for the thread to exit.

Where in __io_uring_register() are you waiting for the thread to exit
before killing it? As far as I can tell, you come straight in from
syscall context, take a mutex, and do percpu_ref_kill().
