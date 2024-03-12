Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216866997F
	for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710231445; cv=none; b=WQ+u4d9hdagDTSgoQ3EDYnd4JIF8yh6wGedVnwv1MuUijF6DUi9PDR5LeFHnK35jWvUmr7nKGyL5aiyXIwB4Pvpa0twaFIXPGuFtOsjklGc5iSbjhWmmhyFT/WZ4yCi3wkKjVot4nnLu3ZsBaV0gNiCCOon6fVuhAob0sFg5ixw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710231445; c=relaxed/simple;
	bh=Y4CcAgqo2YqwQFQ0Ceo6KXM6LL4DBAAXCFDSiBWK/r0=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=LpjI4LrI+vRbH5OQy8p0Haxwwh6TbdlWBTwMmtyWypitmRAcah10gIDAxiebRiD1Q25J2wnH6UNG6iKq6oQ/sduUfpCLzTJE32uJ+YTXZaBi5W2a0Heno1QIJ/MkJFpnD7CUaja4fyzry8YG2ffVm+T+AMcKcsnMEvQzftvsMMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8LjrG+/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8LjrG+/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C10AC433C7;
	Tue, 12 Mar 2024 08:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710231444;
	bh=Y4CcAgqo2YqwQFQ0Ceo6KXM6LL4DBAAXCFDSiBWK/r0=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=f8LjrG+/OiGTgYNCrV8P7EhBoBo9OK0w2cKOVuH4UxFH8KDikH5wZnJNa8Y4vLz/8
	 FCOaATm5SbQ/W5FPc5skzMpVSgj7xsALHC35PGmCNXf6LCe+bUdpTw5VAl/trINV/A
	 J1vSFhRCeexC5cvFhi8iGM7EXWyTUPhO/OBVEpdWumTRjeS3222AIjmVuo6jiavU7N
	 8+evnWQBaP+lAEi0efjZmSV+sYPsAZsFI/JhwNEEEU4vMgR74ZTAUG7GiQvInLogIe
	 l03lqXvu/7mSUSQ6DtpTL1bu38OnZ13SnfO8jzMyd3dv8BCLfuqgRTh2CekAY2PZIz
	 RMW/8cEGLzIYw==
References: <87il1tqhbg.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20240311130535.GA31537@lst.de>
User-agent: mu4e 1.10.8; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
Subject: Re: [BUG REPORT] generic/482 fails on XFS on next-20240308 kernel
Date: Tue, 12 Mar 2024 13:47:04 +0530
In-reply-to: <20240311130535.GA31537@lst.de>
Message-ID: <87frwvrhin.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Mar 11, 2024 at 02:05:35 PM +0100, Christoph Hellwig wrote:
> On Mon, Mar 11, 2024 at 02:20:31PM +0530, Chandan Babu R wrote:
>> Hi,
>> 
>> Executing generic/482 on a XFS filesystem on next-20240308 kernel generates
>> the following call trace,
>
> Please try this patch:
>
> https://lore.kernel.org/linux-block/20240309164140.719752-1-hch@lst.de/

Yes, the above patch fixes the bug.

-- 
Chandan
