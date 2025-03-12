Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A974645
	for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789631; cv=none; b=AEksvvvmw6dRfxTY/KLz/RlhAygo92Tk12lv7FiV3W4GTgMs1Nf/WPq7u56dDFVmSIzIUeCRnI6JVm/IjkEQkLhi+qVj3kgXMdaR4RPtwPGMvFVAxl5KajGgxbiKvxN0FCuHDHY/9T7d/+o+orXk7m/YNn5PcfjzsI7tXX6RL2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789631; c=relaxed/simple;
	bh=UBxjjewEfqW7bgsY5pLmVJwDI/I5b1vpzN/Tb6m2NY0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jKRTHVUq/vw/96NbcMI7OxmskhpKd3eCNffBqI4GbCVQ3JZyWNZr9iXOrEqeXR7VQ9fz4fNgiHSS8A915kfqFWsP4HuHpE6mCQPRYUO3K0of1p2Ip4jrR32+Q6b2itSU7dVpGMZDXQb+Dw2Kior/RAYn1or76MBqM0CPbof2egc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=s/5AZ9wm; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="s/5AZ9wm"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d03ac846a7so21570345ab.2
        for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 07:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741789628; x=1742394428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nM8y5yMTrKKaGiqQToVe7ZOOp/tPnNhmC6g36Zt2NE=;
        b=s/5AZ9wmdwp/ZXT69+RcZnh/PjMrPyFrZAjO0peCqeTc8YNiEyI/KfyISiuvVx1rDf
         cse1vzAjxoO+NaeDUCnr2cKTx7p9VlxMHXJawQUFqZP1Y18LEaeB8LITbWvyxegK3Vgs
         NyiTwT8qVguxadkLy3hZm5VqllniF5oiMV8RS2aoAQ4zm82sNI7LigewCQHgdOV/rREk
         pUoU9xLW7srrwd4YIkqfLctK7GDl6sZbMK05TyTEWWF7Gv2R5bCo2JKCJceGSWM9fUl6
         NVEzRqbNjKmlVTEdCk2I3dzIemO9womHZwbA89HihCXW8GREuXqpClP5u0G3uJ1zXdpx
         URNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741789628; x=1742394428;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nM8y5yMTrKKaGiqQToVe7ZOOp/tPnNhmC6g36Zt2NE=;
        b=ZX+l6rAv2K3ZH5AfRGHB5NJ66yY+YQipxsPNKFzUAbVcyfuKlOe2WKOE4ptahjozsd
         8/bF7CFyyWWNg6WVDuDGGdcZODMPaR1XZ2z3s8FrFklYLHIeNlD2br3OmjiizLpVzSfZ
         g6+Y5JYbFXM/bkUNGACm5HVIYoTF0Kk8nM33GMfMQXM2al1TMqQhxATboEiqLI0LtISh
         Ro+OPu1TxSD8bmS/+2g5V5B+P/ucOIc0yLnLkfw8ZaUUfor+UKRD/rzj/ejcC5RttOPt
         Op8FvwfvPASfbPYTn9DtANvYW6Df/Q5JZQdmOpmG3PgG+Xjdg5ZXIoB70Jhj+eWwLqo7
         CFTA==
X-Gm-Message-State: AOJu0YxvyCgR3pGf83ozLUXll2Wz+9uDUT0QwZdrXkAyduz44lUqrphk
	C+cfukiB0+K0TtgfTYS/2T36H7Ft4BcR/6ZHHL3bXnxabXSQUCz+pZOWHTdRNYjXIClf0N98bEG
	7
X-Gm-Gg: ASbGncuLZCs18QbXe53k1KJSTpN8h2gYJUFcGAygYkpRXiI09nvcz1kMv92MIuZy+HK
	kc90oaHB3uShu73/Vl6mxdS03aGynRP1uTBghIvzTboFYD5mYdpl/kEdeuSk9n/M11JaZz/1qgk
	bX0xMVQ9vEF72VDTbUblLsuIIKzeHvVE+fot/qig7xmxpLdwihsPJ0Vwh8Xyy1rlPwFmdWl7qHJ
	srYxJN/Wopi8hciAyyzrwaHO82FJCh6z+H+LVBQq8dgOwhCYGvy3EoA9JPSeTBAcoYDJMZoxfAz
	ItcozhJrjrFvjRyCQu0GscXfjlpJU94Wx8+h6OnwHSDkqA==
X-Google-Smtp-Source: AGHT+IFjZxOaxOQMpHju/ujIiv0xL0DG5hI2T2oJVYSh3a8Oo/W3Zko6Mugub4K2M7oJAFLiesDwhA==
X-Received: by 2002:a05:6e02:1a84:b0:3d3:db70:b585 with SMTP id e9e14a558f8ab-3d4419baaf6mr247212435ab.21.1741789627705;
        Wed, 12 Mar 2025 07:27:07 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f23db8f8d0sm1335734173.45.2025.03.12.07.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 07:27:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20250312084722.129680-1-kanie@linux.alibaba.com>
References: <20250312084722.129680-1-kanie@linux.alibaba.com>
Subject: Re: [PATCH] block: remove unused parameter
Message-Id: <174178962656.513960.8514899109835328005.b4-ty@kernel.dk>
Date: Wed, 12 Mar 2025 08:27:06 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 12 Mar 2025 16:47:22 +0800, Guixin Liu wrote:
> The blk_mq_map_queue()'s request_queue param is not used anymore,
> remove it, same with blk_get_flush_queue().
> 
> 

Applied, thanks!

[1/1] block: remove unused parameter
      (no commit info)

Best regards,
-- 
Jens Axboe



