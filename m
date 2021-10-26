Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C011C433EF
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 14:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4BCB60F90
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 14:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbhJZOkw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 10:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbhJZOkw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 10:40:52 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40420C061767
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 07:38:28 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id m184so1978935iof.1
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 07:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=7+EArhrIY4MVSbuy3zRONci7xFN/KF1Jf5rbrzI4fF4=;
        b=r/KcJ6JAtLru50iQJ/xukzmB2L0lEhomu/spDHpllGx2ghN+LVv6eOQm7qM+6XxwmW
         /T0HXICEiPxTqWBnSTjKwiIzZjL8WalwVAFBs7hxEmN70jUfIKZnvKm3Q20PgyJQOz53
         K2o1M99x7gW3X1+4WbDNCrksHM9y9MD+Sj8X8XD0sY3voiGbD8WFiLqPrWsezrc+tFyP
         IOeLJ0GS2raYIFmjFUX39wvotr5ZX6w8V/frAVfDRzBqKL+cO+nUwkDDe/i9+A/yHv4B
         fD7YvitZguMazJSKEmN6ZYpqmmT4HUP1Uz36gHDxiwVkEWNxBtjMpAnlTuG4XRWW64en
         Wecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=7+EArhrIY4MVSbuy3zRONci7xFN/KF1Jf5rbrzI4fF4=;
        b=H6nmEVcYRBOcDGj9fw5a5PXB6i6tys9wekPDfRySd4EKradnAgjZN0+XOdTm7k4TsC
         72s9aNCCxIn4ldmjaW0Ti0XLjzXVoyaHEEGzVXAeV3l0GFsAstnuK9kchVlYCOxNM2OX
         fsB5qfIGbnD7B9GKYIY3n6JNLIAUVaOQR2P6VWqXY8Aqwrk5+1w9U7rSaqO5+Umi+2Om
         K0ncJ6xbE84b+eSPo8t5NaxyZy/h5laoaJJmNBV2So7MDtcakwIIN2AQ285kUwVq7t0s
         PLQILnyQXGyKt0elvg12WP6NcYZcS/UpGoODo7MXf7werVCxvaVB3PH5k/+y0XRHfxYi
         lRVg==
X-Gm-Message-State: AOAM531x0krZw2cLX/W6W3dyFRNS/F8mxJL/xmz6HM7QhYrsgWo2hHFY
        a/ZYexKdJVPcsPRcTJ6UinbqPOsJ9UC95A==
X-Google-Smtp-Source: ABdhPJyo6akQkXkmianmVcZFIOYZEN9w8AOMLWUkO1KlWQ1z1gi+qtUXkbd+wiA4/FWeSJlxnvMmPA==
X-Received: by 2002:a05:6602:13c6:: with SMTP id o6mr10493782iov.28.1635259107349;
        Tue, 26 Oct 2021 07:38:27 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id g6sm4731214ilq.68.2021.10.26.07.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 07:38:26 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20211026082257.2889890-1-ming.lei@redhat.com>
References: <20211026082257.2889890-1-ming.lei@redhat.com>
Subject: Re: [PATCH] blk-mq: don't issue request directly in case that current is to be blocked
Message-Id: <163525910538.223905.12904318476565888682.b4-ty@kernel.dk>
Date:   Tue, 26 Oct 2021 08:38:25 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 26 Oct 2021 16:22:57 +0800, Ming Lei wrote:
> When flushing plug list in case that current will be blocked, we can't
> issue request directly because ->queue_rq() may sleep, otherwise scheduler
> may complain.
> 
> 

Applied, thanks!

[1/1] blk-mq: don't issue request directly in case that current is to be blocked
      commit: ff1552232b3612edff43a95746a4e78e231ef3d4

Best regards,
-- 
Jens Axboe


