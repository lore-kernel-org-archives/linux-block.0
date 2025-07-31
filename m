Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB7A1DD529;
	Thu, 31 Jul 2025 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753975795; cv=none; b=GxHQlIObfnQfAs3Jkd/vMhtMivp7kXucarNgdgAAciH/jLpSWyelzTFV2tKyRmF/x49612GKXKgZvjfOQNlgL+qfVglbduoJQyppdAgv99plIxkbe4mQ5QJVl69Q9yAueYeOd56sJU+48em6Kt73KsWNwr61+MMxZk6iGq37byg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753975795; c=relaxed/simple;
	bh=Dvb86TM9WVFDZNx7n0oFnWYg8k08SxIFt1k7gp3z95Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWPrQN3HfTmz4v5SS+2MZZNGEpxau5nq/jKwX71XKml1/nO27Gsnq+ArpB2RY/cxCGF00071vf7SFOH3fVHLx7s/2A+oQxwoRDWIT9A4Q3VBhGIEG7NufkykBuFTEq4Ub5njrORq4SsPF/z4s2WReppzeUeCCj7OTzXK+H+vOuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=2fEYzxjp; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="2fEYzxjp"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4btCgh5xSyzm1Hcb;
	Thu, 31 Jul 2025 15:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1753975790; x=1756567791; bh=xQRIHmeEidmmr3xvfnQM6kAn
	c4SlI1EPCVjCZw3NRPg=; b=2fEYzxjplvAfmVkNIGvySQhxqD9Q4wqkibkVgKpd
	3/mrX86Mpu5Ll/B3Qxj5DogrJvQNCbkL2BzPhiQk3zjbVMHQzeQ0dJg9Yl0im9Tm
	C/JYlgLsrzXGqwIS3qX3IyT2dthejrn9+NY1D3BNLab180I2Lzf5VPnmBEG3Mu52
	DAFYRDyhgxFHXJrf1iD9Oo++cB58XF9UEzeWlfVBs9qrYFQegP+u9xHST+IVcW7y
	eYpVsj4tkw7cwtE0GPsUhYzSYjewZcFk7zDlHRPg4hW6xfraaUdRXeZVpmake1Mu
	0iJwE8za1XWoqB/A8tigvRoVY1eaCNKMysnUQb4DOif9xg==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 1mtbCr0qwDCR; Thu, 31 Jul 2025 15:29:50 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4btCgX3p62zm1Hcj;
	Thu, 31 Jul 2025 15:29:43 +0000 (UTC)
Message-ID: <4b24afa0-7e3c-411e-ae29-9ba58ed86386@acm.org>
Date: Thu, 31 Jul 2025 08:29:42 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] zram: enable asynchronous writeback
To: Richard Chang <richardycc@google.com>, Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: bgeffon@google.com, liumartin@google.com, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org
References: <20250731064949.1690732-1-richardycc@google.com>
 <20250731064949.1690732-4-richardycc@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250731064949.1690732-4-richardycc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/25 11:49 PM, Richard Chang wrote:
> +	bio = bio_alloc(zram->bdev, 1, REQ_OP_WRITE, GFP_NOIO | __GFP_NOWARN);
> +	if (!bio) {
> +		err = -ENOMEM;
> +		goto out_free_page;
> +	}
> +
> +	req = kmalloc(sizeof(struct zram_wb_request), GFP_NOIO | __GFP_NOWARN);
> +	if (!req) {
> +		err = -ENOMEM;
> +		goto out_free_bio;
> +	}

Why are 'req' and 'bio' allocated separately instead of creating a
bio_set with front padding? See also bioset_init().

Thanks,

Bart.
