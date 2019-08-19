Return-Path: <SRS0=5ZWj=WP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D7AC3A5A0
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 16:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6BD22CEB
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 16:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfHSQk4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Aug 2019 12:40:56 -0400
Received: from guest-port.merlins.org ([173.11.111.148]:43653 "EHLO
        mail1.merlins.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfHSQk4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Aug 2019 12:40:56 -0400
Received: from merlin by mail1.merlins.org with local (Exim 4.92 #3)
        id 1hzkiE-00073z-3x by authid <merlin>; Mon, 19 Aug 2019 09:40:54 -0700
Date:   Mon, 19 Aug 2019 09:40:54 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-raid@vger.kernel.org
Subject: Re: 5.1.21 Dell 2950 terrible swraid5 I/O performance with swraid on top of Perc 5/i raid0/jbod
Message-ID: <20190819164053.GF5431@merlins.org>
References: <20190819070823.GH12521@merlins.org> <5DCAD3D8-07B6-4A5D-A3C1-A1DF4055C5BD@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5DCAD3D8-07B6-4A5D-A3C1-A1DF4055C5BD@linaro.org>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 19, 2019 at 11:18:13AM +0200, Paolo Valente wrote:
> Solving this kind of problem is one of the goals of the BFQ I/O scheduler [1].
> Have you tried?  If you want to, then start by swathing to BFQ in both the
> physical and the virtual block devices in your stack.
 
I sure was not aware of it, thank you for pointing it out.

> Thanks,
> Paolo
> 
> [1] https://algo.ing.unimo.it/people/paolo/BFQ/

I did the following below and when the swraid is rebuilding, I'm still
getting terrible overall throughput:
newmagic:~# hdparm -t /dev/md2
/dev/md2:
 HDIO_DRIVE_CMD(identify) failed: Inappropriate ioctl for device
  Timing buffered disk reads:   2 MB in  5.76 seconds = 355.42 kB/sec

I think things hang a bit less, which I suppose it good, but the system is
still unusable overall.

 
newmagic:~# modprobe bfq
newmagic:~# for i in /sys/block/*/queue/scheduler; do echo $i; echo bfq > $i; cat $i; done
/sys/block/bcache0/queue/scheduler
none
/sys/block/md0/queue/scheduler
none
/sys/block/md1/queue/scheduler
none
/sys/block/md2/queue/scheduler
none
/sys/block/md3/queue/scheduler
none                     
/sys/block/sda/queue/scheduler
[bfq] none
/sys/block/sdb/queue/scheduler
[bfq] none
/sys/block/sdc/queue/scheduler
[bfq] none
/sys/block/sdd/queue/scheduler
[bfq] none
/sys/block/sde/queue/scheduler
[bfq] none
/sys/block/sdf/queue/scheduler
[bfq] none
/sys/block/sdg/queue/scheduler
[bfq] none
/sys/block/sdh/queue/scheduler
[bfq] none
/sys/block/sdi/queue/scheduler
[bfq] none
/sys/block/sr0/queue/scheduler
[bfq] none


Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
