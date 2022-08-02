Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E9BC00140
	for <linux-block@archiver.kernel.org>; Tue,  2 Aug 2022 22:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbiHBWtX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Aug 2022 18:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbiHBWtQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Aug 2022 18:49:16 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAC026AFA
        for <linux-block@vger.kernel.org>; Tue,  2 Aug 2022 15:49:15 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id tk8so28398923ejc.7
        for <linux-block@vger.kernel.org>; Tue, 02 Aug 2022 15:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=TTXBUW4lU5y2V/2Ygdv4RLdhnnQCWvyuaXBGDXUn2ss=;
        b=fcNDah+RtXAgVWqMVrN4uwWwlhQpszb+tkl+bo8WEjLW1WtpR7rmKSoq6ooG8u2eun
         /U9oOgO+NzwtMYjXakSDbOEGa6wwiCJvQ8EZMolJOSUgZySrVTk8XaEoBIrG7F7avfYH
         nGr9zidrGC/YwOgWQ9+KcPBPxfG0Q6pWN6dN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=TTXBUW4lU5y2V/2Ygdv4RLdhnnQCWvyuaXBGDXUn2ss=;
        b=ENr3WQMdDIY+mMKrW5eK4SjBWrIQQtAkMGWFSdxNp65cwicYU4ZqYRm8feSxODtYkE
         KZ8Z502rOY2GJN03mZXk7JYUEc6vwgYcYBCnNnEce0FVjco/JXw17Zg0GdY6iJf4FRSh
         03ahxI/wXYMq3g01aIgZB5SnOye8bWZBOSxDaVIf4/qxP6jqCKT2tX7o8um8RtWh7hDa
         2ekBzRcJF0HRKyUbs0C1/FkUaE1zqMNVv1L/hyCr7QNHsxLryydKsfo5/PyuhpPuyahj
         N9OvnCmOHRiXJNLTxRpFg3dctaBxHthDrr6/aQSJ3c0bC4GRLj8xdfNj3KN/4EKBkw4F
         CwZQ==
X-Gm-Message-State: AJIora/HASNLCo0kW43JKzZGoGYk01buG9cUCnGE22w/ujbTV9rgOUlw
        yhnUZ5kQGja/GkA2Pih96g5A5O4kEeMo2iZU
X-Google-Smtp-Source: AGRyM1tniHX4+KHaZHHitp8l1kBn6LKtB/hEsNb2fhkwOLuDo0ZlfUPWMkuetE8se8B6R9vs646aJQ==
X-Received: by 2002:a17:907:2c78:b0:72b:64f5:11ea with SMTP id ib24-20020a1709072c7800b0072b64f511eamr18143782ejc.68.1659480553828;
        Tue, 02 Aug 2022 15:49:13 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906210a00b0072af92fa086sm6653114ejt.32.2022.08.02.15.49.12
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 15:49:13 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id a11so7875066wmq.3
        for <linux-block@vger.kernel.org>; Tue, 02 Aug 2022 15:49:12 -0700 (PDT)
X-Received: by 2002:a05:600c:21d7:b0:3a3:2088:bbc6 with SMTP id
 x23-20020a05600c21d700b003a32088bbc6mr897475wmj.68.1659480552662; Tue, 02 Aug
 2022 15:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <87f60512-9242-49d1-eae1-394eb7a34760@kernel.dk>
 <CAHk-=wi+HuC_bs7VMTJSjp0vug9DRMY9+jKcsQryU9Eqofdxbg@mail.gmail.com>
 <YumYKVWYnoALoSBR@kbusch-mbp.dhcp.thefacebook.com> <74bb310b-b602-14eb-85f7-4b08327b0092@kernel.dk>
 <CAHk-=wgAeL8+BYsy4mnut+y7sBF_+LXmW5bjUfegBpg8SisBJQ@mail.gmail.com>
 <7d663c1a-67a2-159e-3f93-28ec18f3bd9d@kernel.dk> <CAHk-=wgALRccia0ouYywoDAH7RDCpi3rwfjwT0TZ7gV4O1+qaA@mail.gmail.com>
 <38164718-0f09-76e5-a21d-2122613cdf73@kernel.dk>
In-Reply-To: <38164718-0f09-76e5-a21d-2122613cdf73@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Aug 2022 15:48:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wii5SG2=P1kStBYJ9JiK97GYZcYdozy-JP15qNcfQXF3g@mail.gmail.com>
Message-ID: <CAHk-=wii5SG2=P1kStBYJ9JiK97GYZcYdozy-JP15qNcfQXF3g@mail.gmail.com>
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

On Tue, Aug 2, 2022 at 3:33 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 8/2/22 4:27 PM, Linus Torvalds wrote:
> >
> > It happens both with clang-14.0 and with gcc-12.1.1.
>
> gcc-12.1 is what I use, fwiw.

Hmm. I think the last ".1" is actually purely a Fedora artifact. The
gcc people themselves have only released 12.1.0, and looking around
for the srpm info, it looks like all the final F36 ".1" is for some
unrelated patches.

So we may actually be essentially on the same compiler version, and I
don't know why you wouldn't see the error. It showed up with a plain
"make allmodconfig" build here.

                Linus
