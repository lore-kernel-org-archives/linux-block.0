Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F01C43334
	for <linux-block@archiver.kernel.org>; Thu,  9 Jun 2022 07:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbiFIHKv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Jun 2022 03:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiFIHKu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Jun 2022 03:10:50 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F47F2424A2
        for <linux-block@vger.kernel.org>; Thu,  9 Jun 2022 00:10:49 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m26so19639512wrb.4
        for <linux-block@vger.kernel.org>; Thu, 09 Jun 2022 00:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JJz/uKfPsh9RRifdT1nn+CMGqnTBCL20lTm/X6d1lqM=;
        b=jsNs38uwEJLDzfg6iOVlGcTuNTHg/2wCkchmIoHgHbUnNvDYT9jX4odCdFR1X5HOVd
         1oO4u6OSo5Jly3z6iRdb2d85wNER+NQ1fcTpyL/ZvioaAqRUTHW4wLmm/yLSNaqDyCJw
         DYA3VByqbOklwDmNBCd3Tz6Zrj1nqbAVHzPmPMudE1tO4p289AF0MZLZi0bRdM+b9D9W
         X+2K8SxU4t1PW9cq/KRjsO+qOEDxsDmujcMAc1jb2Z9Ldd28793q6hEIT5lwZiCcJa4d
         8VCA8ZF12pUDq5TbPSNRKxaotT9xQSNfqV68lphOy6+zyN+6gT46IGjOqRORnl7U6oh/
         dA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JJz/uKfPsh9RRifdT1nn+CMGqnTBCL20lTm/X6d1lqM=;
        b=rPx2Q2uYDfpDxBiZOtIoiWAcgGg+Q5814rI8kx34ssm4TWCxBPUEXtZClv4wtl4zcn
         i16fivOYPot4OW8fJUwvAIApANfcOBbqBqMfax2l0Re8gnp6NFKw0FuVWGlqBKqF5Y5S
         B+nXSkHrNYkCErle1Xow7WRQ/b+h6WqTGbDJ7AHufOWGPI0+jNDeqGnjDeuPWwPr+EDs
         +XfGAtnsGsGVf5bivquQXZrKuL43TVZnQbn29f7HdplaAfR8P8iwgPTSFD1tQWP5688q
         WYtVAGndcym+paV2mZWo0AF17EAQJhUAtwAHbnqbGU72fOyuJZzPo7CIdnRNqUupXARV
         mu2Q==
X-Gm-Message-State: AOAM533Tlt2zO8NJgjIYztO7ceQaZQawFFRWCtMh2Ti8E3rtOHnjgeNd
        S5zDf3zijx6tnHfbCteIg0eU9gWHcApjEWG5sCW1kg==
X-Google-Smtp-Source: ABdhPJylcxfa8lk6sZMPzVdU/PBo3dJQN7FnVwb7dERZQ14FpQB8ahwTtYVRJy9R0o2eeSEMfYKbluxOe47pBBMdUwM=
X-Received: by 2002:a05:6000:2a4:b0:219:2aad:51ce with SMTP id
 l4-20020a05600002a400b002192aad51cemr5208677wry.719.1654758648006; Thu, 09
 Jun 2022 00:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <CALt099+y4-kJ0OqVeKaAjAbs4inOkR-WE0FmyiJRDc1-Ev9UKw@mail.gmail.com>
 <20220603124956.GA18365@lst.de> <CALt099JqRXwsGnq_DmHmnwPyB0K9Y+-BZUG_YoGxOg7G7ZZh9w@mail.gmail.com>
 <20220609042736.GA31823@lst.de>
In-Reply-To: <20220609042736.GA31823@lst.de>
From:   Michael Schaller <misch@google.com>
Date:   Thu, 9 Jun 2022 09:10:11 +0200
Message-ID: <CALt099+_EoSmigM5LizV8g7KFY=n0dcfPv4Ycw=YrCDvhJELMg@mail.gmail.com>
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

On Thu, Jun 9, 2022 at 6:27 AM Christoph Hellwig <hch@lst.de> wrote:
> Any chance I could trick you into submitting your reproducer to blktests:
>
>    https://github.com/osandov/blktests
>
> ?

No need to trick me. ;-)
https://github.com/osandov/blktests/pull/93


Michael Schaller
Site Reliability Engineer - Software Engineer
misch@google.com

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
