Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4903C433EF
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 17:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CBE261186
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 17:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbhKDRbK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 13:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbhKDRbK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 13:31:10 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F962C061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 10:28:32 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id l7-20020a0568302b0700b0055ae988dcc8so6097431otv.12
        for <linux-block@vger.kernel.org>; Thu, 04 Nov 2021 10:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=asXfaJ7FlDhXsYvEBZ+H08GIMusG5ow7G24yM9LQZdE=;
        b=gdQ80SODRt4ycNKo+4aOWr2ZheIl8ReHoOfDJhf0+En93eK053QgDAF7R6gYrEpGp3
         1rp79SbUyqr22uydAZFupl29k0gAr3FVsLVvgm/5/NDofw/himw6nUPkCokZCDpdNf/x
         rl61j7nWgwi4iLdDAVPf88vOF3UuSJNAcAP4cK6H8cytyITtWnBCQFDq573jutmsnElf
         CKy15xSIOJqwMG3K8zfT4PULIenQ6rad+x4hsKMXPbesS5zJEKnU56DX/h2T6lAwyRrN
         BBOEK+aJOzHHogj/3NnsD8MPatM1xsgCaqOo2ZoMF2Gy5kaz/ovtRG8x2U25jJvDO21o
         M3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=asXfaJ7FlDhXsYvEBZ+H08GIMusG5ow7G24yM9LQZdE=;
        b=cJax317kIya6p8FO2lNi+B8rdCT++AAHVp0eYyvLx2BW+Sz/Aq0+iQW5+VxIqtfKZB
         c5Nk/uhMYMlPh64xf8UtlMfgIyUke8GjUVz+mq0CyjibUykLbA4WNRbaza2hDTmxtm/x
         6HDT3znQxPv6/lLSdm0a07IqSJsouEAO1MBAlQtc0f3C7dUwjdMOukUfrwO49Dm5lVoZ
         G2LypKxcBnAkQbDLxCDxRg35urwpp9D8pCLzJJIswwoiht9tZWeB+wU8USSnXsfFIYI7
         X9pWj57fEIEDTlJNZGJqez4WRje3YCTShBt8A0L8GW8Lf484bczgSRBhnKywJ06/SRHf
         864w==
X-Gm-Message-State: AOAM532gjvqj2pNElnf0fnsvWvfELDL+T5yIVm9xFbQpznCs1FyU/ItT
        Bas1v+m53L711LldXHDJUUbLtmO9U0JXYA==
X-Google-Smtp-Source: ABdhPJxVtzrDA/kGuYtWhEWvCodwTSCbFtiLgEq66nfxpbv0AwQrTYJOw5yx9+2YX8cm9Cc5SiFjUw==
X-Received: by 2002:a9d:620f:: with SMTP id g15mr4040489otj.106.1636046911508;
        Thu, 04 Nov 2021 10:28:31 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s41sm276735otv.30.2021.11.04.10.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 10:28:31 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20211104172037.531803-1-hch@lst.de>
References: <20211104172037.531803-1-hch@lst.de>
Subject: Re: [PATCH] block: add a loff_t cast to bdev_nr_bytes
Message-Id: <163604691104.67954.705649427369140782.b4-ty@kernel.dk>
Date:   Thu, 04 Nov 2021 11:28:31 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 4 Nov 2021 18:20:37 +0100, Christoph Hellwig wrote:
> Not really needed as both loff_t and sector_t are always 64-bits wide,
> but this documents the different types a bit better.
> 
> 

Applied, thanks!

[1/1] block: add a loff_t cast to bdev_nr_bytes
      commit: 2116274af46b12df7cea1dc5698f3cf2f231f8a9

Best regards,
-- 
Jens Axboe


