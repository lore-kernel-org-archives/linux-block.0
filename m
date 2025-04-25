Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798717483
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 02:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745548650; cv=none; b=BtNGd3zak7u7jwGCUDAcQAiH8nC0o0UVZy93+rM0sNQk3b3byA+7FRLNBA7eCn932hzqWWbbgyaB4HV2N/0+f6aPvSDDhnXAT+qIoCi4kLiAxt/t+7RDM9ytrhnQ6m2uig4Tib4RkhApkdMM6gbq1MJsnuth+IWDbc5B7IytITw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745548650; c=relaxed/simple;
	bh=M5B06ByfF7RcAeRqx8pWCRo36Cl5bRmp9BxcFYLKFXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W7WSh0MkVF8xy0UPJMfxVxzoVfC4vh+xi51RtguyIJIfzJKV7ssA1kWniNQLT/dge33Wclmq/kLyirR881TiOBVYQZMDUlyC6m9sFrSlG8VluXMPAC1RZ8ozKAhWmP+Zdjrk0OsSeRmbUhw+KOsMTSLSvjPt/HFL6GxEzSHu2jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Og1gwpha; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Og1gwpha"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E8DC4CEE8;
	Fri, 25 Apr 2025 02:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745548649;
	bh=M5B06ByfF7RcAeRqx8pWCRo36Cl5bRmp9BxcFYLKFXw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Og1gwphamrXolN5ZPs9YHTEqpfPSNniBra6il38GqwZJ85LeyOJqynHzGubiBMLIj
	 T5RrneTw1TvAEi+JH/+vJ+62yCEQg+LdymugvITM0XCmvZk7zUeuMO2LdoVIfUzQeS
	 bFFQkKpn6+xPo4d+Uhns64I9woEPbPGtB+c8qCFnGQjvXhZXJ9QhmHivd/BjggL9Aq
	 Sl5N8IIINrOyU91MFrXRl09AUYAJRbGx2Rt55CfFNxwDH15ipJRzbzfIRCoR8zqkEa
	 x5c3gp0d2fnlTY84U6R6twvsGfcpV1kWqrBmEw0i/aw1YJRxamFNADeZA1ibnhZOG3
	 FYxWdWPyFaW5A==
Message-ID: <9d14a000-49fe-4cc6-9720-9894d1b3fade@kernel.org>
Date: Fri, 25 Apr 2025 11:37:28 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] zbd/005: Limit block size to zone length
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "hch@infradead.org" <hch@infradead.org>
Cc: Sean Anderson <seanga2@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20250423164957.2293594-1-seanga2@gmail.com>
 <aAnxqAv41Quh66Q1@infradead.org>
 <jzrhzy3qdj7tt2tlmoayo7pi367etl3furcbk3yvuh4zru2q7q@ikekotau7jvl>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <jzrhzy3qdj7tt2tlmoayo7pi367etl3furcbk3yvuh4zru2q7q@ikekotau7jvl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/25 20:30, Shinichiro Kawasaki wrote:
> On Apr 24, 2025 / 01:09, Christoph Hellwig wrote:
>> On Wed, Apr 23, 2025 at 12:49:57PM -0400, Sean Anderson wrote:
>>> The block size must be smaller than the zone length, otherwise fio will
>>> fail immediately.
>>
>> In theory yes.  In practice such a zone size makes zero sense, and will
>> not work with any zoned file systems or other users.
>>
>> So instead we should just warn about a silly zone size here instead
>> of trying to handle it.
> 
> As a similar idea, how about to skip the test case if the test target device's
> zone size is too small?
> 
> Sean, could you try out the patch below? It will skip the test case for your
> device, and you will not see the test case failing.
> 
> diff --git a/tests/zbd/005 b/tests/zbd/005
> index 4aa1ab5..d23eabe 100755
> --- a/tests/zbd/005
> +++ b/tests/zbd/005
> @@ -36,6 +36,13 @@ test_device() {
>  	_get_blkzone_report "${TEST_DEV}" || return $?
>  
>  	zone_idx=$(_find_first_sequential_zone) || return $?
> +
> +	# Ensure the zone size is large enough for the fio command below
> +	if ((ZONE_LENGTHS[zone_idx] < 512)); then
> +		SKIP_REASONS+=("too small zone size")

Nit: "zone size too small" would be better.

> +		return
> +	fi
> +
>  	offset=$((ZONE_STARTS[zone_idx] * 512))
>  	moaz=$(_test_dev_max_open_active_zones)
>  
> 
> 


-- 
Damien Le Moal
Western Digital Research
