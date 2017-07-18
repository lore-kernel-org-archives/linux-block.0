Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54154 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751334AbdGRH5V (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jul 2017 03:57:21 -0400
Date: Tue, 18 Jul 2017 15:57:19 +0800
From: Eryu Guan <eguan@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [v4.12-rc6 regression] commit dc9edc44de6c introduced
 use-after-free
Message-ID: <20170718075719.GW2478@eguan.usersys.redhat.com>
References: <20170629113445.GS23360@eguan.usersys.redhat.com>
 <1499979851.2740.19.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499979851.2740.19.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jul 13, 2017 at 09:04:12PM +0000, Bart Van Assche wrote:
> On Thu, 2017-06-29 at 19:34 +0800, Eryu Guan wrote:
> > Hi all,
> > 
> > I got a use-after-free report from kasan-enabled kernel, when running
> > fstests xfs/279 (generic/108 could trigger too). I appended the console
> > log at the end of email.
> > 
> > git bisect pointed first bad commit to dc9edc44de6c ("block: Fix a
> > blk_exit_rl() regression"), and reverting that commit on top of
> > v4.12-rc7 kernel does resolve the use-after-free.
> > 
> > I can reproduce it by simply inserting & removing scsi_debug module.
> > 
> > modprobe scsi_debug
> > modprobe -r scsi_debug
> > 
> > If you need more info please let me know.
> > 
> > Thanks,
> > Eryu

<snip the console log>

> 
> Hello Eryu,
> 
> Thank you for your report. Can you repeat your test with a kernel that includes
> commit 8e6882545d8c ("scsi: Avoid that scsi_exit_rq() triggers a use-after-free")?

I tried 4.13-rc1 based kasan kernel, and I didn't see the use-after-free
again, thanks!

Eryu
