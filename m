Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B68A1E488
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 17:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621771; cv=none; b=GJZjL32C2u/U3qGdOUSzYFzAHfAEJ2jUzijxejTRJ3Jm68r+YccylOA6RYf+/MT7AFFh1pYeyV/X9VAmiP0j6u0ehRB64aOyalh7TtvLk5kH6eES+rqWK/rOUdAH/1IjGbZpGxaxSk8crmaqzNa0r6jf172meSnrcgRna6m2Tdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621771; c=relaxed/simple;
	bh=Z1GskjClhquD1XZu5l3BrsicrOLmznGF3BV92ZWk+sM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dgrF1cHkHRbs1xDeLHGYIWSKVz9PLcPqlkrm6r04eB/ny+f/ShfZAWTcsY/t1smdN/LAMdtTPhTQheFXrLx6gYDFk4Pm8rq0BfeQLi7ZmqBT+RfaKKwvnLv46WCmMdDH3Gvuu10qySFNmGl+azVD1qXYWeubcRlDP+6PZoUKaRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WNzxAmoh; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WNzxAmoh"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1db9cb6dcb5so8209775ad.1
        for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 09:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1708621768; x=1709226568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOZrMjyUcQo5lrNPbgsjeePit/IKSLB+Nm61h+OnLec=;
        b=WNzxAmohVlEWCqX36HPP0NWQS5t7fpP8drb5QZXNQOvK0E//af/8FzORIttiVc05Un
         sLNkFKv2vS7PH/pYOdMm5ibijQpLXiXJ9QGIYnI4avczMJflpZGSuC/i8zu6xcqmrtV5
         8d+EkflZBuhG72vwIJARXIfCMsiyN3T9q25MnDPBazmh1bmLrPOLEu8Qh+QN1uRMwZAC
         JGm5FpDZ1lMiex4VizREFQpx/zYlf/QO9xIzFNepbul9LmveL3FdeoumIBing4xbXp2J
         dfqo0wY8OxXMQkyskx9c82p6XRe7c8X0Xi58rAno4xxPf/fT52e9rSlGMtvFhN0kyith
         52Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708621768; x=1709226568;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOZrMjyUcQo5lrNPbgsjeePit/IKSLB+Nm61h+OnLec=;
        b=HSfIzSXI4aUxWqIPNRMsx+iymFIzTw4hPFzuLJ4fXRRuAB3RgLxQfQIuTSLHhmUmXJ
         dP9THIUQMctwHcCbCwrL1PhZW1ON2AM7KxkuTN/zyAQ+kZ5XtnYYQRKRCihyQZGliZNi
         qYWviVy6tbrX+sjx3VWmxp/NLs9bf5/arzUWM0u1pAgOVRPkf734UtfUF17ToeX+rJwZ
         1KK0/ximPuhqBhwQCDaaDffqCV/2R4ZnNrR++fn5NUyzXD0XQBgfTT/+3spFX2xYEEch
         Zu1LDSnEEZiUcfjs0/W6abIMG93KhC9EQVVTfRUblASCAqR7Qz4O5+OML1crhmcZQnSd
         5sKQ==
X-Gm-Message-State: AOJu0YxPXxPrNtEYfzYX1/Ez0RHnJqvBZJ5DkvT1gAo5s1NPmG3ceHTL
	2h+Sa66KhpkEJ9qsU1TxSX5bZRN50Lsp3kHujricX/t84q3zj3ldZ7cNfKzv/Us=
X-Google-Smtp-Source: AGHT+IGRol6/6PHs9fyf4vSpFmqKkAbEqktu+wXWnxKsziokb9SKYPGvs2VZy49eIXTcCIXisyQKAQ==
X-Received: by 2002:a17:902:d389:b0:1db:d32c:f4c0 with SMTP id e9-20020a170902d38900b001dbd32cf4c0mr3204585pld.3.1708621768321;
        Thu, 22 Feb 2024 09:09:28 -0800 (PST)
Received: from [127.0.0.1] (071-095-160-189.biz.spectrum.com. [71.95.160.189])
        by smtp.gmail.com with ESMTPSA id w19-20020a170902c79300b001db839b9e80sm10253745pla.286.2024.02.22.09.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:09:27 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, hch@lst.de
In-Reply-To: <20240222083420.6026-1-john.g.garry@oracle.com>
References: <20240222083420.6026-1-john.g.garry@oracle.com>
Subject: Re: [PATCH] null_blk: Delete nullb.{queue_depth, nr_queues}
Message-Id: <170862176698.8813.5426505320214942854.b4-ty@kernel.dk>
Date: Thu, 22 Feb 2024 10:09:26 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 22 Feb 2024 08:34:20 +0000, John Garry wrote:
> Since commit 8b631f9cf0b8 ("null_blk: remove the bio based I/O path"),
> struct nullb members queue_depth and nr_queues are only ever written, so
> delete them.
> 
> With that, null_exit_hctx() can also be deleted.
> 
> 
> [...]

Applied, thanks!

[1/1] null_blk: Delete nullb.{queue_depth, nr_queues}
      commit: 0f225f87873ee95dd4cf94dfc6a3249d4289e4ea

Best regards,
-- 
Jens Axboe



