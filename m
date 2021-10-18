Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F9FC433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 17:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FD966103B
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 17:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbhJRRXD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 13:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbhJRRXC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 13:23:02 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558B6C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 10:20:51 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id 188so17128622iou.12
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 10:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ONRNJRbuBfiJ3JCw8oKU8k4CkuwpYwt18lfZltRmdP4=;
        b=YehyEKALmpCemjfxK9PJn3PQOUoqQ1BEpOKWwSSRVVgNv3wik+5CxUxn4egxpjOVhU
         6qDLqc08mJ25J1ImWrcjrjGhNTO5+E0WFHVX3jaBaypJ++utAlCeTdYttdpzQATEG9dQ
         KosZRmLLqhJTGI8ek3JnatQMF6OJqscw4dr0T5IVCNYDnhG4XYpgIGo/i3NPY1mPsc1X
         spUR1bH5iCXuK3sHX5wPGmGiGtiaKiSfnybmO5pxOGkd1Kf8LFDzWCL6ktahWgue6QyE
         FJs3p8nRVy44SSwoW1z5elY50pfiE+9ykXqPT1+dmqy6JHMd+UVUnvGyVgNsF2qA3o+h
         jWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ONRNJRbuBfiJ3JCw8oKU8k4CkuwpYwt18lfZltRmdP4=;
        b=lQiQRWGRi5eRj1RyyWktHT0m5hhlVocFd5UhBaPg0So0LNbn18oqoLpQ0CQ9/oqhBq
         hCjNSbxS/p5QfdviCr5R3MLspOnDrrVDi4y9iV1LIzPKX6sAVOOlRSnxCa9syoXcxgx9
         ZXtpAYRg+xY4oRJ2NSQ5cnITKBdBwnUMOiL3P5qCWmTp6ZucpPgz/6CoKNHetCwpB7sC
         L2hgVi7ZXNBTFu7Ngh4HZrFBbbX41y0BfWZSD8gI8h1QmcCXdR7lARqJCG59neG9FFFa
         sC9LSiqZMPCDb/H6y5Bk+CRMVAPrtIPrqZZltLdtJjoEN57copjIVGkMUi5XE4Htxw0b
         j6GA==
X-Gm-Message-State: AOAM533Df6yzfkDRTvmZkQuU0AUOWBaFXlQX15QzwGFW6j2Nx/BVR06v
        FvuqrluUmRvAaqn8QfvgkRLbEg==
X-Google-Smtp-Source: ABdhPJxJpFsGzvUO0vaFr3szQ8U4IzY7lRLrQYfilJHwTw/2XVCnembT2uWtYpWbB0NcyjBml3aCYw==
X-Received: by 2002:a05:6602:199:: with SMTP id m25mr15223847ioo.173.1634577650669;
        Mon, 18 Oct 2021 10:20:50 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id b7sm7105844ilq.65.2021.10.18.10.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 10:20:50 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     hch@infradead.org, sunhao.th@gmail.com, hch@lst.de,
        willy@infradead.org, Zqiang <qiang.zhang1211@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: fix incorrect references to disk objects
Date:   Mon, 18 Oct 2021 11:20:48 -0600
Message-Id: <163457764524.392122.9390950005139028238.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211018103422.2043-1-qiang.zhang1211@gmail.com>
References: <20211018103422.2043-1-qiang.zhang1211@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 18 Oct 2021 18:34:22 +0800, Zqiang wrote:
> When adding partitions to the disk, the reference count of the disk
> object is increased. then alloc partition device and called
> device_add(), if the device_add() return error, the reference
> count of the disk object will be reduced twice, at put_device(pdev)
> and put_disk(disk). this leads to the end of the object's life cycle
> prematurely, and trigger following calltrace.
> 
> [...]

Applied, thanks!

[1/1] block: fix incorrect references to disk objects
      commit: 9fbfabfda25d8774c5a08634fdd2da000a924890

Best regards,
-- 
Jens Axboe


