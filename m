Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C63C19F28
	for <linux-block@archiver.kernel.org>; Wed,  3 Aug 2022 16:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbiHCQ4X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Aug 2022 12:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbiHCQ4W (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Aug 2022 12:56:22 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4CADFA8
        for <linux-block@vger.kernel.org>; Wed,  3 Aug 2022 09:56:20 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id j8so7292857ejx.9
        for <linux-block@vger.kernel.org>; Wed, 03 Aug 2022 09:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=fF3PNytTKzW+Xwe+g27Jiexe7avRBsF+C6Vqed1bC1A=;
        b=XeDPkBsgqoCgDVjLTB00ruFJGXiWYdSexpdwg3k7fGwHBxVOs5qtQUAnTntkFLeKyH
         um5nlMi3/BFBAAoEzbuk8h2VAP0MS4ubQZrSFONRyIuJ7eBdIi3pxYWmnbDthrGUWVBr
         mCwLq1M3r4szScXp/3Xv9QMXPPquzDOQVFvPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=fF3PNytTKzW+Xwe+g27Jiexe7avRBsF+C6Vqed1bC1A=;
        b=ALVwu1aSA5qkQXu5OY30nbFGSbURWn3AWC+XB9ZxUZpbIgXim6CYSL1kTd6cCCWgQR
         decR3fI6tYN5TeOgei5ohCZ8at7g8LlATP5wqfDXMoh9cgq8LUEUqQnxa1oKnbSqCxCP
         Yxen6z0qqgqPkLRzPLPC2XxDr2tQW8YNFvktVdCX4kOy9U9ghkTGrS0ZsltnrH9n9SoA
         iS5f4fwQ/CccGGhajm9kAhoajI8HRcrgqVOgy4TMTXIBLW/F6BI7NQU8WWlouST/hWC5
         3T0ATa7vZEG0HoYv3uc5rNkrQMPUVJhAHaRobMUDKMlEJAXl1SJJilUjVxGKjIrKLzQS
         rGtQ==
X-Gm-Message-State: ACgBeo2LRUVL7WL3jXnmyh1DM07Pzu1ias3NTpPbcBp+tuixe/N0gbRj
        yep39zbmoBlgcP0WkNBo+HKLdpLxWwkvVfnN
X-Google-Smtp-Source: AA6agR5ClNMK11OivpFWL1FU8ku+oEEC5RRu5e62JvKsDQ6j7uv5gbb9vRIIT9EDMBXtsVZkc72R0w==
X-Received: by 2002:a17:906:8477:b0:730:a658:b286 with SMTP id hx23-20020a170906847700b00730a658b286mr5625868ejc.646.1659545778634;
        Wed, 03 Aug 2022 09:56:18 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id b7-20020aa7cd07000000b0043a87e6196esm9811775edw.6.2022.08.03.09.56.18
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 09:56:18 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id j15so14184357wrr.2
        for <linux-block@vger.kernel.org>; Wed, 03 Aug 2022 09:56:18 -0700 (PDT)
X-Received: by 2002:a5d:56cf:0:b0:21e:ce64:afe7 with SMTP id
 m15-20020a5d56cf000000b0021ece64afe7mr16303069wrw.281.1659545777734; Wed, 03
 Aug 2022 09:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <87f60512-9242-49d1-eae1-394eb7a34760@kernel.dk>
 <CAHk-=wi+HuC_bs7VMTJSjp0vug9DRMY9+jKcsQryU9Eqofdxbg@mail.gmail.com>
 <YumYKVWYnoALoSBR@kbusch-mbp.dhcp.thefacebook.com> <74bb310b-b602-14eb-85f7-4b08327b0092@kernel.dk>
 <CAHk-=wgAeL8+BYsy4mnut+y7sBF_+LXmW5bjUfegBpg8SisBJQ@mail.gmail.com>
 <7d663c1a-67a2-159e-3f93-28ec18f3bd9d@kernel.dk> <CAHk-=wgALRccia0ouYywoDAH7RDCpi3rwfjwT0TZ7gV4O1+qaA@mail.gmail.com>
 <38164718-0f09-76e5-a21d-2122613cdf73@kernel.dk> <CAHk-=wii5SG2=P1kStBYJ9JiK97GYZcYdozy-JP15qNcfQXF3g@mail.gmail.com>
 <2ae97675-383b-c2c7-9bed-6a9a55ce64f1@kernel.dk> <CAHk-=wjQpMT+Z-=B4QzGT_BkSe0kuqDuK+hBvOq7YTXKmM2HEQ@mail.gmail.com>
 <c1b1b619-9142-9818-0536-ce4b97d3e979@kernel.dk> <3af4127a-f453-4cf7-f133-a181cce06f73@kernel.dk>
 <CAHk-=whx-CA1QpFc_6587OmiJHb5+OYDR9aRQQh6=06oJWZG8Q@mail.gmail.com> <CAKwvOdkpNRvD0kDe-j8N0Gkq+1Fdhd6=z-9ROm3gc12Sf0k-Kg@mail.gmail.com>
In-Reply-To: <CAKwvOdkpNRvD0kDe-j8N0Gkq+1Fdhd6=z-9ROm3gc12Sf0k-Kg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Aug 2022 09:56:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjHmtBQNUa_tCs2aRa5dPJmbBo4F7S6UrJ96-PG_YkQ3w@mail.gmail.com>
Message-ID: <CAHk-=wjHmtBQNUa_tCs2aRa5dPJmbBo4F7S6UrJ96-PG_YkQ3w@mail.gmail.com>
Subject: Re: [GIT PULL] Block driver changes for 5.20-rc1
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mark Rutland <mark.rutland@arm.com>,
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

On Wed, Aug 3, 2022 at 9:51 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Does adding `--noexecstack` to KBUILD_ASFLAGS for these architectures
> help, rather than modifying every assembler source?

See, this is why you cc the experts:

> > I've added random people who have touched those linkage things in the
> > past to the participants, in the hope that somebody goes, "No, Linus,
> > just add flag XYZ to the linker script" or other and there's a clear
> > and obvious solution.

Thanks,
                Linus
