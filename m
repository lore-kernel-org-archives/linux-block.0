Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20DDC433F5
	for <linux-block@archiver.kernel.org>; Thu,  6 Oct 2022 13:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiJFNi4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Oct 2022 09:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiJFNix (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Oct 2022 09:38:53 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D51EAC392
        for <linux-block@vger.kernel.org>; Thu,  6 Oct 2022 06:38:51 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n18-20020a17090ade9200b0020b0012097cso1863104pjv.0
        for <linux-block@vger.kernel.org>; Thu, 06 Oct 2022 06:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTCYSZmMysxtSVfEJTY+s0G/UzQUqK+OIX1DRudo8Kg=;
        b=TzWXmCFRuEwSQxIvtrbLg3T/gSXyynJruPXM2VsC2kWTdmxgp2c6gfxpoMvWW3Hghk
         r18GM8xCrKv7P+cPLVf88WS43gkSrm4EvQQeUupsML+Z6vTl6tQfEY3EzjM/V7eL6KAD
         ySdJB2j4CTJAHh3/lCiCWusUXeEvb4PYmS8uBwd5rJOvBkwmxxbT6wFvf0GPhvUuIWLE
         ABDicttkDsY8z2JdCYV2ntUjJm4vRgIIo3vR15PMSmtLqxH0ksziR/0IbTeKoYDO1Rz4
         igkCFxrP29PaR3yEvO09BAcQ7R9FrpqzBWAFAcQZPUBUe8kwpPjNIt8DQ7qKk2m6ghtc
         IR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTCYSZmMysxtSVfEJTY+s0G/UzQUqK+OIX1DRudo8Kg=;
        b=gK/gmbHX9WZKcoohCnaH/5xUlkXVc6Kz6k5atuRf8HyyDxAuvNPu/SlEYD8rIwKJT1
         NLpOV6J5XZOtDo5ww6h7njMq9DpBFGglAScOjuJSyklVtlc0aQJvfoMB1WJdbQ6pBi/9
         /+uq7b1WuqmOm5hIcbfGwVFiC7Vh+mJs+zARUXOs6sOjnapcomybJh4s1Je01zdqq3wL
         leoR+LVE02dunE3F1ccjSctSagjHDgglwvpuc7lq5ejkdD+Z+av2bvBvm/sVW9S3FIS8
         KCLp42kYPWEKVFIfHZBSWd9+oWG1WyJwKdFsPcgFrwNzJVLruWZNnXZgXdgtxvCMUKhw
         rVAw==
X-Gm-Message-State: ACrzQf0k/ru1QPv0b1aGzjj2VaJHiNk24q8KCyRRgsM03yF6MlPPG1aO
        8WaWHgWHV3uN79RIHTXHM1TQBGbqolTd4Q==
X-Google-Smtp-Source: AMsMyM6p5emMqF60uEZPjXHkvs1E1VToggNwIb6bqQONyLj6xjXv3FjpqqhDN3PJwImhRiE8UzhFTg==
X-Received: by 2002:a17:902:db12:b0:176:d6a4:53ab with SMTP id m18-20020a170902db1200b00176d6a453abmr5024135plx.113.1665063529879;
        Thu, 06 Oct 2022 06:38:49 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w129-20020a623087000000b00541c68a0689sm12890163pfw.7.2022.10.06.06.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 06:38:49 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Deming Wang <wangdeming@inspur.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221006084450.1513-1-wangdeming@inspur.com>
References: <20221006084450.1513-1-wangdeming@inspur.com>
Subject: Re: [PATCH] block: Remove the repeat word 'can'
Message-Id: <166506352904.7298.7396235219714937696.b4-ty@kernel.dk>
Date:   Thu, 06 Oct 2022 07:38:49 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 6 Oct 2022 04:44:50 -0400, Deming Wang wrote:
> Remove the repeat word 'can' from the comments of bio_kmalloc.
> 
> 

Applied, thanks!

[1/1] block: Remove the repeat word 'can'
      commit: 340e134727c9adaefadc7e79b765c038e18e55c3

Best regards,
-- 
Jens Axboe


