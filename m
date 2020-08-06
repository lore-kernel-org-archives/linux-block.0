Return-Path: <SRS0=mumx=BQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C898EC433EA
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 11:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A384D22D05
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 11:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="DHXI5gz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgHFEue (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Aug 2020 00:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgHFEud (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Aug 2020 00:50:33 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7DCC061574
        for <linux-block@vger.kernel.org>; Wed,  5 Aug 2020 21:50:32 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id kq25so35880559ejb.3
        for <linux-block@vger.kernel.org>; Wed, 05 Aug 2020 21:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K8jVEF988AvgAe7iTq/dbJ5q9bsNo7gb9zMavBuVMlY=;
        b=DHXI5gz6mfv9ZyVVeOTJX5bEkeQEOyDznKVdS0SEqGVKjh1KT9kKFQiZNeEi8qDRxZ
         6fXqax8f2aTvMYFiPHyA/GXtkOIwdKmcFNUCvNVxmh+JlTbqpn01I7poVVLgTvN7d+O9
         w6JqTKr/o+t7U+N/a0TDyRXwad9JwSU3NkJHS/FYIwf4WTa4uvIT9J1Odls9to2JWWUE
         +CWO/ERClLP0s2bme70Npq5BbpDB4Let7URqglG33+gDZCxkj/0EtdmFXQ0r/cm4foBH
         BpQ+2xGKtl/Jc7PZ9sX+gWwdsEx+CZCw5OMpy0t1K6sImSLuhqArOXlGMTbg0hfSOchf
         RUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K8jVEF988AvgAe7iTq/dbJ5q9bsNo7gb9zMavBuVMlY=;
        b=ehInljSHc3FnGobBRZDhyNfZYYYXjn+I4C4DFrmlPB2P4PaDLnSFCyvqxQMzKQz55g
         E8ziDRaYOHb3YngISw5T02r0CQZGvG6GtCsMRAejQZcfAVPS+BxOIMKhQO7OBE7rF1oO
         2NMI1Z4Eyzsc8hz+nFR/Kzwz8cpAVTKnr9nnGhuNoXvJ1VsBlGQ3fvzOblE0S4CIx24g
         hOgscJb4vTSHYbIUzfznJFuQ+o2U3AAs9fdPOpCouYzhRjRfW1DJjLN+jae0ikJMBNKZ
         +X33VVN6XgaGvYGVJgX886dnt90USCKwACkr0Qvo0XZUnRbah4R4oH0thkyhPiq2mHge
         bvMg==
X-Gm-Message-State: AOAM532sNX1otL/CZyJqUjNrCLEWa1EaPMcelP309knLG9Fni7kH2M8e
        q3tm/62nEjA52j1i3gifrvxdwkOCuwIx11EBd4KZ1Q==
X-Google-Smtp-Source: ABdhPJyZHXdvhgF7dJ/9AtUiQwLZUn3n+G46wOOlmqC1WMfC4oeqKRgULimRAE9ereXd4yf4xaXeiOOoGfTgMLlIiNI=
X-Received: by 2002:a17:906:1589:: with SMTP id k9mr2502402ejd.115.1596689431224;
 Wed, 05 Aug 2020 21:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200730091358.9481-1-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20200730091358.9481-1-guoqing.jiang@cloud.ionos.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 6 Aug 2020 06:50:20 +0200
Message-ID: <CAMGffEnN99YWokrQikrWhSUqS1GGA1RLSCQ0-ZCK4Y2B6qLz8A@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] Two patches for rnbd
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 30, 2020 at 11:14 AM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
> V2:
> * add Acked-by tag from Danil and Jack.
>
> Hi Jens,
>
> Could you take a look at this patchset?
ping! Jens, can you take these in your queue?

Thanks!
