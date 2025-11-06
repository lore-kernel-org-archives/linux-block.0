Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9313B16D9C2
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 04:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762402594; cv=none; b=Io18RkypH1xQXhBrRtn/NSSRzXueozelPlGXEnznQ25d8jd+X7ktiICqJbrZ++zHGQB33VNaW++gFy41qlt+Wd7zQ3JCK+LSYC2K0Tw1rus1BSkNkYZUSZhmp46sFO6z7tfP0WgOF+T4FG/0bUVBAH2zSX4jKz//QHcuYTRaJwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762402594; c=relaxed/simple;
	bh=jo8yg4CaeGmaOTacBVOzB4QpTOKG2emYqp85Jsiu1A0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nWcaeIIGXa5G+tIPBWRxO1NbjZVhGy17Jeksyme+eBjSa2JmMqzoT40RCKP0AL3+BfpltyADGk7SXzYEiAiCM8IXQR7er0aSqqjWdmVPTzMGHDmOzxoiqSInsn0OxQtMy9euwnopuus8aVK8DfcyyiiVTfeFLFEmAQBeZG2yTdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7eH9ckU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7eH9ckU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35533C4CEF7;
	Thu,  6 Nov 2025 04:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762402594;
	bh=jo8yg4CaeGmaOTacBVOzB4QpTOKG2emYqp85Jsiu1A0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g7eH9ckUbaVCxfhGFJYWsDhmPJyCxCii4Fyz9823bzIgWUpPenorLEvI9MStBVXZL
	 42DGfIkj4AQGxeTjKN9jNH30f3J3qryOjq9mBLIakxO2oQ5Zir/vQL7f16PkR2upHX
	 0NiO/kM6GJNtVzbxqDWHA/k/emE+yzZFvHyfdN/qp1K8Gl1OLO5EY9RM534tROqR/T
	 JkoCRLSiCjDAYgO2hJSazD8EPc8qwrvfoTLb/vPBMUhSD2aTbiYnSfolCgwWwsqQtl
	 LK2JIm23gYsdh/MxL1nLH37YXVDcpTjgySxreant96ge7r9PC6kxfIV7p4jeJSRnUr
	 ywxzi2UZfU1UQ==
Message-ID: <762d1f96-a802-4d6b-8b7e-20f58dfe017c@kernel.org>
Date: Thu, 6 Nov 2025 13:12:39 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/4] null_blk: simplify copy_from_nullb
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, hch@lst.de,
 axboe@kernel.dk, hans.holmberg@wdc.com
Cc: Keith Busch <kbusch@kernel.org>
References: <20251106015447.1372926-1-kbusch@meta.com>
 <20251106015447.1372926-2-kbusch@meta.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251106015447.1372926-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/25 10:54 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> It always returns success, so the code that saves the errors status, but
> proceeds without checking it looks a bit odd. Clean this up.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
