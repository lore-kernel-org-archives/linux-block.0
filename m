Return-Path: <SRS0=SzsG=WD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E036C31E40
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 00:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4415C2089E
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 00:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UNuxmD35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfHGAKR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Aug 2019 20:10:17 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46813 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfHGAKR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Aug 2019 20:10:17 -0400
Received: by mail-qt1-f195.google.com with SMTP id h21so86494666qtn.13
        for <linux-block@vger.kernel.org>; Tue, 06 Aug 2019 17:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zPy6c5lKRqWhHCVvQSPB2eQWatU5KxqafbBHRjUyLkQ=;
        b=UNuxmD35ivjOkCYHrqTH0HW+EZ+v5dZqTwX/rMaL4yahcfN+wstqI4yahnZhsMjyIj
         LlIQ5vfVc7AoFHUsTFbpWP8TDNqdDG+akh8ocNQchufv1r8XlMxmsi+xmJadKkqwKFAw
         T3zqGrCYTBTK3z9NpTfHSM2EMoingc0tBCzgboXl/yUZUzY2nl7SQpKxHV4bvix99Ppr
         bJ6dD5W2dAJgc8VGTy6+6G8WKfQw7/RrLWLUKtKf1M+rFwzO6mAEghVmAxkqPlbVwig9
         aL3e64WDjjwtnbTcP0R9euiCEZa8LsSWBXbR02Fbi6kIIPl7T/lNEjahq+vTOCBzcjO4
         KwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zPy6c5lKRqWhHCVvQSPB2eQWatU5KxqafbBHRjUyLkQ=;
        b=KEds2Nxa6EpnIERL5LYkDa0XTNaOLdhHGW8P2Ij2VcLyQbuK9yI7F4M4sVr/x8jcSK
         f6BB5RwnLQMcEECPj3LR0UB0ONueHSV9xASYlnK0O+EVQtqrvfTr2FrIFZqE6bWls5pU
         IuWtUElIY4E2FIJzTxONC20rf3HpP1DDpIuW+2KrjexStTROQBZ7sfEt4gy6l3yJKILs
         DHLWNsQ4E5jbtynB6Pt2d+VgOJUeoA/t3Fp5n4vKxIB+PwbCfBI90ogg61OSFdDfE3Gi
         A0/KIEL8KUEWgLO4P/OyW6H93d7z83+oNQQ6k0MWlDLsEfg6b6CjCPtZq9Xt/cqy+Erw
         LZ7Q==
X-Gm-Message-State: APjAAAWqVnMsjBGX0OwqjEALxx9SNZ+fkY6cf/zeZV5AZVwV9BTdetur
        RMpMZHuZiRn/ijpW1LrvGKWpvM0uWe1eki402MmdPw==
X-Google-Smtp-Source: APXvYqz/nvrAaowmmB6Sf6BQPwa8pIwGZJehvQrUhjTHgaVF+oOAaZlaFz27zN20fk8bETO2PikPaehedJix77hWPb0=
X-Received: by 2002:a0c:ae5a:: with SMTP id z26mr5561475qvc.65.1565136616288;
 Tue, 06 Aug 2019 17:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190806220524.251404-1-balsini@android.com> <CAJWu+oq9JLnbGdqy+362JZUzjv6PvuRTNwiarTQiEfizsY32hQ@mail.gmail.com>
 <20190806235708.GA10161@google.com>
In-Reply-To: <20190806235708.GA10161@google.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Tue, 6 Aug 2019 20:10:05 -0400
Message-ID: <CAJWu+oo=GrZ+SbA6=bboM4==TKXBsTRWkTrkWiZ55pqhJtgQqQ@mail.gmail.com>
Subject: Re: [PATCH] loop: Add LOOP_SET_DIRECT_IO in compat ioctl
To:     Alessio Balsini <balsini@android.com>
Cc:     "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, dvander@gmail.com,
        Yifan Hong <elsk@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 6, 2019 at 7:57 PM Alessio Balsini <balsini@android.com> wrote:
>
> Hi Joel,
>
> I was considering the rationale for this patch totally straightforward:
> it enables Direct I/O ioctl to 32 bit processes running on 64 bit
> systems for compatibility reasons, as for all the other lo_compat_ioctl
> commands.
> Also the reason why someone would decide to use Direct I/O with loop
> devices is well known, that is why the feature exists :) So I thought
> this was another redundant information to put in the commit message and
> decided to omit it.

No objections from me if maintainers are Ok with it.

> If you still think that I should update the commit message with this
> information, I will do so.

I think you should.

thanks,

 - Joel
