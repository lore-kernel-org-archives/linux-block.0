Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5718A26AC7
	for <linux-block@vger.kernel.org>; Thu,  9 May 2024 01:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715217352; cv=none; b=Wl4tqEojsGwGxj7tVNaJT0dfYGmvv2iykk3jRL+LqHEutylDzX+kGdmqKS7CfBztAfE70/K1JJG0pEZlMhHLbfqkErHngEjVsUfQo+Fed04NmTYIiOyJWiaE+BAhHXHserzeohvF0Ie9+ldQYW4p1bJpSAGlO4k2ExiWCJ3RPTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715217352; c=relaxed/simple;
	bh=7X61mZ5lfsoEsG6HnR6GXEyIgQo8vageQpInxeE6FnY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lHbLGKwypoY/HKzKsp+EmViWp++Y98y4P9Mofw0cVzVHI2eLmiFHaqubrbRyyrB5u66xPo62uC4e1ORvntl4RraM9iJUvvaFKzlgc8lrVNrCipp/hEeLVWrx7GSSrgGq+WQ16A+NLlIcVknpw0D+0uKCUyKANpEFyPoZJ9fDhFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=k5WKX7Sq; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="k5WKX7Sq"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2b6215bcd03so125655a91.1
        for <linux-block@vger.kernel.org>; Wed, 08 May 2024 18:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715217349; x=1715822149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8lwS9vcphRmjixI/uaFdylh1pgxXJ6lfp2qPwJut7g=;
        b=k5WKX7Sqj6wSQyWCbW9GFWS5IVeU+5/yVLEeA19XuHrOrOQYZUpydchZMbyxVq71HV
         E4RUn0gF9+wVUAv8FjyOshlCe4UJ7HDFBNsTmG23AhPyJk1sqADk1BzeUQpPuQhrUyTs
         hxvF84Tj15eyP1g6YRtUJi4IovWmkwbbCT73BKWzhhLf9MXxZq+76AOsSdij8HnfEeot
         r3hrz3OTv4Nph1UFfyoTwdH8N6sGb/+JQJEMQpQYFcWeWHaccOmH9Ul01DS7U89cP1RG
         tur4a1561jL/F3uctYyJGx8WWQXpyXwjf4HV96OmcI11J7+M9XEFd8+EesX2UNpb5NrM
         j/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715217349; x=1715822149;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8lwS9vcphRmjixI/uaFdylh1pgxXJ6lfp2qPwJut7g=;
        b=Yyz8UzPLZffP8pc5xFM5ocbC5z07Zk5H9BNvpvWqsbueqTw05sviBSA9TMbl0otZYJ
         TTjhFWzzed7AZhESRn0RDs27O8i/2ZvQ3i+3tQTGzcn94xcywmW2u8tfUzNbEBilFiFK
         XQEdDUo5GXkoElxgayPRziPkBq/cjrdzbcm/EUPOOPJVxPZ1Ecx4WJPSSe7YfJbI9hAU
         XXXRIi/l1faxnTFKhM28b6CQb1hMk3joFcJJ0QjrSMNHaXGr5SDriigfbJ9WjknmbVId
         nwF3vhFJBsIqOqLgyA28v97PfnokIMzjPcl96kPhPcC9EnpHd2v0XztKy87BTv6ulhgu
         Y6Cg==
X-Gm-Message-State: AOJu0YxYyCqF/4SIxqAFTm89KkphfQTVJUgEwkKBh1fOzI5sCxQmqKpq
	tImzEmRJqRRAbSqqDwNKUIytIykBCNQyfiXF/mM+UlJYdZGIkqhHQflwwE3kW6FGJjvVYNovO2J
	9
X-Google-Smtp-Source: AGHT+IG+KQp/2UPB+v262lL13vKSoTcFv0DdiGTOqb57XhqAB3+StExChLeNCKp7Mz0cujw+/u6xQg==
X-Received: by 2002:a17:903:32ca:b0:1e0:c91b:b950 with SMTP id d9443c01a7336-1eeb0991088mr47671945ad.5.1715217349150;
        Wed, 08 May 2024 18:15:49 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c03b8e6sm1715775ad.229.2024.05.08.18.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 18:15:48 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Coly Li <colyli@suse.de>
Cc: linux-block@vger.kernel.org, linux-bcache@vger.kernel.org
In-Reply-To: <20240509011117.2697-1-colyli@suse.de>
References: <20240509011117.2697-1-colyli@suse.de>
Subject: Re: [PATCH 0/2] bcache-6.10 20240509
Message-Id: <171521734824.13804.15279321312095650681.b4-ty@kernel.dk>
Date: Wed, 08 May 2024 19:15:48 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 09 May 2024 09:11:15 +0800, Coly Li wrote:
> There are two bcache patches I'd like to submit upstream.
> 
> The patch from Christophe uses ida_alloc_max()/ida_free() to replace the
> deprecated ida_simple_get()/ida_simple_remove().
> 
> Patch from Matthew uses similar method which bcachefs code uses, to
> remove UBSAN warning of out-of-bounds index on dynamic sized bset
> iteration from the in-memory btree node.
> 
> [...]

Applied, thanks!

[1/2] bcache: Remove usage of the deprecated ida_simple_xx() API
      commit: 2abd9a197d828ed5c2cbe922368eb28d02861a28
[2/2] bcache: fix variable length array abuse in btree_iter
      commit: 3a861560ccb35f2a4f0a4b8207fa7c2a35fc7f31

Best regards,
-- 
Jens Axboe



