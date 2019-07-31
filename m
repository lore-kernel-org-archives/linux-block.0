Return-Path: <SRS0=Z/SB=V4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98130C32751
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 13:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E96E216C8
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 13:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="o6I0yztQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfGaNun (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 09:50:43 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39654 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfGaNun (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 09:50:43 -0400
Received: by mail-qt1-f193.google.com with SMTP id l9so66543608qtu.6
        for <linux-block@vger.kernel.org>; Wed, 31 Jul 2019 06:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tZpiteHABmHMSPpeLCCgPpkl35yK+eRJrcx7w2v7BEo=;
        b=o6I0yztQ1uBb+6DsjOUES/0UAzIKGGSeIrZ8gkPuLrON4Nso+SDoVEbRa1BLAzuSCf
         ErC6mUpCB+VqiZwhrAmJmBWowLRoMID0tUyqfqpp9q3BWoENvWchtAPBmlWV1s+VbvT8
         uutaOozlWtACYU/FE7BNq1xTUq1gl3/ZyxJP7O7uY1tRfIOxGT5ZUXKtpLolQN2g+QwR
         RDoo3JJSraTJwegn4rrCm/gXXEWJ3yphA0St01h54eeo5YEHXyQf5s98ls3OOqvJPC54
         SN4zPBofrA2xQ8VRskBbr0cx0NkxQyup162ArnuwqH49QCPQvkHcNhPjIJwmapcpQPkX
         VLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tZpiteHABmHMSPpeLCCgPpkl35yK+eRJrcx7w2v7BEo=;
        b=Tzr4UGEZrB+p4c7O8ZXEszdbbP4L8WD6XHFb3e6V7s652qmqmtuSjqbgeaL1bZhCB+
         p2aTw1B0PkyfXwpfRXQa69rEwxMf0GpnOSY/gNqqud4l7DmqWhAKA1bsYCcqN6wPwcjo
         lHB0JXVkTn2nsjuGD/zQ5iOv9zItWkoKOrrCmXTYYrp6GGITRP57Pa77hBiy5FurjjQ5
         mzqnCRA0LpNb/8xicXLlWyNwnlpaVKrIvi1fpMYrPF0GFahyWN2sdl+9IcZ7pvhpaMxl
         xG4jzzrcMU8Wn40jAu5sgHmhvrvbVKkhibGOULWo0XDIkyessHCR+szPijAZWw4QHdAg
         MOPw==
X-Gm-Message-State: APjAAAVqIBi2MHL7EHTTfnacGAQJWmZ/TZedxlKlDjtJuettS9VkCwHl
        xt0HYCJc52zziLjxLvwQac4=
X-Google-Smtp-Source: APXvYqz/0GnRZMGK0hAP4dkgd4FJ4+Sorx1A7OT3jZAGzwNrYJMYdLwowSdZum6AL+DPDDpZgp9GCg==
X-Received: by 2002:ac8:2c8c:: with SMTP id 12mr86009283qtw.137.1564581042595;
        Wed, 31 Jul 2019 06:50:42 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id j2sm31211885qtb.89.2019.07.31.06.50.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 06:50:41 -0700 (PDT)
Date:   Wed, 31 Jul 2019 09:50:40 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     SunKe <sunke32@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        kamatam@amazon.com, manoj.br@gmail.com, stable@vger.kernel.org,
        dwmw@amazon.com
Subject: Re: [PATCH v2] nbd: replace kill_bdev() with __invalidate_device()
 again
Message-ID: <20190731135039.uisoh37v626h2aco@MacBook-Pro-91.local>
References: <1564575190-132357-1-git-send-email-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564575190-132357-1-git-send-email-sunke32@huawei.com>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 31, 2019 at 08:13:10PM +0800, SunKe wrote:
> From: Munehisa Kamata <kamatam@amazon.com>
> 
> Commit abbbdf12497d ("replace kill_bdev() with __invalidate_device()")
> once did this, but 29eaadc03649 ("nbd: stop using the bdev everywhere")
> resurrected kill_bdev() and it has been there since then. So buffer_head
> mappings still get killed on a server disconnection, and we can still
> hit the BUG_ON on a filesystem on the top of the nbd device.
> 
>   EXT4-fs (nbd0): mounted filesystem with ordered data mode. Opts: (null)
>   block nbd0: Receive control failed (result -32)
>   block nbd0: shutting down sockets
>   print_req_error: I/O error, dev nbd0, sector 66264 flags 3000
>   EXT4-fs warning (device nbd0): htree_dirblock_to_tree:979: inode #2: lblock 0: comm ls: error -5 reading directory block
>   print_req_error: I/O error, dev nbd0, sector 2264 flags 3000
>   EXT4-fs error (device nbd0): __ext4_get_inode_loc:4690: inode #2: block 283: comm ls: unable to read itable block
>   EXT4-fs error (device nbd0) in ext4_reserve_inode_write:5894: IO failure
>   ------------[ cut here ]------------
>   kernel BUG at fs/buffer.c:3057!
>   invalid opcode: 0000 [#1] SMP PTI
>   CPU: 7 PID: 40045 Comm: jbd2/nbd0-8 Not tainted 5.1.0-rc3+ #4
>   Hardware name: Amazon EC2 m5.12xlarge/, BIOS 1.0 10/16/2017
>   RIP: 0010:submit_bh_wbc+0x18b/0x190
>   ...
>   Call Trace:
>    jbd2_write_superblock+0xf1/0x230 [jbd2]
>    ? account_entity_enqueue+0xc5/0xf0
>    jbd2_journal_update_sb_log_tail+0x94/0xe0 [jbd2]
>    jbd2_journal_commit_transaction+0x12f/0x1d20 [jbd2]
>    ? __switch_to_asm+0x40/0x70
>    ...
>    ? lock_timer_base+0x67/0x80
>    kjournald2+0x121/0x360 [jbd2]
>    ? remove_wait_queue+0x60/0x60
>    kthread+0xf8/0x130
>    ? commit_timeout+0x10/0x10 [jbd2]
>    ? kthread_bind+0x10/0x10
>    ret_from_fork+0x35/0x40
> 
> With __invalidate_device(), I no longer hit the BUG_ON with sync or
> unmount on the disconnected device.
> 

Jeeze I swear I see this same patch go by every 6 months or so, not sure what
happens to it.  Anyway

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
