Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169D41C6FE8
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471814; cv=none; b=pCWnArsXhP79plWTmjNju9HSMECQlKXcLhIJ7u9xMBoeNKOIPZEM1hC10Owx5nVwwMLhSJjuTqspYNwab1uNE5KU3sho1aTCxxU6REEunQP49r//yxUXs9f3WkElL0kLDDa4HSdAW8Qbl2qGNgsV1aLZ41cQSGzjPidQ174BKK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471814; c=relaxed/simple;
	bh=7sP9JRn/UDyFaH9N5MSFB17+Bj8xtMARWOWMifHGasc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y2ZvcKuyBtMA56stKrHoSLGA1CYGFasPM8Ci7TveidEmXMXqOLkNmijK57v4mSrYDjtcfTc1Ic/JXtN8EBEBJ6PvYUEDQ93ATUX+nMl5mjiogMdHHo6rJHom7wtyNWZlpn3kQrG3N/G0NPexeBDbCtJ68AePqyPHNd61knIc7K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=atOYOHK1; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="atOYOHK1"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-88040cfadbfso1217466d6.0
        for <linux-block@vger.kernel.org>; Thu, 06 Nov 2025 15:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762471812; x=1763076612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqSPWGiycvFbLPjchihb1T2SvIrY502knNF2q5NwttU=;
        b=atOYOHK1Zt+t/rSFEEbupy4StowH0zes9B6KPi6G3KC1Kw4VUP0Krc+RngQG5YVYQZ
         RkySCrSF5vXiVw4iGd7pnzSyYYdL0Q3Wn7OtmZLp4qTQkt+u3GyCgcGwAKN88RveNYYZ
         ch9HSNSHmEQcvqHGXEqNkCpaCLPSqOSdgvw1bdtV36s2pXFTqBv9O+E8ZHuJ0CNvMP2e
         ykqB+FXXkmECImMuG2FFMWeVaoQ3We/Gl1n46v4A45xTDv6FKwIM50oniuGs/6RX3lZy
         S5aTemSUqQAHfFXjK+znuFCRf71FSv+UJ9hhsM4ZEZQaJozcEO13tZeGncScmnS9+ZRl
         26lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762471812; x=1763076612;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MqSPWGiycvFbLPjchihb1T2SvIrY502knNF2q5NwttU=;
        b=Hs9lHqps9V4hLcQUng43sriJAGXhZ+q/MmY0UeDtQDS+wZHWQzRu/Amp+2qWLFpCWq
         Ozv9PIHMx7t2eCThInpU5X0E1tOyW59n60VTaZJ92US4cKH3u3uNotTzEw/vBKU+TIrt
         lQrffCqFYiLkrMYj2yI/pZmpyaLwb+sB8F17V6vjxzI/3gzM45UwtmwZcMVBzQGU/Sf3
         6gsoI9g/5N9pW8hk5ZJSIgpvZBdf2nTqke/Y/uoH1p/5qnujnx8N8RXOs2B26ojrxqCw
         8VH1Srl5UvzkwwgRiGRpwaHnaXOO2WIrPEh7nu9gXn+S9Dfo5PTeEP/cCVhowpDoyF61
         6lTg==
X-Gm-Message-State: AOJu0YzNnjbnNSZ+dYY2sBkK9KNIG3dhSOsLeNGcNaYM8LYzt12/5EEE
	x9YJ8pKpmJjUnLQ38bhoTFLjuMcJsFKhE0AfjU12K6bbP+UMCEZ/BcbymvoOvNB6quBAr6c0VeW
	wiUIA
X-Gm-Gg: ASbGncucSFuiXtcGf38yYfh8pQJEANsXHld9xLG3u9UdDDYF7wyHGmCC0kC/jwuv2iB
	KhrY2m5f1NL8ettvRCxKxcjq+E0GLHK+vfXOtpM4u2nFnfD9NCNLJGnzC4X2lOL+v46Yr9USY6C
	DimijX7BPOprpwG58YdBaYIrZNznrWRIvSQ6MH9maejiJVHH33aQwLXNElZs9A9GgdQ1yTlS07A
	SJJSif5ci0Le3dHZmGEO19rArA+7V9GfjtHbN7dHXfxh2jpnPLCmhy6XukadiGlgd16pwNBSf9T
	9DuzKZKNcyQBvKpL2N/k/2QTIBXwwetWCHf6uGhviXWDDqWkvcDrv1nSOUBz4qhl9DKZaPhj222
	iSRNQ3w+E2fspsYUrul9b0qFzY/BL7WLAyLfrZ2ZYdaKuMOWeCKzgJsj22bMh+nnFiVlXtzw=
X-Google-Smtp-Source: AGHT+IGDmBlkb9ElT4lc2YxQEJ4N5SdFXffADKJ69IM6oZ7HbmZNu+yoOhdj/jeCzkya+TTr6qi/4Q==
X-Received: by 2002:a05:6214:19e7:b0:775:6a7c:dbd5 with SMTP id 6a1803df08f44-8815d22a969mr20183576d6.33.1762471811920;
        Thu, 06 Nov 2025 15:30:11 -0800 (PST)
Received: from [127.0.0.1] ([216.235.231.34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88082a37f10sm27786316d6.54.2025.11.06.15.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 15:30:10 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251106171647.2590074-1-csander@purestorage.com>
References: <20251106171647.2590074-1-csander@purestorage.com>
Subject: Re: [PATCH v3 0/2] ublk: simplify user copy
Message-Id: <176247181033.292880.16085659049514901290.b4-ty@kernel.dk>
Date: Thu, 06 Nov 2025 16:30:10 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 06 Nov 2025 10:16:45 -0700, Caleb Sander Mateos wrote:
> Use copy_page_{to,from}_user() and rq_for_each_segment() to simplify the
> implementation of ublk_copy_user_pages(). Avoiding the page pinning and
> unpinning saves expensive atomic increments and decrements of the page
> reference counts. And copying via user virtual addresses avoids needing
> to split the copy at user page boundaries. Ming reports a 40% throughput
> improvement when issuing I/O to the selftests null ublk server with
> zero-copy disabled.
> 
> [...]

Applied, thanks!

[1/2] ublk: use copy_{to,from}_iter() for user copy
      commit: 2299ceec364eecdc0a5b4ec80c757551d130389c
[2/2] ublk: use rq_for_each_segment() for user copy
      commit: e87d66ab27ac89494b75ddc3fed697b5aa8417f1

Best regards,
-- 
Jens Axboe



