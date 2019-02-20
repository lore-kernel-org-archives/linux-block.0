Return-Path: <SRS0=4lGM=Q3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56631C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 19:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29693214AF
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 19:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="aM+FyHWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbfBTTgz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 14:36:55 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38546 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfBTTgz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 14:36:55 -0500
Received: by mail-pg1-f195.google.com with SMTP id m2so10122872pgl.5
        for <linux-block@vger.kernel.org>; Wed, 20 Feb 2019 11:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0qZUSx079tD8Vu6fGKJpHunxf0aj+rh5wYA8jiJD30k=;
        b=aM+FyHWB1oftARzCbB7VlTwXVFq9vf+khB8T7AvbI6bl3FNC8K09rRV2NWRTrF99NJ
         co699og0x/zTm4gHDXjKPoT+Hp7TMGowoBwubEawrxzyL/WFdv6yP9fjTSR0jz1cq31g
         pkajh451yPWm3FNXzTp+wYTDDp20EtDph2YxxPnN0zOEzLpKyOy1jr4DKKEqs+FkDnMP
         px2N876zN6Gt8Om2fioXlfGI3PzBjfbcHMWsi/RGhzDktNqoivJg8Ohs62bTK/ae1T9I
         owbLpIZZnu8dHJ6KLzwlM+tWcmkroH2p2C1ptPL7w9OzS6LPphaZSk6QdcPRgrz8nITl
         DxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0qZUSx079tD8Vu6fGKJpHunxf0aj+rh5wYA8jiJD30k=;
        b=iZcIa2Nt4vlmZsACRdjLZtLIsCfzAvcpAj7x/2lxUiCjkkb3CE/VtQ3pS9ZpAD0C4A
         BDgGFP9tZSkGFr6R6hNw9YxkTQ3kMfxsYGuqd7tNCJw+UwUjkIKdUp+QgAvr77+xClJd
         rs+bI2Y9g/DkEMx3usNJzCpa04MzZO9XRJMAWhileBbt2GXDugVbPIea3vssLw6vpWmq
         TayJOdlxmsLkPrgbmtGi6IeJhAcAxo8D2lRzrtXUgwcpnH0TwY5tQa4vbQVwFaQBWIQ9
         w1qzyrkK5mcNSdh5Mp/rPFeNvjVKgNohL0aRKxAthG0DIRwo2yErdxVXBuvgOxE9zTfi
         lYYw==
X-Gm-Message-State: AHQUAua8YF9XBDOjIwtW75rol+PO5jP3/jsqs7H0aACrAC8NA1StqrU6
        Ex1Zvok/tXcUElI/BuNiF2qqAA==
X-Google-Smtp-Source: AHgI3IalhoSDx9p5dWlynqGA0ZeST6acmC5LXjXlMh8bjO2bIUdo58L6XJYrA3q78kI8d2GNFGlizg==
X-Received: by 2002:a63:e14e:: with SMTP id h14mr20044958pgk.184.1550691414166;
        Wed, 20 Feb 2019 11:36:54 -0800 (PST)
Received: from vader ([2601:602:8b00:55d3:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id 14sm29619934pgq.22.2019.02.20.11.36.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 11:36:53 -0800 (PST)
Date:   Wed, 20 Feb 2019 11:36:52 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     linux-block@vger.kernel.org, osandov@fb.com, yangerkun@huawei.com,
        houtao1@huawei.com, yanaijie@huawei.com
Subject: Re: [PATCH blktests] loop/004: Need to wait for drop caches if
 block_size is changed
Message-ID: <20190220193652.GF8325@vader>
References: <1550655486-132008-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550655486-132008-1-git-send-email-zhengbin13@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 20, 2019 at 05:38:06PM +0800, zhengbin wrote:
> When i test blktests, loop/004 will be fail. The Key test steps
> are as follows:
> 1. losetup -f --show  /dev/sda
> 2. src/loblksize /dev/loop0 4096
> 
> step 1 will create /dev/loop0. after that, daemon systemd-udevd
> will visit and close /dev/loop0 who will add and delete
> i_mapping->nrpages.
> PS: the operation of systemd-udevd is in the background.
> 
> step 2 will set /dev/loop0 block size, linux kernel function
> loop_set_block_size has been changed since commit 5db470e229e2
> ("loop: drop caches if offset or block_size are changed")
> + if (lo->lo_queue->limits.logical_block_size != arg &&
> +     lo->lo_device->bd_inode->i_mapping->nrpages) {
> +               err = -EAGAIN;
> +               pr_warn("%s: loop%d (%s) has still dirty pages\n",
> +                       __func__, lo->lo_number, lo->lo_file_name,
> +                       lo->lo_device->bd_inode->i_mapping->nrpages);
> +               goto out_unfreeze;
> +       }
> --->maybe systemd-udevd just visited /dev/loop0, this leads to failure
> 
> Add a step between 1 and 2.
> 
> Signed-off-by: zhengbin <zhengbin13@huawei.com>
> ---
>  tests/loop/004 | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks!
