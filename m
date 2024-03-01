Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F1541C7A
	for <linux-block@vger.kernel.org>; Fri,  1 Mar 2024 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709309393; cv=none; b=fiPAy+5dmOEFGFSlWDtnpSOblTJ4V3plzO0yjQYajojcb0nwFp7BhQHJtsXQlOhEI5p1bQwWMESdQSvjVESnkj6csaBetyUIX4ayIQZn60ii4OJHpL1l4t1ZJ9H8BVwwdjDLBx8pcb5Kv3b7OKObWU12VASUSe4T6zrCUcJq9LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709309393; c=relaxed/simple;
	bh=OSir/lB0szIQY81vhGPvg5xRh8vdBZI7ODeONZVVdZc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=goRu7caTS9QFHCfABpHIV9onLu1WzAlpz0rX9SfzUpAuBcL1Nx2UoThnOwauUyTtbnTXbTHGf4ahpk2QFBjMFhDZCFQhKPcEeLtv9eXE7nbjxJHUb2e+SwtSYt+ug29zF5vi+CXapXTFS8T0p6rFCEVM5DYxR2tZgQ6EhOmUoXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lsPwMc+N; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lsPwMc+N"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7bff8f21b74so24392439f.0
        for <linux-block@vger.kernel.org>; Fri, 01 Mar 2024 08:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709309390; x=1709914190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Teu7cVnfzCMq0GtMqNcznhRFikj20rv7Z/X/ZRCczTw=;
        b=lsPwMc+NLmY0K4fhiv4eK5YFlg1USL+GRt+x1i5M96Vb42c9ZYbU8HJAdcOphbAwLW
         f9eC6RbB8Hnfk0YzvEbQOtxTrLN+YqDHiEPlNUS6F44sLUo72WkTD/omwzHLp9MQ/s67
         ytQbdx/kjxaYjeDvw4smHSkBkhcbrJjdf52GJdkxZ7YdZo5IN3h78YY5HHPTOTQjmHO8
         pyOu5w1ietftoFOaESreGTrvVgJ5Azj8RSJTMlyZ9bvAQOFUe8MlaABfThNfgPrwSpn6
         UMK85PAwcM6qghPMCYGMJrU06NpNltVr7PhTB+ycPVxeSKOFibuJUhSMsfqNwnshOVOY
         0uAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709309390; x=1709914190;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Teu7cVnfzCMq0GtMqNcznhRFikj20rv7Z/X/ZRCczTw=;
        b=jHcYTE+RP5BM8CirLrOCk7U4FsQvYuWeuSsadsyfQqNC1MreokfncTt4tzpBs91A7O
         MIr1GC8notb0MnsOnSsSMQD4HV/USE5l/6r1kdiwLU2cMLDrCYbAv2kz9uUDHv11PwF0
         q2pO5UkjO0RteU5eNIUm4Lyap4mC17rGiSAKfVuzAiNq5wANq9ngbV2yFAokHN9Hmfim
         OyxPfLteBZmwfhkjjkYrhdocOxbTzjw164c0D6XlGsPJPcdpau/XPHaNi7fJujO6RzXv
         rBEKwP/+iO96P1NgTnf7MlwV+mNBltZDndNBGnbuUwJfP3npzx9pwy2hXJDTqWcTqzj6
         5ljA==
X-Forwarded-Encrypted: i=1; AJvYcCUA2l6xPH4nJz/ZnZO5wwXy9l6PQznI3DNY0bJwVkLKUCUaFzO2KE/fmRLGOWRNERIZaU4g6VOxji4bqijxEX8RUocdD5aedY/wZoo=
X-Gm-Message-State: AOJu0YzE4fWhHebCQ0AVPFpm2xYVr99/zwJnxN18g+qsmtYWRVwGBcE0
	5TCVm745svafNuSHYqkfjLcQzGG/pNq2v2M2mkzEof1OpXYyoJqdMf7WKMj/3rDE5Ok2lHJS5q1
	s
X-Google-Smtp-Source: AGHT+IFtkOTGles2zTmi7oQgkvSykVxZ6EQxQeTqgEj4iIIQDhIs8bnSx0k6a+EDDeFArf7OdTf+iA==
X-Received: by 2002:a6b:6b11:0:b0:7c7:acf8:54c6 with SMTP id g17-20020a6b6b11000000b007c7acf854c6mr2040545ioc.0.1709309390297;
        Fri, 01 Mar 2024 08:09:50 -0800 (PST)
Received: from [127.0.0.1] ([99.196.129.26])
        by smtp.gmail.com with ESMTPSA id j13-20020a02cc6d000000b00474ab85e3ebsm865136jaq.130.2024.03.01.08.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 08:09:49 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: pali@kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20240229144408.1047967-1-hch@lst.de>
References: <20240229144408.1047967-1-hch@lst.de>
Subject: Re: [PATCH] pktcdvd: don't set max_hw_sectors on the underlying
 device
Message-Id: <170930938495.1106749.3472068230834361456.b4-ty@kernel.dk>
Date: Fri, 01 Mar 2024 09:09:44 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 29 Feb 2024 06:44:08 -0800, Christoph Hellwig wrote:
> pktcdvd sets max_hw_sectors on the queue of the underlying device that
> it doesn't own (and doesn't reset it ever) since the driver was merged.
> This can create all kinds of problems as the underlying driver doesn't
> even know about it changing the limit.
> 
> As the state purpose is to not create I/Os larger than a single frame,
> and pktcdvd never builds bios larger than that, just set REQ_NOMERGE
> on the bios it submits so that largers I/Os never get built.
> 
> [...]

Applied, thanks!

[1/1] pktcdvd: don't set max_hw_sectors on the underlying device
      commit: eabf5dfc2d6048d8415cd22d38d7d3e0bdb4dff9

Best regards,
-- 
Jens Axboe



