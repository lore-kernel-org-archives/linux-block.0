Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DB310A35
	for <linux-block@vger.kernel.org>; Thu,  4 Jul 2024 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720080406; cv=none; b=J/4arao548GZPwxLYxO4W1vzti2YhoXOXmkcdR1M32znXDH9SWrYgtF4kXOaMsv7Qn0GOa73wD0Totua6jiL22JmFESoX7bUbVj1JRHx4PtdJ1iXTt23OAezTjsuckqceAV8h4b9lu1ENXbDKFe8OzND6OGWVMeBsc5WEYffl68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720080406; c=relaxed/simple;
	bh=5RGo4lFFt71IQiI1TCTzj0DbowR4sXdnqx/JKtHgaVU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B/ny5h6zNNqRmRCjHnKv9RH3/vhg/MF5Pt4YSKcw6ineMjRMEW8ATW9JkjZukc1xW9Kvyl0Q3KoG1VuLSeZQJPTIcG8iWqsMzUTxDFZmHH8RGTg1tnSf3T1iSH5eKZ7klFIVfrxGt9GpHwtS1Lu158Zq850DqnxyacVLgyKS2oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=i1VvMj/h; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="i1VvMj/h"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a77b04d7462so901666b.1
        for <linux-block@vger.kernel.org>; Thu, 04 Jul 2024 01:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1720080400; x=1720685200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InmbeL6o9ojNvDEesFGoWnpa2QxtU5BGWJEJVmI7xik=;
        b=i1VvMj/hmduQQJeDTi4fJVESMS9k8SxbbvwcrH+FwA3SFrRqofGqGGVChdpCA5xbxm
         kNisMwZMfF3x2Yma6HGnZYLS+BmcwTbeC6TChzrYafbegmLuWycPd0SVLVEPgobsJ0Ei
         RalWCkwMERDTROScozg5lOUts/wcHRDVmzxx0ySpLoF3EUt7MpelDcyhzQQhj4d+Goxf
         2Kv5fj7c6B1n6U1XLtxdF7W/yTctqIveJfXiNFZ9oPMzQPOIh5KToRM6Qwr6YHNDMbfl
         qyBxIGVkkknd/pTXKAuhPjHqkn/kQuZp6YahHqt0HkLgutvWsaNMYdMZC0iPUDHNuSNU
         z12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720080400; x=1720685200;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=InmbeL6o9ojNvDEesFGoWnpa2QxtU5BGWJEJVmI7xik=;
        b=AeFk5wq24rn9xgeUJEkfqFJDErxIAO0q8EaLcB/SsWDoD/lVbmLwzA+qPvlt2Zq/Jd
         XvkbDoAGTYQMFJ69ZTe+pfyPVILSDrqWP4s24fVt2a+z/+h7o1y3v145hgE2AW9x2fE/
         Uhv/ims6JMzuDiwkm0mHuA2DUm8wwQoZ2FVWHxS7+N92KaIolmjEXC6wOTpvlpXe/eKK
         K9dlX2p/3YuCjsrRi0IAYO6CtCoFqOK0nlscV5adJfIZfsrjjOulUOA+B1WvybFEg3aj
         FWteYdxl9FeX4G/bC/+b4LmSRVca0uPx3snEYIyOBrlU9Eygg9HK7Ik4a+G45DwKefRI
         A+hw==
X-Gm-Message-State: AOJu0Yx51qk955qDYnFvi33mRBtnAI4nOPHW1C+Dc53Yuy8hrBdvV8vL
	bxdoKvKEuTqE4kZGY0gHZ6tJpBDw5ttzUZlw2I9ZKAx3umfOUEeTKZbCe2lzE8c=
X-Google-Smtp-Source: AGHT+IEikPiS6rm2p4onuOe+CWtSJY5et+xuqoKVJxbc5RfYthJU32LCfyvFGIgQXNr2/jrFej+yGg==
X-Received: by 2002:a17:906:f106:b0:a6f:b940:f4 with SMTP id a640c23a62f3a-a77ba706962mr50916066b.3.1720080400128;
        Thu, 04 Jul 2024 01:06:40 -0700 (PDT)
Received: from [127.0.0.1] ([77.241.229.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a752d528ee5sm299311766b.212.2024.07.04.01.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 01:06:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, martin.petersen@oracle.com, 
 Kanchan Joshi <joshi.k@samsung.com>
Cc: linux-block@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
In-Reply-To: <20240704061515.282343-1-joshi.k@samsung.com>
References: <CGME20240704062234epcas5p1dd4ae6e7c91555b9573418d618086c1e@epcas5p1.samsung.com>
 <20240704061515.282343-1-joshi.k@samsung.com>
Subject: Re: [PATCH] block: t10-pi: Return correct ref tag when queue has
 no integrity profile
Message-Id: <172008039893.235003.9202296408224313061.b4-ty@kernel.dk>
Date: Thu, 04 Jul 2024 02:06:38 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Thu, 04 Jul 2024 11:45:15 +0530, Kanchan Joshi wrote:
> Commit <c6e56cf6b2e7> (block: move integrity information into
> queue_limits) changed the ref tag calculation logic. It would break if
> there is no integrity profile. This in turn causes read/write failures
> for such cases.
> 
> 

Applied, thanks!

[1/1] block: t10-pi: Return correct ref tag when queue has no integrity profile
      commit: 162e06871e6dcde861ef608e0c00a8b6a2d35d43

Best regards,
-- 
Jens Axboe



