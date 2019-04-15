Return-Path: <SRS0=7FI7=SR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC205C10F0E
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 19:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE7A20848
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 19:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0q7jn0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbfDOToi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:44:38 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43507 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbfDOToi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Apr 2019 15:44:38 -0400
Received: by mail-pl1-f193.google.com with SMTP id n8so9063774plp.10
        for <linux-block@vger.kernel.org>; Mon, 15 Apr 2019 12:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kM517WVslK3F/N7tT2N+GPvER4mVQQJDaxD3CFTtvls=;
        b=T0q7jn0Cwe40SsXXnx+4GETexKEz5Eq1NDtI8rDY18oWwgf3tFDJ1qe8nggbe1nmnW
         EYr6rOE8plO9BTUld2MRZScUxFR/sC5BaVVfgehC640GTF5jko/Kj3SqxpAHnOnk4+wP
         qTm9sjnsV+AbmS484YQE2Okj7GZMggfUZBqL24gLUx2V8GUNzI/xJ07CawwVpJ8gqspc
         toBXJV91m7wnj5C6b630Ku5Gs8hstvH2QMC2+PoEZ6Oc01ep7CRg/z+cVenDa1kKmSzA
         MTZDFhubKR9EIBsbtYiBM3xknZ1ACsBxDXg2je/dgwhPnw+vt0YvLZ0OesPoJUld6m/K
         zPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kM517WVslK3F/N7tT2N+GPvER4mVQQJDaxD3CFTtvls=;
        b=iPiZv6UUitKfT0EJ/aKNEPApnBUy/T/3p98T6+Vg3YLWeXaUFOS/9L9IJXgRQti3pR
         P272CW7WmQGPy5ZooMCZ0CpsKwTTtgI3bIFR+fc8w3dZwqqR4MfHSz09FpJBDZkVkykN
         DyGU2YQMJtQKA8fmlkJGa9O/5sObd0dZmyLAiZQ535xEjKwPtk9Ipu9ei37HPWu37mIO
         wzFmwOLbA36TZazqQDhxRl3TMkt0gxxeyKd+CA1H/KRrFM30FnmfGByPoU+EBd0K/d0E
         ffDKNY2MmbJS3qpZc/kksBk70ItiL652U/64K59r2AMFfDglxDMcxnHMW//3fqxl14Ds
         16JA==
X-Gm-Message-State: APjAAAW6/o0/6mNNBMmA45qKWy3TrvC+LOUsOoH20Ltgmz2jKlM4royY
        9gaAHW+RaAYktDLUr8HiWzE=
X-Google-Smtp-Source: APXvYqywB8xIB5yQLvX6Ol+AmQaLk/7/oBjw3ilMrTn4PYNgfjqpWGvmZvQoOHDKGBfWsCXw7NSWoA==
X-Received: by 2002:a17:902:b78c:: with SMTP id e12mr25407342pls.29.1555357477866;
        Mon, 15 Apr 2019 12:44:37 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 128sm37818124pgb.47.2019.04.15.12.44.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 12:44:36 -0700 (PDT)
Date:   Mon, 15 Apr 2019 12:44:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/5] block: rewrite blk_bvec_map_sg to avoid a nth_page
 call
Message-ID: <20190415194435.GA23676@roeck-us.net>
References: <20190408104641.4905-1-hch@lst.de>
 <20190408104641.4905-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408104641.4905-2-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 08, 2019 at 12:46:37PM +0200, Christoph Hellwig wrote:
> The offset in scatterlists is allowed to be larger than the page size,
> so don't go to great length to avoid that case and simplify the
> arithmetics.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> ---

This patch causes crashes with various boot tests. Most sparc tests crash, as
well as several arm tests. Bisect results in both cases point to this patch.

On sparc:

Run /sbin/init as init process
kernel BUG at arch/sparc/lib/bitext.c:112!
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
lock_torture_wr(23): Kernel bad trap [#1]
CPU: 0 PID: 23 Comm: lock_torture_wr Not tainted 5.1.0-rc4-next-20190415 #1
PSR: 04401fc0 PC: f04a4e28 NPC: f04a4e2c Y: 00000000    Not tainted
PC: <bit_map_clear+0xe8/0xec>
%G: f000caec 00010003  f05db308 000000fd  00000000 000000fd  f514e000 f062be28
%O: 0000002a f05a41e0  00000070 00000001  f05dd564 f05dd504  f514f9a0 f04a4e20
RPC: <bit_map_clear+0xe0/0xec>
%L: 04001fc1 f00130c4  f00130c8 00000002  00000000 00000004  f514e000 00000547
%I: f500b990 0000003a  00000012 f513e570  00010000 f500b990  f514fa00 f001316c
Disabling lock debugging due to kernel taint
Caller[f001316c]: sbus_iommu_unmap_sg+0x34/0x60
Caller[f02d6170]: scsi_dma_unmap+0xac/0xd0
Caller[f02e2424]: esp_cmd_is_done+0x198/0x1a8
Caller[f02e4150]: scsi_esp_intr+0x191c/0x21e0
Caller[f0055438]: __handle_irq_event_percpu+0x8c/0x128
Caller[f00554e0]: handle_irq_event_percpu+0xc/0x4c
Caller[f0055550]: handle_irq_event+0x30/0x64
Caller[f0058b10]: handle_level_irq+0xb4/0x17c
Caller[f0054c38]: generic_handle_irq+0x30/0x40
Caller[f0009a4c]: handler_irq+0x3c/0x78
Caller[f0007b68]: patch_handler_irq+0x0/0x24
Caller[f004e054]: lock_torture_writer+0xc0/0x1fc
Caller[f003ca18]: kthread+0xd8/0x110
Caller[f00082f0]: ret_from_kernel_thread+0xc/0x38
Caller[00000000]:   (null)
Instruction DUMP:
 113c1690 
 7fed90ae 
 901221e0 
<91d02005>
 9de3bfa0 
 92102000 
 9406a01f 
 90100019 
 9532a005 

Kernel panic - not syncing: Aiee, killing interrupt handler!

On arm:

[   13.836353] Run /sbin/init as init process
[   13.937406] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[   13.937736] CPU: 0 PID: 1 Comm: init Not tainted 5.1.0-rc4-next-20190415 #1
[   13.937895] Hardware name: ARM-Versatile Express
[   13.938472] [<c0312a74>] (unwind_backtrace) from [<c030d350>] (show_stack+0x10/0x14)
[   13.938671] [<c030d350>] (show_stack) from [<c1097184>] (dump_stack+0xb4/0xc8)
[   13.938834] [<c1097184>] (dump_stack) from [<c03474c4>] (panic+0x110/0x328)
[   13.939008] [<c03474c4>] (panic) from [<c034c360>] (do_exit+0xbf8/0xc04)
[   13.939161] [<c034c360>] (do_exit) from [<c034d3c0>] (do_group_exit+0x3c/0xbc)
[   13.939323] [<c034d3c0>] (do_group_exit) from [<c0359460>] (get_signal+0x13c/0x9c4)
[   13.939491] [<c0359460>] (get_signal) from [<c030c760>] (do_work_pending+0x198/0x5f0)
[   13.939660] [<c030c760>] (do_work_pending) from [<c030106c>] (slow_work_pending+0xc/0x20)
[   13.939862] Exception stack(0xc703ffb0 to 0xc703fff8)
[   13.940102] ffa0:                                     b6f0e578 00000016 00000015 00000004
[   13.940372] ffc0: b6f0e060 b6f0e578 b6ede000 b6ede360 b6ef5dc0 b6ede95c b6ede2c0 becb6efc
[   13.940613] ffe0: b6f0e060 becb6ec0 b6edf628 b6ee9c00 60000010 ffffffff

Reverting the patch isn't possible since there are subsequent changes
affecting the code, and the image no longer builds after the revert.

Guenter

---
bisect results:

# bad: [f9221a7a1014d8a047b277a73289678646ddc110] Add linux-next specific files for 20190415
# good: [15ade5d2e7775667cf191cf2f94327a4889f8b9d] Linux 5.1-rc4
git bisect start 'HEAD' 'v5.1-rc4'
# good: [34ad076e8efd33658e4367df70a92058de7a870d] Merge remote-tracking branch 'crypto/master'
git bisect good 34ad076e8efd33658e4367df70a92058de7a870d
# bad: [5b51a36f96d773866e1a2165bacfcde58464eb1d] Merge remote-tracking branch 'devicetree/for-next'
git bisect bad 5b51a36f96d773866e1a2165bacfcde58464eb1d
# good: [457109829f4ee4107e8c7108237afba21fabbb5e] Merge branch 'drm-next-5.2' of git://people.freedesktop.org/~agd5f/linux into drm-next
git bisect good 457109829f4ee4107e8c7108237afba21fabbb5e
# good: [c4af5502948132ca3ce48d047188f8fc2f484dd7] Merge remote-tracking branch 'sound-asoc/for-next'
git bisect good c4af5502948132ca3ce48d047188f8fc2f484dd7
# bad: [722312b700e5fe2e9b16547fc2cb0dbbfb3e345c] Merge remote-tracking branch 'battery/for-next'
git bisect bad 722312b700e5fe2e9b16547fc2cb0dbbfb3e345c
# bad: [da55bae775eb580cd7f1b74850e55cf8880e7984] Merge branch 'for-5.2/block' into for-next
git bisect bad da55bae775eb580cd7f1b74850e55cf8880e7984
# good: [1e815b33c5ccd3936b71292b5ffb84e97e1df9e0] block: sed-opal: fix typos and formatting
git bisect good 1e815b33c5ccd3936b71292b5ffb84e97e1df9e0
# good: [06bda9d56ba3c0ba5ecb41f27da93a417aa442d1] Merge branch 'for-5.2/block' into for-next
git bisect good 06bda9d56ba3c0ba5ecb41f27da93a417aa442d1
# bad: [14eacf12dbc75352fa746dfd9e24de3170ba5ff5] block: don't allow multiple bio_iov_iter_get_pages calls per bio
git bisect bad 14eacf12dbc75352fa746dfd9e24de3170ba5ff5
# good: [ae50640bebc48f1fc0092f16ea004c7c4d12c985] md: use correct type in super_1_sync
git bisect good ae50640bebc48f1fc0092f16ea004c7c4d12c985
# good: [efcd487c69b9d968552a6bf80e7839c4f28b419d] md: add __acquires/__releases annotations to handle_active_stripes
git bisect good efcd487c69b9d968552a6bf80e7839c4f28b419d
# bad: [8a96a0e408102fb7aa73d8aa0b5e2219cfd51e55] block: rewrite blk_bvec_map_sg to avoid a nth_page call
git bisect bad 8a96a0e408102fb7aa73d8aa0b5e2219cfd51e55
# good: [22391ac30ab9cc2ba610bf7ea2244840b83c8017] Merge branch 'md-next' of https://github.com/liu-song-6/linux into for-5.2/block
git bisect good 22391ac30ab9cc2ba610bf7ea2244840b83c8017
# first bad commit: [8a96a0e408102fb7aa73d8aa0b5e2219cfd51e55] block: rewrite blk_bvec_map_sg to avoid a nth_page call
