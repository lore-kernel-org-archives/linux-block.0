Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9C81E32D6
	for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 03:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784950855; cv=none; b=DvBVc51bGmYcl8wFX5xZN/APhYgOyH3gyQoQUIow9D5eMvQWPLUwwuXZfxzMPvtCF3u2yagr7Iud+czCYNCtpHeaUcj3GfSiSX3AmV4W17VomoQLhnBaGeBvDxYtfLq8y3uwPBIk3Q2zJ+BEsgrfPEN2mXChAsMtpDpPTvwOwBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784950855; c=relaxed/simple;
	bh=4YSSlMyuBy+xqXGXj8Tpv/4cW8UnYQeiG/0mlrVu4FU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lZ+7ubn+QIYuDLvQcCYQzzRHj4NwExZqsW5KHGAD4kSL1pVooc0BZ5EtytBS6BO9GHrtjV4qTpnxabYzCx1HyULYotoY6vLZEkEDpP+Z04mEY2g5PQNlOKfyc46niYxllXy70FLZSOt9IXcq/Z2ukfIP9SXJvIpVBpgJzdqu/Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eJO9iuM5; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eJO9iuM5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=4Y
	SSlMyuBy+xqXGXj8Tpv/4cW8UnYQeiG/0mlrVu4FU=; b=eJO9iuM5rZcCC9LCgQ
	y2O3R3ITt/HHM88b6esiVhQ8r90xAEcdP5zZZ13OapaBeI5QjD0q8iGvXiCvaZQp
	qm9dvXsfNoqDFLxgrzo4L7GBxIOhfNgf6AecybGo2jl2VE1E4C0zMqcfvZO4aeoS
	pxhcc4ui86hO7TP4Dc9b1fWA8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wA3oPghMGRqxxkJLg--.4927S2;
	Sat, 25 Jul 2026 11:40:19 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: efremov@linux.com
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	syzbot+619e27617b2abe6b9b72@syzkaller.appspotmail.com,
	Yang Xiuwei <yangxiuwei@kylinos.cn>
Subject: Re: [PATCH] floppy: avoid NULL deref in reset_interrupt when cont is cleared
Date: Sat, 25 Jul 2026 11:40:07 +0800
Message-Id: <20260725034007.2829360-1-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <27146f5c-5e57-44a6-bbe9-d910d8bbdfcf@linux.com>
References: <20260723073512.11120-1-yangxiuwei@kylinos.cn> <27146f5c-5e57-44a6-bbe9-d910d8bbdfcf@linux.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3oPghMGRqxxkJLg--.4927S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrXr15CrWDXw1DZFWUCFW3ZFb_yoWxGwb_C3
	s3Zw4DAw1UXa18JFsrKw1DJrs7CFs09ryjvrW0gr1xJ34xJwn3Gaykuwn8Zw18GrZIkas8
	ArnIq34xur12vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjgTmPUUUUU==
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbC6QPHWGpkMCM0uwAA3n

Hi Denis,

On 24/07/2026 17:42, Denis Efremov (Oracle) wrote:
> It looks to me that this check closes the exact reported crash, but it doesn't
> fix the root cause of the problem. I think cont can be set here with a valid
> but unrelated continuation while stale reset work is inside result(). We need
> a more generic solution to close the bug here.

Agreed, this patch only avoids the oops and does not fix the underlying
lifetime issue. I went with the simple guard first as a minimal
workaround for the crash we hit.

I will look at a more complete fix for v2. Suggestions welcome if you
have a preferred approach.

Thanks,
Yang Xiuwei

