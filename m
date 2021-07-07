Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D99C07E9E
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 08:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECDD661C82
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 08:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhGGIUC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Jul 2021 04:20:02 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:59819 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhGGIUB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jul 2021 04:20:01 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MK5BG-1ll2Kc0ulC-00LUfL; Wed, 07 Jul 2021 10:17:20 +0200
Received: by mail-wr1-f49.google.com with SMTP id d2so2073150wrn.0;
        Wed, 07 Jul 2021 01:17:20 -0700 (PDT)
X-Gm-Message-State: AOAM533Mw9h6hSTfpOB+NF5ZrF2qHhfh4nRiUnF06ltMe7U+WDlpW5c2
        Vyj43nY2EGNcq+oD5ceecf7W8gfuZ/lgDhGXeV0=
X-Google-Smtp-Source: ABdhPJw7Q9biNKuYw5LzzABEnymQHmOJOcA3+Y6lhnseoEQOvXLqHFB80q3Ei/XLODgiV261tfZT4qREh8gSCMmDldE=
X-Received: by 2002:a5d:6485:: with SMTP id o5mr27386161wri.286.1625645839748;
 Wed, 07 Jul 2021 01:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2mAQOnTxBhVzVA8q8O-uVrdidCN5h5-T2dc0=Wet2uPQ@mail.gmail.com>
 <20210706205927.4407-1-abd.masalkhi@gmail.com>
In-Reply-To: <20210706205927.4407-1-abd.masalkhi@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 7 Jul 2021 10:17:04 +0200
X-Gmail-Original-Message-ID: <CAK8P3a23=tcWx8iWNAKXcT9TRgPrZbEVVy9a_ad29hSde_jkKg@mail.gmail.com>
Message-ID: <CAK8P3a23=tcWx8iWNAKXcT9TRgPrZbEVVy9a_ad29hSde_jkKg@mail.gmail.com>
Subject: Re: div_u64/do_div stack size usage, was Re: [v3] block: Removed a
 warning while compiling with a cross compiler for parisc
To:     Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, bernie@develer.com,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:RCQaZuFTGyqYxV+lx9Z+/6VgkMm1qpKjfKfkLzmlW9nQnvwHSA1
 nHITFP7pB1GK+k06/KcorEmSS2nVoevzv4ANostrSYrpgnhTHAINpElZXVasD5uQN+ncJyu
 I2UhJu4olVV79TUlXRqk49gPVBpiANrabpYmPKj+QjdD8h4vXhx5x1FyrBh5qXPCO5rqbR6
 XK0lLWJ259X5//UEy57yw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7ctsQDTFDkY=:WdxQ7xsX0VjhbeupjHEDQr
 MtazFpB2jNMcaMgJAP7vkUqIUMrAt2wl5SSBfbGbmJEZtFbY3/7Xe9i/rIcFXeipE6CDqQyLw
 qdh/2CKGIY1H8Ke2LplEkhsLUCGOnIGQqsuiH3DOlNW6kh8eIHhr7EuhHIUw4ruWJTc85+ZX3
 Qs5Okow8sQyrgqmtAbhmQTfJTV0AEEzNcvgo/ZD1CQoMin/rs1AoiXMJkovjZ1ekpW//32oN/
 kf+ivVW1nVozC4oYOt8TVSSc+0GpDg9PZDDTs1283sxNetb1BaaBr9vOwi43oC9XJQ1M9UVH3
 9F+fhZjBQcOaWzNm3QxNcow3svs7AkqZ1hqCx8vJyLv9oGjZsSCfKRDG7dwEN/3mpvptCQMGT
 It5DLKyCObPdCjQAJjR8ug1ll6zWanEiCLDlmjXLiDz7TEE80xStO4ZoqW2NAqgPIx4U5X4Pc
 bbhm5C/dc87KUS1dZ9khMNjqCOcPfA+hoooV9jxWUhCOpmSxSPu66I8awDAoD4k28J8VEpA1V
 IoK4hp1RFtJA37oftfna5wNbCNWPhIzdsleU2AZcMW+wzPW3ZfOnpGr1vtcOgbrGMyb1FwNK/
 Px4OFurDL981PEy6AmeWWfL7dHgIdId+hcomIQG5TN9M2dD+qowbbxmk8MTdKmQOL/7J/U1Mm
 dmM8dxE/0rCvfHEtduucKxYVLbogCA1gpheHE+WCjtuYAc07W1HNLcdBXDig2N4X5Gobfe+S0
 shtonuD4JedMUTtiAOi4xxCqtNna5gJB20BF4OL71KX4uUpBLK2cM9Z7y1OFNrI/4/WbUsebD
 jZcH4sppCHg+LluajPQGnkBVQDsF6jxUjNVKiRuSiuHeh8XQLwXcykybx6WG8ZEwPmvANOG+u
 9tedVR82cGfNN74vJiXyQG/mareGpI3OY5/sLM1PKzI0InCvUHHrxmgSTyF6QdmL1/GbFHieZ
 8jroiZ3u371oD+z2CoemrseUE+mtQVOoRXuef1ZL8aUQaBvOAfnq4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 6, 2021 at 10:59 PM Abd-Alrhman Masalkhi
<abd.masalkhi@gmail.com> wrote:
>
> I have compiled the kernel with a cross compiler hppa-linux-gnu- (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0 and the conficuration was the default, Build for generic-32bit "generic-32bit_defconfig"

Ok, thanks. I have reproduced this now with gcc-9.4.0 from
https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/.

I have also tried it with the other gcc versions and shown that it
happens with every older compiler as well, but it does not happen
with gcc-10 or gcc-11, which bring the frame size down to 164 or
172 bytes respectively. gcc-10 also fixes similar warnings for
net/ipv4/tcp_input.c, net/sunrpc/stats.c and lib/xxhash.c that
fly under the radar with the default warning level.

My first thought was this was a result of -finline-functions getting
enabled by default in gcc-10, but enabling it on gcc-9 did not
help here. It's likely that the gcc behavior was fixed in the process
of enabling the more aggressive inliner by default though.

I also tried building genhd.o for every architecture that has
gcc-9.4 support and did not find the problem anywhere except
on parisc.

Using CONFIG_CC_OPTIMIZE_FOR_SIZE did solve the
problem for me (frame size down to 164 bytes), but I could not
pinpoint a specific -f option that fixes it for -O2. Maybe we can
simply change the defconfig here? 32-bit parisc systems are
probably memory limited enough that building a -Os kernel
is a good idea anyway. 64-bit parisc already builds with -Os
but does not see the warning with -O2 either.

    Arnd
