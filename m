Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DADAC56202
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 08:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3A7120DD4
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 08:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImJmIvHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389043AbgKZIzn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 03:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgKZIzn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 03:55:43 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EB6C0613D4;
        Thu, 26 Nov 2020 00:55:42 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id w6so1081234pfu.1;
        Thu, 26 Nov 2020 00:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bnO6NVqMPcFA+LEbenqKqiGTKjx8AwNGtIbzzcNgtlg=;
        b=ImJmIvHhPF0dDO5+yUICHcW09FugJIcBJfBpykhw96jB8k/m7z9gyATnS5v8cUQfiM
         Pkhc3tuMCUAe/xh7fn2FUrL7v3CI0RgWn5BkhYfOEyBd0hpVvOltTTElnRD3wB+irxka
         mhUVV9hMEsg3uxyYNKAoFH1LyVaNgN+KFUjQZ7DhlBvsK8Q2sG6dAdcEnr21gIzpm0tB
         vx4FDok+8DSihmpKhkC/wsHRhtxkPyUOUEy/rWWyJpa+3UDwJ/0DJuAQjZUVs3EBIMWr
         NsDpzH2tKqx0ePFaEiX6jooXGs07EQDLdUnbWvy5ZegL7pYrNiun9xSqwL5413kR+SXt
         C1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bnO6NVqMPcFA+LEbenqKqiGTKjx8AwNGtIbzzcNgtlg=;
        b=ace12jr5OxG60FVpZhpF/WYXo11r2IoY/0A3PBl/dT9QmVepOFRBPiIoMiizqlvyXE
         LnTKA58AMTey+lTRA2DTdQaaZrYcFXu+aNlEcCy8qrBf07F40tmUFMZFBaxumqDJeZkp
         p1GEfjB+Kj+lZYQ+f967E++8jeedgKEt+a2K8VarxGG4iPucDYfn14ywDG7bNgZHP0MX
         EEZgjDho8uGmq3il97nIbGQsNRHuXriE4vgRBQ2KLAiU0X991KMfYRgqPuhRXr0W1Lia
         /acugQck1XgeAO+hJjndx6F5tH7hd3YzcJ0cmlZ9O5HcshvA/Zrrsn++41Pf9uQ0/wW6
         UY0g==
X-Gm-Message-State: AOAM533/jVbbR7/QRolRGw0kxCdOXslEcDS3nwdODJT3U8ygqpGWRwd/
        6PZEF8ws1Kbjq81rUoGltGzeiD7DjEd6OUwCww==
X-Google-Smtp-Source: ABdhPJyvXVB6LJ7I53IhuqhWqqufw40lN2NPeHRGteuWLEj4VoEw4bpfzJEZDVhslxRO6sJUhE4fU7Uut/fZk5bHky4=
X-Received: by 2002:a63:a1d:: with SMTP id 29mr1802020pgk.162.1606380942463;
 Thu, 26 Nov 2020 00:55:42 -0800 (PST)
MIME-Version: 1.0
References: <20201122095051.4819-1-rsalvaterra@gmail.com> <20201125195608.GA1484898@google.com>
In-Reply-To: <20201125195608.GA1484898@google.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Thu, 26 Nov 2020 08:55:31 +0000
Message-ID: <CALjTZvZgK8mx+9-VCrEpGpAyZC8mx-e6jdgv9Wi0y7CiYBcroA@mail.gmail.com>
Subject: Re: [PATCH v6] zram: break the strict dependency from lzo
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 25 Nov 2020 at 19:56, Minchan Kim <minchan@kernel.org> wrote:
>
> Acked-by: Minchan Kim <minchan@kernel.org>
>
> Thanks, Rui!

You're welcome, thanks for the patience! :)
