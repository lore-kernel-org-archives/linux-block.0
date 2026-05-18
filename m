Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF5E3E3C7A;
	Mon, 18 May 2026 09:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096854; cv=none; b=sv+89qCARSZxKfpl5ylFOqgd2dmlfm4FF3Psj6O5apmvBsJhsfQxB5dE0pwQM6PYpxBCYj07o6ghPZMoUnMcrCE8VNQk2UpO1lu3BiLojHIY8S7JeISoiU42k4CS+Vx7xhfMyHWF05mTgt61EcKHHtOar1XhKPDEJM8N1Uv6M3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096854; c=relaxed/simple;
	bh=BOMTqJ26QtMv4Cg79EtgB/2A7khoKAvwAwceJXWkTS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pub8LMpt4duulAO4p63H5OFpx1nqy1XbQM0aPQZAWYv2ETaJlua0z/C0ecX+VMmR9TkKkoMB5CifYMP2rBPRx6VkjRXJfCtqFxLM2NPj6bB541HXNHTGvqJGc10uSgnrrU2ZSPfRKQWHFOzeb0bn/XP+lBr5VmyAyBPpGPd91HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kj0gJdFz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kj0gJdFz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F532C2BCC6;
	Mon, 18 May 2026 09:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779096853;
	bh=BOMTqJ26QtMv4Cg79EtgB/2A7khoKAvwAwceJXWkTS8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kj0gJdFzpDxQvEzAnxfjuWsS849r/hHk58CEr2mfX9x2knapxNHC+oZiT+hi/ea1O
	 hiKnmAQ4N5H/AyMC1ukdIzqMFWuPPzYohjkkpao6sODGO9rNeM5c355cSJPZXyNhi5
	 5AI+v0n6zOOknwVFBtgLnAKaMhfV1e/PlKJLHiX+IAi+KPF9rhu3pFHhFMwHnv6Zj9
	 IcgBkoGkSKQcLowQMaeBBIeuxeBHVJkJCjJIwFlnQHGkTUKPxBrjUSY+zEKWrS28Ri
	 BNSkK+XpgByecdZsCQQsdoyh3sfHOLga6c8lOKyeQghtTzVR1kS8TlYnahFRjhsDca
	 oMRa/ChfP0I6A==
Message-ID: <e20941eb-da39-452d-a2d9-bd67c1a4ada3@kernel.org>
Date: Mon, 18 May 2026 11:34:10 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] direct-io: remove IOCB_NOWAIT support
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
References: <20260518063336.507369-1-hch@lst.de>
 <20260518063336.507369-2-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260518063336.507369-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/05/18 8:33, Christoph Hellwig wrote:
> None of the file systems using the legacy direct I/O code actually sets
> FMODE_NOWAIT, and if they did this would not work, as the write locking
> could not handle the retry.  Remove this dead code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
