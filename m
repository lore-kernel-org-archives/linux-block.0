Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23131990BA
	for <linux-block@vger.kernel.org>; Fri, 14 Mar 2025 14:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741964081; cv=none; b=i1GQRiH9JKBh2x/dWY9QoDMZQo8lzlr6cRmyq3/XTqPtK1mqqNz9IyFGFmAqHoEQLhiZgIfNu9dHzJko9AdH5W7bB9hJWjWkwnAfEmvWkfzL5Ji9cxyy2eJQ2IEMGtgYBOujMquF7l+AmOPGhudKjHBV7yNso2fvWoBftLA0rjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741964081; c=relaxed/simple;
	bh=hmiPlAO5fA+HP9TOkGDgXGILEEEL/7uX0m6fv+S2ICA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ne5pj2NnZoW6uoF7Lxnv9krvUSq4QsdeqtBAIboH3CglO2FH+bUzNB0+KcWYTlMxre/oG5Rh5XeCaDLw/DUUjG/fqIvfp/Gas+gFVL5ojavHJmSTYMKDtNblZAGWvM02NZF9Rrf63AgJHsBnU7RcN5r9vwzq1WyRu1ViJ9WPGyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gDTO75D4; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gDTO75D4"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3cf8e017abcso8984435ab.1
        for <linux-block@vger.kernel.org>; Fri, 14 Mar 2025 07:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741964078; x=1742568878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C/yk7vWOpSlwQhBuNTOHZMsj5ct824YHIupvrggjkvU=;
        b=gDTO75D4wMG46x3FPuIN6bSzUInWoQWvkpSKNmhA2WuOjOWfluSoOz4OOQ279CoWyt
         3Qgcj/LtGth33uQKPGEAfRvN/JL9vbxyfh/yxszhSjjiXdu8x/5VvYiCCKRhT10au+g4
         MUsZFYSi2XjT9zEGpyS1bqZkzNC71nsFPNBZ86M7Avls2YKzMajD6NGA2R8zLPFyhe5N
         bMQLTarxOVyC0AB4olYlUCCWag/8N8zJSI/b7aNSyjxLf22Ev6qbmtAS3906DfjpUQ9V
         LL3gqY7Gs5HmRBVYVP/X3cvQJdlJaJCdLDdnV/h8bLUTTdt6O3EkDlyZFzgt70pkdMt9
         dCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741964078; x=1742568878;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/yk7vWOpSlwQhBuNTOHZMsj5ct824YHIupvrggjkvU=;
        b=HCQ1QTCUydAZJAY7y2iQZUgpfGsI8rxp71lVpl+SX1QpOtw8EnW3w99pA0Obp1YFj3
         MKdVTcClkn/bnf6s3D8E7sYv4z1AbVbad7kqiCOf4AHbWTbNMGD46VNJHNZTftUKmAA8
         B69LruWu4ucosW9fSEC0lI+w4pW9EwZTquGueDLzm0JsmwllSk00loZHVmPKh8ZNMnhe
         eMBoMi0SxFftpK74uHLYzM90Tf17Pe2b6YnkD7lct7R3nNZWNoRvSaB48kawxWnu8G/p
         AuZCE60BmwNPbQX77DpBWDxFg4cQGkmD2Cgd9ETI4blFF4A+/F3/ThnFi6NuLYAusAY3
         kjjw==
X-Gm-Message-State: AOJu0YxBkCLrh7PjjGKtmJSEVFCI4ZOh3Pi7F35qtZXTTZjOCHf2xnZI
	CEEjwPS2AmrN2vqjpmM2bbyVIzvC8QnfQ4JUAoBwXZkqbCvZ3mlk235G+xds+UUeSp82clpm9ku
	Y
X-Gm-Gg: ASbGnctWIGduwr9Y7I37UFRNKw4RePtFFzffNu79dYkVTbWOM1FCn4kXy7E6Owiq05Z
	0/cbRqgf1k3sG/DGKVwpMqYr7F0wx765K+jlufsbbzhv8J74QwNgbos576ZuxZizCtYycRjGwlF
	u8NIvpqnnorFlE6PcMzxFbscl5rDa5a60DrjuOayBqs6Ivti1MICs9VVHd1ihPJ5uCtzJ0UFlSA
	OJA+Vt4mbBJlcK914KSIezIBuQjoOJ3TKwPN3XLyioZhiZ4aQ9vg+/cGDeVDyhZuLb0NGSnWNDg
	WhjcP191H701t6fjhg6bravazNB4fo2LoHHgoq5sSj+NKYvZfXno
X-Google-Smtp-Source: AGHT+IFQ1CaYTThf3yfX7iABIfIjGpZd6UUGniA8xEJYupufBfGZrErPQ1H4SsabM75frWn4aKd8pA==
X-Received: by 2002:a05:6e02:1b0a:b0:3d0:47cf:869c with SMTP id e9e14a558f8ab-3d483a82a83mr23001095ab.19.1741964078615;
        Fri, 14 Mar 2025 07:54:38 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d47a668e75sm10124505ab.26.2025.03.14.07.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 07:54:38 -0700 (PDT)
Message-ID: <183eb52b-2e64-4809-b81d-9cb51edb746e@kernel.dk>
Date: Fri, 14 Mar 2025 08:54:37 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: remove useless req addr print in debugfs
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: linux-block@vger.kernel.org
References: <20250312084743.130021-1-kanie@linux.alibaba.com>
 <97516917-9dc4-4d1f-908f-3bbdd8d7cb97@linux.alibaba.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <97516917-9dc4-4d1f-908f-3bbdd8d7cb97@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/25 9:04 PM, Guixin Liu wrote:
> Gently ping...

Don't send a ping after 1 day, that's totally unnecessary. Especially
for a patch that isn't an urgent fix, it's just an odd ball cleanup.
Reviewers have more important things to look at, and we'll get to yours
in due time.

-- 
Jens Axboe
