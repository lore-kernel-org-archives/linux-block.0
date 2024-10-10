Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6161991B8
	for <linux-block@vger.kernel.org>; Thu, 10 Oct 2024 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728578440; cv=none; b=J+vF3a7cmK4hOtPSOjHZ3WH+9cyOXOKJ5MtmB5SphZwfHfrtZGVVmw7RudaMSzX+ZUGliNE0GUJr3FZH9aWBOThj8bq9i9A4lmeXfUI564iepEGF6zg41kCCwhpYyLTj+B4hEEuSwDJVoYhicBAxe/BrSwThEv9tuAkLLXfsNq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728578440; c=relaxed/simple;
	bh=emRD/yhiwJNd5I3pgU02YmFVVUfHmQHkMVwo0yCFw0I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tTfWXNeNxI5VdkdOTHHLyI4IjEdmRpmbUCPsez5F961cJUb6F0UeEtlkRJcTA7CKJdjftDyjEkZ6naLWJy6moTC4Oy5MsQvoh/Ekp0JBwA/iMEs313qVuz1BXTovBR4H4zvACfN473GhPJOlKVUgHT4ztjqIvEpMUpVDu0/qUMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qPsGo8OS; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qPsGo8OS"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-8354cecdfd3so35322339f.2
        for <linux-block@vger.kernel.org>; Thu, 10 Oct 2024 09:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728578436; x=1729183236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyEsB+OCzLx40GaxNsnDi2QdTHIQWPihWeYETwMhlxk=;
        b=qPsGo8OS6Sl9xhrIuNpN0TgusVnXqpRlx8G6KM4xOP3rmGq6KNhd2dLTBc8bTLvCON
         ZcGF4eEDaqB+HnXpj4WOzJdaYRGVv5nVUpS2ZOc3WbYUggza6ON0JLTMYDwGCOcPJOqh
         OcO0IUsHzf1w5nm4eEh+JxKcmU9vvHHPFAvILGRN0HOioG+vfe5FJxUiOXI+9hFcz8Xk
         9PveRexzB3hlgV40sasC/nDXvLD7B9rzKq6qqEjLlgOd5eVEb0Q5qZ2EnpbH/2jqQh9N
         e8vsozbuh2Odep9EnabCUvksxlNiRLC1Mr7rl5ZjMHv5+Rt7ZjBXUr5d4Gh76aKklmZE
         h1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728578436; x=1729183236;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyEsB+OCzLx40GaxNsnDi2QdTHIQWPihWeYETwMhlxk=;
        b=LZWKXkNiCRM9+9wry6rK4Cel6GxrOx1rdUo5TDuw8sA8q96K6Oskp64vkn7tIKl8tt
         Jg2DvY6+AWt3XF9q3xU1Zy9C44v+n6gj91dbu2hY26YRKmOuH7OCckdRSCAJ/bJ1W5qW
         u/Q0V2vCJBp3O4rE2SfTEFlu9gsieisbKgfh7fZu9dZUqaIqEeir6tLnFkZdyfaBNB7Z
         jSgKlnppK8f7TQCRMhd5S/f2XwFCtRSZyM4xZO+ESHL6P6tAf9800p4R9Id+yQLRvsYc
         vlCNJxlftNOBDLOqr7LGTfaapZ9c9taUk+/eRl7QOg3jKiRCrd3E3jy6cEVvv01YNHFm
         2asg==
X-Forwarded-Encrypted: i=1; AJvYcCUbPcmAXnAsTn80dZJi9Xe2FsPuuN05Y5C/4bCL3q4xa1uxPCiWCDJjOYYNRfCadRKHUDKq8fqU+gYGVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGpLOnFMeB1FX/TA7dt8jMdY7CMZlfFGCbeumJLjdUVHjY28hF
	JKBn7Ve+Ve3zDTMxvZNq+cL3gKxMeCwVpWP/oSAakMKvMnNT1X7nMgJZ6RWsHI0=
X-Google-Smtp-Source: AGHT+IFEmCZPBVhf98FTxzWL+eR06aMmyiWwZQg2crpBWOEdUtRFqg0o1IYByJp66uZ0W79z+8AwVA==
X-Received: by 2002:a05:6602:1555:b0:82d:129f:acb6 with SMTP id ca18e2360f4ac-8353d5125a7mr656986839f.14.1728578436301;
        Thu, 10 Oct 2024 09:40:36 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbad9d51afsm308876173.44.2024.10.10.09.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 09:40:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Breno Leitao <leitao@debian.org>
Cc: kernel-team@meta.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241010141509.4028059-1-leitao@debian.org>
References: <20241010141509.4028059-1-leitao@debian.org>
Subject: Re: [PATCH] elevator: do not request_module if elevator exists
Message-Id: <172857843553.77782.4750472326626678741.b4-ty@kernel.dk>
Date: Thu, 10 Oct 2024 10:40:35 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 10 Oct 2024 07:15:08 -0700, Breno Leitao wrote:
> Whenever an I/O elevator is changed, the system attempts to load a
> module for the new elevator. This occurs regardless of whether the
> elevator is already loaded or built directly into the kernel. This
> behavior introduces unnecessary overhead and potential issues.
> 
> This makes the operation slower, and more error-prone. For instance,
> making the problem fixed by [1] visible for users that doesn't even rely
> on modules being available through modules.
> 
> [...]

Applied, thanks!

[1/1] elevator: do not request_module if elevator exists
      commit: 822138bfd69ba93e240dc3663ad719cd8c25d1fa

Best regards,
-- 
Jens Axboe



