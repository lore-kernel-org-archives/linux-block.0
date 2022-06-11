Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C917C43334
	for <linux-block@archiver.kernel.org>; Sat, 11 Jun 2022 09:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiFKJtK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 11 Jun 2022 05:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiFKJtJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 11 Jun 2022 05:49:09 -0400
X-Greylist: delayed 150 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 11 Jun 2022 02:49:08 PDT
Received: from resqmta-c1p-024061.sys.comcast.net (resqmta-c1p-024061.sys.comcast.net [IPv6:2001:558:fd00:56::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63E326ADE
        for <linux-block@vger.kernel.org>; Sat, 11 Jun 2022 02:49:08 -0700 (PDT)
Received: from resomta-c1p-022592.sys.comcast.net ([96.102.18.237])
        by resqmta-c1p-024061.sys.comcast.net with ESMTP
        id zxfVnpaGcwEG3zxhVnLvNl; Sat, 11 Jun 2022 09:46:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1654940797;
        bh=4wlAJzloxfebzj0QZ5tbUKwCcQhSxlLII/J78gbwRM0=;
        h=Received:Received:Message-ID:Date:MIME-Version:To:From:Subject:
         Content-Type;
        b=Nin8RHIoKQHgwyP+lDzOIlBBmY3tw8bzaRzsqKIbEkRlIspDBdjGtSdSkc2GdT5lJ
         9cRHiz1rKWyTGnZvVWrhhFylB33hawqOU1pZRuF+DZ0hZSbgWWp330VocTIjU+mlrv
         n1tCYY7eKgHPfD9NGJNXQvauu5XkuP5fxlQqyBSYAVW0NgBZCaYDWOoI+muMiy167I
         8O1POALmYganvwZqgpy+xdtKNILvVBDdPWqj/pAAMamxB/bOTshDyEImIDFVRYjPj0
         xTXk9VAh5W7AHt64+42kEX8LNiagK4atQ+g0amqhhq1JVfzjhr1jRDMbgKE3fvHnSh
         G46h64njGY+GQ==
Received: from [IPV6:2601:647:4700:284:fffe:9b3e:6d02:e003]
 ([IPv6:2601:647:4700:284:fffe:9b3e:6d02:e003])
        by resomta-c1p-022592.sys.comcast.net with ESMTPSA
        id zxhRnNXDRrEBozxhUnE1lc; Sat, 11 Jun 2022 09:46:37 +0000
X-Xfinity-VMeta: sc=0.00;st=legit
Message-ID: <849cea40-4665-14fe-fa46-e555af730214@comcast.net>
Date:   Sat, 11 Jun 2022 02:46:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     linux-block@vger.kernel.org
From:   Ron Economos <w6rz@comcast.net>
Subject: loop device failure on 5.19-rc1 RISC-V
Cc:     hch@lst.de
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following error messages occur on 5.19-rc1 RISC-V Ubuntu 22.04:

Jun 08 21:00:20 riscv64 kernel: Dev loop0: unable to read RDB block 8
Jun 08 21:00:20 riscv64 kernel:  loop0: unable to read partition table
Jun 08 21:00:20 riscv64 kernel: loop0: partition table beyond EOD, truncated

This happens when the snapd daemon tries to mount loop0.

Reverting commit b9684a71fca793213378dd410cd11675d973eaa1

block, loop: support partitions without scanning

solves the issue.

