Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch [109.224.244.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1901E1B4241
	for <linux-block@vger.kernel.org>; Fri, 23 May 2025 19:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748029326; cv=none; b=RQMlyHSOsrZLGd5fiIddGJrk7yM1VWD5/B3sRWYjKg+almADtYNcIq4bzuYe5MZlV0kA6G3X5WR9rkMDLXlzq7D3d7HWfsc0M1Qq0jnnp4HkdcrPxoO4Rav55p2ktHGailTwn5+ZbgEOttD3T9mZXzV8p+I/jlaGAUsY+XV2J9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748029326; c=relaxed/simple;
	bh=Lk5RzQlYnNlU7iU3G807KFcWyUlzrKz/G2vXUprsI/c=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=eDYENp6YmoBjoyU1N5vJ3OFxvVv6wR8fG62YSViJb9i3sX0+I71serA2oRRVe3iPBRV/0Dn7xLl4HZkro6u1uJnEcwyTKxMbplPBnfneA/n8YvBNoxPuJdGG6uEGZLWd9sXyv+PI5f2UV6wCa+zXIEKuqvluWW7eRORj82fE3Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=michaelmarod.com; spf=pass smtp.mailfrom=michaelmarod.com; dkim=pass (1024-bit key) header.d=michaelmarod.com header.i=@michaelmarod.com header.b=WjbkI+dX; arc=none smtp.client-ip=109.224.244.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=michaelmarod.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michaelmarod.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=michaelmarod.com header.i=@michaelmarod.com header.b="WjbkI+dX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michaelmarod.com;
	s=protonmail; t=1748029316; x=1748288516;
	bh=TVXc6KoETFI/fSm/yJFgfcH2Y2Nh5rI4W7Pf4i9F7tE=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=WjbkI+dX8cr4u64eHAbJPeDFOFyLF2pdqW7JI0eHqSGI8L6ux6BR+lUfmpMnpKw0Q
	 lkh9w+j4bSTYUmWXbepT095UPLHhRPGUwI+WZhF1HJbG5es99Y8VkjElhfOAWO7t/F
	 NogwoLFX6KoWPgo1hSZf1q/i9xP7ek2OW+scV0rU=
Date: Fri, 23 May 2025 19:41:53 +0000
To: linux-block@vger.kernel.org
From: Michael Marod <michael@michaelmarod.com>
Subject: Processes stuck in uninterruptible sleep waiting on inflight IOs to return
Message-ID: <2DFEFE31-EAF3-4D72-A09E-B7AB4D9D7D79@michaelmarod.com>
Feedback-ID: 10378778:user:proton
X-Pm-Message-ID: 7f16b9695be7d375b69c3c47b3f05a7171e5ca0f
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Processes are occasionally stuck in uninterruptible sleep (D state) across =
a i3, i3en, and im4gn AWS EC2 instances under heavy IO load, forcing a rebo=
ot to fix. This has been observed on at least the 5.15.0-1083-aws and 6.8.0=
-1028-aws kernels. The local NVMe drives that come with the instances are i=
n a RAID0 software raid using mdadm. AWS support says there is no issue wit=
h the underlying infrastructure and so I suspect there is a problem in the =
block layer of the kernel losing track of the IO response somehow and wedgi=
ng the system. There was a recent CVE which sounded like it might be the pr=
oblem but it turned out not to be it as the impacted instance=E2=80=99s ker=
nel versions are "fixed" (https://ubuntu.com/security/CVE-2024-50082). If t=
here is any more information I can provide other than what is included belo=
w that would provide some clarity on the situation please let me know.

The call traces on the stuck processes which have blk_* calls in them alway=
s include wbt_wait and look like this:

[163867.923558]  __schedule+0x2cd/0x890
[163867.923559]  ? blk_flush_plug_list+0xe3/0x110
[163867.923562]  schedule+0x69/0x110
[163867.923563]  io_schedule+0x16/0x40
[163867.923565]  ? wbt_cleanup_cb+0x20/0x20
[163867.923568]  rq_qos_wait+0xd0/0x170
[163867.923570]  ? __wbt_done+0x40/0x40
[163867.923571]  ? sysv68_partition+0x280/0x280
[163867.923572]  ? wbt_cleanup_cb+0x20/0x20
[163867.923574]  wbt_wait+0x96/0xc0
[163867.923576]  __rq_qos_throttle+0x28/0x40
[163867.923577]  blk_mq_submit_bio+0xfb/0x600

Or this:

[111397.863857]  __schedule+0x27c/0x680
[111397.863862]  ? __pfx_wbt_inflight_cb+0x10/0x10
[111397.863864]  schedule+0x2c/0xf0
[111397.863867]  io_schedule+0x46/0x80
[111397.863869]  rq_qos_wait+0xc1/0x160
[111397.863872]  ? __pfx_wbt_cleanup_cb+0x10/0x10
[111397.863873]  ? __pfx_rq_qos_wake_function+0x10/0x10
[111397.863876]  ? __pfx_wbt_inflight_cb+0x10/0x10
[111397.863880]  wbt_wait+0xb3/0x100
[111397.863883]  __rq_qos_throttle+0x28/0x40
[111397.863885]  blk_mq_submit_bio+0x151/0x740

The nvme smart-log and error-log have nothing interesting on any of the dri=
ves and the mdadm status all looks fine. Nothing interesting in dmesg other=
 than the traces from the D state processes. None of the CPUs are doing wor=
k but the load avg is high because of CPU IO wait. Additionally iostat show=
s no activity.

There are a handful of IOs that are inflight and never return in each case.

# cat /sys/block/nvme3n1/inflight
       2       10

Snapshot of /proc/diskstats taken twice to show the stuck IOs in column 12 =
(IOs currently in progress)

# cat /proc/diskstats (non-nvme/md volumes redacted)
 259       0 nvme1n1 105729 10821 4012670 22218 17309 13374 623448 1836 5 3=
8184 24054 0 0 0 0 0 0
 259       2 nvme2n1 104012 12803 4017102 163554751 17263 13207 610776 1635=
22410 4 163004500 327077161 0 0 0 0 0 0
 259       1 nvme3n1 102827 7381 3877790 20710 16198 13096 577168 2373 12 3=
7892 23084 0 0 0 0 0 0
 259       3 nvme0n1 135418 55608 6630967 31629 33645 23603 834048 3958 0 3=
8220 35587 0 0 0 0 0 0
   9     127 md127 534397 0 18536329 461386 147709 0 2645600 957536 22 4743=
6 1418923 0 0 0 0 0 0

# cat /proc/diskstats
 259       0 nvme1n1 105729 10821 4012670 22218 17309 13374 623448 1836 5 3=
8184 24054 0 0 0 0 0 0
 259       2 nvme2n1 104012 12803 4017102 163554751 17263 13207 610776 1635=
22410 4 163004500 327077161 0 0 0 0 0 0
 259       1 nvme3n1 102828 7381 3877790 20710 16198 13096 577168 2373 12 3=
7896 23084 0 0 0 0 0 0
 259       3 nvme0n1 135428 55608 6631044 31630 33645 23603 834048 3958 0 3=
8232 35588 0 0 0 0 0 0
   9     127 md127 534406 0 18536398 461390 147709 0 2645600 957536 22 4744=
4 1418927 0 0 0 0 0 0

# cat /proc/meminfo shows that there is 5GB or so of dirty pages that are s=
tuck and 270MB or so that are stuck in writeback. The write back number doe=
sn=E2=80=99t move over time whereas the dirty pages fluctuates slightly (pr=
obably because of activity on the root volume)

MemTotal:       251504596 kB
MemFree:        224189644 kB
MemAvailable:   242048200 kB
Buffers:         1627368 kB
Cached:         16798708 kB
SwapCached:            0 kB
Active:          4911976 kB
Inactive:       19563000 kB
Active(anon):       2872 kB
Inactive(anon):  6055720 kB
Active(file):    4909104 kB
Inactive(file): 13507280 kB
Unevictable:       29328 kB
Mlocked:           19952 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:           5008372 kB
Writeback:        277224 kB
AnonPages:       6078340 kB
Mapped:           741700 kB
Shmem:              1192 kB
KReclaimable:    1640636 kB
Slab:            1964256 kB
SReclaimable:    1640636 kB
SUnreclaim:       323620 kB
KernelStack:       30768 kB
PageTables:        63536 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    125752296 kB
Committed_AS:    8918348 kB
VmallocTotal:   34359738367 kB
VmallocUsed:       74008 kB
VmallocChunk:          0 kB
Percpu:           152064 kB
HardwareCorrupted:     0 kB
AnonHugePages:         0 kB
ShmemHugePages:        0 kB
ShmemPmdMapped:        0 kB
FileHugePages:         0 kB
FilePmdMapped:         0 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
Hugetlb:               0 kB
DirectMap4k:      415744 kB
DirectMap2M:    20555776 kB
DirectMap1G:    236978176 kB

I also traced wbt-timer which resulted in this being repeated with the late=
ncy number ever increasing:

    <redacted>    [005] ..s.. 166350.485548: wbt_lat: 259:1: latency 314423=
1651us
   <redacted>    [005] ..s.. 166350.485549: wbt_timer: 259:1: status=3D4, s=
tep=3D4, inflight=3D10
          <idle>-0       [016] ..s.. 166350.493550: wbt_lat: 259:0: latency=
 166251680941us
          <idle>-0       [016] ..s.. 166350.493551: wbt_timer: 259:0: statu=
s=3D4, step=3D4, inflight=3D3
          <idle>-0       [021] ..s.. 166350.529555: wbt_lat: 259:2: latency=
 166255836643us
          <idle>-0       [021] ..s.. 166350.529557: wbt_timer: 259:2: statu=
s=3D4, step=3D4, inflight=3D0

There is no block activity on the nvme drives or the md device.

Appreciate any help,

Michael Marod
michael@michaelmarod.com
