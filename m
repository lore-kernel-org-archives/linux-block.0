Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E485031715D
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892684; cv=none; b=sjtgZhZJMaLRAgjjdGGJIzyVh7jtQ+9kZ+u+2yQ8KgGssMUpco5eb6J6dxIzuF3wboMHHQfngkb3KmGwSsH7LPfb0WNQI6OsHVbwu5MfAo4jLi3jSu66DcmJ4ad74nA0VRREcC++NXWjDAtw5zE8e8oYz+LrmtmnrJw352fsUt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892684; c=relaxed/simple;
	bh=vLnIWUnT7L6c+HLKibZGqAb1vjAvLoI/vnRdb+HoAdM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nAWT4vez2onZoT4TMPKXSFbTrueeuvHBsdL0FaNskasN/x7WyoFdWU9qI6tA9/O0N6zn4gBxYjsvaRlIoHkJs17nVexp3ZhnoLtJQZo5gKz73m1/idCdu+nDirguRuBTC7dkOIiualc90h0KTk6BmMnAjhk0+mEq+A6tZFSbdAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=rhruCnxJ; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="rhruCnxJ"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-479ef2b78f3so10511076b6e.2
        for <linux-block@vger.kernel.org>; Wed, 27 May 2026 07:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779892682; x=1780497482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/ujAwvlEauNK8MqRmCBOkRamDg/525sCRmIkKVYiQo=;
        b=rhruCnxJ4saMk3c6lgLfJCIZ1yh7LMUPis6zFWy8eAB3P/iqKeePj3gZ5lfXzeNjy6
         m7N721nFPYurjFyhLeDfifKJu/6+cvhhffoyp8aJ7mDuuKicDMJsFd2FKzkG2sv2L5+T
         5r5mUZczVv5Vkw9ve35r0NHISZfMnC0WDVI/qhX/5ZmqXXTj/jHaaFXGWa34V9urLU+o
         3+DuMdCrB82bPGpKs2AorD2Vph1x3BVpnwSGqAIsj9xl20vVmiYElp3Xob0jNS745Dfb
         CtK5+UYJLQLWxVShVS0gUdSLPafy1iBLt76RI7BO/8wRrmGS4SIMyJlEcwmj7S6AfiKc
         snTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779892682; x=1780497482;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h/ujAwvlEauNK8MqRmCBOkRamDg/525sCRmIkKVYiQo=;
        b=oB8pYosqNWOkGUhBew5BhxFTZPO8YBJtehOLfQIaPmyw6lQCFiZqEtwaiplwjq5NsM
         y/zISs0rriBvTvt8pFg6W0hNHrnAblIn0uWidXGK6hUnKxyLXmuMx6wX+hm6edS950OJ
         nRWaThPyVGxOSWqA/0pQhFaJ2xyukf7K1niu7oNs0nvzLQtY9w3h3kAEWc/d4vqbwSc8
         jrOyibNPGjNzuFR8TxL0WO3vFux5MfXKZNAadxrde1/AZx2EdeRmxDlO67F+PbMbQkKw
         GrOzuXjy3MBUXd7tPl0MEiNoD28m0IqMNq9CuGMc8XhUDLdPqQ5kzOyBldlzgGylPh/M
         AqSA==
X-Forwarded-Encrypted: i=1; AFNElJ8w3pYB/Ig1Y2gDQ20j81FwBEz9a7wvJZLvs5Oazj6Uc/7cUTYhfmz6DwrpGlvtIZvOyu+IOFqlVJWeNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyG1jqALeZ+VaFMSqJ8KQWcCd6cLcD0HotxaDPgpDmylhw/18yW
	o+xNReB8CVm+t4J67sGY7BNDOyq9Kv6sNJJl2H4k5R/33CTr9S0aIXVlVZxDFir6MXE=
X-Gm-Gg: Acq92OF04Wv/9q3i/CKAkfHnye20Zyi5yfvztY93ygkvzYNcCb9frVgBbN88+aquVzT
	o7xYu5UBf2xW4FuWZZcfuUyxrV2tKfGknjy1p9ZdfzRheBUXM3rOfH9MwL2LCa8IC+sOUOKKf82
	XLn8yQbRucMm1k0hKW3DE/GxXolm2j9Ho0Ox5lyMXkSp5mfuhnUQYHJPGeJH6xuAk6HN+HAeUXZ
	Y4zyyUR6EPWuIFRcgJfuI6I5J9DR8K28H1PgYZfSYHsTkPasJHXhTKWpUPJGoZ0y8534T7QPsiL
	0T99uxW0MYOCkF6mXYE38XVmstm3SHH3UIQthdtOClLlPWytCP4/APlik3dsoZ2A0dtMTdMgMSU
	IyNTVkMfqie8+ZgKLK4ThPHiUQ3ne+H0KgXv/du3n2qnqkYaEoJdbv6eX3SKZ/IUd9Ntejj/gd8
	Hn6cFH8mRySI9qFiVN79Ohah2IJA1R/I264E1N8DkFYTgfQh52tYmhAkMyazVuqRCzJlgOzhepx
	cg=
X-Received: by 2002:a05:6808:c2d9:b0:479:f370:fac0 with SMTP id 5614622812f47-48549ec2492mr14461494b6e.18.1779892681940;
        Wed, 27 May 2026 07:38:01 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b6351a772sm16950878fac.3.2026.05.27.07.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:38:00 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Boqun Feng <boqun@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>
Cc: Mateusz Nowicki <mateusz.nowicki@posteo.net>, 
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260527-block-for-next-2026-05-26-2200-failure-v1-1-4865889e282c@kernel.org>
References: <20260527-block-for-next-2026-05-26-2200-failure-v1-1-4865889e282c@kernel.org>
Subject: Re: [PATCH] rust: block: mq: align init_request numa_node arg with
 C signature
Message-Id: <177989267992.742656.1381719020976456974.b4-ty@b4>
Date: Wed, 27 May 2026 08:37:59 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 27 May 2026 11:18:09 +0200, Andreas Hindborg wrote:
> Commit b040a1a4523d ("block: switch numa_node to int in
> blk_mq_hw_ctx and init_request") changed the type of the
> `numa_node` argument of `blk_mq_ops::init_request` from
> `unsigned int` to `int`. Update the Rust callback signature to
> match, so that the function item can be coerced to the C fn
> pointer type stored in `blk_mq_ops`.
> 
> [...]

Applied, thanks!

[1/1] rust: block: mq: align init_request numa_node arg with C signature
      commit: 6b2f3e4970e48e70c10111366f59f908f2ea6f96

Best regards,
-- 
Jens Axboe



