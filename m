Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEDC346FB5
	for <linux-block@vger.kernel.org>; Wed, 21 Jan 2026 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007349; cv=none; b=s8s+sV4eJtoBAHZ3KNDiFivzS5hDZyKq4VKawM8IJ8SRIOqf66fEVKtajmhXcxKXEinwk7q5yG7h47ksY9eGZXLAlsmCbvL8z76oB8TTHUzpfRC1NWLuZWioB2ekMbe38Os7oSpKtwuN5KmiUCRIPcHG9+TtT/sVc0W1Z14pqgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007349; c=relaxed/simple;
	bh=oyMoqMzfrO6hhjmIJXEL1L+H7flIoCNgzMBvcdiXLR0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=p/246c9hK2OmlJI93nFxHNa5cX7SM3aa/rQPAum9ChMWYcEt2rpEPj0btYsprTJT3mak9NkoWGaR2a9l23dk33uXYG5yCvMm2PA0RmuBxCwqgrEYF4bsw9ccZEBj9hl/MJz6HhtEfF0Z07zE/lSnoYkq+/RxO6wnG/v5oAzX3Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QycMTy/w; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QycMTy/w"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7cfe2a6bf81so1990781a34.0
        for <linux-block@vger.kernel.org>; Wed, 21 Jan 2026 06:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769007346; x=1769612146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YN1rAYJSflyi0JuUEgrnI+IKrGTQTtoF5SqGUf18jyQ=;
        b=QycMTy/wJ8gruUum444xXfzMQB/AMcV30R6z6g22SikENxfd04sSWrrqMtnHAqzndz
         o21J7rPRfrT7uVZxWBRySNdrd/WgeGNpYG1XBVXAlz7SL6hfrpUcKUIHqvTq8eodvulg
         uVzoQ3vz9iyMnuI1vqWeiHccQBSF3ScOkGi6Sg3gSd75yLFxdPJThdK//E5+ipTy5D8Y
         5q9gMZZgq15wJ/1GIlfpnT8rOfjua9b57FAIkSQZA9yxMXIGHvGGeFoV1oif2mDtwoba
         cs7qnaWjEjvlFVoIcH7MSso2boU/BXwOGhLRCoYCs6UrL0gtRF9aGwfIcG2FgPcdcU8w
         SuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769007346; x=1769612146;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YN1rAYJSflyi0JuUEgrnI+IKrGTQTtoF5SqGUf18jyQ=;
        b=ZXsUkxfIT7UsIbWPHWaqLXX8qOlHHUOLQZ3zj3kQ2yPQfYWwAEqXsdtipz7ASu5E/P
         oer1aVjbK0mgUXajlF8aeQH/S2BXfAH+pNu1ffIsX2UN2h/6B9UtcMNIjkd+m962Wnfj
         BVOVs3OusM44UZdK2g20LgimLIWgh1J5PbraRwVgSHilk8IV064zNLRlcVH6z0nMxeGG
         3uyVhbVq+AZCrFHmGykPnkZlDA9sJ2OGJZourNGA0RiB4O4WQaHdekWXbEF5XIOT5lM+
         wrxQ/3jWPxGYD520OtDUur60cwU6jYGaeCiEddiYxfotM+8t7blU48qJ7y6WpbfDFrBq
         bWMQ==
X-Gm-Message-State: AOJu0YwHZPCKlAzKB3kjdwGrfZQJMnYkPGGeFfLe/qpDLZd3IhrKpiPZ
	YRvCNUC40Uob2yzzfaVq1Cq7f7HxH+Im7AcxXpwuCPJBCrS4cvxpUL8JyaEL+437V84=
X-Gm-Gg: AZuq6aKoqx5LqIdobjiwCIOXQeAJlUq4UcqykMgbM8p4kYx8XY9Bx9a90DOPsVyLI2g
	a8LXjvP49lKlxCzlV9LmPz8tMhij6aDtJC0JggRczE8PDTvzWzIX7voCJpQQ5r4yJkPcqrl7BXf
	tSjS9PrJpDB8msdyqfc9Kk2X5jpxdZ7BPZNRU3o1ow0/NT+8zJ4nhfsQQtl5KBfu0olyjScBhQo
	nln1Frd1GdQM4EsVrZ3d63ljijLlq8zWm2Peda5nb/YpxIR8CqVF+9yIAY6OWfHga06Py9m2jwH
	VWfhTM40m5EMD8f3oPmqv2E4Xj0uAqrmwAKjP4Mv3t+anbDLviPk1O0ODO0SxYOfyti10mz8oC4
	3h7rYjvIn8/m3TV1BfYYU+uXgjfAIzTkVsmES5AyIw3j9LSgyaQgP5FRbJRq6JXZgKi5IS3W70V
	RHnVIFlkuvN5D0qBgjn2TS1EX8p5McrwHbsPxhjFGXjd5BKEXRUqunIenFrybuKUAad5DhwWuSC
	g==
X-Received: by 2002:a05:6830:6735:b0:7cf:cb09:b7e8 with SMTP id 46e09a7af769-7cfe02b53d6mr8624701a34.36.1769007341366;
        Wed, 21 Jan 2026 06:55:41 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf2a60f1sm10300762a34.23.2026.01.21.06.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 06:55:40 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>, 
 Seamus Connor <sconnor@purestorage.com>
In-Reply-To: <20260113085805.233214-1-ming.lei@redhat.com>
References: <20260113085805.233214-1-ming.lei@redhat.com>
Subject: Re: [PATCH 0/3] selftests/ublk: three bug fixes
Message-Id: <176900734052.11503.10092243182514467838.b4-ty@kernel.dk>
Date: Wed, 21 Jan 2026 07:55:40 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 13 Jan 2026 16:57:59 +0800, Ming Lei wrote:
> Fix three misc issues of selftests/ublk:
> 
> - make sure all io_uring commands are completed before exiting from ublk
>   thread
> 
> - cancel in-flight uring_cmd in case of failing to start device
> 
> [...]

Applied, thanks!

[1/3] selftests/ublk: fix IO thread idle check
      commit: 75aad5ffe099a1b1a342257236dc260493917ed2
[2/3] selftests/ublk: fix error handling for starting device
      commit: 23e62cf75518825aac12e9a22bdc40f062428898
[3/3] selftests/ublk: fix garbage output in foreground mode
      commit: e7e1cc18f120a415646be12470169a978a1adcd9

Best regards,
-- 
Jens Axboe



