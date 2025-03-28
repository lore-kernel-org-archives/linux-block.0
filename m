Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75061865E5
	for <linux-block@vger.kernel.org>; Fri, 28 Mar 2025 23:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743203053; cv=none; b=dc1KR5HPb3ODmQARLYu0zw+LfO9Ocbsx9fAqmDiCAgCdZMd8C9ne8ofgS2WFtiitjdorDutI1r8dioQzsMoMJL7c9U/5a3HqWq9YxePK+69750Rfevb7DkckSDwDI9rq6B59kaVmNJ+N/F3ij3d/FMrXL+7piOLDdiyXsp6t3bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743203053; c=relaxed/simple;
	bh=V/Yo9JaPudHdUaz/y8DF4V6JJBxzXUoyxnkqIpft2S8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SyqMrVXU0jeB/Pw1hejwqeVWm3ENX5GFZXZbi3vSDyfIpqD+qXv8X3eF/yTnuCxJUk4Fp+DzJoN+mkbBNNswYv2ITqb5gCiJP05/7LzxxZ/3t39uIQqtNcofgvt7FzvD2xxCLWRx4aQHqOxtXlTYwgyKoUL1/qXooUal+4SVBPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WfnjjzLT; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WfnjjzLT"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d5bb2ae4d3so9005875ab.0
        for <linux-block@vger.kernel.org>; Fri, 28 Mar 2025 16:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1743203051; x=1743807851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qhp4FjWVQrvvO+GlfbQLfHCrJZodz7/Fm5AMhUdc1FA=;
        b=WfnjjzLTVSPckitKrYLiczzZgEFBsTxx4C7wwIn1Bp1WKWEI1Csk+l6iJNhDSszU+t
         T9hW2S8YmuC3hQmQMBPI4UQ/5wuaM4ZK+2pSkuonPT0v5D1cgRcwsujB6DITEaLyw6X4
         BR16eBFgh8lkb9g2Ho0mNTXFDz6lrSWr5C5/97hxbCryjBZaTc/K/nMbCPSKZsc43GcA
         JShCOldn64+NXptX6QQ0XSmqM+jXYNG6e/JlhYPS0RIIiMJhb/E5xXLX5biv9OLpLoTN
         lBuhISS2/s/KgUBCDXUBQAm0ALgvptHApm9qYoaxQUwpnbUQYI/L4AXXYsL6Xa+p/Mvi
         CcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743203051; x=1743807851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qhp4FjWVQrvvO+GlfbQLfHCrJZodz7/Fm5AMhUdc1FA=;
        b=g4Orwe8X2kxjK+2JGuePsD+++cuVfvkjo0FKvx4QnppR1v/SuCoN+kpm156+JISmvs
         2thSySLg9F7/uEXhT+YkcTFjYbLtWqgnpZI3wRd/rQAvaGFD1LCnSt5GOxNlY4m3DpBg
         NgKR9M0uZf/5ZkChwFMKYmD8p6Xz20NCa26O4vfzXV816NloSmaykMqj+fzekEDPB+nX
         pbwKtUWv8epiPcqEmkNi1XbSEfccpnFl5vy11VfVzJWk821WcD60qnCw0Yxhv9wIkhTV
         Q8yIthzEG3ybu1SkmQb5Dovy06cLLn2g+gWu6T5j9XmUDQzSRXFTZUYqt8faoUabCGR4
         9Ncg==
X-Gm-Message-State: AOJu0YxJctNaXK2ehfOcy9aZb6GvtMrCFHWJFXf7blGcyZj4+0XmF+As
	1Y9wXHbaXE+ZDbt7205dsRtOVxlr86nTUZlXTa3TdDiA5pgjufmenhYQEpk/vgYJbXPnJq4H1oE
	j
X-Gm-Gg: ASbGncukq9a0YX7W77/jJNfXNqyRDIjZq//52G2ITvbkCcjtbVyO4ss9jxARUKlSuNR
	q05itfwkD9LycgsK48P5AL+XH7DIcaIK8D+skNyie/KWNuQcvA9z9DjVXLsKW5OHnbVpQPESbXR
	VEMWaqhFk1tlUPVGHasvK6oB0uNr4yVxkyfiK+yEJJMfS3eKRSDIQvzJ/fHNX7nlgMQFtr6gXga
	rZREa8L9xGv9j1BOUz7tHLoy2rlltL3MJ1r7aB0UFWZEFFYgPixoXiUChjysgIpBD+5Li7stOx4
	muQ1YFIJdT07zhnE7Yv+VMjMVtfrP+s2mSoAgWVlkA==
X-Google-Smtp-Source: AGHT+IHPLiyiUBHTmY8K8liSQ7EueqnYy34tBm9yuLIaqAlS1dx00t7wM4dbN8H3iyc2RlQhEdNkcw==
X-Received: by 2002:a05:6e02:3183:b0:3d5:e002:b8ac with SMTP id e9e14a558f8ab-3d5e0908e3emr14696755ab.9.1743203050568;
        Fri, 28 Mar 2025 16:04:10 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f464717e3dsm651238173.3.2025.03.28.16.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 16:04:09 -0700 (PDT)
Message-ID: <9b65632d-5155-44d8-9dbe-5026a1cc471d@kernel.dk>
Date: Fri, 28 Mar 2025 17:04:08 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ublk: specify io_cmd_buf pointer type
To: Caleb Sander Mateos <csander@purestorage.com>,
 Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250328194230.2726862-1-csander@purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250328194230.2726862-1-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/28/25 1:42 PM, Caleb Sander Mateos wrote:
> io_cmd_buf points to an array of ublksrv_io_desc structs but its type is
> char *. Indexing the array requires an explicit multiplication and cast.
> The compiler also can't check the pointer types.
> 
> Change io_cmd_buf's type to struct ublksrv_io_desc * so it can be
> indexed directly and the compiler can type-check the code.
> 
> Make the same change to the ublk selftests.

Looks good to me, nice cleanup, more readable now.

-- 
Jens Axboe

