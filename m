Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43661274FC1
	for <linux-block@vger.kernel.org>; Thu, 12 Feb 2026 18:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770920782; cv=none; b=SUWNzKGxdx54RNV4PvJlZlorrzAHmksT4Od36APCUZ1fuW/kHx5Dl4HsqJjVP+xkr/F2Iw/nvhk3wRodV5+dx8i779H/FZHgFMv0xtwfnef50ftT4LY2GK0PQqDguvqgY2MVKM28eTcfUSNfv7HsfuzRzltUW1KmvX+P9LgHsZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770920782; c=relaxed/simple;
	bh=FbopfvGOmfDpFc/KtQozR3IJOYSa6/YtjlOBWSvunNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEWFbLJ/usYbNm8Aq9C0ahqXOQ9NsvGgApSfrhKBSBz4bdeg1vgv0ICCR5UxKJrmXIlqS2GO/TNUYiaeHTz9samJhMatD41bS32+spZOhzWCBKaHUnembFKoE11+m4B1VWzCvBk9MItD678P4npeHL5oUK68Iv2ozGgkua/vRfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=rY6xd+LT; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="rY6xd+LT"
X-Virus-Scanned: Yes
Message-ID: <6c293fa1-adce-4df8-8a1b-fc2337a978a5@zazolabs.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1770920778; bh=FbopfvGOmfDpFc/KtQozR3IJOYSa6/YtjlOBWSvunNI=;
	h=Subject:To:Cc:References:From:In-Reply-To;
	b=rY6xd+LT+zBRUrHncMq0kdfmWMLzc9fgKHVPVvVveo0H8ULclACFum4YVG4ok3OvM
	 Pp5vFdvWy8WvvFNBkejdRmt8+CIJGnwT2+YzIEOZnSSKrjIWRptOQRYywjmi3trafF
	 grJqh+0oSoT0u58nNSkqfrsGTiXV+EUbcbk4sVurevIctvx8kpiW77moG//mcRwrvm
	 0SLvb/fgrqHSfvWkr+fJ7aCoUHrtJXi7gHW/+JL9pJCHB8ocZ3WbBgOLLmHMph/FmQ
	 ClZykGfnLa4NyliisP6auUQMMQcHNa6QfZCDvs8xjOOonlMPHSKKV+hETJH6ZIX/uF
	 ukLJLKqCNVzcZUgkCulu8zWd9Uzo4+oJV5hOnA2T0ehEaFpCjUcjYfzmFj/Yu+iKn4
	 DFwk2K+Coah7gVJ+B0uJ1fZoLyUw3CMQg8Vsw1XpXns9Z9F0YhCgNbACksuRUZwMG3
	 DFlXVToH8ttaU0GwG/1HmnLtEvU7jzyLc/S+YQ7p/ElMX0DuQJokfidATnjNX3OawJ
	 aeUIBaUws7d7ReGxob8YsJd8UcOKtmLo4FBalNWOFOsz3h5vkGUvsZQXHicEh750oc
	 5Ct5qqKaJ3IlRwUfrvrDdtT8vxRauO411nbYriKAF3/6CiX2xvq/NVtSoHg0skMrSH
	 LPjLwudPfvpdIi+PHeNa+kKc=
Date: Thu, 12 Feb 2026 20:26:16 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: ublk invert part scan bit logic
Content-Language: en-GB
To: Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <0535f4dd-ada3-414a-84c6-7abc232aa670@kernel.dk>
 <aY3KpLbAOchXxXyi@fedora> <dfc5a8d3-45d3-4fe2-aa0b-b9571b5fb883@kernel.dk>
 <aY3PYGblTx748m4q@fedora> <e63cd486-cdf0-4c90-85a5-b2f15699e96d@suse.de>
 <aY3iLwf8G3jKUIbw@fedora>
From: Alexander Atanasov <alex@zazolabs.com>
In-Reply-To: <aY3iLwf8G3jKUIbw@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.02.26 16:22, Ming Lei wrote:
> On Thu, Feb 12, 2026 at 03:04:53PM +0100, Hannes Reinecke wrote:
>> On 2/12/26 14:02, Ming Lei wrote:
>>> On Thu, Feb 12, 2026 at 05:48:40AM -0700, Jens Axboe wrote:
>>>> On 2/12/26 5:42 AM, Ming Lei wrote:
>>>>> On Thu, Feb 12, 2026 at 04:05:27AM -0700, Jens Axboe wrote:

>>>
>> Is there a specific reason to continue to allow BLKRRPART if the
>> UBLK_F_NO_AUTO_PART_SCAN is set? Wouldn't is be better to have a
> 
> No, I just want to allow future ioctl(BLKRRPART).
> 
>> simple 'UBLK_F_NO_PART_SCAN', which directly maps to GD_SUPPRESS_PART_SCAN?
>> Would we lose something substantial in that case?
> 
> If there is, we may add new feature flag for it.
> 
>>
>> I actually would _like_ to be able to suppress partition scan
>> completely for ublk devices...
> 
> Fine, we can change UBLK_F_NO_AUTO_PART_SCAN to align with GD_SUPPRESS_PART_SCAN.


These are two different things, does not make sense to merge them.

Use case is you have a backing files which are not ready/accessible -
you create a device with UBLK_F_NO_AUTO_PART_SCAN.
Do some preparations using the device and when files are ready
read the partitions.

If there is a use case to disable partitions on a trusted devices then a
new flag to map to GD_SUPPRESS_PART_SCAN makes sense.
And that is in case using UBLK_F_NO_AUTO_PART_SCAN to suppress initial
auto scan is not enough.


-- 
have fun,
alex
