Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8FB318B9D
	for <linux-block@vger.kernel.org>; Tue, 14 Apr 2026 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158908; cv=none; b=NebbEdCdrW9m4F+Cil63HCENN/eos8kWL+99d3F1YKgCTfWvT7DIlQz6n2EBJ5KY8mJmfLF2SByg7LSPKUpfsHbo2MSCFa9xIMHtJa0UCPQgZcORiF/IzKMy8c4KCQvvECGuq9nBCkLUWsrgIMA8+PcwJEiPYmP9TuBUJFm06FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158908; c=relaxed/simple;
	bh=2EBuE01usAV3DiOBSAXZSbtDbx0xzesm3vd0gdSoMcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4teVpxnShr0GExhbQUE+6Bu6clV6nKCV6+EDD1DTaQp5E1X4KKv2An+E89+dv9pxNO3r/8/9Q6ym7Xkjg1UvivaI9N+GLNN3sWHc/fwKnkDAWozkknHbzDkn1ffTs1yIpCkqDFkYEhq1dGh0hrTE6LJR9Nq/tbCQc8RlY208Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAe5Im/t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAe5Im/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0520EC19425;
	Tue, 14 Apr 2026 09:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776158907;
	bh=2EBuE01usAV3DiOBSAXZSbtDbx0xzesm3vd0gdSoMcU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IAe5Im/tkimmif/3y1GdOu8qU+ziLCZI58kpFcP0yp9uFEW4mQuh8RTij+S7Mmi6G
	 KU/9GgpeDIlUyF/PSLlkwRwHv70GZt5837wDONm2vhxfQt9pxQYVteg20JzOj715OC
	 TylLQopnQExttEofYKJ2vzO6+dE+A6tBndzczajiS0f0ZOI8QxIsj7NwxI1UZ7Dl3s
	 dQNuiwrwIlG+hjTKvgIiI7m8NSvbhos/rmRy4tzh1PcZzoGvBmh7LSU6i+Bpq7bXnM
	 qx+P8PvzLvH8IPda5b90Wtfj1aeoehoZu3kXOGIpXjzHaVN+Dx1hwcXwY5SySXzAAa
	 pKXfGk71h4FYA==
Message-ID: <78c39a80-f950-4940-9b39-8c0a515dab4f@kernel.org>
Date: Tue, 14 Apr 2026 11:28:25 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] zloop: set RQF_QUIET when completing requests on
 deleted devices
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20260414081811.549755-1-hch@lst.de>
 <20260414081811.549755-5-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260414081811.549755-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/26 10:17, Christoph Hellwig wrote:
> Reduce the dmesg spam for tests that involve device deletion.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
