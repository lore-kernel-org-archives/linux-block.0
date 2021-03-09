Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D9AC433DB
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 02:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D24346527E
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 02:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCICzk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Mar 2021 21:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhCICzd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Mar 2021 21:55:33 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7D5C06174A;
        Mon,  8 Mar 2021 18:55:33 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id jx13so91444pjb.1;
        Mon, 08 Mar 2021 18:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X1NdEaeznqDG0w3Bd/Nb0MooHdcqj7OMlg+M+dl0jEk=;
        b=JcFCVCA1vhjhbzEHAoko4Jj6BjMumWdOa097H0rfulPeKTK9V4yxCqgLEu6FODS7/L
         u6PRVZqB1Bptq58B104MQXpFRMMP+AEoIbDhve75xZtjXamMbW3cOII+4VqLU2YOVmeR
         PNFCV3L1PlhY+fgeAESTV06Y+XNc+0RK4clhnQ7ugAtiwF9f7IwXgWhkvl4DuPDUCTcC
         rMdJ5RBn/wB0r520hnbc40j9U1fSiOsyGpoog4MRYNUhnygsDRlKp3kp+cXq7/6od1Vg
         SRnB0lvStkJBCesGQn09WRo4bQqtKIWWj7/O6EwYRL3BryizpEYSjJCSHIpy9glWnLs1
         MvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=X1NdEaeznqDG0w3Bd/Nb0MooHdcqj7OMlg+M+dl0jEk=;
        b=Eu1ue0FKlOQpbkie+Un9Uj8UQoP1JKs9Y++ruLeR2e8aZGlWpQgGhUr4yhsDLCO8Hh
         5Za4qEEcQU9qvnZw1utYuekkl1kmq7xpoLpRH2TAjBd0SLpe2GmOHzBJPQXTTDnY4HH7
         ngiqKhTapNj8Zxj//P91zFSMtvz0n6D5Tt0zRY2yN+G4hF8BzZG4sramZBEpaujMIiKv
         LJtEzG53cZAk0g9dhsygkkmA+gSs7UfxSTXMndISa9k3x8x2Uqw6hFcu4knmauw5k+a0
         dsAaAc0aGvmXkUFV3eGP8EmEnfQD8zjhHW3B3anNYBlvZPnZBjT1UwrwWev+H07h/NZ8
         eV6A==
X-Gm-Message-State: AOAM531o/0RXUx4XalYMefmhTf8NaQRZQk8ySCEBLShWSWU3UJFIhJ31
        tXVX6qpVT2rDAUSBl/IG6es=
X-Google-Smtp-Source: ABdhPJwDGoOrBNsG7W6D7YEYRWeYZihu5tHW/dziBjZoDxtF8HP24+vk2/7pCBqBrodOpkFgHr+SiQ==
X-Received: by 2002:a17:90a:7e94:: with SMTP id j20mr2343701pjl.8.1615258532930;
        Mon, 08 Mar 2021 18:55:32 -0800 (PST)
Received: from google.com ([2620:15c:211:201:4ccc:acdd:25da:14d1])
        by smtp.gmail.com with ESMTPSA id a19sm7825247pfc.65.2021.03.08.18.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 18:55:31 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 8 Mar 2021 18:55:30 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        axboe@kernel.dk, mbenes@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <YEbjom8FIclEgRYv@google.com>
References: <20210306022035.11266-1-mcgrof@kernel.org>
 <20210306022035.11266-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210306022035.11266-2-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 06, 2021 at 02:20:34AM +0000, Luis Chamberlain wrote:
> The zram driver makes use of cpu hotplug multistate support,
> whereby it associates a zram compression stream per CPU. To
> support CPU hotplug multistate a callback enabled to allow
> the driver to do what it needs when a CPU hotplugs.
> 
> It is however currently possible to end up removing the
> zram driver callback prior to removing the zram compression
> streams per CPU. This would leave these compression streams
> hanging.
> 
> We need to fix ordering for driver load / removal, zram
> device additions, in light of the driver's use of cpu
> hotplug multistate. Since the zram driver exposes many
> sysfs attribute which can also muck with the comrpession
> streams this also means we can hit page faults today easily.

Hi Luis,

First of all, thanks for reporting the ancient bugs.

Looks like you found several bugs and I am trying to digest them
from your description to understand more clear. I need to ask
stupid questions, first.

If I understand correctly, bugs you found were related to module
unloading race while the zram are still working.
If so, couldn't we fix the bug like this(it's not a perfect
patch but just wanted to show close module unloading race)?
(I might miss other pieces here. Let me know. Thanks!)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a711a2e2a794..646ae9e0b710 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1696,6 +1696,8 @@ static void zram_reset_device(struct zram *zram)
                return;
        }

+       module_put(THIS_MODULE);
+
        comp = zram->comp;
        disksize = zram->disksize;
        zram->disksize = 0;
@@ -1744,13 +1746,19 @@ static ssize_t disksize_store(struct device *dev,
                goto out_free_meta;
        }

+       if (!try_module_get(THIS_MODULE))
+               goto out_free_zcomp;
+
        zram->comp = comp;
        zram->disksize = disksize;
+
        set_capacity_and_notify(zram->disk, zram->disksize >> SECTOR_SHIFT);
        up_write(&zram->init_lock);

        return len;

+out_free_zcomp:
+       zcomp_destroy(comp);
 out_free_meta:
        zram_meta_free(zram, disksize);
 out_unlock:
