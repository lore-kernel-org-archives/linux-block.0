Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6E0C00140
	for <linux-block@archiver.kernel.org>; Tue,  2 Aug 2022 21:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiHBVvN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Aug 2022 17:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiHBVvM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Aug 2022 17:51:12 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A3E2A940
        for <linux-block@vger.kernel.org>; Tue,  2 Aug 2022 14:51:11 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a7so15268415ejp.2
        for <linux-block@vger.kernel.org>; Tue, 02 Aug 2022 14:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5Rv79VJHIKSvpOIw2O5Fm8WohEUbhBV/qYyIN/5sZZo=;
        b=B9D4g9WwzhG4R8cuR9n9EaCFkwSDiOqYzcsEtXxhTnadfT8wSySSDao6azrT6nYOS7
         DLWQ+91KHujqQXXHJLG354VovSYvd7rg9/c1nyc70I/YAIFpLfVhJyv5GZzthlc8WTX1
         d/K8uquolELySYwroIw5iWMA6KdvKt3SriZcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5Rv79VJHIKSvpOIw2O5Fm8WohEUbhBV/qYyIN/5sZZo=;
        b=UOSV67quqzckSgV152WBmMCmy6/9r+DZQFDvnrZB0NmoVGJ7o83dW1UXohvJkgknFo
         k4hl7NqlVc9dH8ObBJBjzqsHj0UhMt+4VPB0e96eQjzcxYKJl2k6FRv27d/zPZ43Yb1d
         5+Lk6X8jfbUfSUCVwHPvD9TbQ9lkvZWBLG/DywVJBgKJ8bpRtxKUww+Op4yPiUSLJQpn
         sKIJ74j0O8S1+rQG2dKJeFpOyV5m0ungALH5/WnO5IKcG9Rtcf+RcKs8aPt049ZVBywq
         X/msBQqsT74P01GqM9yGGErXyELbkbE+KimAN4S7i07RbFDLi7UgFsWncX7O8ztPjiqH
         2FkQ==
X-Gm-Message-State: AJIora/CnNcXkxQfl38O+MvCwzt3n0O3zXVgjgeYC+UgunIdR+NFdDsE
        oG405uVzfsvWHNCvQucFF2U0ZkklLoz/8f6Q
X-Google-Smtp-Source: AGRyM1u7XEwbNKGANIfSkM/AMLGZhWh+Ky1HsHgqPJ1J58c87Ani9EqyTjIXZUpuoye3jxbubNPdaQ==
X-Received: by 2002:a17:907:2e02:b0:72b:7f58:34a7 with SMTP id ig2-20020a1709072e0200b0072b7f5834a7mr17968025ejc.525.1659477069876;
        Tue, 02 Aug 2022 14:51:09 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id b15-20020a17090630cf00b0073022b796a7sm6165538ejb.93.2022.08.02.14.51.08
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 14:51:09 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id z16so19328405wrh.12
        for <linux-block@vger.kernel.org>; Tue, 02 Aug 2022 14:51:08 -0700 (PDT)
X-Received: by 2002:a5d:56cf:0:b0:21e:ce64:afe7 with SMTP id
 m15-20020a5d56cf000000b0021ece64afe7mr13924974wrw.281.1659477068521; Tue, 02
 Aug 2022 14:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <87f60512-9242-49d1-eae1-394eb7a34760@kernel.dk>
 <CAHk-=wi+HuC_bs7VMTJSjp0vug9DRMY9+jKcsQryU9Eqofdxbg@mail.gmail.com>
 <YumYKVWYnoALoSBR@kbusch-mbp.dhcp.thefacebook.com> <74bb310b-b602-14eb-85f7-4b08327b0092@kernel.dk>
In-Reply-To: <74bb310b-b602-14eb-85f7-4b08327b0092@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Aug 2022 14:50:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgAeL8+BYsy4mnut+y7sBF_+LXmW5bjUfegBpg8SisBJQ@mail.gmail.com>
Message-ID: <CAHk-=wgAeL8+BYsy4mnut+y7sBF_+LXmW5bjUfegBpg8SisBJQ@mail.gmail.com>
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

On Tue, Aug 2, 2022 at 2:35 PM Jens Axboe <axboe@kernel.dk> wrote:
>
>
> As to testing, I'm going to punt that question to Hannes and Christoph,
> as I have no way of testing that particular NVMe feature.

I can't test the *feature* either.

But dammit, I test two very different build configurations, and both
of them failed miserably on this file.

Don't you get it? That file DOES NOT EVEN COMPILE.

I refuse to have anything to do with a pull request that doesn't even
pass some very fundamental build requirements for me. That implies a
level of lack of testing that just makes me go "No way am I touching
that tree".

                 Linus
