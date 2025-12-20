Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E87430F950
	for <linux-block@vger.kernel.org>; Sat, 20 Dec 2025 20:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766264331; cv=none; b=SX6q8aihmvGoFgcZOp6uyPMNlrae64KjUNFf35S5lehSqZrAv8svrHDtddzHMtpMJujRAkMBGfJo/lrZ26kvB1FbKzx0nJyawDic611XG3UfnVfKJYGaRSvSN5xD5Ijp7bkRSUBHmn1TODk+u4QWg3SI1FrTn2o+1VL5QwURANI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766264331; c=relaxed/simple;
	bh=FuxQS6E0Qzft914wYAlyaZ47/nuyIPysXDjhmxdisGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jiJRxUnI0lseoQ+Ete5GevqCThIJNQT/Ne2h1SbFt7D7DUe3BZax8gx1lMjZ/OMYFTMgdkOxYpk/Ee9ooPDKOLMdfvr/bkH+TfHKGcf9a6OvK1v3XOgiMT7VF3cd3ZjIMyfYL9gApzmDwltHSTCoVPq/ttdvkqjUsIF/jk8lSio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQwKBhzS; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQwKBhzS"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso2448837b3a.0
        for <linux-block@vger.kernel.org>; Sat, 20 Dec 2025 12:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766264330; x=1766869130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rv3JIVjNgbdyh2io0L3fN/o5T0HuY7Hr8INRNlkFSBM=;
        b=KQwKBhzS38L7C1XjKOMITCOVb10V5s2hWbV74yWEoGipcsBPaOOYo1nG5y3myvmf+M
         CvOgc7RHd0ZKlAoIMPAnUjoJ2o1viIHjwko45lGIvH0QOeyorQSQOmgmmUnrbB3Ez21p
         S/1sYCSnG9tJYd3Wa0efqu7Qz83oH7QFkj/IZeaiMq2qpb60Ee7ARUTo5e3qOrCi37LF
         ks6DYJzCwj9nFiZYUiTOfJPrDIJUZ+JJGo0rYJJZYFtDdL+iKHso04nKlzMnB13fGHIF
         jpx/wFfawWC7hHMK8NRTwb/sI74tSRexmSRzVk8plZZSSC0YYUF8Jzdl2Om3oC0i4eZ8
         Ub7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766264330; x=1766869130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rv3JIVjNgbdyh2io0L3fN/o5T0HuY7Hr8INRNlkFSBM=;
        b=DC7U4rDhjprqZfYQCxTtqbp+bw2tvD/V1aL0vtEjI/Y4jBiY6HynSvoVmxnW5gdzOj
         LxiSLfJjM46lIXOoIQYjTv96fNMfEt7SshhhtC30jrFqKdotXGw9uMPb9a0j6NQKqZ0C
         vas25vvJW4kqLl12C30i7U5ob6lzajjCqCEXT2hAuzor/wp6q+FG+YRQUk2L6VKqpRRr
         h9vM5o7CGEfdjuYGv3Q0Fej6rOXzN2aMksZA8IKOOxOsQ+yYbXfArmq4L2ok0S5XMk38
         atjMiGYaWBZqxgp/bifc5OLjBzNBVTz0WzGOfhHo91qoYJ55BoS3wgs5CFwVOBeggUMz
         1p/A==
X-Forwarded-Encrypted: i=1; AJvYcCUb9KWodDXhURGif65Bwg+rlhT7gKYIowE2MA5AnW0NlYW4jDvzs4DTCoBLrpFzPOZ7vAWDeyN3o6/nUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpCZda6aktudQ9My7xxqhASSqRI3iQz33kTh/ErzPoWJAJofZ0
	PPt67ElimUrJjvm7Foc6otT8qsl5rUuObZE0xgLkM8CaLjHGEzETwKbF
X-Gm-Gg: AY/fxX7JNILw6nZZ27urv7p5H857Vq95/hzMQG+Nc+gaiKyXZjTUGnGbqABiVpEuIxZ
	OdLEXLAPFFQGN4IXKDRqOAafh9nLkQswb41XP/5+F8RgOpzGG0LFoZdYa9dLsgSOqPK+pbUa2D/
	XjvQML0csHM/TfQLVzRH7FsKr/ryk68R6o4W21uPgS3pCj9B3wdH7js5x6XfoncFqE5ZKfgq6u3
	SkDX8J6xFGroda4W0GFDIwIMVOpZzrZNMf15pASVpsbPLBlYXXVqyxaciFzGzPACQi1XPu3c1Vv
	R6HOX4v4uDkWjVF3rnHCLxcLAMWC3nCXy9fIwRe6p3rObmqokSawkvoXVOGt4mnwMmNNN+FJT1z
	5K2jGBi7ODgeleTfpfBDI4Je99ddQH4FdkUqi9vRO3ePgsQZHrzF5dB0+lbSjNKXZwpEthuj8Qb
	1mnoinapyzZdyFUsNK9CxbZEnE5II614DQhHrSiQiiy6w=
X-Google-Smtp-Source: AGHT+IHvwuYKMUU22bSDiWhgDhgPtQNkVn7dYPOpwL8nxp+q364FIMqTcJxyMX2lBMhJzgA6rw2kyw==
X-Received: by 2002:a05:6a20:3946:b0:35d:53dc:cb57 with SMTP id adf61e73a8af0-376a96b9113mr7150196637.49.1766264329534;
        Sat, 20 Dec 2025 12:58:49 -0800 (PST)
Received: from ionutnechita-arz2022.local ([2a02:2f0e:c406:a500:11f0:cf32:1f0:98ab])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7a93b441sm5878717b3a.9.2025.12.20.12.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 12:58:49 -0800 (PST)
From: "Ionut Nechita (WindRiver)" <djiony2011@gmail.com>
X-Google-Original-From: "Ionut Nechita (WindRiver)" <ionut.nechita@windriver.com>
To: ming.lei@redhat.com
Cc: axboe@kernel.dk,
	djiony2011@gmail.com,
	gregkh@linuxfoundation.org,
	ionut.nechita@windriver.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] block/blk-mq: fix RT kernel performance regressions
Date: Sat, 20 Dec 2025 22:58:22 +0200
Message-ID: <20251220205822.27539-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <aUaa7IbGko82Dn8Z@fedora>
References: <aUaa7IbGko82Dn8Z@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ionut Nechita <ionut.nechita@windriver.com>

Hi Ming,

Thank you for the feedback!

You're absolutely right - blk_mq_cpuhp_lock is only acquired in the slow
path (setup/cleanup operations during queue initialization/teardown), not
in the fast I/O path.

Looking at my testing results more carefully:
- The queue_lock patch (PATCH 1/2) alone restores performance to 640 MB/s
- The cpuhp_lock conversion (PATCH 2/2) doesn't contribute to fixing the
  I/O regression

The cpuhp_lock is used in:
- blk_mq_remove_cpuhp() - queue cleanup
- blk_mq_add_hw_queues_cpuhp() - queue setup
- blk_mq_remove_hw_queues_cpuhp() - queue cleanup

These are indeed slow path operations with no contention in the I/O hot
path.

I'll drop the second patch (cpuhp_lock conversion) and send v2 with only
the queue_lock fix, which addresses the actual bottleneck: removing the
sleeping lock from blk_mq_run_hw_queue() that was causing IRQ threads to
serialize and enter D-state during I/O completion.

Best regards,
Ionut
