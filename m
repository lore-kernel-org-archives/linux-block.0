Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE36C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 17:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355672087E
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 17:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="SYCnQaor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbfCYRc7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:32:59 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42059 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729473AbfCYRc7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 13:32:59 -0400
Received: by mail-pl1-f195.google.com with SMTP id cv12so276497plb.9
        for <linux-block@vger.kernel.org>; Mon, 25 Mar 2019 10:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cwv9bVCeyjnu5LVATt33xUYBz93/1PSCokvRgtAv0Uc=;
        b=SYCnQaorXLe+/jm5NpnB0CcwFD8brpaun/1X11SOCp61mFGXg2i0VPuFFPaSYy9WbJ
         rTscMzzP73eEIZFca+PaSJATpj7XYozkg/wMvED4wYWjJS1bEgQf+6FLvfw9o38O/iNi
         nrYCEWD64Yzb/B7gBFl1a9cKZcBg399taRgFzb7wvvu4twVRNlAigIG5nIMNYTHTZLTt
         jlqL7OT7Smkom9uzlDzR7TLLPd0o8wtC1pCgE2vldegrVdqymre08fV8Wdns5BbK/I1U
         baB481kZFp/JjVHFE0FVuu2ZWJBfz/pGJtV+5RiYuChNuPDLYYdYq1SlKiL+0k7pbxLo
         a0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cwv9bVCeyjnu5LVATt33xUYBz93/1PSCokvRgtAv0Uc=;
        b=hmtC8ada8Q7TDx0iitUWJgMOErKejGPkJ9FdDJyP6qDnecphfpIKljPNUPT6z1SorZ
         +3FoaWs5CyBCvWjd9YSqaXubekBAuIDWleuH9rQLL77kJ3GZE7eZpH7BpkZ/kuN6kyZ4
         Rz6ZLpv4W+Uw9tu5UYBa5aHVOYA9wQ2cBOrtdaYOa6o/2r06Uby3wcXUfMbTrObVlp+d
         +y8qA/pg55Hi6IdYvdYgQAm0S5tNi/ed2PCbXcPLOoXs941Sd+eMgXGGLARbhAZ1DIe6
         GGHP/D/7dhWrrN97XWlB/7j/9VIK/8RQmlJOeXkmq+MP8suVtbIv09fV1sc+3sjGhCb/
         nd5A==
X-Gm-Message-State: APjAAAWEvcBZRqUqyl9fHq1DBe1L7JVctFEIujqFYPqYFELb5Ov0/Uj6
        TM3UZ40MpHz2GcEAkujMn3ufrA==
X-Google-Smtp-Source: APXvYqzPuadUkWe+96o8GLoBTePhfRJROkb05JfpbpD/BhIRHs8TcVYMnswiXKeLqpJMFquBtWDObw==
X-Received: by 2002:a17:902:ba85:: with SMTP id k5mr8069586pls.270.1553535178162;
        Mon, 25 Mar 2019 10:32:58 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::3:b619])
        by smtp.gmail.com with ESMTPSA id 139sm20851858pfw.98.2019.03.25.10.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 10:32:57 -0700 (PDT)
Date:   Mon, 25 Mar 2019 10:32:56 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     linux-block@vger.kernel.org, osandov@fb.com, jack@suse.cz
Subject: Re: [PATCH blktests 2/2] loop/001: verify all partitions are removed
Message-ID: <20190325173256.GB5826@vader>
References: <1552563917-8388-1-git-send-email-dongli.zhang@oracle.com>
 <1552563917-8388-2-git-send-email-dongli.zhang@oracle.com>
 <20190314175533.GC11825@vader>
 <c55aa1f3-6b5f-3dab-6c74-247ba65b5bd0@oracle.com>
 <20190321232628.GE20838@vader>
 <d5a32d6f-b679-f960-8904-489556383537@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5a32d6f-b679-f960-8904-489556383537@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 22, 2019 at 10:23:01AM +0800, Dongli Zhang wrote:
> 
> 
> On 3/22/19 7:26 AM, Omar Sandoval wrote:
> > On Fri, Mar 15, 2019 at 10:00:27AM +0800, Dongli Zhang wrote:
> >>
> >>
> >> On 3/15/19 1:55 AM, Omar Sandoval wrote:
> >>> On Thu, Mar 14, 2019 at 07:45:17PM +0800, Dongli Zhang wrote:
> >>>> loop/001 does not test whether all partitions are removed successfully
> >>>> during loop device partition scanning. As a result, the regression
> >>>> introduced by 0da03cab87e6 ("loop: Fix deadlock when calling
> >>>> blkdev_reread_part()") can not be detected.
> >>>>
> >>>> The regression will generate below message in dmesg:
> >>>>
> >>>> [  464.414043] __loop_clr_fd: partition scan of loop0 failed (rc=-22)
> >>>>
> >>>> and leave orphan partitions like below:
> >>>>
> >>>> - /dev/loop0p1
> >>>> - /sys/block/loop0/loop0p1
> >>>>
> >>>> This patch verifies all partitions are removed by checking if there is
> >>>> /sys/block/loopX/loopXpY left. The expected number of partitions left is 0.
> >>>
> >>> Thanks for the test! A couple of comments below.
> >>>
> >>>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> >>>> ---
> >>>>  tests/loop/001     | 5 +++++
> >>>>  tests/loop/001.out | 1 +
> >>>>  2 files changed, 6 insertions(+)
> >>>>
> >>>> diff --git a/tests/loop/001 b/tests/loop/001
> >>>> index 47f760a..a0326b7 100755
> >>>> --- a/tests/loop/001
> >>>> +++ b/tests/loop/001
> >>>> @@ -4,6 +4,9 @@
> >>>>  #
> >>>>  # Test loop device partition scanning. Regression test for commit e02898b42380
> >>>>  # ("loop: fix LO_FLAGS_PARTSCAN hang").
> >>>> +#
> >>>> +# Test loop device paritition scanning. Regression test for commit 758a58d0bc67
> >>>> +# ("loop: set GENHD_FL_NO_PART_SCAN after blkdev_reread_part()").
> >>>
> >>> These can just be combined to
> >>>
> >>> # Test loop device partition scanning. Regression test for commits e02898b42380
> >>> # ("loop: fix LO_FLAGS_PARTSCAN hang") and 758a58d0bc67 ("loop: set
> >>> # GENHD_FL_NO_PART_SCAN after blkdev_reread_part()").
> >>>
> >>>>  . tests/loop/rc
> >>>>  
> >>>> @@ -24,9 +27,11 @@ test() {
> >>>>  		mkpart primary 50% 100%
> >>>>  
> >>>>  	loop_device="$(losetup -P -f --show "$TMPDIR/img")"
> >>>> +	loop_name=${loop_device:5}
> >>>>  	lsblk -ln "$loop_device" | wc -l
> >>>>  
> >>>>  	losetup -d "$loop_device"
> >>>> +	ls /sys/block/$loop_name | grep loop | wc -l
> >>>
> >>> We can just repeat the same `lsblk -ln "$loop_device" | wc -l` from
> >>> earlier, right? That's a bit cleaner than the hardcoded string slicing
> >>> and ls.
> >>
> >> Seems 'lsblk' does not work here.
> >>
> >> step1: truncate -s 100M /tmp/tmp.raw
> >> step2: parted /tmp/tmp.raw --script mklabel msdos \
> >>        mkpart primary 0% 50% mkpart primary 50% 100%
> >> step3: losetup -P -f --show /tmp/tmp.raw
> >>
> >> Now we are able to see two loop partitions from 'lsblk'
> >>
> >> # lsblk -ln /dev/loop0
> >> loop0     7:0    0  100M  0 loop
> >> loop0p1 259:0    0   50M  0 loop
> >> loop0p2 259:1    0   50M  0 loop
> >>
> >>
> >> step4: # losetup -d /dev/loop0
> >>
> >> There is below syslog as  partscan is failed.
> >>
> >> [  261.181049] __loop_clr_fd: partition scan of loop0 failed (rc=-22)
> >>
> >>
> >> There are 2 partitions left:
> >>
> >> # ls /dev | grep loop0
> >> loop0
> >> loop0p1
> >> loop0p2
> >>
> >> # ls /sys/block/loop0 | grep loop
> >> loop0p1
> >> loop0p2
> >>
> >>
> >> However, 'lsblk -ln' does not report the orphan paritions:
> >>
> >> # lsblk -ln
> >> sr0   11:0    1 1024M  0 rom
> >> sda    8:0    0   20G  0 disk
> >> sda2   8:2    0    1K  0 part
> >> sda5   8:5    0  4.1G  0 part [SWAP]
> >> sda1   8:1    0 15.9G  0 part /
> >>
> >>
> >> Therefore, we would not be able to use 'lsblk' here.
> > 
> > I see. I think we should check both lsblk and sysfs here. How about
> > something like
> > https://github.com/osandov/blktests/commit/6c1237cd358008024ece90bd915a67c23add8a2a?
> > 
> 
> It is good to me. Thank you very much for improve the patchset! I have tested it
> would pass with commit 758a58d0bc67 and not pass w/o 758a58d0bc67.
> 
> To check both lsblk and sysfs may test the loop much more thoroughly.

Thanks, applied.

> Just one programming question about loop_partition_sysfs():
> 
> +find_loop_partition_sysfs() {
> +	find "$sysfs/" -mindepth 1 -maxdepth 1 -name "$1"'p*' -printf '%f\n' |
> +		sed -n "s/^${1}p//p" | sort
> +}
> 
> Why not something like:
> 
> ls "$sysfs/" | grep $1 | sed -n "s/^${1}p//p" | sort
> 
> Is that because it is better to use 'find' than 'ls' in bash programming?

I usually prefer find because you can control the output more exactly.
ls probably would've been fine in this case.
