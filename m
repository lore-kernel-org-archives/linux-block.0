Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450BD78F2A
	for <linux-block@vger.kernel.org>; Thu, 19 Dec 2024 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734619755; cv=none; b=XZEg8uqPxF2mICcqM6bxq1Z4t4T6ZERYT0lXMiJwaIYHPgvC7uZO3QXVtc3Z3gYmE7bw5yUwmVmFiiK8h93o33fbGzgn5Z8Df7dlYmegPj8VHwXi9BVmnTfauVSI9/TkbcmMhOzKhL+6n5+Piox+OQFPsFykroePbDdR9BTGSy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734619755; c=relaxed/simple;
	bh=Q+EomjDZycglZsjryq0cM1VeuhUT9pL5FD0hsIAghG4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DVoUytpuX9Fmd3oVZJA8IES0Kqq2IeGqrW6+eM/oqtp0LMRZ9yRXfmu0dWv9iEh4mufnTzChhR98f1Ogn4jNx0TnkZfbZpyItWgYDPDpu5j1pyWOx2ypQa1dYCa+LaAvMMGQgTw5HZ04kl1aSIC+XhJlNnRbX36OFqoZYUurvOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QYK9ibPM; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QYK9ibPM"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-844e394395aso29037939f.3
        for <linux-block@vger.kernel.org>; Thu, 19 Dec 2024 06:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734619751; x=1735224551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQ60x+mPbb77CyhDa0DiW7NwCMIdq/cT+gHfSLtJd14=;
        b=QYK9ibPM5b+Qu4AFbJoVBfhBFSxj79RVOUQrZeq0LLbnxiqwTr6TlDyx9VZqQHzqDY
         BUHfGo+Q4v2pTOGzJFRq7e+OABJ1qhbJurXT5UrntolWMFFXOtAa9a87mwUgtKs1GlmA
         Q3c/bwDZWn7DUQ1mWa/M7WVaVO1nRhiGsWsms9iJ+75pgkm6PzQeXDLCzZ91a0DqzTu1
         XFlyKOiqCPtU5/PvtaY+xwtN5q9xUw3sf4oTX7Sl8QQXot9Kct6UvCHHBf/duwUPF4zY
         b2bdJBpQUGVRssjv/By9ew3nQO499G0zKWTl2R/mEodjduvpyCIesV+hmSn5BVXsr9Iq
         QFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734619751; x=1735224551;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQ60x+mPbb77CyhDa0DiW7NwCMIdq/cT+gHfSLtJd14=;
        b=W1HUKQqhha5y9yEXnhr6I4W/qCBIeAKzDrgzTAyNxdfLxTfdzIy+AFN6j7QJ4bkCrm
         FrgFZLuaGpFcBckaqNWydATqlah7a+dcMwjqZjtH9dN5hgEnihJR4ToM4oTUOl3xIzoE
         K1r2cLQfniucCsHuId4KlRZR5QrVSsgqfkTR51DFV34/9WjkdlTBH2mHfOV+QkJl7lRq
         b8ax545MHhBq3kRyzBOLr4xostbCbgsXfxnekM3VbxzzxExMQl7NJ0Zxdie/HOQFsbob
         rAaV1izPRWBsS5wsIXfGMCAmzO+9PYjJaoYKIAjNI52h7Q0Ii9TaLOcnUBfKUJi+tZB8
         X4aw==
X-Gm-Message-State: AOJu0YxeYSsQIwDEHE/HuiB7WWzyoP9bMpG9d5xVVhtDixWW9XRs+k8d
	xqX7MbFK0pE8WOJodvhQfvmFp7Sk8BRQiA9Z2/5SbgBxgSwdW0ZCOMBXLj62BLbZP4GwHW1WU3Y
	j
X-Gm-Gg: ASbGnctQjetWJ/7E6oXNHEJOLyZGbXk25qDjVFPigAOea7pSPGGxEdQNqttLhUY3KwJ
	HZEHMH1VMyaMDUSUky3aTO3qq3YDOE7OlwMw4M6xKOGaobyTBppSPMp8MCzjtomtr4v7IX4kPmN
	ESvsSnJm6jQ9951NN2Nn7txiYKBcw3MMkIPGHY1eQcJ1RmZuuDh3oMQF2p8HYfchjMH5jxvlGTE
	z8vqsShHjRjt/W7zWGyLf4x2GTk8J9Ove+GZWhVAduugnw=
X-Google-Smtp-Source: AGHT+IGrWIj+Dq1PoelgceWWRGXFk1gpLjNfR5GYtB8xJgcRso1BbCMhrtk/e6Zg/9Gv2jengF+7Lg==
X-Received: by 2002:a05:6602:6410:b0:843:daae:e16d with SMTP id ca18e2360f4ac-84987c062c8mr360043239f.6.1734619751107;
        Thu, 19 Dec 2024 06:49:11 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf4f3f9sm301915173.1.2024.12.19.06.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 06:49:10 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20241219060214.1928848-1-hch@lst.de>
References: <20241219060214.1928848-1-hch@lst.de>
Subject: Re: [PATCH] block: remove BLK_MQ_F_SHOULD_MERGE
Message-Id: <173461975023.786617.2273087317101243902.b4-ty@kernel.dk>
Date: Thu, 19 Dec 2024 07:49:10 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Thu, 19 Dec 2024 07:01:59 +0100, Christoph Hellwig wrote:
> BLK_MQ_F_SHOULD_MERGE is set for all tag_sets except those that purely
> process passthrough commands (bsg-lib, ufs tmf, various nvme admin
> queues) and thus don't even check the flag.  Remove it to simplify the
> driver interface.
> 
> 

Applied, thanks!

[1/1] block: remove BLK_MQ_F_SHOULD_MERGE
      commit: 9377b95cda735bb14f7a2243a4f49ee9c8e948f8

Best regards,
-- 
Jens Axboe



