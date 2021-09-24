Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B44C433EF
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 20:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B919611C8
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 20:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345982AbhIXURh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Sep 2021 16:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345521AbhIXURh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Sep 2021 16:17:37 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA53C061571
        for <linux-block@vger.kernel.org>; Fri, 24 Sep 2021 13:16:03 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id bx4so40586289edb.4
        for <linux-block@vger.kernel.org>; Fri, 24 Sep 2021 13:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dma3ODYRAwAqQNgxjoPPmrM71vwSjvGubtDE6+J/Uj4=;
        b=TCKaE7TNX17wekyhEJMq0Q25AVyKWiZRP+g/+Gp/8PWclgr/jK3NrgttQdr7wcLdXR
         Q7Vui+5HdK/XtCPVLRA1f3pBVqdfXx9tpC6sVw/nnEysSkKizl2mQK1SQUekXcJnHoZb
         iKS9R9k/fhu93FJDzD8w8K1oJinhGnJ23XrS0RrTKDPGUkbMcQkqosdn1u9ndrmaqYVX
         aY+QtdNzVtWH36uUWKCcNE6ZOBnMcRs/Ux8HSJmt9kBinzOvcfA/PBdBGjSEj4T5I68L
         agEiE1FY6qB/1zx1Jyhcyw1sMqbjO4VrSZY6VVVg4ZwmbJQMY9JC9tCVJhGtQbWB3EHK
         KETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dma3ODYRAwAqQNgxjoPPmrM71vwSjvGubtDE6+J/Uj4=;
        b=GB834pqJ12XpGjTPGYy7ciGscAADdSBsLpa/p+ZheWQ+R5pnO4ZmxTSRvFZOEkel/j
         GFsKs1pSpBW8Yi043U6xu7ug2hhcFT5UfFYc9jb19l+KyCcFc6pJYH86ZevUjkmwwROM
         unvWkv6fI3MRoqPChRiFtpuQGFakTx78NADvkD49MW2HpzXysS3idqRUjhpZ3zqq9oRb
         3Pn8b/Drbvt729A/YDGklRkAdVSPH0KPpAfA9ndYOn5rlWma9Na3asvUlvoYwqdEp4Ax
         R30ANE/2KMdkBqblQYffmAP4u1kmdumXyriIrFKJxZgDzcOSPL6H2GNOSDNeYRi1Cr2T
         5vjg==
X-Gm-Message-State: AOAM533wrMPAa/82GfSsqw6ZRehR4UG0efB7t+ex+C/3KyqiwWVcTpy+
        5mlPvozzgGhLlXPMUYP2D/rLXpzRNtnqtIYXBHhEAw==
X-Google-Smtp-Source: ABdhPJy+GO7D85GdcvOuwQ7T61FovB7Jo/xuxyb7T+18+fqF4fp9j9ohG6KW8vkKyjgJq4w4BsZG3i2clMRE46OOnIA=
X-Received: by 2002:a17:906:2bc3:: with SMTP id n3mr13014432ejg.548.1632514562127;
 Fri, 24 Sep 2021 13:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210917210640.214211-1-bgeffon@google.com> <20210924161128.1508015-1-bgeffon@google.com>
 <20210924125422.358374d83cdb95db055a4467@linux-foundation.org>
In-Reply-To: <20210924125422.358374d83cdb95db055a4467@linux-foundation.org>
From:   Brian Geffon <bgeffon@google.com>
Date:   Fri, 24 Sep 2021 16:15:26 -0400
Message-ID: <CADyq12xAc4Y5P4n69oahPNs6M55cUb6=7Nku=J5iEOJVMBOPTQ@mail.gmail.com>
Subject: Re: [PATCH v5] zram: Introduce an aged idle interface
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org,
        Suleiman Souhlal <suleiman@google.com>,
        Jesse Barnes <jsbarnes@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> Also this?
>
> --- a/drivers/block/zram/zram_drv.c~zram-introduce-an-aged-idle-interface-v5-fix
> +++ a/drivers/block/zram/zram_drv.c
> @@ -309,9 +309,8 @@ static void mark_idle(struct zram *zram,
>                 zram_slot_lock(zram, index);
>                 if (zram_allocated(zram, index) &&
>                                 !zram_test_flag(zram, index, ZRAM_UNDER_WB)) {
> -#ifdef CONFIG_ZRAM_MEMORY_TRACKING
> +                       if (IS_ENABLED(CONFIG_ZRAM_MEMORY_TRACKING))
>                                 is_idle = (!cutoff || ktime_after(cutoff, zram->table[index].ac_time));
> -#endif
>                         if (is_idle)
>                                 zram_set_flag(zram, index, ZRAM_IDLE);
>                 }
> _
>

Hi Andrew,
As written that patch won't compile when
CONFIG_ZRAM_MEMORY_TRACKING=n, my guess is that the compiler pass that
removes the dead branch only happens after it attempts to compile the
branch itself. So it appears that even though IS_ENABLED(..) always
evaluates to 0, the compile will fail because table[index].ac_time
does not exist. You should get an error like this:

drivers/block/zram/zram_drv.c:314:57: error: no member named 'ac_time'
in 'struct zram_table_entry'
                                                             (!cutoff
|| ktime_after(cutoff, zram->table[index].ac_time)))

Brian
