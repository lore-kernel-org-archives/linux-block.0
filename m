Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217644;
	b=rnfdk1GnFcm9EohU2cj0rx52x0lnohWUUF1o6l6JWztaGVYYSmjTk5ICMcviOfoovBZt
	 2OvhumflIvv8jp2pGYu6JaL+QMmJv/c2NrruUFE0izvujzOjgAp2YYPuuQPxHv4bU2osz
	 61n+vC/CwBzTsbc84DrUQ3wz6voYPCdiAIasn4hPG+aBaYBHcnuWc/Ndmn2C7twbU7G/5
	 VUSLdRFj2Jfqc3yCrnBkIFz7iWkizWFp4xKpiK8vZNRjg06GUuTshfT5u3VvSnQHVD22f
	 Y64sXkUGk+GF3wnWTcNqTJptXJbA907anlAX93mXepSMeApwzs+amGJ34R866dchryQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217644;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kqvaAt/tpd5C1Q82JB51zk4TiAzz5sUAmZ53khQ+gCk=;
	b=hGYkdsqAUiV305xwwwQ9kCoVZeKGYZEpm1ph6BvANriJrxJkev3RO1pxh3HONPHtWdzz
	 FhbDysxW5aXQ0uZERVqhzCowPrMejGI1T+M677v2JrIdU8Oegk2EJ/rWp4gchVhC9rUuq
	 MFh4ZA2WajKE4IQUK4hwDwX00OOhX9xdM8StiqvBgn8u0zw3yFJfm9GmBhcbNOd+k1SLY
	 a4uV4SFjHhCxON3qr1jbX2V/pHH9OOBicPnIXT+AGIaRx4BTKrNCTNuUTnRxqknBJKiaF
	 Q6fUQSxyMD/ov4SB4IJFCtwHvfy+H9EmV7E5Z2Q/W63JAhrEGc4/3zp9UiHavRfN+yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VUQi4UZG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D7F606A320
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VUQi4UZG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C251F01828;
	Wed, 28 Oct 2026 20:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793217643;
	bh=kqvaAt/tpd5C1Q82JB51zk4TiAzz5sUAmZ53khQ+gCk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VUQi4UZGpGEDOrHqGdp4mpAQlmVasTr8HaE0sXMhabjZGkNP3eUos4/ErjBITlow5
	 zrMVGXMcw89kwQXm4IbNoCYwvtHsrjmWR03Vs76V8wxzP7jRJ0W3UasAyQJUSMr4Ic
	 eYCugzfbuztqHy+WKzQzIcJ+KqryYYY5Lgf3Hl402oqgrH7FnuAcHvf6mDGKhU0ciU
	 B/onHaQ4yjzjPYhgGOrCOlzeuTCcyZERl4mjRfoB3kENWF1GNxLx4kDOI2BRyRIe3e
	 ElO08bGMcx3zfMXgKL4fF+XQ5j4+fhT1PG9UnYg1RoVy+8/9fO4ulKAuZz0XoylNW/
	 K+PJLYSTNnDAQ==
Date: Wed, 28 Oct 2026 10:00:42 -1000
Message-ID: <b97d0425c19b2bb4c2a102aab1fefdba@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 25/98] blk-throttle: pass the I/O counts of a dead group on
In-Reply-To: <20261028164415.1262013-26-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk> <20261028164415.1262013-26-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, Oct 28, 2026 at 10:41:28AM -0600, Jens Axboe wrote:
> The recursive io_service_bytes and io_serviced files sum up the online
> groups plus what dead descendants left in aux_cnt. That worked while the
> counters lived in the blkg. Since commit 7ca464383aec they're in the
> throtl_grp and nobody passes them up, so the files go backwards when a
> child is removed. Add them to the parent in throtl_pd_offline().
>
> Fixes: 7ca464383aec ("blk-throtl: stop using blkg->stat_bytes and ->stat_ios")
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

--
tejun
