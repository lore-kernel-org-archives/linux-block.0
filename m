Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36821 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755910AbdESSs6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2017 14:48:58 -0400
Received: by mail-pg0-f53.google.com with SMTP id x64so41858089pgd.3
        for <linux-block@vger.kernel.org>; Fri, 19 May 2017 11:48:58 -0700 (PDT)
Date: Fri, 19 May 2017 11:48:54 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Linux Block Layer Mailinglist <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] check: add ability to exclude a test or group
Message-ID: <20170519184854.GA9332@vader.DHCP.thefacebook.com>
References: <20170519131710.4813-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170519131710.4813-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, May 19, 2017 at 03:17:10PM +0200, Johannes Thumshirn wrote:
> Add the ability to exclude a test or whole test group from a test
> run. Thus a user can explicitly decide which tests to skip like in
> this example where one wants all of the 'block' group but block/001.
> 
> block/002 (remove a device while running blktrace)
>     0.835s           ...
>     runtime  + test  ...
> [  363.132053] run blktests block/002 at 2017-05-19 13:01:56
> [  363.136844] scsi host0: scsi_debug: version 1.86 [20160430]
> [  363.136844]   dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0
> [  363.138819] scsi 0:0:0:0: Direct-Access     Linux    scsi_debug       0186 PQ: 0 ANSI: 7
> [  363.199172] sd 0:0:0:0: [sda] 16384 512-byte logical blocks: (8.39 MB/8.00 MiB)
> [  363.207053] sd 0:0:0:0: [sda] Write Protect is off
> block/002 (remove a device while running blktrace)           [passed]
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Thanks, Johannes! I applied this with the added ability to specify it in
the config file with

EXCLUDE=(loop block/001)
