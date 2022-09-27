Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27679C54EE9
	for <linux-block@archiver.kernel.org>; Tue, 27 Sep 2022 08:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiI0IUC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Sep 2022 04:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbiI0IT4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Sep 2022 04:19:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1F4A0317
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 01:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664266792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R5pq+5nPQ5CuaOOvu2/KImvR8H/JJJEgdviRtRkCx0M=;
        b=M/qPpBJ2AMOco3lvlubD/tI+KjkpbA2IfMj4W3JgfYFn5ptXN8gTQG7NjMwVn8QisReh1i
        nQAbPq62nVM1xI/DuVKR3NY38qP9QQGvYkSVW7pdfHFhFNYuk0jcO2ePDuIX+magzy12g6
        Qk3VjPcqD5PWrzg+Mj9PksKM5/rHcIw=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-219-cYwngmtbMhiYmKXnUs3RNw-1; Tue, 27 Sep 2022 04:19:43 -0400
X-MC-Unique: cYwngmtbMhiYmKXnUs3RNw-1
Received: by mail-ua1-f71.google.com with SMTP id y10-20020ab0560a000000b003af33bfa8c4so2247840uaa.21
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 01:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=R5pq+5nPQ5CuaOOvu2/KImvR8H/JJJEgdviRtRkCx0M=;
        b=7w5YfC8pdi5QzSlHMKTywELqmEzUhuNi7EIeqdNVxF/9AZGRwKaH0h+0zT1e2coZFb
         i6a00NuPyHSfnbrlqVi0nuDtnn9BVK9xU2Y8IewrxgmL+mHNnosIVTyMopYaNxatJcbE
         wTHg53aY9kLbu3q6YaM7QbDrUd5Nv0pRjPlqAlJLc0FV0artAkIglqChxessHnclaGDw
         KRugqqddgg4n5nPfeH0n2dBdYeH+DEXiyrlAcO0QitUhBoZKnafq0v75aTAwAWDA01DL
         4wuw8vtnhqTxnjQkBS+Y+bE5pPMypx/0A+ZXGzrLrmqDY+SrKomEBmN1X+hGlu1zP35U
         BmqA==
X-Gm-Message-State: ACrzQf1XnMK2mAG2pvA+lBzZh98ezPlenZGX3pYtk/ODqf7h6xS/LPut
        ia7oUbdRrxOMZfxHaCMO6Qn5BRKVI0+NkwoS0JqlJxlZaU8SXBszvwv85Gm2u94Q4WVcZIpc4Kd
        ducpR+ZaNsb3dIj8nHva+ZaRhTDYgwyvoQVSN5+Y=
X-Received: by 2002:a67:f118:0:b0:3a5:662a:b5de with SMTP id n24-20020a67f118000000b003a5662ab5demr3967026vsk.54.1664266782866;
        Tue, 27 Sep 2022 01:19:42 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6tKVYgkiTVlwD9anc1aSfrSCK/NUtpiAxXZwjJoltzGjtJDNo1C8CbtN8ZsAgmAqnGKvdSYSOjQWBvdfIEZtk=
X-Received: by 2002:a67:f118:0:b0:3a5:662a:b5de with SMTP id
 n24-20020a67f118000000b003a5662ab5demr3967020vsk.54.1664266782679; Tue, 27
 Sep 2022 01:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220926210702.1776648-1-kbusch@fb.com>
In-Reply-To: <20220926210702.1776648-1-kbusch@fb.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Tue, 27 Sep 2022 16:19:31 +0800
Message-ID: <CAFj5m9+r=bxD21m=RPPE-T_ysxMwjDqdcPXvTAeMLwzGYWdzMQ@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: use queisced elevator switch
To:     Keith Busch <kbusch@fb.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 27, 2022 at 5:09 AM Keith Busch <kbusch@fb.com> wrote:
>
> From: Keith Busch <kbusch@kernel.org>
>
> The hctx's work may be racing with the elevator switch that occurs when
> reinitializing hardware queues. This happens because the queue is merely
> frozen in this context, but that only prevents requests from allocating
> and doesn't stop the hctx work from running. When swapping the io
> scheduler, this leaves a race condition open where the work may get a
> pointer to an elevator that's being torn down. Use the quiesced elevator
> switch instead.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

This patch should fix one kernel panic when running stress
test(elevator switch vs
nvme pci reset/scan).

Reviewed-by: Ming Lei <ming.lei@redhat.com>

