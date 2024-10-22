Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B4E7F460
	for <linux-block@vger.kernel.org>; Tue, 22 Oct 2024 06:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729578790; cv=none; b=DQZhQ7LEg6wasV9KehkZyzLXCnB/EA984SF6JAIsoIbLRhOSjZ7tfrhJanGLVnLD6rM2n4SnoSTkvhCjP1hlLlG8j7XANXS+QvepTlj5xJe75E66wnxC4FuiCvzCY2Y7tITe1giXPlz7PVjogrzzMhpznOAygWNeFt266Ho062U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729578790; c=relaxed/simple;
	bh=AC9tJ2nFp4SGtHALUPMcfQs4hHc9AElyN2mcfup589s=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eUUw/snJau2Que3hjuQBiL460Q2nzgf+3wOSnqomIMmplQqbrxU/rS8inUCFDqSNpmPHHkPODHKXuqSLY2JZiNScJHLbbPKbc3kXLD7K0xbR12QCX7o38/ot5mRuO+W8BuI8DyRwLJ3PS0JW8/HOlMxeTe+guZEEElnpXD9qhU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vCMj/rhr; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vCMj/rhr"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729578784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4qjMWGm/U9BUvuXs53nUhhk2P2eOgQ21koz66cHzG/s=;
	b=vCMj/rhr23QaMD9ASuemrIZwhoCSmAQhISszho0zMtBFf4pfkF1XU0kUOAkiaPzhtwiy6B
	HyK5uv2Q3pC1+jLqLAEkJSd3zuIBQCsd/rUz3/8UW7YWYHZWYiiS+LpDGHpocXx1mrKEki
	bya4qu9ophNtY94WXF9c2Wee2E0mozQ=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH] block: remove redundant explicit memory barrier from
 rq_qos waiter and waker
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <ab3720ec-b12b-4c0a-8e56-930753c709fd@kernel.dk>
Date: Tue, 22 Oct 2024 14:31:53 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 josef@toxicpanda.com,
 oleg@redhat.com,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Omar Sandoval <osandov@osandov.com>
Content-Transfer-Encoding: 7bit
Message-Id: <7C429559-E91C-4732-901B-0D49C2D083F7@linux.dev>
References: <20241021085251.73353-1-songmuchun@bytedance.com>
 <ab3720ec-b12b-4c0a-8e56-930753c709fd@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
X-Migadu-Flow: FLOW_OUT



> On Oct 21, 2024, at 21:45, Jens Axboe <axboe@kernel.dk> wrote:
> 
> On 10/21/24 2:52 AM, Muchun Song wrote:
>> The memory barriers in list_del_init_careful() and list_empty_careful()
>> in pairs already handle the proper ordering between data.got_token
>> and data.wq.entry. So remove the redundant explicit barriers. And also
>> change a "break" statement to "return" to avoid redundant calling of
>> finish_wait().
> 
> Not sure why you didn't CC Omar on this one, as he literally just last
> week fixed an issue related to this.

Hi Jens,

Yes. I only CC the author of patch of adding the barriers, I thought
they should be more confident about this. Thanks for your reminder.
I saw Omar's great fix. And thanks for you help me CC Omar. I think
he'll be also suitable for commenting on this patch.

Muchun,
Thanks.
