Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFD42E2DF2
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480327; cv=none; b=dxk4wMUST1AInu7mBsyxRgdUA//PRJYO1naXr9PCsqRMQkQla6PZLyU3Hj/PQ/RPkSF3QVZXsgGi9NULpk1a4Gt3kj9x6Jn0uwqleSTJH5FgFENVWQXPSSM4RIwlbVwm0aUhoGeUYuM2viPhaS2QYyy16UqbIwqGhi41kOlw68E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480327; c=relaxed/simple;
	bh=hDOXd0eCTllGjlvphmdoQTkCI4o/v1tiBMI/JQFO+Oc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jQnx8v9o+Aqr7Z9lniJZIZT8RUK/GK+FxN5B5wxwhV2wZUQwCxF9kHdo63E27vDWHejUtAePOaD55QhA3fd6/oZDBpt8FO/4B7xTB5XI6NRdBVYvb+uqv1tA2mW7WIsexnCpm9djKkZBkl6yuyw1/7C/70cyXsB0WYZ6A4hShHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HHqcw1gB; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HHqcw1gB"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-43323851d03so21083845ab.0
        for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 07:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763480324; x=1764085124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mop0BXbeVA7pz+P89+67JHjYtUjDwIbDaVAf0R8oLm4=;
        b=HHqcw1gBBMRx4taAkSTWpBBwyTdVqwTxIuNPM3SZCvmXQNm+QHLFFhFoG6S2YvaQhC
         tpqL1nwyku3/VU2gQHGX3mRtU+zhbxbwTDeyjf9jGRJw66WsL4OmjQgdLuZSTFe2+IEi
         TGZwZXS2d2o/65TUSD69ruBySfEXfulRnaWnoSScu05lk/qAgl7/G7rsFsOnkdOrMxbb
         W2ZAqZSSx9phKCptfna3YQCnco1+AK8BM/5FzEsRkXsrR88TtN2t6T9xOkt8UEdjmYns
         yTTAbC9NLAdn7lCGuLiDVYNZhdNr6IcGYwtA/BmpC3FN0mnpo0x5RX5sKUsGdqxVKPnA
         TW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763480324; x=1764085124;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mop0BXbeVA7pz+P89+67JHjYtUjDwIbDaVAf0R8oLm4=;
        b=iNCNB4gGMy24ZrwHxjDZPy/L4v9m1Itlq0hBrVkmKHby5mgNwVNKX+HWK77xOg9Ddx
         Of5hwEj1mjFwD+8GwSRhrWsJ8PcPZdTVzF5PCfa/HCEKbmjwuz5Lp27BthXuw5NsFGLN
         JMsO1Izy0JFG+Imql2+Hbqri664BRoE6hAIHe68eAkz4ab7L03VxQBYw3HdOhfbJynDv
         ckrjiegPm/UAy0+zhGNvEWNTZl83fXeWEjODkkKroeeDbJIqVF9OTdLPKzCLTOC8ppE+
         349rTQpW4CBhlfqXo6QNOUFNcupCeGwmx+VWXQqFMEgYgfiZ500vyTITqYalqJRNIPj/
         /Q0g==
X-Gm-Message-State: AOJu0Yx8VcPkKVN/OuHq6QMxobhF4fQRqxZp3vyYIHWzJ90k5OGtLtUk
	X7OrBDLX/0pcgjphp71pze3tDCq1xD73q316LNCwrpZtpqp4XSUVvf5jPI+m6Xpz5y0=
X-Gm-Gg: ASbGncuP9CGmnZFAowN2Kv8HExGAPtbdPs7fL2lOGArD7d0mVEdc58X+wCiT+fL7Ofx
	WoTxFrwxoZLQvXRIikdsBTT7B7anilhJoH0VOrmofqE7Z7F6l+7lfoLP6mFYDKud5iYnTGASpZp
	uO+VQS3NCeENQVTBOcdO1+6FkLRr0T9EuvhSK9m9+pZ549WA0O+bLqwsxOIW422ebgdknUFCxgf
	fnaUBHV0UIiU/IJlf/yNqj49WZ+KAi2e8K6RpVgUqNMwNfmFzSJvH/v8uxmjhfgF4b8tPtolybd
	mmqdQaZUHZNjvo7m8Bq2JcUrIKhUkO3SZP3PQXXUkB1ayQ+mSwEV7rGE/Z4e7pCKcjMMqBorIDS
	M4AOOgLlwPyZsWse1/VoNvyeUKCdgSkQvxwW6KDliHZyU+wbMz30YKRbJlr3HZrKBKTnsDwYNi8
	SEMnLjZuFfdPmEBg==
X-Google-Smtp-Source: AGHT+IG8+S4XnZehtbJh2wZVxg2hQEO6XU1apy+1d/G7wa7Jeq7lGc5uai8Q9QxowXUoeU7qPJOUrA==
X-Received: by 2002:a05:6e02:1845:b0:434:70bd:8b47 with SMTP id e9e14a558f8ab-4348c8be2acmr204639365ab.11.1763480324489;
        Tue, 18 Nov 2025 07:38:44 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-434833e94f1sm83498515ab.10.2025.11.18.07.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 07:38:43 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>, 
 Zhaoyang Huang <zhaoyang.huang@unisoc.com>, 
 Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org, 
 Christoph Hellwig <hch@lst.de>
In-Reply-To: <20251015110735.1361261-1-ming.lei@redhat.com>
References: <20251015110735.1361261-1-ming.lei@redhat.com>
Subject: Re: [PATCH V5 0/6] loop: improve loop aio perf by IOCB_NOWAIT
Message-Id: <176348032339.300553.10948808566145680135.b4-ty@kernel.dk>
Date: Tue, 18 Nov 2025 08:38:43 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 15 Oct 2025 19:07:25 +0800, Ming Lei wrote:
> This patchset improves loop aio perf by using IOCB_NOWAIT for avoiding to queue aio
> command to workqueue context, meantime refactor lo_rw_aio() a bit.
> 
> In my test VM, loop disk perf becomes very close to perf of the backing block
> device(nvme/mq virtio-scsi).
> 
> And Mikulas verified that this way can improve 12jobs sequential readwrite io by
> ~5X, and basically solve the reported problem together with loop MQ change.
> 
> [...]

Applied, thanks!

[1/6] loop: add helper lo_cmd_nr_bvec()
      commit: c3e6c11147f6f05c15e9c2d74f5d234a6661013c
[2/6] loop: add helper lo_rw_aio_prep()
      commit: fd858d1ca9694c88703a8a936d5c7596c86ada74
[3/6] loop: add lo_submit_rw_aio()
      commit: c66e9708f92760147a1ea7f66c7b60ec801f85e3
[4/6] loop: move command blkcg/memcg initialization into loop_queue_work
      commit: f4788ae9d7bc01735cb6ada333b038c2e3fff260
[5/6] loop: try to handle loop aio command via NOWAIT IO first
      commit: 0ba93a906dda7ede9e7669adefe005ee18f3ff42
[6/6] loop: add hint for handling aio via IOCB_NOWAIT
      commit: 837ed303964673cf0c7e6a4624cd68d8cf254827

Best regards,
-- 
Jens Axboe



