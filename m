Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60141256D
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765799479; cv=none; b=tZ9xB55grZdp67+VmfE2H+I0UpXDqgYrSk1e7/umE7IFABjiEUJ/2A+FA2KjWeP2JRo7D8vFhYximbi+nL54GcDmgpHW44RKWAuARM1sOUlw96urD6PGYWkyfRY3lXdKUpsmVpucG0vdDj38w8xRrtB1lCNgSC7eDkiNJpfgPfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765799479; c=relaxed/simple;
	bh=3VHFiNfacX6GPiwHsa0M5p/LfStZSUg4vM4lhqF5Tc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uWLMjbSnzURFDHfdWMZ8LElk8S5d4xB49wt6SNq9qGX6YauN1hpfC0QONBhnYyelORM5CVhitfukuoCh94EjGOOmuiDh4CH4CbgED2zkFTYNd9Z3dQddf6iCPkborm/BYkwTCRGc67HwSNcJwFIfg9xPJfzpKpK0582pxEloYlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkvJEbJp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkvJEbJp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F473C4CEF5;
	Mon, 15 Dec 2025 11:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765799479;
	bh=3VHFiNfacX6GPiwHsa0M5p/LfStZSUg4vM4lhqF5Tc0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pkvJEbJpy+k8/9/XF1IvEDoT1v+jz9qhd5f3PTyVJ5IHlVS56v6vxTCVaf+NBc94z
	 /mq33tL39Ff/7Zwkd0dTkfIHMypHBWvRMp8nOtOzG36A5pnNwiIm/e3ZLgF9LDAo57
	 2HDBjHVU9HyIn/XMLOr3qWqaGZ27SI/67JrLmViBfc7ojA08SjDucOVKsM4uQy2US+
	 /BZR/92eo0RjT+9HHMRu8RXwxH3NBixIoJIip4JVP0JbpX4XTtPk7VuUJlDU0Lj1zl
	 Vf3a8Vo2bVp1LCqV8b0WUz65LJ1+QvFhuWPJu/ZcQ114iVhPsS+41bW0hagFlVIHba
	 NqkL0wGuAfJPg==
Message-ID: <615dfdff-f60a-4b87-866d-fbe1ddfe45ba@kernel.org>
Date: Mon, 15 Dec 2025 20:51:16 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 1/1] Documentation: admin-guide: blockdev: replace
 zone_capacity with zone_capacity_mb when creating devices
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <yangyongpeng.storage@outlook.com>
References: <20251215095816.1495942-2-yangyongpeng.storage@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251215095816.1495942-2-yangyongpeng.storage@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/15/25 18:58, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> The "zone_capacity=%umb" option is no longer used. The effective option
> is now "zone_capacity_mb=%u", so update the documentation accordingly.
> 
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
