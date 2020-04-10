Return-Path: <SRS0=rO4A=52=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43698C2D0EC
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 19:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204E12083E
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 19:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="qNp1L1fO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDJTJe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:09:34 -0400
Received: from mout.web.de ([217.72.192.78]:58861 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgDJTJd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Apr 2020 15:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586545733;
        bh=sNyyQCsXyfuYEo6jFFgq3kX3z34MamWp1a11cAuN5zU=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=qNp1L1fOOWMQM3UexEtjL14eGqCbvX4P4PzqI9eP/BC6nDECv5MDFnivM4tuddLnT
         PbyzcG5QwglSfww/WFR9Sp/nqYUt70q8ju3fFz0gp9z7YSG4zKgKh1M9KOt5uRvisu
         DuW74elHE/91Gvzo0K9y4PGgHjCCbNl4RTTcfVBY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.110.107]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LpO4v-1ikdbF3Xbp-00fDaZ; Fri, 10
 Apr 2020 21:08:52 +0200
To:     Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
        linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, nbd@other.debian.org,
        stable@kernel.org,
        syzbot+934037347002901b8d2a@syzkaller.appspotmail.com,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] nbd: Fix memory leak from krealloc() if another
 allocation fails
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c91c88ef-0600-4733-d301-de1e2e62cb94@web.de>
Date:   Fri, 10 Apr 2020 21:08:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XgK3M+Ie6c8esxWP36w86h1EJ+IdOJZFcBjHUfFqC3WwiR5fz42
 YAO13exwf2rwdSPsuWOuKZMh4xF1utnVeLxMT8bFy7/Bx+860bDS40eN9cf8wtC2uCszvg4
 DJAdQDcpcDT0Q62N5+htU6dTJkiJ3XblX8dRreoC8OknBDDTRmeIilBwzNNqf+Jp2nhksTb
 sVjB6r/ww8xbmPmbsVjEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PRuJ7OaHffM=:G7/NYEgKIvP/9OnnQwQnnZ
 el1WAjUmpGDSrO5Nz2W+m++zMym9Jo6MQtug78U8/ozyNlU6V+UvoImXyHGONjZT89LChSJGQ
 Aq2uKj+UsZntNApxR4FYKe9BRWYOzWsthhldpJ118EtHXBGG0z0DAhXiH4i9CvwU75Fib22zw
 RdYQg4rWFRAS2tA18dKdSIDFZ9znxPk9cRzDaqLEfMKgKONbMi3o+by8XquFTBntth3SymKXe
 AtunTkI2uEkRO+VdC1faP1HeywuoqLcGTxj744nDwr/U0vwet/ljuAJ5xTiblx+DLQ4iTbloP
 FhpTGKO74bQ3pcUtISl3+LGWzNZePu56vFsgWTgMMYSVmVoigerTez5f73+UrXiqDkR3+AjDf
 IIBbvkueOX0wZjDmnteoyHli7hp/vZPY3Xf2w7nctCwmtPrWhK1xAN9bvjxNJvenE/Zadbxpt
 tJfGwXLvOV91Cx4ZdyklfCRB3tpS5KdkQiZ2OtYULNQ3irNB30nUZhtuaThdOCP9frzrTsh5O
 XnsqJMYxNE9dGV8H24E/nR83b0YycmHkrUOA9+jifGG4dVEoKavuHQv2cmdDuBRety0pI2+J0
 GxW328Tllgvno6p0gPujXRmhnql/PMKH4EaZ6mFINVDeV21rAdhFxhxA/n5bmkc0MIVfGsTGU
 x8Z7/QKExm1QdsSkDXg5b/EzNb8qHitb6geOYcGtnJmTXvUQbaQWVLklQVigL1sHvpp/DEssX
 qZwEsGusOGf5aE6xTwACBKSNn+l/uyIqgAeDoMA2LO2Px9iVr4Roh5DRsk7j9409cfhQN9dwb
 XmK7o+Qp0/M747IpsoEUhiTOqKXVpCxjJW0XxQhXlgvU1EcG55xHgHekNZqgGOpehSJwodzbB
 sBaNoB9Dca0t0Aod6vlGGXuqkxLcbOnzpN36dulRPfsGHoVsELvRTP6MvJdKGj7n0rzvEEoMl
 YPjBA4zsQfHb6pX/iAAI8V+dULEWOqKEFGE2CfaUOXwQfvOmwJZkm4sP1xib/RHd+TVWm54Yc
 YwfA52Ng/bsA7CT+UGwdfS29D/3F3FQReO+zWW5LnurPMj832rZYFJR/KuqrD0wvPiHJDuqs5
 eakuicCYPsk4CbumcHw7aK1UeOmeeMqxVp7H8y2TocJYkCKiLVJADa5suMsZ0xflRsiY1lbs6
 A+hMjug1xh1GSWufLcMh5PC0gkf6LbDtZNuCWtJqkKZn2dppHTgMQFN2HOpMmu87T4Oytqavy
 etlpNffL+RGcmAAKL
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> syzkaller reports a memory leak when injecting allocation failures:
=E2=80=A6
> as then config->num_connections is not incremented and the cleanup code
> freeing config->socks is skipped. Just make it run always.

How do you think about to add the tag =E2=80=9CFixes=E2=80=9D for the fina=
l change description?

Regards,
Markus
