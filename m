Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LMfx12+b"
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF74BE4
	for <linux-block@vger.kernel.org>; Wed, 13 Dec 2023 07:16:10 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7b7684f0fe4so21835139f.1
        for <linux-block@vger.kernel.org>; Wed, 13 Dec 2023 07:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702480570; x=1703085370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uewgFUrXAkDfEjDIhgFTikSg31fgOKfkxWQH0ytJjl4=;
        b=LMfx12+blqVRXs1RTPceZjYGi0Y12pCJsyzNFZ8NbZZZJWx1dTMucYFpF0MXtlGeoX
         akiU7e6KtOhSDiJqHCnK0WZ5WrQK1UF95SbP2Njdoppn/2e9rf6I+7fp81znvDM/ttiY
         7GXxscAumf0ZsN8+8yOoHCA9nYSstxGeNR3h8FVZCVyJ5E8i9Kmb1thEt8HJWWZUqECD
         C+FKTTuS7+HzZrqg/pBjT5dH/npWaLT86zcS+E9cbzDHrNtHnH0+v0y6rEfOtakp5vH+
         SxlEYWT9bQ9Vql9uCFnH6oOa6a5NB1pCJV1/awZGxwpDzoACwvqhBqPMOaxWl1vFccGn
         Q4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702480570; x=1703085370;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uewgFUrXAkDfEjDIhgFTikSg31fgOKfkxWQH0ytJjl4=;
        b=XlG9y3atr/UodQp3rLR4KriUX/Uof/lYvBsRRqm+BLwMtTLZ0Asw5z10244L9+eLQz
         0qsos14UfktrW+0qSAaMhfN6G0K+pgNLJjM1zYtLro3//WDVUH1GwOXDCe2sFwAbo5jI
         lerCpDS7e6T6Ao30bYg4UjtigLfx0pu6hmWoMt8pgRLNQwzmxJtXn621VlbKUL/71Ybm
         F979k1VeNx3OCQXiu3Yeruk3cDV5Hcy4Kt8A/Fen42SEhkEh/7D7KWmWEZ0DTkkkY+Tl
         GXi0wauYNLLdG83pQYyg47c61tjL9YBY8Jb8q1/dMjTY1/YiOv99vc5UoxAg8hELdBhq
         /G2g==
X-Gm-Message-State: AOJu0Ywn+OSWqoYkTBP90oh37RwssBxLMWwhQrHDvrENSRqqhVvP/w1h
	lLgZYQN1C0vPoc4G6LEl69lcbw==
X-Google-Smtp-Source: AGHT+IH/shbRPqxSdrHsCi3YSVAXuMFbwsH0rjMNL+wzVgnAcEDJUAeKpM9jP/po3XTdRFYcCQYGNg==
X-Received: by 2002:a6b:a0d:0:b0:7b6:f0b4:92aa with SMTP id z13-20020a6b0a0d000000b007b6f0b492aamr14346479ioi.0.1702480570069;
        Wed, 13 Dec 2023 07:16:10 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id d7-20020a028587000000b00469297cbf72sm2990832jai.153.2023.12.13.07.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:16:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
 Kees Cook <keescook@chromium.org>
Cc: kernel test robot <lkp@intel.com>, Jack Wang <jinpu.wang@ionos.com>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20231212214738.work.169-kees@kernel.org>
References: <20231212214738.work.169-kees@kernel.org>
Subject: Re: [PATCH] block/rnbd-srv: Check for unlikely string overflow
Message-Id: <170248056905.41187.18405305753131685807.b4-ty@kernel.dk>
Date: Wed, 13 Dec 2023 08:16:09 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1


On Tue, 12 Dec 2023 13:47:42 -0800, Kees Cook wrote:
> Since "dev_search_path" can technically be as large as PATH_MAX,
> there was a risk of truncation when copying it and a second string
> into "full_path" since it was also PATH_MAX sized. The W=1 builds were
> reporting this warning:
> 
> drivers/block/rnbd/rnbd-srv.c: In function 'process_msg_open.isra':
> drivers/block/rnbd/rnbd-srv.c:616:51: warning: '%s' directive output may be truncated writing up to 254 bytes into a region of size between 0 and 4095 [-Wformat-truncation=]
>   616 |                 snprintf(full_path, PATH_MAX, "%s/%s",
>       |                                                   ^~
> In function 'rnbd_srv_get_full_path',
>     inlined from 'process_msg_open.isra' at drivers/block/rnbd/rnbd-srv.c:721:14: drivers/block/rnbd/rnbd-srv.c:616:17: note: 'snprintf' output between 2 and 4351 bytes into a destination of size 4096
>   616 |                 snprintf(full_path, PATH_MAX, "%s/%s",
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   617 |                          dev_search_path, dev_name);
>       |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] block/rnbd-srv: Check for unlikely string overflow
      commit: 9e4bf6a08d1e127bcc4bd72557f2dfafc6bc7f41

Best regards,
-- 
Jens Axboe



