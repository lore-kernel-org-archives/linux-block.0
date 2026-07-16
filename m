Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFFC3BBFD2
	for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 12:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784203934; cv=none; b=qKkSuWc8FdpUOM5Q4+kdEowmooUPR/eoUcdZ78IvJUPhLOpQA50xj9ZxchWKeIyWyRL2DxwmW+xQQnzDrk+ZGVnR7s2bqaTqExh77tNqQyr6YTdQ6Ct6eQspIIlXXUAK33h90u6SbjY2OS/cQHcNggXueCPdrICETpAVBYFL4Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784203934; c=relaxed/simple;
	bh=/ydX0Tx7JIIxQfkwbpXi9aBXHmoyd+1dzmQzQXEGbMc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kGfk4v4FYOcvBIfcoFWIGGrpdsDZhEUxzG2MJ+lxailRe1quoLDoNwuvxzLkz8gpuQQNhzXKThGX8q5kuBHUPo7kztBhH7yzIKF6dWAXr4WIO9ZNuLpcPnr/BluHIpQ06i+EjEgbSy4q9icjpNb4psj6gYQD6SDiSdAgolQYHQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=O7KiQ5cY; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="O7KiQ5cY"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6a3d915616fso503957eaf.2
        for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 05:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1784203931; x=1784808731; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MOQ08mFARROE5GDJpTfRDUjCD6cSYFvt9O9pJjVNLQ0=;
        b=O7KiQ5cYoQwP/kycpYC//cebf+wkJfnILmteZn7rUafjBPXhITIKlxVPcRBCxnH50i
         2PlfQ9zcjnhMyXUUOM9S7vwS+/6pokGPvprj8qzH5/cnWz9BfxiMya8hhTFpjCwmXrL9
         Rxl0Do76HzPRpTe6EnSH8Ph7XAvB9UNv7X5099DUYiWdENPrpwP+nzVz3fv/+kFdZxca
         NEMkvZC2FLehqWWqIMqBLKzRjrlLDuyFYHdCZKrq/V3dtZ1aTN1s9k+cpwI8ZObYStN2
         +VQJYijtdmn2b8Q3pBp82sKhP6ldS1mKDbA6VqwL90hop8R7JVS9ycgu/y4dB1yyYu45
         dMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784203931; x=1784808731;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MOQ08mFARROE5GDJpTfRDUjCD6cSYFvt9O9pJjVNLQ0=;
        b=oTtG+BqEP1qIdDS1h6tZfXDgu6aXUxs4QGLUL1BNIWipCA7HjhFGGQltp/6bH27ybc
         QH3JDt4hUpKs4k7u+HGkTM/d3mQsvEe0Lw/2OIqGqDmaujPfeZGCb5X1GDXHQq3jKWFe
         Fqn8dTnrnuSykRroFePmblKonvunoKacUncAfF0kF0NABZjvDVPRlN6ALe9gYrDteS+6
         hoLG0dnov4NckwioRXLjSlKcS6TCTiQd2arTq4xk8db8Wy550m3X/y9/MiUpYfsTjmwt
         a0KFni8xQd3iWllznvjLNHHCHYXFggI7R9gciz94JIVEEOw15KSTQTzsywEs2+/3Um8X
         08GQ==
X-Gm-Message-State: AOJu0Yx7zny/NyxUa1ohhLZAvn9GhGT//eINWi9qo5X9w14Ef1lfCYTW
	nipklKBirC4+TaYoYldZKilxyv3uKNJiGQcr5GMtYb2KAINrYOpQi8Kwb5iw26NsQK9XXCYBpbE
	Jdka3h2Y=
X-Gm-Gg: AfdE7cnliLbiR9Y4vg9MXpS7iA372Ldd80GL6RaOLWJkFGksCIcOHA36L8zbInIHaj2
	9/mAYpryGEUUPlIX99ONzyEjQY9bhqyFKbLgDK8FoJ7W45CTzWhgwlwxEFTuJhYYgqUfEp+5zc7
	JDUoIkBSEnzbKUuQcr77Wc9FxhZjHXG70H71AMdHehKfXBSHxA14vG6zQnbPT8cE8LM3QNHff0h
	q4B5Zb/ADHccC3eEpF4IVS96egEUCXwyQdBddyGMxF6PuHhizBFYAehi3QAmgtLhl6k8f3vYbTe
	ddXG+andyUDG0ODlzaHJb559F3m3Cl+E4R1UHPe5JUy1uJD17ACgd8vTVmX1fhXzqyxCTdUCm7K
	uxRD7evb2DUTFpslqXkdSbgBngJ/NpxahPCHQf8L06FHfB/VL1yZQ0fNXMZuRF88FUYizzIt2n0
	aSmCX6Pnr/JjT0hAWWaI4fEqbHaLaNBgYuMjM+g5tdT0V+98sqSaG5b9I=
X-Received: by 2002:a05:6820:6ae5:b0:6a1:475f:1350 with SMTP id 006d021491bc7-6a3d9f06230mr4103252eaf.19.1784203930776;
        Thu, 16 Jul 2026 05:12:10 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a38a4bd734sm11627050eaf.4.2026.07.16.05.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 05:12:08 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: xboe@kernel.dk, Jackie Liu <liu.yun@linux.dev>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20260715073341.95129-1-liu.yun@linux.dev>
References: <20260715073341.95129-1-liu.yun@linux.dev>
Subject: Re: [PATCH] block: show operation in error injection rules
Message-Id: <178420392807.282740.2473268498977818022.b4-ty@b4>
Date: Thu, 16 Jul 2026 06:12:08 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 15 Jul 2026 15:33:41 +0800, Jackie Liu wrote:
> Rules listed through the error_injection debugfs file omit the block
> operation they match.  As a result, rules that differ only in operation
> are indistinguishable even though op is mandatory when adding a rule.

Applied, thanks!

[1/1] block: show operation in error injection rules
      commit: f94de432646ebec7857ba2624fe082e779b52572

Best regards,
-- 
Jens Axboe



