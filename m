Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E93A481AB3
	for <linux-block@vger.kernel.org>; Mon,  5 Oct 2026 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791204821; cv=none; b=uB4EgktXdjjgM65WWFohwukMNdO9KDwYESS9bbhv4TS5rB/OJZhknnNQ9ycMvsJtRN1YG9DQM+cfG5s5oZHNrhm8xXXtmLUc8DNedI11O1gpiQCqgOST494AttPo57Al/3/ginUpR6gWHzOKGvbfVjTNnrFCOdklttXuFbxURVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791204821; c=relaxed/simple;
	bh=KV9Idgk74q+kzdvs9NJK4T2vJA+2ki3ng9G3PQGcFRA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qo4NfW6SXo6QoSKkhkAl81uleviFNxqnBLVECxJqhZWRtx0QHtsAT8W5hMkBfh9ygvBq1c6DsQr4fLjicKZuruI46srDOXUIk3qUa9aw/cZei3ElwP5GQbM0Qkm3E5emGa5H0Osnw8A3t24PIoGvESo+JxVMLQcnsjo894mLgY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=vvAEl31v; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="vvAEl31v"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3282db206d3so5794939eec.0
        for <linux-block@vger.kernel.org>; Mon, 05 Oct 2026 05:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791204817; x=1791809617; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AeB8BqmMgsQF1nloxCuY2ulp6jNsowaLkA2HeKjC91U=;
        b=vvAEl31v9P2BhqV57/q6Xxy5mPwHEGzTTqbzS3/HX1++uw4hTkVNXTbQOTbWqdnCNl
         HmVO+dU8d2fG5wFwrcRbT8P5Du5g5+RKOfxx19VgtX6TgjoRz7kMu2faCphj7IW7lL6U
         TYF49Yy2uvXb1g9XjodIfaLOas9Dq+GN4nelpW9cDGSTew13glRJIQUVa02K+WxhgElb
         BjxHpOHUN/2dmgYKrsCqPM0HL6gyVnXPJhNKXH4ql7uI/RP8GTjbvnKFva4KdGQCjR3L
         rzmI8qr/zMX2fJvZhTkCI9P386xTULihsFO35O3RLPjC//Tld0c7hBas6EeVMZLbFuE3
         IJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791204817; x=1791809617;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AeB8BqmMgsQF1nloxCuY2ulp6jNsowaLkA2HeKjC91U=;
        b=tYR0F7W8Z/AhbgbpIHMqjvgEMzkY3wwGkMC5tNQN9A+yuiyqp/GM6wPwrlZQtUd8cV
         A2IkQ6qpHuDmsP2fN3JhjO8mdTX2jkkV79bTm4aCzjkmwY9OkFi0xdWskbuLngLNzEAm
         j58BXzzVyAt2fpkzLgvhHivUDtTYg4cQd4r/lToF5k6ULEXbJOOuvcMvMN+OeHgQSEs3
         z+1NeiN53gcsL0PhFdQoiJmHHi4/ZRYf9jS4ITvrElBFDu2WeHm4b4v4YGfDvfRTWqIT
         kA2GU9sBAhLhNPVLMpaja+F8ELCATrRv0hq9iYc4+tewaurNAPWqbxiQ+ICvJ2UNCEph
         vOxQ==
X-Gm-Message-State: AFuF++l1M7/NL2c/IniWtX7+VwV3Pu9wJrzAMgpxNUmTtM84QKtH8ZK4
	AME+phm9bvj4CS9itOz3eyU0cHQTJGp5aaEJG3M2aAzSO+o0keIZ07drfWov1QPL7PZP3REPoZy
	2cRgFEbU=
X-Gm-Gg: AYBFou2AzS8C6j6IRUKyJmaUALIOevEahjfVOPFquMTaaqZx86DoPM6cND+ipC1B6Um
	c4SJaRDfwsg4fpWMVSM/MSZuwkc5+AQ2tEXIUzoiaHaMZRc0mB/uFyFi22oxFiHWbvFFZtjgR4m
	2GLPe4XMxX+72Cr11bTbi1VwaHC68a+kMr3Rsak0RLrA4R0jKeiwrtTaU1Rl6NHDXOexW7tRNrL
	CxNRo9gjhUscjkPb2SjGBfM498TtS/Ml0b8YJFy65joPto+HLxUEqUYAruu1vtLWmFpMNqwQREx
	fAmAFAjfgqrFcLpo/fmJJIyoKl7bqvR/h35sakd5cCn+mvLxdu2d2xVl0OzV/1YWWuivdMp6oJk
	CKH+tfhsjo4ShRTKl34qsuKn7z/rTq8tKNfv4/OX9c/D4YdxHYaeRTamRbX2/dMSo741U6igPtR
	SFWEaXunNDuPgYtJ2LvqEBwYBru+5ILCgmlyodIgrV6Ne9NFOKId9z0+tsyGFNnaxP6kQxnF3A0
	p/y5g6XO0isUGoJ+E/6pM6cXOmZfPpHonm7Y/j/LLUKIZVxxHL+nVg60Q==
X-Received: by 2002:a05:7301:18a3:b0:34e:67d0:bbb9 with SMTP id 5a478bee46e88-351116caa62mr8843433eec.29.1791204816959;
        Mon, 05 Oct 2026 05:53:36 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3512713861fsm14209884eec.10.2026.10.05.05.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 05:53:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@opensource.wdc.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, 
 Christoph Hellwig <hch@infradead.org>, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
In-Reply-To: <20260916065657.62724-1-shinichiro.kawasaki@opensource.wdc.com>
References: <20260916065657.62724-1-shinichiro.kawasaki@opensource.wdc.com>
Subject: Re: [PATCH v3 REPOST] zloop: zero out only the unread tail of
 short reads
Message-Id: <179120481607.458282.12883375484893510775.b4-ty@b4>
Date: Mon, 05 Oct 2026 06:53:36 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 16 Sep 2026 15:56:57 +0900, Shin'ichiro Kawasaki wrote:
> zloop_complete_rq() handles a short read from a zone's backing file by
> zero-filling every bio in the request. This is correct when the entire
> request is beyond the written part of the zone. When a read request
> straddles the boundary between written and unwritten data, read_iter()
> returns a partial byte count and zloop then zeroes the whole request
> even for the partially read area with valid data.
> 
> [...]

Applied, thanks!

[1/1] zloop: zero out only the unread tail of short reads
      commit: 58304e139cb3fa640da74bc02101f0926d0607e2

Best regards,
-- 
Jens Axboe



