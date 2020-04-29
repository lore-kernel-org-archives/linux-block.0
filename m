Return-Path: <SRS0=GTSZ=6N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA268C83006
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 14:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB2362082E
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 14:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="hRK69Fjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgD2OGP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728306AbgD2OGO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Apr 2020 10:06:14 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2DFC03C1AD
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2020 07:06:13 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id j3so2728497ljg.8
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2020 07:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/5dFXvkHlFL4ZD9k3m+cudI2M3jreB1NrwloZ96EAJw=;
        b=hRK69FjpTSEspooL3pngL3RWCh2k42g9+qRkAdCL+irtc4FBd8usHLppdKZiUO37H4
         dVtIaQds7wIJpD4FvJmA66WsFpFfircv+CumTEfc64ZSOaC04mVKNMUiibqxvwXKlthW
         uV/x8yUF7yTSwotvszuUAYM3u62kvRUPdUhak5B9N3l1WIRWV5MaiV84IC2e8djDPvwE
         Yr8AcLkIr1KWLn53YcTtBcJGoRPGQ1Pqr7OnW/qaqaIkm3e2ejq+sjpqgO3w+/wHVZQ8
         3Jmoz2QNSIxgVhyhS7eHhnQ7OHVYaCMFrOcDADZh3gAbG5a3TT0Y72ntLo6SHcnf3IBB
         uj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/5dFXvkHlFL4ZD9k3m+cudI2M3jreB1NrwloZ96EAJw=;
        b=E7hjbC7/9UVVAEoUXFI2nF7V8zHh2FVI1yK8pNiET3YFVanwMcz5u1iYbb+3u+6/4w
         oZMlcKUaiQKTwyxg5dFF6y7wHDySP8cFL/Qa+aK3DzMw6Vhawpqc/7qnEx+FNhBZ4nKk
         GLrTR5jwcx1tj1cmk0It2ZjpRZbFQR2g/ftlmibPPhTfDy4193psaiDYou8WvPkKTFEG
         Q4Nc+nYRiX4f8C+16MrYw4bXkSCSLcBIq/7bCYZMXuRgn5M6yksMc7drZG+0UCaT2DxG
         ww2sZ6uMilIC0T/zb68gCLHgePtomkOM9v7dW086jtWNfV1tRrqD3gXOTmbUaWPz2Q37
         Aa7g==
X-Gm-Message-State: AGi0PuZHhkaONQizqCh81TZiDBG4uS88ApbNvFgFGmzN/OTZLX0WLmj6
        CekGdLfVCQpr9GCwiGnlGQSvueR+xDpGkHTmDnaHZA==
X-Google-Smtp-Source: APiQypKeyYViSeG3LDYxj8g69kihbk0QRE6mRva/Grt1UgVyN/1ZIYYoZXAzChs4XfsXoPtgXgLAGZsvsvLk5MwjgfQ=
X-Received: by 2002:a2e:8e98:: with SMTP id z24mr21704390ljk.134.1588169171856;
 Wed, 29 Apr 2020 07:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200427074222.65369-1-maco@android.com> <20200427170613.GA13686@lst.de>
 <CAB0TPYGZc_n-b5xtNsbJxEiqpLMqE=RcXGuy7C2vbY18mKZ6_A@mail.gmail.com>
 <20200428070200.GC18754@lst.de> <CAB0TPYF4yHwXTG2xb5yci9-KJiT5=VbwWz9yj+uyBwb2rSi8Rg@mail.gmail.com>
In-Reply-To: <CAB0TPYF4yHwXTG2xb5yci9-KJiT5=VbwWz9yj+uyBwb2rSi8Rg@mail.gmail.com>
From:   Martijn Coenen <maco@android.com>
Date:   Wed, 29 Apr 2020 16:06:00 +0200
Message-ID: <CAB0TPYEkuCe-z2nNDRadGV3ASFXdZ3OVcB16yZ4PnNc2cokHAw@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Add a new LOOP_SET_FD_AND_STATUS ioctl
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Narayan Kamath <narayan@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, kernel-team@android.com,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 28, 2020 at 4:57 PM Martijn Coenen <maco@android.com> wrote:
> and it allows requesting a partition scan. It makes sense to maintain
> that behavior, but what about LO_FLAGS_DIRECT_IO? I think you're
> proposing LOOP_SET_STATUS(64) should keep ignoring that like it used
> to?

I've just sent a v4 which basically implements that and your other suggestions.

Thanks,
Martijn

>
> Thanks,
> Martijn
>
> > and then in the main function reject anything not known.
> >
> > And then maybe add something like 64 bytes of padding to the end of the
> > new structure, so that we can use flags to expand to it.
