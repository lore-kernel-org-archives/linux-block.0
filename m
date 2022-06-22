Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C83EC43334
	for <linux-block@archiver.kernel.org>; Wed, 22 Jun 2022 17:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377401AbiFVRqu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jun 2022 13:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358743AbiFVRqt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jun 2022 13:46:49 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0969F35ABC
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 10:46:49 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id k15so1365254iok.5
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 10:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=qAFCZk1NpVWo7GACDd4Q9nQOdX9qli/cCrDJzW19dwQ=;
        b=lM5cc9jWKp7RMHHJ75oZ37AW6q6b8mQRBreFoYC3I6pOVGQcBNw65VTfvh8PlePDYJ
         dvh3zvQY63KLX31kXiq4tvdT5W9cg6Rt1yHnm95DvhcIsxUuuYtv3FvNiR+83ksfcTF6
         9v7n/6m+OWci0gpOI3W16UxBwikLDmtC8BFsaw0yGwSWjNqDd3D0vDWu8FQiILeWOaoM
         tuSYOoXOHv+mLy0rD9NjhB9umTJ88vIzri9RzMTrLbOz0+FemoyEQkxag282ueCulIom
         1H2azU5y6v4ClOnv7/wi7HuxqR6imiozXSJbOgCKa4426hFKBMYjo48s4rRcF/VEgD3h
         /b6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=qAFCZk1NpVWo7GACDd4Q9nQOdX9qli/cCrDJzW19dwQ=;
        b=y7nI+ooVsedIGNpMvofG8nFUNFefH94Px3XgB2ot46BDb+Qc0PMwr7XsyK5ojjB5dz
         1S6POqx8zj17F/DwH/bb+yvkF1nF7eBGPRljl/6M7kCGFSwnIzBWw2YLBOMU+LHjst5g
         qSqB6/xcWs1/eihZgAeNPlvzFNLPgNkwBBQWmdbUtr3BcObGwXkl1GAWUENRBcMygsUy
         J+jJGb8Uzo51M9Z0RdT6d64KQ05obT+CrTHFoAUwKsUTFWcFfujc/1uI+aMDJdVS88PD
         Brg4KeqO7c6tMgHSBZLA8ZiZFRgBKWd/TCSLwQm53MQpPm+8RBwGhW13GPAl5tDeA4D8
         JZ5g==
X-Gm-Message-State: AJIora+dQR0jfNAF6rwl96LNjrJmRcYGY6vjeA/cKKlysX11+/dMoM1n
        rT1gB2/4sMhEaBDw2/J9jXiENQ==
X-Google-Smtp-Source: AGRyM1syLNDaG6ZwDSYIn5KpK1ELHjQy2WoZOIfSeKXJTPgNarzU29JKzuBPU10qdLATx8e/Oe1+Hg==
X-Received: by 2002:a05:6638:1a8e:b0:339:cb8c:df22 with SMTP id ce14-20020a0566381a8e00b00339cb8cdf22mr2885136jab.152.1655920008372;
        Wed, 22 Jun 2022 10:46:48 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m18-20020a02c892000000b0032e79d23f8fsm8721910jao.156.2022.06.22.10.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 10:46:47 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com, bigeasy@linutronix.de
Cc:     tglx@linutronix.de, linux-block@vger.kernel.org
In-Reply-To: <YrLSEiNvagKJaDs5@linutronix.de>
References: <YrF1p2n0MxHQ3fcJ@linutronix.de> <YrF5uf4ZL7Oh7LVJ@T590> <YrLSEiNvagKJaDs5@linutronix.de>
Subject: Re: [PATCH v2] blk-mq: Don't disable preemption around __blk_mq_run_hw_queue().
Message-Id: <165592000770.77505.5790006044844979572.b4-ty@kernel.dk>
Date:   Wed, 22 Jun 2022 11:46:47 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 22 Jun 2022 10:25:54 +0200, Sebastian Andrzej Siewior wrote:
> __blk_mq_delay_run_hw_queue() disables preemption to get a stable
> current CPU number and then invokes __blk_mq_run_hw_queue() if the CPU
> number is part the mask.
> 
> __blk_mq_run_hw_queue() acquires a spin_lock_t which is a sleeping lock
> on PREEMPT_RT and can't be acquired with disabled preemption.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: Don't disable preemption around __blk_mq_run_hw_queue().
      commit: c9198d784fa93d447afe8e4627dfe205f0ce5ec8

Best regards,
-- 
Jens Axboe


