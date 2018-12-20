Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA97C43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 04:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF40A2177B
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 04:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPjTGIce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbeLTEGZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Dec 2018 23:06:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39001 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729543AbeLTEGZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Dec 2018 23:06:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so278734wra.6
        for <linux-block@vger.kernel.org>; Wed, 19 Dec 2018 20:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=764p58HLM0lpo1BToc1E4Ap2ilx0jsMqSsDNuXFirts=;
        b=MPjTGIceJlHhNBZaXvZ9f0+QeLm99Rz2VduLhYSsBXeWQ0f+73ZhpLqyKfXQw9uIEM
         oReFljkTNpSNIKTTsVuYQOgolTdiY4d3EOiD1EzOMq13nWELuJ3Wlds9MOD5AY/Shyir
         HF+qnriFDze0+cSvrPKzyCSUy284zpRUkxvzmEyyFK2b8WHXLdQxMo0JUO/rnXc/j9LY
         GtPyMCovBJVg4aY/qSWtRaAGzmFMpmFak7ftLtkHCWT2Mz9rReimYIOQh4CxR1U6BqU7
         GXiDNdmzJaR0Cr/YAs5kFufFA7RlgOe6XNZ/mMHoPUldfrMp8PNE6DZH6McZxbO/ZyHg
         AueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=764p58HLM0lpo1BToc1E4Ap2ilx0jsMqSsDNuXFirts=;
        b=tfAMJp0teO0Rro0ssZczWrFKWTYepKrcvv6OfmDOOrPfbI7wjIcz9H9okZJBHwTNAa
         0vuP6qYUuzqBtmB9suHbKYT9NW9j7ecmKFaW5GPtuXJlG7q/PCqGjVgk7ipQxt8KRnBH
         E1cHPml7KCFch+wbgq1Cnj8I93g4/dps3WGV4yl9LoX7CAsyrfEyLleVg8A02yqlG5LH
         0dkOP0ck5+Xvna4BMEEl+D13rDmfypm6u6tjLzx6/ii26BV8ipmKUfEAQ9pqFrlI+Vql
         L8WTRzpHkYRCNbCT72j8F9EfWQEamFGsvwZxY0XK4aON+8AwkQlzMccpyqr7n06b2gH5
         RXiQ==
X-Gm-Message-State: AA+aEWYLSAH+NNwmuJgokXFjdsZtgH3cUeXFt4lVXgWYLtCj5gRhbql3
        MzXdse0fZgkKzkTq5yuXSYemLpY4HRgIu4Q7anvN1841qfI=
X-Google-Smtp-Source: AFSGD/XxdeXUrtZ8MxtcHtBH6eBR3avmpdKf0D26lYSr8OjQwuYnFylNJylpZnEi+hxhABlkEgRHYQglCxw9RZk4y2M=
X-Received: by 2002:adf:97d1:: with SMTP id t17mr20687436wrb.283.1545278782760;
 Wed, 19 Dec 2018 20:06:22 -0800 (PST)
MIME-Version: 1.0
References: <1545261885.185366.488.camel@acm.org>
In-Reply-To: <1545261885.185366.488.camel@acm.org>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Thu, 20 Dec 2018 12:06:10 +0800
Message-ID: <CACVXFVM6DaT7385bgimhJOboRHDTXNkOFFy15i=SBP1_-MWx_A@mail.gmail.com>
Subject: Re: v4.20-rc6: Sporadic use-after-free in bt_iter()
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 20, 2018 at 9:22 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> Hello,
>
> If I run the srp blktests in a loop then I see the below call stack appearing
> sporadically. I have not yet had the time to analyze this but I'm reporting
> this here in case someone else would already have had a look at this.
>
> Bart.
>
> ==================================================================
> BUG: KASAN: use-after-free in bt_iter+0x86/0xf0
> Read of size 8 at addr ffff88803b335240 by task fio/21412
>
> CPU: 0 PID: 21412 Comm: fio Tainted: G        W         4.20.0-rc6-dbg+ #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> Call Trace:
>  dump_stack+0x86/0xca
>  print_address_description+0x71/0x239
>  kasan_report.cold.5+0x242/0x301
>  __asan_load8+0x54/0x90
>  bt_iter+0x86/0xf0
>  blk_mq_queue_tag_busy_iter+0x373/0x5e0
>  blk_mq_in_flight+0x96/0xb0
>  part_in_flight+0x40/0x140
>  part_round_stats+0x18e/0x370
>  blk_account_io_start+0x3d7/0x670
>  blk_mq_bio_to_request+0x19c/0x3a0
>  blk_mq_make_request+0x7a9/0xcb0
>  generic_make_request+0x41d/0x960
>  submit_bio+0x9b/0x250
>  do_blockdev_direct_IO+0x435c/0x4c70
>  __blockdev_direct_IO+0x79/0x88
>  ext4_direct_IO+0x46c/0xc00
>  generic_file_direct_write+0x119/0x210
>  __generic_file_write_iter+0x11c/0x280
>  ext4_file_write_iter+0x1b8/0x6f0
>  aio_write+0x204/0x310
>  io_submit_one+0x9d3/0xe80
>  __x64_sys_io_submit+0x115/0x340
>  do_syscall_64+0x71/0x210
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x7f02cf043219
> Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 47 fc 0c 00 f7 d8 64 89 01 48
> RSP: 002b:00007f02a1df78b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
> RAX: ffffffffffffffda RBX: 00007f02a1df8ef8 RCX: 00007f02cf043219
> RDX: 00007f029804a7c0 RSI: 0000000000000001 RDI: 00007f02c4f67000
> RBP: 00007f02c4f67000 R08: 00007f0298007af0 R09: 00007f02a362f0f0
> R10: 00007f029804a9c0 R11: 0000000000000246 R12: 0000000000000001
> R13: 0000000000000000 R14: 00007f029804a7c0 R15: 00007f0298049f60
>
> The buggy address belongs to the page:
> page:ffffea0000eccd40 count:0 mapcount:0 mapping:0000000000000000 index:0x0
> flags: 0x1fff000000000000()
> raw: 1fff000000000000 0000000000000000 ffffffff00ec0201 0000000000000000
> raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff88803b335100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>  ffff88803b335180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >ffff88803b335200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>                                            ^
>  ffff88803b335280: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>  ffff88803b335300: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ==================================================================

It isn't a new issue, and I reported it on v4.16 actually:

https://lists.openwall.net/linux-ext4/2018/04/04/6

Thanks,
Ming Lei
