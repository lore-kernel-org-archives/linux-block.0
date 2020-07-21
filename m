Return-Path: <SRS0=rrL6=BA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F329BC433E0
	for <linux-block@archiver.kernel.org>; Tue, 21 Jul 2020 15:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C61572073A
	for <linux-block@archiver.kernel.org>; Tue, 21 Jul 2020 15:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSi1poIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgGUPEJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgGUPEI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jul 2020 11:04:08 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732E0C061794;
        Tue, 21 Jul 2020 08:04:08 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s10so21480750wrw.12;
        Tue, 21 Jul 2020 08:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bm7aGTjf92tJ8OWCzSg3iBTJ12cgcD8em8JxJYzvaT8=;
        b=XSi1poIhxWMJAMst+GBhdNWiuBoXY8yLX9OLK33R8Z/fURwYpxWpwnx4X9ehyNg4sZ
         TRa7QH3gk3RCeUBbQxEfU79P8dlymBNlzLjzolU5VGH+N6Jk8EVGzSdLEkbD1fBlDE+f
         6hVcgEGMtQftNrWBHKg5x9gloCmPpFjx1GJwaAvJuryCLV1cRlr0nfzmZ+htyHPg3U2K
         SimyQvgWN1lwTWZyDJDdDYlsCZ39fCoVuW9kE1kPdg3z3UeqewtKb2U0cZFeqGk+27kd
         Lzh4Z16yEB33svlhj7MDJ9N7x2lDxO9ynG18slxOPvF43oK1MUBaJs7T9fwoOIgz7d8g
         96kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bm7aGTjf92tJ8OWCzSg3iBTJ12cgcD8em8JxJYzvaT8=;
        b=abSch8MMkO/FTclXq8IsBEOLq7Lgyy76OseCEEPbobEHS+Y/zH8hrlqnMESr7DxgSB
         o1AwwwQjufhERBnlbOhv1WPk5fb6Aqa6x/5Xr8CJZkLpxCUWDmDGbauNu8/hzin6mpRp
         Y0K1rfZakRz09SWqsklU7R3Vcv4SJ+3M1/cFO/0ujoN5psTpSv6M8dhj1uongMoYsrmr
         pxBhuuHMVaGWtfLIbDpRJtyIYfQbQs43F8sV7ouu8HteWmUskiVRS9oDwtQ7cit6ETuX
         31KzyIx/55S3xjRl3b9reMJV2h/2QCrf7zwlYghbJ/EieYQ3b9uKcPBhZoSXfi2PjAZq
         1jRA==
X-Gm-Message-State: AOAM5339BKPuyftO1AgNxNwWbx11lkg7zrgcN+CkyqR/ViUcVprJDA8d
        Me8H+ldPfbTFlv/gjN0JSkCCqR91JjzHXYXzce5gWBGG
X-Google-Smtp-Source: ABdhPJzk4KDC3d8HohEKBxvMFgcJQnEMPvrUyHemUKAHXXR/CnoptPSfhMW4u6qYSvZAK0dKcj1F0ipwpkAGw9RTJbg=
X-Received: by 2002:adf:f0ce:: with SMTP id x14mr25948565wro.137.1595343847088;
 Tue, 21 Jul 2020 08:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200705193332epcas5p409173a9d12f203d3817305dd3250ca59@epcas5p4.samsung.com>
 <1593977393-21446-1-git-send-email-joshi.k@samsung.com>
In-Reply-To: <1593977393-21446-1-git-send-email-joshi.k@samsung.com>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Tue, 21 Jul 2020 20:33:40 +0530
Message-ID: <CA+1E3rKP8nXDQc+Gz999rdCKhhsxePowzg0J26q+N2QhMF+Q2Q@mail.gmail.com>
Subject: Re: [PATCH v2] Fix zone-append error code
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Damien.LeMoal@wdc.com, Kanchan Joshi <joshi.k@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,
Is this fine to be picked?

On Mon, Jul 6, 2020 at 1:06 AM Kanchan Joshi <joshi.k@samsung.com> wrote:
>
> Changes since v1:
> - updated commit description
> - added reviewed-by
>
> Kanchan Joshi (1):
>   block: fix error code for zone-append
>
>  block/bio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --
> 2.7.4
>


-- 
Kanchan Joshi
