Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CC3C433E6
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 14:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93AE722EBF
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 14:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbhAZOt5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 09:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391327AbhAZJj1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 04:39:27 -0500
X-Greylist: delayed 402 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Jan 2021 01:38:47 PST
Received: from cc-smtpout1.netcologne.de (cc-smtpout1.netcologne.de [IPv6:2001:4dd0:100:1062:25:2:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08557C061573
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 01:38:46 -0800 (PST)
Received: from cc-smtpin1.netcologne.de (cc-smtpin1.netcologne.de [89.1.8.201])
        by cc-smtpout1.netcologne.de (Postfix) with ESMTP id DD3AA13A1F;
        Tue, 26 Jan 2021 10:31:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by cc-smtpin1.netcologne.de (Postfix) with ESMTP id CF7C111E75;
        Tue, 26 Jan 2021 10:31:13 +0100 (CET)
Received: from [89.1.203.165] (helo=cc-smtpin1.netcologne.de)
        by localhost with ESMTP (eXpurgate 4.19.0)
        (envelope-from <kurt@garloff.de>)
        id 600fe161-031e-7f0000012729-7f000001c664-1
        for <multiple-recipients>; Tue, 26 Jan 2021 10:31:13 +0100
Received: from nas2.garloff.de (xdsl-89-1-203-165.nc.de [89.1.203.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by cc-smtpin1.netcologne.de (Postfix) with ESMTPSA;
        Tue, 26 Jan 2021 10:31:08 +0100 (CET)
Received: from [192.168.155.24] (ap4.garloff.de [192.168.155.15])
        by nas2.garloff.de (Postfix) with ESMTPSA id F049FB3B13A5;
        Tue, 26 Jan 2021 10:31:07 +0100 (CET)
To:     Denis Efremov <efremov@linux.com>, Jiri Kosina <jikos@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Wim Osterholt <wim@djo.tudelft.nl>
References: <20160610230255.GA27770@djo.tudelft.nl>
 <alpine.LNX.2.00.1606131414420.6874@cbobk.fhfr.pm>
 <20160614184308.GA6188@djo.tudelft.nl>
 <alpine.LNX.2.00.1606150906320.6874@cbobk.fhfr.pm>
 <20160615132040.GZ14480@ZenIV.linux.org.uk>
 <alpine.LNX.2.00.1606151610420.6874@cbobk.fhfr.pm>
 <20160615224722.GA9545@djo.tudelft.nl>
 <alpine.LNX.2.00.1606160946000.6874@cbobk.fhfr.pm>
 <alpine.LNX.2.00.1606301317290.6874@cbobk.fhfr.pm>
 <9c713fa8-9da1-47b5-0d5d-92f4cd13493a@kernel.dk>
 <nycvar.YFH.7.76.2101191649190.5622@cbobk.fhfr.pm>
 <5cb57175-7f0b-5536-925d-337241bcda93@linux.com>
 <nycvar.YFH.7.76.2101211122290.5622@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2101211543230.5622@cbobk.fhfr.pm>
 <e503292b-5f51-eac5-771f-e35991d1084c@linux.com>
 <nycvar.YFH.7.76.2101211603590.5622@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2101221209060.5622@cbobk.fhfr.pm>
 <5ef748c9-9ab9-9a7e-6ae9-6e4a292b6842@linux.com>
From:   Kurt Garloff <kurt@garloff.de>
Subject: Re: [PATCH] floppy: reintroduce O_NDELAY fix
Message-ID: <f822ebde-89d6-dbbf-ae4e-b06a4aadedf5@garloff.de>
Date:   Tue, 26 Jan 2021 10:31:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <5ef748c9-9ab9-9a7e-6ae9-6e4a292b6842@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Denis, Jiri, Jens,

Am 26.01.21 um 09:21 schrieb Denis Efremov:
> On 1/22/21 2:13 PM, Jiri Kosina wrote:
>> From: Jiri Kosina <jkosina@suse.cz>
>>
>> This issue was originally fixed in 09954bad4 ("floppy: refactor open() 
>> flags handling").
>>
>> The fix as a side-effect, however, introduce issue for open(O_ACCMODE) 
>> that is being used for ioctl-only open. I wrote a fix for that, but 
>> instead of it being merged, full revert of 09954bad4 was performed, 
>> re-introducing the O_NDELAY / O_NONBLOCK issue, and it strikes again.
>>
>> This is a forward-port of the original fix to current codebase; the 
>> original submission had the changelog below:
>>
>> ====
>> Commit 09954bad4 ("floppy: refactor open() flags handling"), as a
>> side-effect, causes open(/dev/fdX, O_ACCMODE) to fail. It turns out that
>> this is being used setfdprm userspace for ioctl-only open().
>>
>> Reintroduce back the original behavior wrt !(FMODE_READ|FMODE_WRITE) 
>> modes, while still keeping the original O_NDELAY bug fixed.
>>
>> Cc: stable@vger.kernel.org
>> Reported-by: Wim Osterholt <wim@djo.tudelft.nl>
>> Tested-by: Wim Osterholt <wim@djo.tudelft.nl>
>> Reported-and-tested-by: Kurt Garloff <kurt@garloff.de>
>> Fixes: 09954bad4 ("floppy: refactor open() flags handling")
>> Fixes: f2791e7ead ("Revert "floppy: refactor open() flags handling"")
>> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> Applied. I'll send it to Jens soon with a couple of cleanup patches.
>
> https://github.com/evdenis/linux-floppy/commit/e32f6163c47efbdbad06258560aa00d1c7e5b699

Great, thanks.

Due to libblkid (rightfully) using O_NONBLOCK these days when probing
devices, the floppy driver does spit loads of
[    9.533513] floppy0: disk absent or changed during operation
[    9.534989] blk_update_request: I/O error, dev fd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[    9.537206] Buffer I/O error on dev fd0, logical block 0, async page read
[    9.546837] floppy0: disk absent or changed during operation
[    9.548389] blk_update_request: I/O error, dev fd0, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1
and fails a mount prior to being opened without O_NONBLOCK at least once.
(Reproduction is easy with qemu-kvm.)

The patch addresses it and I would suggest it to also be backported and
applied to the active stable kernel trees.

Thanks,

-- 
Kurt Garloff <kurt@garloff.de>, Cologne, Germany


