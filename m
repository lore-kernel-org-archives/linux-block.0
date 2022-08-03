Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7BAC19F28
	for <linux-block@archiver.kernel.org>; Wed,  3 Aug 2022 17:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiHCRBO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Aug 2022 13:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiHCRBM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Aug 2022 13:01:12 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7323BB86D
        for <linux-block@vger.kernel.org>; Wed,  3 Aug 2022 10:01:11 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id k26so16850554ejx.5
        for <linux-block@vger.kernel.org>; Wed, 03 Aug 2022 10:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=EfvcPcMWd4uXd2nvNTbFbeyzwtEH/MnPizehPXc+W0Y=;
        b=VSaxmHImNCqGYuO3lC211ekF/XhBY0N1zfwO62w7a77PiXroDlLcih/Qswea5u16E/
         vvYYgWWaFtEUEkXSuih6YarCtV2dYGTTIFTX1X+dtRLxxtuUDSdKKk+wANTzUkuyPf3t
         WqakA6MMF1r3x2pAJGKqTzvzJZAtlYOvLyyns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=EfvcPcMWd4uXd2nvNTbFbeyzwtEH/MnPizehPXc+W0Y=;
        b=bpFAC4TUw/fiJz4oIcJVDn6fSyoE4GreK4ub1wMHnzcflkU5z5lat0UXOSrvll5URb
         y13kVGhSU5rKSTDGqr8ICzdt1PUdpwklyoQBVaXe5WV9THfzDpaCjxOrZxNY060L+O+7
         dcUAr41ve1n+3S8ZuGUY+2bFhTEg9haXoU1+HbClwisBl7Wz4n26TeokVgk5RQXtrcfO
         hsARAMjzND5s22heuEV0ISxes7D7AgWRRciCdGI9zrsAtFrbKKkpub+mzuW8MS8thBaz
         TyipIe6DFSQq3cedy9hpaeT52Ivhz3JBRJEOFjvipi+cMvYmJiEZwERSi82knGB3140a
         fGew==
X-Gm-Message-State: AJIora/SLG9koFiZuZymBOh++QwmIK0/9jey8QeggSAxbiH4ZTJO9CpD
        ueX1GcvUJ35/CE6+YXZpK4bbewazt3umFbwq
X-Google-Smtp-Source: AGRyM1tLZMQlidq18+IzigH8e8NpqEp2HSu9sQynTAdXILiGi3Aoib8fA2Q3plrCHnWo42lAD1m1XA==
X-Received: by 2002:a17:906:a402:b0:72b:8e6e:64ea with SMTP id l2-20020a170906a40200b0072b8e6e64eamr21326603ejz.469.1659546069819;
        Wed, 03 Aug 2022 10:01:09 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id ay24-20020a056402203800b0043d3e06519fsm7393795edb.57.2022.08.03.10.01.07
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 10:01:08 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso1149310wmq.3
        for <linux-block@vger.kernel.org>; Wed, 03 Aug 2022 10:01:07 -0700 (PDT)
X-Received: by 2002:a05:600c:1d94:b0:3a4:ffd9:bb4a with SMTP id
 p20-20020a05600c1d9400b003a4ffd9bb4amr2268477wms.8.1659546067570; Wed, 03 Aug
 2022 10:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <87f60512-9242-49d1-eae1-394eb7a34760@kernel.dk>
 <CAHk-=wi+HuC_bs7VMTJSjp0vug9DRMY9+jKcsQryU9Eqofdxbg@mail.gmail.com>
 <YumYKVWYnoALoSBR@kbusch-mbp.dhcp.thefacebook.com> <74bb310b-b602-14eb-85f7-4b08327b0092@kernel.dk>
 <CAHk-=wgAeL8+BYsy4mnut+y7sBF_+LXmW5bjUfegBpg8SisBJQ@mail.gmail.com>
 <7d663c1a-67a2-159e-3f93-28ec18f3bd9d@kernel.dk> <CAHk-=wgALRccia0ouYywoDAH7RDCpi3rwfjwT0TZ7gV4O1+qaA@mail.gmail.com>
 <38164718-0f09-76e5-a21d-2122613cdf73@kernel.dk> <CAHk-=wii5SG2=P1kStBYJ9JiK97GYZcYdozy-JP15qNcfQXF3g@mail.gmail.com>
 <2ae97675-383b-c2c7-9bed-6a9a55ce64f1@kernel.dk> <CAHk-=wjQpMT+Z-=B4QzGT_BkSe0kuqDuK+hBvOq7YTXKmM2HEQ@mail.gmail.com>
 <c1b1b619-9142-9818-0536-ce4b97d3e979@kernel.dk> <3af4127a-f453-4cf7-f133-a181cce06f73@kernel.dk>
 <CAHk-=whx-CA1QpFc_6587OmiJHb5+OYDR9aRQQh6=06oJWZG8Q@mail.gmail.com>
 <CAKwvOdkpNRvD0kDe-j8N0Gkq+1Fdhd6=z-9ROm3gc12Sf0k-Kg@mail.gmail.com> <552201a1-2248-b16e-1118-54373531a158@kernel.dk>
In-Reply-To: <552201a1-2248-b16e-1118-54373531a158@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Aug 2022 10:00:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3KEgg5mRLCipxhmZK69FRKEX6Td66Hd5-A18e_DdRkA@mail.gmail.com>
Message-ID: <CAHk-=wi3KEgg5mRLCipxhmZK69FRKEX6Td66Hd5-A18e_DdRkA@mail.gmail.com>
Subject: Re: [GIT PULL] Block driver changes for 5.20-rc1
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 3, 2022 at 9:53 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> I can try whatever here, but a quick grep doesn't find anything for
> KBUILD_ASFLAGS or anything close to it. What am I missing?

I think we only have 'aflags-y' (so you can use config variables etc
to pick them) and EXTRA_AFLAGS.

And we always go through the compiler rather than invoke 'as'
directly, so I think you have to use '-Wa,option' to pass 'option' to
the assembler.

              Linus
