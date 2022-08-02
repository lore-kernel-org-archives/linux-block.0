Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7649AC00140
	for <linux-block@archiver.kernel.org>; Tue,  2 Aug 2022 23:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiHBXDd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Aug 2022 19:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiHBXDd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Aug 2022 19:03:33 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9352ED4E
        for <linux-block@vger.kernel.org>; Tue,  2 Aug 2022 16:03:32 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gb36so2886812ejc.10
        for <linux-block@vger.kernel.org>; Tue, 02 Aug 2022 16:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=cmp4ekNg8RAJcv4umTQ1zCefnlYFtk6/QGkZiYvNYGw=;
        b=VdGfLUnS8oMSNYsswnBYiJ2H88njhRvEnJ21OHkM46lzq2ks4ax++saV01W7mVQj+G
         xHQNHywLNNC5K2rYYD++p1nPUvcK9H5iBURFD0fF9bzLWtAPSFZGgbCsPRcarty4D2O4
         RQSsuqHKL33Zn1+MZY263/Lb/7otYuPW7s9rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=cmp4ekNg8RAJcv4umTQ1zCefnlYFtk6/QGkZiYvNYGw=;
        b=Na8KtzeaiQ6rhQWhtb9Yeg2LDrMKdUsUgsB8YUbX9sKaxUUslQ2c712c2CVX6xpc+F
         p9fz78A0vJ9dc3JglIoKFB9eLV+zKkJzIWgkqbSEPqvkMtlxv27IYkRq/7JOkFJ3NQV2
         rKvn+ibtuWh+1jvxST3wwnpMDlg/pbOwSP8WNiV8lrMDBkkYPkQLf45xKTeuBYMsRbIt
         UVqBlDU8J0tuDE8T5nwobHV2sQOff57xaZznc/6lAbQd+ZJ7PzqpDqPrQ+Lo+zXfUNMy
         D/soYBP8I4wmZkFAt1KTEW/u515YFUeFFZYCglOFe2LsaMeqg+Dx+yI3kkcgw6zeELJD
         EdkA==
X-Gm-Message-State: AJIora+b7TNaSJHNwtLr4MurvXXp8pHbqdDxTnhAlRikb8+qleNSBgL9
        Hz4AgY8HeTRhuI5Vz1xQzyGsH6E1I0LebJ98
X-Google-Smtp-Source: AGRyM1s+NIWODsGLpYphINwyozsVCxMzD6+JeSOWGjiFGjKeWC1irevZeYru1+y+Uky3EdkpsE0P2w==
X-Received: by 2002:a17:906:9b86:b0:6fe:d37f:b29d with SMTP id dd6-20020a1709069b8600b006fed37fb29dmr17884721ejc.327.1659481410484;
        Tue, 02 Aug 2022 16:03:30 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id e11-20020a170906044b00b00730935f959fsm2208790eja.223.2022.08.02.16.03.29
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 16:03:30 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id v131-20020a1cac89000000b003a4bb3f786bso103553wme.0
        for <linux-block@vger.kernel.org>; Tue, 02 Aug 2022 16:03:29 -0700 (PDT)
X-Received: by 2002:a05:600c:2d07:b0:3a3:585:5d96 with SMTP id
 x7-20020a05600c2d0700b003a305855d96mr968321wmf.38.1659481409570; Tue, 02 Aug
 2022 16:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <87f60512-9242-49d1-eae1-394eb7a34760@kernel.dk>
 <CAHk-=wi+HuC_bs7VMTJSjp0vug9DRMY9+jKcsQryU9Eqofdxbg@mail.gmail.com>
 <YumYKVWYnoALoSBR@kbusch-mbp.dhcp.thefacebook.com> <74bb310b-b602-14eb-85f7-4b08327b0092@kernel.dk>
 <CAHk-=wgAeL8+BYsy4mnut+y7sBF_+LXmW5bjUfegBpg8SisBJQ@mail.gmail.com>
 <7d663c1a-67a2-159e-3f93-28ec18f3bd9d@kernel.dk> <CAHk-=wgALRccia0ouYywoDAH7RDCpi3rwfjwT0TZ7gV4O1+qaA@mail.gmail.com>
 <38164718-0f09-76e5-a21d-2122613cdf73@kernel.dk> <CAHk-=wii5SG2=P1kStBYJ9JiK97GYZcYdozy-JP15qNcfQXF3g@mail.gmail.com>
 <2ae97675-383b-c2c7-9bed-6a9a55ce64f1@kernel.dk>
In-Reply-To: <2ae97675-383b-c2c7-9bed-6a9a55ce64f1@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Aug 2022 16:03:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjQpMT+Z-=B4QzGT_BkSe0kuqDuK+hBvOq7YTXKmM2HEQ@mail.gmail.com>
Message-ID: <CAHk-=wjQpMT+Z-=B4QzGT_BkSe0kuqDuK+hBvOq7YTXKmM2HEQ@mail.gmail.com>
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

On Tue, Aug 2, 2022 at 3:59 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> Actually, I'm mistaken, on the build box it's running 11.3. So that
> might explain it? I use 12.1 elsewhere.

It's possible this -Waddress error is new to gcc-12.

I try to keep most of my machines in sync just to avoid the pain of
different distro details, so I don't have gcc-11 around any more.

             Linus
