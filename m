Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0B2376BEF
	for <linux-block@vger.kernel.org>; Fri, 29 May 2026 17:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780074228; cv=none; b=RZeLa/XwfJlhh2BYkIqCYsvHlf7qFDWNg8ElsxNeCLM1RSkUryMan5euM61Z7w6qBXgGwWiteRFzvX3GEMdBJmJ53rc45rBxRt2Nqk+nsWwA/C5LoH0YFkGqu6RLltUZviBnBzkUkru5qO9/4+6XymB7Csrous5lcghMR0NFm5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780074228; c=relaxed/simple;
	bh=0bpXXklLhkKuaEX9I4SuDKwKS8LVUaRiVhjLPzt+ivY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=q7UPZKfDQFwIFRrMdex4B6pSm+x8TMPVJzTxkVr2HF3HyiXGUKcUvDfOI9EKNgQDNt/+YnNhfI9ZqqY/6pOl/JaRBS7UXyRDNpNUFJCRSIm7KvTkW/r7xjHzDfZuht1nVVSxKpwLUljjCUul6GJYwhTnsl4hKSRT1Pf1FgGykQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=rYy2VJ45; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="rYy2VJ45"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-459bf19e87bso8576395f8f.1
        for <linux-block@vger.kernel.org>; Fri, 29 May 2026 10:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1780074225; x=1780679025; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcGLH/EQExlMx8LK97cIOOOdFdV3nFNyIpOuQ3UkU8U=;
        b=rYy2VJ45K3SVaBmrDg9yaRado/XgLvUIvWMxJsHfZNd/Hzl2CNEVYlVkOFG2iny5LT
         W9LT7mI5dgCYL9SFo5nOMYdH0WnOV/2sV0Fvxke8zGYwXunLsYXxkK0rAgWsf/XPs22Y
         RvIsuG+osHTTv+7cmffd5t+aJCN3lPOWxob8Ute+EiZ35wf7bLwwwpBkpPTNdAr5MIMK
         1nqWnVGviNhuOJdGp8caABVCYjvN40ydif6hjiL+BfPsDecZFZ2pMP44EbcraDd3ic2S
         vbP+PkuiNYb4ck8J9otUD1SxkrUhiSHHdwp6C6p6uP7Hkall5hn/yDsz/92hLpFq6aZA
         cDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780074225; x=1780679025;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KcGLH/EQExlMx8LK97cIOOOdFdV3nFNyIpOuQ3UkU8U=;
        b=cH/dEMDrcZl6yIFXEaeItYw4as/3lWQof02XYEJ/fPYp1u+E8gQhq0kuhtTNtRcABz
         BXw+CEtrUYgmEjXGBAMpsr1E7Mrjodz2vXaDld5qED12CgR99auYNxnuAtUIM3TGIZIA
         HWMh3IxLYFzE8h8KqZNT/z1KiEkXn0/JPXvi93HwBnJnIwyjOOA28iGWWnDlx5ZY5EMK
         osw1ayyuusXKBKweY4GaOCWdex0VnqmyLo2/2ueeQZBdOjT+Hbn4YQ3EnN9xAtIw+X3J
         8mMTtgrDZPUhgn6I+R6/jGsiK0XHHhydRlnYOA4ueI3v00M06FNMxxpSfnXzjpw3XL0k
         P/kw==
X-Gm-Message-State: AOJu0YxP5Dq/bhRNEfjV1S6Wyt8VolnenMGE9fjN8LvydHxqqazTjmp+
	FUoDAsvDfw0PS/wRV4WE0qTTaNZMsIBTfZYxZt6Vu1ZjLxfYkvnQnPcg/hP1EIv6C9gWNL60AyD
	UXThr
X-Gm-Gg: Acq92OEKYiJJhs9SEOuNkZbEcdk40mpnlY3mBcxMKpD4LaARdVcdQ7G5sfkSZLpscGF
	j3i5rnmytLHffpi6Ls4hPIsCNsRQeNccS326iezUBbMr4dNosrqyL7mNzEUnuG3KYxDovI0ncUY
	aFu5RqA0iWCo7W5J8A7K4hzMFmfBriIr3JJed+/tJ+OX8P/vI9+l5uu2soGRBmqVHI0En7bJNJP
	Ax7EY6Gmt716ytDN9GYOkXamR+1IeykQY9Rf3xQmNtCH4DADSO4+RKEnUjlqnW8KcIL7b+/oQtr
	oS70o30aLTRkdmhzZTDwmqvZQM71ZXNN/AAA4oxjDjhypSExCn+924AQftJZf2tCHXYbH/dwbAI
	pXKML3M+8EbMh+rhQZgY+LPLbvW7FHHOJl1QGlSH7NiMOx0WEs9oDtq8py+jtMz9u0qyM5uV/bA
	8nGciGQ0Yl9DzKi5yNAN3FbaGClHVaQbEQuhGNZ5rmyVyqFNp8YzlkLsPQm4F9uIFN7RkaiEAAO
	nnysX2gX8UpD4F/Mm2QHac3io5AVMHgVEoOBSC6Pal1Lop/J/0=
X-Received: by 2002:a5d:598d:0:b0:45e:a19f:22c1 with SMTP id ffacd0b85a97d-45ef6b19af3mr1319158f8f.15.1780074224764;
        Fri, 29 May 2026 10:03:44 -0700 (PDT)
Received: from [172.19.131.179] ([216.250.207.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef32fabcasm5059632f8f.0.2026.05.29.10.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 10:03:43 -0700 (PDT)
Message-ID: <d12b120e-0628-4d5c-a36a-7618f752250d@kernel.dk>
Date: Fri, 29 May 2026 11:03:35 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 7.1-rc6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Just a single fix for the block side, making a slight tweak to a fix
from this cycle. Please pull!


The following changes since commit f6982769910ecddabdb5b8b9afdab0bb8b6668ac:

  block: avoid use-after-free in disk_free_zone_resources() (2026-05-22 08:01:52 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git block-7.1-20260529

for you to fetch changes up to b051bb6bf0a231117036aa607cadf55be8e63910:

  blk-mq: reinsert cached request to the list (2026-05-26 15:05:30 -0600)

----------------------------------------------------------------
block-7.1-20260529

----------------------------------------------------------------
Keith Busch (1):
      blk-mq: reinsert cached request to the list

 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Jens Axboe

