Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1ADC433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Apr 2022 01:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240241AbiDYBwB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Apr 2022 21:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240236AbiDYBv4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Apr 2022 21:51:56 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1DC3AA5B
        for <linux-block@vger.kernel.org>; Sun, 24 Apr 2022 18:48:51 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id k27so1558100edk.4
        for <linux-block@vger.kernel.org>; Sun, 24 Apr 2022 18:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AMq90c3EMg7Fo2DoesguV3visvIyItzGt8+NgqwW1jA=;
        b=N0lnR+lEWZ2JpvJDFYtPnAWSABeP6Qu+dzIw6plNSyp/DjwEjP3Of8osZGCMWR0Qiz
         AO3jGmjwm4/zb81Wz6+VsPB0OJbLdcLE2htsbPovDbzBiMlSwTFviIODAPboLtqR9mGz
         5LEGQJFhe0HioZkY/xSlKmgtx1+QZFIMdfibA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AMq90c3EMg7Fo2DoesguV3visvIyItzGt8+NgqwW1jA=;
        b=hUcdTXoZrXjdsSreHYg24iHsgK7ZDr79HTG5PngGB34qqB+f/9iPObdyPPXd90PCih
         9rLOibAkQqFTepDIOTGITbxmkqRkBmz/CDG6aLeiIccrsxcNoKWvm8eDnXll6fOh9T2V
         J7ywK8K4u27w/nS2ZhicHXv+XRzVuzSU/Q2S1zGfkxYQup+jncC4YTWB/h7lmPA1MLqW
         rPwvS5dh0xpxDRyInIDRooloQu3Ix6sAUu+XIgWAK/9mdpkKm6P4GN92/CveDAc8dAVX
         1YucbhasX3bScOwD+5AOicEosWpqkwq+T5ti8eqEqd2rdWjQMnPckcWjYF70orgM6vBw
         yZBQ==
X-Gm-Message-State: AOAM530CWAxTRx2FiyeJJ2KPbfW+F3glgqMGusfXGWIlTZ2kHG7WQ+pe
        4EC33qNCnlA7zyq7V17QNku7D/8gu71oIRxifQ19zw==
X-Google-Smtp-Source: ABdhPJwZOqrqMruNYx6fZ+JTZUfCJwGibdcad+m1P70jVJs4UKuBc6rZxzI1DBU1HjF8rnWSebMP2c1jAWoVl21Lovk=
X-Received: by 2002:a05:6402:f1c:b0:41d:8bc7:cd26 with SMTP id
 i28-20020a0564020f1c00b0041d8bc7cd26mr16460882eda.47.1650851330313; Sun, 24
 Apr 2022 18:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220422115959.3313-1-avromanov@sberdevices.ru> <YmMPpaseLn4i6MYk@google.com>
In-Reply-To: <YmMPpaseLn4i6MYk@google.com>
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
Date:   Mon, 25 Apr 2022 10:48:39 +0900
Message-ID: <CA+_sPao6mN5hwFEanGuAM6YeM+RYiKbortwNech3-cLfMsGuDw@mail.gmail.com>
Subject: Re: [PATCH v1] zram: don't retry compress incompressible page
To:     Minchan Kim <minchan@kernel.org>
Cc:     Alexey Romanov <avromanov@sberdevices.ru>, ngupta@vflare.org,
        linux-block@vger.kernel.org, axboe@chromium.org,
        kernel@sberdevices.ru, linux-kernel@vger.kernel.org,
        mnitenko@gmail.com, Dmitry Rokosov <ddrokosov@sberdevices.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 23, 2022 at 5:27 AM Minchan Kim <minchan@kernel.org> wrote:
[..]
> The 2nd trial allocation under per-cpu pressmption has been used to
> prevent regression of allocation failure. However, it makes trouble
> for maintenance without significant benefit.

Agreed.

> I'd like to remove the double compression logic and make it simple.
> What do you think?

I'm all for it.
