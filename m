Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2097A2FD7D3;
	Tue, 25 Aug 2026 22:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787696977; cv=none; b=rfUAVh38TPv4K/H786Xtr++cI5JrizbCli8+mr76ZhjIDFPdszLDZeIgaQQuoCoqXP31126kOY4ybW9bXNcMsUucafL/xk1QLKHGKkIiwWg/2wSPxFlDI1P/4jHhboaN1SX6Zgy+G1abudqNxtJPQJHK0HxJYFd9jaD979K/SvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787696977; c=relaxed/simple;
	bh=MualCh+nq02q+4mlfUIoBWO/WZ66xbPpaBAD1mMErmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VuwdYVAm9n5W9r14pZW01iOHqdOwiGCxZrVNtF1DUiML1b4/dVfaPKCNTkhParBC2djLU/7hAzQkfQabkujZwV+TpauHTAUoBHQiXEB++YR2EFVKmJKR4BI7EYWqM9VGSnoLeUZ2Rov4PKh3GfJcoJlbcAu4lQg/jKLvYSPwiIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Rl14/mNL; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Rl14/mNL"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hV2Ws18fFzlfvqD;
	Tue, 25 Aug 2026 22:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1787696966; x=1790288967; bh=MualCh+nq02q+4mlfUIoBWO/
	WZ66xbPpaBAD1mMErmM=; b=Rl14/mNLVTbK4aPWCW/MlfJOObWGGb6atzqjP8Uh
	e2NrNb52V0XamP8fj5qgcVvuWBaxEq7SfL3uYqL/lri73HX8OuqPXzNJ5n6m+Ddd
	kMZXhMPgSgVO2m/KBW96TqiC7QF10LrQRQNLdHZjbkXCg2XDIx+c1GriDILxmz4b
	YUCr1Q2khxxoXACc2QwyZX37oWfNM+yvqatxttqzLuYH+AIcLo1egIvsyhDwY4if
	pw08lt8q9SmmwKu2BRDrz0Gv/aos+0zagCN8vyt6TC41KjwFwPAGhbB1ispUL9VI
	IGEd7+5GslbxI0Ag8ymjDzbB4dhLMY7Dk6IhRWmW0QAi9g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id HAx3rGvDsovf; Tue, 25 Aug 2026 22:29:26 +0000 (UTC)
Received: from [100.80.227.50] (unknown [104.135.182.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hV2Wm6r9wzlfvpH;
	Tue, 25 Aug 2026 22:29:23 +0000 (UTC)
Message-ID: <a08ff061-87d1-4589-b19e-8ce4540e0bc0@acm.org>
Date: Tue, 25 Aug 2026 15:29:21 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] loop: three small cleanups
To: Tao Cui <cui.tao@linux.dev>, axboe@kernel.dk
Cc: hch@lst.de, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tao Cui <cuitao@kylinos.cn>
References: <20260825125720.181793-1-cui.tao@linux.dev>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260825125720.181793-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/26 5:57 AM, Tao Cui wrote:
> A stale kerneldoc reference, a simple_strtol() left in the max_loop
> setup code, and an unused function argument.

All three changes look good to me, hence:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
