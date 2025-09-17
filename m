Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCDB3043C7
	for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115319; cv=none; b=AhRhi3oUjHhEQXzvZxSzWvtUcOeaaqyofh68jqvCuzHrRvb0T5hh8jpQGGV1hzDKwcN8/L7m89cLrhfRNiqUChdaBLTH8hUCGVJh1NvIQjtaZbR9AmGw3vYHpyo6kE0L5QvytwxKJJpXiqmF0+0l2pAKy8pfJplwWeZ/oeTVDG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115319; c=relaxed/simple;
	bh=Nmr6lcv2CNDyGpXvoHn0q/udjP4zcmNWEvHXekPMVL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jI4Ynkry1Os9M26fqujrROk6/HYIuUy9CMA3UMQFkwhcHa+ejlQNPuGaKG8Qww4faGA7nFyHo7lD8Jfa7iha2t/uQt7j2vGCzJpXx8ogriWSF+mApkFIpWcK2U68hapnzNWmAZWWw/+m65kLYqjjJ2iNd8XQjUjW0AMzkOsrko4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CEL5FUxU; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CEL5FUxU"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3fe48646d40so5165545ab.0
        for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 06:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758115316; x=1758720116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dMJ57nRyP0a6b1BuiyGtLla26Abwla3P9duCF5wfULw=;
        b=CEL5FUxULkusfYT9Rrpmk7M2gA+dv7m3CZHRyf6nUciIeHfZ3tVOWYPBG0S5V7D8cJ
         XO1kaBDS9r1x3ZQPW4ATJmjIjp+/obdVkYiEIrLzi0GtbzYiVmk6bd2SiF+0C0kgkywS
         43dcw4bekYVLLzO4nvdehLz5ruQ1oUd7Ws50ozuRFFwLE0zkl8jYjM+FofedrtV2Ocqi
         abqUtNTvDN3mpxaD36WaF1bIyMubRTgG2qNBUd4Wu/Lnvm6tjJkosz9AwVPvKleHtHlL
         OIR6YWBCDuBuOXTRdf3gauTaKQK+cZTX/t41voZgN/KLATk0+Wo5T0CDkvhD4IyJUFf+
         53wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758115316; x=1758720116;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMJ57nRyP0a6b1BuiyGtLla26Abwla3P9duCF5wfULw=;
        b=o8F+5eP/enFR94hi1tgTJautuIpQ1xQdimMKeIkM2Bpk4XTtBKlx9qrt/ltrrENB8L
         FHhg3BsIc8DYPRqb/HEvdRiMmuV5a62QbMI16QAZoxiPkCy9DuxHVMYu6fWrKSBHyKw5
         Q0VesPwPYbQ88A9NCJWos8cS9dU/Gl54RWDTMKfGKTed0zRTjgvbf2PqpyUADijTr0q+
         PVIwnabD1Cfe4JFdUP06SfuxhNlyrqavrPT4Gb+sl8cHFZMUWDqTeJ++FMbyhI5bLM2x
         0vwKP6Uq++tqGGkN8W6eXE8osaLURn3RlA8yp5GhLdPC7EiO9cyYyekb3fBzoe6W+Gx6
         Ffyw==
X-Forwarded-Encrypted: i=1; AJvYcCVw5f3FNUB21VZE0wuKlNib3aNRhn3L1JvCZHVu67Xjby2W6Jwne4HpjAM9N5rRVPtgBKmgUCH3r3LY7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yys9J+TigSUKxCavNQGT9g+UX8IU1OKXLiP7dLUSxLxk9OjQ+/6
	ahsPwfWJpeOXnxy6bMyJAqJTL1OOz4EQExDUAQV+CVwuQglXOVYvBNFOWKHwad7+WJ8=
X-Gm-Gg: ASbGncuVPFLQQJPR2CDnCPqzZYzmdHRCq1dzAmOR1oMFav09HSD6dubo8DlQdxG8huZ
	am0eM6U6MnZxMnieho8tEty5+A8bJruZk6jAweNskUjlxIWzuu9dlnFdjWX67b0WNrVNUDKoVaG
	rYYekCQuRy1l7k+kFpEvxv7xtIJL/9caFK9yZf8jqoDLoXeEIu+a++mAMvF6SnJfUQl4B6erF3A
	hc3MFXCc2l50OkH4t0etIlFMVyti7wNrm1Oct66C/G4VjTSXwJirtNgTX6CnbLnqcZJua7TPWus
	KkFGPgTPiwjRRGpn9K8kx9mCHJCA9EJ8wMBUyKNfFbBE6gpWlpmrpo0/jXgCqeQdBDNHRz68ce+
	QlZObUJWyLS+EOT9YrUc=
X-Google-Smtp-Source: AGHT+IHSpzOaWwnFlZgfl4JfEV7AGMMb/I3wng29e2F7j8UdqwxsOuC6KxjQOdtNGivJ3EwBqX/aVw==
X-Received: by 2002:a92:c242:0:b0:424:36a:7b00 with SMTP id e9e14a558f8ab-424114f2623mr52787045ab.13.1758115316438;
        Wed, 17 Sep 2025 06:21:56 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-511f2f6b4d6sm6916133173.36.2025.09.17.06.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:21:54 -0700 (PDT)
Message-ID: <d334cba6-bc9c-4da0-8e28-672632d70188@kernel.dk>
Date: Wed, 17 Sep 2025 07:21:54 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] md-6.17-20250917
To: Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org,
 linux-raid@vger.kernel.org
Cc: john.g.garry@oracle.com, yukuai3@huawei.com, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250917011056.1843135-1-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250917011056.1843135-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/25 7:10 PM, Yu Kuai wrote:
> Hi, Jens
> 
> For 6.17 on drivers supporting write zeros, raid{0,1,10,5} are broken and
> can't be assembled.

Pulled, thanks.

-- 
Jens Axboe

