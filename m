Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9922CC433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Jul 2022 19:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbiGRTNP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jul 2022 15:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbiGRTNN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jul 2022 15:13:13 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29CA2F656
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 12:13:12 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id y2so10071945ior.12
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 12:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=HZhWrFGJ/60u+arYGfm5slhhzNJ7cejuyjajN1Mdj4w=;
        b=jKusduWGP6hIWEpTg4Vx1MmpMKz3PJXf4JjUrMzeUhwyusH4jyR2vDphpzG3sDDCdh
         eMpxKCumpoHQJGizZmCT6gT5q3yElOy6JuXq4/eCuS0LyAdBL6KpwXGjG3GYhh2NBwRR
         u51EAaoZfek2kmBs7FF71rMPZlK53bU7ARxn/zr+rvO2z/+nlyp8JK1QvWU/g+JGh6gc
         aL0n3ov6bymEHsij4eG6KtcsS5ShnFio/nzra0vZ0Lw97hqTB4b4fCUT+jPKn8QGU0dZ
         uf8/A4euC94uErqv4Yvqi6SzwTBdtpu92sllaA97YooiBH8ZgbIKZBivaj2nMTcECAye
         Fk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=HZhWrFGJ/60u+arYGfm5slhhzNJ7cejuyjajN1Mdj4w=;
        b=v4HWEm6nYVGLGRGZWFqOQFvhhySo/JdaAD56IGVwLNLrUqNDlZ/LbzvxvaD0WMsYof
         kB7JqCRNENfyUXkaXWRXKShy5ChokGV48vzwhOM8z8tC1fPsGIIy81Kaduhe+KsfxPnr
         ud/bY2qeUSeOv2Wb5n9+lVMt3x51asFe36N492TSYi/GyjmwzjGzvLYfCDvYjGC6TpJb
         P7vOcIvyHDGi4iWvEl5GfYjJ0CWbjV7gLuLBVgMj79Bcg4AVA+w4hXJoD5IawftSSh56
         WBTld1rJqmw4M1k+PUnG5g3Yu19mRhJrqVafLu/0gyctCmDGVGKiFNdqhNFurNKNp7Ss
         7Z0A==
X-Gm-Message-State: AJIora8R0M5ZmM7AuaBFqPqiTzj9hAB6mbmZXUYNSH0FEfqg1+eKjWWc
        louFSMafQlMp4GF1tPeM0irQzA==
X-Google-Smtp-Source: AGRyM1s822w+3NlRMHNv2p+54NOtHEFOjsQYORLCx1GXCWLhF87bC27lCIYpxKZHjYHKNOuFX6ixGg==
X-Received: by 2002:a5d:9383:0:b0:67b:adc2:c053 with SMTP id c3-20020a5d9383000000b0067badc2c053mr13697774iol.102.1658171592442;
        Mon, 18 Jul 2022 12:13:12 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id p123-20020a022981000000b0033eb2f2ccfasm5817730jap.43.2022.07.18.12.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:13:12 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     dan.carpenter@oracle.com, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <YtVAgedTsQVK1oTM@kili>
References: <YtVAgedTsQVK1oTM@kili>
Subject: Re: [PATCH 1/3] ublk_drv: fix an IS_ERR() vs NULL check
Message-Id: <165817159186.144718.1786091988428260978.b4-ty@kernel.dk>
Date:   Mon, 18 Jul 2022 13:13:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 18 Jul 2022 14:14:09 +0300, Dan Carpenter wrote:
> The blk_mq_alloc_disk_for_queue() doesn't return error pointers, it
> returns NULL on error.
> 
> 

Applied, thanks!

[1/3] ublk_drv: fix an IS_ERR() vs NULL check
      commit: fe3333f6953848f1c24e91a1cf70eed026dc3a86

Best regards,
-- 
Jens Axboe


