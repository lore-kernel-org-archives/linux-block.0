Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1C1332602
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 18:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772132229; cv=none; b=TU0Tct5bPiI3RjBBs+AAFProxbdpQI1A2OAxjSKp9kf4Vma7yEhR0iIZv+mR7rxGhMrwB1rwfAchi7MDNEYnl7pHQoKjAM6cil4hJJeETSUV+acudFgk+CRyZUcOhmUyZ59S2HeNeuuhr26zf83/OxHDV2CmwmE615dGE7JiNP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772132229; c=relaxed/simple;
	bh=PnxEIgfsXeStlrThxLfxoDBf2IdKb0WXD9cn82B/HT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KKua0hH/4FH1o0EkbSHPbjvnKs//lRNkGVyL+8Db0oqEfuZUz9RpVyFgrfBmm5rPpb3wEysyZvwREBMiyOtJKnKYZQZxyyDmSGw51eN5PaPK0ZeOk1hH5X5rFugEoFrBcF3VsYQ0d1r4h6Ko0HHC2m/7c0o4AzUyM6Vpgg0fuLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOuKzwpy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOuKzwpy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C14C116C6;
	Thu, 26 Feb 2026 18:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772132229;
	bh=PnxEIgfsXeStlrThxLfxoDBf2IdKb0WXD9cn82B/HT8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AOuKzwpys4kof1ZxK7YXH2reFy+tcD+VOHwUOAvUXIQgyrggK4FbVj4kmokSrxxce
	 AiX9oVFnCv1wyqoUxClw/UI1VUJBGUzlCHWD1UR5W+AhVEQNKBmYnN8rA4QyWgB9fX
	 VcIo4zJSIlby/v3JSoy8oFh4cRBXgi3BuqwyWhUHIj3Jj15H7VtBW4VlT1EYhZmrbu
	 d3c/XrAwMiRW1EIvUvPM9JPfVR7XqnpV2Z/5zqaQqennlovKf4LiSeg8RN95a2nJ4G
	 GDHML72oPy9JtFFliUruxGMb2TUSCjf4yhRdXTCILJ8l0Wg+4lxR2y2FCwxv25fdn/
	 n36rzn+jSPB6w==
Message-ID: <df5dac1b-286d-43d5-a742-375b6de8730f@kernel.org>
Date: Thu, 26 Feb 2026 19:57:05 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] Bug: Write fault blocked by KUAP!
To: Caleb Sander Mateos <csander@purestorage.com>,
 Ming Lei <ming.lei@redhat.com>
Cc: Changhui Zhong <czhong@redhat.com>,
 Linux Block Devices <linux-block@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
References: <CAGVVp+U0EYVX+VbbEHzcYP70zdmOXwAmUvpMYV9y3jBSRFmS6g@mail.gmail.com>
 <CAFj5m9L8ahNYFf-tUAZFKAUzkeyqV-Sx94MxC268XJ-hqHPCig@mail.gmail.com>
 <CAFj5m9+OCswLULgVx8eSydTG0OeN4f-8dK1-JyoAA70CNF88Qg@mail.gmail.com>
 <CADUfDZrq96YGiMN9==gMitAHZtXydOAwy-767-d0j5LdUqO91Q@mail.gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <CADUfDZrq96YGiMN9==gMitAHZtXydOAwy-767-d0j5LdUqO91Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 26/02/2026 à 17:59, Caleb Sander Mateos a écrit :
> On Thu, Feb 26, 2026 at 4:44 AM Ming Lei <ming.lei@redhat.com> wrote:
>>
>> On Thu, Feb 26, 2026 at 6:48 PM Ming Lei <ming.lei@redhat.com> wrote:
>>>
>>> Hi Changhui,
>>>
>>> Thanks for the report!
>>>
>>> Loop Caleb Sander Mateos  in.
>>>
>>> Thanks,
>>>
>>> On Thu, Feb 26, 2026 at 6:37 PM Changhui Zhong <czhong@redhat.com> wrote:
>>>>
>>>> Hello,
>>>>
>>>> on the ppc64le arch, I hit the issue below with ublksrv on the latest
>>>> linux-block/for-next, please help check it, and let me know if you
>>>> need any info/test for it. Thanks.
>>>>
>>>> INFO: HEAD of cloned kernel
>>>> commit 37a43fd770f3dcac8f72f3ea909b3e893e2385c9
>>>> Merge: 13cd9b41227a c1dfbd7e71b0
>>>> Author: Jens Axboe <axboe@kernel.dk>
>>>> Date:   Wed Feb 25 08:37:06 2026 -0700
>>>>
>>>>      Merge branch 'for-7.1/block' into for-next
>>>>
>>>>      * for-7.1/block:
>>>>        ublk: report BLK_SPLIT_INTERVAL_CAPABLE
>>>>
>>>> reproducer:
>>>> compile and install https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fublk-org%2Fublksrv.git&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7Cf0b0066758be476be95508de75587a73%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639077220067774377%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=ki4yUMx%2FBTANcpfzEoVMdBKsuflIbzhHO2Wqpxtvj5g%3D&reserved=0
>>>> #echo 0 > /proc/sys/kernel/io_uring_disabled
>>>> #modprobe ublk_drv
>>>> #cd ublksrv
>>>> #make test T=null
>>>> #make test T=loop
>>>>
>>>> dmesg log：
>>>> Feb 26 00:24:30 ibm-p9z-27-lp26 journal: running null/002
>>>> Feb 26 00:24:30 ibm-p9z-27-lp26 ublksrvd-0[57921]: start ublksrv io
>>>> daemon ublksrvd-0
>>>> Feb 26 00:24:30 ibm-p9z-27-lp26 ublksrvd-0[57921]: tid 57923: ublk dev
>>>> 0 queue 0 started
>>>> Feb 26 00:24:30 ibm-p9z-27-lp26 ublksrvd-0[57921]: tid 57924: ublk dev
>>>> 0 queue 1 started
>>>> Feb 26 00:24:36 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
>>>> [1772083476.4882] platform-linux: do-add-ip6-address[2:
>>>> fe80::8448:a3ff:fe51:f102]: failure 13 (Permission denied - ipv6: IPv6
>>>> is disabled on this device)
>>>> Feb 26 00:24:36 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
>>>> [1772083476.4885] platform-linux: do-add-ip6-address[2:
>>>> 2620:52:9:160c:8448:a3ff:fe51:f102]: failure 13 (Permission denied -
>>>> ipv6: IPv6 is disabled on this device)
>>>> Feb 26 00:24:36 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
>>>> [1772083476.4938] l3cfg[0f1985ec14299e62,ifindex=2]: unable to
>>>> configure IPv6 route: type unicast fe80::/64 dev 2 metric 1024 mss 0
>>>> rt-src ipv6ll
>>>> Feb 26 00:24:38 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
>>>> [1772083478.4938] ipv6ll[95ab7f3fdbfe643d,ifindex=2]: changed: no IPv6
>>>> link local address to retry after Duplicate Address Detection failures
>>>> (back off)
>>>> Feb 26 00:24:38 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
>>>> [1772083478.4943] platform-linux: do-add-ip6-address[2:
>>>> 2620:52:9:160c:8448:a3ff:fe51:f102]: failure 13 (Permission denied -
>>>> ipv6: IPv6 is disabled on this device)
>>>> Feb 26 00:24:48 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
>>>> [1772083488.5034] platform-linux: do-add-ip6-address[2:
>>>> fe80::8448:a3ff:fe51:f102]: failure 13 (Permission denied - ipv6: IPv6
>>>> is disabled on this device)
>>>> Feb 26 00:24:48 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
>>>> [1772083488.5037] platform-linux: do-add-ip6-address[2:
>>>> 2620:52:9:160c:8448:a3ff:fe51:f102]: failure 13 (Permission denied -
>>>> ipv6: IPv6 is disabled on this device)
>>>> Feb 26 00:24:48 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
>>>> [1772083488.5041] l3cfg[0f1985ec14299e62,ifindex=2]: unable to
>>>> configure IPv6 route: type unicast fe80::/64 dev 2 metric 1024 mss 0
>>>> rt-src ipv6ll
>>>> Feb 26 00:24:50 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
>>>> [1772083490.5034] ipv6ll[95ab7f3fdbfe643d,ifindex=2]: changed: no IPv6
>>>> link local address to retry after Duplicate Address Detection failures
>>>> (back off)
>>>> Feb 26 00:24:50 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
>>>> [1772083490.5039] platform-linux: do-add-ip6-address[2:
>>>> 2620:52:9:160c:8448:a3ff:fe51:f102]: failure 13 (Permission denied -
>>>> ipv6: IPv6 is disabled on this device)
>>>> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: Kernel attempted to read user
>>>> page (7fff81210000) - exploit attempt? (uid: 0)
>>>> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: ------------[ cut here ]------------
>>>> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: Bug: Read fault blocked by KUAP!
>>>> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: WARNING:
>>>> arch/powerpc/mm/fault.c:231 at bad_kernel_fault.isra.0+0xc8/0x2c0,
>>>> CPU#5: lt-ublk.null/57924
>>
>> oops, it shouldn't be related with `ublk: report BLK_SPLIT_INTERVAL_CAPABLE`,
>> Perhaps one issue lies in the ppcle64 architecture code.
> 
> Agreed, the "Kernel attempted to read user page" error seems
> incorrect. The call trace shows this is in copy_from_iter(), so
> reading a user page is expected. I too would be suspicious of the
> powerpc copy_from_iter() implementation.

Looks similar to:

https://lore.kernel.org/all/20260109064917.777587-2-sshegde@linux.ibm.com/

That fix was rejected, more acceptable fix here:

https://lore.kernel.org/all/20260217124457.89219-1-sayalip@linux.ibm.com/

Let us know if it fixes the issue for you.

Christophe
