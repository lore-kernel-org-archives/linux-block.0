Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E68DC433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 14:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52D2E6138B
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 14:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhJTOM2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 10:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhJTOM2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 10:12:28 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A7BC06161C
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 07:10:13 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id s18-20020a0568301e1200b0054e77a16651so8369345otr.7
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 07:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eAir1TZHj8ej8jRm3+Abv46htwdqCGDBjtrmMkKXab0=;
        b=c5ZEUNl4zRWqSLWEpSMlcrYnUC87+RhEw5iBGeBar1ZCKT+3uZaYTFXYWaxm79Q6BB
         27xJyy20J0wrjB06FkT13/lhH2u7ctbY0q6+2HVQ0xP3uqHrL9D+3wHtF6cazZH8Ch7i
         CSwpuPoZO4uIgIv3A7ZS3pIgqmk5Ip4LRzaZ/syhX9WGe9No+rcg+ETC7f094cMy+Djh
         UZJmRT+lsRa7NAdzeHVSGeicw/ia+o/Km7KAhXiys/axPpJSBlYjoOKa82OttYOdLEu1
         8vEDc14JIFndIoBwFhGw75UMiWF/f1fdrfdfvW13glT9XUxgs4q+fWDKXUl5lvgdRZsZ
         /NIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eAir1TZHj8ej8jRm3+Abv46htwdqCGDBjtrmMkKXab0=;
        b=t7dh5pyMIUqmtA4foVh8zVnViI8wEV1nt37s9Jx9II0m6HnNOzdoBuK6ykupGXsYzQ
         DAiY4U1nyD92GhvbzbA90FKtcsUAPkLAsKUvBz7H/QIcmcj4ZKNXVU4Jx4bM35ZNSHHr
         xnVXIgsKatPRnmDgJZBp6Qs9joAIjVk8fNjnQ4A5EKq+dxgdKgA0l3lW247VvMS3Bjc6
         RDMk8PHdcQf76Xp7+iMQiIdpAplMIozWoS10/JEK+WGXTZ5ICUHOK9r4SLyvSM9J1jMU
         WHJ6mF8xOXp94im5qlCPG64sQFviGqS0C55EKStuhm9FLnAoHlMLruig3NSb8YURWVLq
         s5iQ==
X-Gm-Message-State: AOAM532TWnia51PF+qGpobnBbOu8U9Ps+B4N2bQbOD6U6HEdLvKst//k
        WRTXEx9shVUWavTuDHOK/b3HHdF3UqggDg==
X-Google-Smtp-Source: ABdhPJyAHK4/39pU4/Go6dsstvNmAydij4wEGbmfDM+OWDXqESXQa/OP1CnzWR7oBc1Q7Fnw62hNJQ==
X-Received: by 2002:a9d:19e8:: with SMTP id k95mr88305otk.284.1634739013089;
        Wed, 20 Oct 2021 07:10:13 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id 103sm486002otj.44.2021.10.20.07.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 07:10:12 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     josef@toxicpanda.com, nbd@other.debian.org,
        linux-block@vger.kernel.org, Ye Bin <yebin10@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] nbd: Fix use-after-free in pid_show
Date:   Wed, 20 Oct 2021 08:10:09 -0600
Message-Id: <163473900612.733071.518425291980291734.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211020073959.2679255-1-yebin10@huawei.com>
References: <20211020073959.2679255-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 20 Oct 2021 15:39:59 +0800, Ye Bin wrote:
> I got issue as follows:
> [  263.886511] BUG: KASAN: use-after-free in pid_show+0x11f/0x13f
> [  263.888359] Read of size 4 at addr ffff8880bf0648c0 by task cat/746
> [  263.890479] CPU: 0 PID: 746 Comm: cat Not tainted 4.19.90-dirty #140
> [  263.893162] Call Trace:
> [  263.893509]  dump_stack+0x108/0x15f
> [  263.893999]  print_address_description+0xa5/0x372
> [  263.894641]  kasan_report.cold+0x236/0x2a8
> [  263.895696]  __asan_report_load4_noabort+0x25/0x30
> [  263.896365]  pid_show+0x11f/0x13f
> [  263.897422]  dev_attr_show+0x48/0x90
> [  263.898361]  sysfs_kf_seq_show+0x24d/0x4b0
> [  263.899479]  kernfs_seq_show+0x14e/0x1b0
> [  263.900029]  seq_read+0x43f/0x1150
> [  263.900499]  kernfs_fop_read+0xc7/0x5a0
> [  263.903764]  vfs_read+0x113/0x350
> [  263.904231]  ksys_read+0x103/0x270
> [  263.905230]  __x64_sys_read+0x77/0xc0
> [  263.906284]  do_syscall_64+0x106/0x360
> [  263.906797]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> [...]

Applied, thanks!

[1/1] nbd: Fix use-after-free in pid_show
      commit: 0c98057be9efa32de78dbc4685fc73da9d71faa1

Best regards,
-- 
Jens Axboe


