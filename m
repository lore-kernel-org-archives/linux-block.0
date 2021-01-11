Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A73C433DB
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 17:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D835122AAD
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 17:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389111AbhAKRGc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jan 2021 12:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730342AbhAKRGb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jan 2021 12:06:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E76DC0617A2
        for <linux-block@vger.kernel.org>; Mon, 11 Jan 2021 09:05:51 -0800 (PST)
Date:   Mon, 11 Jan 2021 18:05:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610384749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M8ewGNe+dVJQ1GN8KqHjVmB38uC0U1Nx3E0FtB6lQlU=;
        b=Q4nUXs0ioBZHaPgRoo1OKO4rf8HX0eHsev5v7b64YBQAfOARnuwhE2WxpDcgyKJ80GYtzh
        KE7kky7ua4FBQdsniYQAKmkBSOAWAmBK2QLBLH0iP/zrHs1csIvCydRpdigMIH8HLrtGp7
        cQLtaqO+SXyJi+1yCn3creYLd43D1MducE08H3FvSQjqv4gbDj4JNh/rs6wKEX5W91LX1o
        C7QUEEG8pUV0j2C0sPjOR2M+Q4R7zPhyWeeePF7kHRaKZP08Jo5P4V649x52C4Ba33XFBA
        YtW+YMy61UY5mMjdR8LZl8FtrPUFsyinMK2Nx/I5tYUABIMcXtXYBRCeIwxLWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610384749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M8ewGNe+dVJQ1GN8KqHjVmB38uC0U1Nx3E0FtB6lQlU=;
        b=0OQlGZJ/A/GxlBThxUoclGlga3ecire1rTfHtHFldSjA5vPoCCDOo5gvzJyjxhGhc646FB
        S/QwJQDMAW8ksECQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: "blk-mq: Use llist_head for blk_cpu_done" causing warnings
Message-ID: <20210111170549.bdelgeb524d3phbc@linutronix.de>
References: <1ee4b31b-350e-a9f5-4349-cfb34b89829a@kernel.dk>
 <20201218151824.quxry5bmaqlpohkr@linutronix.de>
 <7da575fc-d750-55c1-473c-66f6ca8825bb@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7da575fc-d750-55c1-473c-66f6ca8825bb@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-12-18 08:22:29 [-0700], Jens Axboe wrote:

Hi,

> > Anyway, could you please throw a .config and the test in my inbox so I
> > can reproduce it and then I will look at this next year.
> 
> Attached. The test is just booting my vm, haven't even started running
> anything when it triggers. It also seems to be happening throughout
> the vm running, at a pretty low rate though.

I tried those patches on my old -next tree, v5.11-rc1 and today's -next
tree. I booted your config with:
| exec qemu-system-x86_64  \
|         -m 4G \
|         -machine q35,accel=kvm \
|         -cpu host \
|         -smp 8 \
|         -kernel "$KERNEL" \
|         -drive file=Deb_sid_amd64-playground_xfs.img,if=virtio,id=diskroot,media=disk,format=raw,discard=on,snapshot=on \
|         -nographic \
|         -append "earlyprintk=ttyS0,115200 console=ttyS0,115200n8 root=/dev/vda1 sysrq_always_enabled ftrace_dump_on_oops nokaslr ignore_loglevel"
|

on an AMD and Intel (due to only CONFIG_CPU_SUP_INTEL=y). Nothing.
Is there anything special in your commandline / disk-setup? After a
complete disk-upgrade I have almost no block-softirqs:

|~# grep BLOCK /proc/softirqs
|       BLOCK:          0          0          0          0          4          0          8          0

Sebastian
