Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEE0C0015E
	for <linux-block@archiver.kernel.org>; Fri, 23 Jun 2023 14:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjFWO1f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Jun 2023 10:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjFWO1e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Jun 2023 10:27:34 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4274D1706
        for <linux-block@vger.kernel.org>; Fri, 23 Jun 2023 07:27:33 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b515ec39feso1503575ad.0
        for <linux-block@vger.kernel.org>; Fri, 23 Jun 2023 07:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687530453; x=1690122453;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTvsQhQg+h/6sjmrvelSIwmDtg13vMLMA+Amro1Li54=;
        b=lXpJzgQNWwfs8mxsJzjqqN7vope1utG4AxzgV1/vHoC6RBwrpSRRPtaRCaLP37tdmi
         797NlhGzETdYlK7zx8zHUhhqrxGCpcZZ5YphrtpNu59sv66LnViLrphqY3FuAcg91JBQ
         8PEUiRIV/xD09ip0RfazefBvmurY0NWzj4L5q/Hi80PA9/gQlqm6wCmUv8IJ/2lPc08C
         9njgSPAm7U5ZL/OWAE7lp3sSgMY55+l8DUnVbgMKl/Kg9XEjJ9r8pmkWPEZU2Yxo/4zy
         rlwgZd3JRYWk/9qwwp2/8mI1qLHVShwVTIQLzAcsbC3PakTOIqEkwg7t+VFYzNdhBARH
         yaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687530453; x=1690122453;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTvsQhQg+h/6sjmrvelSIwmDtg13vMLMA+Amro1Li54=;
        b=UQ5I6p/4zy85tLW98W83KosVQYqpcLynWMzibDOGaN09/cZTf75sr7WJNiIb+IzFc0
         xO6synUo6dyW7lwXlLS54y24FzzJb42nQE9XuqLS6nApiigtoVflDD8sACoECtpg8+k7
         gkDylgIMVK4hfoS9i7JGJdoE5bnulhHG3QDsvQGAQQrrmKPD4QhJdYrkMcebt17LC4gZ
         zSVM+uStW9WPpT5PP1HUO0geAh4dJMaa5bx7aAHERlgmrfVXXSGNnw6hQlIF6vJr6RHg
         jbOm73Lq8ydJjQRC81L+JwSyfb6G1Zh9GRmHn8P6niJtKDKVRKXBafRFhY48z0QZa4Xz
         k1mw==
X-Gm-Message-State: AC+VfDye16H3fOjKU06DXreMlfPYl1bVyAd0EsAVjb2CEjKU/6WFrSfX
        wM86sqs+1aDiPSd8Q0HtE4PCsA==
X-Google-Smtp-Source: ACHHUZ5/OXC0NppqoOq90GmL+bp8zjgBepblkSqpqUTQkpHQCO7r4kHc5KW2EGmCwT/GphvlPCNmjA==
X-Received: by 2002:a17:903:230c:b0:1b2:1f12:acf with SMTP id d12-20020a170903230c00b001b21f120acfmr26082569plh.6.1687530452727;
        Fri, 23 Jun 2023 07:27:32 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id lg13-20020a170902fb8d00b001b3ce619e2esm7291108plb.179.2023.06.23.07.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:27:31 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org
In-Reply-To: <20230622165107.13687-1-jack@suse.cz>
References: <20230622165107.13687-1-jack@suse.cz>
Subject: Re: [PATCH] ext4: Fix warning in blkdev_put()
Message-Id: <168753045157.468611.1058915697772264584.b4-ty@kernel.dk>
Date:   Fri, 23 Jun 2023 08:27:31 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-d8b83
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 22 Jun 2023 18:51:07 +0200, Jan Kara wrote:
> ext4_blkdev_remove() passes a wrong holder pointer to blkdev_put() which
> triggers a warning there. Fix it.
> 
> 

Applied, thanks!

[1/1] ext4: Fix warning in blkdev_put()
      commit: a42fb5a75ccc37dfd69aa9bde5ba2866e802ff3c

Best regards,
-- 
Jens Axboe



