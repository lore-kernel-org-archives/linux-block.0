Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3D7C433FE
	for <linux-block@archiver.kernel.org>; Thu, 23 Dec 2021 14:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348748AbhLWOKW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Dec 2021 09:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243803AbhLWOKV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Dec 2021 09:10:21 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7D7C061756
        for <linux-block@vger.kernel.org>; Thu, 23 Dec 2021 06:10:21 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id l3so4998945iol.10
        for <linux-block@vger.kernel.org>; Thu, 23 Dec 2021 06:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=gMMkG6ShZ8Fp8sfGbq2eA4arzE/ALNfZG3xl3bXJNac=;
        b=zJGqbUATsUbBv6aa3sXgvVdq8FU+nNsnuNULbWOe0Aq65kN627RrJBdYAnXPEOU573
         57oO5OnVaYU37dWODlrEEKJxu79VLTm7VDq8++2Xf4HnqRqI/dI13K6+B5bgFE7GJPmr
         guGqNeGmHAXcM3tB1dRoG1i9eNhAlm9LzYfYlwaepBgd8HNjB4Vnc2MJQmADlG63OqK7
         zJUuK9teis2aL3R6Lj5EJCYhMV3NVEXzXlnp83F1fJ1DyziTsvU5mxOopnk24a5kG6nL
         teLIYhVOw9/0RNEza/SfcUotZISuE2BFRFDUUCcLXTtod4BfdYdRqQ6FkopKNaEyoQxd
         8aCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=gMMkG6ShZ8Fp8sfGbq2eA4arzE/ALNfZG3xl3bXJNac=;
        b=2tLqWnF+Mc9/RekAr6cX8rtQtYZa3OHOVFM9zgxf3dYqWkLx4X0+UPdD+t8UQv3wfr
         aqa8v/dvuBW7KHDuMmX0KHc8q8lR7GBWN3PWvWV8plt06FyStuAj7dHFfXzRHXFSXN8d
         zhpMqc1kRWRB04VhA2by0mKt4leVQJkCAn4Exl0yEcPQVt+DFDfJUHi//cFmiZHvxP2M
         nyz4ggr9nTKSvkVSOUQgT5G3OPspsHEKi8YTlRO5Gl/H2SpefujjfErqLTUfAshQM9P5
         wS33wKVRio82pTs1EsF5isIXClSQIw0NhHT8kxf4bA5N2fBcYp+//G/XAX3Yb4DcdxEQ
         B6gg==
X-Gm-Message-State: AOAM531LHb3yVXp68uvxzARInEvUlj/kwACZr0jG5wQx9uQojA8vbp/u
        a2sSnmIeMw+FDcefUizoWMqsgVrHveBmtQ==
X-Google-Smtp-Source: ABdhPJwe/yp49IOX3sR4spMvhOeNOgkGUATD0XvuuA62Fz9OMMcM+zMLkz/p2WC4YR3YMJG1IZdJkA==
X-Received: by 2002:a05:6638:2495:: with SMTP id x21mr104131jat.258.1640268620593;
        Thu, 23 Dec 2021 06:10:20 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id k1sm1549005ilu.80.2021.12.23.06.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 06:10:20 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        kernel-janitors@vger.kernel.org
In-Reply-To: <20211223125300.20691-1-lukas.bulwahn@gmail.com>
References: <20211223125300.20691-1-lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v2] block: drop needless assignment in set_task_ioprio()
Message-Id: <164026861975.771757.2667766405282712502.b4-ty@kernel.dk>
Date:   Thu, 23 Dec 2021 07:10:19 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 23 Dec 2021 13:53:00 +0100, Lukas Bulwahn wrote:
> Commit 5fc11eebb4a9 ("block: open code create_task_io_context in
> set_task_ioprio") introduces a needless assignment
> 'ioc = task->io_context', as the local variable ioc is not further
> used before returning.
> 
> Even after the further fix, commit a957b61254a7 ("block: fix error in
> handling dead task for ioprio setting"), the assignment still remains
> needless.
> 
> [...]

Applied, thanks!

[1/1] block: drop needless assignment in set_task_ioprio()
      commit: 669a064625fa3a06ddf8a4ac1f35b7436b99f133

Best regards,
-- 
Jens Axboe


