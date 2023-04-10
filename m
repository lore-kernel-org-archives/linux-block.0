Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB1FC76196
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 11:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjDJLtc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 07:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDJLtb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 07:49:31 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7022849D8
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 04:49:30 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id C8C472B067A3;
        Mon, 10 Apr 2023 07:49:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 10 Apr 2023 07:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1681127366; x=1681127966; bh=r4BCmjZXjIvYt/f6w97laQkdk
        EmzOoan8dalpyKawq8=; b=q0HhgsH16snrZWzPbz1zdce8Qe1ia0KwOAoYHEZva
        pp/yFhUNvvE7MhZPK0ksIJ2Y7pEhQ7vL8NSAspVO991u5kkymJFt/dMyOnhPoMXl
        zZ/OI6rOckAbJkDPqFClL/rKxMMvHumNoXEYZrE6TY0llEcqKeVjsGR7u3Ij099u
        qc4SEA3KyD+TKbnswKkSsqmZj06/wPrXKleRmrLmAZm9NZ4ZXucjcsApyiLaphIy
        2wVsQ3/wjHyOI7tRYxk2CFpQR1ZsjzK6w6KRTS8kEZS7zEAZ8/BvZc2pnzFLt0J3
        M5TV4wo1rd9WBINkZlqMQi7GC//qkLJYvOvtni2mQqbEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=ie1e949a3.fm2;
         t=1681127366; x=1681127966; bh=r4BCmjZXjIvYt/f6w97laQkdkEmzOoan
        8dalpyKawq8=; b=iHEnQYAaeO49TnpC95pKb+sYkMA6pFfRe3MEN6Xr7IFL5AjJ
        IBa7tfwU78gHj2a00OQsKhoh06LfgMR4AuZcZXj8pInA1rs8paYeju3JOC5D8sHl
        JBkLkDRzx8pXwbaz4VNxfoLEPP9LZ27t2waCr0c2y19PyqKHdmJ1ehlN5/ANIFtW
        na1H+iYpQktzZLuDM1/bQDewGMbcqImuqxOcQx7W2ZXwFHTKHEE4JAEDJAjdftAU
        1Wwsj8Hg7riqk/C2fwhjCFhthav3t5reZvUR3kWuoMeCwRaXXYcBFmXFqhR0FXEl
        4nXaP+OpiBHix5Mf6YgNbXJFjCCKn3Tmb6KXtA==
X-ME-Sender: <xms:xfczZMxqLwrYVdFIRz43ehwl-sr8H4rryIdZcgzBNE8GV5wytCFyZg>
    <xme:xfczZATdKZS4LfPiaf3IEsA9Ve8-rKfHi6htxhz0J8MAJh3ShlOVA5bY9bClTNoX-
    6uBtG4REWhfC6CK24c>
X-ME-Received: <xmr:xfczZOUKdeHF7eYAcp3DrJFd0MckDe08s2tcsqmIA26OrP3awR_tmYfy_NYeIGnXmp7U-LCbLc_RvVG2pwvzBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekvddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesthdtsfdttd
    dtvdenucfhrhhomhepufhhihhnkdhitghhihhrohcumfgrfigrshgrkhhiuceoshhhihhn
    ihgthhhirhhosehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepveevge
    evveeivdehfeeggeeiveevfeekvdegudetgeelieduheeuieekieeftedtnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhhihhnihgthhhirh
    hosehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:xfczZKjNngzW4wu00VIoM_MOXlMrcFGHOjdZjm-e8mDR3RW_WYhuKw>
    <xmx:xfczZOBEho9XwTbngfHdqPxV9ePyOXPgRtvrNhn06LR9Q1P0lwWnhg>
    <xmx:xfczZLIvc_36vTDLAzA-Ej1EeeWhPQU0eyUSJJygSoHGepkQzM5h3A>
    <xmx:xvczZP7l0m7Y7H34AWvNhuH4ZwGg9Nn1udkCwSfG1DL4Z3JzLosxqJpCEs7sJEeQ>
Feedback-ID: ie1e949a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Apr 2023 07:49:24 -0400 (EDT)
Date:   Mon, 10 Apr 2023 20:49:22 +0900
From:   Shin'ichiro Kawasaki <shinichiro@fastmail.com>
To:     alan.adamson@oracle.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: blktests nvme/039 failure
Message-ID: <5vnpdeocos6k4nmh6ewh7ltqz7b6wuemzcmqflfkybejssewkh@edtqm3t4w3zv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Alan,

I noticed that recently nvme/039 fails on my system occasionally (around 40%).
The failure messages are as follows:

nvme/039 => nvme0n1 (test error logging)                     [failed]
    runtime  0.176s  ...  0.167s
    --- tests/nvme/039.out      2023-04-06 10:11:07.925670528 +0900
    +++ /home/shin/Blktests/blktests/results/nvme0n1/nvme/039.out.bad   2023-04-10 20:15:07.679538017 +0900
    @@ -1,5 +1,2 @@
     Running nvme/039
    - Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x81) DNR
    - Read(0x2) @ LBA 0, 1 blocks, Unknown (sct 0x3 / sc 0x75) DNR
    - Write(0x1) @ LBA 0, 1 blocks, Write Fault (sct 0x2 / sc 0x80) DNR
     Test complete

nvme/039 => nvme0n1 (test error logging)                     [failed]
    runtime  0.167s  ...  0.199s
    --- tests/nvme/039.out      2023-04-06 10:11:07.925670528 +0900
    +++ /home/shin/Blktests/blktests/results/nvme0n1/nvme/039.out.bad   2023-04-10 20:15:09.114539650 +0900
    @@ -1,5 +1,4 @@
     Running nvme/039
    - Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x81) DNR
      Read(0x2) @ LBA 0, 1 blocks, Unknown (sct 0x3 / sc 0x75) DNR
      Write(0x1) @ LBA 0, 1 blocks, Write Fault (sct 0x2 / sc 0x80) DNR
     Test complete

It looks that expected error messages were not reported.

I suspect that the time duration is too short between error injection enable
and I/O to trigger the error. With the one line change below to add wait after
the error injection enable, the failures disappear. Do you think such wait is
the valid fix?

 tests/nvme/rc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 210a82a..7043c23 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -652,6 +652,7 @@ _nvme_enable_err_inject()
         echo "$4" > /sys/kernel/debug/"$1"/fault_inject/dont_retry
         echo "$5" > /sys/kernel/debug/"$1"/fault_inject/status
         echo "$6" > /sys/kernel/debug/"$1"/fault_inject/times
+	sleep 0.1
 }
 
 _nvme_disable_err_inject()
-- 
2.39.2

