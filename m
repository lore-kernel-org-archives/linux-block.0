Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3598C1C32
	for <linux-block@vger.kernel.org>; Sat, 26 Oct 2024 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729948571; cv=none; b=kfa+d7MAzjJFXm7/sI5/Cv6llV/voksUGbEQjEf0F39n3BrHOs70Oip57UEADnn3bYhQzNPcX0vRZmt8PK7dQsqJSwT2z56R9Lx6GsoXRF7e46pATkFtzWdtKLwGgEGqiyOGFYCvf3sVy2OddX7PSfhyuH5pBzz9qL319wlv368=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729948571; c=relaxed/simple;
	bh=HshIz0FZMYgPscW+buo1EmSjueZZzXnsSSSo8Gei6xo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JHGf5vwkNkU00/Wjwk72X+/QGaXxWqHfOzMWW+VLXCXZCV0xWrj9jab9Hgs+WR9YiNpQbcQdVlbxKHKPfybtpm5unZCVSwgdb3V38WagOMc6ZXjDF2VZHTuvGfrVx1lPbfhxu7J3HxJZATpjVsCiILCPKk0et7H2wiqalqVxFrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pYMlH1pv; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pYMlH1pv"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2eba31d3aso2041087a91.2
        for <linux-block@vger.kernel.org>; Sat, 26 Oct 2024 06:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729948559; x=1730553359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80w7ki3isYWdjzg7EiyQZPHIggrfFyzyhk6ks2u2wSo=;
        b=pYMlH1pvGDTiMYQg5QVWHVziiS2G+yHHvIHo9tJSuLtSsdTuHa7767vcsAc12AvtYv
         myOM9d95lCKCe7pJqoKgykrGSehmPkSa3WVDTRIo8QkvvJIIdkgtQl5ud5G27yNiDOx4
         eJ8+QU9btov7PJADxxRItTUoFxHzd4K3p05TcJx8dpYsWZ26E/uaIzfFd9b+awQV4OEo
         0P3fHvb00BYD2jd5+5L+M0yeUukkKyn0lxGRX1JGZ8F7qSeSFVVIt4ezxPqbJFwqPnu9
         4+Dj9Qa7vZDpnbGYUzCBEZiLvWQeUU70C/m2FojDTBIaxFZj7a5w/ISCvE5hmEo6VLrM
         XXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729948559; x=1730553359;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80w7ki3isYWdjzg7EiyQZPHIggrfFyzyhk6ks2u2wSo=;
        b=QFys8IqYxTUEUN2B0nHOF1MdRLyWIeLOEebMc5tlR3Ak0Jv3E5xTQOk8bgt3SnVbvO
         BuhrpqA+Ca0nXTbJMhAWJQRdrm+jpyjcG8ywTP7YGrlpivqBjbaeIeC7gulloyyk+HQp
         x3x6KE0GN3Wspxwe5gYugxd4hh6rptXDnmSvQp6Yw+EWDqFDyzcmKblY8UuAAXsP2EnJ
         zum6nrCGMp0Rs3VS+hXIi2lr5MGfNOqvkWCexKuj2uVlSTle/N/nJhgLRh8FCdm+gDBi
         LfzqKNGRR7UA9AY5P5JLIJ6gbrV1Eq1tuCFqXWkhYCufx0jqVJaL6AtZ/hYkrmYlQtdF
         b3mA==
X-Gm-Message-State: AOJu0YxahJ30SicuqLafK9mpJ7OCGb7ViKlpGyV1QWRsAvcjp75nmdMK
	m6iI+0/J/Ihr69T7VmileNp9m9FnhYDhZqlJiVvSv+7qbyNYZyx48BWmm280wdQ=
X-Google-Smtp-Source: AGHT+IGIojFAlrWbyH2cBN+QkXvxnbPvE+zW7RdFIF93JSqkE4mSH354gFB5/R4rbfMcwSDcAMffrA==
X-Received: by 2002:a17:90a:9312:b0:2e2:a8e0:85fa with SMTP id 98e67ed59e1d1-2e8f1057e59mr3253112a91.8.1729948559098;
        Sat, 26 Oct 2024 06:15:59 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3555adesm3422731a91.2.2024.10.26.06.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 06:15:58 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Peter Zijlstra <peterz@infradead.org>, 
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
 linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241025003722.3630252-1-ming.lei@redhat.com>
References: <20241025003722.3630252-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2 0/3] block: model freeze/enter queue as lock for
 lockdep
Message-Id: <172994855784.317773.15027485410465627721.b4-ty@kernel.dk>
Date: Sat, 26 Oct 2024 07:15:57 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 25 Oct 2024 08:37:17 +0800, Ming Lei wrote:
> The 1st patch adds non_owner variants of start_freeze/unfreeze queue
> API.
> 
> The 2nd patch applies the non_owner variants on nvme_freeze() & nvme_unfreeze().
> 
> The 3rd patch models freeze/enter queue as lock for lockdep support.
> 
> [...]

Applied, thanks!

[1/3] blk-mq: add non_owner variant of start_freeze/unfreeze queue APIs
      commit: 8acdd0e7bfadda6b5103f2960d293581954454ed
[2/3] nvme: core: switch to non_owner variant of start_freeze/unfreeze queue
      commit: 6b6f6c41c8ac9b5ef758f16b793e1fd998cd25b4
[3/3] block: model freeze & enter queue as lock for supporting lockdep
      commit: f1be1788a32e8fa63416ad4518bbd1a85a825c9d

Best regards,
-- 
Jens Axboe



