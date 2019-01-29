Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F37C282CD
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 01:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD142183F
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 01:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tzWclNZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfA2B3t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 20:29:49 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37132 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfA2B3t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 20:29:49 -0500
Received: by mail-oi1-f196.google.com with SMTP id y23so14835173oia.4
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 17:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=49FnojA2bt/A1VgJ2WpQ7kbGUvT2+/aDvOHfA3PJj4I=;
        b=tzWclNZVPxHCoe/9ReflX+KuP9CppsAjgauwbvQsOc/1Y/ZQNVnPi9qe6p/NFlyMwH
         TzxEKRTt0Jg4xsxpt3OsQR1MSJ5PwSJBiCYSMGHV63Y7GDKtzwfVJdHs4oGAo/ArOG8i
         /7wwHSZLqy/J0OBKU4Wh9m8ErvFGFoVfYbwX7cAePIPXV6oYMleee3BxcsOjdAEqUkod
         jHxT+8ztxhUeaYjv0yLqQpgNzJO/Fvi8i7CMcYGbMhN8GELTuS/f6LvtaGqIZQFFbo3t
         JOur85ynIWxm8QG8G2uJzaMyBZvBid0oCWcykx2iCNyyz8yrMkp9n7Rybnxd+rzyjIfO
         Qj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=49FnojA2bt/A1VgJ2WpQ7kbGUvT2+/aDvOHfA3PJj4I=;
        b=W/zXWYkNA5PHDU1wzrexfQ41AtYex7kAbgu+scboXETTBv0DFk7flVeWvCmdL5r0v0
         wfQnIV1+hEEjCw7qpXwbjObOTloJM3RroJ7fj7qEucd4YDMyGcrRCIEJHXOCQcIf++bC
         /d8uXks3Yuwy3icILP/s9ZqHqzPDRwhp4Vy6Qbb0fcOfdIyRTTA9gix2NCw7aiyxYNDp
         nVsOoR/V1sQZ58c+TcVvzLx3LyFfbH2jm+raONhIOHPOGLEllf/nxruSXK7olT/dh8fG
         V54uPXrTbZ4/fDnCGDznkQu4L4oTScxfFeU4d6pJ7q5ZDZUXDcDHwb2KE8nwb6Jw9mwE
         JXRg==
X-Gm-Message-State: AJcUukcjk25skYGDgdyqCIMmgSUpC1Sfien/78LiDgtatmWhxkhELlbK
        rExNgecJzr7EkLZnDs1jbilabDlrYj3TlZetO2jhTw==
X-Google-Smtp-Source: AHgI3IYEag40vEM5j6TkTvQO982PnOmlQyVbmy2bNshv8A/XtIabMbV8nQe+wfa6xBFh/M5tmKuzMnSu27qA33L5OgU=
X-Received: by 2002:aca:ad14:: with SMTP id w20mr7581212oie.3.1548725388414;
 Mon, 28 Jan 2019 17:29:48 -0800 (PST)
MIME-Version: 1.0
References: <20190128213538.13486-1-axboe@kernel.dk> <20190128213538.13486-6-axboe@kernel.dk>
In-Reply-To: <20190128213538.13486-6-axboe@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 29 Jan 2019 02:29:22 +0100
Message-ID: <CAG48ez2gvgBUKNihnjEWeBv1WZiXWwfxcA2Wf90n8GHLket2Mg@mail.gmail.com>
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

On Mon, Jan 28, 2019 at 10:35 PM Jens Axboe <axboe@kernel.dk> wrote:
> The submission queue (SQ) and completion queue (CQ) rings are shared
> between the application and the kernel. This eliminates the need to
> copy data back and forth to submit and complete IO.
[...]
> +static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx)
> +{
> +       struct io_kiocb *req;
> +
> +       /* safe to use the non tryget, as we're inside ring ref already */
> +       percpu_ref_get(&ctx->refs);

Is that true? In the path io_sq_thread() -> io_submit_sqes() ->
io_submit_sqe() -> io_get_req(), I don't see anything that's already
holding a reference for you. Is the worker thread holding a reference
somewhere that I'm missing?
