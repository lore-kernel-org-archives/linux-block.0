Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599F9C433ED
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 08:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C5C8613C0
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 08:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbhDFIWL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 04:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbhDFIWL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 04:22:11 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821AEC06174A
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 01:22:03 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id f8so11443739edd.11
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 01:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E5EweybTg7wEcTM54yJEH+iU0Z6FZkCHsU36oBWxVGY=;
        b=WaG28ro3OIJ3Eaiu8Dz4L+I4NqyIizFnp5JYuv90NYGgQOBiInqU12PPUQQDWpZY2m
         4RyIVM3k89zReEJF3aTmFKSruQVjFS4sErz6jKs3JKbLlN9iHwoFZcjfdI335ZZXrBm2
         OGeewBCFgaKqWsA4q8SX8xCBttbau5fi1Vg0v//SC+l3g9wlws4PfT/r9M91gK2gFp/V
         iNw0vX+JphX4EbY96HY7hjoEZ+JXWeVW0mCpZjry/G1cBeP6JsSJuVaZ3PCvmqzCAjY2
         Ov2LLMS7mcHAfewTTBzn5DrLcLJ/zW9bsN3XfSqusXdblrjupqdBxol+UW0EVD1L0IqF
         JR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E5EweybTg7wEcTM54yJEH+iU0Z6FZkCHsU36oBWxVGY=;
        b=LCV8e7zFWBLUFMnzYO/yHxVrWrw/aZuZvWzPpcPY49Ca96bE6vioBxySH3lTvKeqeb
         WiDitHJGO41gnl2KoOkI5GmEzu/HdjBaqINLP4z7C+gvki5Bz/R1A/ntrFAucz9Xggp7
         it6doNBWSr5agXzlLV7iunfO3eIxfbRJv7ONN19lLuoZZX4KDsmLU/Sbu0SbTBnoIagi
         B96qr2Fk0QOO0/7X/Nc1YsiGLcAEflUjgcaNDjzGeorVNcMWSkR0Y5JJYJXFFmHNqM6p
         no3Qgs93zuq1OEFQxdsY2eMbb3vZlmLcBAW9g+dl0xOx7uxK3zIg8LANeMNHnvmlriic
         oh2w==
X-Gm-Message-State: AOAM533uoV8C/92lK9fDX5DYr6H1aYXfLIz4i4ahHpXhJRKm3lzhsXd/
        BC4hbtuAYOvlvJbdaPtY2zACAOAnXspm1ltkK4rcCQJ6IW7AJT6Z
X-Google-Smtp-Source: ABdhPJwluymCHKHsQH6kgsNUx2GYzOTJlHYn00T8Zxl9d+v01eDId2TmRUlobfL4MPNUZedlW2NEIdLbAqqQrI+xz+Y=
X-Received: by 2002:a05:6402:518b:: with SMTP id q11mr2001062edd.151.1617697322222;
 Tue, 06 Apr 2021 01:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210406070716.168541-1-gi-oh.kim@ionos.com> <20210406070716.168541-8-gi-oh.kim@ionos.com>
In-Reply-To: <20210406070716.168541-8-gi-oh.kim@ionos.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Tue, 6 Apr 2021 10:21:26 +0200
Message-ID: <CAJX1YtaFtyb_5mYxmG2L=0hStbk_rALOD7feTmLA+ZRPr8zwQQ@mail.gmail.com>
Subject: Re: [PATCHv3 for-next 07/19] block/rnbd: Kill destroy_device_cb
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, Haris Iqbal <haris.iqbal@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 6, 2021 at 9:07 AM Gioh Kim <gi-oh.kim@ionos.com> wrote:
>
> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>
> We can use destroy_device directly since destroy_device_cb is just the
> wrapper of destroy_device.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
> Reviewed-by: Danil Kipnis <danil.kipnis@ionos.com>
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
+ Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
