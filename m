Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0200AC77B7C
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 15:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241738AbjELPJi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 11:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241725AbjELPJg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 11:09:36 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B97D1FC7
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 08:09:36 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-76c6ba5fafaso18798739f.1
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 08:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683904175; x=1686496175;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCibvLLxmrwwjTg8tqAHybrQHxUO9Q8BGBSAxnFXhiw=;
        b=uQb+J4jzLKUfp8gagw5cGFiAeUpcv8jZJp1GHPpWmpH5ipBA16smx4xIf5dXo0kFt+
         8GFco37b1QZVTDLsrUc59o0pmGTqqi+/Qpf+QglCqnMTKQ7ve0Au+qGHWiu40eqcmuXq
         tRZZ+RomkmcHetSB4F4Ten7NhzlmLnvX+ZH5m5DO/LRzSGQqwgNL/qweq2O67gzIGqjc
         MiJgfs9oBjCHf6V3c9KE9H5PsHE6lUMNVV2lUxN9lnfahQMHEBGRb3KV40k7a+9VIaC+
         B+AiDPgnY2JO6kEjuOgTgw3z+ikAybLXCLo3kEg3OrtP/hEreqnZzhzWQbgqssBrkyKF
         0/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683904175; x=1686496175;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCibvLLxmrwwjTg8tqAHybrQHxUO9Q8BGBSAxnFXhiw=;
        b=Q4bwwAo7fEY7LuwNYUXQqvLQrK0xFUIlBICatqwWTMTyBNY5V3YzEdyrMYTNcrR0B3
         dSqg3MEqAgZOEFY0cFuL0SbAjbrnvrWQiKpuwppwSVfYUqFsaI1LPrn3rW+JwbvAmHkR
         IEL+pmM06XyzjNpytsV4FwYE9A1+6qmC5AOWjjelpbBiIAWSEMpNGmExXYAA+MjfA+tx
         hxrT90uNvaf7P+1cXXyI06DLftv9iIsISJOVEKRgiXHq6p9925Y/emDfQGHaqFIPRsM3
         l7shBVK1QwStYdC/E6y3fK21OhNLDdkKUJZ60kVZD6TbIpMQznn/r//cZTsW1Z/hcPEZ
         yHuw==
X-Gm-Message-State: AC+VfDyTGR7E36NW0fS6ocaQ/+lCRB8h2SRXdwLz1cER1xhekrnwSPKU
        agOiqbjtCiZj1dKmH1ojn9W7Wg==
X-Google-Smtp-Source: ACHHUZ4C6nUSwzXyYsE0c9Gh7gS2xy8BK1Q/t0KdbEpeZZJd9wlQic8dUm6KTp4fKwUEmUvC3d6cQQ==
X-Received: by 2002:a05:6602:2b93:b0:76c:8a4c:ad79 with SMTP id r19-20020a0566022b9300b0076c8a4cad79mr2715877iov.1.1683904175386;
        Fri, 12 May 2023 08:09:35 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u21-20020a6be315000000b0076c6f5b8db5sm1685542ioc.16.2023.05.12.08.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 08:09:34 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     josef@toxicpanda.com, Ivan Orlov <ivan.orlov0322@gmail.com>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        himadrispandya@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
In-Reply-To: <20230512130533.98709-1-ivan.orlov0322@gmail.com>
References: <20230512130533.98709-1-ivan.orlov0322@gmail.com>
Subject: Re: [PATCH] nbd: Fix debugfs_create_dir error checking
Message-Id: <168390417460.869582.2878039069012872149.b4-ty@kernel.dk>
Date:   Fri, 12 May 2023 09:09:34 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 12 May 2023 17:05:32 +0400, Ivan Orlov wrote:
> The debugfs_create_dir function returns ERR_PTR in case of error, and the
> only correct way to check if an error occurred is 'IS_ERR' inline function.
> This patch will replace the null-comparison with IS_ERR.
> 
> 

Applied, thanks!

[1/1] nbd: Fix debugfs_create_dir error checking
      commit: 4913cfcf014c95f0437db2df1734472fd3e15098

Best regards,
-- 
Jens Axboe



