Return-Path: <SRS0=+SaT=EC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43AAC388F9
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 08:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FC2A2224E
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 08:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHqyU5Na"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509108AbgJ0IkX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Oct 2020 04:40:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45278 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2509041AbgJ0IkE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Oct 2020 04:40:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id e7so483961pfn.12;
        Tue, 27 Oct 2020 01:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ZiyaeUHjFYAo8O2nb9YsSxiVAxNu61UHIsbR2dmhM8=;
        b=DHqyU5Na/jfu0CgjXEBRZ7QpVnSFuOgsccPtxwmB+XA4WPA2U6F0rtyb58Si36ekQR
         C8SPIVYvHA195OL3/laP+QorziaeN/NjA9qyj/tUcbgpyp8cbTwATo/BsjUmPx2S1iL5
         +45ITpRLLFFLySIo0H41QoOZYK7NennGZSd5yifnZ33dVvEV0XtPWHsPVQcGCqro8xyC
         3AwmU70/AsdKxVXFcYoqnRZEDCW/dP1qbMenGD9WtodVtAQEGDc8gC8xg+xfJBTq/Cx6
         D3IacEV5Qy7mGMgQjtZomJsTo+IGhvwEPuq6AujAcNy1lWj3WpBD84k6gaa7iWtFKwkV
         OOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ZiyaeUHjFYAo8O2nb9YsSxiVAxNu61UHIsbR2dmhM8=;
        b=b60d49JD6S6tes0HjdG2KLYJaU9xjixDphPHHMYAZN0WFhJbMVJ2EqcSihUTQcEnrS
         DIR5qRyJqfcKnRKP7PzHdqDCeb4Oqr6ZBdGA9XgxEK1VcAOLyd982QxO+NllwNoAvTz9
         WOSr3z3CPI0NCLeNB8qd1wI3QcZWvMO25WPAwolzWDeKHe6TLSeUTZEnAFEt6UaPvtUJ
         YHZDg8N1q3TzJS361XwpMoNdgJDxUN7bss8GvjihgXGF2NlN4W3IQhGPlv6TXYRYlFA2
         bwePCy0wie6eiegVxYoKojGG8WrQc4Kx63ncuEuU4zIbooNUIQe9nzRkHUybePVNZRsN
         xSSA==
X-Gm-Message-State: AOAM531+Y8WfKVAiVXxKEmYj7OC2UUywsjWDWUBwMf62k2q2kzCTlmek
        dUzQ2KdWftiXdePPFsfPaFlqTvylzQNR+pFoI1QFHbw=
X-Google-Smtp-Source: ABdhPJxxCmUA25gVUIxPmAa6W5aLqGOF6/2FnS/2HGGle0o+YkeMtP8HdkFdpXf/etcGVUa6ceI10ZWUue2a0n9pVX0=
X-Received: by 2002:a63:af08:: with SMTP id w8mr1001427pge.419.1603788002072;
 Tue, 27 Oct 2020 01:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201026085141.1179-1-rsalvaterra@gmail.com> <20201027012204.GD2412725@google.com>
In-Reply-To: <20201027012204.GD2412725@google.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Tue, 27 Oct 2020 08:39:51 +0000
Message-ID: <CALjTZvbf4qK6SHEe7OhkTC_o7kaY4oOKQ+kk-D2OUq_ULsYAqQ@mail.gmail.com>
Subject: Re: [PATCH v3] zram: break the strict dependency from lzo
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     minchan@kernel.org, ngupta@vflare.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Sergey,

On Tue, 27 Oct 2020 at 01:22, Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> Honestly, I'm not entirely excited. lzo is a fallback compression
> algorithm. If you want to use zram with something else thenconfigure
> zram to use something else. What do all these #if/#elif buy us?

The idea is to allow us to select a single compression algorithm at
build time, if we're sure to use something other than lzo. The status
quo only allows us to select additional algorithms, as lzo is a hard
dependency. I dislike the "iffery" as much as the next guy, but in
this case the default selection stops being static (as lzo may not be
available at run time), so we have to fall back to an algorithm which
is enabled, otherwise zram won't work out of the box (we'd always need
to choose the algorithm manually in sysfs).
Personally, I always use zram with zstd, and the only lzo dependency I
have is zram. Disabling lzo saves me about 3 kiB in the final
(xz-compressed) vmlinuz image. It's not much, for sure, but when your
total storage is 4 MiB (and your RAM is 32 MiB), every bit counts. :)

Thanks,
Rui
