Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB7FCA90AF
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 12:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E9E20740
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 12:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="pT6qYxmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730865AbgEMMDR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 08:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbgEMMDR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 08:03:17 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBFDC061A0C
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 05:03:15 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w19so13421542wmc.1
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 05:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k3fs1BLKtzG099u3CgLy58/9ILkEABhBTm9A+LIuHXM=;
        b=pT6qYxmGM2SoowfqRAm4b6ZnL3452CJrFvZI/ZIDevCNNwTc9daFMYFtuwXvHt/hfD
         r3DVttTh8Xkmo1xktXm7NEQxIbmXapQ+fnlIIfltRZNF9fDGrXny/1bOfwJ6vU825oRN
         HDCHJwzMOs3UdZHxcdSacst1Xk+tH8bIm+kolpMWTGvDg+Tzw1+1tfZZ7eJruoEVyNXs
         lbkoAp/jGc9XmtEbTjDXG0I7Y4p20mzr3QSohynmWUDEeUHMzHKbNqnH1MZg1S73jJnf
         4r07ynb2UkmmMxF/zbdTer9AisCOZSLz0GNTjoG0VnJtfl7GtFpy6M1TxhbNaQh6l4LA
         kBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k3fs1BLKtzG099u3CgLy58/9ILkEABhBTm9A+LIuHXM=;
        b=Ko1FmXpYlLLx+eYaQRVo5J4YTeYdgmfpmEqJ+wnOEq3zbaAOQQu0htz9wj2v/Kjac3
         b/eAxz/dzeAVS66Xrw08T0VU7IsVa2YYs6GaosBG9j324GMjIUx5tkSNuPJ2omB8bVHt
         oJiisd7Vt0gbR2KtZDuLsidF3gy136he1cuzOsoFuVct7Lryg9VICN74aahQijI+ursM
         I1Bj9wzk0WR+wc74I/eP4BKqptuamH1vaRqtJ3JFMIN9WJc6X205WuqMnsdxXngCg9Jn
         b5aR65DJk5mL+leFMMusBVs+QRrW1NZDLm5boUPGDQHOy3yR5INQTkJ7HLR+wTZp4AkA
         BXlg==
X-Gm-Message-State: AGi0PuaTuof9eLgIxLFxGIVbJF8nOASHifm05UC71q0fiJEiWAtBSiWD
        Kxge9qD+8m1UwDwynZvrYScKQu7313h/VzXa32nBkHR34fA=
X-Google-Smtp-Source: APiQypLVIruiKQj5MuhzcA9Z8EW2j/28PcQzLLRZavdzT7l0kjnkHZOIDtgZxdFzMRDiltXJlgLQMWnUxNp/7s9gnjM=
X-Received: by 2002:a1c:b4d4:: with SMTP id d203mr33555929wmf.188.1589371394083;
 Wed, 13 May 2020 05:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200422090018.23210-1-houpu@bytedance.com>
In-Reply-To: <20200422090018.23210-1-houpu@bytedance.com>
From:   Hou Pu <houpu@bytedance.com>
Date:   Wed, 13 May 2020 20:03:03 +0800
Message-ID: <CAO9YExsLF_SveFp38yqz66HOtmM5xgRAFxLE88eqXJjitO684Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] nbd: export dead connection timeout
To:     Josef Bacik <josef@toxicpanda.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Josef,

Would you like to accept these patches?
(Just in case you missed this thread).

Thanks,
Hou

On Wed, Apr 22, 2020 at 5:00 PM Hou Pu <houpu@bytedance.com> wrote:
>
> Here are two trivial patches:
>
> Hou Pu (2):
>   nbd: export dead_conn_timeout via debugfs
>   nbd: set max discard sectors in the unit of sector
>
>  drivers/block/nbd.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
>
> Thanks,
> Hou
>
>
> --
> 2.11.0
>
