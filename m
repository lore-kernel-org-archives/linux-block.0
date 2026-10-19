Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676804B3CBE
	for <linux-block@vger.kernel.org>; Mon, 19 Oct 2026 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403072; cv=none; b=ViuajT1kCQ3lCng7h6hdZ7rfBx7ijgDRvgJ7kMTtSxShIzVldc3R1Q1N4cGOhRTF8FedzwdhqcTNv9NJjI7t7Nihq0wl6j7clPDzWs370rVJGLUsjiTbXzmv7v90lvAN2owkva4wrHjJ2vGM6m9EXpuPUrUh2pouTCT/ApUrysk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403072; c=relaxed/simple;
	bh=wMI+wvLL3Lfmf9QOAzMBWmfEf84Qwp6r7z02p/HhR48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nfijAxygGgBY0x5Owkx8d+gRC6uxBC8GGA0qie3OBsnUOg/MUM5MbyzEB/wBNGACOXzGair1haGBQckep5KBvxy2wiiFjQJrONtLZI6oco3iXiygsqZze90LZosj0uJae3yCcDRhGZMVyyPUpjMJKEScCD1KiVa8SxJrKbo0mXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJmJORKQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJmJORKQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CBE1F000C6;
	Mon, 19 Oct 2026 09:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792403067;
	bh=4unmMhDlj948qvIvWvnmCfD6s2zcYKI54XQJsLFKqfg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GJmJORKQnSo3nGzeIpQFxz5w7SnMf9Ox6v4WuHjdD/0YS2FokERQ3cT8XAmdz63lT
	 srM7rTBoW4QzuV7hhS8V0VXRg0m2AOAoVn9Q256B9+jtyiixmTrPk8PxIKWk8y8/7g
	 wb2tV1etMzjNxl/HfqfQ/S04yaGa526/8epuuXDx//DWQpL4Ahi9BOsOXbXWhraPZc
	 gONoFZGzsrBIlxYsnoVx5YwgTPTSwp51La/j2EqOjPN3A6oopvpqOsO7Ih9Ird9IL6
	 6LqqyO/ELDS3p/hv2KNxR3rZev/0oe+RYSLJ3IHZUaP+3A1o+srMTXPjz+qD3a0+cM
	 Yqu+51KaUUnWA==
Message-ID: <be184b72-5d1b-4723-869b-a9fce2535bdc@kernel.org>
Date: Mon, 19 Oct 2026 11:44:25 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zloop: print device that had errors
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20261016073043.1164325-1-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261016073043.1164325-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/16 9:30, Johannes Thumshirn wrote:
> When testing zoned filesystems that span multiple zloop drives it can be
> difficult to figure out which devices access caused an error.
> 
> Prefix the error messages where we have the disk available with the disk
> name.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
