Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F041F4297
	for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536145; cv=none; b=NymOGJwODqZV678hLf5osChUxrpnuC53OmQiunec/Jz081Cm/mhVqOcwpOgIjxps9I0rqvtwBRkgivFtFWkE3TiqpsERXXGKVqVhqCi3gql/RcZg+rp4kKLlPXlP75yZXo5k7Yc1onzHvjMpbgGCx3f8AoOkv+S/heWCPSP3TnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536145; c=relaxed/simple;
	bh=HT3gj1u7/nvYJA/61kS1+m+QfDqb7Q7pkezqn8FKGMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVd9Dy3FD5p3odwAmoLqSG+77b5O0VQXBI/rS9pFRhXEST709vCs4TG7cfxdsNL8LGJwHb/xZwGxJGRC0Ichi3TprgDJSc+6DGRNTmi6oDnVv2SJKiXxkcMtDibdf2v5uYPkYIDyt5qx+OTZkAeQeXuqzWwp09dnHfj99XV3qwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cAJz+po8; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cAJz+po8"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-930cfdfabb3so47706039f.1
        for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 06:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1760536142; x=1761140942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hMbFwwV83Qg+1jJmG0XLxD4XrkMFEdpohch/EjieyXc=;
        b=cAJz+po8XfTlLeos8FYrvs7LZMUVhFZIzIxzeCKu4S9lI4/HNbvDix/xtXKXDVcHuI
         0ijA9DLqcwSrpYZS8102/PlYcbqu5J2wOL3vIBSSFNgLfAtJDhibe6QkuuyouACzUIj9
         vRu+UNH9iO98OZB/jneHmvZRxLP1ziWatQKru/nD3zxDebplI9StuJMb5YhliqRJYbar
         xk4JGtKL02P6IEf5yzxBM2xilxZdGonkAUsAMa4T1gMljdFhISPTqGohtfIn2Q2lW+q1
         TDHUkTjQCnvQpavqTqboV72mUSYeDCrYvurX6KICF2QvvJJaw/A1woP5KgqIW4lDxT21
         373Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760536142; x=1761140942;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hMbFwwV83Qg+1jJmG0XLxD4XrkMFEdpohch/EjieyXc=;
        b=QSk3PyfIginGtZPiabwgzQTOR7Hs3QzB1oMT7ewp4vgKSUNr0rKvnlWJ39dmy2EDrD
         068ePpSXlkAa1fyM3zU/rhSEe/7NNGfikYlHCIh5jda6n7QV/ruUfbnfvQ15gahHIQat
         iKeCtxQypLwKT/MY6WT78ZOh5Og9/+VtRlSaowQuACdkGgcP0x4dJr0mWnt8z6xCFhyW
         XcqXGsuVCLa1c6MzhI4nD0F8QbuZjkjKDzsfZirp/thmXg6HjeybkPBfv77hyWkyxbny
         JG2iu/62ox51idEWTXaiRfJLbBeedzW2udJ1vPlIwWZQPmvoVaQ00XfxXt7NXc7fsxZo
         vzYw==
X-Gm-Message-State: AOJu0Yw1HzgUo2NFIjvYkUsgwGrR3vc4R2zHojzIr5kug0+E/SpNr8Th
	94sMjDTxh2oFlyTynodHKIKopZX7sOCs4h2MvU3BkyZ8nGMqqcDTfG1V8veeHhwmDuU=
X-Gm-Gg: ASbGncvrKtpKcNZK/mSzfyHBGJsmaUxdQRq7dSgkDqtQQYrgqL9t0+hiIB6yNeVX9aA
	1WN2JRlwS6T7Q3mbf7+oQcwum5mPMrpDGrhAh1sGViqB3FnvxN+cWHTaa2Dj7ZP53Bxqpg5Tpj8
	CvBkFaUlHQKNeI9y/loqezAC3RjHj55m000Arc6inHo5le2ZgyT7Isbq9DFILJ2c0sI2jkz71Rj
	ptkF+Ds2Ocnm68H8sEHspLrilXk16L/Y9Vu2HJnjs8za4nDlS4R2jWe+aFoLDY/dE3Z4AGLdHAX
	HeTNfsJIk1IWLsY6LtoVu+IbXbSkR7BsN6flXcLLFCp4t3knodafoPEgbnxfsbR6Jr4Ts2oBvSY
	J5m5ofkZyWef3vmHpVg+r9b7w/ADvgp2yJ4/TQfqdK5565YBg
X-Google-Smtp-Source: AGHT+IHa8fNGDE+sM3KP62soMcj2BPqKtw3xT2uQRog4kYeJMrSbUQu6nIccEpfSNol6haFAFkjRNQ==
X-Received: by 2002:a05:6e02:1fc3:b0:42f:9649:56b4 with SMTP id e9e14a558f8ab-430b437e677mr1896315ab.13.1760536141679;
        Wed, 15 Oct 2025 06:49:01 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f7200b261sm5666738173.34.2025.10.15.06.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 06:49:00 -0700 (PDT)
Message-ID: <9e775775-940f-477b-879f-dd7389f0be31@kernel.dk>
Date: Wed, 15 Oct 2025 07:48:58 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: fix stale tag depth for shared sched tags in
 blk_mq_update_nr_requests()
To: Yu Kuai <yukuai3@huawei.com>, clm@meta.com, nilay@linux.ibm.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20251015014827.2997591-1-yukuai3@huawei.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251015014827.2997591-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/25 7:48 PM, Yu Kuai wrote:
> Commit 7f2799c546db ("blk-mq: cleanup shared tags case in
> blk_mq_update_nr_requests()") moves blk_mq_tag_update_sched_shared_tags()
> before q->nr_requests is updated, however, it's still using the old
> q->nr_requests to resize tag depth.
> 
> Fix this problem by passing in expected new tag depth.

Fix looks fine, but you really should add a Link to the bug report, and
also a Reported-by tag. I'll add those.

-- 
Jens Axboe

