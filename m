Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C475DC433F5
	for <linux-block@archiver.kernel.org>; Sat, 16 Oct 2021 22:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A23BF6105A
	for <linux-block@archiver.kernel.org>; Sat, 16 Oct 2021 22:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241000AbhJPWNA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 18:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235468AbhJPWM7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 18:12:59 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FF7C061765
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 15:10:51 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id i11so10939334ila.12
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 15:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i8NcHpSItiwZ9TaoEZMfLmWFidB9gDloE2VLdIjDcgs=;
        b=3Pm5KYOhuV9RT7njJYaaA9ndYPtEBlXxdLvlLSBLHLFDLK7ZEVomlmUvoFkKPp7Ep6
         QoM7EKB8KbB0eaU3w5L++u69Fp1Ls4jYQseN/yp+QRD/6R5ziGcpJ+uIvesyizDU2eNe
         0zEoEEt3ftSLQ73PzYkwO2fscmCzVhKuAEj6F3Jkdsry9XUy0n8MQxhg638tHA1rlZe8
         OJlyNaW8X+YjBuPBT5DhYjbuR3DhnGmPYIrY6Lpsw8V7vUiCZSq+wB+WcbER6QAgDITe
         ymSIankewQIbzw0Z34xqD3dfugRH+hNaZA/jgluT7m+E/sS3hXYxYIG5CGVFLZ4zPCra
         wPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i8NcHpSItiwZ9TaoEZMfLmWFidB9gDloE2VLdIjDcgs=;
        b=K/jke5iVchLI1+bTj7Xqq+C7R47WtqO3peOb0CPk1360hRUcJIZrmvmM4wR6Z/iIgR
         2pOgMcwO2DoV7wbSm2nyEfU7sLQPcMItwzxy4hEuK+mLxidj5huXV2zJjy6Ocw4UsNNp
         qaaDlyjSzpV25oN5QVFadkwncSU1LeuxgNU3l1iXF9ryRhOJgpBsa3TUkYYBbF9G236L
         tXTBrawPtIfpUFy/+yEnHuvEN3KCbm7eYSRFYcSBNLrOh86P8qcenHWNy/+Qg9jU4dYH
         9z9//u7udel7mifmmXizLMUnnI5KWtQxRcQZW55GscKVOY3pF5ljKTr4rWET3uj0y9fu
         sDWw==
X-Gm-Message-State: AOAM531UujtDlpn3BlzOOZAEhZYnj31WqWFOUkl8/bIY3zAniFhaG+lX
        GgIIeMxTYjcyovAqqt2vOV8FFQDnWXs=
X-Google-Smtp-Source: ABdhPJzAGVkiuOkmT5LAu4eIj0//pVhofQbXmBHEFbUQ6bbkcde1SvxMEVDnMZwnRREhGlH3hBpFWQ==
X-Received: by 2002:a05:6e02:1c46:: with SMTP id d6mr8641201ilg.117.1634422250269;
        Sat, 16 Oct 2021 15:10:50 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id q205sm4640238ioq.41.2021.10.16.15.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 15:10:49 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 0/4] block: clean up Kconfig and Makefile
Date:   Sat, 16 Oct 2021 16:10:47 -0600
Message-Id: <163442224212.1141648.15209524413845277700.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20210927140000.866249-1-masahiroy@kernel.org>
References: <20210927140000.866249-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 27 Sep 2021 22:59:56 +0900, Masahiro Yamada wrote:
> This is a resend of
> https://lore.kernel.org/linux-block/20210528184435.252924-1-masahiroy@kernel.org/#t
> 
> 
> 
> Masahiro Yamada (4):
>   block: remove redundant =y from BLK_CGROUP dependency
>   block: simplify Kconfig files
>   block: move menu "Partition type" to block/partitions/Kconfig
>   block: move CONFIG_BLOCK guard to top Makefile
> 
> [...]

Applied, thanks!

[1/4] block: remove redundant =y from BLK_CGROUP dependency
      commit: 21baefbb1558318bd32b3a5130dd93d76d64df72
[2/4] block: simplify Kconfig files
      commit: 59b0555ae1c3ddc506c64ad44efa1841ad5843d7
[3/4] block: move menu "Partition type" to block/partitions/Kconfig
      commit: 9b95c675b440156da5b99194e47755728362f4b6
[4/4] block: move CONFIG_BLOCK guard to top Makefile
      commit: 782b51ee1f9915942809dea14e7881489cf3ff10

Best regards,
-- 
Jens Axboe


