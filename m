Return-Path: <SRS0=GKfo=62=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C634CC54E4A
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 12:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97F6F20674
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 12:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7AkaL4j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgELMJR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 May 2020 08:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgELMJQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 May 2020 08:09:16 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9FEC061A0C
        for <linux-block@vger.kernel.org>; Tue, 12 May 2020 05:09:16 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id s186so11381389qkd.4
        for <linux-block@vger.kernel.org>; Tue, 12 May 2020 05:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T2fncHwwyBGjLFuee7Yap/yZ6xzfu3YuAgvACLPEZ7Y=;
        b=A7AkaL4j2ljencVkYQF8gS0KzIaLvcuJEVQA+5p4eJ5gcPiZh1KOiWvwQHaGZWCFQf
         j3doxibYshyggjkk1HqG1Zzl/TO2FX6V4QtYJeR5r/ZzoDlddYrLXMmoYk7m4Z4uQeUk
         GA0GuJZrmtJbqCSiiAWgSIHB1R7cJd3yvYgG5i9AoOkZ4il85t9SyHGEr+tXotNFWBYz
         zWCm+Y2S7trlfafeO+Hfj1etHayYQUVFoCuT7q+jQLJW8ahJS7JyV10hUaRuRcvhvp+C
         Ab3uZo/wfczGgpu3Rz6l0DDOkH/L79NVkcwR56KQljvUUdwd4M628+9o0wBVnqbbbIDu
         +xcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T2fncHwwyBGjLFuee7Yap/yZ6xzfu3YuAgvACLPEZ7Y=;
        b=aezZUjE5IPAFRT/QjsI2oMtDHB/Z0CO2nJrb6gY3tgrUpEAxDa1W52ozNz8hiGAqFv
         dZCNZcbaFBu7xLlx7xUCCQoEIGAJd0HGTijQX+uIt+mIeyHnKI1yyJsd9zZzwveX9FUK
         hub/3iuvmrcG1+OKEnSBX61hxpyybWOxtGhjCUDEQGx5E9fao6s8C+4mA98T2uxyBO06
         Jrdmp7/nwPeki3aau8t9WE1EZXqBaDpcvCZyjWlsgnAleKzy64M9FWwNzB34EqbwbydV
         EULFCYehfJCdNSL/AtWV+IWp2406ODedW7n/e0mG0AMDXRoNMgHI5314oWvjQbDapA3q
         6MIw==
X-Gm-Message-State: AGi0Pua9hOwihw4YloGvZyB3AcybQc7WhqIbrcSLta7NbO3tm9GWDUMQ
        R73Y+PdQ0eICJl5TATl207z8yHSUPGd1sdBuwXU=
X-Google-Smtp-Source: APiQypLQdANhCyKBqghA6PMs+bJNFuVmKNb3pfnA1C3KI3hZ9rxBeZOmHCVdCJkXqYSVTuxxPl5yyMncE5gRyNE/+eo=
X-Received: by 2002:a37:97c1:: with SMTP id z184mr14862208qkd.249.1589285355848;
 Tue, 12 May 2020 05:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588856361.git.zhangweiping@didiglobal.com> <5211ebcc-a123-47be-1a59-b2d767bab519@acm.org>
In-Reply-To: <5211ebcc-a123-47be-1a59-b2d767bab519@acm.org>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Tue, 12 May 2020 20:09:02 +0800
Message-ID: <CAA70yB6iG3YmMzHDbhv864wi9dOonb9wFY8GiOMjD6DLSHokNA@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Fix potential kernel panic when increase hardware queue
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, tom.leiming@gmail.com,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org,
        Weiping Zhang <zhangweiping@didiglobal.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 12, 2020 at 9:31 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-05-07 06:03, Weiping Zhang wrote:
> > This series mainly fix the kernel panic when increase hardware queue,
> > and also fix some other misc issue.
>
> Does this patch series survive blktests? I'm asking this because
> blktests triggers the crash shown below for Jens' block-for-next branch.
> I think this report is the result of a recent change.
>
> run blktests block/030
>
> null_blk: module loaded
> Increasing nr_hw_queues to 8 fails, fallback to 1
> ==================================================================
> BUG: KASAN: null-ptr-deref in blk_mq_map_swqueue+0x2f2/0x830
> Read of size 8 at addr 0000000000000128 by task nproc/8541
>
> CPU: 5 PID: 8541 Comm: nproc Not tainted 5.7.0-rc4-dbg+ #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.13.0-0-gf21b5a4-rebuilt.opensuse.org 04/01/2014
> Call Trace:
>  dump_stack+0xa5/0xe6
>  __kasan_report.cold+0x65/0xbb
>  kasan_report+0x45/0x60
>  check_memory_region+0x15e/0x1c0
>  __kasan_check_read+0x15/0x20
>  blk_mq_map_swqueue+0x2f2/0x830
>  __blk_mq_update_nr_hw_queues+0x3df/0x690
>  blk_mq_update_nr_hw_queues+0x32/0x50
>  nullb_device_submit_queues_store+0xde/0x160 [null_blk]
>  configfs_write_file+0x1c4/0x250 [configfs]
>  __vfs_write+0x4c/0x90
>  vfs_write+0x14b/0x2d0
>  ksys_write+0xdd/0x180
>  __x64_sys_write+0x47/0x50
>  do_syscall_64+0x6f/0x310
>  entry_SYSCALL_64_after_hwframe+0x49/0xb3
>
> Thanks,
>

Hi Bart,

I don't test block/030, since I don't pull blktest very often.

It's a different problem,
because the mapping cann't be reset when do fallback, so the
cpu[>=1] will point to a hctx(!=0).

 it should be fixed by:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index bc34d6b572b6..d82cefb0474f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3365,8 +3365,8 @@ static void __blk_mq_update_nr_hw_queues(struct
blk_mq_tag_set *set,
                goto reregister;

        set->nr_hw_queues = nr_hw_queues;
-       blk_mq_update_queue_map(set);
 fallback:
+       blk_mq_update_queue_map(set);
        list_for_each_entry(q, &set->tag_list, tag_set_list) {
                blk_mq_realloc_hw_ctxs(set, q);
                if (q->nr_hw_queues != set->nr_hw_queues) {
> Bart.
