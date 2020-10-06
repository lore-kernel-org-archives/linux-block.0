Return-Path: <SRS0=/MU2=DN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068C5C4363D
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 23:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C12B32100A
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 23:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="lcHTIxtP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgJFX7j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Oct 2020 19:59:39 -0400
Received: from ale.deltatee.com ([204.191.154.188]:32836 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgJFX7i (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Oct 2020 19:59:38 -0400
X-Greylist: delayed 486 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Oct 2020 19:59:38 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JHj9CUDHulvt/1dca/0kn+WWXEkB7eaUTv3vf/yi1ks=; b=lcHTIxtPiDHBVgECn9AZ9Qt3Bo
        +IofrW10Um/Kg01wz9y25FjxYCE8gRn4GlMmNOo5wVVPdwXHMkFK8spdCeo88gqG0Xe82CXFHrPeM
        ix4Y/+aIrHEINluE1m28LkxabWg+T4QlSU4fo9g9GHMa7MdkZcE2xlVuwew0wniUVg3gEibPXBK1q
        jk9Oh4SN3Ghsuxrfhn7fCFb4THtoTkvUcIXzrw3Y296YAJl34KCVx1wWN7ThodL063S8nMpW/jsuR
        HP11CkGzipf3VxAkBNdosKYbdoPX8uHqanmmSEATaDCKS/bQCLtOLEqP9EEsqd9zdV4zmexir0Dym
        h5oZM4UA==;
Received: from [172.16.1.162]
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1kPwro-0006k3-2h; Tue, 06 Oct 2020 17:59:36 -0600
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Stephen Bates <sbates@raithlin.com>
References: <20200930185422.11494-1-logang@deltatee.com>
 <20200930185422.11494-4-logang@deltatee.com>
 <BYAPR04MB4965C2DDD4A5FBD86A128FE9860D0@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <868f8fb6-6024-d60d-a9aa-6513b9d0986f@deltatee.com>
Date:   Tue, 6 Oct 2020 17:59:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965C2DDD4A5FBD86A128FE9860D0@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, sagi@grimberg.me, osandov@osandov.com, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Chaitanya.Kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH blktests v2 03/11] common/xfs: Create common helper to
 verify block device with xfs
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020-10-06 5:50 p.m., Chaitanya Kulkarni wrote:
> On 9/30/20 11:54, Logan Gunthorpe wrote:
>> Make a common helper from the code in tests nvme/012 and nvme/013
>> to run an fio verify on a XFS file system backed by the
>> specified block device.
>>
>> While we are at it, all the output is redirected to $FULL instead of
>> /dev/null.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>  common/xfs     | 22 ++++++++++++++++++++++
>>  tests/nvme/012 | 14 +-------------
>>  tests/nvme/013 | 14 +-------------
>>  3 files changed, 24 insertions(+), 26 deletions(-)
> 
> The common namespace is getting cluttered. Can you please create
> 
> a subdirectory common/fs/xfs ?

I disagree. The common directory only has 9 files. And given there
appear to be no other files to add to the fs directory I don't think now
is the time to create a directory. We can do so if and when a number of
other fs helpers show up and there's a reason to group them together.

>>
>> diff --git a/common/xfs b/common/xfs
>> index d1a603b8c7b5..210c924cdd41 100644
>> --- a/common/xfs
>> +++ b/common/xfs
>> @@ -9,3 +9,25 @@
>>  _have_xfs() {
>>  	_have_fs xfs && _have_program mkfs.xfs
>>  }
>> +
>> +_xfs_mkfs_and_mount() {
>> +	local bdev=$1
>> +	local mount_dir=$2
>> +
>> +	mkdir -p "${mount_dir}"
>> +	umount "${mount_dir}"
>> +	mkfs.xfs -l size=32m -f "${bdev}"
>> +	mount "${bdev}" "${mount_dir}"
>> +}
>> +
>> +_xfs_run_fio_verify_io() {
>> +	local mount_dir="/mnt/blktests"
> 
> The mount dir should be a parameter and not the hardcode value
> to make it reusable.

I also disagree here. It is already reusable and is used in a number of
places; none of those places require changing the mount directory. If
and when a use comes up that requires a different directory (not sure
what that would be), a parameter can be added. It is typically standard
practice in the Linux community to not add features that have no users
as it's confusing to people reading the code.

Logan
