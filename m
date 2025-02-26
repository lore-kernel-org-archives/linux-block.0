Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6B92755FB
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 19:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740599905; cv=none; b=ncKjDs7H6R5XzftvtgMl0pxaEftQVuqFBn8GG74ZgpjIUG/1AYG/qnwwHal5TVCyihzl9Aa8xhklQKdMx3KzlJK3qD5K1Njy/3DW86Mj2LItR4YvyfMdq40GYXNhwshqZLozQ9+WZ3WhcBCsf/xSEjtiuo/H/eJMFQysJSNr6sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740599905; c=relaxed/simple;
	bh=gX9qu0BeQtR7XKFlFbgVhGUYL291Ng0kpopRBf1dZVo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OnB+jxc9qcbpy3or7P62caCbbU5RrgvE4opFqeCONvN3u0kv+e1S+aCAUe3hSbXhnoCYpxX/LEtn9tgM4UWraVx0q55zXlfGfThbvgjcl3GMsinaHvhZPKLosiNzJWRNsQ0zCGNIfYZ1zPH0m5u9rTLPZOZZRGVwwcibGnYABnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JD6N9vLJ; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JD6N9vLJ"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3cfcf8b7455so1897355ab.3
        for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 11:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740599903; x=1741204703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ndd7w08DJfKf6jnDYi/L8YoxxT3mLVwsG83pvOZOq9Y=;
        b=JD6N9vLJWEA5vArHi4D15ap7GpQV1h/tYqPDbTSIWnxkI/wLDMobWA6nX1bcVime/a
         cFP//XXeQzcsNNyTecCa+Tt7QEZlHK36TOE/xil6jpnJy4HXj2RlX/wFl7H22A2+L6fY
         5QO2PDQDUikiOK8bcZa+FKOZ7V0afoWY9s+KHtsxQvn44DvYA64H7fs7b/gui4lc5cDC
         1L0aX/+++osxdwSEYhBmiGrnfPY4BcxEtCvmzcXDK5r5Ge5oxaPPFvgKGG3+rz3LiBtK
         P0N/gZohNaUYnlJJFU60IN28mJEKiPXxu8OdRUEvbexqMLuQ7ubsBvRhXin8dyR7xp6X
         hVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740599903; x=1741204703;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ndd7w08DJfKf6jnDYi/L8YoxxT3mLVwsG83pvOZOq9Y=;
        b=BtxFUQ4pr+RPjlbM7MZpmORx/ElSl9lwYVJElAXBbdWw6I78KpuowtlFygz1Eot7eY
         jGU0RpEGk9aaS3cikXtq9UWiC0RJb/ERbbotVFtiKskzf6T1qUeuQ97shsQulBelp7dD
         2kT16240JUHCHx2AZvTu+ej7ru8qID/RTgVQghp3FYE8Au/mYYP608rk+yqs8HebBg+I
         Pw4+EbeQW7Ru5gFpTYRFlWwQv03weYL3SxqlMebcIvDV55nC/MtkmSDqKM2q9KjbzKBo
         HiG9ts6ON0QQJBoi+2IOfw/orAyYEw+gjH2oT65Myv2T5GXa/ANMABivkTCgC4UAqoVl
         nTAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5PT40hvRHTdh2LJ1evJY+DbCXI+8MIS7LiZoGuHLoj/l+Cg+d9pn8Jwvx7GczeDn7vl+0ezzTAloTBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtmtPNl4NE8OryAAZWB2qqw8ieIxL4/T0krOrmGpY6auwg27sy
	phGwqtKqcgjCII5XbpjI/9M3ie6CEkIpzROkljueihGfhKBW7FCYrskxYtUvHKM=
X-Gm-Gg: ASbGncuXvuDTAI9KSIP8IqcSmn2aie7opwtpohLbNEkUKVPhNRU6Bm3MTb/FOw3pBet
	tGzspFDP+NjyqW00SHVQ+X5S6wzjg/qSAm0HFEE3oSt4O5XzCE/+4CXmV7+sDbJGoQgMj4zzzKN
	55hXBdewwYry+xaPPJjHELcFfek9Bno4nAOL7rH+P9UqLoc74xeTm++ciIKZeHQP50MFNC6zg+/
	1sJ9v0IfNM+c0deq1qapNGtTqAvUQklUURy1W8P1sZQfW5KKCI0s2vD7n2MNA0B1ofx8owPB2bg
	a3uNRVyjKms9HXw1nP2BCg==
X-Google-Smtp-Source: AGHT+IGnsC039ohXWBjqBuO4K8YxxWd3QQUk7/Zi2UK4xWUHzax4sA2PzQVHkm4u4n7MbFbgw+t0qw==
X-Received: by 2002:a05:6e02:160f:b0:3d2:a637:d622 with SMTP id e9e14a558f8ab-3d3d1f4f176mr59581675ab.12.1740599903028;
        Wed, 26 Feb 2025 11:58:23 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d361ca3590sm9477085ab.45.2025.02.26.11.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 11:58:22 -0800 (PST)
Message-ID: <5f46cba6-0a11-457f-8591-732f709e7fea@kernel.dk>
Date: Wed, 26 Feb 2025 12:58:21 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 6/6] io_uring: cache nodes and mapped buffers
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@meta.com>, ming.lei@redhat.com,
 asml.silence@gmail.com, linux-block@vger.kernel.org, io-uring@vger.kernel.org
Cc: bernd@bsbernd.com, csander@purestorage.com,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20250226182102.2631321-1-kbusch@meta.com>
 <20250226182102.2631321-7-kbusch@meta.com>
 <83b85824-ddef-475e-ba83-b311f1a7b98f@kernel.dk>
 <e20b3f2f-9842-49a8-9f78-c469957e66f5@kernel.dk>
Content-Language: en-US
In-Reply-To: <e20b3f2f-9842-49a8-9f78-c469957e66f5@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/25 12:43 PM, Jens Axboe wrote:
> Ignore this one, that was bogus. Trying to understand a crash in here.

Just to wrap this up, it's the combining of table and cache that's the
issue. The table can get torn down and freed while nodes are still
alive - which is fine, but not with this change, as there's then no
way to sanely put the cached entry.

-- 
Jens Axboe

