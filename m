Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEAE17597
	for <linux-block@vger.kernel.org>; Thu, 30 Jan 2025 02:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738204565; cv=none; b=c0jlLnJZPw8Apz03TSVv0Gf16UYxaVCggIEjwf2c5x1lvDfd6N5FGLDJLAttLk79gif95OMf4y1xsACFaCPh0L8lvJOTCZvFqjQBJ0P4w+ABYjbRLLuKMqQt2Z0BfUetTsIYW3AI3e2XRo0FcdO0rAwmnXPiTHLq/l92Mezx400=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738204565; c=relaxed/simple;
	bh=Q1G2WExXZ1LS0vcxaBpbMiAkGuO20HKv/SE8S3q4M5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XyB7/L5iED9PPxo8I1Ujs1P25Ku2ayP98ahyvG9VTgAHHimZvL6zWPlLhF3yOn771GcB3YWdbm/ebGVwQ4jllLHgj96tbJ1EljjyUtnzhJZ+PCPqZPQUn/JZZJOy3mj8ytzeMCtLTeHu7OHwYRQ9LyFh4w+b1gT8BSZTTAycadM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJIqDLbl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJIqDLbl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9C4C4CED1;
	Thu, 30 Jan 2025 02:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738204565;
	bh=Q1G2WExXZ1LS0vcxaBpbMiAkGuO20HKv/SE8S3q4M5c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DJIqDLblr+yd1GwRQJGaQGhTj5/CA3RmVrYqYeeerwzv2+RroSxvFhpB2cWdNgp7c
	 HF05HAssBRPXMm/qkAUR6KWhbE/gkNmKSRg8N3dibDHmyBxCiW62k1hVHStttfIoDO
	 YQ/FmLiYc5nT0uwUxQVoZlNVhNALVsR5QOfiOLYMfbrKjeSOTILe2rgab62whlIaXm
	 34hVtikHAdoW0oTpwaJ8VwPdL0UOJzjGTNvHy2hDmJD0M4RyaQSKnHzRcUKbZ3u+Hb
	 R+1jWq1uyJlMkb5D5beiF6PcY6thBmqOCUWegCR4YmrU4yEyA2VvSuK+MumhTXypoR
	 iDosMEvW/4FAg==
Message-ID: <fee0cec3-bc9f-4902-bc8a-dbc93da9ff71@kernel.org>
Date: Thu, 30 Jan 2025 11:36:03 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] null_blk: replace null_process_cmd() call in
 null_zone_write()
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>
References: <20250125012908.1259887-1-shinichiro.kawasaki@wdc.com>
 <20250125012908.1259887-4-shinichiro.kawasaki@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250125012908.1259887-4-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/25 10:29, Shin'ichiro Kawasaki wrote:
> As a preparation to support partial data transfer by badblocks, replace

s/by/due to/

> the null_process_cmd() call in null_zone_write() with equivalent calls
> to null_handle_badblocks() and null_handle_memory_backed(). This commit
> does not change behavior. It enables null_handle_badblocks() to return

Since this patch does not yet do this, maybe rephrase this to:

It will enable null_handle_badblocks() to return...

> the size of partial data transfer in the following commit, allowing
> null_zone_write() to move write pointers appropriately.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

With this fixed,

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
