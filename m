Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AE820409A
	for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 16:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754929321; cv=none; b=AkIpCLijAVIzKPfUKkvPTXo/tvXF8QDCTYGbveN8CRq8hfzJOqoJJmehVKURReh3yPBs4k6J0teVPJAJ2HvzJ3lbq0TAkWotox77wRiSjjfax2kI6P4V1a4Upzcf4QEkWR+ulS5eBMb+1JehA0aFwpsIYwZjZuIrJomt0WZYt/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754929321; c=relaxed/simple;
	bh=8y8WHcIBQPFQzKHJ+R81QSiRSdAPH6XYmgFgHVUwhVc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jwWRvKo6kJU9C64AOX3yiGnI9tbRSd8Lmf0ndtgcaPyTu+UwjWHNeEnxl+VihknhP5CiUCVlSxLF0VNbDn76DzCJkz/iD3P+m8I90dkuJX7PNSQP4P33cndx3oRujvsxj/bSJyAauOjB7MTpLRm69/0mYWaocvlCKH0PwtyILRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XKSn2EmB; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XKSn2EmB"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3e535242273so17794845ab.0
        for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 09:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754929318; x=1755534118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85I4cocrczFgRXWpVhE+enP7kd+fGH+R3Uvy/geOLPE=;
        b=XKSn2EmBKgeEBCImnT+l2E+fnXVz3jkTBZnLfmE+fq7Fgik22hD8CRNtfc5MGrRg3A
         k3NXDq2EUWxrvG2Gxr1k9A9b5bDhFB4cs4zdTqD0G0hGOojx/hqcya0izn/Yp4bgOT8w
         TAA6ayGBuzE+J7FIm1GTPFSws58uIz9iwkTVWXQw5Wl2KsQWW1rmhv7MLqLr+oYlIsMi
         QgEIolcXfin1watd69qsRPl5BHIwO9cGkEQyBM0Y1QSTNWLUC7s3dyoBg4kAxkuOH558
         sK8sNu4SY+pZEEvTCtTdDnN0Wq720d//wtMUcoqwRFGjiRXua91aiaPARoOEf27vCG3q
         18xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754929318; x=1755534118;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85I4cocrczFgRXWpVhE+enP7kd+fGH+R3Uvy/geOLPE=;
        b=cVG6pdegY4KGkyQ1nZYcu1peosTdeyG3mXDUaoUVCJXdcICGjyyDkL+rKxusnIVbxZ
         31N8FeYRwuAJWojlwPUZNYM3bsDfRlZhzIE2VO2ATBp8ZD3Vs10s9NTl13AjS4fiaYK5
         VlWL8iWGjXdYCcwNeHbik3emjy3iqe9tdKKsi+ju7RdJ1yqvmEUPde9RYEVKMJzx7Eko
         A1eEuwniJWM5r/5hYCt8HI0eX/GjIfg0jkvWBJAElCOIhNVDBsiEswvf8206al45opF3
         SLPzRVtes2liMvGpLidc0XavcjHykOHlshN75+K5DVyd1BFJ1u5q/Tj5hBAoCf8WksOa
         lC7Q==
X-Gm-Message-State: AOJu0YwcXDRQjhFWZE6zp7vdesHIMFxzdNuwB8UBFSTpQF0GALmGqY9S
	tuQkWWSOnNMs1U8VofAfaLoitLxWotJY+IJQIjSne/32Jm3onXG1kQcmPVkDpRtu4Ho=
X-Gm-Gg: ASbGncvaCIAKYNyWl5JNbyFSrafapzsbyyD0gyqL5mlpAni6kSTcYuiV5tGBbtt8gA9
	Jjlz7T/lM6jTeb+0lOzpiYtoOp1nei/Su5dqBzCKuJHXRwvNIduwjfvJOP1AQxDV4bPZQZiT94k
	Kq0SxM989JHGAWpgo967VQknKTGxGXCTG9MiacdsIR/d3JnP0Nd+dSiRyylmPjHo0EwfsvEWCbt
	qbPTP2OUqXjiw09Njatkk3NoAAbv16gwm2sWUz9d0wzCPrdj19ZoIu2HFQCxm2uhF5okzGteWfL
	h0gG5ExaF7J+UG3zx89ob4HdumZXOqUbSwh1WR+Q+0/U2KY0eXEgpm3kQC77Qle33NhgCBQW8p/
	++igmQZffyTnALg==
X-Google-Smtp-Source: AGHT+IH1tFRBHHgZcmUXkVlCifmmffKnybpULnvg38aiSXoYdRjqobDKzGmOs7rlqaBDVzPRL7PLKw==
X-Received: by 2002:a05:6e02:378c:b0:3e5:4b2e:3b05 with SMTP id e9e14a558f8ab-3e54b2e3f75mr95720265ab.2.1754929317950;
        Mon, 11 Aug 2025 09:21:57 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae9c21728sm2457200173.67.2025.08.11.09.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 09:21:57 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, jack@suse.cz, Tang Yizhou <yizhou.tang@shopee.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 tangyeechou@gmail.com
In-Reply-To: <20250727173959.160835-1-yizhou.tang@shopee.com>
References: <20250727173959.160835-1-yizhou.tang@shopee.com>
Subject: Re: [PATCH v3 0/3] Optimize wbt and update its comments and doc
Message-Id: <175492931717.714692.13410561974179783344.b4-ty@kernel.dk>
Date: Mon, 11 Aug 2025 10:21:57 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 28 Jul 2025 01:39:56 +0800, Tang Yizhou wrote:
> Some minor optimizations and updates of comments and doc for wbt.
> 
> v3:
> Fix a typo: change 'cur_win_nsec' to 'curr_win_nsec'.
> 
> v2:
> Patch #1: Pick up Jan and Kuai's Reviewed-by tag.
> Patch #2: Pick up Jan's Reviewed-by tag.
> Patch #3: Take Jan and Kuai's advice. Change the name to
> 'curr_win_nsec'.
> 
> [...]

Applied, thanks!

[1/3] blk-wbt: Optimize wbt_done() for non-throttled writes
      commit: d8b96a79622e03813c221450498ca9742704ebf2
[2/3] blk-wbt: Eliminate ambiguity in the comments of struct rq_wb
      commit: bccdfcd56d4b5b78d0d76f46d0e89a51330dfd75
[3/3] blk-wbt: doc: Update the doc of the wbt_lat_usec interface
      commit: 0452f08395f8e7d04fe3744443dad396b3330d0c

Best regards,
-- 
Jens Axboe



