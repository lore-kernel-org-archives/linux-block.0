Return-Path: <SRS0=+obT=ZO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F325C432C0
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 13:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA0E2071B
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 13:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfKVNuC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Nov 2019 08:50:02 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:35309 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbfKVNuC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Nov 2019 08:50:02 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N95mL-1hjb390sfn-016Bs7; Fri, 22 Nov 2019 14:50:00 +0100
Received: by mail-qk1-f171.google.com with SMTP id e2so6302682qkn.5;
        Fri, 22 Nov 2019 05:49:59 -0800 (PST)
X-Gm-Message-State: APjAAAW3bKjJ0TVudyGpz+iEAw6aPURBBsMdthaSU7pSDRy1+nYcYm3E
        UUKyPnYYHCUoUPuOSEOOxtOlEFKLHoxBusuD5P0=
X-Google-Smtp-Source: APXvYqxg3ILrHYVaxe+mUN7l+DKLHBgh2CYz7q6KL/X1TBQ2KSTbaCNeIK7dnSWX71Vt/Go7Beuq9hcatumuaCjpLR8=
X-Received: by 2002:a37:a757:: with SMTP id q84mr2719071qke.394.1574430598876;
 Fri, 22 Nov 2019 05:49:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573456283.git.baolin.wang@linaro.org> <CAK8P3a1we9D5C2NOBww=cW-4L1PT3t0NnDRmknLwiLm652TmKg@mail.gmail.com>
 <CAMz4kuK9HEuGdhNqHO_qoy9jD=ccsPPhD_dKYwNRgQyWyYwqRA@mail.gmail.com>
 <CAK8P3a0rNhyxmUWLUV1js3FsuAESDOPX3E4b8ActtL4GRT4uTA@mail.gmail.com>
 <CADBw62pzV+5ZXBEbFvTQJ9essAd4cd7Xkz5j9AXB5rAQy0wLqA@mail.gmail.com>
 <CAMz4kuK_3q4JY1vNXe6zGHDNF8Ep-SkcUq6Z25r790VSz4+Bjw@mail.gmail.com>
 <CAK8P3a11vJb1riYseqPnF_5SuJA+YnYuGwC0XWx6_rk+eQ0Bmw@mail.gmail.com> <CACRpkdbzN8_YFT0Di88Oi1j+TTMT-VJLSbv6J8jxP+AsA3j1Dg@mail.gmail.com>
In-Reply-To: <CACRpkdbzN8_YFT0Di88Oi1j+TTMT-VJLSbv6J8jxP+AsA3j1Dg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Nov 2019 14:49:42 +0100
X-Gmail-Original-Message-ID: <CAK8P3a16tv3V78rSb306wCb1H2OF_nkkk1ZO5HAwjrkEGHUScg@mail.gmail.com>
Message-ID: <CAK8P3a16tv3V78rSb306wCb1H2OF_nkkk1ZO5HAwjrkEGHUScg@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Add MMC software queue support
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "(Exiting) Baolin Wang" <baolin.wang@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        linux-block <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Tv7D5aPF3m7gli8X46lkL3LrjJZjc7FOoo/MW+i+WEq3WHXS7gw
 d2JfKApVJOlgSnPVjzxHSPE8wyfv8EQqgaqDJWQbUSpwvhWsOMuqbgcFrJ4eDzNGC3PEeFb
 v0QlQZh1Kldpt45q8Msh5zaj2mj/n2uU9Q1wYkMWV0thjRiJVyZ1TTQ0ZTFfL7MfW+UrZeS
 JJyNxB5uQRTyDF8RnJ1aw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:83zYc4a3aw4=:3lhuH7Pw1iw6jl6Sh5zbwM
 WD8ZqoDYUarhccL4mAliVJ/tT4Za00JURObyvWf7NQmTbqI3l0YEn8hK+yVj5m8k5o1hubBtg
 FPP21v/MkzHwiePRnrs/rMf+vuTeJbDkXHBj0Ilbfefvw1Z6t17k8BzT5RP2HaVUsueUv2qqY
 Qzrxw0B8NvxT2seO/2N2EiLQeaXraFLWQdjHS3GtKMrFJW7U1vv8t0XruwB7X8SYc5LErxZPy
 bHkQHdLRfcO7k/6TBobXrVDqfrgP2c3QFQVmmmU6+geIV1Cmq9TbTjw3m3Izj4qD7pYgoFxBc
 DaL114aInsX4Vf2Au1qEG3BFgRJ3V/lWc3HcDfh+SiePsEWUMZOUb+yeDPs6EaN8Qgefuvvja
 XRZVWR31B308P/BisZ2NQEjHQfm27w8SLhzFuaBuYN3OAso7420x3x0AQFZRsn9WdUiMzrkvh
 0DzAtmzIUXnb267VgU4O+03ydEMMVrsgM8n3/eEOmeMvDx3nlOb9UMYrxAI+CLEileppzxnJS
 VC5usciyspCcSdb2gh40vHrhxpCr+y7Jf6Zg+E3CtqAB/iyb65NXd5O3N5a8VJ0RUvHJXidtM
 C84UzidPE3eNRNviIngI0em1aPR4LLVNyPYrs+SRT+6N9o4Fs7UpoOMwX3AzMtc9SDDWWl8oL
 grM0PgH5Sr6dhXQHqL6G43zgvF4cm8Net97ElsS4RGiCI0y2qp0kQqRLyVT1+L0wOfD7+26Ge
 nsw5DZpczMxZVVUePd6QolpAfJts4xU7Mgfesyv1FC60stQG4nrok7589d5u23nTV2pJwo8FT
 q7Vpewu5gpI0dqHCsjDqGIa/dv9DlriRLO0W0OM6hTXNQhEo4WwLcDOaxWRS4m3Td5MXxt+zd
 XYae+FvmBu3VMDCzQTpg==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 22, 2019 at 2:20 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Fri, Nov 22, 2019 at 10:50 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> > I suppose to make the submission non-blocking, all operations that
> > currently block in the submission path may have to be changed first.
> >
> > For the case of a partition switch (same for retune), I suppose
> > something like this can be done:
> >
> > - in queue_rq() check whether a partition switch is needed. If not,
> >   submit the current rq
> > - if a partition switch is needed, submit the partition switch cmd
> >   instead, and return busy status
> > - when the completion arrives for the partition switch, call back into
> >   blk_mq to have it call queue_rq again.
> >
> > Or possibly even (this might not be possible without signifcant
> > restructuring):
> >
> > - when preparing a request that would require a partition switch,
> >   insert another meta-request to switch the partition ahead of it.
> >
> > I do realize that this is a significant departure from how it was done
> > in the past, but it seems cleaner that way to me.
>
> This partition business really need a proper overhaul.
>
> I outlined the work elsewhere but the problem is that the
> eMMC "partitions" such as boot partitions and the usecase-defined
> "general" partition (notice SD cards do not have this problem)
> are badly integrated with the Linux partition manager.

I think that's a totally orthogonal problem though: we may
well be able to come up with a different way of representing
the extra partitions to user space or as separate block devices,
but in the end, this looks exactly the same to mm
 ->queue_rq() callback. If we have send a cmd to one partition
and want to send the next cmd to another partition, we first
have to send the partition switch cmd.

      Arnd
