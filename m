Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A17C2F3E
	for <linux-block@vger.kernel.org>; Thu, 10 Jul 2025 04:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752120957; cv=none; b=eIv9RBSRkKm5AElm8O5dvx8SDZi9/dZ0s3EStYSE5Lp3EneN8ruFEdDDQqQ0VsRYK6NaeF4Pih1DfCO8mkg5MNDyfhBHcPzHXoy8YQRhKk7Kjb5U7UyxrhPM2GsQPnf+wLErpnxFn0pH75mlqoXACgOgLj6s/ZT8MNGoiLQgmn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752120957; c=relaxed/simple;
	bh=YHOepXdOE12xu0t0jyCDuEz5cYjGH+RWqvfo4Lt9fzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TFAFxyvLGsTazw0hpZTppv+Ad8D/C6zQq/QY2PlIH7Wyyd5P0nL++D18hkElIEQ9a+oDGedWm8uq82aAus9KKmVqOtHvWGTkl1UZB8DVDSj7XHCFrXE4RKoLHtC3/mhlpbwwjPDGquiKPImxvzB7XRtAN6jksNdv6QkC8zcLhNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdbWdwI6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdbWdwI6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03DEC4CEE3;
	Thu, 10 Jul 2025 04:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752120956;
	bh=YHOepXdOE12xu0t0jyCDuEz5cYjGH+RWqvfo4Lt9fzM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QdbWdwI6oZG0McE6H0AJc9d9vR2ruvahGDA2Vr5s3zfpMWOa5VV29LD/UsEeuIbnx
	 ZtvhwdoNpgtKulLHrTsaR12We+MKOEngi7RLlPtY+BR5Ht+omGK7NSKlENkCjb9Cmr
	 ODYmcV8HZyCJu6Nm1St2lTspN083cN1hMDKQo+apc858kAcvYwrGF+NEQqoxCU62BP
	 mzq34Uo8ZP+BMsFaQ+UeN6Py2I/Y0cJQAP1KZMoJvaG5s1c68JpUWI2RypLB1ofd85
	 twftWDJkIXHdViIt78DLt5aLFzQ2PX8g2hZL8EaPsLKQQ/udbfcy7Q566gCDWz+3rq
	 TqqUtUWpJy4UA==
Message-ID: <41730c5c-33cf-45bd-a0eb-44057da37eaa@kernel.org>
Date: Thu, 10 Jul 2025 13:13:39 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] blktrace: add zoned block commands to blk_fill_rwbs
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20250709114704.70831-1-johannes.thumshirn@wdc.com>
 <20250709114704.70831-2-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250709114704.70831-2-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/25 8:47 PM, Johannes Thumshirn wrote:
> Add zoned block commands to blk_fill_rwbs:
> 
> - ZONE APPEND will be decoded as 'ZA'
> - ZONE RESET and ZONE RESET ALL will be decoded as 'ZR'
> - ZONE FINISH will be decoded as 'ZF'
> - ZONE OPEN will be decoded as 'ZO'
> - ZONE CLOSE will be decoded as 'ZC'
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  kernel/trace/blktrace.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 3f6a7bdc6edf..f1dc00c22e37 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -1875,6 +1875,27 @@ void blk_fill_rwbs(char *rwbs, blk_opf_t opf)
>  	case REQ_OP_READ:
>  		rwbs[i++] = 'R';
>  		break;

May be enclode this new hunk under a #ifdef CONFIG_BLK_DEV_ZONED ?

> +	case REQ_OP_ZONE_APPEND:
> +		rwbs[i++] = 'Z';
> +		rwbs[i++] = 'A';
> +		break;
> +	case REQ_OP_ZONE_RESET:
> +	case REQ_OP_ZONE_RESET_ALL:
> +		rwbs[i++] = 'Z';
> +		rwbs[i++] = 'R';

I would really prefer the ability to distinguish single zone reset and all
zones reset... Are we limited to 2 chars for the operation name ? If not,
making REQ_OP_ZONE_RESET_ALL be "ZRA" would be better I think. If you want to
preserve the 2 chars for the op name, then maybe ... no goo idea... Naming is
hard :)

> +		break;
> +	case REQ_OP_ZONE_FINISH:
> +		rwbs[i++] = 'Z';
> +		rwbs[i++] = 'F';
> +		break;
> +	case REQ_OP_ZONE_OPEN:
> +		rwbs[i++] = 'Z';
> +		rwbs[i++] = 'O';
> +		break;
> +	case REQ_OP_ZONE_CLOSE:
> +		rwbs[i++] = 'Z';
> +		rwbs[i++] = 'C';
> +		break;
>  	default:
>  		rwbs[i++] = 'N';
>  	}


-- 
Damien Le Moal
Western Digital Research
