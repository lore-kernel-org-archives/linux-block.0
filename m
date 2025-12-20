Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8245B1DF980
	for <linux-block@vger.kernel.org>; Sat, 20 Dec 2025 00:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766190532; cv=none; b=kbnoVMB8Au38PDPWV+sDNVZLJD8TUDcERcqrWitXARW3BC0H+6461YrI+fMUQ2V3l0EwZSATYyCdRnN0arCdLlQptv42xGyXUsf2rwq0cjPpYklTIQ1h+yO/N1AGQrw+uKm0m1vfLDxbR7lm932ZjLOH01XcszjxykljI2LF4dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766190532; c=relaxed/simple;
	bh=VvJfzkbY6Pvbp5XiLsETEgRs3mPUoGw8r8VQctBm+WE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQGv6keDb/O3neSs/KhS0siC7VhqkB6ifFiru35TbA38A9MafoZET3V33Fa7xV6ZH8Ca4dbzc+1HyRHLYOS1pC8NyU1/+4ubKp0Ana44IE6j+2F5GX3l76G+EV9Bno4RKU9T6f/trPs4/XibeCRrnjst3nn+WuAklWbKjF5fEPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWgXsnqR; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWgXsnqR"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-11beb0a7bd6so4806140c88.1
        for <linux-block@vger.kernel.org>; Fri, 19 Dec 2025 16:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766190530; x=1766795330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wHCkyH+h2SQ3kgDQDVUH0NkMAhmwOMZAgZrPL7+vsvk=;
        b=mWgXsnqR1AZEWIdQYVRgr/pTZac96wIjtu7s6IAziC+r+WDsvG4O9GPVVYrgQEwIKg
         tm80YWBj36EiqRiz0z+suCMaydX1yOMB2N8f0BsPcIjx7pRtR/QQ4REKY2nqtXR0PbmJ
         LrosLWvBIxeVraW8tEY/LwN7mXlryFbYv8llf/yk4lL8bC6rAVsjrP635y1orxwWwt31
         E9i7pdJ72USSJf/EHECZHOXHIGHTNAuTmAVJ24hhhr9Jf6BajLjQs/wgLhoO7SIbShh8
         RP0JHm2r6aDcYpPZQHNg+U9+D8GCWafcygRlssJkRV2qQZ1vtlMwzY75qbfXBEqg/3tU
         eQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766190530; x=1766795330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wHCkyH+h2SQ3kgDQDVUH0NkMAhmwOMZAgZrPL7+vsvk=;
        b=uW+iO+Cr8NKNqndY5oFCgt+eIOA7KjOiH87mpa8eGHVVrYadlwk0LpCZIzGooYsHtB
         tkKqspCb1GjFX2LbBiRRbMfZNLpPCWQWbVR5OlIlf6BDl5OQ+Ke0RX1UWnYvdwR36/5K
         kM64qz2T6KOaXr6yjDsbYzXPj1fb3Do33J8vfySVYEkAKQt3Wr79a4t2r3K0ZMR0hB9z
         7OhpHXuyDB3hhCMkKQP3NypDZDyPFfwANdgbYFNt6SOwQkNrVBVVv5ACg9DWqZe0jNCe
         CIFQ2QpiuKOQAnfwVE28Diz6fH8P7djgK9dEHRYZIXOSfDq3JqY5tAD8hTkKytFY9V3U
         SjIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXASU4cNq4JnoVwgPlz9hGIUlsl4scv8D61TbOrpwQyk2H27Lp+Yp/X58TbPl8mKG0mKI2KoPLUZV8+DA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjgEjIqhcv34hp8UwAyP4x0/CHdmKmb6kyBOsTeMv6PajFGvVV
	j/lciV/d9orKPSjpuSJf2oqmix4mpSTNqZ4F1KUXqDUQG8xoynxfddRF
X-Gm-Gg: AY/fxX5i/m3wfmqBz5xFl16GU+ciUa+8aG/d/Z4zGV+XqOrKKwzD0JuOJm7BoK2Rd1C
	5mOktmO7iHL/adSCv9aQfAnoqmkJnQwi7UBdQIjRK4O1OubxuR1/jBV6QCjpaHbICyNLoULHidU
	KI2beSQeLm1EhQYwK9WIzoSh1lIASMICIEIg7wE5z6jmFtmyKxdDKNe5lRq7BKqmn+jA0En19dU
	bFSmr70AXBwKz+Ok+DN0mGbT1S3C00pyTE8b4j3bQkdHIsLsjSEHDWreJcGh+N9egxIpTCaSCMq
	pOD+S4nimNMh4uLzPqDumOoBSIQ7WxX2R+0Boo6sH7zyHqhrj/6VQku2FCsMc56zEIY4l6+rr0/
	QVfsQVJwR3hrWmX3J1Toi/qB7a2Qb/L9JotFMPtJfJleStGAuw4DrU5TqlHEQSbB4lX8PG6NEgw
	puFPqkre9MjIP+Gvdjq0ReqMoPUmttaMKIeC3htukmlcJC4n7spEn/DN1Mh/FDPXqKhvsLOod2t
	rD4Fib11AcFxQDBpF+9XK6SNSAsnxEEwnQ7ypG04o7C
X-Google-Smtp-Source: AGHT+IEIe82uT3wqmzhkzHDjKZsCjlBDS/hGHFoOpvdoqxzmGNAgG8/YDvFtaipEoWCLmTW22YUSXw==
X-Received: by 2002:a05:7022:912:b0:11b:9386:a383 with SMTP id a92af1059eb24-12171afd92fmr5438106c88.22.1766190529475;
        Fri, 19 Dec 2025 16:28:49 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm14425651c88.4.2025.12.19.16.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 16:28:48 -0800 (PST)
Message-ID: <02a6cf4b-62e7-4361-ac95-533da18f7ffa@gmail.com>
Date: Fri, 19 Dec 2025 16:28:47 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] scsi: core: Improve IOPS in case of host-wide tags
To: Damien Le Moal <dlemoal@kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 John Garry <john.g.garry@oracle.com>, Hannes Reinecke <hare@suse.de>,
 Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
 Ming Lei <ming.lei@redhat.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
References: <20251216223052.350366-1-bvanassche@acm.org>
 <20251216223052.350366-7-bvanassche@acm.org>
 <ac537693-ec0c-4c50-8ee9-a02975f0e18c@kernel.org>
 <dba8da69-1f14-48a5-a540-01e8659b7d3a@acm.org>
 <074e472e-4320-4d42-b4ac-a1fa7585e2b6@kernel.org>
 <ddf72e7a-a5a0-48d0-8714-9f3caa4345bb@gmail.com>
 <52e2f607-f4a6-49ff-9a52-db382333ea69@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bart.vanassche@gmail.com>
In-Reply-To: <52e2f607-f4a6-49ff-9a52-db382333ea69@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 4:13 PM, Damien Le Moal wrote:
> E.g.: "host->can_queue is identical to the maximum queue depth per
> logical unit" -> As I mentioned, SCSI does not define/advertize a maximum queue
> depth per LU (beside the transport defined maximum of course). So Is this
> something that UFS defines outside of SCSI/SBC ?

No, this is something that is supported since a long time by the Linux
kernel. scsi_alloc_sdev() uses host->cmd_per_lun when allocating the
SCSI device budget map. Hence, host->cmd_per_lun is the maximum queue
depth for a SCSI device. This limit is enforced since a very long time.
Before the budget map was introduced, the number of commands per SCSI
device was set as follows:

        scsi_change_queue_depth(sdev, sdev->host->cmd_per_lun ?: 1);

> Also, for UFS, is it always one
> host per LU ? (that would be odd, the "device" here should be the host and you
> say it can have multiple LUs).

No. There is one SCSI host per UFS device and there can be multiple
logical units per UFS device.

> But if I understand this correctly, you are saying that a UFS device is like
> SATA and can_queue == device max queue depth, so we are always guaranteed that
> if you can allocate a tag, you will be able to issue the command, right ?

That's correct.

Thanks,

Bart.
