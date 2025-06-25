Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C011DE4DC
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 21:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750886301; cv=none; b=p3MuJdWsiDCNqW6ryldHPqNzNxRKvhLQA6fSOz1odvsRo3XiWjwSBa3FdBRf0/qNW3I1G5+KfF4ZV9BBgi3STMeR0Bq+N43dbOAq2cvtkO2iOwiijHdODmjxh2PJ6BS2H3iN7h038uzruvHJdTLAFp8MdojqzgpbeAJ4z2jI4OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750886301; c=relaxed/simple;
	bh=m5dQzTuvbbtJR8qBze1MieINz4Shsgq0Ke6bwVMXZXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpd1thbVEtt5myKhR5Q0Fx0PQ9C4r2/KOanwcwOb5gky7Tus75zHVbBDs1DL+YOzhvCF1kut9gmqGTdByCuhgdiRk8GM8jMpwOfBovT+icEo//vLPl913/JxTinnDYIIt9D53gvXSRW0HmuqYmrMQrgowpHm0L2PbvvNjr7egJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvlapTTo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvlapTTo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA48FC4CEEA;
	Wed, 25 Jun 2025 21:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750886301;
	bh=m5dQzTuvbbtJR8qBze1MieINz4Shsgq0Ke6bwVMXZXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AvlapTToZQxcbDnOyv9k9jp1u5tVw0L2Q3WnZ6SwsIe0JdvJ4UQetIj1AQVl4Pc7B
	 ZawU90p4NVsBN3VzCwlanCBJI+k29ukaw2GnjrWcRJMCsKzHshDg3pZwgSgprnuDr3
	 TAcfB3NT1ggDzQwv9Xr3FDQxK2I6ed8bcPBba2yed753IB2S0eFR4Hinf15Q7eKC8W
	 sLvOHwa+vvo+mx6dVYh3gKwYCal94jHMbmKON1iIkSX1NTiEnwf5PyJbNnNUw6hEnY
	 jTBBlViOfaOW+QVV2KQy3jFa7qRy6QRt+nHN2iZtncuUb9wnaUGkHp5I7L2VZIdjO7
	 jAuywK4s40VmA==
Date: Wed, 25 Jun 2025 15:18:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	axboe@kernel.dk, leon@kernel.org, joshi.k@samsung.com,
	sagi@grimberg.me
Subject: Re: [PATCH 2/2] nvme: convert metadata mapping to dma iter
Message-ID: <aFxnm0MX0G7Knzcg@kbusch-mbp>
References: <20250625204445.1802483-1-kbusch@meta.com>
 <20250625204445.1802483-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625204445.1802483-2-kbusch@meta.com>

On Wed, Jun 25, 2025 at 01:44:45PM -0700, Keith Busch wrote:
> Aligns data and metadata to the similar dma mapping scheme and removes
> one more user of the scatter-gather dma mapping.

One thing missing from this patch, it should have removed all the iod
mempool's since we're not using them anymore after this.
