Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D853BBA0F
	for <linux-block@vger.kernel.org>; Tue, 13 Oct 2026 08:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791879248; cv=none; b=tM1gwAUr2WApBLRdibcSx7OjqMgTGIo4NDsTBQOISPH3zy+/TYpExSYi/sF5gCIkOfLFpLPj42Zf2CPsVu0yEn85sE746gbl4et3D5U8pc/NjgVJSoFnu2WKMpCExTQXn+1oUpKK+9deuNL8Dl29QqzrDSn6gqY0GyZPYRiCELs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791879248; c=relaxed/simple;
	bh=WwRtsX+o3Yc1BZpZy6ImBzyNEsrrxZVX7aPBj0iBNNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+k5U913lyeg8wXJVfh2xXP8KnsgQeCmMR2dl57x5mna8BoqJrTOfjgrPpX7gJKStsSKPKwYWX+hff9YgfrfdKVgkrxKC2mXjD/+zXRVoRaZB8iCcZQR+MCyi0qT401CNCvshRJYZWKmCqNVkJ2JJ+dHHEf8ZdRZ2u3UZfaOz2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ImBbR5sT; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ImBbR5sT"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a1635f7c89so26694455e9.2
        for <linux-block@vger.kernel.org>; Tue, 13 Oct 2026 01:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791879245; x=1792484045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qE8viVfc7wSzykdGhKjE2C5YJHAozDefAUnUohB6XA4=;
        b=ImBbR5sTwRM4cizz08l5eBbwMoNWIKi8p3hYox+xpo2rKz4P7vWuh8n5yyCaJIOHP8
         pe5lPuhmVc7uSK759NRRnpRAiijkIjed8Au8i6P/kl1OnPsPfoXYQUfb8Fsn15f1q/na
         mvM48HMTWxn/WQnZMuYn3TTrpdQQy771sq0B+DNLZkrk/7mzs8c3rkWC46rikUigJOdl
         Vco9M+pNyRurGfmYqmztAZbxokRThCXdUnV3CS1f2pdVsLBSbwz7/xcXaAWihiGbEDyu
         3hAVJOGpgRtfnz3Is/3wuJG27d+/64Bgu/vSvIZX/PH+J29jgAsxKq+OUqrFSO1O9298
         7Wuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791879245; x=1792484045;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qE8viVfc7wSzykdGhKjE2C5YJHAozDefAUnUohB6XA4=;
        b=fjgHfWjxAC5rg69FXFYFxqlASDNSDKbdnoN3Qu4MSSJJto/O2ItZi4c8T1d0FBF9nM
         +lUozrtXYW/W0h9rHJQoUbklz2sifR2VTYCUdR+EpvO0WqdZROPODoP/61JmMafthhRN
         RC0HeObaiq1+y/Ps3zNxA85si9q64Vz1Roy0fHkMhZPwJQ+AIrj/LfuTQB0IcmfUfkZy
         YFw++e/rSqGWlh4a7rtkukFblnCA0M1INhgaBjHM6TQ9CPMQHT0kdehg9qz4WnVLwlQp
         EuCM8K4itPaktpTdUiGoN5GDuQAw1Sm1iz2vOQGqAQMN6y3VP2IJYtqre+bxAXdc/d3h
         EfDw==
X-Forwarded-Encrypted: i=1; AKwUvBx1x5ZsIxwxMFda5To7VBuAjIiC94VlPmlwWB+Dd8ECefDTKvIk7vqeHAsZFIOcK58c6LG5pJKJWTsXlA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKbIqdhXopAxsf0hBK3iVioMNRfjsbX+wgPPGEcvBAw+jtkVGRd
	bkONxC/oBh6cb8NEBEJjuPLyPfqq6EsdnJLuNwF4eqPlR+a1+vxIqCo+VBHrM8nxlx8=
X-Gm-Gg: AYBFou27joQyKpD2tc+vPpRsoASkKqBnNa25S6yODdkR2sjhQC0u9RcEOoYqTRqPgtV
	2m6BPpyy2eu8HtDCGGfSpV7gegscQs/XntqZsbmO0edPX6sj1uYtdXaxO0zgMHpFOyTfHOYNsck
	i08fDnk/al5cM8S0orFbdHqWsmxMBAk+X6K0F1JS1iGPFU/1rHpYM93fuKr4EL20SYF97Fiibh0
	FubsrxM9kiXtJz5NLXmf2hWmFwNlU2j0EBKdvkEyTU4I2IBGYjGNkBMrGheRjH/OqpdjzOZvKnn
	H0VLQgsSKDqlqAOvKn8s8Kznwr5VwziDs0J2W9tjw998MpmZnWuHq2fyJYWfZ+VGrfiTxUvmKUl
	ljAL+SEPH5r3mEB7/LkRnpH4jvpP3LV1upvXQMW1lo7o7/p3UAjIE8qtpP7/xDf9K78/YWoQR3r
	Qe3Ds2pk7RoO9JzLVMAStgIcYvY9fOYwBlrv5MEO9ESoCRKNmR6IkYqaQujEpaVT6a9v6ROKfcG
	0p0x2c9M3tjs8PgEaQi/7x+ULvXbkGc02AEFvcg
X-Received: by 2002:a05:600c:8106:b0:4a0:c02:938c with SMTP id 5b1f17b1804b1-4a18e4d683dmr203452395e9.25.1791879244612;
        Tue, 13 Oct 2026 01:14:04 -0700 (PDT)
Received: from ?IPV6:2001:a61:13f5:2701:b3a3:b9f5:f3dd:ee85? ([2001:a61:13f5:2701:b3a3:b9f5:f3dd:ee85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1972eaed8sm233812305e9.1.2026.10.13.01.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 01:14:03 -0700 (PDT)
Message-ID: <2207cca2-89e7-4694-b903-aca15cec1edd@suse.com>
Date: Tue, 13 Oct 2026 10:14:02 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [usb-storage] [PATCH v5 1/2] scsi: sd: mark disk dead on surprise
 host removal to avoid I/O hang
To: =?UTF-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <mkp@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alan Stern <stern@rowland.harvard.edu>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Hannes Reinecke <hare@suse.de>, Mike Christie <michael.christie@oracle.com>,
 Damien Le Moal <dlemoal@kernel.org>, John Garry <john.g.garry@oracle.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "usb-storage@lists.one-eyed-alien.net"
 <usb-storage@lists.one-eyed-alien.net>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <TYUPR06MB6217DD31B1B3CD09E431CC12D2922@TYUPR06MB6217.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <TYUPR06MB6217DD31B1B3CD09E431CC12D2922@TYUPR06MB6217.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09.10.26 13:29, '胡连勤' via USB Mass Storage on Linux wrote:
> index a1b21ea14e54..98f861fb7e80 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -4272,6 +4272,10 @@ static void sd_remove(struct scsi_device *sdp)
>   
>   	scsi_autopm_get_device(sdkp->device);

Here you resume the device

> +	/* Device is gone; avoid sync_filesystem() hang in del_gendisk(). */
> +	if (sdkp->device->host->surprise_removal)
> +		blk_mark_disk_dead(sdkp->disk);

Here you check whether it exists.

That seems a bit inverted. What is the point of resuming a device
that has gone away?

	Regards
		Oliver


