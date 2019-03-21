Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4394C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 23:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554C321902
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 23:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="wRmcP0mu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfCUX0d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:26:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32999 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfCUX0d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 19:26:33 -0400
Received: by mail-pg1-f193.google.com with SMTP id b12so141396pgk.0
        for <linux-block@vger.kernel.org>; Thu, 21 Mar 2019 16:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3w3S8k7k2fiZhhHnx96Ws5U31CKWrr6kN7uBb0rDT6I=;
        b=wRmcP0muItih9xRcRxvb9LF1UoZf4NUWV1aSJksqKHvqAWLRFhZfahOGI6rbL6tzoj
         tJ/IsfkxP2xhI1SRyczMTy981/w6pPHfobB0du94ksyzAo6YCRbi4ruEZ7qcsdgIjZHi
         +Edeb61D335T5QvSzOrfuNGeemN7qenvdXDSMqpdpSxWj07lt0/0ny7Vu6PuRpegMCOd
         gQPSXk3nCjTBbFA8M4MQrEfJKqv5qvtnxfX1ifQ70zd7z2nZdnZVTZmTYDHBLWMzbZxJ
         OAZEktPHsA6Y7/mfD2JdEjk2jlmI8fVxoyRUCOdjsSM+LWUUmDWlizFKtA/6oDFhl3XB
         xUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3w3S8k7k2fiZhhHnx96Ws5U31CKWrr6kN7uBb0rDT6I=;
        b=KmCGMgvPlM1rUTSOWrN+qDKhT5V/9GkEBE/gKvxSTE0y4EoeVqAYwQIr6fBQxTCA+6
         /cTVWWfOz09ISC2BUzyVB85QOowdnZbmOFW+AN8lUCZyRtmNrKSgscrXFYCtLFb8QcTX
         XYsPxNMWCc5sk3RacfdIaSy9eN79RKHZDe2LsXG+GlxCz8rilSNj95M+12euQuxwLPaQ
         WdcrtETfNMr2romY5A/fX5xYJ+JvuxmDfCOmgrRajnQMBzilSUUMWnwRI9qhdiMVVDO6
         ZkE9caghAmQpwPuX5GimTZI7JxuYNoVeA+vqFLsEEGrhgQPjhUsT7bMW+0yK9ORo57om
         lnnw==
X-Gm-Message-State: APjAAAWvAnUmhByI+b/gNClPi6mpMUPypTA9V7+bhMiz8lGCwKWdqubd
        ENJBPjJMg9Zoa/pt8v1hUHreFA==
X-Google-Smtp-Source: APXvYqwYhS5SKYLc42cAUvvkzGNKsFg7aEU5AQ8izjIrLx3LZgyRJzG/sr3P4pID6U7NyHTzkmYYhQ==
X-Received: by 2002:a65:49c4:: with SMTP id t4mr5857274pgs.421.1553210792137;
        Thu, 21 Mar 2019 16:26:32 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::2:1643])
        by smtp.gmail.com with ESMTPSA id 14sm8731196pft.137.2019.03.21.16.26.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 16:26:31 -0700 (PDT)
Date:   Thu, 21 Mar 2019 16:26:28 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     linux-block@vger.kernel.org, osandov@fb.com, jack@suse.cz
Subject: Re: [PATCH blktests 2/2] loop/001: verify all partitions are removed
Message-ID: <20190321232628.GE20838@vader>
References: <1552563917-8388-1-git-send-email-dongli.zhang@oracle.com>
 <1552563917-8388-2-git-send-email-dongli.zhang@oracle.com>
 <20190314175533.GC11825@vader>
 <c55aa1f3-6b5f-3dab-6c74-247ba65b5bd0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c55aa1f3-6b5f-3dab-6c74-247ba65b5bd0@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 15, 2019 at 10:00:27AM +0800, Dongli Zhang wrote:
> 
> 
> On 3/15/19 1:55 AM, Omar Sandoval wrote:
> > On Thu, Mar 14, 2019 at 07:45:17PM +0800, Dongli Zhang wrote:
> >> loop/001 does not test whether all partitions are removed successfully
> >> during loop device partition scanning. As a result, the regression
> >> introduced by 0da03cab87e6 ("loop: Fix deadlock when calling
> >> blkdev_reread_part()") can not be detected.
> >>
> >> The regression will generate below message in dmesg:
> >>
> >> [  464.414043] __loop_clr_fd: partition scan of loop0 failed (rc=-22)
> >>
> >> and leave orphan partitions like below:
> >>
> >> - /dev/loop0p1
> >> - /sys/block/loop0/loop0p1
> >>
> >> This patch verifies all partitions are removed by checking if there is
> >> /sys/block/loopX/loopXpY left. The expected number of partitions left is 0.
> > 
> > Thanks for the test! A couple of comments below.
> > 
> >> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> >> ---
> >>  tests/loop/001     | 5 +++++
> >>  tests/loop/001.out | 1 +
> >>  2 files changed, 6 insertions(+)
> >>
> >> diff --git a/tests/loop/001 b/tests/loop/001
> >> index 47f760a..a0326b7 100755
> >> --- a/tests/loop/001
> >> +++ b/tests/loop/001
> >> @@ -4,6 +4,9 @@
> >>  #
> >>  # Test loop device partition scanning. Regression test for commit e02898b42380
> >>  # ("loop: fix LO_FLAGS_PARTSCAN hang").
> >> +#
> >> +# Test loop device paritition scanning. Regression test for commit 758a58d0bc67
> >> +# ("loop: set GENHD_FL_NO_PART_SCAN after blkdev_reread_part()").
> > 
> > These can just be combined to
> > 
> > # Test loop device partition scanning. Regression test for commits e02898b42380
> > # ("loop: fix LO_FLAGS_PARTSCAN hang") and 758a58d0bc67 ("loop: set
> > # GENHD_FL_NO_PART_SCAN after blkdev_reread_part()").
> > 
> >>  . tests/loop/rc
> >>  
> >> @@ -24,9 +27,11 @@ test() {
> >>  		mkpart primary 50% 100%
> >>  
> >>  	loop_device="$(losetup -P -f --show "$TMPDIR/img")"
> >> +	loop_name=${loop_device:5}
> >>  	lsblk -ln "$loop_device" | wc -l
> >>  
> >>  	losetup -d "$loop_device"
> >> +	ls /sys/block/$loop_name | grep loop | wc -l
> > 
> > We can just repeat the same `lsblk -ln "$loop_device" | wc -l` from
> > earlier, right? That's a bit cleaner than the hardcoded string slicing
> > and ls.
> 
> Seems 'lsblk' does not work here.
> 
> step1: truncate -s 100M /tmp/tmp.raw
> step2: parted /tmp/tmp.raw --script mklabel msdos \
>        mkpart primary 0% 50% mkpart primary 50% 100%
> step3: losetup -P -f --show /tmp/tmp.raw
> 
> Now we are able to see two loop partitions from 'lsblk'
> 
> # lsblk -ln /dev/loop0
> loop0     7:0    0  100M  0 loop
> loop0p1 259:0    0   50M  0 loop
> loop0p2 259:1    0   50M  0 loop
> 
> 
> step4: # losetup -d /dev/loop0
> 
> There is below syslog as  partscan is failed.
> 
> [  261.181049] __loop_clr_fd: partition scan of loop0 failed (rc=-22)
> 
> 
> There are 2 partitions left:
> 
> # ls /dev | grep loop0
> loop0
> loop0p1
> loop0p2
> 
> # ls /sys/block/loop0 | grep loop
> loop0p1
> loop0p2
> 
> 
> However, 'lsblk -ln' does not report the orphan paritions:
> 
> # lsblk -ln
> sr0   11:0    1 1024M  0 rom
> sda    8:0    0   20G  0 disk
> sda2   8:2    0    1K  0 part
> sda5   8:5    0  4.1G  0 part [SWAP]
> sda1   8:1    0 15.9G  0 part /
> 
> 
> Therefore, we would not be able to use 'lsblk' here.

I see. I think we should check both lsblk and sysfs here. How about
something like
https://github.com/osandov/blktests/commit/6c1237cd358008024ece90bd915a67c23add8a2a?
