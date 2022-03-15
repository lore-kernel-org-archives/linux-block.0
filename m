Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926D0C433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Mar 2022 17:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350552AbiCORgQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 13:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238293AbiCORgP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 13:36:15 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADA4338B7
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 10:35:02 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id hw13so41060338ejc.9
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 10:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=01vubDCka59+RytoWaJjo8FyvSBZWQhJIVc+vafyJ0E=;
        b=fxRcChAFjOVezx4HjRe0TkRKHQAIxaquoe4fNRsez2/ZTv7c1Hedfsw72FAvxFxT2b
         G8Sb2r0a4mjCmehTMgpQ/PBF3fhYmsjHRGLe/D1pAWwkrV9gocgmWB54/1u0VtYQBgUW
         W/sA0shGDck8Vths0eWpWcEwySkbWiJCiFLe8TYDTgAoBoddox/XevAiaeUfYEw8SrBz
         uOXrh33AR4t5sdVQse9DRha1jcKuZIWrZWaPcF8evyb5Gfasa659KzWsbVHjVMEZz2Vi
         V8Cnsx7ywhxqOmpWczX2WdEcpn2NU3opjtfmEu2+UusCXSlRGsRMkXudbN8A9I11kaYa
         PwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=01vubDCka59+RytoWaJjo8FyvSBZWQhJIVc+vafyJ0E=;
        b=7SyYivoiDXGXMs0SrjG7rcwBPTcCL3QzFxyv4GscD5Rbg08FbCo8VgPNZ6+hdLfJXp
         RLSkZcm+iS+bPuP6D8LdjMKUtLfP9KRD8gGeUY2vgGCSMOnG/1rwXQc6kTCVvV9HCG5a
         JtiAtxEOU6jixBLmL4Jul6Knd74Y3ycayHsQEsQs5J9/hugY9iR7yYujvKm1J5jeQ2yz
         Wbu+KzbX2YOzBAmoWTxwzB2Q0t3ILpoY3SmrXvE003wYzI1X+aKPCtgBJ7BEkZgqfuJa
         U1EQ3qsbDdqv/BMB1LTiJf2ExXgDVhlJkA9M17O7FiydHlm8ro5qJMXeL4twkgt5yycV
         Wasw==
X-Gm-Message-State: AOAM53077efQNa9zimAMDS30gn9LneAJQnskR8aiXXcCSggzHzMFa77b
        iakZRa4vDuMwuNoeof1wzYAZyAEGmThg5VqyhPOgiw==
X-Google-Smtp-Source: ABdhPJwlZTvVcqHl5XIEdYScyeQjLdixdoVpg6f/gEKQhUTzLUEU4xkUfpNk5HQuHkCX2rgh0KphrFfAvLY0rZjSKk0=
X-Received: by 2002:a17:906:6a24:b0:6db:ad7b:9066 with SMTP id
 qw36-20020a1709066a2400b006dbad7b9066mr17480090ejc.697.1647365698176; Tue, 15
 Mar 2022 10:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220315172221.9522-1-bgeffon@google.com> <YjDMo35Q/cvPLkxu@casper.infradead.org>
In-Reply-To: <YjDMo35Q/cvPLkxu@casper.infradead.org>
From:   Brian Geffon <bgeffon@google.com>
Date:   Tue, 15 Mar 2022 13:34:21 -0400
Message-ID: <CADyq12yK+qODV2ut1acjwkyXKDbh_YS3MHpRoJaq_g9G1HAyEw@mail.gmail.com>
Subject: Re: [PATCH] zram: Add a huge_idle writeback mode
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linnux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 15, 2022 at 1:28 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Mar 15, 2022 at 10:22:21AM -0700, Brian Geffon wrote:
> > Today it's only possible to write back as a page, idle, or huge.
> > A user might want to writeback pages which are huge and idle first
> > as these idle pages do not require decompression and make a good
> > first pass for writeback.
>
> We're moving towards having many different sizes of page in play,
> not just PMD and PTE sizes.  Is this patch actually a good idea in
> a case where we have, eg, a 32kB anonymous page on a system with 4kB
> pages?  How should zram handle this case?  What's our cut-off for
> declaring a page to be "huge"?
>

Huge isn't a great term IMO, but it is what it is. ZRAM_HUGE is used
to identify pages which are incompressible. Since zram is a block
device which presents PAGE_SIZED blocks, do these new changes which
involve many different page sizes matter as that seems orthogonal to
the block subsystem. Correct me if I'm misunderstanding.

Thanks
Brian
