Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5901632AAD4
	for <linux-block@vger.kernel.org>; Tue,  9 Dec 2025 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765300896; cv=none; b=Yynagxj7Ww9HCDysM0V1gkkv4JvKUHrArVFwjzsYkMcEaTDECcCN9HWIbH2VOFpbt9/u+ubc9E6RRnuBzSsFVA4BuGDzzZkkehWRSdFocwjvPGxf+msWdTRz7yfxvP73oOy4Pk4L8YJh0Q3EZLoMRrovaT71JgaO14Fpkmw389Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765300896; c=relaxed/simple;
	bh=PxfN6IrhmJsY3FGoedlwbgk9sixTb5+ZEyyS77wtU7E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RVcUdjxFAtCtESs606CS/SKctw2msH8CB/WhiTLLRy/5GrxMrfKCcJLhzxOOVVJA3TYWT5KI/lxjk1KDq6/lAEMYbr+neCp0swt89RjFx4wwBQLD7y03Y0tq5PFVJz007+NS8vf0DfSt3DhtQPXobLa8nZ4TNSxK89TudnVwR7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1IFq9vuL; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1IFq9vuL"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-343f52d15efso5574639a91.3
        for <linux-block@vger.kernel.org>; Tue, 09 Dec 2025 09:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765300894; x=1765905694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rCsW9PlTAYIGULzV3a3bQeMbvWm/rssCDvYfHhy5jY=;
        b=1IFq9vuLT8BcaYEzHwCFYUamjWdAF4jJuX9BVzkpT7Nr7/M7H5/c2m1TmL7jVfGeJH
         /u692qOsoEryq3Qdz/lUcHUo/RsbLbNipVqFFOiNK1KhLh2O4Oq81N77eYuxP8gmMffX
         VoFjh2fJly141fPSewLKszypo+XEwqVHsimtOkWDH2GgcmvN7uL6OGHOwnC0P+J9iYSc
         CAyD22GOFO4WwLpENl+Oh8i66fwP3LSiUEwAyeWHd+o4RFxTaEtI7+gpqMNgYGIqpUAX
         haTdh7yOJuhvA+9758XILu2CJm9ZU2zHvR8+36w0vrXcjey8E4bxtrma0OR0CWxaH+xn
         jtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765300894; x=1765905694;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1rCsW9PlTAYIGULzV3a3bQeMbvWm/rssCDvYfHhy5jY=;
        b=ADjLEQnPZb2lfQgMa0F7ZKS16CxLNFJQXcPCd9MVkfB8/xFo/8DJQy12j7F5F2Tpxy
         an47qW796JfpfSWVrDZXxV6Y83/Q/7l20E/wW6lGpAokejMdcf2Q2/nkXw1WxdIJGoRu
         v1RzWPKn5LMmZqPzXqCBNIMyTTV/eC0BRec1E8nUn0Jwd2I+sfBIPFMXugNGt7P+F8OQ
         DRS1/PMh2nlu0+0oTgw2pDC1nqTs2iidkneeaUoF+KCoofVcMwmUGH7DKCLrJnNseDXG
         qbhUyCG5V/ZPd5A0yVZnZKPArv0uXZeZaAACiS1W50RXjsXTVHLFuOyvAF2UbxpDKtdd
         MpUA==
X-Gm-Message-State: AOJu0YxMyti+0zPI2x2t8+1JTH0mYkUb/N0LERQ2CQquKVMVtD4sZHzX
	3cd5MzYodo4NKTes57VfGUfswNNSgnzpPCoOw86bcPTa3iUEaD+E1oSdXErAyu1IM1JzOgDfebv
	F2DE3d3Xs+Q==
X-Gm-Gg: ASbGncukPNi5uMlq6K+N1ycvqjWZr99SvmNojaSk/Mrl4g+tDvzOgGovyiWhpLZN6zL
	1rk2ROc+9hpH/J4/CNWlLBkS7QL+VqtBu/+EjZFmLQAhYC+G4hmOaB+X6IzIp4SG8bJHYbDfLJJ
	w/ED+GxtVv2YMZJPU9i8BQIPpj3dqulGcniju9z2O6zt+qIGDgCE1e9qo1Zu6YZkOSSfmNRMmU8
	pEr15yQ7yXDcMbFLcyKNJ1bEVr6ux7pahpd/U84L+WlwOQ0NlFxYwFwvo8D1PkHTysVgyl/dSb0
	ITKznuwSKHbxak7E3SIyICLhaS3aCgtqEMM6pfsJqQj8+muk2PPYrEfpQjFENzBSzLpALcpTAiM
	vDx9Wc6uUMpbOvos2MTYFL9A+UpmeZNej7EEhiKv4GRX68ODelkfzPUjLnvvr/SEJnHqwzIvuBL
	y+10vokttLHVVZkZdwSMsLqqHojSof6KhakeDP2SXZv3ul75bqa/ccs6QG
X-Google-Smtp-Source: AGHT+IH6eqzKuOWUxreqhPpZimoHVZ2JHD7vpSeAoJZzK5vKnGNGqQwB+Pc2fWZI97x8Z5EiAlsbCQ==
X-Received: by 2002:a05:7022:fe05:b0:11d:f0d3:c5da with SMTP id a92af1059eb24-11e032bbdc1mr6698483c88.43.1765300893595;
        Tue, 09 Dec 2025 09:21:33 -0800 (PST)
Received: from [127.0.0.1] (221x255x142x61.ap221.ftth.ucom.ne.jp. [221.255.142.61])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f283d4733sm994549c88.17.2025.12.09.09.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 09:21:33 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Johannes.Thumshirn@wdc.com, hch@infradead.org, agruenba@redhat.com, 
 ming.lei@redhat.com, csander@purestorage.com, colyli@fnnas.com, 
 Gao Xiang <xiang@kernel.org>, zhangshida <starzhangzsd@gmail.com>
Cc: linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, 
 linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
In-Reply-To: <20251209090157.3755068-1-zhangshida@kylinos.cn>
References: <20251209090157.3755068-1-zhangshida@kylinos.cn>
Subject: Re: [PATCH v7 0/2] Fix bio chain related issues
Message-Id: <176530089153.83150.12817626967905322379.b4-ty@kernel.dk>
Date: Tue, 09 Dec 2025 10:21:31 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 09 Dec 2025 17:01:55 +0800, zhangshida wrote:
> This series addresses incorrect usage of bio_chain_endio().
> 
> Note: Patch 2 depends on changes introduced in patch 1. Therefore, patch
> 1 is still included in this series even though Coly suggested sending it
> directly to the bcache mailing list:
> https://lore.kernel.org/all/20251201082611.2703889-1-zhangshida@kylinos.cn/
> 
> [...]

Applied, thanks!

[1/2] bcache: fix improper use of bi_end_io
      commit: 53280e398471f0bddbb17b798a63d41264651325
[2/2] block: prohibit calls to bio_chain_endio
      commit: cfdeb588ae1dff5d52da37d2797d0203e8605480

Best regards,
-- 
Jens Axboe



