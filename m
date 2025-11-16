Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06DA12B94
	for <linux-block@vger.kernel.org>; Sun, 16 Nov 2025 03:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763264693; cv=none; b=WihmYGSmnCzsKOZfetsnAvSYvgsWXUC3Q5bS338aIDYQHBEJXStiZFL4EhmQ+0x1B56bTWD7O5YjbRMXX0QQgJfeN4or8+zzy0zrbrnJ64pBihwVa9bFYn6qjw329tl4Mv+smqKW9JlyEUzDlGIm+r55xf/sxzL3os1oyHCWnLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763264693; c=relaxed/simple;
	bh=ttPRQJsZMRjc+5coyuiKcBuzjOUKFheGTwZbeSxK2pQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3juESiCmxq+DrWzgSjz77rqXceWjK9a8zYRD4ydZxG8bVtH6tTM+I/47JTTt0ki22VZJspeKcc+8Yo+/AqMhJWjRZwSnWP35Tz4ekB45XNzp71PSh3bs3hfsP+yEvvLsAWVjscHvXAG7La3bsoLrVgLRAIvto7tG9WhzYkDKTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKH53nQg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKH53nQg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748D2C113D0;
	Sun, 16 Nov 2025 03:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763264693;
	bh=ttPRQJsZMRjc+5coyuiKcBuzjOUKFheGTwZbeSxK2pQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gKH53nQgsGdn2iwTBo+Y0xn7URb0EeeXuW5pJ1/bdGcMpBPu4G5cjOGnPxQev2FKA
	 7+HfSf2E5mF9KpCsOr8Xun5umDzVRc3BO2bxPjhMHjEvV26IlzrwvcSosDAZmCrPbv
	 c5+dbnoA8zRoFavPOzB0zHCJVznQv+e80zL2bikecqOLNwkESKuX5lCobuWuZmM2bv
	 X8iJrtUgUT3rPaDYF9xEMaselic+RzqCTNW5biYAi3AZRwjjbgVludrh+ZSQEEtnv3
	 gYIWvZwyk5uq0dEf9Imzoeuv4SKb7BZtFKqrYxlfKEdDY99Zdf/aK38fpK+OZG0Rf4
	 bRUJ+X8cyU+Jw==
Message-ID: <5631b99a-dd89-4f89-a5ac-e8a445ae954d@kernel.org>
Date: Sun, 16 Nov 2025 12:44:49 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] zloop: respect REQ_NOWAIT for memory allocation
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, kch@nvidia.com
References: <20251116025229.29136-1-ckulkarnilinux@gmail.com>
 <20251116025229.29136-2-ckulkarnilinux@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251116025229.29136-2-ckulkarnilinux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/25 11:52, Chaitanya Kulkarni wrote:
>   6. Zloop driver:
>    zloop_queue_rq()
>     zloop_rw()
>      kmalloc_array(..., GFP_NOIO) <-- BLOCKS (REQ_NOWAIT violation)

Absolutely not. Please re-read the code and see that zloop_queue_rq() adds the
request (zloop command) to a workqueue and zloop_rw() is executed within the
work item context, that is, a different context from zloop_queue_rq.

So this patch is not necessary at all, there is no blocking violation as
zloop_queue_rq() never blocks.

>       -> Should use GFP_NOWAIT when rq->cmd_flags & REQ_NOWAIT



-- 
Damien Le Moal
Western Digital Research
