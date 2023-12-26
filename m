Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00664F89F
	for <linux-block@vger.kernel.org>; Tue, 26 Dec 2023 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Q7Ec9gN5"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7baf436cdf7so4420039f.0
        for <linux-block@vger.kernel.org>; Tue, 26 Dec 2023 08:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703608129; x=1704212929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2gV8/cpPy2T5tIPvkQnnjmxZIQ9RGgRvZoWZsYkLO4=;
        b=Q7Ec9gN5Lx1aenuJSSKq5zCnn0roYS/ZBrh9Qp+v73+jSzD0bY8IVbD3qmxgVEknvP
         XpVM1lJeuyV4yKXUSiha1QJjnpqMr+LsyVGGvsgVvjH5cYU8NfAg0itmNldiyPuJyyZn
         9/ED3y189ZdqfgwE5XnjFuSbUJrTCE5eBCcx5SSEn9ogfNxw3JNUeaUInwH6qX2Bdsul
         gr5zB7amfJICbMgjaA31SZdPOir/pbY0XN9lKnTzdNC+lHMwx60DEK9hnl7+Thc4b6Q9
         cReVB1ERImupmvQAmBIn65ucCL5GXuS2Xqdq/95SbfZwdG5NXdRqP0nTqzZCrpbDRW77
         kRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703608129; x=1704212929;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2gV8/cpPy2T5tIPvkQnnjmxZIQ9RGgRvZoWZsYkLO4=;
        b=jhSJdD6jU5Xrxzy9WXyBp1ZFi15I2oimtKzri7QsSSr7Ds5k9ksdBioAmcIh6zY6xT
         w4AH0GwlPQy77eKdZay+cu2IaZv8TfdfFV28DE6G+7ev/qYtGqmL0IPJynqot/2H7coI
         RnyMN1V7Xj8DLPVjaDQo6sTC00jUk4Uy0enBeOInorlr0CdAyplAPJ43eKgNr7uJVVLC
         +8FLrpfpCsUCmovUiuktAkVHxRydhNP+Rv6ZkAzu3YEVhOA+ufhBxUawwnq0k747zafE
         owc8c3RE7wMamio35GSESN9p3E/6KFniAJGIZjlHp9UDUJc8uNdAm+VXNq5EcPstIq97
         NpFA==
X-Gm-Message-State: AOJu0Yw4AKFY7bXWx7WQ+msEl1BYWGQ75yg0BE3TH4IHNT27HYtVSVkh
	PpbbCxI8lQCdTv0l7s9ebJw/zJOcHFyyDwKHwo1yFLJoDR6jaA==
X-Google-Smtp-Source: AGHT+IGnZOPQd96/25whfypNRQeQKddn0WJRLE9uQdAgjZvVt8+q0cR/zuqGvQ1Y+xmUhMz/M3pdZA==
X-Received: by 2002:a6b:3e46:0:b0:7ba:90e2:2b1 with SMTP id l67-20020a6b3e46000000b007ba90e202b1mr10878422ioa.0.1703608129440;
        Tue, 26 Dec 2023 08:28:49 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id i17-20020a02b691000000b0046d18e358b3sm1607879jam.63.2023.12.26.08.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 08:28:48 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20231226081524.180289-1-hch@lst.de>
References: <20231226081524.180289-1-hch@lst.de>
Subject: Re: [PATCH] block: renumber QUEUE_FLAG_HW_WC
Message-Id: <170360812853.1227834.7306705322769980126.b4-ty@kernel.dk>
Date: Tue, 26 Dec 2023 09:28:48 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1


On Tue, 26 Dec 2023 08:15:24 +0000, Christoph Hellwig wrote:
> For the QUEUE_FLAG_HW_WC to actually work, it needs to have a separate
> number from QUEUE_FLAG_FUA, doh.
> 
> 

Applied, thanks!

[1/1] block: renumber QUEUE_FLAG_HW_WC
      (no commit info)

Best regards,
-- 
Jens Axboe



