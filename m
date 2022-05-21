Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53695C433FE
	for <linux-block@archiver.kernel.org>; Sat, 21 May 2022 12:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241329AbiEUMco (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 May 2022 08:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241134AbiEUMco (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 May 2022 08:32:44 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFB99C2FA
        for <linux-block@vger.kernel.org>; Sat, 21 May 2022 05:32:42 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id c22so9876385pgu.2
        for <linux-block@vger.kernel.org>; Sat, 21 May 2022 05:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=lIe2BuS+hmdG8AC61X4W4lVxIRLtVNB5bIbXaAUes2E=;
        b=xZn9e0CtL2ijpN1+ZzPITsYQVlCKSIw0zYEYMs9ibNQYitl3G4yzlB4qAfrtuBjd48
         /fq0XGp1DtLEMxe+SyW4PMENlvb0VDj0TthBZUFT62Yy4cg94EcfhRToAlP0T1v3A3gQ
         OS+8wvpaf3bwj+IMsGplvjg1RIaSmsZ5vWoTolouyPwGJuW/0pHzx519NSJKJZWXV58f
         LDvMDP7pO1dYPKdALkVtEsKyB8UCL9zqr5wxLrwYisc00/4VDDMmJBNylGz8Psp1ZrQ/
         lxPQUJneD4nB2J0kfdSCkvWHIzsKxQlOzFWq27Sj19TAt/6PF3wL5QOxV1LfZaA1c5oU
         gpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=lIe2BuS+hmdG8AC61X4W4lVxIRLtVNB5bIbXaAUes2E=;
        b=ZjXTlIaqcPksudSSah+2UcZkYvi40Rw1g/Dazzs5aW6WzyfF1eH2Nfy01Xd1aFPLtW
         Ht9e1VSyS/KhN6Sd/DnJ8MADPcyyigLduF2U/OrRoQC4HO2LZm6BCp6Q/rSyl0m+Kp//
         tQPAAG63sCXIHcCe1WsfaSwHaSk/bbSk3W9simd6UFxpLOS84YwCvo6Rt8t/9O/jxhp3
         D3kv+bZHF04tUgagCRfGmhNNP12WFzPEU3QiJ2tmhqNiKsQlvkGS8ha5PGOc1sUm2WoJ
         d+BiCBgk39gC0IcoKlpKuy3inqXGAjBGaqkjkh9un1PnQ5JirZ5YfstUsykVJvFYfjdD
         BH9Q==
X-Gm-Message-State: AOAM531ZKOqTNZPxLD02Hg2jfnJ3c/fgtzGJeLuYRfgkMe62DVMPvWT5
        zKCpCjlD3khKA9nvAuopR3HHBov/jmBeig==
X-Google-Smtp-Source: ABdhPJzRWPrUcTvufMhYzwWmLFMMgDj0nDGFmOBoKj6xLvfnguKOugOol+/wchoN4E3ubIosscAlRg==
X-Received: by 2002:a63:e50b:0:b0:3f5:e132:4526 with SMTP id r11-20020a63e50b000000b003f5e1324526mr12449716pgh.506.1653136361824;
        Sat, 21 May 2022 05:32:41 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h16-20020a170902f55000b0016194c1df58sm1497724plf.105.2022.05.21.05.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 05:32:41 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Julia.Lawall@inria.fr
Cc:     linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220521111145.81697-29-Julia.Lawall@inria.fr>
References: <20220521111145.81697-29-Julia.Lawall@inria.fr>
Subject: Re: [PATCH] blk-mq: fix typo in comment
Message-Id: <165313636064.19338.15073887794756259717.b4-ty@kernel.dk>
Date:   Sat, 21 May 2022 06:32:40 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 21 May 2022 13:10:39 +0200, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> 

Applied, thanks!

[1/1] blk-mq: fix typo in comment
      commit: 2aaf516084184e4e6f80da01b2b3ed882fd20a79

Best regards,
-- 
Jens Axboe


