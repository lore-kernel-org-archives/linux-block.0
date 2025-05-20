Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4373C264F96
	for <linux-block@vger.kernel.org>; Tue, 20 May 2025 09:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747733081; cv=none; b=URSgq9YmSbDaFLwU82tkBMO9YjmiMLyOqzje7e8e9PCE1aFHKuRExC/ZOv3uVHYP9MrKn+nkg/k1o/Mf4qg47k6VotWbm6w4/gtVYzfsz945Zkjh+oogjtIKyuwZ8qqbiNv+Ohx5BkZ9lS+dm5JE1+RT1H78U7TjvqqO1V+Sx3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747733081; c=relaxed/simple;
	bh=PEPVlbDIvkOhLOb+Td9rYloxnw626gzq6tvUDklS08s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lYciXEnNekoYDTiqpSxGIBXtIPkFEnG4ti7tZkpnxxdvMCsthv5nDzSrctyge7ZAsPz796xxP6JDHmyxHUeW2ngCYn4VqtfNmjGaQLeH5UYo1Xc6N/Vw7ftCk0F2TAWtSAwqhMCIrK3lQqrQiIvRNKymLBasom8h0rrLSybAXTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moH4eraO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moH4eraO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C382C4CEE9;
	Tue, 20 May 2025 09:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747733080;
	bh=PEPVlbDIvkOhLOb+Td9rYloxnw626gzq6tvUDklS08s=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=moH4eraO8pjvU+hZweUgOn6u4jzmiPhBsKIBYn+Sx3YlnWS0zf6n4IAl8LAPyYDY2
	 gZJLlCMvRfe62e2+YeOGCbXL109A2hVfZJYu9JGMH6fqJw4AR1ziWLBabUU2N2yPia
	 dMiVCVcowsk+aRkRPSn3ieVa2gEVuTy9DBlOkK/i2MY4kPsOy5TieP+BHS8I46e391
	 k+mbZ8xL4mwxmVEhy2n7Av+ibay3pG+h5RbdUtwRd8s76WWBiDkIUqJ9fdF4fIDMBe
	 hx50yyiefCNnSd7xvJyywt1lj4FPi4lY77vMNNsDhHiIMY+tPF/4qV7s98Mz4W3NqR
	 6ySTAqAjRvIDQ==
Message-ID: <2dec1020-5c03-4a8c-b775-1ed9044941e4@kernel.org>
Date: Tue, 20 May 2025 11:24:38 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] zbd/006: reset only the test target zone
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
References: <20250520072018.1151924-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250520072018.1151924-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/05/20 9:20, Shin'ichiro Kawasaki wrote:
> The test case zbd/006 performs random writes to the first sequential
> write required zone of the test target zoned block device. To prepare
> for this operation, it invokes the blkzone reset command, specifying the
> offset of the test target zone. However, the zone count option is not
> specified to the command. This resulted in reset of all sequential write
> required zones on the device. This zone reset operation is unnecessary
> for zones other than the first one and significantly increases the
> operation time.
> 
> To address this issue, add the zone count option to the blkzone reset
> command. Additionally, use long option names for better readability and
> clarity.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
