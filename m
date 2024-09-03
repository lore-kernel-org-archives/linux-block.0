Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26711AACA
	for <linux-block@vger.kernel.org>; Tue,  3 Sep 2024 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374837; cv=none; b=AdP4ugvB/gJ0Jkm94/MWBskGN+tjBwIs9dQNqVgiDKrdul7tECsDSSt5ouP6U0Of9sel89kQfvXqbxAvmAvMaK9sXnXhV+F2gVhDShSO3cWOmWbDrfsT6g814e494ZYTM2EdyM7kjVd4ZbNO0tIBm6GeQBKuH1QbYqX9JeuUsLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374837; c=relaxed/simple;
	bh=xSz8B53rf+QzRPU3cuEAjx1UneTEcNz2pfUv/oMORxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n8da96RPvq9i7a0pXI7zRsqtbjJrUWA1tIdEAJiFeir2jeqwnTTCk8AMpeO4GJZs/+gYinn16HWj2S3yI3fJtbkeoRuu+BmkOB8UYzSWb8jjV4K6x1ez/FjfpnNazFFmSJ6g1Ze0VRSDz8o1L69lRpV5AL9vd52Kuhr2RO33lhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UdjfcTS4; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UdjfcTS4"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-715c160e231so4534609b3a.0
        for <linux-block@vger.kernel.org>; Tue, 03 Sep 2024 07:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725374834; x=1725979634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ajeI2Xr7CqyaAqgfiHTgHpuagcScqdiRqWE+LOfyYIU=;
        b=UdjfcTS4gRWD+PV9LjJEkNPNcooFE8bCvp6U+K5nHJ97LcNn4hUTuP0l4LQnMOQJ+f
         Kg01Lo9Su/VAYJv+EBXp7yfyguM6IOr0wZ/b2aO+Rg2MVx0ktOJxpgJ30azw0CeFkLFU
         DguE0kYPpnC+XbfjZ0tvoiigMTFGqn2iJW6wMXGWgFTZgeepS8HQk/uT45aTq2U/HAuM
         HKzaxFKa3K6Ig8d8gxG7LSzaxDCUXzTon6C7JlN9tila6KF7KvCxBbyaMFRA85jjilvV
         IX4xXS5+f7JEBDnfWP80GRgid/m83Q7cWeWHgX3ALQDR2dN4yqHrHezWizzzl4hljEE/
         W+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725374834; x=1725979634;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ajeI2Xr7CqyaAqgfiHTgHpuagcScqdiRqWE+LOfyYIU=;
        b=ZXdUdA7NiwHKvhN/E9x/E6S+KXA1Wl/wA7yeCABqhCBxLPr8b3Mgi4VtXKNQptOwZo
         9AFNY8zvzfkb2NnzWwMcLSoYyw5S6m/oOxVoPRuz3oCyIBdLaxihgj1SCy61RKJkGDwd
         65Mp62FQA6dHUjRAXt3VgIvOLgjIMpsaxswso5NVJh8ckmm389N/TxWJkpU5r5jIEFWf
         oLl1C689f2Wv+RWATbnkOv32XoYCD99azh05g+dKl4PSP35MsyfgTr9HBeVSsknL9uNA
         oIRDZPrfGshdQeqTAt1p+aNtrXPNFN2GcS2DcI/YHT6q4blBNneoOOHWOoGurgMfYFqb
         ao4g==
X-Gm-Message-State: AOJu0Yxy+hl4PIov4+Bpb4z+aQI/ym+ryA0Rx2WhuZ4bfbEOTUqV8kTK
	KDUyHKX6HCCAKpynubIl1IEXtdUn3GLdJkP+JlvTvPBt1WJSxWoYoEO+jc/4OwI=
X-Google-Smtp-Source: AGHT+IEVpTVZQxX8y95gWtwI56jNBbybBFM609xPsyFu6tH5jpeVhChWUZ0lpZKbMNRhzjQ+ab73Rg==
X-Received: by 2002:a05:6a21:9103:b0:1c4:a7a0:a7d4 with SMTP id adf61e73a8af0-1cce100384emr16737901637.7.1725374833759;
        Tue, 03 Sep 2024 07:47:13 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e743252sm9245597a12.15.2024.09.03.07.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 07:47:13 -0700 (PDT)
Message-ID: <3abb351b-64b5-4a11-a2c6-5dbb43ee98b9@kernel.dk>
Date: Tue, 3 Sep 2024 08:47:11 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/21] mtip32xx: Remove redundant null pointer checks in
 mtip_hw_debugfs_init()
To: Li Zetao <lizetao1@huawei.com>, hare@suse.de, dlemoal@kernel.org,
 john.g.garry@oracle.com, martin.petersen@oracle.com
Cc: linux-block@vger.kernel.org
References: <20240903144354.2005690-1-lizetao1@huawei.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240903144354.2005690-1-lizetao1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/24 8:43 AM, Li Zetao wrote:
> Since the debugfs_create_dir() never returns a null pointer, checking
> the return value for a null pointer is redundant, and using IS_ERR is
> safe enough.

Sigh, why are we seeing so many odd variants of this recently. If you'd
do a bit of searching upfront, you'd find that these should not be
checked at all rather than changing it from err+null to just an error
pointer check.

So no to this one, please do at least a tiny bit of research first
before blindly making a change based on what some static analyzer told
you.

-- 
Jens Axboe

