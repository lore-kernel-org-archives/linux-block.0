Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2532031B124
	for <linux-block@vger.kernel.org>; Mon,  1 Sep 2025 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756737467; cv=none; b=TwA7ZT6oUQdc6KfPbX1PV735PuE+3EvzD+ub49Yjf2NIPe9zQk61UXvNqqblH2Rfb5GeIjhFfr5AtLFiT2t3ijzGl0eEjihHJTMDGSyQlgTVao5FP6EbjGnSic6ogdKgEE9V6D/hzg7s2RDWDkoR6PzfzD/9RSVaFnDNQGTlPf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756737467; c=relaxed/simple;
	bh=sra0/FDnnUH8X1K3s5FaMUQj5vaPuAreMN5Lt9OQLYk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=knE7810HlqaIh70Z1plPrvqPWsMZzlP8Of7d2Dtd5Z9QmdVhjxaD9qqtRbdWZSr0ZPItnNCIrBTpEi8NnSLLtcdIgqWGkxWHnAV1+6ZNF8ap9cQ2r43FApNcC/MSnk262hGTJKxny4C8yLn+AydvAujEGiCzKZmbcwhEWstvyQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=liWgYTtm; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="liWgYTtm"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b47174beb13so2966555a12.2
        for <linux-block@vger.kernel.org>; Mon, 01 Sep 2025 07:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756737465; x=1757342265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTfsWeNGithKokPaf8LnUeHsYMRih1Pm7H+/AYqRTGM=;
        b=liWgYTtmY44mCW6rLBVTC5Se3eeAexg5teq0lLK6gWh1HB/plUCp/0j6uvmEzl+QZt
         JrM1OOCZHhNIfkttG9yTVpDQ0l77DaAc96mHMeLc+SxkTzpq7MlZZKswrpUK5ekJABoB
         mZebhGA2+hAmJR0fl19FiBmwuvLNpz+OLc4xnOo4Kpckt4ip0RtDWAxnLUVSwhxqrRv+
         BMp1niscqXgQFX96w1d1VCFXnEp0xGsghire7Ij8ztFg9iDy7tsdDEcMV8wvze2jksP8
         ShcFL4dS4tO9pFjPJyeJyeahar+mPkkwnHgCuggFdR78oQJAV87RJjU55Wz96td3XeWt
         dJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756737465; x=1757342265;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MTfsWeNGithKokPaf8LnUeHsYMRih1Pm7H+/AYqRTGM=;
        b=JmRSik/DNnkk9hpAb/Acm/BRX+vkWVBRvFVz7HCHfz1EEEWd+6cTmeBHl1vANioQ9H
         exrBLVwqml/9bctWDvCqz0sku89rOgfkMDcwFaT572tI6UMzKoMliacpOBAiZDrN5Oo1
         CzWMqaJ7jJYtg8/AgXtiAqv6q6RrKFIdgk2oW6c+AATSqInrGF78p/qFjobuiMGnxCGI
         YxmOUyiIrSVVpCkFVjQk4M4WE7ist4tHQi8H7GQGSy4Fxp6pUWBMZebN3bQeAa61ia4+
         33F7n5gal0lfRjuzTLJgR3Fph5MnXBcBpum8drA452D7lzsmPqU22DiKGwxew0WX02Qj
         3yjQ==
X-Gm-Message-State: AOJu0Yxz1XKKYR1Il1/mqY/dezHdQiVe6oSNbs6el++nGH0rfxff8/RF
	brdPaec4eEeqIovFUP2A+OyPbIsg1GmCn7OzKBq/zGwLlM39/VrXWjdmGo9JGbFM6FVA1IXV8Qh
	le3kV
X-Gm-Gg: ASbGncuYyimyDfEtKWkhLblykOWYRa5kj73B8WXoX7Qes3jKfr0eNJKuHUWW7VALJsb
	BvRiNEcMPH1vr0CDAL+kATgKvzvK9tl4+sQrEfjDd15yTNlWmr413hf1CrgOqST7holJ3Uq/vXO
	tH4IUM9Esxkm4Zf8qWH0seHeIGXURphFJyg+t+tsV32ez5JwewGOTDFqozSXs2JSR7gkHMBU6qo
	KVCxX0+KMyZw41L5PEBJSVilS9bjfloLxUiOkIhSnsT8dmXPYPQyDzhHDiex9ixjVe2DU87YRm7
	gy5+65SGkOdX/ZAj+Y2ZCi8m22edhKP08cJdswGeb3muIrjUHDXrXdFqgQQo+BrXURNzqMRr7eL
	Qo4V1jKl+c6Q/41U=
X-Google-Smtp-Source: AGHT+IEaM9vFz+UVeUU5AY/6OvHJYzbkVtiO4j665XtK5yxUnNyy9lt762KQCwiXvBmRtrrLMjcdcQ==
X-Received: by 2002:a17:90b:48d0:b0:327:dce5:f635 with SMTP id 98e67ed59e1d1-328156dfca5mr10342372a91.25.1756737464713;
        Mon, 01 Sep 2025 07:37:44 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd28b37dfsm9546596a12.25.2025.09.01.07.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 07:37:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, houtao1@huawei.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com, 
 johnny.chenyi@huawei.com
In-Reply-To: <20250811065628.1829339-1-yukuai1@huaweicloud.com>
References: <20250811065628.1829339-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v3] brd: use page reference to protect page lifetime
Message-Id: <175673746364.13707.6940913855936222519.b4-ty@kernel.dk>
Date: Mon, 01 Sep 2025 08:37:43 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 11 Aug 2025 14:56:28 +0800, Yu Kuai wrote:
> As discussed [1], hold rcu for copying data from/to page is too heavy,
> it's better to protect page with rcu around for page lookup and then
> grab a reference to prevent page to be freed by discard.
> 
> [1] https://lore.kernel.org/all/eb41cab3-5946-4fe3-a1be-843dd6fca159@kernel.dk/
> 
> 
> [...]

Applied, thanks!

[1/1] brd: use page reference to protect page lifetime
      commit: 2a0614522885b136e9e650791c794dd49abb5b31

Best regards,
-- 
Jens Axboe



