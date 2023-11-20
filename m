Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DNKri3ku"
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427ED10E
	for <linux-block@vger.kernel.org>; Mon, 20 Nov 2023 09:26:47 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7a950f1451fso41583639f.1
        for <linux-block@vger.kernel.org>; Mon, 20 Nov 2023 09:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700501206; x=1701106006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tLplbkX4hamk2/U979duLSHoKAJgGQpD3zAJN5ozOdo=;
        b=DNKri3ku+dJECWj90+CHp0VJbN/kKVtrNOv4KIhYeFzFgTvl75i4pKTXXxQ3hrEURn
         URK/Uh42tO9bwuZUdGmVwJEQxJOZK8vALgN7V7q/0RGsAdOYC84xGiKrcHYQppFuV6aw
         2WPXYYF78wFACwjHUq0iA5zwjZ0RaLNppV6Q5sk1qOvtQyVbpGiqct7gKicRpTXaGp0s
         prhp2KEisrb74T1LYgii+P25oYtFw+CJ1n8wRCIJZcgPLqD69k9w0GI2Pi4S1hoI6oFp
         377rFnLhj/nLyuPQ5oX5iu8eItSvq+Vx7QndoYTk0EWQ/l9LE7xOIjrN0DlPlaM4Kcag
         5T3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700501206; x=1701106006;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLplbkX4hamk2/U979duLSHoKAJgGQpD3zAJN5ozOdo=;
        b=BBZflg9Da8Yxe5zpl8KbZzY+QHe0vcyomK7GjM+hze/ILuD+XDHaEcDSfxZBkACZPM
         U6qo7c4NaYby/Fxj6wy5jeMAdt+IiOYmXmrpBe6R2EqvtSh0TIpdr8yYYCTuOXhPciM1
         Ne3UhHTR3cdIC0vGdwnCUUPcpDF9H/xwvqJfnB3ohhkbLl5bCLQopavzl5/y40V8nfkd
         V1y+gHa97NQSqG+2u9wC6sbSZNnXNRXI83q1KhaJOgHQbLz8zsfvFMSK88kIgKZXwhRj
         qU7xQsUgs2JHmxOVN6fysalEpVJak4VPDTxPWTbokx2v4E+9o2A7jk10ZUcAxZxw3sYv
         vP/A==
X-Gm-Message-State: AOJu0YwQ4PkVfxyg4We1ZE6ywnrVsaPUTmi15YufnKIKObA/3xmCyqZ/
	VVizkWXtIm4TWRvpkSEQvjHL05bBoqleh8d/o3EF+w==
X-Google-Smtp-Source: AGHT+IExOduYUJggrgepkZiLBwHdzp7V7CseQW2nIbXnAER9Wp44OHqHvcwUIaCJvCbUKkC5UOgYtg==
X-Received: by 2002:a05:6e02:3893:b0:34f:a4f0:4fc4 with SMTP id cn19-20020a056e02389300b0034fa4f04fc4mr8352180ilb.2.1700501206527;
        Mon, 20 Nov 2023 09:26:46 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id r7-20020a02c847000000b0046455c93317sm143008jao.92.2023.11.20.09.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 09:26:46 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20231120070611.33951-1-dlemoal@kernel.org>
References: <20231120070611.33951-1-dlemoal@kernel.org>
Subject: Re: [PATCH] block: Remove blk_set_runtime_active()
Message-Id: <170050120595.99906.13245631313110981729.b4-ty@kernel.dk>
Date: Mon, 20 Nov 2023 10:26:45 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-26615


On Mon, 20 Nov 2023 16:06:11 +0900, Damien Le Moal wrote:
> The function blk_set_runtime_active() is called only from
> blk_post_runtime_resume(), so there is no need for that function to be
> exported. Open-code this function directly in blk_post_runtime_resume()
> and remove it.
> 
> 

Applied, thanks!

[1/1] block: Remove blk_set_runtime_active()
      commit: c96b8175522a2c52e297ee0a49827a668f95e1e8

Best regards,
-- 
Jens Axboe



