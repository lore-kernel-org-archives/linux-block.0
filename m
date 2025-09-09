Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25EF35336D
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431697; cv=none; b=pBlQnWFN6eZO2O6Vj7555KQixrdcHmvTaK9Pj8MutpRXuhXaxT7L6n7aidOlAO5C3x9XvC+K2ITqtsTgAFnxzgFtBWyhd/CV+T9koZUlTSO2v6PbtJhSsSfVJXIEXyfwuERo5dBJxwDfIn1cM5pIr2M2aDEo1ydBdhuu3KnjVaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431697; c=relaxed/simple;
	bh=zdmMTS66pDXSVVeEoILIIh+RFkwTTy3dD9US6WLNHvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iicBK8msw9yqIo6JzAk806sVyHbCjrsXl6A8tWx83XAnfTVArW8JpeuEIoYhZfBiSnVwfXoecKbLkIaBYGSLTFfH2j6y3MlgSJhVrwkMgqL7WGjM6/96A7xpBrwDa2GjP9cWNB11tcmbEG63EBvqimN5rx4o11PcedDfDDRL/DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WnE546bA; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WnE546bA"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3f664c47ac9so31538505ab.2
        for <linux-block@vger.kernel.org>; Tue, 09 Sep 2025 08:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757431695; x=1758036495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jN1Kj7K7CkcC2gypxZGow6Wd+LfV+1NytZv39KYFilg=;
        b=WnE546bAGlo5G+8fg8jwTZo4lmsOMgNuGpIiLHtxNJ8GJ7O3Po14xHWH77y80XNtmG
         TjyfjohcywWIVVHmy70qFv2w4685MgZSg4ec/xc39NOAtoAxWSPJW4CGL6F+V+G7Gvaf
         Uf0d+Lv2fg2cqeIdD+0ln3wa0nCHnoZiImMzinbEyh7DIzvILb7/oHvq7mTtEnBPSVxK
         xH7m4MlU06X1aUwaV1vcjgokNNf8wScfBjQzp50AwKwqMk/SSowjDIa9N+t4o/00JiJl
         W/kIGX4EKBUjQktsif9voUWtpzY5ruvCxLcJM/H7Sfs12ReWECAitqF9zdhiixW5xgGp
         xPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757431695; x=1758036495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jN1Kj7K7CkcC2gypxZGow6Wd+LfV+1NytZv39KYFilg=;
        b=db165b6lwoDmibuKE/FJC+3uhndhieJZs++mvRL2GMPNb+sGJD+fzWxFkn+2691YEA
         rIOl8pr9ptexdkm9Weu73ndkAJDzb3sE43JFj4eQxEhuYXo+BjJOyL109BKDppCPmL6d
         5QVRgRosW4fzxOWaFsWkWBbOtjOlF3EttxghjdDJknm8+n+5X3Gyv7HFEA99D4FHFSpZ
         dqBgc2UAqlHw6yhFIdYy9nRriOMMeR9VnnHAXAWyhqTUBNyFhxrYdwWuE+wppBMER6uA
         ew9wgiRtQ5KyvahUgWV8vZnhoV7I9GeoxnozshJto+BWaB4jU+P94VvEjkLUhUcNpF62
         jW0Q==
X-Gm-Message-State: AOJu0YwUW4W8zjdS4y7KYJwzWJYuOAYk2rReWHSFMh4rrnM/bLK6QsMK
	2D7+HEmhGHlj3DM/e1FMicWAr+d2JFpdoxj5QQpK6EijdD1LJHCd/QURoN+JXhQ4Tdc=
X-Gm-Gg: ASbGncvN23/oG7LOqkYX7C5bK9g8/kD5X3PDu61sPPEld+fNQgeLzAtpqC5Eh2N2vKq
	G1XgnLvvyAKsER1BU1+y26FLMSKJ9tVrX/gttOQ/0ToQH29GOUkrqKMPwYvDpZq4BEm0WGW7ozW
	JRp7EAoi6gb0jRUAe5z/Ic0ZdTyMxCVZ3T0iN9a3Bz1nVjF8iFYeqdYofgb8Gtv94ozOgB7+7lW
	C6R6sh9wLCukzv6jfh7EqjqY1qhqc8Gv9upIYaj/Yg8mhsG9Ec21VhXfbADCDG7ByrZsQ6zMu/6
	lmUhG0bap5tP6MxM5i1yCU/4Qfrsl6yEwXEpp13aKLgb4V6t306BThZI60HuMd1Ik3hr6r7Au66
	Q6Qh56wXIe1IiSBYhHuDhIDjuDeexX2AccsE64IeI
X-Google-Smtp-Source: AGHT+IHxQYn//P6OlMBv4Hjw7zsJ7Uk1Uew3KWJj5QRX2MyObcGnhrIGAx1/Aj6Ur5T/j8o5uW59sg==
X-Received: by 2002:a05:6e02:1d99:b0:3f6:5e25:a5cc with SMTP id e9e14a558f8ab-3fd87781510mr141362695ab.23.1757431694832;
        Tue, 09 Sep 2025 08:28:14 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5103baa86e9sm5847043173.9.2025.09.09.08.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 08:28:14 -0700 (PDT)
Message-ID: <165f4091-c6c9-40f7-9b41-e89bfdd948cf@kernel.dk>
Date: Tue, 9 Sep 2025 09:28:12 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 00/16] block: fix reordered IO in the case
 recursive split
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@infradead.org, colyli@kernel.org,
 hare@suse.de, dlemoal@kernel.org, tieren@fnnas.com, bvanassche@acm.org,
 tj@kernel.org, josef@toxicpanda.com, song@kernel.org, yukuai3@huawei.com,
 satyat@google.com, ebiggers@google.com, kmo@daterainc.com,
 akpm@linux-foundation.org, neil@brown.name
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Can you spin a new version with the commit messages sorted out and with
the missing "if defined" for BLK_CGROUP fixed up too? Looks like this is
good to go.

-- 
Jens Axboe
