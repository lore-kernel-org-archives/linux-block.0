Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D894D22259F
	for <linux-block@vger.kernel.org>; Thu,  1 Jan 2026 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767283085; cv=none; b=uwIQ8J+W1/t4bFQZ6Wh2aMkbkvd/OBVHwSOI0qmIIHVwau5kiB2CPznK1scMTcLkiXIdOdT1V2j5ot4oAHuUgoqhK4bYrzwcv3pogHOP0L7wF8/klJVedJRB3tCxr1XhPSwFAuy+nH8173yxB5TXckQB5glDXi0hLON/Tr3aIh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767283085; c=relaxed/simple;
	bh=Th3fJ1MQIwKOtdSeQbGdqWL9zs8Sbkw2DIL9tRp36As=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CMFokx5jYgnZg2klEtJiSbM3rhPAqzIY3abLD+Tiuy2EqcxpQlbA/5QhJ+6adS2CVRNFvqMDbYOrK2JB3WZA7kmhU2Xc/2QcJ7CiIQTehq9lA+4K6RSUWGfq4L2IDjFqL7QUWwflbc4SoL8HE/pwDAOxLE4k12r+smVROOZRQCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BTglT2sy; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BTglT2sy"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c6d3676455so5188338a34.2
        for <linux-block@vger.kernel.org>; Thu, 01 Jan 2026 07:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767283082; x=1767887882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWxZMPDfz6VibqcQ4C4tU4AllLssToyo/WIL80GfDDo=;
        b=BTglT2syHlu6wQD6rA0vMgMj98sd6jvZNpgSQZAUydl7KlTA5FCS2yp6T+ViX5qkEv
         a45g3bMfYeZLalCoOgAxlOtvstfjNJ3Y4wFOJIB9LIJpCQXytTtAAWQwigkWOT72t6bt
         f+Aqy4R40O+POiuiU9St0MbGaDwlbkBtm7hfPIGsAmo50F0x1ZFYo4VgCvYbdZpFoYAD
         tYhkV1EKc9arbam+vEFDlcCMFa5kJuMENHz/UlME450Ar74IRVR7veI3JbbPm5jZ1/fs
         DjaXqsBTMZVzbbmlyRK1/d8qydALTZMZ7Yu+mXSaALZfaSQb86hQRd+NEdK80sml93cg
         nfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767283082; x=1767887882;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xWxZMPDfz6VibqcQ4C4tU4AllLssToyo/WIL80GfDDo=;
        b=jiTMVuEIF4tMMZSrhiyFsUrb7Il9ojSLh17mumXUY86HGLikYcKeodOjcZLfzSvSaG
         dX2iIziZjjrK6wXFdkZBfHyJreMsbpdLSVtMx/Vt8eEDe4qB+fhuAGyzS49hzQClVGE5
         ElDayfy5aiHpH7Hi0CDSIaCO9JBunQ1KZqv6gEK7tRMwAfBPQJEy7gziD4YHUvbX+BxS
         O1AD2IgcR872HYkzZcEv3evvsZaVGKFMzvsll5qay7Vqw3Ngy72kNZCmn5O1rtloakrU
         a8BWFZynaowbKQZg/fooPz5BG3KrLJ6uQ13cwi0MCSHP6y8ceTbPa7wEOdHDf+DlFxA8
         SD+A==
X-Forwarded-Encrypted: i=1; AJvYcCU55oCpEEh2ks4HAtMaUhQiKbbChxjQbODQ8sahWbCQMMlMd7A0nE10QFdf9Z3L3lotuXHC2MRE87bqxg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+mlsE82JkqOYvPapKdYmf9n0rQnRh94xqn/lHs80M8T9gFSK1
	ZfSkOSk6+WDIVk+Wdia3uUT7D1LmQvnqNOBiCVdwr2t2N5PcAW2yNfYxGjbqppL0oES7KfBBKs0
	YRic0
X-Gm-Gg: AY/fxX77hrK4M328M/uvFbquYeA73x863V5/93u3ydiwvfL+FnGkF2bAkx88B4HKzq1
	25in3Uy0jqpf00Y1qV/WFHcMJVuemhsO6KEu4S2e+HwO0mm9y2xmirKHAZXsgkuK2NyGZL0lzV+
	jBcmX2b/Rwic0JWMuOyDfqpHhGiEq60Av1rXJYu7mo1np7509Hm2I6gedLi7yOLrN/Erpdwfdv9
	PzvWPzE4zBB/wMxF0O2q5Nk2wlyvssarEWqamLTq1ldVxxGisHQq9VoioBoFL7lDv6DgAA1Yebe
	SpBpoJlPsiouYdUECvkSCbe6pwmkM83ygVgmjiM/BGpTw5/+X6VN1+gxUo41z6tBIXnXwBFyxjv
	90GU5GUONIW8kdRBaUzDe6Dkbiy99xfh3/xDGz9eCD7tegr6kczlf7Vg3I9+BzE+szDfapJYZ9B
	B79KQ=
X-Google-Smtp-Source: AGHT+IGHCkf/1xNPXPk0nyG8mmvveOUau82FYECqKBzaPoATKt456TDZITRLK3PauRkPrRFIrTXqiA==
X-Received: by 2002:a05:6830:254c:b0:7c7:55e3:9117 with SMTP id 46e09a7af769-7cc6690c751mr20713295a34.22.1767283081859;
        Thu, 01 Jan 2026 07:58:01 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc6673bdabsm26303693a34.10.2026.01.01.07.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 07:58:01 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Yu Kuai <yukuai@fnnas.com>, Julia Lawall <Julia.Lawall@inria.fr>
Cc: kernel-janitors@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251231172207.143911-1-Julia.Lawall@inria.fr>
References: <20251231172207.143911-1-Julia.Lawall@inria.fr>
Subject: Re: [PATCH v2] bfq: update outdated comment
Message-Id: <176728308066.509736.9424691237994816881.b4-ty@kernel.dk>
Date: Thu, 01 Jan 2026 08:58:00 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 31 Dec 2025 18:22:07 +0100, Julia Lawall wrote:
> The function bfq_bfqq_may_idle() was renamed as bfq_better_to_idle()
> in commit 277a4a9b56cd ("block, bfq: give a better name to
> bfq_bfqq_may_idle").  Update the comment accordingly.
> 
> 

Applied, thanks!

[1/1] bfq: update outdated comment
      (no commit info)

Best regards,
-- 
Jens Axboe



