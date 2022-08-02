Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B43C00140
	for <linux-block@archiver.kernel.org>; Tue,  2 Aug 2022 22:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbiHBW1n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Aug 2022 18:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbiHBW1h (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Aug 2022 18:27:37 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BBE4E843
        for <linux-block@vger.kernel.org>; Tue,  2 Aug 2022 15:27:36 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id tk8so28332922ejc.7
        for <linux-block@vger.kernel.org>; Tue, 02 Aug 2022 15:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=xcNTXX8l7/kFEB5mAEvnpDDYWM8DWCWfYn98tVpEZBI=;
        b=SweZesmFxyZmAlFsIb6kJ3BkstkoNgGlB2r5d8Uhe4jA+EXcgeuy5lFGIzg+GlkmNu
         wxNs3RZzlp1Kw7C4nhGFsxjtsWw7bI6EdjlX8RPFs1hnAgJMslRpB+AA2w0AUlQyIdIx
         KcssazBH2UBQ8aJltqe0V6elzPCUTdVyAKulI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=xcNTXX8l7/kFEB5mAEvnpDDYWM8DWCWfYn98tVpEZBI=;
        b=TtXHTQ21iaRzvJVGzv7XvsP72lBtTdaNGLczYx7BKQVZ+q2qVlS2NGS+uxEsG8haud
         V/NoqyKfLhjO2aVyhqJgEsHpzf2oPA0ESlyqelw1XvvSUTSXnYXst/3PMjDL+Xzc+b2W
         du6fD9NlM8DWqqA30lTA7PAlMr3g9WW8z8P+EspDbTRwTfwY8lp3C2d0lXU834Z9ww5d
         YV1qBTaSv6GFiJRliUYJzwFdvDRGOTlWWDzqwJ7L1yEfecK3CHgtWGxbbVCBMAnqW4gE
         kdCm36eJvUZ1rZR/FlAUs8K1I5LJi4I4gE/j5dmD6/BZebDfLoV62TSpTowULsUuISz3
         qFJg==
X-Gm-Message-State: AJIora+f6cPx7MdR+1J9f0T8eLC5Ebo2ubq6Kp0S61DTn0XRzhqHP3G6
        64Y3/ykn+/a/PKXmCUsRoYT5Znr+b23iwwgF
X-Google-Smtp-Source: AGRyM1shXXSUVaW997kNDwYtvNDTJwVu/6gr8ECe/AYFvKAkXOU1k7M/EUJP7m+yn5XkI1++aQqvPg==
X-Received: by 2002:a17:906:6a14:b0:72b:64bd:ea2b with SMTP id qw20-20020a1709066a1400b0072b64bdea2bmr17001675ejc.680.1659479254403;
        Tue, 02 Aug 2022 15:27:34 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id q8-20020a170906a08800b006fe0abb00f0sm6632879ejy.209.2022.08.02.15.27.33
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 15:27:34 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id a11so7856315wmq.3
        for <linux-block@vger.kernel.org>; Tue, 02 Aug 2022 15:27:33 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed0:b0:3a3:3ef3:c8d1 with SMTP id
 g16-20020a05600c4ed000b003a33ef3c8d1mr877981wmq.154.1659479253679; Tue, 02
 Aug 2022 15:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <87f60512-9242-49d1-eae1-394eb7a34760@kernel.dk>
 <CAHk-=wi+HuC_bs7VMTJSjp0vug9DRMY9+jKcsQryU9Eqofdxbg@mail.gmail.com>
 <YumYKVWYnoALoSBR@kbusch-mbp.dhcp.thefacebook.com> <74bb310b-b602-14eb-85f7-4b08327b0092@kernel.dk>
 <CAHk-=wgAeL8+BYsy4mnut+y7sBF_+LXmW5bjUfegBpg8SisBJQ@mail.gmail.com> <7d663c1a-67a2-159e-3f93-28ec18f3bd9d@kernel.dk>
In-Reply-To: <7d663c1a-67a2-159e-3f93-28ec18f3bd9d@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Aug 2022 15:27:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgALRccia0ouYywoDAH7RDCpi3rwfjwT0TZ7gV4O1+qaA@mail.gmail.com>
Message-ID: <CAHk-=wgALRccia0ouYywoDAH7RDCpi3rwfjwT0TZ7gV4O1+qaA@mail.gmail.com>
Subject: Re: [GIT PULL] Block driver changes for 5.20-rc1
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 2, 2022 at 3:24 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> I take it this is only happening on clang, which is why I haven't seen
> it as I don't compile with clang.

It happens both with clang-14.0 and with gcc-12.1.1.

And Keith says that the issue was apparently know about and fixed over
two weeks ago.

So *somebody* knew about it, and fixed it, but apparently the people
involved didn't bother informing upstream.

Regardless of what happened, it's not even remotely acceptable.

                 Linus
