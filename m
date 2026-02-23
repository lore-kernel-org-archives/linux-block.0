Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BBB30BBA9
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863819; cv=none; b=qIlcWCGY0qNiFaQRbIMHgvG+dFtFOZAzuYf83HAXfhUpTcPY+zml+7VZlsvtJ3yYc2De9YBdl2dei+O3ghGwmv5tbQoOXM3PDKs6+bNJD7AlFT6cPiEbTDixIwqdGFZ4k9DMBPqqE4PmKKHbiyDOkQta6uacIG5A3v6jjdOSyiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863819; c=relaxed/simple;
	bh=1Xg70YMd+FaVEOb4w7tS4Z1DiPj7LoxSZz0ooGNfLJA=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LzrusI5lWglNOVIlNXQrv5jz6xlhRGSRbdhBqhJ5hu297zkMCvZnzMY7HrX8OZDR2jz2OS8F55HXnqL1DUgwhLktMGwd6AndpAtyPn2kHYL5Qdp1fGxVIuZ7JMoiyBd8VR/vrYq/C/+zzphGmOSPrzbNFcxjQe5iZ/kV0rJKGMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=RMQ+HSdw; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="RMQ+HSdw"
X-Virus-Scanned: Yes
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1771863813; bh=1Xg70YMd+FaVEOb4w7tS4Z1DiPj7LoxSZz0ooGNfLJA=;
	h=Subject:From:In-Reply-To:Cc:References:To;
	b=RMQ+HSdwctZiDtv2Jm2NSE7NKTLRMqLGYwGn9ESKrLc1fGF6wSCW5Bkk7wQXWXTuV
	 beiddA+C/LUcaW7A80qJhr+hNZPjAiePuVkQdQ57xvPVRaqSYai0eA38ZEey0VqKRg
	 I7qdp4vDEWzYpiN70812gBNXvCdU88bYsCOar4gGzvot1/DTtONhJF5YEu49Pt7id8
	 enMXRBx0GP8P8JNHoenHyqqwWq7CVEx3QHC7Cn7Y1E4h6laLLrMMR0GACmZCq7CiDq
	 gAO81tw/4LvMnFgTdD76AHcobgE8vU707pBzO2uZMbn24S9RVJ8Y2DQKUYxsb1zxcB
	 jm4Nt6at9KUpRJcs4nC31XKecaa7A8VhC05gvY/a3Ftb74RZwE/MtM3KwsdwiZI5XL
	 lIZ43L19AaWc2+ORgW/kjMkpzVKhbhsA6l5cg3TtKHScrLHdTZ53A3Y3UIRbegSzh7
	 9V7LKg0KdEp/fmE6hvIKin1ZSwm+xK8nvPm4llFCJwG4oonHlUOqmvvTsjzlHe76/b
	 giUtvgoAh1UvfpT0lN9Yo2Xor4Y63HNwIpB5HlOcDpn62pRLRU9gW3i2zG/IXq4okH
	 xnMGYYgYCw7BolGAkFfzKudNNvEUaWmlM/rzYg8GYEw2y5WD9gtJ1N1e5nqL9yxGDi
	 X9bFDVGoNwvmA4K9dBrESjSY=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] ublk: cleanup flag handling and fix
 UBLK_F_NO_AUTO_PART_SCAN
From: Alexander Atanasov <alex@zazolabs.com>
In-Reply-To: <CADUfDZp-jX98mfERO0OUoMePfws5yRtvfmLfzD2tzfi+HDPyLQ@mail.gmail.com>
Date: Mon, 23 Feb 2026 18:23:21 +0200
Cc: Ming Lei <ming.lei@redhat.com>,
 Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A21C344C-709D-4E28-B0C4-62946391D560@zazolabs.com>
References: <20260223121515.3296983-1-alex@zazolabs.com>
 <20260223121515.3296983-2-alex@zazolabs.com>
 <CADUfDZp-jX98mfERO0OUoMePfws5yRtvfmLfzD2tzfi+HDPyLQ@mail.gmail.com>
To: Caleb Sander Mateos <csander@purestorage.com>



> On 23 Feb 2026, at 17:59, Caleb Sander Mateos =
<csander@purestorage.com> wrote:
>=20
> On Mon, Feb 23, 2026 at 4:17=E2=80=AFAM Alexander Atanasov =
<alex@zazolabs.com> wrote:
>>=20
>> Currently the code misuse GD_SUPPRESS_PART_SCAN flag
>> as it tries to use it as a switch for the auto partition scan.
>> To fully disable creation of partitions GENHD_FL_NO_PART must
>> be used, switch code to use it instead GD_SUPPRESS_PART_SCAN.
>>=20
>> Using the new flags rules for partitions become:
>> - Unprivileged daemons - never scan partitions, they have
>> GENHD_FL_NO_PART always set - they are devices without partitions.
>>=20
>> - Trusted daemons - by default have partitions disabled.
>> Partitions can be enabled via UBLK_F_PARTITIONS flag and
>> automatic initial scan can be requested via UBLK_F_AUTO_PART_SCAN =
flag.
>>=20

[snip]

>> Rework the code to work as described above:
>> - remove checks in ublk_partition_scan_work and rely on
>> the caller to schedule the work only if it has to be done.
>> diff --git a/include/uapi/linux/ublk_cmd.h =
b/include/uapi/linux/ublk_cmd.h
>> index a88876756805..467ecaa20ac1 100644
>> --- a/include/uapi/linux/ublk_cmd.h
>> +++ b/include/uapi/linux/ublk_cmd.h
>> @@ -367,8 +367,11 @@
>>  */
>> #define UBLK_F_SAFE_STOP_DEV   (1ULL << 17)
>>=20
>> -/* Disable automatic partition scanning when device is started */
>> -#define UBLK_F_NO_AUTO_PART_SCAN (1ULL << 18)
>> +/* Enable partitions on the device */
>> +#define UBLK_F_PARTITIONS (1ULL << 18)
>=20
> This is not backwards compatible. Existing ublk servers expect their
> devices to support partitioning. If you want to introduce a feature
> flag to control this, it needs to be opt-out rather than opt-in.
> UBLK_F_AUTO_PART_SCAN probably also needs to remain as
> UBLK_F_NO_AUTO_PART_SCAN.

It is easy to turn both to opt-out - it will just get double negatives =
here and there,
which I tried to avoid. I got the impression that the API can be changed =
in current stage
and people in general do not want to have partitions at all, so not =
having them by default
is better. But looks like I am wrong here.=20

UBLK_F_NO_AUTO_PART_SCAN(old) -> UBLK_F_NO_PARTITIONS on by default
UBLK_F_NO_AUTO_PART_SCAN(new) -> disable auto scan on by default

Also for backward compatibility moving to GENHD_FL_NO_PART can also =
break
users who did a user space partition scan.  But I have no idea what to =
do here (yet),
especially with regard to unprivileged devices.

>=20
> Best,
> Caleb
>=20
>> +
>> +/* Perform automatic partition scanning when device is started */
>> +#define UBLK_F_AUTO_PART_SCAN (1ULL << 19)
>>=20
>> /* device state */
>> #define UBLK_S_DEV_DEAD        0
>> --
>> 2.43.0


Regards,
Alexander Atanasov



