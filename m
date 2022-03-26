Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4574C433EF
	for <linux-block@archiver.kernel.org>; Sat, 26 Mar 2022 19:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbiCZTSC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Mar 2022 15:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbiCZTSA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Mar 2022 15:18:00 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33F07C157
        for <linux-block@vger.kernel.org>; Sat, 26 Mar 2022 12:16:23 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id v12so1514988ljd.3
        for <linux-block@vger.kernel.org>; Sat, 26 Mar 2022 12:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cnXQMxTCjuK4qy9Z6rkrcod3DmyuqMLPfF2FwH3SpN8=;
        b=bCs57BhhsoW00lBzQRMs/4XoNlbiHwKv6eU2ZdjBDNdcCDmE9zNM57EzubgpNI/NHO
         HyB/nCCaDT/nI7Oi5Rdh1FKr96y/zNtFfDRi1rtF9iqq26EQraSkZLdtTTuIbuc4NJhV
         tFpXwXn6oKsMB3DKgM8hDJ/rtV4Jqa+p0K8fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cnXQMxTCjuK4qy9Z6rkrcod3DmyuqMLPfF2FwH3SpN8=;
        b=RtqK5TAbLlysIEgfIs4o/UAq2iE9bli879eYvSDcwpqFOZ6aTv8qQ8aj+Y4dUF/PmQ
         qc515OZe86JxgQ4R9hn/YyWM6TpXWj/qLHnfSK57B3MrumZLt5UqO4HT4ZkPmFzEbGOj
         I6to9def1arI4heFTK+0+tLjJq+obqGxJgL35m0F0HDgMlGA5EwFn49E6FCH4DajFgsf
         R3mTE8qgX9fSsyIhtoog4ZmmjHW8gasTwYYIFzySe0MxNfv2cp4OI0fOrPu6dgYDbjn0
         W07JX1uvc25qX2RZP6p8492MtJacHGk/jKc99+yXbXocoT1MVjfwOwMdt5GRnUAUmvfg
         k20g==
X-Gm-Message-State: AOAM530nJX6Hsu0JKpyjWJYeZfPnNZHVpntcM1JbYHeCcrnYBPvzCGqy
        +zQx9N8ZBW1++fZdcViv0jdY7TL6OgF9XjRIT6Q=
X-Google-Smtp-Source: ABdhPJxfskYBZb5hAgsAG6tJo2MYuH9Ly9Nk/V7NVfpwkTpEbfSAIb0bS0pu5WMZWfPnP8P5OQNW/Q==
X-Received: by 2002:a2e:4b1a:0:b0:248:484:b45c with SMTP id y26-20020a2e4b1a000000b002480484b45cmr12953711lja.419.1648322182057;
        Sat, 26 Mar 2022 12:16:22 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id y22-20020a2e9796000000b00249b86a210bsm650870lji.91.2022.03.26.12.16.20
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Mar 2022 12:16:21 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id p10so12653427lfa.12
        for <linux-block@vger.kernel.org>; Sat, 26 Mar 2022 12:16:20 -0700 (PDT)
X-Received: by 2002:a19:e048:0:b0:448:2caa:7ed2 with SMTP id
 g8-20020a19e048000000b004482caa7ed2mr13301860lfj.449.1648322180275; Sat, 26
 Mar 2022 12:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <37e3c459-0de0-3d23-11d2-7d7d39e5e941@kernel.dk> <CAHk-=wh5AdZUOR8xYc6cxM2wZ_CtanV+e+B6b6pBsha9XXwxbA@mail.gmail.com>
In-Reply-To: <CAHk-=wh5AdZUOR8xYc6cxM2wZ_CtanV+e+B6b6pBsha9XXwxbA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 26 Mar 2022 12:16:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whW+8NP5hgm7f5CuoOOKgda4kE3pXM20UY=ttjgiL6B5Q@mail.gmail.com>
Message-ID: <CAHk-=whW+8NP5hgm7f5CuoOOKgda4kE3pXM20UY=ttjgiL6B5Q@mail.gmail.com>
Subject: Re: [GIT PULL] Support for 64-bit data integrity
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 26, 2022 at 12:14 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It isn't generic enough to make sense. "48" just isn't a common enough number.
>
> Maybe

This got sent out early by mistake. That "Maybe" was supposed to continue

  Maybe a generic mask implementation could be useful, but not this
special case.

or similar.

           Linus
