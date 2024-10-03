Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F5C199FC2
	for <linux-block@vger.kernel.org>; Thu,  3 Oct 2024 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727961622; cv=none; b=se66udCMmrXUzZ2HlC1K9/48SPMmEAzbEQ7R6WF9jGYppN0y39xQ1SOvzEeYEOfWkxNYKWGLpII8Go9WzMKhdqcL+KglBdNQdKMPGPO3OLpAPEiEHCfRTHoriokIkufhueRCM20EyPKi1NbsNBBYSnvQdkSq+nMk9ehqkzZZxN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727961622; c=relaxed/simple;
	bh=WD4yKKiKfvM6Y/N3sOKCsh8BIytPui1G2fZUyZj0j9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BMHISCZ5q3L3iOGapv/3NJeXMIe07z7Palpt6h3+aC598TbgUR01K30fY4qIFKR9q+pwbrptvOg3R7cDfbcnwVh2OyIBk6v/azBqDnZIN3W96bnULQbSyKjhj5rZhK7lpBEqNnbP2+wpPl475u6zdyUVsDNZhL9UGSh3DZ4v944=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=r3/B8kuu; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="r3/B8kuu"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a342bae051so3808845ab.3
        for <linux-block@vger.kernel.org>; Thu, 03 Oct 2024 06:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727961619; x=1728566419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7acx50tgt/uVPHLaSIR2NzBWUBzAmiQEE7K7Tpb53+M=;
        b=r3/B8kuuo6PkwuRWs89AKEinEEbNf1LCDmnDoeqw/wTCKgMW//HyVLXjnSE58P+zxz
         Fh4IILpcMFyi6lKyJqC0Rc9VDp77QZ1+wg0/ot9EqIX8z6CFGo/dDr0uaI1DvcVaFgOT
         6WK5W9ubS/51Spa9MqkTifhjdecUFUkKRwt7AOMnvRcVXcQzGT0XE73qtZgTmjdx2lPn
         0Yr9hGFNwYGssy1bsmYRqkfyuardAdX5PYA59xgxjBJDvzW96newK2nMRcXAfAqm+I96
         k805aywYYGMOoN/xhZ23IRzDVLiRIJWeJ54CLq+I37dkVgRiZ3vrW4/7oOuJTLbKuKQj
         wzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727961619; x=1728566419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7acx50tgt/uVPHLaSIR2NzBWUBzAmiQEE7K7Tpb53+M=;
        b=QFmkTHrqJcTNkukWKYa/niE+OsmQPLVJ+Yc5wCAubHXbuY5mkoK+6j+yeyjdFD3Hqd
         ch6sUzUmAUc/n0RdLNVhdxZ+FymwpVJI8upPMXnvJ8o7MhlhQJ2NjRSpB/kdxV1nlnDh
         zhk6hs7xQc9IWNjLQzYPpZdwV8GG04BAoOyid5QzTyv452QQv856zvGzEKYL9I7wPL0g
         FJODeJWguCCgjAgVe+GYS05gGkgDnNfPlfVoeYvv1ThFxNrbDxq6gglvgrrMVteIM3v4
         amfUMikqOieH+QM8wGWBcWXwzQO1XTYCF40MG8a8V8t610CHOurQuMqb4F3uEt3Y0I4e
         sDdA==
X-Gm-Message-State: AOJu0YyQyN+acht8JuNCNjS/vfVM/n0TaKW2qXCee4I4YxwyI3PwOoZh
	jShff0V/SYyZWRjeFcDGcL952WL7mLs6refLF67vuTUtA/GmY2SVMuZUM7JNoTY=
X-Google-Smtp-Source: AGHT+IGjDLJNIN9w3Mk2FVQ8pyAaz2zDdkttdssQRtEsPNh0pQnr3foixacoiNYIhFks5iUt/DMIbg==
X-Received: by 2002:a05:6e02:194e:b0:3a0:480c:6ac4 with SMTP id e9e14a558f8ab-3a36594b787mr63127165ab.22.1727961619479;
        Thu, 03 Oct 2024 06:20:19 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db55a63e53sm262900173.92.2024.10.03.06.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 06:20:18 -0700 (PDT)
Message-ID: <bdf5f4c8-e943-44bc-b9cb-9dd8e726d5cd@kernel.dk>
Date: Thu, 3 Oct 2024 07:20:18 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: enable passthrough command statistics
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>
References: <20241002210744.72321-1-kbusch@meta.com>
 <20241003130053.GE17031@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241003130053.GE17031@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/24 7:00 AM, Christoph Hellwig wrote:
> On Wed, Oct 02, 2024 at 02:07:44PM -0700, Keith Busch wrote:
>> +		accounting of the disk. Set to 0 to disable all stats. Set to 1
>> +		to enable block IO stats. Set to 2 to enable passthrough stats
>> +		in addition to block IO.
> 
> Jens' reply suggest he likes this interface, but I have to say I
> already hated it with a passion for the merges - overloading a
> previously boolean file with a numberic value is not exactly an
> intuitive interface.  Is a new sysfs file for this really a problem?

We can do a new file as well, like iostats_passthrough. Don't really
feel strongly about that part.

-- 
Jens Axboe
