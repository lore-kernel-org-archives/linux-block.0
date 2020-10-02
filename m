Return-Path: <SRS0=oVJv=DJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560F2C4363D
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 13:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E68A206DB
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 13:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fm6DfaJf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgJBNt6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Oct 2020 09:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgJBNt6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Oct 2020 09:49:58 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BE2C0613D0;
        Fri,  2 Oct 2020 06:49:55 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x22so1245752pfo.12;
        Fri, 02 Oct 2020 06:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pd2E4pk015R2XdMt2k5oTuv87igGS+Moi+dfcF3aud4=;
        b=fm6DfaJf6otXShorBJAUKni5EtrE+TSTYSmn0Oyq0izvTGDiRUl0Nz/T4S6Xft7DHi
         TCAUe6dOLxbEzRzEkNDoD805LI4/4wTbIvcGenDhAOxrbI3F7frwXREjyUyP1E7KYBUa
         0zxvUrNq27JoPDk4RLH0vjQHvcxdI0dnxOlwnf8JRdZqzqopaErhmw3rHq+2QECPDgJF
         HmKSYLXBkIBHUu/3mZS1VcMM19Cuz01iwzDZ0pvdEyL8BvgavAwU/PiAYAeW24aO6rEU
         tCtGwQM9tiAK6EAQqj7Ip43Qj5CI37UuTi6/m4yIFY24mdPl/YF+dQ/D4Bh6bqL11ANp
         yaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pd2E4pk015R2XdMt2k5oTuv87igGS+Moi+dfcF3aud4=;
        b=JOZ1aUI1NUQpi5EKzp1SK2od3MyNREyKY/eOXGMUF3srG/KSK0/4ghxyX3biQhbp3Z
         KTb4dSI83xbcfm8s6JkKImrOfQGD1XGBM+DScK8yujIADOqwp1Hwt1/DQ6DsopX8JApU
         HKjl5sT0fyho4ikTnEOAv3/Ckry53LnDXIeBnHFmXzsz34eWtC3gTV0NuLUT8LVVT9xx
         DCbwSr4fpwo06FJTfGhiFYG9DkpjGASXo61SKJ1rOJk7q7hpeXYByE17HrHSPQdTxPJ6
         VTewOHLyxtOqy+8colUPvaOp6qR58oHW9q5wJa42ka+PntyY6TgGkWfcOl6oUWrNX5VE
         n/UA==
X-Gm-Message-State: AOAM530th12HLUrDq27R6KwTirV9Yb48Ue7VSC0r5EBA6jhBkbTEiKS7
        CihMwJxX7bFu2YeBd2/Dgg==
X-Google-Smtp-Source: ABdhPJwaSLwwvJEXpuTtS5g0uD2iW6wSVbjVjp+V+VQFgatBFf4x/OzktcviyT37nI7bHk3P2LQ8iQ==
X-Received: by 2002:aa7:9ad6:0:b029:142:2501:3975 with SMTP id x22-20020aa79ad60000b029014225013975mr2757157pfp.58.1601646594794;
        Fri, 02 Oct 2020 06:49:54 -0700 (PDT)
Received: from PWN ([161.117.80.159])
        by smtp.gmail.com with ESMTPSA id s4sm2013178pfu.107.2020.10.02.06.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 06:49:53 -0700 (PDT)
Date:   Fri, 2 Oct 2020 09:49:44 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     syzbot <syzbot+85433a479a646a064ab3@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, glider@google.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: KMSAN: kernel-infoleak in scsi_cmd_ioctl
Message-ID: <20201002134944.GA8205@PWN>
References: <000000000000a24fa705ae29dc6c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a24fa705ae29dc6c@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 31, 2020 at 03:28:22AM -0700, syzbot wrote:
> BUG: KMSAN: kernel-infoleak in kmsan_copy_to_user+0x81/0x90 mm/kmsan/kmsan_hooks.c:253
> CPU: 1 PID: 12272 Comm: syz-executor.3 Not tainted 5.8.0-rc5-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x21c/0x280 lib/dump_stack.c:118
>  kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:121
>  kmsan_internal_check_memory+0x238/0x3d0 mm/kmsan/kmsan.c:423
>  kmsan_copy_to_user+0x81/0x90 mm/kmsan/kmsan_hooks.c:253
>  instrument_copy_to_user include/linux/instrumented.h:91 [inline]
>  _copy_to_user+0x18e/0x260 lib/usercopy.c:33
>  scsi_put_cdrom_generic_arg include/linux/uaccess.h:170 [inline]

+ Cc: Greg Kroah-Hartman
+ Cc: Anant Thazhemadam

Hi all,

In looking at the report, I guess this patch should fix the issue, there's
a 3-byte hole in `struct compat_cdrom_generic_command`:

[PATCH v3] block/scsi-ioctl: Prevent kernel-infoleak in scsi_put_cdrom_generic_arg()
https://lore.kernel.org/lkml/20200909095057.1214104-1-yepeilin.cs@gmail.com/

But I cannot verify it, since syzbot doesn't have a reproducer for it.
The patch adds a 3-byte padding field to `struct
compat_cdrom_generic_command`. It hasn't been accepted yet.

> Local variable ----cgc32.i42.i@scsi_cmd_ioctl created at:
>  scsi_put_cdrom_generic_arg block/scsi_ioctl.c:695 [inline]

#ifdef CONFIG_COMPAT
	if (in_compat_syscall()) {
		struct compat_cdrom_generic_command
		[...]

$ # before
$ pahole -C "compat_cdrom_generic_command" !$
pahole -C "compat_cdrom_generic_command" block/scsi_ioctl.o
struct compat_cdrom_generic_command {
	unsigned char              cmd[12];              /*     0    12 */
	compat_caddr_t             buffer;               /*    12     4 */
	compat_uint_t              buflen;               /*    16     4 */
	compat_int_t               stat;                 /*    20     4 */
	compat_caddr_t             sense;                /*    24     4 */
	unsigned char              data_direction;       /*    28     1 */

	/* XXX 3 bytes hole, try to pack */

	compat_int_t               quiet;                /*    32     4 */
	compat_int_t               timeout;              /*    36     4 */
	compat_caddr_t             reserved[1];          /*    40     4 */

	/* size: 44, cachelines: 1, members: 9 */
	/* sum members: 41, holes: 1, sum holes: 3 */
	/* last cacheline: 44 bytes */
};
$ # after
$ pahole -C "compat_cdrom_generic_command" block/scsi_ioctl.o
struct compat_cdrom_generic_command {
	unsigned char              cmd[12];              /*     0    12 */
	compat_caddr_t             buffer;               /*    12     4 */
	compat_uint_t              buflen;               /*    16     4 */
	compat_int_t               stat;                 /*    20     4 */
	compat_caddr_t             sense;                /*    24     4 */
	unsigned char              data_direction;       /*    28     1 */
	unsigned char              pad[3];               /*    29     3 */
	compat_int_t               quiet;                /*    32     4 */
	compat_int_t               timeout;              /*    36     4 */
	compat_caddr_t             reserved[1];          /*    40     4 */

	/* size: 44, cachelines: 1, members: 10 */
	/* last cacheline: 44 bytes */
};
$ _

Thank you,
Peilin Ye

