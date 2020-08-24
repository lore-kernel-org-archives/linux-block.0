Return-Path: <SRS0=iUg4=CC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47211C433DF
	for <linux-block@archiver.kernel.org>; Mon, 24 Aug 2020 19:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E06B20706
	for <linux-block@archiver.kernel.org>; Mon, 24 Aug 2020 19:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Es/OR0qt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgHXTrD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgHXTrC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Aug 2020 15:47:02 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7EAC061573;
        Mon, 24 Aug 2020 12:47:01 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id u126so9959274iod.12;
        Mon, 24 Aug 2020 12:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=plOSeJr9JbCX/G7XioOegDbHP0AUWpDmZ+AWPNX08Us=;
        b=Es/OR0qtgjM2R2DENxTrthzTAgIsD/sruK0Tr3HWZIiM0DoftVL5QVAGhH+k8oaPRN
         oCycgNP5ueJMyg+Bm6i6qOsxxMJwm1F52m/f1P+l/djMEjADyaFr1L7TnTcJ/zLRB7LK
         4WkpTkNd/b405luQUa+Y+fAGNHEHXnIdrX2D7+xwwPGaH6YkVLB1IPdQZZRdLu+dEqfC
         NpCwdxTT4W403uS5yG31z88spS7F2ozRVIzv9VyIISKMPMsm/mU+d0GyPaS/TM3Zzj5I
         QUUEz23TleayixgylvRtnZUN8WY8Om61UR+xFnwQgMFfoJ78z0QN2mHYXRdRF0jC/+m5
         mCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=plOSeJr9JbCX/G7XioOegDbHP0AUWpDmZ+AWPNX08Us=;
        b=MpE9D3GMlVBWQextK5WcEopJhhUnSYNXC/2S3IP0CJl6pkBo9+PZQkwzXBKi0G9ZtG
         OV9dtB4CivumP4Pdc3+7Dk+HZziUP9rJWSnF8QrdqGXok0VV8n/Ik1dfPuYsOhzJLx51
         Io1HYS+sY/5UpbgkAjy4ju6LLob4kjj5lsZtzYrxxSMyYh3EafwCCLUAe2PvC/id+F2o
         hYIdikWDAy+gs7myq7b1G3AbiYOiXW7Bloll4wUrCZg/nq9JARZb7wNuuvZSOJBbpYuL
         ht2NZc7C/ExdJ+59SFZjW5/fvxQtIaP3TgFfJr9KgRN/Cxv4XcNwil3STi+5MtzwZmMV
         BYhw==
X-Gm-Message-State: AOAM532gtqH1t4Q3xapv10RiXYv8XUgN1eXRwIEw1iHZMk7gCZI3ccUS
        PPULOgJs0Kxc6EYsDA042loREWiDp5b2jfkZWXQ=
X-Google-Smtp-Source: ABdhPJxjYySwG9/BUPn1SLcKwSHwTAPktAHj14wvLTMgcIqp2PPtecTZoMb4k1u3VzVGzY5yfm9cDmq/Q2q6QbrRfrc=
X-Received: by 2002:a02:82c3:: with SMTP id u3mr7153952jag.81.1598298421260;
 Mon, 24 Aug 2020 12:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200824194322.337375-1-ztong0001@gmail.com> <3b904063-ca08-092d-a861-e1c80d511ab1@kernel.dk>
In-Reply-To: <3b904063-ca08-092d-a861-e1c80d511ab1@kernel.dk>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Mon, 24 Aug 2020 15:46:50 -0400
Message-ID: <CAA5qM4BMSqy=xeJr=qyWHs_TJySpEgoTgg7H66Qu24mkKzwGwQ@mail.gmail.com>
Subject: Re: [PATCH] rnbd: fix uninitialized variable
To:     Jens Axboe <axboe@kernel.dk>
Cc:     danil.kipnis@cloud.ionos.com,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Got it. Thanks Jens.

On Mon, Aug 24, 2020 at 3:45 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 8/24/20 1:43 PM, Tong Zhang wrote:
> > variable err is uninitialized when bio is an error code
>
> It's fixed in Linus's tree:
>
> commit 17bc10300c69bd51b82983cdadafa0a7791f074e
> Author: Nathan Chancellor <natechancellor@gmail.com>
> Date:   Mon Aug 17 23:49:25 2020 -0700
>
>     block/rnbd: Ensure err is always initialized in process_rdma
>
> --
> Jens Axboe
>
