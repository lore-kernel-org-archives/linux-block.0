Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519396E610
	for <linux-block@vger.kernel.org>; Mon, 15 Apr 2024 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190362; cv=none; b=hf+QPochKhKsKyKVOj3aDpoISo37uSyucfk3mOPY/XmDFk60oQnmQVnukFYms4iWN8G+Cjl2Em/LudJKca0QbyFdZk2vkdJpjyLq1bjyIUnsnCMmk/wEvFl1PYmqUHb2WjDZXAilw6Fe4RWafLnDl5WkoZ9EfQfAkGjm32qIw4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190362; c=relaxed/simple;
	bh=8l0Ez116v7JnYngcDeZrAtI+urffG7i1XNEDlUC+lFk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kkyOVzFAvGJC6WfHAiv59B0tr6IaWzLYRulIFO6g5ZAbtYzlfEMHB2MsN1hnWS+5CVJjKkutwyI/2EYRlEVyIt+Tm5OBYnjNDrZ2F/huTkzqoViR2PsYrruSUE3AtvADcZj7mKbbbrJrvP1GasPTSjJ3M4TjtJhUW8WEC6diLJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zJDZfoBU; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zJDZfoBU"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d6b362115eso55506439f.0
        for <linux-block@vger.kernel.org>; Mon, 15 Apr 2024 07:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713190359; x=1713795159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwRyKSvxsFLuOvVEx/al1TPimZgcBsVUCohLN6VLBZo=;
        b=zJDZfoBUW623jU8qfwDEGG8rhnA1JZpocEeuDAFGVLaWGOcudFljyAcugw959I13z4
         +NqOdLFIWvWasRhmURL2Jp+IYYFCQQuCMvgIN87mL3cr2b0oNKfR9FqjSwtHv6kiHkTR
         OvFY2ulzuVt8R+vvRufg+EHNNjH0amNwcFE7ObBzBdSvqCjr1EhBynWB6ygDiI+jIs2j
         CQRY4xmatXWO1wdUVDnxJ05CpHqIvWcYUkT74zJrLTnBmq2TlDhLYwhnnTEQeYSS2tAe
         qQXU2NkLuvDP7wVCge3gmGu6bEoBKRQAx/TrUSiA5iZD64+1qt39yyIzt+qrkHov8NUJ
         nngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713190359; x=1713795159;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwRyKSvxsFLuOvVEx/al1TPimZgcBsVUCohLN6VLBZo=;
        b=o5a/UANKXBfuFjUoE+BsdIWgdOos/n3HlZurF4BwmUVUfPu63oqru8X1VwY+v3k60i
         +N2rbJg8qFVtN2xikvsbKbeY3Yb0fmYjw/Vt9v4YmKP9q3uJXM/0zZ9lY9t9jJ6DgsLH
         T+myztW7LbQliDh1Vzc9vuIdrgFwT3UcJWI5nRWkfNy5cOyS8cuHZgW/Giyiuv5j89yN
         ePaTvPHzgZJVJ8TEA9a5nPtyHRRCf2ZliRUm0d35gmaAuYQN9jEe1sLn6aLIUsUpQYuY
         Z4RLPa536uaEf63y8cPY5moc/9GqXMGFNUkCq69Eguq04pThqx2+6iIs8E/t/s0lirn1
         swOg==
X-Gm-Message-State: AOJu0YxbdCFz1Z9h+PkAYhlcmDo1VrVqKxR37IbMad3RAGPwkQY79PwY
	OmeXT0Z4lrlyKyRhZZIcjPgAvUXTGTY3qT8/8zkw/Q3CL0eaC75vf9HhZvBn3JnsrGNSXsrsYPg
	K
X-Google-Smtp-Source: AGHT+IGh7jRVLU/Gc/zStRGelKTGjBbGhgnCsoa0om4lkxUk0p1USV28zKNKXCzHbeL5AzSgxagAXQ==
X-Received: by 2002:a5e:8d03:0:b0:7d9:4bfe:5ed1 with SMTP id m3-20020a5e8d03000000b007d94bfe5ed1mr4595982ioj.2.1713190359011;
        Mon, 15 Apr 2024 07:12:39 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jb3-20020a05663888c300b00483123e0d46sm87994jab.101.2024.04.15.07.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 07:12:38 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>
In-Reply-To: <20240415122020.1541594-1-john.g.garry@oracle.com>
References: <20240415122020.1541594-1-john.g.garry@oracle.com>
Subject: Re: [PATCH] block: Call blkdev_dio_unaligned() from
 blkdev_direct_IO()
Message-Id: <171319035827.13780.15475438289317494207.b4-ty@kernel.dk>
Date: Mon, 15 Apr 2024 08:12:38 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Mon, 15 Apr 2024 12:20:20 +0000, John Garry wrote:
> blkdev_dio_unaligned() is called from __blkdev_direct_IO(),
> __blkdev_direct_IO_simple(), and __blkdev_direct_IO_async(), and all these
> are only called from blkdev_direct_IO().
> 
> Move the blkdev_dio_unaligned() call to the common callsite,
> blkdev_direct_IO().
> 
> [...]

Applied, thanks!

[1/1] block: Call blkdev_dio_unaligned() from blkdev_direct_IO()
      commit: de4c7bef9d330e4a59c78181bd596c7569d7208e

Best regards,
-- 
Jens Axboe



