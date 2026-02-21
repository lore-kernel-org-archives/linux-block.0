Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115A3131E49
	for <linux-block@vger.kernel.org>; Sat, 21 Feb 2026 13:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771679200; cv=none; b=CO1aHZpzE/NXyxx+GBc5Bp7Tua/xVvdn6j4Cao/tBPS+lpY4T+jouhaUPsIuEj0siGQy/Hgp6b5vBUdUcVtUHEn9NaXVY7Yr6vi8mzJtFjqcmAmtYvUmxF+aGsLBc8lbJMpDa/7aC5IasjwJMzQD/TPRWYyaO8hHC0Nw7j8C9Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771679200; c=relaxed/simple;
	bh=Hc8U17Xt6LcVin8TphIgzsxXMQmZ54svpKwBTfwEiR4=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nX3fSKIyW8Z4+rJmpMfZmyJKpVb7LTR20Mpn8u+L+laXOzF4DjUu0oXrSoyAU9fJI0iYFF5uvH+Zw60Ei+vcaObEmrPx/kR1ofb6LJthFcJhNTmmkbM8QkO2sqBkud2eT04HGCK3zftcfeM5/y/Yb4P5/aX3pDdO4oQcrfVpovE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=kaPxk7q0; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="kaPxk7q0"
X-Virus-Scanned: Yes
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1771678828; bh=Hc8U17Xt6LcVin8TphIgzsxXMQmZ54svpKwBTfwEiR4=;
	h=Subject:From:In-Reply-To:Cc:References:To;
	b=kaPxk7q09eu/ix48yYtRtCmB3MPEf7Lts8xlsurX23RCzS3rlTmTcdcmb7vuSrkTT
	 Jk+Wsjz6dwMjziLyuT3SlnEfSN7Clvz5o7tdD0kPL9AQFvgfrH/Uqtamrlf8KSrcOP
	 F1xtVDRpsDhXEm2W0jluQT8sv54L2bARR2MypJ6Pg3zwIjo9tvEM3pBvWna3oDbP0b
	 DsWhW/Jtny4EqDJ3z90onTj1++VIULhRa+GIdtqcmedVIfwxpKDOXwypiLMX9ANemM
	 JRYlsYJVbIqnlEgQ+cF9jqP/R6X3ZRKktTsFnYyz5YZR3OMh4pm0tOsrtbfsZVtPz3
	 OIIxOE9QTU9ipmGWjUg6R0aF8T+JXMusGeaccqLT/79cwS2feR2Y+dIla3EoZsYmug
	 gS9U+oL2koubKJG+WJt+o53bVKWi9Fkzo+CE6AE1syndCH7eP/QH46EbM8JQLI2yQj
	 Hg7/SspTgRcPsZXQ3wSnDu7ouw5BcfmIcH62IT/q5dEueJeR7KQ5a2e8IBI6KVaoIw
	 OeApAyMpbH7ETtz7HlFDOdNbMhfvc2sirD5OCNXWRIS5noDV1F+7CEILHDzDTwVwOk
	 ZH/Qesm4aa7wnhLtm5KBhqsDG9XhKeGd0Q3jDICqQBwZnxNCLr75qEXvdDVH7lEAem
	 Uws3mDywT0vOA5xCdAhnEyrg=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ublk: cleanup flag handling and fix
 UBLK_F_NO_AUTO_PART_SCAN
From: Alexander Atanasov <alex@zazolabs.com>
In-Reply-To: <aZfb7aQTMRbRaRgb@fedora>
Date: Sat, 21 Feb 2026 15:00:15 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>,
 Yoav Cohen <yoav@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CFA6B655-C9E6-4D44-975D-45D1F75628D6@zazolabs.com>
References: <20260212152553.1737373-1-alex@zazolabs.com>
 <aY6fAlXmzQZCKwmM@fedora> <efe851c6-cb40-4e6f-a382-047b33753ee1@zazolabs.com>
 <aZfb7aQTMRbRaRgb@fedora>
To: Ming Lei <ming.lei@redhat.com>

Hello,

> On 20 Feb 2026, at 5:58, Ming Lei <ming.lei@redhat.com> wrote:
>=20
> Hi Alexander,
>=20
> On Fri, Feb 13, 2026 at 01:05:40PM +0200, Alexander Atanasov wrote:
>> On 13.02.26 5:48, Ming Lei wrote:
>>> On Thu, Feb 12, 2026 at 03:25:52PM +0000, Alexander Atanasov wrote:
>>>> Currently the code misuse GD_SUPPRESS_PART_SCAN flag
[snip]
>>=20
>>>=20
>>> Alexander, please let us know if you'd like work this way?
>>=20
>> =
https://lore.kernel.org/linux-block/c95b3de4-f4f8-4b35-a3e4-a83da98ced0b@z=
azolabs.com/T/#mbb410ceb3f4c6f23e6c566911dfc833365ce9cdc
>>=20
>> in short - having partitions and auto scan are two different =
features, why
>> merge them?
>=20
> Yoav's original requirement has been addressed by scheduling scan work =
in
> wq already.
>=20
> So I think it makes more sense to switch to UBLK_F_NO_PART_SCAN.


Okay.

>=20
>>=20
>> If we want to cover all cases i thing we should go like this:
>>=20
>> /* Enable partitions support on device */
>> #define UBLK_F_PARTITIONS (1ULL << 18)
>>=20
>> /* Do not perform automatic partition scanning when device is added =
*/
>> #define UBLK_F_NO_AUTO_PART_SCAN (1ULL << 19)
>>=20
>> Added value is to have partitions enabled/disabled explicitly for =
trusted
>> devices. Where by default they will be disabled.
>>=20
>> Also may be change from UBLK_F_NO_AUTO_PART_SCAN to =
UBLK_F_AUTO_PART_SCAN -
>> to make it explicit instead and be like
>> the rest of the flags - all are enable flags
>>=20
>> Then these variants become possible:
>> - unprivileged without partitions (can we add security checks to =
allow
>> partitions for them too?)
>> - trusted with or without partitions (UBLK_F_PARTITIONS bound to
>> GD_SUPPRESS_PART_SCAN)
>> - If it is a device with partitions then UBLK_F_NO_AUTO_PART_SCAN =
controls
>> if initial auto scan is performed or not.
>>=20
>> Having them separate can allow emulation of removable media where =
data is
>> not available at device creation time but is known when available by
>> external event so you can load partitions. Two step device bring up, =
i.e.
>> partition scan at device creation time will block you, but you know =
when
>> data is available from an external event, and then you can load =
partitions.
>>=20
>> What do you think?
>>=20
>> I'be added CC Yoav since i think he requested that feature in first =
place. I
>> beleive Hannes may have a different use case, so let's get some more =
input
>> on this.
>=20
> Yoav's original requirement is to not scan partition during ADD_DEV
> command for avoiding hang, which is addressed already by scheduling =
scan work in wq
> context.

Okay.

>=20
> So I think it is fine to change UBLK_F_NO_AUTO_PART_SCAN into
> UBLK_F_NO_PART_SCAN, which can be implemented by GENHD_FL_NO_PART, as =
you
> mentioned.


Okay then I will switch to use GENHD_FL_NO_PART.
UBLK_F_NO_PARTITIONS/UBLK_F_PARTITIONS will be a better flag name than=20=

UBLK_F_NO_PART_SCAN - since it will not be about scanning any more.
Partitions will be disabled completely -  by default for untrusted and=20=

if requested for privileged.

And if privileged have partitions - we need UBLK_F_AUTO_PART_SCAN
or UBLK_F_NO_AUTO_PART_SCAN option to explicitly request or suppress
the initial auto scan.


Regards,
Alexander Atanasov



