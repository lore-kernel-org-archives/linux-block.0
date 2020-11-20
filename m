Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFECC63777
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 09:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C7F622210
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 09:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHwYJIYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgKTJKZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Nov 2020 04:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbgKTJKZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Nov 2020 04:10:25 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60ACC0613CF;
        Fri, 20 Nov 2020 01:10:24 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id r18so6769894pgu.6;
        Fri, 20 Nov 2020 01:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CjaLATDl2cTUYsdiLtOBub9W4/EnK9k7yCEhJHGSsUo=;
        b=XHwYJIYYFCn+voouE0ynk+0BkN9YnMFxz/Jv3LfYVdt/zjgG8+mdPbxnlJfZ3P9De6
         JHG2D97HECDDK76xIPaVJIq2vKIr/Mig9sZlLlltoNaiAuQeB42NNaVCE/gG/XolNcTP
         Z80TC914UxYKrpe/o+zhm91yYhVdPm/raiFWmYZUX9ZBsQ0J7DDwYYyWIo5JhEy4SA3V
         Z9K8KbxmTF4O3F5o2mNvzDpJCC5DSpWKXyjkArXYnmSU0QSWr5WNa8bIepBeJhZY1vSl
         gnOheyk/Fq1w2bMVF302VEEGX2ohUXXTmnpIre3gsu0Qcxv9QaisjNkpBFt03VQLQQMA
         Zvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CjaLATDl2cTUYsdiLtOBub9W4/EnK9k7yCEhJHGSsUo=;
        b=hvsJJFub7h1zavq5fzLEWLMuyObGgns+ByuceHONSskpJ7EHMUtUIPXVSUdxrYLfLC
         LI43RAhrK5phriqjlskCp/jI5WRf4isw3VX6U2fGh3Q0Ibua2aD10DVApHwiZ4RwtN7M
         0kinhZcfv8SPvoeblLNfTWBkr1gccz7AdoMWMBDKedo/dOcUuhXyk5hWfTcnDrTr8am5
         Z4i1pP+IeyvUOkP01xi498EPADDhTF86YTee5leW7QQmlI9XsoFHiBk0YibNvwQBi9QL
         LuDH195869IYA548wialIfuVpw/xH4uNsA6bcC4c+NFmYTSdnXKyA/7tbjr17l1qtep2
         5jTQ==
X-Gm-Message-State: AOAM531nDpLQpPu4ElYWN3JsO7mMXeiyWIUVNpDHUcIA7cH8+odXPxdF
        CgwHeZVzuWAJhCSwoil9cW/PS83LLV/X/tqnjg==
X-Google-Smtp-Source: ABdhPJxvr2Bzc6LIEbyDz2huULyNlz0t3Oe5MFYawGoKKWmg8wT1pcYcO7bKei8ocujSEGmx75RoBXyegZURPd4BIMk=
X-Received: by 2002:a62:1408:0:b029:18b:78d:4c4b with SMTP id
 8-20020a6214080000b029018b078d4c4bmr12711553pfu.25.1605863424495; Fri, 20 Nov
 2020 01:10:24 -0800 (PST)
MIME-Version: 1.0
References: <20201115101514.954-1-rsalvaterra@gmail.com> <20201119222610.GD3113267@google.com>
In-Reply-To: <20201119222610.GD3113267@google.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Fri, 20 Nov 2020 09:10:13 +0000
Message-ID: <CALjTZvbK6_UqDQFhMxdEQAR-FbsZKrztkEFronvoFpLUWsi_gw@mail.gmail.com>
Subject: Re: [PATCH v5] zram: break the strict dependency from lzo
To:     Minchan Kim <minchan@kernel.org>
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Minchan,

On Thu, 19 Nov 2020 at 22:26, Minchan Kim <minchan@kernel.org> wrote:
>
> What's the purpose of ZRAM_AUTOSEL_ALGO?
> If you and Sergey already discussed, sorry about the missing it.

The purpose of ZRAM_AUTOSEL_ALGO is to make sure at least one of the
required compression algorithms is enabled, either as a module or
built-in. I believe Sergey agreed with the reasoning behind it, but
he'll let us know if I misunderstood. :)

> Below doesn't work for your goal?

Unfortunately, it doesn't. :( It breaks the dependency chain, allowing
you to deselect all compression algorithms in the crypto menu, and
consequently disabling zram. This is only my opinion (and I know
select directives should be very well justified), but I believe that
it should be zram to make sure its required libraries are enabled, and
not the other way around. Having to select a compression algorithm in
the crypto menu for the zram block device to appear in the block
devices menu seems backwards to me.

Thanks,
Rui
