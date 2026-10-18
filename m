Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEA735C6AB
	for <linux-block@vger.kernel.org>; Sun, 18 Oct 2026 16:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341404; cv=none; b=tAbQa5RbxQeC5vUAludVZV58hrtuyQZtYPRcqlLB7gp5z7VO0ZDHKgxAkZLSVWfPPa3TEjcikZB/TtoBkiM6fmz4mYSkUAxE6LMRPkshWfHRYEMOL942Uer/4UkmkbbXRLmisU1IshNjTzXPEisxRQ5OCNLmMs4d8Y8FhjA7Fu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341404; c=relaxed/simple;
	bh=3Unlnh0PNjqnXDYXvYR8smv2pg/9re+eFFyM9g2tMPc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bqFETl77MlQjwFijo2cP3iuxIRaAtRqY8QYqp9Tm5SePJUUCFnoaXKeKuB5C00MpGkvMFvCXTGhr253tKv8/+9RJiDJqutHPHZkAwCbTx69PtDWhei5K9PQHQUIvt6SLEZ1IU7DBFajgCeQRtVFAlb7L4OfMoBdw3NQyNlP2/pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 69IGaHRs095738;
	Mon, 19 Oct 2026 01:36:17 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 69IGaGB4095735
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 19 Oct 2026 01:36:16 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <933f7085-9bce-45e7-88e9-2bf70b71cf7d@I-love.SAKURA.ne.jp>
Date: Mon, 19 Oct 2026 01:36:15 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] block: wait for inflight requests in
 bdev_release()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <fb1e0f16346994e32b479e4be596436b2a614b03.1791234123.git.bvanassche@acm.org>
 <20261007130851.GA30117@lst.de>
 <4d7c7365-259c-402e-9cf5-d55ad9333200@I-love.SAKURA.ne.jp>
 <380f04ef-902d-4664-9ae3-228692d2efb9@I-love.SAKURA.ne.jp>
 <696e5e7c-e3f1-4181-be2a-8915fd1753cf@I-love.SAKURA.ne.jp>
 <cc2910d3-3113-44d4-94ef-0c8d365fac9c@I-love.SAKURA.ne.jp>
 <53c3ccf7-1a5e-4861-afc0-7cbfd3284655@I-love.SAKURA.ne.jp>
 <d05d7049-70a1-4216-b268-1c209834dc84@I-love.SAKURA.ne.jp>
 <e8d48691-9e29-41e0-9326-fff961b10cdf@I-love.SAKURA.ne.jp>
 <81c9adbe-14f3-4d1b-8a88-8b796e91f3a9@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <81c9adbe-14f3-4d1b-8a88-8b796e91f3a9@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav413.rs.sakura.ne.jp
X-Virus-Status: clean

Sashiko's review ( https://sashiko.dev/#/patchset/e8d48691-9e29-41e0-9326-fff961b10cdf%40I-love.SAKURA.ne.jp )
spotted that we should not try to wait for block layer's queue
to become empty before open_mutex is held.

That is, the only approach we can go will be to wait for block layer's
queue to become empty after temporarily releasing open_mutex.

