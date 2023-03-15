Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063F9C6FD1F
	for <linux-block@archiver.kernel.org>; Wed, 15 Mar 2023 01:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjCOBVN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Mar 2023 21:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCOBVM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2023 21:21:12 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4F81A67F
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 18:21:10 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q189so9946140pga.9
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 18:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678843270; x=1681435270;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITvu+0H4hzdXWFaZP3EQ9AZzH/uBUt2ewtngWEwLRSI=;
        b=HbMGtm/c6i8D7knDHw9+kOWqHHvjy8NQajDpO3xMZlQVi7m5ZS9B//aup5IHE4SotN
         NozPFBP8W/WehaqSsT8ybipJdvzpr5qivCQnBM9AsXoSlc/co07y1RwBSCPZIdkPPKvK
         yxIond4pN4PpxjtYQJiJWWfYV2FfyTPgSkwdbGi6hRW0mrEHSGYma8p+N4Ac7fH2DN6v
         eE+bcLvzJynzxnEyv8Zraer+5yWtaeCQAU66rBCXQruwnHasvrEwTvmCoWpCCFvEHqec
         kuMl4zVhRuA1JDB2QrIBlM4MihvqKFZH3aBTrf8jsbzC+cyqxTbB8MpqVcAS7qD9YaTf
         O5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678843270; x=1681435270;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITvu+0H4hzdXWFaZP3EQ9AZzH/uBUt2ewtngWEwLRSI=;
        b=lENmU12qbNybdsL4Kom3rerKNsyW76DYbUoBJhvZIr+UN8ZvW5+q2kHIbxwt/Se884
         ZbD9+WpicoNLimzQT+CxjRd+hpEVGBOUys/QYQzlhSFPtQv/6/3MdaT0arXkEGHRbVrI
         PZjPkwXuwj/wpUQzTYq8fnWrNI1h0DBY95nfkr3jnYoH9OSEwBxCdF4rc+Dm3Mpo9JDe
         wUHEmHpW5UEm+cLgf5cntvfYSICmoLLX8tjy+jbnhoNVGpM0h/C6CQby7N0L1sytWAuH
         Sq5kVY7PAB2afM3PBIWTG1eBqIVchU/vs7y3GUYDVfEkRddzHBG9pbgp6nzJSc5hw3n4
         Ey6g==
X-Gm-Message-State: AO0yUKX/K9cedsPmWm0N9WPPhG5Qk/X6yKI22mpvU9po/KiZHjixeole
        eAyHSNDdU0nnT0+t8bp5MJp8pw==
X-Google-Smtp-Source: AK7set+PDFL9dZsCZr9etWTJ9GUpWDEU53BJ91UN6BYlYHRmlWdMfqx5zOI4r0qc1hNOBIzx6sh/Hw==
X-Received: by 2002:a05:6a00:26e4:b0:625:a08c:a8ba with SMTP id p36-20020a056a0026e400b00625a08ca8bamr228934pfw.1.1678843269669;
        Tue, 14 Mar 2023 18:21:09 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l17-20020a62be11000000b0062549352d1esm2199000pff.162.2023.03.14.18.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 18:21:09 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Jan Kara <jack@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ming Lei <ming.lei@canonical.com>
In-Reply-To: <20230314182155.80625-1-bvanassche@acm.org>
References: <20230314182155.80625-1-bvanassche@acm.org>
Subject: Re: [PATCH] loop: Fix use-after-free issues
Message-Id: <167884326867.17000.10454351781372505992.b4-ty@kernel.dk>
Date:   Tue, 14 Mar 2023 19:21:08 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 14 Mar 2023 11:21:54 -0700, Bart Van Assche wrote:
> do_req_filebacked() calls blk_mq_complete_request() synchronously or
> asynchronously when using asynchronous I/O unless memory allocation fails.
> Hence, modify loop_handle_cmd() such that it does not dereference 'cmd' nor
> 'rq' after do_req_filebacked() finished unless we are sure that the request
> has not yet been completed. This patch fixes the following kernel crash:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000054
> Call trace:
>  css_put.42938+0x1c/0x1ac
>  loop_process_work+0xc8c/0xfd4
>  loop_rootcg_workfn+0x24/0x34
>  process_one_work+0x244/0x558
>  worker_thread+0x400/0x8fc
>  kthread+0x16c/0x1e0
>  ret_from_fork+0x10/0x20
> 
> [...]

Applied, thanks!

[1/1] loop: Fix use-after-free issues
      commit: 9b0cb770f5d7b1ff40bea7ca385438ee94570eec

Best regards,
-- 
Jens Axboe



