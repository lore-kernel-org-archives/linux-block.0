Return-Path: <SRS0=2P2f=BV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E174DC433E0
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 08:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B940920756
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 08:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="PyjA9Amd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgHKIbh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Aug 2020 04:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbgHKIbh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Aug 2020 04:31:37 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0D4C06174A
        for <linux-block@vger.kernel.org>; Tue, 11 Aug 2020 01:31:36 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a26so12202551ejc.2
        for <linux-block@vger.kernel.org>; Tue, 11 Aug 2020 01:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AiEVGPid6fNu3u2/+UVT80DrdCDFGK6L0AEhBU/401w=;
        b=PyjA9AmdtZwpDwiqa7CWI/1e1+SMXF8+PoPYnxb+EWmtB09hHtqNEQvDJYifVgJe5t
         0cFPEm+eCxvvj1bsdNVbLfH7NtIIwA3rKYKl2A5FFOCZ4kJiWSg8fVE6INjDmVGJcF1y
         J2Ga9RGRm1J0z4XX9b7ynr5Hat8fw2XHn3vLBeRcyBeWenHgdYIyFNe1/EeZV8EsdKpE
         M7BuOEI8RdlOuS6jNIOjmuUIvD4f5PGD9WD8VBBjLcY11WQnzu/4Jfows5e+WrVeq2IA
         cd5AHJRtDanuK+woC3qPsW5q279EOx7mKRPffQNO/cmfPrYf9bF50ajRtwTdZb9vWn50
         Y4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AiEVGPid6fNu3u2/+UVT80DrdCDFGK6L0AEhBU/401w=;
        b=rbLIJIvnN0RNVhVXW1yZolFaSiCHeCn5/MBVl3LnMFp1ytnJpRBalNMUUjT1xZ3sSE
         4omhtHehUl13jFV/giElkEE045k4FKIyU6W9iKAxjKbgvC1cWi4wBfiyIqaEgTuqWUpM
         4iYu/1/yV/PmVTn0rAShlxF+QJEhzSde5fjucy31B+QJhxhnf+HgzHn0NBzln9cQVdwn
         ALRVvZG5lBFbCEwS4aXfnW8hbAf2caqWvqkxFMOEiDhDutWBbaYle7rQ5w/h0S6zHg5T
         LxLWBTqELLjY+mxzgeDWSuDbCBj464xxvgh6j4Yfp1D8JMMyumYYuO0mLjr0v10pnffY
         2aLA==
X-Gm-Message-State: AOAM530x1jnnp2QKsSf71+trNJU9NJTlUGks7m/oTZqCqNlCmP5Y7mBX
        w+3ou+ZsQxXC6wGgyJifQtKaJWq09K0MzyPayuxKHg==
X-Google-Smtp-Source: ABdhPJzG73nvFfk0XHtVcnuCEDIBQb1M84nJWERMU5MRp5HyWBIMdmOdwokCmjSJgOTGZ+wm37iGEylpCzk4+KHjTP0=
X-Received: by 2002:a17:906:7a16:: with SMTP id d22mr25846663ejo.478.1597134695070;
 Tue, 11 Aug 2020 01:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200810115049.304118-1-haris.iqbal@cloud.ionos.com>
In-Reply-To: <20200810115049.304118-1-haris.iqbal@cloud.ionos.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 11 Aug 2020 10:31:24 +0200
Message-ID: <CAMGffEmN25PjoLVsWPbp7kVrCWpA-T8AMxb32zYtSVs=3Z090Q@mail.gmail.com>
Subject: Re: [PATCH v2] RDMA/rtrs-srv: Incorporate ib_register_client into
 rtrs server init
To:     Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-block@vger.kernel.org,
        kernel test robot <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 10, 2020 at 1:51 PM Md Haris Iqbal
<haris.iqbal@cloud.ionos.com> wrote:
>
> The rnbd_server module's communication manager (cm) initialization depends
> on the registration of the "network namespace subsystem" of the RDMA CM
> agent module. As such, when the kernel is configured to load the
> rnbd_server and the RDMA cma module during initialization; and if the
> rnbd_server module is initialized before RDMA cma module, a null ptr
> dereference occurs during the RDMA bind operation.
>
> Call trace below,
>
> [    1.904782] Call Trace:
> [    1.904782]  ? xas_load+0xd/0x80
> [    1.904782]  xa_load+0x47/0x80
> [    1.904782]  cma_ps_find+0x44/0x70
> [    1.904782]  rdma_bind_addr+0x782/0x8b0
> [    1.904782]  ? get_random_bytes+0x35/0x40
> [    1.904782]  rtrs_srv_cm_init+0x50/0x80
> [    1.904782]  rtrs_srv_open+0x102/0x180
> [    1.904782]  ? rnbd_client_init+0x6e/0x6e
> [    1.904782]  rnbd_srv_init_module+0x34/0x84
> [    1.904782]  ? rnbd_client_init+0x6e/0x6e
> [    1.904782]  do_one_initcall+0x4a/0x200
> [    1.904782]  kernel_init_freeable+0x1f1/0x26e
> [    1.904782]  ? rest_init+0xb0/0xb0
> [    1.904782]  kernel_init+0xe/0x100
> [    1.904782]  ret_from_fork+0x22/0x30
> [    1.904782] Modules linked in:
> [    1.904782] CR2: 0000000000000015
> [    1.904782] ---[ end trace c42df88d6c7b0a48 ]---
>
> All this happens cause the cm init is in the call chain of the module init,
> which is not a preferred practice.
>
> So remove the call to rdma_create_id() from the module init call chain.
> Instead register rtrs-srv as an ib client, which makes sure that the
> rdma_create_id() is called only when an ib device is added.
>
> Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Thanks!
