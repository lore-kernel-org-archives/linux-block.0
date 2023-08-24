Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673DBC6FA8F
	for <linux-block@archiver.kernel.org>; Thu, 24 Aug 2023 15:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjHXPSH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Aug 2023 11:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242264AbjHXPRh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2023 11:17:37 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B32EC
        for <linux-block@vger.kernel.org>; Thu, 24 Aug 2023 08:17:34 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b974031aeaso106514961fa.0
        for <linux-block@vger.kernel.org>; Thu, 24 Aug 2023 08:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692890253; x=1693495053;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x7QFTOLH78RvEs9lsDd2isR/kznJbT884Moit9I1Mww=;
        b=F8HYc2wlHQh7sFZRJXll5V+x4kkYAC97g23LuGAMfPuLh40W93RLLYxh4vUe4wYP0w
         Zy5nK9hW2b8Jd19JogoFt/PXkPGoCYhQktI7+C5DSN9XigtBd0E7KejfgQsPimFqN0VE
         q1bhBoVHKaX4CQvbiFWH1gAGc4bB3J7jIdnojT1KVWQqJk2Vovdd7YngZOZOioMl0vwY
         honm76e8nfgXhvn8IBVJHXxGWpvwrxiHHOCnGXgq57yGnjz9hezb8yTfcZnY8XJw0ydL
         u0lpf10gvJALa1QGZ9HReny0k2v7U22Ip6DnPQkogOjKTvMSP/1l8ij+sEsoswoB7JS5
         yu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692890253; x=1693495053;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x7QFTOLH78RvEs9lsDd2isR/kznJbT884Moit9I1Mww=;
        b=WhpVIMmYfGPPZhOnBc/0ffXDGmupog/YgcUmQalgetOdA6S2QcKOlSIi+YOAV1ctXI
         G5i7YF5bJGwiSvi0IlKpXLGr4cYzWy5fZbnO4vOvWoYfO/sTlZC1zL3lDjUaoovi6fdZ
         hw8yRl6+27zCoMOeNmaMOIwqX2nuYuF6xtmcUjiYIrLCNzz5umJgzd8Pv4coAJHWHXPK
         IF8SHVCZmWJ+TDJddu0LyMbN04zI5q1K7+EM3snr5dy/fvhDMAe1zEvBIJoEgx276uIe
         JbEUkWWsBC9ElQPU8ZdXtxluMCxs7C0wwSRvDY94nIoRZy/QQ+6/IanYGrt26VlWi2H+
         UajQ==
X-Gm-Message-State: AOJu0YynOKO6MDMSTD6RZvIcj9yVmHxyrzQXlPs7AH0q7MPngCN3LPdl
        jaH7Oh6F1MhbI0JzdLQAGL1lR8EVSLxCcOELpuKk9ws6c+4=
X-Google-Smtp-Source: AGHT+IHLoSnR9wy0dD8HrHwRkD+cEwUF9Knq9ENj7AVSCpebugJsaTRmSWA3/gXe7kCvjkqLDIlIRGidCjZFkVZIh+0=
X-Received: by 2002:a2e:81d5:0:b0:2bc:e882:f717 with SMTP id
 s21-20020a2e81d5000000b002bce882f717mr1709229ljg.53.1692890251788; Thu, 24
 Aug 2023 08:17:31 -0700 (PDT)
MIME-Version: 1.0
From:   Xinying Song <songxinying.ftd@gmail.com>
Date:   Thu, 24 Aug 2023 23:17:20 +0800
Message-ID: <CAMWWNq8NavOF0hf3+RmfVJeM3VbLnuMEXXyYfbhQbQsH+CBvog@mail.gmail.com>
Subject: nbd: double reply err, how can nbd handle tag change after interrupt?
To:     josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
Recently I find the nbd module of my server complains aboult "Double
reply" error when using rbd-nbd. With more investigation, I find every
time the error occurs nbd module is returning STS_RESOURCE to block
layer due to EINTR in sock_sendmsg. When the block layer get a
STS_RESOURCE ret value, it will free the tag of the request and
reallocate a new tag next time the request is being processed.
However, when the request is being interrupted, nbd module may have
sent the nbd header of that request to nbd server, so it is possible
that the tag of the request that nbd server gets is different with the
new tag in nbd module for the same request. I don't find any patch for
this in mainline. I'm not sure if my analisis is right, hope anyone
can help to explain. Thank you in advance.
Best regards.
Xinying Song
