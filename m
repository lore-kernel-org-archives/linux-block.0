Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F84223DFB
	for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 20:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756154905; cv=none; b=OT1jtcghiYIWX7y33z7l37wqlZ0RKr3y+yRLHRJmA6SquRC3crTPAx+4DVXiX5hCur3DTXChr3KvLvFb1tWB9vXhPbiV3xluGzS9l74gdeya6itVvZze6K2lZyQKDFtNj6W2PEscKZzVgrD5cfSA6ReKJYWyCxkHwmBdoe9GUV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756154905; c=relaxed/simple;
	bh=UzdtCt2cSTRJHaGMDc2BZeooKml6cx3yyDsZZPsfqf0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gf5FvxatYdDuAffiapfFD8JFxMLguCQqW/uU/gLtQNZeSpwqbeI49Z5KJH+ecHEnlstC7e9Q/k/fp8uWy5VeYnufJKSOLL2HL2cpBzoy9nJtrg5/0lc6niW3CA/FN4gT5es2/f3Xxm2RkAyhkqCaJxX6+vDlwsET6Q97zbNnx2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0oe4CpB8; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0oe4CpB8"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3ea8b3a6454so17045175ab.1
        for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 13:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756154901; x=1756759701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgVPIGHVx9wUmlMMmVem2hzAa+XWm2r+soyMgVZw3sk=;
        b=0oe4CpB8GkM/W3CqVz+s36Yr+ykBYB1amDLaCkWA+/fYd5Er317CwIW2Huzu7Fcne5
         SaObrC8A0ySlTBMUjeJzja4ZEx+l/rpNUY7gohSEIhCztJ6tfiDnmq/1brIKTRez2dOq
         gaSPg8gms/2CrtcVsuK5q6hgkDPOxCqoW3UwZIfn4cgn+ZyJUlxln04M0E0WE/M9WgEY
         NmE5LzrniSPMpP7mds+Vil1geDLViMP4J8v4Y7EhPWcqO5vgv0CaLKARQT3FWXrbPmEb
         eCwiiR9m6vi4ecSl7QlVJtNKqeLmlsRcsf1EkJcee5T3BxhuMLhCYvpU/3bxt553gtph
         /q/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756154901; x=1756759701;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgVPIGHVx9wUmlMMmVem2hzAa+XWm2r+soyMgVZw3sk=;
        b=bcIKs01HudGy5UszfFUNjsXgp3PkadYwq3JCkJCsbhKo9jDK2gjam6sYrgiDL0Qa12
         4/YH0JDC4IcK1Tjq6bMH4wjvree8v1bjETvLkPJ7N1JFK/ZdXfR/8RCkMyVWkbcJWBmm
         VFgG6rjykY8SSb9WjkgHKjzSUyLMBwr645hnH5KjBh7CvwulR9ejN1yS+HKTQaOM8HIq
         WmxJo/3Sw3J/2lQTFbJSHVPphZCTQlFHO6f8FhwPq/EpCsrIKcIXwO3HkPJ5F8R7tgR/
         pPrnGCeQo9tIh8uLv22H1arKQHxhqpqLn8YlhfA8xknPDDFpa+oK5gYootS6Lep4rMP4
         7zyQ==
X-Gm-Message-State: AOJu0YxcKoiv8F32w7CAmM/J7P8hAgUkUewzx2x1p7yGO5Z1HY8XElWp
	9Tl9YsGVDmAFyQpYfL04A45Zj64dsSkUKjwJz83G4h4lbTaIkOf3RasvjSf8NBIKoco=
X-Gm-Gg: ASbGncuXMNi3WIlcN+LToTnuxfgFOG6amYjujI8/d5zjEeY0boLRzGylZd9tTThd6jv
	Cg4EXd1PCXlKa6T6MOU0pshmVCjCinzdjz7c1xAg7p5LWH9Xyjh929Hq4si6hsH1PPwJFUoFKLy
	Ei9daJbkNK9qWyREABEtB7gOhHT4zi2yXGYGDpwbkSTZhMXJFUSxN6OJUiNaf6dePuFyv4GyMCV
	zLPNrUqA+3q+80DJZIoeqnMVvQcL+4yAL69t48qwcpy3Y4tYi6Nhb7XDEttfHvk4wK/WHo+s59l
	d1heClXRReXVgklqVTDyVeHcAsIw+YUvaerqHuR5zYpKiJu58AxgKSK+LjDL88yjOnJXJn7qxrc
	hWaczfoY7+m6Gvw==
X-Google-Smtp-Source: AGHT+IH7AXkfHl6tA6/UEjZTmfW68apyPesU3Sr+FpGFSyWYpnvMVEzwKJ+a13Lm9Pb8l608MUWDJw==
X-Received: by 2002:a92:ca47:0:b0:3e2:9f5c:520f with SMTP id e9e14a558f8ab-3ee5dbf82acmr18905335ab.3.1756154900964;
        Mon, 25 Aug 2025 13:48:20 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ea4effe70csm53084775ab.51.2025.08.25.13.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 13:48:20 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250825151424.1653910-1-bvanassche@acm.org>
References: <20250825151424.1653910-1-bvanassche@acm.org>
Subject: Re: [PATCH v2] block: Move a misplaced comment in
 queue_wb_lat_store()
Message-Id: <175615490017.25116.5369832210687682183.b4-ty@kernel.dk>
Date: Mon, 25 Aug 2025 14:48:20 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 25 Aug 2025 08:14:24 -0700, Bart Van Assche wrote:
> blk_mq_quiesce_queue() does not wait for pending I/O to finish. Freezing
> a queue waits for pending I/O to finish. Hence move the comment that
> refers to waiting for pending I/O above the call that freezes the
> request queue. This patch moves this comment back to the position where
> it was when this comment was introduced. See also commit c125311d96b1
> ("blk-wbt: don't maintain inflight counts if disabled").
> 
> [...]

Applied, thanks!

[1/1] block: Move a misplaced comment in queue_wb_lat_store()
      commit: f5d10e6915d80f7f4c4ed445a8b8ba4a5ee79318

Best regards,
-- 
Jens Axboe



