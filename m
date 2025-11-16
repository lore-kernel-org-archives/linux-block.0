Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4731CD15
	for <linux-block@vger.kernel.org>; Sun, 16 Nov 2025 03:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763265032; cv=none; b=rBOEcp/Yiw7W0Vuz2N5k2HoOZLZqMJaVWVzSC9OsBHRlZKRi5DsM7fEM1rhE3B/8eLD2miLsuwD4nvwFPG4fPsq2vUSrr7j9vz5A3CAVUEZO33V4Jhc8/aaFeAq74ATCU7dRF+HL/CV38qveo2hoewvDuyExfjEnAn+1NpE+pCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763265032; c=relaxed/simple;
	bh=g9OhCpbNbVQIOApgrIMhYlTBdh8hggtGLPA9uVCNUxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=giuXfnQ7PBtpK7yNRqCebMw+ibPzuqVTWM61vRTl4XY2uNnJLG+eCfkuhwg/KlSODzB8MARsIzInVXm+l7FpInVhgTQv6UlMW+ixOHNn7NINWceJKXPiKOihzd3TafGrKc4zTSS/e2G9WH+wiDBzXe4b9/d9RQzDX1Q2Wsek0ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbmTOys2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbmTOys2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C66C16AAE;
	Sun, 16 Nov 2025 03:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763265032;
	bh=g9OhCpbNbVQIOApgrIMhYlTBdh8hggtGLPA9uVCNUxg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qbmTOys2dBI+Bi52TlRL97aVCpVEhY1q+AjfGTiytjVacPjT3Zb/K0V4/uVgxPmN/
	 R0aWjP/dhE7crKxLzqmu9ofajtYh+QJ/LLGAXD6Tr3v7kjjV0CypEZX1S325LjmCrG
	 41ja+1n//r4aVDY6DkYlI+ttwjoq0nUHjRi3CSXUnLtuBujroKVG99uZwK/WU8fr56
	 1YaClG9RwmOqFAvmHysbmVZMODUb0SxIq4DqpoGava+C2SB+EOsXSV+Daq6L+vOvJN
	 9mcRrhoq800fekdxBiI6PYlEP61X4M59fW1bKz4kxW/2ZLqBHQkxGXmyAuU6vzwT4a
	 LcCrRuaJLb8SQ==
Message-ID: <6f76d0ec-a746-4eaf-abe9-86b51d2ff9db@kernel.org>
Date: Sun, 16 Nov 2025 12:50:30 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] loop: respect REQ_NOWAIT for memory allocation
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, kch@nvidia.com
References: <20251116025229.29136-1-ckulkarnilinux@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251116025229.29136-1-ckulkarnilinux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/25 11:52, Chaitanya Kulkarni wrote:
>   6. Loop driver:
>    loop_queue_rq()
>     lo_rw_aio()
>      kmalloc_array(..., GFP_NOIO) <-- BLOCKS (REQ_NOWAIT violation)
>       -> Should use GFP_NOWAIT when rq->cmd_flags & REQ_NOWAIT

Same comment as for zloop. Re-read the code and see that loop_queue_rq() calls
loop_queue_work(). That function has a memory allocation that is already marked
with GFP_NOWAIT, and that this function does not directly execute lo_rw_aio() as
that is done from loop_workfn(), in the work item context.
So again, no blocking violation that I can see here.
As far as I can tell, this patch is not needed.

-- 
Damien Le Moal
Western Digital Research
