Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC032F9995
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 08:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762936618; cv=none; b=qaIFEf2crst8/Tu+42VUpvRQks/7/2uA+NiTxMnAiLCX9SG3phvzYxxRBgFkysCeY6PGnMbaYGz78l0m28A6qS4zdPBAs8i1QPDDeoixFGL+zv80VxsVgig0wAKnyGwXE8D1WezSihtqxSveVTtRfN5fT7Qd3fmLvgLoQthCK6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762936618; c=relaxed/simple;
	bh=1gn1MoFCZohELftcSPrstcPguNeetnIaK6xhr48NiFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EOfMTUkHYPRrE5MjfFRofg+jH9pVdZWqFkCePi1P4Jiy2vRHEPlvsSyGoH5ZqFCJRfcKlOwCFWgohsO6V6emm/PYzEdJfs7fX2wLrRpeP+mss0SMnYGHuUXIw2d45E2ZVOqg54yT2A5/jPhLEbgxfehHdyg2pp26BhpRobm2m/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7WUQZ1L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7WUQZ1L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7CBC4CEF5;
	Wed, 12 Nov 2025 08:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762936618;
	bh=1gn1MoFCZohELftcSPrstcPguNeetnIaK6xhr48NiFY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I7WUQZ1LQNK+sxuYui6/r7RJTOXUvddHSsFpx4S6RP7qiHtbJZH++OZ5Xe7tvcj4E
	 BMzJER6i7pA495z7wJnTMiRXut2fpZphECCsCLBILjS6dU/yjlsWenOn3797YiyIFu
	 YcWwrmndeTJp9X/yl3FnvBCay6xJQY+CndbRdlCehWhlgQUB+FzxBK+QsJxxlo6IPA
	 4u3slXBqK4tWmngRRbrg7QjwdfPazceGtpYOOdaZmHbR5ACnAN0P9sUTiBbDewKrRu
	 0h/zP1yX6EKSDEtHoS/1JxlfNnmZXqfEfpTg3HjjYZD5ZsE+TQcAE74urmqOmTYu0f
	 C5WC40T5ZS6ug==
Message-ID: <171c72ef-7495-42a1-858e-bb907fc92338@kernel.org>
Date: Wed, 12 Nov 2025 17:36:50 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] blk-zoned: Move code from
 disk_zone_wplug_add_bio() into its caller
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20251111232903.953630-1-bvanassche@acm.org>
 <20251111232903.953630-4-bvanassche@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251111232903.953630-4-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/25 08:29, Bart Van Assche wrote:
> Move the following code into the only caller of disk_zone_wplug_add_bio():
>  - The code for clearing the REQ_NOWAIT flag.
>  - The code that sets the BLK_ZONE_WPLUG_PLUGGED flag.
>  - The disk_zone_wplug_schedule_bio_work() call.
> 
> This patch moves all code that is related to REQ_NOWAIT or to bio
> scheduling into a single function. Additionally, the 'schedule_bio_work'
> variable is removed. No functionality has been changed.
> 
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Damien Le Moal <dlmoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
