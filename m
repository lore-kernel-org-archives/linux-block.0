Received: from sg-1-21.ptr.blmpb.com (sg-1-21.ptr.blmpb.com [118.26.132.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C2331618C
	for <linux-block@vger.kernel.org>; Thu, 27 Nov 2025 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764228915; cv=none; b=S98QgwG04B9ExQoWe+zWDBSBmeKlieL2ltmJPiF6B2/LvHuhTobkfhbMiGKnXDQpdGig+CzLqELlKqL2RjjGX/lkfzMSgAmX/pHPBT0JPREgM1H6OSIdSzA2pFcGWavFRCuIEWUrAEBJ5MJhAtDKAnZLcThLSsZ31kPTlDIIufI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764228915; c=relaxed/simple;
	bh=oEmwfypF1xAnlb9nboIXOJOghZs0T1nWN8Nas1+CFEU=;
	h=Subject:Message-Id:In-Reply-To:To:Date:Mime-Version:Cc:From:
	 References:Content-Type; b=pEdH2yHd7QC0pQTSn7jtEC3BT+V6EHvMvGv6QwTcsTKjfzZMU6bM0kqc/pezHyfbRKH3AKul/ATlC9QMqfd7em/E6nMm0ybzflRsl0Rstj4P7FU93oCjdATr3W6gnceBF0lrKFAo+5NbI47r9PLp7XPDJI21TKupyJWT9R4q16k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=U+Bl9TYY; arc=none smtp.client-ip=118.26.132.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="U+Bl9TYY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1764228900;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=rTC8WndGlfg6Oi81Wk+14Ihg+q/EmaVWWfihhK690jQ=;
 b=U+Bl9TYYOpElBnUfcA2V/uRBXfou99n7Xk3/9jjaI+4a/jv2olTLGs+1jbIWeMuLYGY/gz
 6658Z7UIuKjXDdTpVtjE7Ol1aNKIWcBGl+ngVBvoYncsrUQeujyRDfJTSmWZhdlFiZwDoS
 L3p/FRfx+6l8FzgKUzxco4mmgUodX7llx9IX02zpVhF+KDFgQt9Ijw8+c2EJlC3712Pps9
 3vYg0clpKdmQwXxIG0CvZGS/aquK7sNNa/UvwuzCJif9RbNDhY3PeDzCPuYTmijAADeEfn
 kUUNTifE2E1fb/Cf5k96IS8D75jITTRaRgC0IQkBcNAJxdQ+9+ujjkNfmT/bLA==
Subject: Re: [PATCH blktests] test/throtl: Adjust scsi_debug sector_size for large PAGE_SIZE hosts
Message-Id: <3407c6bc-9832-41d5-81c7-7216dd81f5e2@fnnas.com>
Content-Language: en-US
X-Original-From: Yu Kuai <yukuai@fnnas.com>
In-Reply-To: <1c7ea752-11a1-4f2c-8b1d-1b289eabd583@fujitsu.com>
User-Agent: Mozilla Thunderbird
Organization: fnnas
Content-Transfer-Encoding: quoted-printable
Received: from [192.168.1.104] ([39.182.0.153]) by smtp.feishu.cn with ESMTPS; Thu, 27 Nov 2025 15:34:57 +0800
Reply-To: yukuai@fnnas.com
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, 
	"Bart Van Assche" <bvanassche@acm.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"Yu Kuai" <yukuai@fnnas.com>
Date: Thu, 27 Nov 2025 15:34:54 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Cc: "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
From: "Yu Kuai" <yukuai@fnnas.com>
X-Lms-Return-Path: <lba+26927ff22+7e7b34+vger.kernel.org+yukuai@fnnas.com>
References: <20251121013820.3854576-1-lizhijian@fujitsu.com> <cb0d1c57-7cb3-4434-b6a0-592ce370a4e1@acm.org> <1c7ea752-11a1-4f2c-8b1d-1b289eabd583@fujitsu.com>
Content-Type: text/plain; charset=UTF-8

Hi,

=E5=9C=A8 2025/11/24 14:44, Zhijian Li (Fujitsu) =E5=86=99=E9=81=93:
>
> On 22/11/2025 02:05, Bart Van Assche wrote:
>> On 11/20/25 5:38 PM, Li Zhijian wrote:
>>>  =C2=A0 # Prepare null_blk or scsi_debug device to test, based on throt=
l_blkdev_type.
>>>  =C2=A0 _configure_throtl_blkdev() {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 local sector_size=3D0 memory_backed=3D0
>>> @@ -76,7 +87,8 @@ _configure_throtl_blkdev() {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sdebug)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 args=3D(dev_siz=
e_mb=3D1024)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((sector_size)) && args+=3D=
(sector_size=3D"${sector_size}")
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((sector_size)) &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 args+=3D(sector_size=3D"$(f=
ixup_sdebug_sector_size $sector_size)")
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if _configure_s=
csi_debug "${args[@]}"; then
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 THROTL_DEV=3D${SCSI_DEBUG_DEVICES[0]}
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return
>> Why do the throttling tests query the page size and why do these tests
>> use the page size as logical block size?

Because for null-blk, we want a fixed IO size to disk, and page_size is
chosen for this case, a large IO will be split to a fixed size and
then check blk-throtl will work as expected.

> Good question. AFAICT, throttling tests will test null_blk and scsi_debug=
 block type, the former will
> calculate the max_sectors based on the page_size.
>
>
>> Will the above change break the
>> throttling tests?
> The tests still pass with this change on 4K and 64K OS.
>
>
>> And if it doesn't break the throttling tests, why not
>> to remove the code from these tests that queries the page size and to ha=
rdcode the logical block size?
>
> That's a good point. I'm not sure about the original design rationale for
> the scsi_debug part. I'm Cc'ing Shin'ichiro, who authored the scsi_debug
> target for the test, to see if he has any input on this.

I agree this can be removed for scsi_debug, I think what we want a fixed ma=
x_sectors_kb
for device setup, not the lbs.

>
>
> Thanks
> Zhijian
>
>> Thanks,
>>
>> Bart.

--=20
Thanks,
Kuai
