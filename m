Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BF0C7EE23
	for <linux-block@archiver.kernel.org>; Mon,  5 Jun 2023 17:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbjFERWI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Jun 2023 13:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbjFERWE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Jun 2023 13:22:04 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A90B0
        for <linux-block@vger.kernel.org>; Mon,  5 Jun 2023 10:22:01 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2564ced644bso1035015a91.0
        for <linux-block@vger.kernel.org>; Mon, 05 Jun 2023 10:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685985721; x=1688577721;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bx3FOQ8WpXAjUchLrV7ZdQUMCcuc5rVhaoplHLZKkU=;
        b=NmMei7rN/FQixwaXZYdcuIqojmmWOTp3C9B6kG7NOpV0TNYhFnHmxNTr6RVA4dADhm
         lnGs6br8Osze0v/nf45uyiMWPpbT08Ed1pOxiu/uIzRR2GRirueFk/vTh71TTVGMY1tM
         lcu3bjzFVw6A6v2Q9VvvaP0ykmVyppKEVkhGBB5l562aAKL9NBDktU2ohjDOodcjtPlR
         ydBEK2dmhGggVTvL0IAa3d830ysmMcn0aUkBoYH/nX5g3XagTgxONQNHPde0tx5wfQY9
         7ryJkoTYpwHPx5dL1kP/eqdpJuoLDjFkmuAUfIkT3+cVjJPLBPdohoZ3RvxQKC4ZzZCx
         ybgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685985721; x=1688577721;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bx3FOQ8WpXAjUchLrV7ZdQUMCcuc5rVhaoplHLZKkU=;
        b=foUpRXab2snFZd7kjGmqGOMSZmAmkPjq2wKSz/+WxNnqo6y3rc0ZVog+7q8xt1l4Xk
         C0TRQ6x2j/H9QBe24N6hdKCrE00Dux82Fgxd6nMrbT3Pe+pBmwi0lPzTPrfQQD1f7Ltn
         k9Aba3VreT+CH3f48F1VGcGp97aAbw95J/5pyrO7dvxq6C5Kl0i6GCtqoSRam/0fwURj
         WGDgVEUr+dAzUa9Ik0OKo88cmzhMhWYh5d4JA44QnFpu4of/Drex/9TjAPUtPL4ETpjr
         utJn0yKNl+IuVMUYXl+IOiAZ4RncyqUhp4uzZO9YVn2zde/2FmiJ4HwyJc6FLHciX/Aa
         j7vA==
X-Gm-Message-State: AC+VfDwCLc/uIoZOqMDVLbDSwvdPdABWMXP7BWtcUsdUjjk79QQwcjAK
        AGfJ9O66XN/Wa2WIY8hEcJ3GiFfIdljxNyMYduw=
X-Google-Smtp-Source: ACHHUZ661iczc0HcuBHzs3Fi+bR77NqS/CnPjg3kZtWjD9M5bK3e6bkSVWVIc5Nlkq2/lDCuuq4zNg==
X-Received: by 2002:a17:90b:1e51:b0:258:85d9:be02 with SMTP id pi17-20020a17090b1e5100b0025885d9be02mr16979731pjb.2.1685985720966;
        Mon, 05 Jun 2023 10:22:00 -0700 (PDT)
Received: from [127.0.0.1] ([2600:380:c01c:32f0:eff8:7692:bf8a:abc6])
        by smtp.gmail.com with ESMTPSA id cl9-20020a17090af68900b0025643e5da99sm7993666pjb.37.2023.06.05.10.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 10:22:00 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, Christoph Hellwig <hch@lst.de>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org
In-Reply-To: <20230601151646.1386867-1-hch@lst.de>
References: <20230601151646.1386867-1-hch@lst.de>
Subject: Re: [PATCH] drbd: stop defining __KERNEL_SYSCALLS__
Message-Id: <168598571992.2504.2085169404981858004.b4-ty@kernel.dk>
Date:   Mon, 05 Jun 2023 11:21:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 01 Jun 2023 17:16:46 +0200, Christoph Hellwig wrote:
> __KERNEL_SYSCALLS__ hasn't been needed since Linux 2.6.19 so stop
> defining it.
> 
> 

Applied, thanks!

[1/1] drbd: stop defining __KERNEL_SYSCALLS__
      commit: d519df00938eed652fc041ff4e07b2b38a4ad3bc

Best regards,
-- 
Jens Axboe



