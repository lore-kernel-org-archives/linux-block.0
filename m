Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC39C43334
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 16:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiGUQ7e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 12:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiGUQ7c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 12:59:32 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7A089A70
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 09:59:32 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id e69so1809038iof.5
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 09:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=1kqeRM9oX/Rl6BdFXFJQ+uKk+mUw9WhMvOLFm8cupR0=;
        b=YB+rdKa5cJCTHXqDiym02eFJBJOzjxjz7Zggp7j2qnY2CHHIhxtviPhJx6jEZzSsD8
         JcYVfEDpNXmp7Em9IsMIQWqfTxSBHbdQxcIb95//dFaQ/6fNuC32HDSb+sKXKG3zH5KH
         XF0+hhRw3RjuPFqW69KV+5Ena2QvyE9DdqDuEyFFZHIid5gqbINf42l8ej3Ty/7XkC29
         dvl6YaA8g5GAUID2QPy74PnhCua61z/1bBbOuPRfANnpIkCq5I1H4t4oP9bNjcSKWaFE
         cNAVkMu3TinfgjIPnOcVYO0M0PLFruTp5wml7QIlGWVA99gOk7cj1a8SQK9HcvRL3ONp
         4R/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=1kqeRM9oX/Rl6BdFXFJQ+uKk+mUw9WhMvOLFm8cupR0=;
        b=k2YYRcNE8yMtNaEQiczvjcMw9aaC3N59rdWw/KKp/eTYNoxn2UjzKJJVBrF1ffoJcj
         sjEhfaSiyvVCDsaM6z5WEq3uMDpd7tHbVeEcuzFGyZ0XinjjvCfNLzvoChjA/T+UY4nF
         DaFwJgfLyhTu9BN83/Cur0bFL6mn/NVjRDNXTQJnzZjDgE4H4mspej7xpbogADXVVvum
         cx6VKiQfD/hAmG0/xiixzKrE1FL7jMcFO57ekMBf1WEGkKao3Dtdk2Oc2R5XjKeG86Z9
         a2NTxsGF7Ht63jU5va4VtTFKJvWIxFBoOMUXTJP5xi0YvQaXlT3D8E6t/GJBJwQC1hEu
         zhpQ==
X-Gm-Message-State: AJIora9OPNAWyBZJ+S/iZpGRwBr273KraYCIUhjOYS8ahjDJaHhhoYTK
        s/3re2aecyrx0V8U6yO8PcxcvWjnnkbZww==
X-Google-Smtp-Source: AGRyM1tDsjlHuLPJXPW36J0VSd6ATIzsnt1GnpMrTPV0yw5IAtV6I9ffImg72Fb8HMSvOaCsIQGIaA==
X-Received: by 2002:a05:6638:2404:b0:33f:7105:ed23 with SMTP id z4-20020a056638240400b0033f7105ed23mr21828950jat.50.1658422771339;
        Thu, 21 Jul 2022 09:59:31 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f13-20020a05660215cd00b006788259b526sm1022565iow.41.2022.07.21.09.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 09:59:30 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20220720130541.1323531-1-hch@lst.de>
References: <20220720130541.1323531-1-hch@lst.de>
Subject: Re: [PATCH 1/2] blk-mq: fix error handling in __blk_mq_alloc_disk
Message-Id: <165842277069.64404.16728554527229671657.b4-ty@kernel.dk>
Date:   Thu, 21 Jul 2022 10:59:30 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 20 Jul 2022 15:05:40 +0200, Christoph Hellwig wrote:
> To fully clean up the queue if the disk allocation fails we need to
> call blk_mq_destroy_queue and not just blk_put_queue.
> 
> 

Applied, thanks!

[1/2] blk-mq: fix error handling in __blk_mq_alloc_disk
      commit: 0a3e5cc7bbfcd571a2e53779ef7d7aa3c57d5432
[2/2] block: call blk_mq_exit_queue from disk_release for never added disks
      commit: c5db2cfc6274692d821d33b59acb6ff615e350c1

Best regards,
-- 
Jens Axboe


