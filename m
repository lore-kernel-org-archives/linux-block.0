Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18593C6FD20
	for <linux-block@archiver.kernel.org>; Fri, 24 Mar 2023 04:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjCXEH7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Mar 2023 00:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjCXEH5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2023 00:07:57 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DABBB
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 21:07:55 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id d10so384110pgt.12
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 21:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679630875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2LfQ4bUGZWvA0RhGgJPkL2wWDD5iJCeigY4j8HTk/bI=;
        b=aaHGmkeM2buhuAyL59PFubTTRpNOm1eOr6ux6+8muJ71E4GdLMqxN/ANXRS2Ff2iqT
         puytLloUQm/NIr3fW/m4egfG9EAzyZI0SVKcGavWJAQBHL+kju0K9cQxrovSDlaS6PR/
         EpyuHT9jOB/RAxUTzC09aziuazUj4QdQCE8jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679630875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LfQ4bUGZWvA0RhGgJPkL2wWDD5iJCeigY4j8HTk/bI=;
        b=5d16XaT7SbPZiB7GiZ8rdNdYse49dXOJ0raRdYOLMTIDSRRuo/kM1P7mNj+TcV3QT4
         52/vEelAcuRW1xmyfHwHDrXKmim0dhGU6DJS0ZNKg2CPCDhIf8dhowZ86HgXVO0LBwL7
         bSopsAfwv6CXzD0xeicMp3nOsI2LXiJGbVct9UYzMBgBiywyIDG/VTmjSyrwxoYliT49
         WSaKnr1zX7tbXn3OMEDtVfOifgM/xAi4CF8zJjhDR8AXXXgHJVtYmh0Jp64E0HF+TeKE
         +G7FQH3ICuwwnwU5G+nHR332E+brY6IBddmOPXoooqJZMekFfJiGSOowsTKLDkF+TcBS
         to6A==
X-Gm-Message-State: AO0yUKUbMsY5d814wgl+7lIvcZpbYMaGnVKUWJGRKiDTbzHYWcDzNLZy
        VHL5NaN6vVq7POOklddwiYiv1A==
X-Google-Smtp-Source: AK7set/p6NEs60N0pJLkWHg1ERai59XDLTc6q2wAVfQjBCptyxS1eAAboGBNMuT6+4vwwc9JM6nMnQ==
X-Received: by 2002:a05:6a00:80d0:b0:627:e677:bc70 with SMTP id ei16-20020a056a0080d000b00627e677bc70mr7152042pfb.14.1679630875169;
        Thu, 23 Mar 2023 21:07:55 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id t19-20020a62ea13000000b005a8de0f4c64sm12678235pfh.82.2023.03.23.21.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 21:07:54 -0700 (PDT)
Date:   Fri, 24 Mar 2023 13:07:50 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Mike Galbraith <umgwanakikbuti@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] zram: Replace bit spinlocks with spinlock_t for
 PREEMPT_RT.
Message-ID: <20230324040750.GE3271889@google.com>
References: <20230323161830.jFbWCosd@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323161830.jFbWCosd@linutronix.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/03/23 17:18), Sebastian Andrzej Siewior wrote:
> From: Mike Galbraith <umgwanakikbuti@gmail.com>
> 
> The bit spinlock disables preemption. The spinlock_t lock becomes a sleeping
> lock on PREEMPT_RT and it can not be acquired in this context. In this locked
> section, zs_free() acquires a zs_pool::lock, and there is access to
> zram::wb_limit_lock.
> 
> Use a spinlock_t on PREEMPT_RT for locking and set/ clear ZRAM_LOCK bit after
> the lock has been acquired/ dropped.
> 
> Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Link: https://lkml.kernel.org/r/YqIbMuHCPiQk+Ac2@linutronix.de
> ---
> 
> I'm simply forwarding Mike's patch here. The other alternative is to let
> the driver depend on !PREEMPT_RT. I can't tell likely it is that this
> driver is used. Mike most likely stumbled upon it while running LTP.

Yeah, I'm curious if anyone uses zram in preempt-rt systems. I don't
mind this patch but would be nice to add new code when it solves some
real problems. Maybe `depend on !PREEMPT_RT` can be a better option.
