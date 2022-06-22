Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098BEC433EF
	for <linux-block@archiver.kernel.org>; Wed, 22 Jun 2022 15:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359251AbiFVPUL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jun 2022 11:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359238AbiFVPUL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jun 2022 11:20:11 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFEB39140
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 08:20:10 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id t3-20020a17090a510300b001ea87ef9a3dso17114027pjh.4
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 08:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EwS/tK0Wy8erZTHFk7/rY1qOvDCv9NKxynpv49gC4Fg=;
        b=h5QQSY5FM1k34pMrtVHeDpCWCD3fnChhPtZ9D9j+Y8g38Kldqqat9sXeuHEfLMzhDP
         Sd2yj/BKtawDQSxcwFhxdSmqCrMRLjQR8Fi42r41TlbgAjY0Yv8/RP6WydX4AfxoGmKK
         wX4cQA+FkFiBBkhShO0XU99dG9OV0Dm6/EX+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EwS/tK0Wy8erZTHFk7/rY1qOvDCv9NKxynpv49gC4Fg=;
        b=ep8CR1VZ5z0K+BHdvG2Arb9y8bAewp/v4BE9jXyD+qFGTeZxJeMQohWlpuXacaCQze
         N64foxh1YlCLYDgCOKjgG2KqiQRLkAVxiJRkx335UTBhnfmZuMefHN/1uGZjS/fJXTGi
         lSPumlf/BTWO+49mhRxHQc0SPfbxKpH9v+aS2QMk5H6d+QC4VURiWkZz7O8bgoIp9OC8
         csggZjzQtdvOA+JQm/hHxh0UPDXjXeI5psR2pIe845abnwD5I7x1RpT/8wGqJhewq02D
         okUsX8M3EExB5LV0wZpY6WJyEQWf2AP4W4YVzJJvXljIC9FGP9tY9T3bBONpgOcV123J
         Mf+A==
X-Gm-Message-State: AJIora+GMQbS0O/vZ6ykh9EzI8xQq/EbvDyt6HHIwiGUE69yTUp2N0eC
        GZ7gddtcQSSiUDXCahUiz3m19A==
X-Google-Smtp-Source: AGRyM1sG9n0CEU9lxzoX0n31I6e5aLUscw6tw8AvURiwXSK6E0c4SxWjAFV1o8Z/Sricdv3zDfkcwA==
X-Received: by 2002:a17:90b:33c4:b0:1e8:6e2f:97a2 with SMTP id lk4-20020a17090b33c400b001e86e2f97a2mr4247470pjb.165.1655911209767;
        Wed, 22 Jun 2022 08:20:09 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:e2f3:d85c:2a24:ec47])
        by smtp.gmail.com with ESMTPSA id bb10-20020a170902bc8a00b0016a4a2ea92asm1730412plb.255.2022.06.22.08.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 08:20:09 -0700 (PDT)
Date:   Thu, 23 Jun 2022 00:20:05 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] zram: do not lookup algorithm in backends table
Message-ID: <YrMzJSNb4b+tODqR@google.com>
References: <20220622023501.517125-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622023501.517125-1-senozhatsky@chromium.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (22/06/22 11:35), Sergey Senozhatsky wrote:
> Always use crypto_has_comp() so that crypto can lookup module,
> call usermodhelper to load the modules, wait for usermodhelper
> to finish and so on. Otherwise crypto will do all of these steps
> under CPU hot-plug lock and this looks like too much stuff to
> handle under the CPU hot-plug lock. Besides this can end up in
> a deadlock when usermodhelper triggers a code path that attempts
> to lock the CPU hot-plug lock, that zram already holds.

And we think that we (not exactly "we", our partners) actually
see a deadlock. It goes something like this:

- path A. zram grabs CPU hot-plug lock, execs /sbin/modprobe from crypto
  and waits for modprobe to finish

disksize_store
 zcomp_create
  __cpuhp_state_add_instance
   __cpuhp_state_add_instance_cpuslocked
    zcomp_cpu_up_prepare
     crypto_alloc_base
      crypto_alg_mod_lookup
       call_usermodehelper_exec
        wait_for_completion_killable
         do_wait_for_common
          schedule

- path B. async work kthread that brings in scsi device. It wants to
  register CPUHP states at some point, and it needs the CPU hot-plug
  lock for that, which is owned by zram.

async_run_entry_fn
 scsi_probe_and_add_lun
  scsi_mq_alloc_queue
   blk_mq_init_queue
    blk_mq_init_allocated_queue
     blk_mq_realloc_hw_ctxs
      __cpuhp_state_add_instance
       __cpuhp_state_add_instance_cpuslocked
        mutex_lock
         schedule

- path C. modprobe sleeps, waiting for all aync works to finish.

load_module
 do_init_module
  async_synchronize_full
   async_synchronize_cookie_domain
    schedule

And none can make any progress.

So I think we need to move crypto_alg_mod_lookup()->call_usermodehelper_exec()
out of CPU hot-plug lock and pre-load modules in advance, before we grab the
hot-plug lock.
