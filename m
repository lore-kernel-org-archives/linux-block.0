Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F32C1CAA68;
	Fri, 23 Jan 2026 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769176788; cv=none; b=SrSPYlzPZ3Rw6IJRRHsyQL4F7iIQPlTEQhFd2je1+dk7lNJkFyCTlZCIlGopRQXCelsEC/ngfTnvTQUFOS4X+/Bf9LgS8PrJ1Ppthc4VevPc4INco8OlxAuo1QRAI2Wy2lSto8nw6cTQeTgiDEKIphbSFsRiO9aS8ZvmOQ7SRfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769176788; c=relaxed/simple;
	bh=0OH6JoHuspl2xvJjfbXbWBanXbD46736d6C4yRv7NPc=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XGzqQjzZnY+Ab06zMWKi+JZHkQpEWlGZaaJfoaLemeB18I6nJA1segJeVoAArwL/C/QiOjpK3paOiIKul9vqWS4QuQLsPzPupQDmIYQdy3AzMvgSf3UeqZkdMraTFaawjLH2m3NkVT7gucwYdVmJUn69cMRvk95bPLic66TixR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=JalfWsfK; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="JalfWsfK"
X-Virus-Scanned: Yes
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1769176783; bh=0OH6JoHuspl2xvJjfbXbWBanXbD46736d6C4yRv7NPc=;
	h=Subject:From:In-Reply-To:Cc:References:To;
	b=JalfWsfKh1x9caOsDVBDbmrYgWCNDkmwd7m9BP0ojWg9Q2g8suQvceK6MJDsITAbs
	 WqNN7CFnhL6S0gY0F40TTf/Vcz6fuv3OrdKUBUdaJcMiHbi5+5rnnO71i8xHUQGkMe
	 EsYnq0wpYWcj80hiyv9IA3ox7ErAaGa0JPSFkVyIwKAo6pBJ0kc64QJK6uqCNcV/G3
	 bXPP52VnpV4IiMIYQUGQYYt1yMIqjhpCaYNfA67iOCNq+0v6tkBu/JVfme3zkC8szs
	 lSDDMRaV7yrOdfSriBTT773oH8S85ugtEX+nCs2QqUOKpp5IrwD5CCCOE0L8M9WO7b
	 NKdje9+b3T7Io5Mhg9x1p0+jcexTBno/wnGV+WNdP+Be/zP+8t3aMBmuogFkV+6f4o
	 I2ULjL4LntbhyRxqPl5rIBj96Imul2ZGY61VdLQzLOuLDhXqwr3g3mdVFpHEoBj+qM
	 s8qvF0kZydQe7jnpAq+bsCXl7F3THOk5Bar3gJmNxVya6m+OuA3QVZ3MhkcdYSOneY
	 KHdSTulOEWw0F8sKXSiZdWyc8t3ZesOlML8Ikgc96l072Imra27/tQnxkZduXcDCT7
	 hF6NCisZmurEB1COHp9l8kfL659jd+Eza4cmz4N7eJeriYl9My/JwbLHWDPIxcHWfU
	 bGxSBwv9zWxvHdefNS6+AzKw=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests: ublk: use tmpdir for scratch files and improve
 relative paths use
From: Alexander Atanasov <alex@zazolabs.com>
In-Reply-To: <aXN4mFuoXhtJDKyF@fedora>
Date: Fri, 23 Jan 2026 15:59:31 +0200
Cc: Shuah Khan <shuah@kernel.org>,
 linux-block@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <147635F1-943E-46D5-8EF1-D1C965F85EC1@zazolabs.com>
References: <20260123112039.1370223-1-alex@zazolabs.com>
 <aXN4mFuoXhtJDKyF@fedora>
To: Ming Lei <ming.lei@redhat.com>

On 23 Jan 2026, at 15:33, Ming Lei <ming.lei@redhat.com> wrote:
>=20
> On Fri, Jan 23, 2026 at 11:20:36AM +0000, Alexander Atanasov wrote:
>> Create a temp dir for temporary files and use it instead of
>> placing them inside source tree.
>=20
> Many temporary files are backing files of file storage target, so far
> the code requires O_DIRECT, or the size could be a bit big.
>=20
> In case of ramfs/tmpfs of temp dir, it may cause problem for tests.
>=20

I am aware of O_DIRECT problem but you can export different TMPDIR that =
has working O_DIRECT.

I use sshfs mount of the build to run the tests and that is a problem =
sshfs/fuse does not
do O_DIRECT too.

I think test_generic_06.sh is the only one that fails due to this(thou I =
still have to investigate).

If O_DIRECT is required by the tests it may be possible to go thru a RAM =
disk which does support it,
so it works eveerywhere

Other option is to preserve working in source tree as it is now, and =
just add a variable to specify working directory -
UBLK_TMPDIR or something.


I get a lot of out of order io - between 0 and 10 on average on my test =
setup:
tools/testing/selftests/ublk/test_generic_01.sh=20
Attached 3 probes
io_out_of_order: exp 564688 actual 564648
io_out_of_order: exp 564648 actual 565584
io_out_of_order: exp 565584 actual 564688
io_out_of_order: exp 565592 actual 564688
io_out_of_order: exp 566328 actual 565592
io_out_of_order: exp 882256 actual 882248
io_out_of_order: exp 883032 actual 882912
io_out_of_order: exp 882912 actual 883040
io_out_of_order: exp 883040 actual 883032


generic_01 : [FAIL]

All rq-s are there just reordered , AFAIK blk-mq does not guarantee that =
requests will be completed in order, what=E2=80=99s the idea to catch =
this and
consider it an error? (Latest tree with batch io and batch io fixes on =
top of if that matters)


Regards,
Alexander Atanasov



