Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26EBC433F5
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 14:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347572AbiC3O5E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Mar 2022 10:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245243AbiC3O45 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Mar 2022 10:56:57 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB7B49CBC
        for <linux-block@vger.kernel.org>; Wed, 30 Mar 2022 07:55:10 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id k25so25010499iok.8
        for <linux-block@vger.kernel.org>; Wed, 30 Mar 2022 07:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=R/QA3qwuvc+FZQ+dv5ME79tUgBYzzyKos1+TF13+4yQ=;
        b=beGWf5RZrPnpIIOChN9iUKTh3sfzxfPCjZ2JKiQR+vhrtTmfVYrJe0tkng2GZnstMC
         KADRrLbuu5wPJEPpFqNfW0F0u3eEMSJszujRTf3I+7wa2RlYGONVH5KrzXP9E1odfute
         JRkkPR8lV4Efrsf8+D7wIP5Hb1xMf1K3Z9SK2P3S08WKyUoBNIVM4/taAaPTmn7mnyx7
         NebS4jRL7C3ErmStAR6cntI6m1Waae+ZCBjF4reLMj8qy5u/wfr//fADwKtS1kqIGWeG
         Sb1LFDbkiqUs39uWKHXAlSKgPr3PCQ7mnrLrfr/Ht5R6TSKr6qIgFEMT6d2y57XftrzM
         5LjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=R/QA3qwuvc+FZQ+dv5ME79tUgBYzzyKos1+TF13+4yQ=;
        b=bo4oUVTsDoTsaEucPfMqnJ+keIz6EPfeXvJlCUb+28gsk4RJRcNIELeEJyZSF0z+EL
         zXkZ1OMrkc2UAvmsm7KPGh8W53EBtzTngnx3Od6c74bmLFScyDSHSJro+Hz217uT50le
         nSQLgMiuBhqmwdzoQg7DMN9w1KmfxXdLv/LiXVDASTb2jZ3LynhoWQ8NSmZleSrRwxMA
         wiorWv4Gtx5sNB/Gb/+gtrhnoMHiIAkIYipCTyAiPLCNAm9WOyUA0J4HhgsnQnkMAVuF
         pvckeDdcHnNTA7GEtYd43wzNOejMaMGGISUSt9SMxREGh1UyXZpYyHzyHu/yNZPxZ/VH
         4jvA==
X-Gm-Message-State: AOAM533WiASop4a98HHCmf+eWnwMP8wR+Iot7K5OCnlJf0IDwPS0hRf3
        /zVBXbZdWpRLbp8ARPvZFienmXkLqmQ9f/tA
X-Google-Smtp-Source: ABdhPJz3ogEsUt77/dKerlk0+F1wbN/aqIEn3YfWAm1SNqiQ5Px+22BxvDghI7kN/xbnyk/nI0XREA==
X-Received: by 2002:a6b:14a:0:b0:649:a974:9042 with SMTP id 71-20020a6b014a000000b00649a9749042mr11501105iob.81.1648652109714;
        Wed, 30 Mar 2022 07:55:09 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id q197-20020a6b8ece000000b00648d615e80csm11473586iod.41.2022.03.30.07.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 07:55:09 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Carlos Llamas <cmllamas@google.com>, linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220329201815.1347500-1-cmllamas@google.com>
References: <20220329201815.1347500-1-cmllamas@google.com>
Subject: Re: [PATCH] loop: fix ioctl calls using compat_loop_info
Message-Id: <164865210886.39485.16982992188546747372.b4-ty@kernel.dk>
Date:   Wed, 30 Mar 2022 08:55:08 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 29 Mar 2022 20:18:15 +0000, Carlos Llamas wrote:
> Support for cryptoloop was deleted in commit 47e9624616c8 ("block:
> remove support for cryptoloop and the xor transfer"), making the usage
> of loop_info->lo_encrypt_type obsolete. However, this member was also
> removed from the compat_loop_info definition and this breaks userspace
> ioctl calls for 32-bit binaries and CONFIG_COMPAT=y.
> 
> This patch restores the compat_loop_info->lo_encrypt_type member and
> marks it obsolete as well as in the uapi header definitions.
> 
> [...]

Applied, thanks!

[1/1] loop: fix ioctl calls using compat_loop_info
      commit: f941c51eeac7ebe0f8ec30943bf78e7f60aad039

Best regards,
-- 
Jens Axboe


