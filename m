Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D3CC433F5
	for <linux-block@archiver.kernel.org>; Mon,  6 Dec 2021 16:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238421AbhLFQuw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Dec 2021 11:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238455AbhLFQuw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Dec 2021 11:50:52 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6586FC061746
        for <linux-block@vger.kernel.org>; Mon,  6 Dec 2021 08:47:23 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id y16so13687546ioc.8
        for <linux-block@vger.kernel.org>; Mon, 06 Dec 2021 08:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=/0SXgGX28/0RTN9QU/DsVtJokxlTQv3WbGSp7DGmXk4=;
        b=vFQjbp94JtKeOaM/W9yQ5MY4cFN7z0qA2qA2iJRdW07pfEvtmD/kzxr3XwN0QTkDhJ
         daZkRrl4YOK3MV6id76gF4QeaRUv8z35S5stpG/Wi0po2NMTBELs01zHvhs08no3ySY8
         YwywKRobhW1iRMqYsUsM0Ce+6+JM1tpQ4CK8s26d5eemYcpUQriAs+C86+FXdfWQMLc2
         mGDUtvyvBg1PQdVoE24+SCnizqVNYJJjRSz63HmtwVyEH5/3P2wnuqMxZGVD9XpCVDXl
         nnHfvuCiAqca3AA26dY6hJQbnZLjFYDadLZsKozq9CqnnQWYGMgDQtmDU14ndMXDqSsa
         prJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=/0SXgGX28/0RTN9QU/DsVtJokxlTQv3WbGSp7DGmXk4=;
        b=UigZne0cZYoX2Q7gtkHdVp3OH5F31lKMmSPWhbYeHeWMp2Tgc17qAqSFhKurxoRxe5
         Fb+yOhZVgGxMJlhRtJOw08jO66dRbAB3KUXHGzuzDlh5jyoWKFXV5TnGVqVL7ReUx5kt
         XTfbOu7oYttSltb4/+g76/yXL54gnK0rVrC9xYuQU79UuPFOOAH2t6gYvfRR0NsjRnwy
         HGkhiEm/ZrX8RBeS/NhvJYUVzluCJ6Zt9wzFJcr10Q6/IQOMneouSeWN/uI7rGbsC8/c
         KLu9sJNs63EVL1jjAsI8Klho0vHQPgH2hNYZ97qnAovsScy0Kj9WpzQZXuAFXElVrZgu
         WSng==
X-Gm-Message-State: AOAM532TjLat24x/yy5rPE6z4W4773a8yr4V5F5dJzkel438s/LgtJXO
        ujEEUlMb/+su1QXJ1yag4X0Dow==
X-Google-Smtp-Source: ABdhPJxPuaBBKCW2wE1RbRqHqrMZuoqdQw4DulT5czheg7CyIsvbAohHPYPb+2Y15IHcw3V3ctPJ/A==
X-Received: by 2002:a05:6602:2f11:: with SMTP id q17mr35828341iow.75.1638809242834;
        Mon, 06 Dec 2021 08:47:22 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id q12sm1289618ilo.60.2021.12.06.08.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 08:47:22 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     miquel.raynal@bootlin.com, Christoph Hellwig <hch@lst.de>,
        vigneshr@ti.com, richard@nod.at
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-block@vger.kernel.org, linux-mtd@lists.infradead.org
In-Reply-To: <20211206070409.2836165-1-hch@lst.de>
References: <20211206070409.2836165-1-hch@lst.de>
Subject: Re: [PATCH] mtd_blkdevs: don't scan partitions for plain mtdblock
Message-Id: <163880924220.67311.13119218479398937498.b4-ty@kernel.dk>
Date:   Mon, 06 Dec 2021 09:47:22 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 6 Dec 2021 08:04:09 +0100, Christoph Hellwig wrote:
> mtdblock / mtdblock_ro set part_bits to 0 and thus nevever scanned
> partitions.  Restore that behavior by setting the GENHD_FL_NO_PART flag.
> 
> 

Applied, thanks!

[1/1] mtd_blkdevs: don't scan partitions for plain mtdblock
      commit: 776b54e97a7d993ba23696e032426d5dea5bbe70

Best regards,
-- 
Jens Axboe


