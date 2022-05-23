Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF275C433EF
	for <linux-block@archiver.kernel.org>; Mon, 23 May 2022 14:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236938AbiEWON6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 May 2022 10:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236821AbiEWONy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 May 2022 10:13:54 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E600B48331
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 07:13:52 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id v6so9573358qtx.12
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 07:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yf9uUkztNFWKQdMQR+4lfqgGYIJguwpRJROMjgydeec=;
        b=ejzZTp14I0eM1Xcu7f55+JlhI+5GSacYBedYUGQQ3LUYcO7XT4j/NyJA5eQ+FODvPg
         iLrp2yq7P41YzKGBcPKkQ1yVtFLmR2JcZlImu5cKytZMyAsN4fVx1c/ZlcLGGne8Ucet
         hKqmJKMrmOYq0kJl4akBKYxeZ9L5YIZTa/I6hRxNwCqXLuB5QBrOkMVqr4apq8bSveqr
         eHK7+9Y6W7Kys7/dJb6WAobSnenSkLUU6bcjCqnPsz8QpQehRwv05SHSlqO6mbutH5+J
         XyXPqTiUADmQ+MAT7eWyig78b+pXHwe3sqYs8hK+VrZTjPDgTc9nbesjcpN7b2j2deYD
         fHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yf9uUkztNFWKQdMQR+4lfqgGYIJguwpRJROMjgydeec=;
        b=3Kwt/HcDik7ElWuvnuYI855d+L05A+uZPjIZTH5N5luOs8fKoQQbBWDUI3TBrRhAZg
         cM2GCXkoTthpua2V2BJ8e8aLoWtJtE1EcChdJE6ZQ/oJAYANehrz7whclNfXFJiUKmVr
         n6efUou3Nwn7MWST+3njEpM5egmunR/usUjCF5GixA6SYbTxu6DAiibKmx5vi7lj/li9
         ivTDwhHRgfVh8lAllN1+gFQVRJEXr9fe5n+ztlZf3AN0gE3A9nImqdISgjNmIZ6wSEiC
         hXMPvoLm1Cnv94CpE/qEY/zU/RzFFe3aIoaGGMYfNMr7B42hfbhQZy7Zi9R7MzdL4ObH
         v+FQ==
X-Gm-Message-State: AOAM530Uql1aFJQ9I2tHGVM38AXMUwUZey8mhXf6vMKdVeaXVUMaLbuo
        BzMXCjN+sZubbJolYAyG/2vuGw==
X-Google-Smtp-Source: ABdhPJyiT1kMTbQR+T6y2KceS2oNAISZeyIeujBa8g4AUiYDvZeIcUWg78NR8+d9Gb9IEA18FV3eOQ==
X-Received: by 2002:a05:622a:38d:b0:2f3:c9f7:bfa0 with SMTP id j13-20020a05622a038d00b002f3c9f7bfa0mr16634672qtx.404.1653315231961;
        Mon, 23 May 2022 07:13:51 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c10-20020ac86e8a000000b002f3ef928fbbsm1132615qtv.72.2022.05.23.07.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 07:13:51 -0700 (PDT)
Date:   Mon, 23 May 2022 10:13:50 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v3 1/6] nbd: call genl_unregister_family() first in
 nbd_cleanup()
Message-ID: <YouWnpZxnGBiXq6X@localhost.localdomain>
References: <20220521073749.3146892-1-yukuai3@huawei.com>
 <20220521073749.3146892-2-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521073749.3146892-2-yukuai3@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 21, 2022 at 03:37:44PM +0800, Yu Kuai wrote:
> Otherwise there may be race between module removal and the handling of
> netlink command, which can lead to the oops as shown below:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000098
>   Oops: 0002 [#1] SMP PTI
>   CPU: 1 PID: 31299 Comm: nbd-client Tainted: G            E     5.14.0-rc4
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>   RIP: 0010:down_write+0x1a/0x50
>   Call Trace:
>    start_creating+0x89/0x130
>    debugfs_create_dir+0x1b/0x130
>    nbd_start_device+0x13d/0x390 [nbd]
>    nbd_genl_connect+0x42f/0x748 [nbd]
>    genl_family_rcv_msg_doit.isra.0+0xec/0x150
>    genl_rcv_msg+0xe5/0x1e0
>    netlink_rcv_skb+0x55/0x100
>    genl_rcv+0x29/0x40
>    netlink_unicast+0x1a8/0x250
>    netlink_sendmsg+0x21b/0x430
>    ____sys_sendmsg+0x2a4/0x2d0
>    ___sys_sendmsg+0x81/0xc0
>    __sys_sendmsg+0x62/0xb0
>    __x64_sys_sendmsg+0x1f/0x30
>    do_syscall_64+0x3b/0xc0
>    entry_SYSCALL_64_after_hwframe+0x44/0xae
>   Modules linked in: nbd(E-)
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
