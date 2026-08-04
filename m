Received: from va-2-51.ptr.blmpb.com (va-2-51.ptr.blmpb.com [209.127.231.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2321A9F96
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 05:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785822610; cv=none; b=txugSo+PhpdnInyjWwI8Jd5g0zYVPvPoJ9R3EiXoxNS2ZIb6fFYFUKmhNZKm1QlrmJfX/QlAirODqVUhGxXIMcXcu/Ro8Xx0GNGTjgmj9KpBiDqh4xbn9G7737FbomrFal6XP0xNX5dQWUYKtazjkP7OguoreyNPzgGCs9ifNw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785822610; c=relaxed/simple;
	bh=setEX5VUZqq2mU00+0B4wqkLWq9dPw5V+xuu+oaTezU=;
	h=Date:Content-Type:To:Cc:In-Reply-To:From:Subject:Message-Id:
	 Mime-Version:References; b=cN+9Revf5IQW7ej31M4CC2hYpLvk1Einiw30eMEnF6xoAOQB9HrBM83OsjT1g2VmcHk55DnZQ2Y+c6adUaB9puAKF8xB4qlwGINz7+6WwvJI5kx5Wdpc1JyDIpX35lruPsxlcrwLZL9NMw+yZO2+SRXa6j56msmj52QvE/ijH8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=ZStOKxyp; arc=none smtp.client-ip=209.127.231.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="ZStOKxyp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1785822600;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=ZdMj9iR8e+/zdokJq2DgMHJ5s3j4S0Svxt7B4p4M8bs=;
 b=ZStOKxypx/DD8l+L5oOrxxeGtjAowix5Rf9cX8hbh7y0jF60ao0loXShGxmA4+4U0T+8Yx
 Qkf+EVpMI5fca4Ie1nkI+0dKV4CfbWn8+95ee+m0oiDQBl8obhfVqwetNAUadlbgcKNvyv
 LNhi8EIrgcQwG5h7rz/hneefZrF4POAatbimik54r/aW1xJF8SQYTE5M1iivZwtsVly/VK
 WNlKoQfpd04H6VKAKW937tFH9TjOCvlPzOkpf4VqbY3Qjmr8zJUvJPbcJtHbFGUpY95LuH
 2VHqBjtmaiKPsjRNsmHi0Aha+edAD37OKvtmUQ4xn96633cBij/VQseqOdtCZQ==
Date: Tue, 4 Aug 2026 13:49:46 +0800
X-Original-From: Coly Li <colyli@fygo.io>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Content-Type: text/plain; charset=UTF-8
To: "Ramesh Adhikari" <adhikari.resume@gmail.com>
Cc: <axboe@kernel.dk>, <gregkh@linuxfoundation.org>, 
	<linux-block@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <CAC-THR8O=g=566evNCA-fmiprLaCL2f15w3dEjz8MSgAG4cMRw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Received: from smtpclient.apple ([120.245.64.97]) by smtp.larksuite.com with ESMTPS; Tue, 04 Aug 2026 05:49:59 +0000
From: "Coly Li" <colyli@fygo.io>
Subject: Re: [PATCH v7 0/2] badblocks: fix rounding bug and validate input range
Message-Id: <FB5BB136-7491-4B3A-AFA4-D56CAED8F9C6@fygo.io>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a717d88+433ad5+vger.kernel.org+colyli@fygo.io>
References: <20260709131904.596684-3-adhikari.resume@gmail.com> <20260721164027.637078-1-adhikari.resume@gmail.com> <CAC-THR8O=g=566evNCA-fmiprLaCL2f15w3dEjz8MSgAG4cMRw@mail.gmail.com>

Hi Ramesh,

I will review the 2nd patch soon.

Thanks.

Coly Li

> 2026=E5=B9=B48=E6=9C=884=E6=97=A5 13:41=EF=BC=8CRamesh Adhikari <adhikari=
.resume@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi Jens, Coly,
>=20
> Gentle ping on this series. Patch 1/2 has Coly's Reviewed-by, and
> both patches address:
>=20
> - an RCU stall / kernel hang reachable via the nvdimm ioctl path
>  (badblocks_check() looping with a non-advancing cursor)
> - a 32-bit (arm/i386) build break from 64-bit division helpers,
>  reported by the kernel test robot
>=20
> Both are tagged Fixes: and Cc: stable, so happy to resend or rebase
> if anything's needed on my end  just let me know.
>=20
> Thanks,
> Ramesh
>=20
> On Tue, Jul 21, 2026 at 10:11=E2=80=AFPM Ramesh Adhikari
> <adhikari.resume@gmail.com> wrote:
>>=20
>> Two related fixes to block/badblocks.c:
>>=20
>> Patch 1/2 fixes the actual reported bug: round_up()/round_down() don't
>> modify their argument in place, they return the rounded value, and the
>> callers in _badblocks_set()/_badblocks_clear()/badblocks_check() were
>> discarding that return value. Depending on caller alignment this could
>> leave sectors unrounded or, in the reported case, stall the CPU with a
>> non-advancing cursor when reached via the nvdimm ioctl path. It also
>> fixes a 32-bit build breakage reported by kernel test robot, since the
>> old rounddown()/roundup() macros pull in 64-bit division helpers not
>> linked on 32-bit builds. Unchanged since v6.
>>=20
>> Patch 2/2 hardens the same three functions against the input-range and
>> shift edge cases the round_up/round_down fix exposed: s + sectors
>> overflow, and rounding itself wrapping past ULLONG_MAX. Revised in v7
>> per Coly's review of v6 =E2=80=94 see the changelog in that patch for de=
tails.
>> The remaining open item, bounding bb->shift where it's populated from
>> the on-disk MD superblock in drivers/md/md.c, is being sent separately
>> since it's a different file and a different root cause (missing input
>> validation, not a rounding bug).
>>=20
>> Ramesh Adhikari (2):
>>  badblocks: fix in-place round_up/round_down usage bug
>>  badblocks: validate sector range and shift before rounding
>>=20
>> block/badblocks.c         | 40 ++++++++++++++++++++++++++++++++-------
>> include/linux/badblocks.h |  6 +++++-
>> 2 files changed, 38 insertions(+), 8 deletions(-)
>>=20
>> --
>> 2.43.0
>>
