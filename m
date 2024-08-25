Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD9029408
	for <linux-block@vger.kernel.org>; Sun, 25 Aug 2024 07:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724569929; cv=none; b=Wy+BVXQOCIol1aNul11drhD/TgyhvYJ7gUaF5GyiDaoY0QBOu+AYUA0Ga9KLkb0GtQsKMY+dc13Kmezwrm/jJfoq+QmD5in5cOnF10DEurt8W4g4FAax8vtO1Egaa4AwhlUi/qVeVh3KAAOn/zVakLUPMiahaTfi82WBT9ynw1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724569929; c=relaxed/simple;
	bh=UQ+pSrTwI+f9/fLRwaofXkYNi8zObLzhsh5e1npU0vk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=RQRckeO8y5LFGgAF7paRk4sE5/7T1ew3fkGdxQjStBkWwcCu/1DM2raQ9zznOo9hdB9Jf4BS6s4EKRje+1vJ7wL+Gq0i2LR32FyH41ABO/7hEbMqmO2WhSPy0xWvgMuaDKYut5YAYx00J13KYS9MaqVsU4wCtUWxNnE8izhKGCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=eMkTWgVE; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="eMkTWgVE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1724569919;
	bh=WPRjRA3ccqX/v2CyxXpeJv8LPSQsGqeqlW5QXQJWAI4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To;
	b=eMkTWgVEY77+P0FwAmzWTX647z7b3gLrJ6VzezOl8vM0A180Rk+LHIMBe/ZAAi+cn
	 TWtJ5+Wk70PzBiCxJUSjlY33vo0Hx/E8zYhs+lYjXVfw+drzArNEQsC0Du0lGJutEx
	 +dgPBQhLgnGuMO56H1lWDewoy/xYHvO9FoFz3ZaU=
X-QQ-mid: bizesmtpip2t1724569917tvr3mde
X-QQ-Originating-IP: Fjd+UnGuhz7iUpls2ocI9N+au7E2D96HxTBQ/FFpeP8=
Received: from [IPV6:2409:8a3c:5937:7b50:aeeb: ( [localhost])
	by bizesmtp.qq.com (ESMTP) with SMTP id 0
	for <linux-block@vger.kernel.org>; Sun, 25 Aug 2024 15:11:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16210401571042695670
Message-ID: <33EB068C1F9F98B4+1d4bc70a-a36d-4bf7-94ef-f2ec12166ac4@bupt.moe>
Date: Sun, 25 Aug 2024 15:11:55 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yuwei Han <hrx@bupt.moe>
Subject: Can't set RAID10 on zoned device using experimental build
To: linux-block@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi,
I am using btrfs-progs experimental build to create RAID10 volume on 
zoned device. But it didn't succeed.

Have consulted btrfs guys, he think it is related to block devices. So I 
forwarded to here.

# uname -a
Linux aosc3a6 6.11.0-rc4 #2 SMP PREEMPT_DYNAMIC Sun Aug 25 10:44:46 CST 
2024 loongarch64 GNU/Linux

# ./btrfs version
btrfs-progs v6.10.1
+EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED 
CRYPTO=builtin

# ./mkfs.btrfs -f -O bgt,rst -mraid10 -draid10 /dev/sda /dev/sdb 
/dev/sdc /dev/sdd
btrfs-progs v6.10.1
See https://btrfs.readthedocs.io for more information.

Zoned: /dev/sda: host-managed device detected, setting zoned feature
Resetting device zones /dev/sda (52156 zones) ...
Resetting device zones /dev/sdb (52156 zones) ...
Resetting device zones /dev/sdc (52156 zones) ...
Resetting device zones /dev/sdd (52156 zones) ...
ERROR: zoned: failed to reset device '/dev/sdd' zones: Remote I/O error
ERROR: zoned: failed to reset device '/dev/sdb' zones: Remote I/O error
ERROR: zoned: failed to reset device '/dev/sdc' zones: Remote I/O error
ERROR: zoned: failed to reset device '/dev/sda' zones: Remote I/O error
ERROR: unable prepare device: /dev/sda

related dmesg:
[ 479.729281] sd 0:0:2:0: [sdc] tag#953 FAILED Result: hostbyte=DID_OK 
driverbyte=DRIVER_OK cmd_age=0s
[  479.729930] sd 0:0:1:0: [sdb] tag#184 FAILED Result: hostbyte=DID_OK 
driverbyte=DRIVER_OK cmd_age=0s
[  479.729944] sd 0:0:3:0: [sdd] tag#12 FAILED Result: hostbyte=DID_OK 
driverbyte=DRIVER_OK cmd_age=0s
[  479.729949] sd 0:0:3:0: [sdd] tag#12 Sense Key : Illegal Request 
[current]
[  479.729951] sd 0:0:3:0: [sdd] tag#12 Add. Sense: Invalid field in cdb
[  479.729954] sd 0:0:3:0: [sdd] tag#12 CDB: Write same(16) 93 08 00 00 
00 00 00 00 00 00 00 01 00 00 00 00
[  479.729956] critical target error, dev sdd, sector 0 op 0x3:(DISCARD) 
flags 0x800 phys_seg 1 prio class 0
[  479.729960] sd 0:0:0:0: [sda] tag#597 FAILED Result: hostbyte=DID_OK 
driverbyte=DRIVER_OK cmd_age=0s
[  479.729963] sd 0:0:0:0: [sda] tag#597 Sense Key : Illegal Request 
[current]
[  479.729966] sd 0:0:0:0: [sda] tag#597 Add. Sense: Invalid field in cdb
[  479.729968] sd 0:0:0:0: [sda] tag#597 CDB: Write same(16) 93 08 00 00 
00 00 00 00 00 00 00 01 00 00 00 00
[  479.729970] critical target error, dev sda, sector 0 op 0x3:(DISCARD) 
flags 0x800 phys_seg 1 prio class 0
[  479.738363] sd 0:0:2:0: [sdc] tag#953 Sense Key : Illegal Request 
[current]
[  479.747438] sd 0:0:1:0: [sdb] tag#184 Sense Key : Illegal Request 
[current]
[  479.756425] sd 0:0:2:0: [sdc] tag#953 Add. Sense: Invalid field in cdb
[  479.763338] sd 0:0:1:0: [sdb] tag#184 Add. Sense: Invalid field in cdb
[  479.769733] sd 0:0:2:0: [sdc] tag#953 CDB: Write same(16) 93 08 00 00 
00 00 00 00 00 00 00 01 00 00 00 00
[  479.779152] sd 0:0:1:0: [sdb] tag#184 CDB: Write same(16) 93 08 00 00 
00 00 00 00 00 00 00 01 00 00 00 00
[  479.788656] critical target error, dev sdc, sector 0 op 0x3:(DISCARD) 
flags 0x800 phys_seg 1 prio class 0
[  479.797730] critical target error, dev sdb, sector 0 op 0x3:(DISCARD) 
flags 0x800 phys_seg 1 prio class 0

drive info: WDC HC620 (HSH721414ALN6M0)



