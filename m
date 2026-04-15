Received: from ext7.scm.com (ext7.scm.com [49.12.148.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB00B274B5F;
	Wed, 15 Apr 2026 12:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.148.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776256018; cv=none; b=CkwW5q8by4UHSBcOJ6HZaX0u5oFj0PVChCcer9myXt6RI6i+6XSgiJAB6BEn6ZqrB1JMZfH/ryHaBoOej1H8WsIMkiszJy0fzM75uLgHT7n2qdsjF4CzG7eCO0WBkuuiO9zQBCHbLlnGjt90WnxmKcJCJbUxgRsN4xi2ozG6UWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776256018; c=relaxed/simple;
	bh=K70PtLAFEdD5E6f3cPgyHsL9v7wSeWNvccEtt9eCxu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JCKVOa4mrYimSD6VgrZX/fLYFLCI6/zRookHISBQCxeVALMgPDoCx5+GNvRfbsoqnaIlTk2H5eg6E0UU6HUiai1UML+oAeL1OU85RyjOPWEYeyds15mo1ZFrO7Xn2Z0rYoPdog7ZoWb+YgaHEnb0uDKknbx9z4FzafBCr9wpNMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scm.com; spf=pass smtp.mailfrom=scm.com; dkim=pass (4096-bit key) header.d=scm.com header.i=@scm.com header.b=GkMLsYJR; arc=none smtp.client-ip=49.12.148.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=scm.com header.i=@scm.com header.b="GkMLsYJR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scm.com;
	s=ext7dkim24; t=1776255541;
	bh=Z+funUawOvx0kphI4JS6fSWSZisN2O3iu4tKcYlmH48=;
	h=From:To:Cc:Subject:Date:From;
	b=GkMLsYJR1nNfm951kYcihYfOdVuJqeNAhX/g/rFEnZLw+5rur2ApZIE5nlydoDCTD
	 hHg2CnsenDDPWiKrgPUYEQ0Mw6pXx5zPH8/xeo9WB2EnHWvWI2KzGj18DfqS4XSghU
	 0vAAxgnZ1AOyLkOx7tdGJUp3uWzPZAf/kIwLG+OnbitFa9Zhx9pL7jo5PX7b2Y0AR3
	 eXf5lOe1atppgNkNIeK6csMy4wx/jQmHdMSTGCaOz++2DfylkLgg5EfT1UchzJnGyT
	 E8gh8Da1imlJkd1zehopCIZCwkousWfeFk4eLdppIusODqlqoEjS6QElbxt8W1VJDR
	 XxPe9FxU+eFAmPIurlBuPbsNPeM8JzeKhnRBjF2ImOAUOMfpQ63HRI1UHMRyLzAB7W
	 eUGaQ2xzddjcRIJFXeLQtWVXsvfMqWK4sFxEPqPo1VDTRlI0o795B2uJQl19+f4Sqd
	 6/AowSnaoIIy7xS7n32yQzBLxWf/jUSSBn8/u+lvd1bCJ1LteYAj4yV7fC3YQN0oyO
	 ajCXAi/mQNAg/aoixcAzY+dTrE46YkhyiOcOBZdPhxKZBdkUpc3KKf3Pk0u8/zS0oF
	 wdpPWwxq4wQ6MsCqR7jyUJ5YdAuDLDPOUUpUiSJccocosbhocPkxUiN0W8LshTXZac
	 6QHul1B6bYZTK8YK8s6qL9xA=
X-Virus-Scanned: Debian amavisd-new at ext7.scm.com
From: =?UTF-8?B?VG9tw6HFoQ==?= Trnka <trnka@scm.com>
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Cc: regressions@lists.linux.dev, linux-block@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>
Subject:
 [REGRESSION][BISECTED] Spurious raid1 device failure triggered by qemu direct
 IO on 6.18+
Date: Wed, 15 Apr 2026 14:18:59 +0200
Message-ID: <2982107.4sosBPzcNG@electra>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Since 6.18, booting a VM that is backed by a raid1 LVM LV makes that LV=20
immediately eject one of the devices. This is apparently because of a direc=
t=20
IO read by QEMU failing. I have bisected the issue to the following commit =
and=20
confirmed that reverting that commit (plus dependencies=20
9eab1d4e0d15b633adc170c458c51e8be3b1c553 and=20
b475272f03ca5d0c437c8f899ff229b21010ec83) on top of 6.19.11 fixes the issue.

commit 5ff3f74e145adc79b49668adb8de276446acf6be
Author: Keith Busch <kbusch@kernel.org>
Date:   Wed Aug 27 07:12:54 2025 -0700

    block: simplify direct io validity check
   =20
    The block layer checks all the segments for validity later, so no need
    for an early check. Just reduce it to a simple position and total length
    check, and defer the more invasive segment checks to the block layer.
   =20
    Signed-off-by: Keith Busch <kbusch@kernel.org>
    Reviewed-by: Hannes Reinecke <hare@suse.de>
    Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
    Reviewed-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

The issue looks like this:

md/raid1:mdX: dm-17: rescheduling sector 0
md/raid1:mdX: redirecting sector 0 to other mirror: dm-17
(snipped 9 repeats of the preceding two lines)
md/raid1:mdX: dm-17: Raid device exceeded read_error threshold [cur 21:max =
20]
md/raid1:mdX: dm-17: Failing raid device
md/raid1:mdX: Disk failure on dm-17, disabling device.
md/raid1:mdX: Operation continuing on 1 devices.

There's absolutely nothing wrong with the HW, the issue persists even when =
I=20
move the mirrors to a different pair of PVs (SAS HDD vs SATA SSD).

The following command is enough to trigger the issue:

/usr/bin/qemu-system-x86_64 -blockdev '{"driver":"host_device","filename":"/
dev/vg_mintaka/lv_test","aio":"native","node-name":"libvirt-1-storage","rea=
d-
only":false,"discard":"unmap","cache":{"direct":true,"no-flush":false}}'

According to blktrace below, this seems to be an ordinary direct IO read of=
=20
sectors 0-7, but I can't reproduce the issue emulating such a read with dd.

The beginning of blktrace for dm-20 (mirror LV):

252,20   0        3     0.050436097 17815  Q  RS 0 + 8 [qemu-system-x86]
252,20   4        1     0.053590884 17179  C  RS 0 + 8 [65531]
252,20   9        1     0.071942534 17843  Q  RS 0 + 1 [worker]
252,20  10        1     0.077792770 10803  C  RS 0 + 1 [0]

for dm-17 (one of the legs of the raid1 mirror):

252,17   0        3     0.050441207 17815  Q  RS 0 + 8 [qemu-system-x86]
252,17   0        4     0.050465318 17815  C  RS 0 + 8 [65514]
252,17   4        1     0.050491948 17179  Q  RS 0 + 8 [mdX_raid1]
252,17  12        1     0.050695772 12662  C  RS 0 + 8 [0]

for sda1 that holds that leg (raid1 LV on dm-crypt on sda1; bfq messages=20
snipped):

  8,0    0        7     0.050453828 17815  A  RS 902334464 + 8 <- (252,5)=20
902301696
  8,0    0        8     0.050453988 17815  A  RS 902336512 + 8 <- (8,1)=20
902334464
  8,1    0        9     0.050454158 17815  Q  RS 902336512 + 8 [qemu-system-
x86]
  8,1    0       10     0.050455058 17815  C  RS 902336512 + 8 [65514]
  8,0    4        1     0.050490699 17179  A  RS 902334464 + 8 <- (252,5)=20
902301696
  8,0    4        2     0.050490849 17179  A  RS 902336512 + 8 <- (8,1)=20
902334464
  8,1    4        3     0.050491009 17179  Q  RS 902336512 + 8 [mdX_raid1]
  8,1    4        4     0.050498089 17179  G  RS 902336512 + 8 [mdX_raid1]
  8,1    4        5     0.050500129 17179  P   N [mdX_raid1]
  8,1    4        6     0.050500939 17179 UT   N [mdX_raid1] 1
  8,1    4        7     0.050507439 17179  I  RS 902336512 + 8 [mdX_raid1]
  8,1    4        8     0.050531999   387  D  RS 902336512 + 8 [kworker/4:1=
H]
  8,1   15        1     0.050668902     0  C  RS 902336512 + 8 [0]

for sdb1 (backing the other leg of the mirror):

  8,16   4        1     0.053558754 17179  A  RS 902334464 + 8 <- (252,4)=20
902301696
  8,16   4        2     0.053558884 17179  A  RS 902336512 + 8 <- (8,17)=20
902334464
  8,17   4        3     0.053559024 17179  Q  RS 902336512 + 8 [mdX_raid1]
  8,17   4        4     0.053559364 17179  C  RS 902336512 + 8 [65514]
  8,17   4        0     0.053570484 17179 1,0  m   N bfq [bfq_limit_depth]=
=20
wr_busy 0 sync 1 depth 48
  8,17   4        5     0.053578104   387  D  FN [kworker/4:1H]
  8,17  15        1     0.053647696 17192  C  FN 0 [0]
  8,17  15        2     0.053815039   567  D  FN [kworker/15:1H]
  8,17  15        3     0.053872560 17192  C  FN 0 [0]

=46ull logs can be downloaded from:
https://is.muni.cz/de/ttrnka/qemu-dio-raid1-fail/dmesg.log
https://is.muni.cz/de/ttrnka/qemu-dio-raid1-fail/mapped-devs.lst
https://is.muni.cz/de/ttrnka/qemu-dio-raid1-fail/blktrace.tar.gz

lsblk output (from a different boot, minors might not match mapped-devs.lst=
):

https://is.muni.cz/de/ttrnka/qemu-dio-raid1-fail/lsblk-t.out
https://is.muni.cz/de/ttrnka/qemu-dio-raid1-fail/lsblk.out

I can share any other info or logs, test patches, or poke around with ftrac=
e=20
or systemtap as needed.

#regzbot introduced: 5ff3f74e145adc79b49668adb8de276446acf6be

Best regards,

Tom=C3=A1=C5=A1
=2D-=20
Tom=C3=A1=C5=A1 Trnka
Software for Chemistry & Materials B.V.
De Boelelaan 1109
1081 HV Amsterdam, The Netherlands
https://www.scm.com



