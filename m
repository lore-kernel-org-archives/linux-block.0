Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F22EC433EF
	for <linux-block@archiver.kernel.org>; Sat, 16 Oct 2021 22:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0DA960F59
	for <linux-block@archiver.kernel.org>; Sat, 16 Oct 2021 22:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244704AbhJPWOA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 18:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244701AbhJPWOA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 18:14:00 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AD0C061767
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 15:11:51 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id e144so11939421iof.3
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 15:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K1DUr2Vv+e3D9ICDm8sVHntHqzYK21EAKMX4oyspO+Q=;
        b=s2vu/Zt3UnZWMolqxnQ2vOI2UzxnPcFYisYajfA17vIiFXPGsvSajRxt7QGRFtIXlP
         uD5gu1x1/SBagyK+SIIegNlIBPxwCUdziuxO2P21lXG/AAG4KlornwO5n9x0fK3ODfdQ
         Qv147i+pIMaWa5MkJWlo0ngdDBRNCCMdEDcGKXMW8q8+5OyvaFXSs5VBbAIM2NmvvM9h
         q1RqBza1BW4PqutWVSt0M2kDoqc4+HA3mEeG3MnDAgROZorOk0LIXB/IWUfFe2ReIIuU
         Fp/mT6oc5jHT9qRznsy1t2jJBFaCFevSEeX/cC2GqK19sLDxu0W4mLc2Lhl2TvAt/xfq
         Qy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K1DUr2Vv+e3D9ICDm8sVHntHqzYK21EAKMX4oyspO+Q=;
        b=v8Fc0F5Z0baimcMSsHykE3SzJEoLGsy49Wtt14QcAsnswsMOJlnWMX1Xf8gN3i4TMI
         tZvvnzZvdAbE1gWJQ9kY8JobbDmV/3NvB67d7QObSz0kyNiCLd/2IBlOTjsE9sPa53F2
         UX38iThBgoa8i6el+D+B3QmQYQytfRZPJ1f8MB9y4ygCKF8GA9pAjoW2nRiu15iU/ltL
         vryldg/EZe9LygV8Lih2K1F2TLeNmZg2Mykxa9uzHHOJMDNldxZsvO+5TqmYB38jKSh0
         tb26OBQ+0/t6pVUzwvdG5yhPHYBlTYsZVC/iOmfoXokXKTRtqhK+wWIYAbElS8DOHVxx
         fvHA==
X-Gm-Message-State: AOAM5311JVVEKpYW4Rse/elUggHdgi0xgAl19JWZQ8dcaKc9/5kz73BL
        lnXiOoGa0spz4ngyQyWOJDiCog==
X-Google-Smtp-Source: ABdhPJziVmCPDZaLqkBbywtXEI3IDl9l+FK9GjbHk+l+sGmiPpi4P97ftHAw/zT2TiSuoF30XahsAg==
X-Received: by 2002:a6b:ee0d:: with SMTP id i13mr9034379ioh.166.1634422311233;
        Sat, 16 Oct 2021 15:11:51 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id o1sm4662484ilj.41.2021.10.16.15.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 15:11:50 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        bhelgaas@google.com, liushixin2@huawei.com
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mtip32xx: Remove redundant 'flush_workqueue()' calls
Date:   Sat, 16 Oct 2021 16:11:48 -0600
Message-Id: <163442230544.1142120.13380062320331204869.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <0fea349c808c6cfbf549b0e33701320c7860c8b7.1634234221.git.christophe.jaillet@wanadoo.fr>
References: <0fea349c808c6cfbf549b0e33701320c7860c8b7.1634234221.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 14 Oct 2021 20:07:50 +0200, Christophe JAILLET wrote:
> 'destroy_workqueue()' already drains the queue before destroying it, so
> there is no need to flush it explicitly.
> 
> Remove the redundant 'flush_workqueue()' calls.
> 
> This was generated with coccinelle:
> 
> [...]

Applied, thanks!

[1/1] mtip32xx: Remove redundant 'flush_workqueue()' calls
      commit: 82c2ecfce69bb758faf81779e28e0ea1a342f1a7

Best regards,
-- 
Jens Axboe


