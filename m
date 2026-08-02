Received: from va-2-43.ptr.blmpb.com (va-2-43.ptr.blmpb.com [209.127.231.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA903ACA7A
	for <linux-block@vger.kernel.org>; Sun,  2 Aug 2026 12:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785672157; cv=none; b=WYAn1SVLilDpBoJp1bXtdeqBTyug+hlcJJ5HPJEx9yNBz7x0rcK7hoq1Cx4qA3JykDbDVvw40AeyWlt2j+CooQ3JiuaPnNPP4yG4CBE035max1ufN7g6T9X6Q79SoFE29KlTjKLh48BDcQU20R/MJv795aq1uLh4l+Fp674KnHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785672157; c=relaxed/simple;
	bh=LAAuzhLxG+xsPO1r7dkaBxxnb0l5JKvRIbu2/c8qYWc=;
	h=Subject:In-Reply-To:From:Mime-Version:Content-Type:Cc:References:
	 To:Date:Message-Id; b=nsachYFA5yO/xZYYOrTfqqZodkfsvGTgIqJidLGbFoU4tRDG4KiuPnWftB9Gu0Yu8OGjzzcNb19weAal6PKxD4TrcHO4VW6fbsla0BGUEr8mcGH8U5xo+lKYrOKkx+RBwpFfgQnVl/WRt3+sSsp338NMUXeefUsWmF86nH6gvHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=h5DECMNI; arc=none smtp.client-ip=209.127.231.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="h5DECMNI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1785672142;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=MiFFY+spkRGm1pSpy6VKjAeXxonzdJqLzZTfS8wrrzM=;
 b=h5DECMNIte/4mfkgvFDBnWycOssZHcJi01ALtDI4fjvCVhT3iCjIwg46JR9zSa76mjHMSR
 Ghlu5GUSCtAP9fkQbOAr6rDViIV//F3pG57qgPUs/D2dawt+TC3dp7X4agnNWAE4sBf6qk
 C7hzcbDK/m2qqqntnuZE1zz9btBC2o8yKIhBmZ5Z5SHpPZir/OCX/3mDhpFsdV5u4cpi6k
 67oW0Lx+lu0xJY2oIfZQcVSwmXeJ9/Qf+X+OpSPpqSRykQrOPhOzLOnREHbYFis7GEwrNy
 FuNz63Z0c2IZwKCzC8+uCqcTZZjDLuwbHkRrfiwZ9y4ogYLvicPlzYuZ1FnEfQ==
Reply-To: yukuai@fygo.io
Subject: Re: [PATCH v5 3/8] nbd: reset write cache on disconnect
In-Reply-To: <9525c07b-f9ee-4a06-9857-0b6c9942ffaf@fygo.io>
From: "yu kuai" <yukuai@fygo.io>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
Cc: <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>, 
	<echo.chenlin@huawei.com>, <leo.lilong@huaweicloud.com>, 
	<wangkefeng.wang@huawei.com>, <huawei.libin@huawei.com>, 
	<leijitang@huawei.com>, <linux-block@vger.kernel.org>, 
	<nbd@other.debian.org>
Received: from [192.168.1.104] ([39.182.0.181]) by smtp.larksuite.com with ESMTPS; Sun, 02 Aug 2026 12:02:21 +0000
X-Original-From: yu kuai <yukuai@fygo.io>
References: <20260730082046.3459239-1-yangerkun@huawei.com> <20260730082046.3459239-4-yangerkun@huawei.com> <9525c07b-f9ee-4a06-9857-0b6c9942ffaf@fygo.io>
X-Lms-Return-Path: <lba+26a6f31ce+2075b0+vger.kernel.org+yukuai@fygo.io>
To: "Yang Erkun" <yangerkun@huawei.com>, <josef@toxicpanda.com>, 
	<axboe@kernel.dk>, <hch@lst.de>, "yu kuai" <yukuai@fygo.io>
Date: Sun, 2 Aug 2026 20:02:17 +0800
Message-Id: <4695b270-3f94-440c-a174-91b6fb5b94d1@fygo.io>

Hi,

=E5=9C=A8 2026/8/2 19:51, yu kuai =E5=86=99=E9=81=93:
> Hi,
>
> =E5=9C=A8 2026/7/30 16:20, Yang Erkun =E5=86=99=E9=81=93:
>> An inactive nbd device may refuse any I/O operations. The nbd_config_put
>> function calls invalidate_disk, which sets the device capacity to zero
>> to reject all read and write I/O. For zero-sector flush I/O requests
>> from blkdev_issue_flush, if the write cache is disabled, the zero-sector
>> flush I/O immediately returns 0 in submit_bio_noacct. However, since
>> nbd_config_put does not clear the write cache state, an inactive nbd
>> device might still have the write cache enabled. In this situation,
>> zero-sector flush I/O will return -EIO because there is no active socket=
.
>> Although this does not cause any bugs, resetting the write cache state
>> would make the behavior consistent.
> I don't think this make sense, at this point nbd->config_refs is 0, which=
 means
> there is no opener for the device, so how can there still be outstanding =
read/write
> or flush IO?

I see what you want to do after checking the next patch. However, since a d=
isconnected
nbd device can be reused later, the stale BLK_FEAT flags from the last conn=
ection looks
like a real problem. So, I think it's better to reset queue_limits to defau=
lt, the same
as add_disk().

>
>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>> ---
>>    drivers/block/nbd.c | 5 +++++
>>    1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index 7ec85f94f742..da4b48ef3c79 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -1469,8 +1469,13 @@ static void nbd_config_put(struct nbd_device *nbd=
)
>>    	if (refcount_dec_and_mutex_lock(&nbd->config_refs,
>>    					&nbd->config_lock)) {
>>    		struct nbd_config *config =3D nbd->config;
>> +		struct queue_limits lim;
>>    		nbd_dev_dbg_close(nbd);
>>    		invalidate_disk(nbd->disk);
>> +		/* reset write cache */
>> +		lim =3D queue_limits_start_update(nbd->disk->queue);
>> +		lim.features &=3D ~(BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA);
>> +		queue_limits_commit_update(nbd->disk->queue, &lim);
>>    		if (nbd->config->bytesize)
>>    			kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
>>    		if (test_and_clear_bit(NBD_RT_HAS_PID_FILE,

--=20
Thanks,
Kuai
