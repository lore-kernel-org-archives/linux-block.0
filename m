Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359BE3BE154
	for <linux-block@vger.kernel.org>; Wed,  8 Apr 2026 12:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652956; cv=none; b=hXZGLBhzdhkR3Pk3jPjiEMQFtI4yd5GPYiRUI+qhZlvkbKnlT8uah2imMrtFWIc32nc2c1VE3H1sq0y/jr/K8UJp9zkno+PvqqrujB8KNEiZefOJUd3qPzJ4uBsujYnoI8qHsb53/6zYlXfTY0OmMjCrVEGdz/qkakvUGf0ZsIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652956; c=relaxed/simple;
	bh=OIKABSBSw94Ku6fqTn1LdS0SSYTwpVgI9+avoe/SidM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U8JaO03nn+bV/CuRYvZHLPWOTnFWopUVTa4deJyiR5RPA3mRhcpL0o2xIAHvqcrOU4BOFa8VYw8hh7wv7l8kQ+83PexsRSTrhJ/BwcaXRHGlkcDZySd4/o5qBh3RawYfGSTaDlWjqqWH17k+zTcDHxVm62MaHAx1E3fntLr1Y8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=ptlwuXPX; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="ptlwuXPX"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d55b97f358so3987205a34.3
        for <linux-block@vger.kernel.org>; Wed, 08 Apr 2026 05:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1775652954; x=1776257754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iow//NWmkJUNLbZIPpYAtHvNvwATWc5t7TqLz0HDhJY=;
        b=ptlwuXPXmyvy9/V+JQkfFcUO7jPKtT8eEzwHPzqgpONZ/mk9wzXDx2c/sNh51hQmLK
         6ISxO7TquOo3ftSivBRH5/xCRl37p65pGfw8fKml6zOEVA4QISnJtIY4EiEr3QkLHcxn
         lROWeUmWXaDVcallTypi8Oq1mfARLTk1c6Vpa66JjKDyjHZPrRmDnGem75YKtsVSKuRD
         mHgxdwy6zgU5CnYoGlnPkXtRTGllNhbxFmhbok7RfMBhocFbsG6uzsNj7YPlfIGb7uPQ
         dlGSZQoad9R4oTb4B358uEnMOR1OdtG9PmP9VMK7QEpaCX7GqFd+RpCRbb++zVYPyb5z
         7ASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775652954; x=1776257754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iow//NWmkJUNLbZIPpYAtHvNvwATWc5t7TqLz0HDhJY=;
        b=bmDsYR300k+AN/U+iqFgFqmd+jmgRonoAelCx1fIKpmzv800N4oQVNXVULvhcVnuc3
         7AsenDU79Ky9gdv/NR4cizFZb2hnG8R9JLTJI5p0AD8bzDs9oeY84DxR1gJ4HV0YQ+sY
         0AkmsplXItwD0kP9v7RnmY6mz4fj/Sh6spCac49SRnTH3oULSm3Y6e3WPICwMRovmR5K
         WO9ejx590mQ1GZ/O/mKa4ATEzHcJYf/ryAjceocfgh8He3aNE6kDG9KCZrs7+wLXZlXH
         I36mVMgtIexz2LLxPk3UeFzZowpIJdNgT3UQtLh+kjaluSmOIYU+iXmxwxDiLI+JVn0b
         o2/w==
X-Forwarded-Encrypted: i=1; AJvYcCUFAy/YzNBJ9LMQ/aAOxOi/VyfRXCtd9uLQ/iFOgj8rIAhX3XJg/nxiuJvd9TVvCM03sIM0CagAwJiCzg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1YAOuV41i0AvzTnF5Z55iDMWx8DUx2LPOSH4nz9t/xNmN5JVB
	c7qOJG5J/vXWoN6tRhUe27wPdPNqe7QNyS2ex5I/nXFNgIA+APiNbM7r3lWn8/Ct5wM=
X-Gm-Gg: AeBDiev+3fBeA4nDCVooLsD6jAjgiWEo+AgyS7j+CF0L61bM1sUqJgl9OhZTFXaoYjR
	VPJHW5AVZ7wtHEQ6yOHXHdODjCpIEPeHLgMKyMuR6lnpx3/lcOfChFaiXIsaGcLOJby21+CxFg+
	iiSL6rLW8trTbUuK8TR6rpRDNj1AY+msHdtRbSPsIpvdA/uiDnIbHDyAmfpn+Mbmt18RJthaifg
	irWsL2zXTvIrn+w/8YCiy6ZAJJFYrlqJb+vTZlXH96Hd8ro4Nz1bAjziTxTcHFdkVZ2Vsa7Im82
	8mcS81irF7eMfHcYiqLREWiuOqHxU1NECHs250yNHPTmOGiAO4kjuYjRQrbIzbHURUGu8Zu1Ds7
	Rivg+ypaGjX/kGsVU2ISkYVxTJwdNLCY8Qcm+RnAskRYilEW1unNs39DzwXowSZZ9gDV+hoW+EL
	V5sxH52lutSBY3tzYxH7YRoywlznWfcfu0ADmNBZOAV1V/RX48VB1PT5ifpXXVUzYonB5dN6WQl
	ZbMTX4P8Q==
X-Received: by 2002:a05:6830:67fa:b0:7d7:c87a:4feb with SMTP id 46e09a7af769-7dbb730ef6cmr13869376a34.30.1775652954155;
        Wed, 08 Apr 2026 05:55:54 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dbb6c02ffesm11588038a34.10.2026.04.08.05.55.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 05:55:53 -0700 (PDT)
Message-ID: <82deb095-d259-40ef-9e5d-c9542c2ba860@kernel.dk>
Date: Wed, 8 Apr 2026 06:55:51 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] md-7.1-20260407
To: Yu Kuai <yukuai@fnnas.com>, linux-block@vger.kernel.org,
 linux-raid@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, song@kernel.org, linan122@huawei.com,
 abd.masalkhi@gmail.com, chiamingc@synology.com, gourry@gourry.net,
 moonafterrain@outlook.com, xni@redhat.com
References: <20260408050517.2109269-1-yukuai@fnnas.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260408050517.2109269-1-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/7/26 11:05 PM, Yu Kuai wrote:
> Hi Jens,
> 
> Please consider pulling the following changes into your for-7.1/block branch.
> 
> This pull request contains:
> 
> Bug Fixes:
> - avoid a sysfs deadlock when clearing array state (Yu Kuai)
> - validate raid5 journal payloads before reading metadata (Junrui Luo)
> - fall back to the correct bitmap operations after version mismatches (Yu Kuai)
> - serialize overlapping writes on writemostly raid1 disks (Xiao Ni)
> - wake raid456 reshape waiters before suspend (Yu Kuai)
> - prevent retry_aligned_read() from triggering soft lockups (Chia-Ming Chang)
> 
> Improvements:
> - switch raid0 strip zone and devlist allocations to kvmalloc helpers (Gregory Price)
> - track clean unwritten stripes for proactive RAID5 parity building (Yu Kuai)
> - speed up initial llbitmap sync with write_zeroes_unmap support (Yu Kuai)
> 
> Cleanups:
> - remove the unused static md workqueue definition (Abd-Alrhman Masalkhi)

Pulled, thanks.

-- 
Jens Axboe

