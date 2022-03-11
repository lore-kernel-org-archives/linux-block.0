Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3733C433F5
	for <linux-block@archiver.kernel.org>; Fri, 11 Mar 2022 22:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiCKWrG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiCKWqq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Mar 2022 17:46:46 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F342DBB83
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 14:37:03 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2dc28791ecbso109149697b3.4
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 14:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DREXPNc2JSl0V5RZY2vCdvrUUa88K+pQUjqT8ymWxMk=;
        b=O5Q8bxA/KkmDCq6uqRmKbEj/kc8mUESHJC5dAzxPo/3xd3SdDKMrP2QVqRMCCgr3TH
         MocubDdpCRCus/XBr2Ilzqbxokz5l8MQJdMGCOleXY7keRw5WHYICMvC770ECBYk43MN
         jBs9nx1C5E3cOPY8PUqY1eacT+koo1SGbBuuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DREXPNc2JSl0V5RZY2vCdvrUUa88K+pQUjqT8ymWxMk=;
        b=7QklI5bEAQvGhqsKhxpqKJugNNV3I4wfVPMGFxB9kc2eQ/pt5o1sc1JQgMiBUdW9Vx
         64tzjbCySeIziGIChlrVg6s1Rhd848Ed+apRFPhx2XmAIubTyjIigc01R2gVNqrdEYBp
         ZAS+NrwQFS9X5/SPezIId+zAQLghEdldXOZJ9VPdgbjWfIe4SaHBWUOfa1hJjJuVoGeZ
         usI3Pb79T07QyN4L5fDerZGXrzT0stAs39WpMedgOC2KiCnhMG1xQRMQ/TVG4WBzgxLu
         1WyTiPLGxy8jQRUYKFsK0vt4FClIV/aemd+DVAsrTUDmTQFf8dGe4Xq/qnmy2DTiqidv
         080Q==
X-Gm-Message-State: AOAM532+6h9gFImcMKsBha4VneVJdEubKKHu/uEBeAyTivrj2yU3c8JW
        /3Tex72IExzhNVPTQxQHYKfYaNOqQeEUyIO0MI+/AA==
X-Google-Smtp-Source: ABdhPJxD9C+lmjCFUuGqD3d+t0UpXnibKp2g1hAFOkt/GuhNL0o7REY2rjJEqu0+69tDgnz526pRiNrNgibT2VMGHTc=
X-Received: by 2002:a81:74d4:0:b0:2dc:5a9f:c830 with SMTP id
 p203-20020a8174d4000000b002dc5a9fc830mr10697375ywc.32.1647038222492; Fri, 11
 Mar 2022 14:37:02 -0800 (PST)
MIME-Version: 1.0
References: <CABWYdi2a=Tc3dRfQ+037PG0GHKvZd5SEXJxBBbNspsrHK1zNpQ@mail.gmail.com>
 <CAOUHufb=GQaX_2Bp2YfY4ntBZj8iwb8z9mvxUFXw+KkySRu+KA@mail.gmail.com>
In-Reply-To: <CAOUHufb=GQaX_2Bp2YfY4ntBZj8iwb8z9mvxUFXw+KkySRu+KA@mail.gmail.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Fri, 11 Mar 2022 14:36:51 -0800
Message-ID: <CABWYdi3iJ45pSgj-OrxATVXR7-MHb3DZ-UkERPvo9L=h_qtzgA@mail.gmail.com>
Subject: Re: zram corruption due to uninitialized do_swap_page fault
To:     Yu Zhao <yuzhao@google.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 11, 2022 at 2:30 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Fri, Mar 11, 2022 at 12:52 PM Ivan Babrou <ivan@cloudflare.com> wrote:
> >
> > Hello,
> >
> > We're looking into using zram, but unfortunately we ran into some
> > corruption issues.
>
> Kernel version(s) please?

You can see 5.16 in dmesg output. I've also replicated on 5.17-rc7 and
5.15.26. The latter is the LTS version we use in production, where
coredumps and rocksdb corruptions were observed.
