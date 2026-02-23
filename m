Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29167262B
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867161; cv=none; b=A4TFEigopBuV498vE/yq1AOrsvWrie3T9xnnk4W0OxULX6dTpIaQx3NykJMLlRaDFULzi8La1lQIQXsTDaZb39sgzjypc1gWkppQ5ajlreviAH4Qs8tZwr1MIxakS+ACAK7Szz8EAHSqBCWChKBlsDQr0WN56Lct6uvxdj2x/3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867161; c=relaxed/simple;
	bh=OEi5T4L5dpernR/2Z9VLhgrXY3ut8bJ8sg8VBlJ8ZGc=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FoHeT2bonF7HQkN4g+9ir//q9wYhaRmXo7avz6F0jtxNgB4fgwQyNcSlU8R4gpGIs3jlKQbEo3RGc4/V7JvFDCx4A23boMgvd14jHd2XVtOmXIpQ/lDqC2CGxjgkrwwAEIkg1ncSmnaJOwziMzIPL0kzkcqcQfNIapD/I8BuKrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=Q6hwCHv3; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="Q6hwCHv3"
X-Virus-Scanned: Yes
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1771867155; bh=OEi5T4L5dpernR/2Z9VLhgrXY3ut8bJ8sg8VBlJ8ZGc=;
	h=Subject:From:In-Reply-To:Cc:References:To;
	b=Q6hwCHv3YK2rjElFh+Kzo0GIHphdUIxYesSIGwXCy0fZLzstXp4lI3I37Ki3RlpDE
	 rmJl8+sefjJbSyIv0zT37GUcwGZoecDLzdaBPwxsKc65B5PETW2PDaJmMQ27986su8
	 DL7e/2c/2fDwYbrry0tfOzoawlz29mQCKNXtf/p88LO+UsFJusa7ADanjMVPzVijYb
	 VtXH0pzlKkEK2XeBKQfPi7J3gw+GP4p0SHwqktlzLQMEp3sZXvrhOw4jrZcYQ5Fn0G
	 KGDfxMxKHb+1nCAuEm1I6vZ2HDETm0o3IdlSNsxtgTM7Z74dG/TzTgTj8/Z1Aga8Pf
	 tAo5IaIVVUL/GJ90rXZ4ESRMuHdbewzNi556NxGlDg3nz8TBENc9sAkURkDmAWCMMP
	 9ZLkO4uhRZhc5SQGzbuVAqcSxKSZymIax0Sjg1FY/mr8qv5ofuCIjUwkzrp9Oastgg
	 zSx8eEQ8WrDAIUSubnZwYeQwLOw9rhTz15sZy9kFirWnKjxBzN3Kx5aavzWnVT2bV7
	 wWisA0E92K/Xx2ceiB44xaXYf37T98f+nc/1fG6e+5AnmwfQ9YVK55blYcDtwyN8nr
	 G+/bfgeIVd4sbPwpkUPFp0acoatUC9jnfJoywXDdQ4eQ8qPRGUOxZP7QLVhwQkSyR6
	 yqOQT2WzfdWLbjnSnHVsJJl0=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] ublk: cleanup flag handling and fix
 UBLK_F_NO_AUTO_PART_SCAN
From: Alexander Atanasov <alex@zazolabs.com>
In-Reply-To: <CADUfDZqy-wrUDW=Ka+v0sKA0MGrMyVjPNQwU0V0hwA0yMxUbKA@mail.gmail.com>
Date: Mon, 23 Feb 2026 19:19:03 +0200
Cc: Ming Lei <ming.lei@redhat.com>,
 Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <272F3354-E3BB-4164-962A-C9D56A42DC07@zazolabs.com>
References: <20260223121515.3296983-1-alex@zazolabs.com>
 <20260223121515.3296983-2-alex@zazolabs.com>
 <CADUfDZp-jX98mfERO0OUoMePfws5yRtvfmLfzD2tzfi+HDPyLQ@mail.gmail.com>
 <A21C344C-709D-4E28-B0C4-62946391D560@zazolabs.com>
 <CADUfDZqy-wrUDW=Ka+v0sKA0MGrMyVjPNQwU0V0hwA0yMxUbKA@mail.gmail.com>
To: Caleb Sander Mateos <csander@purestorage.com>



> On 23 Feb 2026, at 18:42, Caleb Sander Mateos =
<csander@purestorage.com> wrote:
>=20
> On Mon, Feb 23, 2026 at 8:23=E2=80=AFAM Alexander Atanasov =
<alex@zazolabs.com> wrote:
>>=20
>>=20
>>=20
>>> On 23 Feb 2026, at 17:59, Caleb Sander Mateos =
<csander@purestorage.com> wrote:
>>>=20
>>> On Mon, Feb 23, 2026 at 4:17=E2=80=AFAM Alexander Atanasov =
<alex@zazolabs.com> wrote:
>>>>=20
>>>> Currently the code misuse GD_SUPPRESS_PART_SCAN flag
>>>> as it tries to use it as a switch for the auto partition scan.
>>>> To fully disable creation of partitions GENHD_FL_NO_PART must
>>>> be used, switch code to use it instead GD_SUPPRESS_PART_SCAN.
>>>>=20
>>>> Using the new flags rules for partitions become:
>>>> - Unprivileged daemons - never scan partitions, they have
>>>> GENHD_FL_NO_PART always set - they are devices without partitions.
>>>>=20
>>>> - Trusted daemons - by default have partitions disabled.
>>>> Partitions can be enabled via UBLK_F_PARTITIONS flag and
>>>> automatic initial scan can be requested via UBLK_F_AUTO_PART_SCAN =
flag.
>>>>=20
>>=20
>> [snip]
>>=20
>>>> Rework the code to work as described above:
>>>> - remove checks in ublk_partition_scan_work and rely on
>>>> the caller to schedule the work only if it has to be done.
>>>> diff --git a/include/uapi/linux/ublk_cmd.h =
b/include/uapi/linux/ublk_cmd.h
>>>> index a88876756805..467ecaa20ac1 100644
>>>> --- a/include/uapi/linux/ublk_cmd.h
>>>> +++ b/include/uapi/linux/ublk_cmd.h
>>>> @@ -367,8 +367,11 @@
>>>> */
>>>> #define UBLK_F_SAFE_STOP_DEV   (1ULL << 17)
>>>>=20
>>>> -/* Disable automatic partition scanning when device is started */
>>>> -#define UBLK_F_NO_AUTO_PART_SCAN (1ULL << 18)
>>>> +/* Enable partitions on the device */
>>>> +#define UBLK_F_PARTITIONS (1ULL << 18)
>>>=20
>>> This is not backwards compatible. Existing ublk servers expect their
>>> devices to support partitioning. If you want to introduce a feature
>>> flag to control this, it needs to be opt-out rather than opt-in.
>>> UBLK_F_AUTO_PART_SCAN probably also needs to remain as
>>> UBLK_F_NO_AUTO_PART_SCAN.
>>=20
>> It is easy to turn both to opt-out - it will just get double =
negatives here and there,
>> which I tried to avoid. I got the impression that the API can be =
changed in current stage
>> and people in general do not want to have partitions at all, so not =
having them by default
>> is better. But looks like I am wrong here.
>=20
> I agree it's probably more typical to use ublk devices without
> partitions. If we were designing the ublk UAPI from scratch, it might
> make sense to require a feature flag to opt in to partitioning. But
> ublk has been around since kernel 6.0 and has always implicitly
> allowed ublk devices to be partitioned. So we can't change that now
> without breaking existing ublk servers. UBLK_F_NO_AUTO_PART_SCAN, on
> the other hand, was just merged in the 7.0 merge window, so there
> likely aren't many ublk servers using it yet. It's reasonable to
> change its behavior before 7.0 is released.


Well, may be we can spend on flags bit and just keep
 UBLK_F_NO_AUTO_PART_SCAN (1ULL << 18)=20
as it is for backward compatibility and mark it as deprecated.
and add the two opt-in flags for new users.

>=20
>>=20
>> UBLK_F_NO_AUTO_PART_SCAN(old) -> UBLK_F_NO_PARTITIONS on by default
>> UBLK_F_NO_AUTO_PART_SCAN(new) -> disable auto scan on by default
>>=20
>> Also for backward compatibility moving to GENHD_FL_NO_PART can also =
break
>> users who did a user space partition scan.  But I have no idea what =
to do here (yet),
>> especially with regard to unprivileged devices.
>=20
> I'm not familiar enough with how partition scanning works, but if a
> userspace-initiated partition scan can block any kernel threads, I
> think it would be reasonable to prevent it for ublk devices with
> unprivileged daemons. I agree it's a behavior change, but it could be
> considered a bug fix.


GD_SUPPRESS_PART_SCAN is protection against bugs in kernel partition
scanning code, i.e. it can be feed with bad data and cause a crash.=20
But it does not prevent using BLKPG* family ioctls to manage partitions,
partscan uses them for example.
The intent was to disable partitions on untrusted devices as they
might be used in containers and potentially with untrusted data.
But the right flag to do so is GENHD_FL_NO_PART, which disables =
partitions completely.
Yes it is both  a bug fix and  a behavior change. But since the original
intent is to not have partitions I think it is okay to count it as a bug =
fix only.


Regards,
Alexander Atanasov



