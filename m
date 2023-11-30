Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="azGIg95T"
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1CA10DE
	for <linux-block@vger.kernel.org>; Thu, 30 Nov 2023 15:09:27 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cdd2aeaa24so267851b3a.1
        for <linux-block@vger.kernel.org>; Thu, 30 Nov 2023 15:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701385766; x=1701990566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmpnCqUtuoxHHvkEl3B5MTEZYjPTnTR+G4KhZG9sw9Q=;
        b=azGIg95T8DT5YlRh40XmtRd4RMEQHF1NlqeK5L6qqqKxZ/V49sS/8wZFnuJuBGygRw
         xSe9RvnI787ksQ8455sJPxTqb2zACV55jAYcDgo8OsgYAu852AA9pCqpzX9Xg44+GK6a
         /++Bi4zyGWyf0sjnUqq3/g6luTya2FP0Hnczm1Kci4YVZXED3YRhjyqH6nk4QMkrxM6M
         qjg6kgfHJcab3iYu0cQUCbst7bF6b/mDC31VAAj8HLXHyxBz4NrVH23AHFPnOYWVFsmE
         llJRFPVPaF6muX/vU+hhiMNnzbBnV+Wkg8D1dlF3ZHaxClMIhsF5FtAr7KMTHAFz2NtH
         J4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701385766; x=1701990566;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmpnCqUtuoxHHvkEl3B5MTEZYjPTnTR+G4KhZG9sw9Q=;
        b=uE3lY4lpR+zkIxURZpuV4S5oce9JB9f6f1Mk6aZRwbTonHz9kJE5SXq/yax2ERXmYd
         vZuakmhqZsd4ERQDemZQpbWsn01S5L6mdv6Mq3ZvH6RMEXL7Wa+Qk0G5kzJ3XlWY+RVX
         g1OwnFzj0bSzJV4N3Qi//OeIk+EkoqLKmEFTss1wTLvkXLg6Blc1JmHy5kMAiPub39pc
         XRBWpNj+jxnCjSld0iHa2DEx+H0qBCu/j4nb8lSzYMIbzNNIPn0d0QfhNnwGsM45aZvD
         uI5o5eqIEViDtDa8rtINzs9AXTR7FTjYQ1H0pZo4PE5T944/BNcqbJAWeNRz4rLBN/bV
         F04A==
X-Gm-Message-State: AOJu0YzmjVI4xKUZXrYuR//qlLe3h/gxA2PiTIiYmpuBwQoE7GXgK1V8
	P0/LOBbfTmOu7bzaY37Ea5NB70uNbmmTrz4sb5Z7Cg==
X-Google-Smtp-Source: AGHT+IFKPPF8r3m5BMDX5DFNv0M2Ii6euwt49/3tWDuQf1TJfXsX7mSig2AEFjsW0Ceh/6TAPaPTMA==
X-Received: by 2002:a05:6a20:8f05:b0:18c:6148:6a7b with SMTP id b5-20020a056a208f0500b0018c61486a7bmr20428611pzk.0.1701385766268;
        Thu, 30 Nov 2023 15:09:26 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a000300b002850eb8b6dcsm2010297pja.44.2023.11.30.15.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 15:09:25 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 io-uring@vger.kernel.org, Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, joshi.k@samsung.com, martin.petersen@oracle.com, 
 ming.lei@redhat.com, Keith Busch <kbusch@kernel.org>
In-Reply-To: <20231130215309.2923568-1-kbusch@meta.com>
References: <20231130215309.2923568-1-kbusch@meta.com>
Subject: Re: [PATCHv5 0/4] block integrity: directly map user space
 addresses
Message-Id: <170138576512.699292.6762410631511683338.b4-ty@kernel.dk>
Date: Thu, 30 Nov 2023 16:09:25 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1


On Thu, 30 Nov 2023 13:53:05 -0800, Keith Busch wrote:
> Handling passthrough metadata ("integrity") today introduces overhead
> and complications that we can avoid if we just map user space addresses
> directly. This patch series implements that, falling back to a kernel
> bounce buffer if necessary.
> 
> v4->v5:
> 
> [...]

Applied, thanks!

[1/4] block: bio-integrity: directly map user buffers
      commit: 5a0584b2c714a219296d97d9f4307ffe53c18937
[2/4] nvme: use bio_integrity_map_user
      commit: aec0ff70f016fdf7b4ba52e34d682a185dd8dd74
[3/4] iouring: remove IORING_URING_CMD_POLLED
      commit: f8243a30dc179ac197bd8315bdf9d55d3d7792c3
[4/4] io_uring: remove uring_cmd cookie
      commit: fb62c0c9b04265539851734ae35cf3f10651a8dd

Best regards,
-- 
Jens Axboe



