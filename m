Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A7E42A8B
	for <linux-block@vger.kernel.org>; Mon, 17 Feb 2025 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739808283; cv=none; b=LV6CmxvLmzD7+xfma50a2NldplJt6Ml/om6PLH6yKeIqr+r8LWJtWessQf3nekhUV0EzR7xP38ca+9wwzkPsfPVQMGA3Bx+KwENMsVDEStTfgopPb+E+4FWC/YkY0AJ2RxMPvZWxLRKWvyx6bqoOTCCtVH80xvCXWfZVhldIVSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739808283; c=relaxed/simple;
	bh=fHxnkJg/OG5NfLkyUHDjvJdLdqF52ZVcuLZfO9XyvnU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UJppFTkhTY6ixm9R+dshR66dVst7xMJmMieCKjR6f9V6+o3LHAxabaD/lykcxUVEqDQOio7Mcfc3Wpz9+PzOPvQUFIkYlqYO8dZDnWs6obA4AVOcnseF0uhMFHaT0/L1CF3tiNSeuITIZFxgliirfG7kaSfQWCiq/Fi6yzhQgPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=D8HtBOdX; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="D8HtBOdX"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-854a68f5a9cso379278339f.0
        for <linux-block@vger.kernel.org>; Mon, 17 Feb 2025 08:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739808280; x=1740413080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Of32kxxqkdQUul3Q/d4M92FwvvmlyFoUH/mlpGvEoM=;
        b=D8HtBOdXBTYotgYa+MIBzQh68jYXKj7+UtCxARwUPWQniVQLhq9NvH/Gdx+9vgdJV4
         tCkSz0UYrVZt3yKHNGoLKmaNAjOqEFjvCRNnf+KBlsmZDCF1BEnoINWslsHSEbNJn+Yn
         33zp7LzvGandug2otwhvm6AcUsB1yaUQyU3ch47HF3tsNt/IYAp5EujH9hHmBjDdbfW6
         gkXVffE4IYzEu7RwYopHqh8vOEPKN4+NM0ZP6LPiiVWo1pAe/RHgViYZLHEXcX+Jz+Fb
         5hY1FgPx5p9iegzml8Dn65KBgVX8ckfAVeZEE8VHRmP2LcpCBOEfr6a+steAFGP7/R9t
         8xWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739808280; x=1740413080;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Of32kxxqkdQUul3Q/d4M92FwvvmlyFoUH/mlpGvEoM=;
        b=ay6LGfpXVnqoLoGlWedAWJLnCeQL3Pm4PMYw9gRhXBnrSbrBi+NyBdS4sqI6oWzonj
         PAztiitak/XAL8y/m2PfA/tv3ovzzcCTSItdbMngNyZVcANroK/2Lo4aw+bvCUndLD6t
         IFv1wejyjjcl/gUv2Tl1rveRPYNGaYqN+jUAwXeYpCzcK7IexR+iiV5ENbydZkvKBAXa
         dfYcEDnxJOyp6W3S/6VfyqpPSDxvpGYcjMpoTeMxrz/hhoQpnaBsHnpvpDE8LRSj7IER
         h5twA9RXaMqH+zzHdaOOsbMkHGOgD+ANgh72uqGLRiGkhCgGAU94ix6MdHpVcFyXIxIP
         L8Fw==
X-Gm-Message-State: AOJu0YynR1ornkihMLKW1c7fQX7CbHJb+9VQpU71dO02SDu+y/J/O5zQ
	AJBndUDMZlKJv8T7xwnhFP5g4RoV7SB1L+kuC9Q7U2g+7uuaccABtTsF5z+6U0ik+FxXLOlxdLS
	D
X-Gm-Gg: ASbGncvT4bPdEfHH8bvuMPR4p7LeO9Q4SynmG4D0Nvlipjymd1mdHSQgkrOqoDR8HLH
	Dv3ULH+V8xZoe2d2jATheCmZJiCJKU0swG0t1eICMQoyiKME/gOfi0wSoj3yo6kIUwAsUUCVQVd
	cZVVlrNeA/hU6NakDIjLpMdJOK1wAVaYFDrfKunHhqAgNF2m7Q0qa0tdAA21usrR9abPYO4c36n
	pkfGcj4P/xXUBkT6UaMlnRJPA/Sbxlv1BKidJ+RhfPk/n8Ayo1BxFlNUtWUsXJj/DMqC6YT3Xek
	9ZKljf8=
X-Google-Smtp-Source: AGHT+IGwZm5usgS6agwfj0xXvJB05KBP3+53ibIkWRwS+ofepHEW7xllCngLljERba37Dk0vX9Qmwg==
X-Received: by 2002:a05:6602:6408:b0:855:6fa2:c324 with SMTP id ca18e2360f4ac-8557a0ce310mr1067266139f.4.1739808280199;
        Mon, 17 Feb 2025 08:04:40 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85566f8f801sm193285339f.43.2025.02.17.08.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:04:39 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, 
 Cheyenne Wills <cheyenne.wills@gmail.com>
In-Reply-To: <20250217031626.461977-1-ming.lei@redhat.com>
References: <20250217031626.461977-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2] block: fix NULL pointer dereferenced within
 __blk_rq_map_sg
Message-Id: <173980827919.830791.3313165347020167089.b4-ty@kernel.dk>
Date: Mon, 17 Feb 2025 09:04:39 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Mon, 17 Feb 2025 11:16:26 +0800, Ming Lei wrote:
> The block layer internal flush request may not have bio attached, so the
> request iterator has to be initialized from valid req->bio, otherwise NULL
> pointer dereferenced is triggered.
> 
> 

Applied, thanks!

[1/1] block: fix NULL pointer dereferenced within __blk_rq_map_sg
      commit: dd8b0582e25e36bba483c60338741c0ba5bc426c

Best regards,
-- 
Jens Axboe



