Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CFA1DE2A5
	for <linux-block@vger.kernel.org>; Wed,  3 Sep 2025 01:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756862504; cv=none; b=KQF9NeDX3eZfaaAXqfVy8IuuKzAJFEg3qbUCRHZXCKAutOi1kAjp3Zm9A5QJGlFkxz/NqW68ZSyZ1H59l4wX5fDRiUTNxYXYJZCinFRYsKXsnqHcbuwSFshJS10VThv8tgYe4bKx5kLU53BIFbADDLxwRyHWDFMMAokohGmovL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756862504; c=relaxed/simple;
	bh=rQLNif5sl2BzEcHPDWCigKu+HqJuv/2O9dOuEdyKUT8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f7Lwq3SMHMnwLlxR5EIWdz2nb4sb0KOX0YmYLCVxfL6Q4V9ae9T1QJdsbGsNWKlPLlh/uLXxHrYssUdV1LiqdSWg0Lf4jI4LlXUSrPlYz2VwRQ8KR8zaHbu2s9reK9pYR0wHIAduZXwmqPu6dWszVpFbXCXkjX2WRHwlhrbueVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Jj6Go02x; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Jj6Go02x"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3f3b00f738cso42362975ab.1
        for <linux-block@vger.kernel.org>; Tue, 02 Sep 2025 18:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756862501; x=1757467301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjAS8byAOwIr5PFgfyLQACeUTVvKtTs0AAlpz2j48FA=;
        b=Jj6Go02xAmdqzq0pwi594P5+bM56Rr6+acOEEvq0HOXojH6h+KqqskiDxs0pn5n/gP
         1mg5obPTpR6drBtfJccI6CqYMUEzd2MnwB/u0/Psd0Zqvjm/hgzZB+ez4yfhAWK1J4xv
         Tl3QnZiswRfk/DJmwgcju9riNSE1zI4vPKMAHfZnuudFm56pXGD4Y6/iEOhB42DYMscP
         F7thwrZkPGXTKf4n506F6sGxYQuWzRqqQnKTZjWBkLEbpfMhOuE5NtaSHN6Iv3yYQbL6
         AOIwRN5dFwSatfJGdVe8Dsdcp6xM5dY4PyKon26MGt9XwfeqoRrwpRHGgK4fJgoee7MC
         Y22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756862501; x=1757467301;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjAS8byAOwIr5PFgfyLQACeUTVvKtTs0AAlpz2j48FA=;
        b=BNgUCFxbeDfdj6ElBnz9n7QV7kUqt6/o1JKJSrYSgiu/l0yw/DEYEfckSvqX4CmlBd
         JSx3cOHCidtSkxT2RCnCz9w6COAscdxFGLVN0vmlN8LJ3pd5Xpao0Ctc1XpZJD6yXSw1
         kcdWqd+I5+roBgq74u9P0b+SGzOgEXfCrjX6zgscZg++Wd3BN+TJagDHr933yhbEe23r
         Vj0JDU144ornYn7NP5kQ3X5chwMKpa1DAaJl9Dm3MWc37kdlu0r1HkUbdqwjorKKKjgs
         0mW4c6Sv6cohc6nbFq0EtPYWW4NHjK8VLN0FB4b1qT5rMgq1r7tfa6ZAhOZeMuIvjpga
         WkWQ==
X-Gm-Message-State: AOJu0YzY1GjYc8qskfdEJRuidA4f3R5GEhuTXWPrnwrDOZBVTCAhDOPn
	OfVkp++GBNyRGKuc3RTznoOtgFAl0fnE1AXtcaw4hMB4VtXbEhPWUetas31vCim7Nu8=
X-Gm-Gg: ASbGncuHYL2GuP3o/ywAZueqY6GNjrdNLWMmbzWcBx/tOpQbj7VNmbP9nVRQj/BG8M/
	iWh86scgDInALTgBzajybmnlboITaw0lZhajfclUwiLWcetBNKiKy6lPfnkNMcYMpVlM9J0ZhPJ
	P8dZ35nj1iLstRr4A7HF4W3tV2GDQXGZCwtodXgHwb2acwLQBx471twrcTvj0SMkRyEIl4wI1jF
	Ba0lQcp/cI9SqSYSE7y2IkxrXii1+1sLrDvOc2Yplo4UhC0u7EIfttUZoNEBs2H1YGsZKCpDpRZ
	N9WsjU09hEAtX4tjaV6pgHjWeEZr94uBM8HEzU2v2VD5fWXOO+rnXG2/Fy00vZ6zgu1j1t6GqRn
	H3nv1hN6sZtsYIaRPF9jwvdX9Z0RgX87KNUr2JtXw5GcNPKxyACsWyHXTqIC7n/xc
X-Google-Smtp-Source: AGHT+IHP5bpnitaSPsC737EVCCHHb9hXsYOc52M1nYnXz7j2gVymoM6d5QMfMkdWCV0dXunxYJ6FkQ==
X-Received: by 2002:a05:6e02:17c9:b0:3f0:dce:2550 with SMTP id e9e14a558f8ab-3f401be27a3mr210428985ab.19.1756862501398;
        Tue, 02 Sep 2025 18:21:41 -0700 (PDT)
Received: from [127.0.0.1] (syn-047-044-098-030.biz.spectrum.com. [47.44.98.30])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f31cc0dsm3662537173.38.2025.09.02.18.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 18:21:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250902130930.68317-1-rongqianfeng@vivo.com>
References: <20250902130930.68317-1-rongqianfeng@vivo.com>
Subject: Re: [PATCH] block: use int type to store negative value
Message-Id: <175686250047.108754.9991172148469474347.b4-ty@kernel.dk>
Date: Tue, 02 Sep 2025 19:21:40 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 02 Sep 2025 21:09:30 +0800, Qianfeng Rong wrote:
> Change the 'ret' variable in blk_stack_limits() from unsigned int to int,
> as it needs to store negative value -1.
> 
> Storing the negative error codes in unsigned type, or performing equality
> comparisons (e.g., ret == -1), doesn't cause an issue at runtime [1] but
> can be confusing.  Additionally, assigning negative error codes to unsigned
> type may trigger a GCC warning when the -Wsign-conversion flag is enabled.
> 
> [...]

Applied, thanks!

[1/1] block: use int type to store negative value
      commit: b0b4518c992eb5f316c6e40ff186cbb7a5009518

Best regards,
-- 
Jens Axboe



