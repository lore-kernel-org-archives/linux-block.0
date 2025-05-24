Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143DD13B293
	for <linux-block@vger.kernel.org>; Sat, 24 May 2025 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748099226; cv=none; b=T2++7hHxzcIdlRdKWEWJgJnn6aiZ60qstrbzoHuWsedwR4ZGVMvSQWTZiW7YnbatAdLHCYWIsnKwEro4MeFGllaFfsXBoI8XIiYH6jiznpsr4Y3/Kl/AnS6MwYesfeS+JXW/+6VDE85SgwfubdxBF2wfDJ8lW9o9/0IDeCDR4v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748099226; c=relaxed/simple;
	bh=rkf32/fujlUyhIksQGiE90awC0SJrGJ+MliOdlyFUqY=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gXWpisiE4lLShJ2tyBXfaCLzejqeL+zqrRot+KZEl28wZltZIq4YWOcVmd2pkcLYmpaGAPc7YOj6MdGA1Tdw4yiQ5sQ5l10IPyCYQi9ztG779LUiihYXiSozaM5NpI8903bnITm9Xxf0ePHffB7DnyjBRptkxll9vINeLZ1moyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=michaelmarod.com; spf=pass smtp.mailfrom=michaelmarod.com; dkim=pass (1024-bit key) header.d=michaelmarod.com header.i=@michaelmarod.com header.b=k2GbUWt2; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=michaelmarod.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michaelmarod.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=michaelmarod.com header.i=@michaelmarod.com header.b="k2GbUWt2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michaelmarod.com;
	s=protonmail; t=1748099214; x=1748358414;
	bh=a4739BmBm5c7bkshba12zcDixTZ/irVOFs9jUdDcyeM=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=k2GbUWt2zkmtYMFgS/nH0TfHu3tEdO4tTbhAOEKqnLQYBvrSgmIGbWtI7OnBjBmhZ
	 eaF+X9yHcThenhZmHRMWaqQR/wetPJ0adFm6HCfgeGC1XD/vkYyhGG5o2KCFMz1gf1
	 Rv5szNonlqmVsGd1FaEkX8nVCXN+BNUzu12OyVvA=
Date: Sat, 24 May 2025 15:06:51 +0000
To: linux-block@vger.kernel.org
From: Michael Marod <michael@michaelmarod.com>
Subject: Re: Processes stuck in uninterruptible sleep waiting on inflight IOs to return
Message-ID: <6FB7CF73-1AEC-4F58-A9FF-25D0D0FC8A2F@michaelmarod.com>
In-Reply-To: <2DFEFE31-EAF3-4D72-A09E-B7AB4D9D7D79@michaelmarod.com>
References: <2DFEFE31-EAF3-4D72-A09E-B7AB4D9D7D79@michaelmarod.com>
Feedback-ID: 10378778:user:proton
X-Pm-Message-ID: 5dc23bb623c73d47ef6c04ace993757ceb22f809
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Adding a bit more information that I was able to gather...

I can see the stuck IOs with a command like this:

/sys/kernel/debug/block/nvme3n1 # grep -r -H '' hctx*/busy
hctx15/busy:00000000af51db9e {.op=3DWRITE, .cmd_flags=3D, .rq_flags=3DDONTP=
REP|IO_STAT|STATS, .state=3Din_flight, .tag=3D48, .internal_tag=3D-1}
hctx15/busy:00000000f093c7cd {.op=3DWRITE, .cmd_flags=3D, .rq_flags=3DDONTP=
REP|IO_STAT|STATS, .state=3Din_flight, .tag=3D49, .internal_tag=3D-1}
hctx15/busy:0000000041dbfd62 {.op=3DWRITE, .cmd_flags=3D, .rq_flags=3DDONTP=
REP|IO_STAT|STATS, .state=3Din_flight, .tag=3D50, .internal_tag=3D-1}
hctx15/busy:000000006c17c30a {.op=3DWRITE, .cmd_flags=3D, .rq_flags=3DDONTP=
REP|IO_STAT|STATS, .state=3Din_flight, .tag=3D51, .internal_tag=3D-1}
hctx15/busy:00000000513ed28d {.op=3DWRITE, .cmd_flags=3D, .rq_flags=3DDONTP=
REP|IO_STAT|STATS, .state=3Din_flight, .tag=3D52, .internal_tag=3D-1}
hctx15/busy:000000007ecbcdb5 {.op=3DWRITE, .cmd_flags=3D, .rq_flags=3DDONTP=
REP|IO_STAT|STATS, .state=3Din_flight, .tag=3D53, .internal_tag=3D-1}
hctx15/busy:000000003a913635 {.op=3DREAD, .cmd_flags=3DFAILFAST_DEV|FAILFAS=
T_TRANSPORT|FAILFAST_DRIVER|RAHEAD, .rq_flags=3DDONTPREP|IO_STAT|STATS, .st=
ate=3Din_flight, .tag=3D54, .internal_tag=3D-1}
hctx15/busy:0000000058a5d635 {.op=3DREAD, .cmd_flags=3DMETA|PRIO, .rq_flags=
=3DDONTPREP|IO_STAT|STATS, .state=3Din_flight, .tag=3D55, .internal_tag=3D-=
1}
hctx15/busy:00000000df5d930c {.op=3DWRITE, .cmd_flags=3D, .rq_flags=3DDONTP=
REP|IO_STAT|STATS, .state=3Din_flight, .tag=3D59, .internal_tag=3D-1}
hctx15/busy:0000000075eb3af1 {.op=3DWRITE, .cmd_flags=3D, .rq_flags=3DDONTP=
REP|IO_STAT|STATS, .state=3Din_flight, .tag=3D60, .internal_tag=3D-1}
hctx15/busy:000000007850db7b {.op=3DWRITE, .cmd_flags=3D, .rq_flags=3DDONTP=
REP|IO_STAT|STATS, .state=3Din_flight, .tag=3D61, .internal_tag=3D-1}
hctx15/busy:00000000f483a9f9 {.op=3DWRITE, .cmd_flags=3D, .rq_flags=3DDONTP=
REP|IO_STAT|STATS, .state=3Din_flight, .tag=3D62, .internal_tag=3D-1}

And also can see the counters on the CPU with 2 incomplete reads and 10 inc=
omplete writes.

/sys/kernel/debug/block/nvme3n1/hctx15/cpu15 # grep -H '' *
completed:1788 47
dispatched:1790 57
merged:0

Additionally, I was able to actually unblock this instance by issuing an "n=
vme reset /dev/nvme3=E2=80=9D. This also unwedged the nvme1 and nvme2 and m=
d127 devices that were stuck. I=E2=80=99m not sure if this means that the u=
nderlying device never finished the IO or if resetting the controller trigg=
ered some logic in the kernel which enabled it to unjam itself. When I issu=
ed the reset, there were no additional messages in dmesg or other logs on t=
he system indicating anything interesting.

When I run into another stuck instance I think I will turn on some kernel t=
racing to see if anything reveals itself.

=E2=80=94 Michael


> On May 23, 2025, at 3:41 PM, Michael Marod <michael@michaelmarod.com> wro=
te:
>=20
> Processes are occasionally stuck in uninterruptible sleep (D state) acros=
s a i3, i3en, and im4gn AWS EC2 instances under heavy IO load, forcing a re=
boot to fix. This has been observed on at least the 5.15.0-1083-aws and 6.8=
.0-1028-aws kernels. The local NVMe drives that come with the instances are=
 in a RAID0 software raid using mdadm. AWS support says there is no issue w=
ith the underlying infrastructure and so I suspect there is a problem in th=
e block layer of the kernel losing track of the IO response somehow and wed=
ging the system. There was a recent CVE which sounded like it might be the =
problem but it turned out not to be it as the impacted instance=E2=80=99s k=
ernel versions are "fixed" (https://ubuntu.com/security/CVE-2024-50082). If=
 there is any more information I can provide other than what is included be=
low that would provide some clarity on the situation please let me know.
>=20
> The call traces on the stuck processes which have blk_* calls in them alw=
ays include wbt_wait and look like this:
>=20
> [163867.923558]  __schedule+0x2cd/0x890
> [163867.923559]  ? blk_flush_plug_list+0xe3/0x110
> [163867.923562]  schedule+0x69/0x110
> [163867.923563]  io_schedule+0x16/0x40
> [163867.923565]  ? wbt_cleanup_cb+0x20/0x20
> [163867.923568]  rq_qos_wait+0xd0/0x170
> [163867.923570]  ? __wbt_done+0x40/0x40
> [163867.923571]  ? sysv68_partition+0x280/0x280
> [163867.923572]  ? wbt_cleanup_cb+0x20/0x20
> [163867.923574]  wbt_wait+0x96/0xc0
> [163867.923576]  __rq_qos_throttle+0x28/0x40
> [163867.923577]  blk_mq_submit_bio+0xfb/0x600
>=20
> Or this:
>=20
> [111397.863857]  __schedule+0x27c/0x680
> [111397.863862]  ? __pfx_wbt_inflight_cb+0x10/0x10
> [111397.863864]  schedule+0x2c/0xf0
> [111397.863867]  io_schedule+0x46/0x80
> [111397.863869]  rq_qos_wait+0xc1/0x160
> [111397.863872]  ? __pfx_wbt_cleanup_cb+0x10/0x10
> [111397.863873]  ? __pfx_rq_qos_wake_function+0x10/0x10
> [111397.863876]  ? __pfx_wbt_inflight_cb+0x10/0x10
> [111397.863880]  wbt_wait+0xb3/0x100
> [111397.863883]  __rq_qos_throttle+0x28/0x40
> [111397.863885]  blk_mq_submit_bio+0x151/0x740
>=20
> The nvme smart-log and error-log have nothing interesting on any of the d=
rives and the mdadm status all looks fine. Nothing interesting in dmesg oth=
er than the traces from the D state processes. None of the CPUs are doing w=
ork but the load avg is high because of CPU IO wait. Additionally iostat sh=
ows no activity.
>=20
> There are a handful of IOs that are inflight and never return in each cas=
e.
>=20
> # cat /sys/block/nvme3n1/inflight
>       2       10
>=20
> Snapshot of /proc/diskstats taken twice to show the stuck IOs in column 1=
2 (IOs currently in progress)
>=20
> # cat /proc/diskstats (non-nvme/md volumes redacted)
> 259       0 nvme1n1 105729 10821 4012670 22218 17309 13374 623448 1836 5 =
38184 24054 0 0 0 0 0 0
> 259       2 nvme2n1 104012 12803 4017102 163554751 17263 13207 610776 163=
522410 4 163004500 327077161 0 0 0 0 0 0
> 259       1 nvme3n1 102827 7381 3877790 20710 16198 13096 577168 2373 12 =
37892 23084 0 0 0 0 0 0
> 259       3 nvme0n1 135418 55608 6630967 31629 33645 23603 834048 3958 0 =
38220 35587 0 0 0 0 0 0
>   9     127 md127 534397 0 18536329 461386 147709 0 2645600 957536 22 474=
36 1418923 0 0 0 0 0 0
>=20
> # cat /proc/diskstats
> 259       0 nvme1n1 105729 10821 4012670 22218 17309 13374 623448 1836 5 =
38184 24054 0 0 0 0 0 0
> 259       2 nvme2n1 104012 12803 4017102 163554751 17263 13207 610776 163=
522410 4 163004500 327077161 0 0 0 0 0 0
> 259       1 nvme3n1 102828 7381 3877790 20710 16198 13096 577168 2373 12 =
37896 23084 0 0 0 0 0 0
> 259       3 nvme0n1 135428 55608 6631044 31630 33645 23603 834048 3958 0 =
38232 35588 0 0 0 0 0 0
>   9     127 md127 534406 0 18536398 461390 147709 0 2645600 957536 22 474=
44 1418927 0 0 0 0 0 0
>=20
> # cat /proc/meminfo shows that there is 5GB or so of dirty pages that are=
 stuck and 270MB or so that are stuck in writeback. The write back number d=
oesn=E2=80=99t move over time whereas the dirty pages fluctuates slightly (=
probably because of activity on the root volume)
>=20
> MemTotal:       251504596 kB
> MemFree:        224189644 kB
> MemAvailable:   242048200 kB
> Buffers:         1627368 kB
> Cached:         16798708 kB
> SwapCached:            0 kB
> Active:          4911976 kB
> Inactive:       19563000 kB
> Active(anon):       2872 kB
> Inactive(anon):  6055720 kB
> Active(file):    4909104 kB
> Inactive(file): 13507280 kB
> Unevictable:       29328 kB
> Mlocked:           19952 kB
> SwapTotal:             0 kB
> SwapFree:              0 kB
> Dirty:           5008372 kB
> Writeback:        277224 kB
> AnonPages:       6078340 kB
> Mapped:           741700 kB
> Shmem:              1192 kB
> KReclaimable:    1640636 kB
> Slab:            1964256 kB
> SReclaimable:    1640636 kB
> SUnreclaim:       323620 kB
> KernelStack:       30768 kB
> PageTables:        63536 kB
> NFS_Unstable:          0 kB
> Bounce:                0 kB
> WritebackTmp:          0 kB
> CommitLimit:    125752296 kB
> Committed_AS:    8918348 kB
> VmallocTotal:   34359738367 kB
> VmallocUsed:       74008 kB
> VmallocChunk:          0 kB
> Percpu:           152064 kB
> HardwareCorrupted:     0 kB
> AnonHugePages:         0 kB
> ShmemHugePages:        0 kB
> ShmemPmdMapped:        0 kB
> FileHugePages:         0 kB
> FilePmdMapped:         0 kB
> HugePages_Total:       0
> HugePages_Free:        0
> HugePages_Rsvd:        0
> HugePages_Surp:        0
> Hugepagesize:       2048 kB
> Hugetlb:               0 kB
> DirectMap4k:      415744 kB
> DirectMap2M:    20555776 kB
> DirectMap1G:    236978176 kB
>=20
> I also traced wbt-timer which resulted in this being repeated with the la=
tency number ever increasing:
>=20
>    <redacted>    [005] ..s.. 166350.485548: wbt_lat: 259:1: latency 31442=
31651us
>   <redacted>    [005] ..s.. 166350.485549: wbt_timer: 259:1: status=3D4, =
step=3D4, inflight=3D10
>          <idle>-0       [016] ..s.. 166350.493550: wbt_lat: 259:0: latenc=
y 166251680941us
>          <idle>-0       [016] ..s.. 166350.493551: wbt_timer: 259:0: stat=
us=3D4, step=3D4, inflight=3D3
>          <idle>-0       [021] ..s.. 166350.529555: wbt_lat: 259:2: latenc=
y 166255836643us
>          <idle>-0       [021] ..s.. 166350.529557: wbt_timer: 259:2: stat=
us=3D4, step=3D4, inflight=3D0
>=20
> There is no block activity on the nvme drives or the md device.
>=20
> Appreciate any help,
>=20
> Michael Marod
> michael@michaelmarod.com


