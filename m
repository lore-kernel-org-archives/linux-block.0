Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4C4C468B0
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 16:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646A120866
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 16:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JGI/4tKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731300AbfFMQH7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:07:59 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46351 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731297AbfFMIpW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 04:45:22 -0400
Received: by mail-yw1-f65.google.com with SMTP id v188so8002726ywb.13
        for <linux-block@vger.kernel.org>; Thu, 13 Jun 2019 01:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FPxpCrVHR3Dvl1CZJ6DsBlibGZ1t/tZxp7V37sb6oR4=;
        b=JGI/4tKrnLKNU7PwN8rvd50f5xHOi21cQMMLBUIPiv0uG30cPXyTfMO70OyaH93yNW
         h6T5m4zigbG5/VruTT26QqCtIDShLOuDLTuS6h9S8W6ZxdMP9uUZRDoOL9J1a+vcdH9a
         2z9KPqnpvXLUC3IE2zl0YhUlJpktY181BALOUYjVtt20jaWzEQxIDoFSsnfIzGHLPIT8
         CVbReHPPMOGOCHqy9AWCSM1VS99lQXN/rhsL9Kx1oyeGz3IVp4XOx9uhJnK10gBek9TV
         Sr+GSlBGvXWta+1LN/5QBK7VvwPt16Y/+SqN9xaewvZPns8tGvEDsfzMq4D9gbWalBYC
         5E1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FPxpCrVHR3Dvl1CZJ6DsBlibGZ1t/tZxp7V37sb6oR4=;
        b=RQOpGTlVsI2yHnz8JoFR9Q7NZ7CdIBskA+bvo/a9eavU/zV3SpMwE4tu04j/sw5WGW
         rSaEDxrIHtfdHUwblhlz73EZ38CV/J1vUDBFSmerenhjCxc/CQIiKClT8OW5aKfbehAl
         sqJe7CT/Oae7NqobW3g304JCzubkm2j10daz2vuwPzPNbumdi28KDEX7pagD7ye96gOy
         d4tTLqv1wG7hVdvhQqI2abJ6drxGMrUemqUm2cdNgMQpjOLDqr7d1WWx7LJ1+/Sc/oMR
         AvhLL3+EGrGpXeiMQz9z7vrWpE37rUO5JSrTE2LPGRYJet+U9uKv0rgA6zNamtdlYvkY
         nxIQ==
X-Gm-Message-State: APjAAAX1sAG2AfFLTYSBYPYpmW2Ohk1ZI/coeGeYcCzuzUI7ZcEQgAlM
        vjtcRBohvWMIl2eXR/SjeLTtMg==
X-Google-Smtp-Source: APXvYqzARUTrOo/IaBGuXQhqfmRIwEuUxatxbVgg9mxrwQ/qWTo7bEATYxcrEMr1qjNH/KWPdu3KIw==
X-Received: by 2002:a81:3d7:: with SMTP id 206mr43213113ywd.411.1560415520901;
        Thu, 13 Jun 2019 01:45:20 -0700 (PDT)
Received: from [172.20.10.3] (mobile-166-172-57-221.mycingular.net. [166.172.57.221])
        by smtp.gmail.com with ESMTPSA id d7sm947435ywh.14.2019.06.13.01.45.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 01:45:19 -0700 (PDT)
Subject: Re: [PATCH] block: null_blk: fix race condition for null_del_dev
To:     Bob Liu <bob.liu@oracle.com>, linux-block@vger.kernel.org
Cc:     hare@suse.com, hch@lst.de, martin.petersen@oracle.com,
        bart.vanassche@wdc.com, ming.lei@redhat.com
References: <20190531060545.10235-1-bob.liu@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2c8b26b3-7a41-5631-d091-48fd57cf6c3d@kernel.dk>
Date:   Thu, 13 Jun 2019 02:45:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531060545.10235-1-bob.liu@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/31/19 12:05 AM, Bob Liu wrote:
> Dulicate call of null_del_dev() will trigger null pointer error like below.
> The reason is a race condition between nullb_device_power_store() and
> nullb_group_drop_item().
> 
>   CPU#0                         CPU#1
>   ----------------              -----------------
>   do_rmdir()
>    >configfs_rmdir()
>     >client_drop_item()
>      >nullb_group_drop_item()
>                                 nullb_device_power_store()
> 				>null_del_dev()
> 
>       >test_and_clear_bit(NULLB_DEV_FL_UP
>        >null_del_dev()
>        ^^^^^
>        Duplicated null_dev_dev() triger null pointer error
> 
> 				>clear_bit(NULLB_DEV_FL_UP
> 
> The fix could be keep the sequnce of clear NULLB_DEV_FL_UP and null_del_dev().
> 
> [  698.613600] BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
> [  698.613608] #PF error: [normal kernel read fault]
> [  698.613611] PGD 0 P4D 0
> [  698.613619] Oops: 0000 [#1] SMP PTI
> [  698.613627] CPU: 3 PID: 6382 Comm: rmdir Not tainted 5.0.0+ #35
> [  698.613631] Hardware name: LENOVO 20LJS2EV08/20LJS2EV08, BIOS R0SET33W (1.17 ) 07/18/2018
> [  698.613644] RIP: 0010:null_del_dev+0xc/0x110 [null_blk]
> [  698.613649] Code: 00 00 00 5b 41 5c 41 5d 41 5e 41 5f 5d c3 0f 0b eb 97 e8 47 bb 2a e8 0f 1f 80 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 41 54 53 <8b> 77 18 48 89 fb 4c 8b 27 48 c7 c7 40 57 1e c1 e8 bf c7 cb e8 48
> [  698.613654] RSP: 0018:ffffb887888bfde0 EFLAGS: 00010286
> [  698.613659] RAX: 0000000000000000 RBX: ffff9d436d92bc00 RCX: ffff9d43a9184681
> [  698.613663] RDX: ffffffffc11e5c30 RSI: 0000000068be6540 RDI: 0000000000000000
> [  698.613667] RBP: ffffb887888bfdf0 R08: 0000000000000001 R09: 0000000000000000
> [  698.613671] R10: ffffb887888bfdd8 R11: 0000000000000f16 R12: ffff9d436d92bc08
> [  698.613675] R13: ffff9d436d94e630 R14: ffffffffc11e5088 R15: ffffffffc11e5000
> [  698.613680] FS:  00007faa68be6540(0000) GS:ffff9d43d14c0000(0000) knlGS:0000000000000000
> [  698.613685] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  698.613689] CR2: 0000000000000018 CR3: 000000042f70c002 CR4: 00000000003606e0
> [  698.613693] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  698.613697] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  698.613700] Call Trace:
> [  698.613712]  nullb_group_drop_item+0x50/0x70 [null_blk]
> [  698.613722]  client_drop_item+0x29/0x40
> [  698.613728]  configfs_rmdir+0x1ed/0x300
> [  698.613738]  vfs_rmdir+0xb2/0x130
> [  698.613743]  do_rmdir+0x1c7/0x1e0
> [  698.613750]  __x64_sys_rmdir+0x17/0x20
> [  698.613759]  do_syscall_64+0x5a/0x110
> [  698.613768]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Signed-off-by: Bob Liu <bob.liu@oracle.com>
> ---
>   drivers/block/null_blk_main.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
> index 62c9654..99dd0ab 100644
> --- a/drivers/block/null_blk_main.c
> +++ b/drivers/block/null_blk_main.c
> @@ -326,11 +326,12 @@ static ssize_t nullb_device_power_store(struct config_item *item,
>   		set_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
>   		dev->power = newp;
>   	} else if (dev->power && !newp) {
> -		mutex_lock(&lock);
> -		dev->power = newp;
> -		null_del_dev(dev->nullb);
> -		mutex_unlock(&lock);
> -		clear_bit(NULLB_DEV_FL_UP, &dev->flags);
> +		if (test_and_clear_bit(NULLB_DEV_FL_UP, &dev->flags)) {
> +			mutex_lock(&lock);
> +			dev->power = newp;
> +			null_del_dev(dev->nullb);
> +			mutex_unlock(&lock);
> +		}
>   		clear_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);

Is the ->power check safe? Should that be under the lock as well?

-- 
Jens Axboe

