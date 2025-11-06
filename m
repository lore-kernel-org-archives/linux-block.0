Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A815529A1
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 04:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762403718; cv=none; b=uIDKly+NV9ArO8c08FKwsvCBQxVPPdHMO7JUan81hxtlMpogPX2gA+nlchl9CofQjbX4R3OzolHU6CKYbs/K8STFCkhmV5BZKKfGufaGT7gNmC9f572UTdV8/gKKqdnCKNXOteimcyIajiLuWH7dq/HPZvD8Xqs6iVC/ED9uaxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762403718; c=relaxed/simple;
	bh=0NKkoXcj12kuxL014ecN1w6NAn33C9rghjSJpEtZHOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZz3iffGQrB7KBdHgS/aLtqQHPBhcSe0LB4jfqf+wU9ETEmgrLzjkSLqxZE3+NfoeilsXCoy43MYuq0X0WscYv7sdTdmthpMIobgNMepv+NuaWNwlc927AZxK42vfAq4Yeu6BGF+LBdvTk7T4odBke1W6PU1b9UuDfqH3h4YUvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRhxtk6g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRhxtk6g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DB4C4CEFB;
	Thu,  6 Nov 2025 04:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762403718;
	bh=0NKkoXcj12kuxL014ecN1w6NAn33C9rghjSJpEtZHOQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SRhxtk6gfU1muu+tMgG1D8XEc0ewEnfV04V0exyom2RoBQhZcQOjEMqkNWSvu0Vs8
	 peSoVNT6VYaf1COyMVHSoExN2wH66ClRS2sx4HzihyGsCagH/Cqthxev+3u+Jm/Svq
	 wZD27M2UyZmmM+fxTAMxFSC/+NT39285Adiorm6ACfmMWtkLXbn91oKIlc/lyWchUT
	 xKXEgr+1XNZCklVA6iRbxd5KhO/9wD1QSTIccf+9oHDNLXkSJsxgXsbvaMOBPkmtmw
	 IYZF1cHciX2VqkKw+fgsteejQEEUy4ANlWBJoboaiZ1KcjmU86BhDmRF199gzihRKq
	 tTYHiIXLSmlTQ==
Message-ID: <57db9d0f-299b-4043-82ec-55d502642631@kernel.org>
Date: Thu, 6 Nov 2025 13:31:24 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 4/4] null_blk: allow byte aligned memory offsets
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, hch@lst.de,
 axboe@kernel.dk, hans.holmberg@wdc.com
Cc: Keith Busch <kbusch@kernel.org>
References: <20251106015447.1372926-1-kbusch@meta.com>
 <20251106015447.1372926-5-kbusch@meta.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251106015447.1372926-5-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/25 10:54 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Allowing byte aligned memory provides a nice testing ground for

.dma_alignment = 1 means a minimum of 2-bytes alignment, no ?

> direct-io.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

Note: on top of this, for testing, I think it would be nice to add a config
parameter to allow changing dma_alignment to higher values, and check requests
when processing them against that alignment. That could allow testing corner
cases or emulate devices with weird DMA alignment constraints.

-- 
Damien Le Moal
Western Digital Research
