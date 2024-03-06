Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7084B13A863
	for <linux-block@vger.kernel.org>; Wed,  6 Mar 2024 15:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739332; cv=none; b=PhSgIAd7GunRQZgKeaiReULtRnyygkWVnaB4g7lh6ykn7+x9m91DIgeVsG+34FNRrQp34vv0KWrDOvZCzPpvwbMOLYKMmIwasw8tEOu+vlSQijVL71r5vNvY3aJCSisshYnP6fKubqjSiMLVkzbsle7WV8bUK89qncgAFuok4Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739332; c=relaxed/simple;
	bh=TwK6capiyfUQMZ1xgYBa5lRbR8pKF9uSWRpyW9JGPqE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FND9itdfGCsmc/arHmpdlR3s80SYw4qUhmIi9DiVe2F51PQvDNo4xhc76ucQ+jDmoGusBeZbEpcAHNZLsp8FXxRbxnynnHucJ/6Dilgi4SFeRmhCTm1bni/jhshJzBTlD3XdWf23yC9ikGKyCxlr6KvFaqJGBXnjl28kCUEn320=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UCVMF9R8; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UCVMF9R8"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-35d374bebe3so5646465ab.1
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2024 07:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709739330; x=1710344130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jX4nyne9Vjk99u0/ohdDAGsyHE7iZyQVnC8gHrggHOs=;
        b=UCVMF9R8ADzCo5nIgriOaF6xOKx/0vcLpbLCgdFeJIeHjEUr4qvawHbVJsNNa9/FCD
         YZBy4i+KahcLNG+uBiTyCGu6YHvwXwdKCMVoKdqxxsr0iCZCNLaW3dcoKzy4WfUTv5B/
         mviEuEhYOeN7qkNbLa402U4fPItjjC8LO2lyjQWtWlyh+6NhkpNZMFTnRFcxt6kfBPlf
         Mkjs3HgfMmzAyhbxWQDOp+uR5/X1rxCsaIdh61Qb+LNzAzCv4oNGjWpobghoez7m3GDh
         O/mrlFXDkVii5s9GWQz1y9vt0fKS7NO9mzJzQxP3xEylCaoe/8aAo6b/5zV7U9qPjDoy
         Xm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709739330; x=1710344130;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jX4nyne9Vjk99u0/ohdDAGsyHE7iZyQVnC8gHrggHOs=;
        b=ryWe0nrJmFxl/cakDTWKxqDP6b0Buf4EeiWfjNBiwZKLCPKBWgZR1UW7NGiJmFEeZo
         j69RyWPsoKeSSYgEijWnbh1jbyXUv0hrBQYlJpfSa/RJayu3zeGcn0iozP9xQKDiylNG
         3qhn1yWw0F9otfv5OEZzO4xMtbRhT65aFwpnf6aUN02O7i8vYRki2cQUvc7vcSa7D9LG
         wXd9wcCQyLlQh6Y7nqCzXhDN2nrGY+/OEW8r+Zw9G9w2vLfREcoXwU/QUPJZAntGQH4m
         Cm5p0zdhZFzJzPyzDYu7Au9LYQtfpJBiFd3GT7kOEo6A2jw3OocyOvgbiuDM3O98OUFH
         3BYA==
X-Forwarded-Encrypted: i=1; AJvYcCX8zHbnABeaxfeHoo4bB9dnAkre6iRrzsse5EwWkJl3AM4EhlAZyDWlmJaD3I9uZostOaIKHs5Y8dpHZYg5CZnYpGKbseOmT3gwg7A=
X-Gm-Message-State: AOJu0YzL7EOpA9PZSJbgAKqntJTluEHfhIRhbaxvmzXTNZlVkH55g1u6
	GRZs0DnbIccGN1Ww665nuGM9YxtaKVQnFKOZUtpOYf6LJCGAC2n6fxuPu5NrbFc=
X-Google-Smtp-Source: AGHT+IH1bcw4KhZiBlzy5h98P6a4jHCdS8o6jRQnommbMHMGdLVJEO3B9N/OVPPwu9nqf1K5rJA3RQ==
X-Received: by 2002:a05:6e02:152b:b0:365:a792:3749 with SMTP id i11-20020a056e02152b00b00365a7923749mr3880536ilu.3.1709739330455;
        Wed, 06 Mar 2024 07:35:30 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t2-20020a92cc42000000b003660612cf73sm324467ilq.49.2024.03.06.07.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 07:35:29 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, 
 Christoph Hellwig <hch@lst.de>
In-Reply-To: <20240306140332.623759-1-philipp.reisner@linbit.com>
References: <20240305134041.137006-1-hch@lst.de>
 <20240306140332.623759-1-philipp.reisner@linbit.com>
Subject: Re: [PATCH 0/7] drbd atomic queue limits conversion
Message-Id: <170973932937.23995.12080568570430339256.b4-ty@kernel.dk>
Date: Wed, 06 Mar 2024 08:35:29 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 06 Mar 2024 15:03:25 +0100, Philipp Reisner wrote:
> Here, with the Reviewed-by and Tested-by trailers.
> 
> Christoph Hellwig (7):
>   drbd: pass the max_hw_sectors limit to blk_alloc_disk
>   drbd: refactor drbd_reconsider_queue_parameters
>   drbd: refactor the backing dev max_segments calculation
>   drbd: merge drbd_setup_queue_param into
>     drbd_reconsider_queue_parameters
>   drbd: don't set max_write_zeroes_sectors in decide_on_discard_support
>   drbd: split out a drbd_discard_supported helper
>   drbd: atomically update queue limits in
>     drbd_reconsider_queue_parameters
> 
> [...]

Applied, thanks!

[1/7] drbd: pass the max_hw_sectors limit to blk_alloc_disk
      commit: aa067325c05dc3a3aac588f40cacf8418f916cee
[2/7] drbd: refactor drbd_reconsider_queue_parameters
      commit: 342d81fde24152adf9747e6e126c8c3179d1a54c
[3/7] drbd: refactor the backing dev max_segments calculation
      commit: 2828908d5cc8396e7c91d04d67e03ed834234bcd
[4/7] drbd: merge drbd_setup_queue_param into drbd_reconsider_queue_parameters
      commit: e16344e506314e35b1a5a8ccd7b88f4b1844ebb0
[5/7] drbd: don't set max_write_zeroes_sectors in decide_on_discard_support
      commit: e3992e02c970f6eb803b98b9f733cad40f190161
[6/7] drbd: split out a drbd_discard_supported helper
      commit: 5eaee6e9c8f9940ecee93678972774fb8dd450d5
[7/7] drbd: atomically update queue limits in drbd_reconsider_queue_parameters
      commit: e6dfe748f09e37f77437bd337f891f5b57d5d5a2

Best regards,
-- 
Jens Axboe



