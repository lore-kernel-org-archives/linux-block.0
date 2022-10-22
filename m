Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A54AC433FE
	for <linux-block@archiver.kernel.org>; Sat, 22 Oct 2022 21:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJVVPD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 22 Oct 2022 17:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiJVVO6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 Oct 2022 17:14:58 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B012B63B
        for <linux-block@vger.kernel.org>; Sat, 22 Oct 2022 14:14:48 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id u6so5286982plq.12
        for <linux-block@vger.kernel.org>; Sat, 22 Oct 2022 14:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FvC1lDuEXWCYXb2hvcgpYlisVDpfK5faSIaWNOzeHs=;
        b=jlu1d0/979sEdmVA9E65clPF3vKSUXLVMq4DubRcFyekFo2JoLF0YlZ1TDK+QJ0fky
         IVppFZGJBgrTs6hrAK9xyg2vMB430B1x76T+UHDsvxy9JuF5vSFZNTpWugnc9fNWheQa
         FdEupfGAEWcVxdaw9RdXO1X72DpKTdc5qaBv7wNtjYYcW6/34+bd8qXeyGEyDmW81LKu
         QQM3w77dP2ouOSefV0yVCubstp5zrmR1ijLYa1ClUzCE5mvDNdzOkegUSRPDFwdQ8ioC
         ldmep5tia0oIWmbZI6au0QkSBRhsFPmYRzP97JZ+gHfPLFMoMyxpiXtfPq0NT1YRNVrQ
         N5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3FvC1lDuEXWCYXb2hvcgpYlisVDpfK5faSIaWNOzeHs=;
        b=ZuXavqhudmJkvuMpE5i+IVNdJMgkG5/Y+rvs+uS6jbV/fOU9odCrFEt/AKAXHjiDrm
         C3GJUvfJPZllBE//i/04S4pgeb1RlDlZjH6X8cKPrPiHkXqfKavXe69PMcu17NEykuUX
         da6Kx6+2OT5heBCujheVI4xwCeDMtIMB1TFysTmWAMpbemOpjRpZuLF/aYBYd8FA5F5D
         BCCiHQr76W6wPizeMdOz3zT3g3MLjbFmN1edLrjDt+eNukpFasF6wZclJg+bvNla2Dpd
         Gb7gBJwRQMeV1T6qgUMWn6mxSIy0LBzGbyxsTE4HO8gJ8ZCAT8A6xwkFntA09h39b53d
         RfIQ==
X-Gm-Message-State: ACrzQf0+8Xn3aIWTOwJ9oA1LMlf7XNzM1Tt1NsmFvHSxj1m7A68vKGKR
        cYsBXtcmirTfXQdo02fRpdYGXA==
X-Google-Smtp-Source: AMsMyM7Qu+Y+AtNozdZGfdN2QL/ZRk1f0kTozESOa9h9ASGH+K7+VptQo3OgTLUNf28FrWRcUbZLtg==
X-Received: by 2002:a17:902:eb83:b0:185:46b7:7de3 with SMTP id q3-20020a170902eb8300b0018546b77de3mr25764664plg.19.1666473287610;
        Sat, 22 Oct 2022 14:14:47 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q15-20020a65684f000000b0044ba7b39c2asm15129489pgt.60.2022.10.22.14.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 14:14:47 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com, hch@lst.de, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, yi.zhang@huawei.com,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com
In-Reply-To: <20221022021615.2756171-1-yukuai1@huaweicloud.com>
References: <20221022021615.2756171-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v2] block: fix memory leak for elevator on add_disk failure
Message-Id: <166647328666.27452.18046414061378704307.b4-ty@kernel.dk>
Date:   Sat, 22 Oct 2022 15:14:46 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 22 Oct 2022 10:16:15 +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> The default elevator is allocated in the beginning of device_add_disk(),
> however, it's not freed in the following error path.
> 
> 

Applied, thanks!

[1/1] block: fix memory leak for elevator on add_disk failure
      commit: 02341a08c9dec5a88527981b0bdf0fb6f7499cbf

Best regards,
-- 
Jens Axboe


