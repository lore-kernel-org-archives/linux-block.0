Return-Path: <SRS0=bgcA=6B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67651C2BA2B
	for <linux-block@archiver.kernel.org>; Fri, 17 Apr 2020 00:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F4D9221F4
	for <linux-block@archiver.kernel.org>; Fri, 17 Apr 2020 00:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jgottula-com.20150623.gappssmtp.com header.i=@jgottula-com.20150623.gappssmtp.com header.b="TzohkwjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgDQAxG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Apr 2020 20:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728454AbgDQAxG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Apr 2020 20:53:06 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8587C061A0C
        for <linux-block@vger.kernel.org>; Thu, 16 Apr 2020 17:53:05 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id 74so77741uau.11
        for <linux-block@vger.kernel.org>; Thu, 16 Apr 2020 17:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jgottula-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QXpaYcM38eFB67KwCt1Jc+C3DFRaou4chRNhAdr9Drk=;
        b=TzohkwjGPu93u+uoaV1E/xBsqITd23SUw2sElHtGpNG3AIau0zjMyxDcJ8oAwIYWCU
         BtqS/oikJfPV8Yj8A+WI+zPJeygqHyTf2+6hF0gR/E7sPiJdXSO3rYm102WFfiQxfahy
         ZycsZkbCTwkSf/AkanunUMi83CynOLyrQ25vThm7Tdtz3wmr7P8Ddnvs7aU188kV4KZs
         gt9smKRa0bNqw8bVfycQHBD+JlQlvT/mETDCug1Rq2aykKxOpSPvWIFl9w3YP1Hn7UA8
         chi3yjVqQnPx0jZAMKIfv1Tl7y+hUNqVUMSxE8o3WA7w845hdO7IPKrMmHKoTF0ZBMvZ
         3oGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QXpaYcM38eFB67KwCt1Jc+C3DFRaou4chRNhAdr9Drk=;
        b=ke1vWGZUCtF5/XNhvRn5WybELaTFXlf62AKcFTUirE0yDv9kMmx/Zo/oVZ2J5iPgMS
         2z/Yt94xlsymwQuUG0GzzIKC1XTFgdHqX3FLt2dr4/WXecomh1MoeozvfDXLhcU/9cQM
         MpKwiank3sEh0Z+vOjZIfropC73QzycEHsp1Uh/+1wrKV/viuPnaPSWrW2CroRewaYaR
         iqf0qgqhYJKhU/I9ejIt8M9J5YutEFXT76yZaKezy+hbrlf9Xb+zYtOik8+gQUkYEm3D
         WsPBYvsUIMlfrRZvMftxgB0iYkHCNZLhuR+tXHVg9WN3hLXgHycb2MTODn/qHpJ7MHmt
         FmZA==
X-Gm-Message-State: AGi0PubaENMQ2s9hWd1If10zE6Yz9ruAk1MqKbLzGyH1ZP8IGwIh/thU
        T+pUMJxoAPlmYtOQyNm1mu6q020p2xOkCFuoy0CkzA==
X-Google-Smtp-Source: APiQypIjQeD0xbl0pQkYtPwJq9AE4eIXIMTcKwyOgHP/M2El9rtHAOyIzpwWPtBZinQy+KY8nlq4hF1xffnIsgkQwRA=
X-Received: by 2002:ab0:29da:: with SMTP id i26mr558953uaq.29.1587084785007;
 Thu, 16 Apr 2020 17:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAKuMfTUPzPjuNk+T_GQMCKoB9ssh2arr6xRiu6VODwwB0PMdZw@mail.gmail.com>
 <20200416214649.GA60148@google.com> <CAKuMfTVpaetB0qQ_hm8cSowtZN8HUKXdADWhKXC=4eKd1i5oSw@mail.gmail.com>
In-Reply-To: <CAKuMfTVpaetB0qQ_hm8cSowtZN8HUKXdADWhKXC=4eKd1i5oSw@mail.gmail.com>
From:   Justin Gottula <justin@jgottula.com>
Date:   Thu, 16 Apr 2020 17:52:31 -0700
Message-ID: <CAKuMfTX3PW8FgpGyp1g=CZm4yC6pQ_MK4LFmBoin2zCTqDF0xQ@mail.gmail.com>
Subject: Re: [PATCH] zram: fix writeback_store returning zero in most situations
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Nitin Gupta <ngupta@vflare.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 16, 2020 at 5:45 PM Justin Gottula <justin@jgottula.com> wrote:
>
> 2. There is a bit of a predicament with the keep-going-even-if-an-error-
> happened approach. [...]

Oops. I meant to also include this in my reply:

I suppose a reasonable way to address #2 might be to condense any error(s)
arising from submit_bio_wait into one writeback_store error return value
whose purpose is to indicate that the backing device itself had some sort
of write problem(s).
