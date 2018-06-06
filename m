Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42024 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932394AbeFFIoE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Jun 2018 04:44:04 -0400
Date: Wed, 6 Jun 2018 10:44:02 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: bingjingc <bingjingc@synology.com>
Cc: linux-block@vger.kernel.org, cccheng@synology.com,
        linux-raid@vger.kernel.org
Subject: Re: [PATCH blktests 1/9] blktests: add hepler functions for new md
 tests
Message-ID: <20180606084402.vmx4qi42bmj5tmb4@linux-x5ow.site>
References: <1528272400-7128-1-git-send-email-bingjingc@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1528272400-7128-1-git-send-email-bingjingc@synology.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 06, 2018 at 04:06:40PM +0800, bingjingc wrote:
> We'd like to leverage this test framework for testing linux raid
> software. There are several resync tasks in md/raid. For this commit,
> we are trying to add creation resync and basic recovery tests for
> every raid type.
> 
> RAID is different from other block devices. It requires several
> raid devices and hotspare devices for being assembled, disambled,
> expended or recovered in the runtime. So we don't test devices
> iteratively in TEST_DEVS list. We define RAID_DEVS and
> RAID_SPARE_DEVS lists for providing block devices instead.
> 
> We want to test the software not devices. We also provide a
> LIMIT_DEV_SIZE option for limiting the tested array size by limiting
> used space for each block device.
> 
> [Getting Started]
> 
> Additional dependencies are also minimal:
> - mdadm
> - cmp
> 
> And please provide a file named config:
> RAID_DEVS=(/dev/loop0 /dev/loop1 /dev/loop2 /dev/loop3 /dev/loop4)
> RAID_SPARE_DEVS=(/dev/loop100 /dev/loop101)
> LIMIT_DEV_SIZE=20480 # optional
> 
> And as root, you can run the md set of tests by typing
> ./check md
> 
> For someone who don't want to run md tests, they just keep RAID_DEVS
> and RAID_SPARE_DEVS not assigned, all md tests will be skipped.

While I'm very much in support for the idea, please be aware that md
has an own test suite by itself and please Cc the md mailing list as
well.

Thanks,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
