Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EF641DE0D
	for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 12:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784203931; cv=none; b=hhrMBvVjVSOrIU/9vj98xkJ6w8ci2Xk/Hwo1515FhW4+yIMx7B5nVbhh7SQv3zS0Tc0OUs6FbCi2IgQoyoluIoVdBVPNYOIJhoYdP8eNa7ZjLttkSf08pgyGqcImMbPpR7/+hcKirUlHNpzhdMEdYbgfC2FJJsaRCMNS6Dw3D6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784203931; c=relaxed/simple;
	bh=sH3+44vQaQM8peB9ppgLrHutvbYFdw6Xe1o5I+S0bYQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=U7tnxlRw0q0hlp4udanEjIVZR5Pa3TfuqcI+ty8yQptmtZPBQn/WLjHIciywvF+VKTtE6F16jHws45rSXD1GF65Bje6C1Vk/q6u8otglZ7Bj3pjk1/5kunPVsRvFIqJPCYcKBnuZwdnn6JvhHuFv2/0FJi5UVSBeX1wFebFW0nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=pdegp61L; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="pdegp61L"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6a397a0e5d8so3004131eaf.3
        for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 05:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1784203928; x=1784808728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b2jgJrAzmB89EB8vthyooRE337DkTvMZqBhHuoWYHh4=;
        b=pdegp61L4RvaAbnFfpgfhOQc4nEVqjdGXzXHgCPbHTWcx7xg11w0T+6stEbTzPGM1u
         Y8HlsvTNBBO92phPvln55YWL51do8XmmdnUl5LALdLChC7DuWTgyr2xTVlpVIdYDs0Yz
         RJP23Aj764aK9KjmMuzcB21c355QRGOHa0MpvqAKd4b00FVuYPzAs+qgs4xDR3bsM40g
         nmTu0TtCqj/UfxdBNGjTKxt59M0R9MFkSFZQ1pOBQnc9GwjyHTvUhKBiNbyW33kkdqx3
         AYbNML51jlJF+irkKNcehGIzeror70dgrEtwW1qPxZTeQFrx6U7Btog/ZBd996+UcFCh
         JOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784203928; x=1784808728;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b2jgJrAzmB89EB8vthyooRE337DkTvMZqBhHuoWYHh4=;
        b=Lwc5P+oCyDOpPNiayag6c0GYfULf/6p/4gaYcNL0VHDAmH/wZlcyV/otY8vhVQ8rDn
         WGG2Ck3J4qbNfBfnxU5g2cRL//TF5rQhGCqIKnQ7VakIElxG4zNMocQOEYVixEh5VVOz
         t6+obGtqztE7puRWA/eXQnhM6xZALxKm0wa/QAwv25LRsfULMypKGs67ghfjvXmCYyTz
         rA0rI8bVh4ck+VxEbseLrsfpldqdw9OFUQXJxpN4J8eL9nuCwuftoF9nBTCw7gjv0xn4
         4dFzhMBWD74qKHzSaPaxGi9PLxWBXvf7wj04OJt/SislWKSZ2zL9eJPlkWYV6WODNQWA
         0prA==
X-Gm-Message-State: AOJu0YwgXhmCIc7DslaQAbCl2HEZMl6UNGuhqsIxu4/IiDjXD2eZinSU
	60bKah6nq86nLhm2Lxqw9h+cy2FRstmP0Or+uhwCjDQeqTgs7s+nZUOgH51axBSbsTW+UUc8FGL
	db4omHy0=
X-Gm-Gg: AfdE7ckkBc52HkJ4m3pRupgS0zNbCfd/51cZUD7S+1z5D1GG7Ic/kkmG99dd2aaK2jb
	ymA8zZB3TjihmlrUHimPaJl5DZmjYnBTzly+LVDKCP/7FytjyBrbFkT2SUE9He3O/p9SX/Akfir
	yDA8yOFjs9YIz1QUhi9xvKt74ynO5Y/tmIRMOJmAcbBeUPSiamJDbY48dIE/Kr04JLPeXmutEqs
	LoEuk0KqQnzw98yJ11MN4BKLjOxsdPlpheWO5JN5iAGQ3PrqVTVf7b4IKVZizvHPZvCM/Tnd/nC
	RObMo/wX6VxyKMKGXKBrVW+NPiO8xTbsaHmn0VauFu6A01sw05XVe4cdQ65jcQqSlcko7GmJz9a
	vmjFZ8AMlIa9dAwo7uSSURRWJW45QiVELJYQl5iN0EnUOiS/4lp0EgW5O+wI4BJ40Kzr/Rh/nDY
	g5dpECI8gNKEjp5ReTfXJiksVhA7AI9j0+//bqvSUj1kyg5jz1tNLBC2U=
X-Received: by 2002:a05:6820:1c89:b0:6a1:50eb:2110 with SMTP id 006d021491bc7-6a3da0bd8dcmr4199559eaf.69.1784203927900;
        Thu, 16 Jul 2026 05:12:07 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a38a4bd734sm11627050eaf.4.2026.07.16.05.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 05:12:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260716092237.1305030-1-shinichiro.kawasaki@wdc.com>
References: <20260716092237.1305030-1-shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v3 REPOST] block: serialize elevator changes for the
 same queue using a writer lock
Message-Id: <178420392608.282740.8247081669734891037.b4-ty@b4>
Date: Thu, 16 Jul 2026 06:12:06 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 16 Jul 2026 18:22:37 +0900, Shin'ichiro Kawasaki wrote:
> When elevator_change() is called concurrently for the same queue, the
> elevator_change_done() function runs concurrently as well. This function
> adds or deletes kobjects for the debugfs entry of the queue. Then the
> concurrent calls cause memory corruption of the kobjects and result in a
> process hang. The core part of the elevator switch is protected by queue
> freeze and q->elevator_lock. However, since the commit 559dc11143eb
> ("block: move elv_register[unregister]_queue out of elevator_lock"), the
> elevator_change_done() is not serialized. Hence the memory corruption
> and the hang.
> 
> [...]

Applied, thanks!

[1/1] block: serialize elevator changes for the same queue using a writer lock
      commit: 4ff58d6bc9dd4c7fe6092d0ab5677a79ebc788af

Best regards,
-- 
Jens Axboe



