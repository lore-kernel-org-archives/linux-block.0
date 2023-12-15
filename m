Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BFC358B0
	for <linux-block@vger.kernel.org>; Fri, 15 Dec 2023 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xBetXADN"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7b7117ca63eso9406939f.1
        for <linux-block@vger.kernel.org>; Fri, 15 Dec 2023 06:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702650923; x=1703255723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WBKTN7M6SrEHPbD/br4onX9utwhUTCegr9U3qroprRo=;
        b=xBetXADNtRtL65HxN9aEGkpGMuW5R3vXwQYlVMZht2rneDUTcWNiqJJQaoN9wuWqvh
         bLxi1XK0fDHWJ87+ukOiE59XyplHTvNhPGed1N5VaxmcJVtcJnBLTnkBXC76EH/xRZhZ
         P/rSJiVftnH7FwJci+1Dm9gLX6GBfSMoKQ+6P3pScqUmAPNxJn+ngygNjWvX2dtC8e0U
         T2dP8nFtCm+JG4HyJUjyNHuE5aNZhW8roX6amwuTsse/iELuOMiVLhqdiSeIRbxeCBm6
         1BIuDXl2AmnkbK8Ic+xosqJTMnkr+UvboXqgmgEPa9qqof+C4j7CxNcwWOoh8e5aq1ok
         grZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702650923; x=1703255723;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBKTN7M6SrEHPbD/br4onX9utwhUTCegr9U3qroprRo=;
        b=BLUbHL/61MmCGhGV90hSAazeRPI+mlBv4F6/eHVNh7IfTf33fEH78pbKYqM0N2n2hM
         okshAd6BX2Ftj0R4q/TIdabI4vq0nNwhCOAIAEtCqvGd/P0Y4H8NTUhs0tgmqQMQn1d4
         7LHqS6CL54bEAyu+7gNND4Ca4vaC2H2KTuuIhPhVxwNfKApuve129KXMY9PH/RYST0VN
         H5Ydw8dbNMSSSHko4BTIVhKMz+4ysbQ+1TIdGvwo4jbEyQYO9Cib/c5c6dvHwLsObwZ4
         DcrOICIQweSQ3LeKZr6/NBNgYCmSl6v/MbT1SbHiFLoCz7rdwxl28n2cFkq2WXJh68u/
         ou3A==
X-Gm-Message-State: AOJu0Yy+l9jeHLiJCmU9gqQzond5hwRbKliXBpoFer1uT/O5HIiWWQV2
	OLPMZt3J47eMPSM/DJrasw+Lhe5YdRW6aJ6yBvLMwA==
X-Google-Smtp-Source: AGHT+IF0gQxmTgUnu3o9lfoMz4n948npVqymIdbVkx7PJRZBAjWatfek6oDeXUilFum2mayy6//B9w==
X-Received: by 2002:a6b:e70c:0:b0:7b7:fe4:3dfa with SMTP id b12-20020a6be70c000000b007b70fe43dfamr19698810ioh.2.1702650923006;
        Fri, 15 Dec 2023 06:35:23 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id i12-20020a05663815cc00b00468ecf31973sm4140873jat.67.2023.12.15.06.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 06:35:21 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
In-Reply-To: <d2b7b61c-4868-45c0-9060-4f9c73de9d7e@kernel.dk>
References: <d2b7b61c-4868-45c0-9060-4f9c73de9d7e@kernel.dk>
Subject: Re: [PATCH] block: improve struct request_queue layout
Message-Id: <170265092151.460397.11678955109139047906.b4-ty@kernel.dk>
Date: Fri, 15 Dec 2023 07:35:21 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1


On Thu, 14 Dec 2023 11:08:15 -0700, Jens Axboe wrote:
> It's clearly been a while since someone looked at this, so I gave it a
> quick shot. There are few issues in here:
> 
> - Random bundling of members that are mostly read-only and often written
> - Random holes that need not be there
> 
> This moves the most frequently used bits into cacheline 1 and 2, with
> the 2nd one being more write intensive than the first one, which is
> basically read-only.
> 
> [...]

Applied, thanks!

[1/1] block: improve struct request_queue layout
      commit: 0c734c5ea76e333fbb8dd83b5bab46291b38096b

Best regards,
-- 
Jens Axboe



