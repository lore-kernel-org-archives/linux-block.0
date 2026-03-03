Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C472848BB
	for <linux-block@vger.kernel.org>; Tue,  3 Mar 2026 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772522378; cv=none; b=bjNbsN44WtsZKUn7NHZqBf7VIQpGUHRR77D2sxRNIdRyCBnO/Ek4Q2Mj1dAISmTo/Hf4FuxrYML0JBnjnmpkU6k6yTepEnnQsgTU01nQ8QC0Yd2r44HYhXe6Fxqg014uyv3hqhsVjYT5YSotaI2lVRB+4JDwb2Z2Rr1feCYlYj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772522378; c=relaxed/simple;
	bh=CwpYG7JVqX3mAprWsx7y8qvWB1SdKDYQNXQBFtdWS/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hp0/t8hDTfHoeeVnGuY8EYBOdshW4vKcSw/2bAkGB9eUfnpruJG+Ir+xHG4tkSyNnJn8NbWZInxC2ivlw72Vw4yd5sx4mZL8q1RC6b9U7YFIJIT8mqNuOFaBdZxcpac6ipC/sE4GvpPTQ39cJg9bRy/MUpY9trrGlXn4/hTOeGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WjTAwvaa; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WjTAwvaa"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso47701365e9.3
        for <linux-block@vger.kernel.org>; Mon, 02 Mar 2026 23:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772522375; x=1773127175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=emzxcalxhefyJPtrnF5BVbzsZJUc4QzYRAPUO5dkvYQ=;
        b=WjTAwvaauVuzzJx6YP2PK71akBqEIUvswWoXuw5jL9qpnfw+GjeeBMgI4/DbuJ4FlH
         xDEW2FQYO3XE9YAOamNyo1FCBQXORgYL2yy56UmQRM3eOzAkxgsQyZPqtH5rDehDQHXY
         dNzOeYHOf5icmac+w7lSNv/9WQPk/aZLzwK9B8oiWyFu8C23AiatmSyCyyBarYp7TGZy
         7qyd0mvjEHhZtGAiP43s02chKqNLF4BgMdNbaBG4Kjw3wUxGRE22+wmTnnSfHRhQS93w
         ZkDnjTRoNpTQNYYIM6CXpTj2kfXcS4nnWwMDd4kN6lCeZwccNlI1QRSdXJNmX8IhA8x/
         Fv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772522375; x=1773127175;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=emzxcalxhefyJPtrnF5BVbzsZJUc4QzYRAPUO5dkvYQ=;
        b=aIpByPueFhQvCLGF4chdR2FkKuyPee2skYgJMJeg997bIlNm2XfYjKzl9SkD+ri+C1
         dBbpESkcrrsOnU4PGfKhO1PIPljZ4waXIDWyl/WRF8tBw0y6giVWjaaksRgwvOD2FnPh
         6r5r0mocFrZ+FSGxucqobFvCkn61WBXWoPeV5PrbQ9weTVgpCWEfZLGGSl9wAuL6w+sv
         cBU5HunMP3u4ov5jo7RZdO6aQfQ7JtGd/yrBJNaRSkBqga6F3QX69PKiGUMQf8oG1M6h
         EuHL7lnMvkiZQpshJT+OXo0wtNtTthhMOhbHzZ4rdjYZAEqZGuZQawNbMfLtmFWcUm0A
         UuZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXyssPu91cq1jXcI4eF+ylpKIZ1kdNP61tAGWhEaHIMEkbnSVN4M26J0pQ6gsEfNfrHrNXfURBZpdYmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZhtZEvUbqOtze5zAlwy/vXl2PfOhbK/IG/sgTQEJaycdhe6+5
	jlCsbYbuihEdjE1YFIdEfZozvejVAFRRdUBLmhtqxA1fyw+MU3TgZm7fFLqHb2i7SpA=
X-Gm-Gg: ATEYQzx2UsioaIRrEMKHIPfUfS0osgJAfCQzn77UXs8u9OqzI9PR8Z3Gly4h8WAQnPc
	GIN75rQilmuBSDrxjxXOmw4jB7PgauWuXuX6D+R5phihS7xGXTXifSmevbkYVbWgPCppZVR2TxJ
	4sxZg7duyCsEIHsXpAugOeNhasC+pfGo1l1oSR9r4e3wYi6kp305G4s9kuUarE1Kxxz0zSEc4Ka
	UigOZq44AKwgSBMNXfK5I3I6ZfflvIO0T4/Ua8q7uSD3AbGD8EsP0MW2HH8rvn2lHSBujoKAaCH
	Cj+BqwydO52loHDoyrTJbhQvHPS7mvHB90fOXTBEBSRbidPMdb+OdKAd8aLikYs4aTIqndPI/6s
	5T06KeJpkw9jR6dkXs6aWEghv2wYIoubbyONt3XEYDh+vPte8RRYMnfurtyX5daVfbJXbPNVr7m
	FGnNUVC20otOelVUcff08IAb8l8/CTMs6gatpmqM9U+K1fLhz+kSVwCUZSUl+pcqbYbA==
X-Received: by 2002:a05:600c:1d0e:b0:480:3bba:1cac with SMTP id 5b1f17b1804b1-483c9bc55c0mr240863065e9.6.1772522375015;
        Mon, 02 Mar 2026 23:19:35 -0800 (PST)
Received: from [192.168.178.47] (aftr-82-135-83-117.dynamic.mnet-online.de. [82.135.83.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7030b9sm370239755e9.4.2026.03.02.23.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 23:19:34 -0800 (PST)
Message-ID: <3c173449-bad5-4d74-bdff-4fc9fe4df566@suse.com>
Date: Tue, 3 Mar 2026 08:19:33 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/24] scsi-multipath: provide sysfs link from to
 scsi_device
To: John Garry <john.g.garry@oracle.com>, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com, martin.petersen@oracle.com,
 james.bottomley@hansenpartnership.com
Cc: jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, michael.christie@oracle.com, snitzer@kernel.org,
 bmarzins@redhat.com, dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260225153627.1032500-1-john.g.garry@oracle.com>
 <20260225153627.1032500-6-john.g.garry@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260225153627.1032500-6-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/25/26 16:36, John Garry wrote:
> Provide a link in sysfs from a scsi_mpath_device to member scsi_device's.
> 
> An example is as follows:
> # ls -l /sys/class/scsi_mpath_device/0/multipath/
> total 0
> lrwxrwxrwx    1 root     root             0 Feb 24 12:01 8:0:0:0 -> ../../../../platform/host8/session1/target8:0:0/8:0:0:0
> lrwxrwxrwx    1 root     root             0 Feb 24 12:01 9:0:0:0 -> ../../../../platform/host9/session2/target9:0:0/9:0:0:0
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   drivers/scsi/scsi_multipath.c | 45 +++++++++++++++++++++++++++++++++++
>   drivers/scsi/scsi_sysfs.c     |  5 ++++
>   include/scsi/scsi_multipath.h |  9 +++++++
>   3 files changed, 59 insertions(+)
> 
And again; just what I complained about in the previous patch.
Still not sure about the naming; 'multipath' conveys to me
the opposite (ie the multipath device, not the devices which
are part of a multipath device).

But anyway.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
