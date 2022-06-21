Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06D5CCA473
	for <linux-block@archiver.kernel.org>; Tue, 21 Jun 2022 07:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347664AbiFUHzl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jun 2022 03:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345332AbiFUHzk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 03:55:40 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34578240B4
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 00:55:39 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k22so11244025wrd.6
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 00:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u1L7nd9RWy6bnH2I84AvftyR0eYfq9iIPGW4WLNh4fc=;
        b=giPyOWITw9taw4PaNQ0JGlbTMOUNhJwyE4M53GOoMqGDpIF+IKrbVQxeckOf1V53Yx
         LdiUXJgflNcwjcuD4jMqXEuc5hlkzV5w/Qkoo25ZOv2tILXOS93Ru4DFGWOx/dkt/PDc
         53fo6hW+pNez7BjrVXBNkqXRnEO2BXrGPypOyhQaUmy/rCACBk5DIj/k3JG80MmFw6IE
         dgXmlEWCFiHkVNiwxRewVvCBuanEzxBInZ8nvPb62dbSIlDgHjbPL3Six75dQsnInvw6
         m9th3TpLto75NFlInQpJa0MsuByDqaDyi28TZ10ClXPa4S0UCzFY3p0bqFOUBT2kGUWa
         J5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u1L7nd9RWy6bnH2I84AvftyR0eYfq9iIPGW4WLNh4fc=;
        b=sbjiJ5AUTgMmPjEt/QQPqAURD1V1aLk+NQsEOy27CPR5TuPetcDqiN6Vs7QyQYGmtw
         oH0Bob+aIEWkGXt92/wrBSsKWK9mqhK4TwYVEx9abQgJeZw38O5V12kVktOZmbW5ikme
         ysEW2v9Hh/yctJSmNehqRRvhtvDg6gR/ROti/XtLsIlGOB9el8eAM0TaNyoOVBUoD7dZ
         PKEkGlPV8kHT3qEfsw4IpLLKzn++FW0fJZIGfCN08ZdaJgC8FP1QaQbL1SktnXyIqnJs
         0dz7Vi7PoqRLjyWreeC1kFSPIN3D2FCYVzVCFjgmuWt1IEakMg9gTQQIrZYvoNdPVu7L
         0Eew==
X-Gm-Message-State: AJIora/KEFtkdDHMY6SKIe1/B4Fam+c6SWwqrT82QnNYYLQ4/lVOymHo
        qtvLyJ/PgI4LOZDXpofNHlL68TggSwlQf9jCr9Zabw==
X-Google-Smtp-Source: AGRyM1tqRuIcQxhftk2xat7q2KjLeDqf4WLTaKZ42Rx/0qBDAhBIjp4VO/TVO9DuRg2px8UBFx8TKB1DmOWWiqmowuQ=
X-Received: by 2002:a05:6000:2a4:b0:219:2aad:51ce with SMTP id
 l4-20020a05600002a400b002192aad51cemr26241317wry.719.1655798137558; Tue, 21
 Jun 2022 00:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <CALt099+y4-kJ0OqVeKaAjAbs4inOkR-WE0FmyiJRDc1-Ev9UKw@mail.gmail.com>
 <20220603124956.GA18365@lst.de> <CALt099JqRXwsGnq_DmHmnwPyB0K9Y+-BZUG_YoGxOg7G7ZZh9w@mail.gmail.com>
 <20220609042736.GA31823@lst.de> <CALt099+_EoSmigM5LizV8g7KFY=n0dcfPv4Ycw=YrCDvhJELMg@mail.gmail.com>
In-Reply-To: <CALt099+_EoSmigM5LizV8g7KFY=n0dcfPv4Ycw=YrCDvhJELMg@mail.gmail.com>
From:   Michael Schaller <misch@google.com>
Date:   Tue, 21 Jun 2022 09:55:00 +0200
Message-ID: <CALt099L=D58sMB4176nfmFFN5H_Bh7rvB3Qf5mWJ8MwtuSExmw@mail.gmail.com>
Subject: Re: New partition on loop device doesn't appear in /dev anymore with
 kernel 5.17.0 and newer (repro script included)
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Done: https://github.com/osandov/blktests/commit/e067296aa2c5ba89d8140113af=
1e8e50241275b3

On Thu, Jun 9, 2022 at 9:10 AM Michael Schaller <misch@google.com> wrote:
>
> On Thu, Jun 9, 2022 at 6:27 AM Christoph Hellwig <hch@lst.de> wrote:
> > Any chance I could trick you into submitting your reproducer to blktest=
s:
> >
> >    https://github.com/osandov/blktests
> >
> > ?
>
> No need to trick me. ;-)
> https://github.com/osandov/blktests/pull/93
>
>
> Michael Schaller
> Site Reliability Engineer - Software Engineer
> misch@google.com
>
> Google Germany GmbH
> Erika-Mann-Stra=C3=9Fe 33
> 80636 M=C3=BCnchen
>
> Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
> Registergericht und -nummer: Hamburg, HRB 86891
> Sitz der Gesellschaft: Hamburg
