Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAF921256C
	for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 12:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784636705; cv=none; b=pV3HcdrZZUb0KlwpUeGLES2fig93am9uKIJZI+8dgdAirKy/x8N+RPQymDlpunZnSsfYe4ytC0BP8V74p+0RRkbZzwmsLl3LJaMeu+fauH4qq+AMeUaYiDVfrrS8zwKXVkq0cV7wyRQsPa49dleuMItL6qQIxQuxcAzh9EuicxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784636705; c=relaxed/simple;
	bh=n3cRaxkTZw5gpVPY5POmKzJdneFr0nZnp8mlFJt8BAk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JuXbl5g2wH/wVxDk3T6Isf0pjybI6mxfjV0cdaT4Bpk4kl2qYQAZrcqZm9Mnb9JKfIjRD6RSE8+f/oWvdbFGhl1yJXfiG+/lRS52GoxGhhJTzzBzeD69lYbtKODXnTgN1QJQQ5cxUzwGx2Ouj4x50G4A+NDvoXW1u2oJKx0pB28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=blTh4h2e; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="blTh4h2e"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-495c63c4141so7062334b6e.2
        for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 05:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1784636701; x=1785241501; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EhCvBVU5Lv0jrHpAufZTERt2K3qIJ7tS/kHznUKd4HU=;
        b=blTh4h2eOxRzAHE5YhOu92ZJh9r4sR6p8Q6iOr3tONLFpUWiid/w38KchNXv4JOctu
         XYKRCFhGXZf+4ngcxdcoOdZJ/pm2fVcz0OfF+mZitwohF0fYcGbOt5rMWp7LbvWikcnj
         2Wp4bE4c4mn5EahFMg+Qg26XegyA8an31vd6Af16G8y2tsqrKz7Yk4HDy5eTP6wQhH9U
         cplZqGpyWHqrCzGjxGCPRIeto37j7ZGDvo+B1qz2mluBQ3A2dagtC3R9YjZEz54Gc3Ip
         xdF+gCoQgwo9LI20xulSd0iec8edYjVG0l64LuZ4G190mVPOB0ygFXx5mowepZxeDja+
         UBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784636701; x=1785241501;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EhCvBVU5Lv0jrHpAufZTERt2K3qIJ7tS/kHznUKd4HU=;
        b=WeCRsotabJQ9MvleFy/UxQeAsxKt6p0oENsQn4Sz4QneTzm3D03KlbB0RPmdWeb4s9
         RbsugJ/Daq4b+bJkQ7agopBxbpCCc+LbPckRS7UyTa6Q8Y6MlD/ofPeGbD0TUOfHejIA
         z1AnnMlNKr3w3qdawFEWEz+Jdaae4LUEB8x2v3svopawefNZbZ1i9K/cyIayG9Wh6RXs
         ltRkBbYmTcWrausyr/ZNfVBXB4umhlsERJtw/NVP71FiQzv/ntflvsbo1fqguuw+S9QH
         HJHLliLXtoJ4iDLnXsJiaMpCz4kv1c+0zU4y2pgtGIDX6Ro6t8oVx8JoRrt0FFc9kVM7
         W8QA==
X-Gm-Message-State: AOJu0YwJikn1SmdkGsCYVxpoJw8LwIQbN6V7mZFsay8mR9s1dWkQqCLv
	pTjfFzgbVer3QL4P/QUXaSIK3J0kVe1EOb3odiBtI5/SZ9PMDVtk+ODUFj58VPSRPbs=
X-Gm-Gg: AfdE7ck0qLeB0+u98osCOhHJAUL8/fltrPpmGX3GW3PR3Yemi76z6TmEoZ90VOASt1G
	KhAuPpj/QyYQJTJkdt61c6iqnZIUpeul/PR1r8XbaZ0BqF+NabRqdTz4eGOotajur9Xu6EHCMV2
	KPDRiMDw9RSeF+gaQd2Qxds3Ik/O+0zlPfg+amvwbKi/81orwwZr+iQ/UBGgBW7Zvd4L3ktoASC
	ML7nfVUImpOlwfn1L5qIX7RdWmPPwInCbwJ2PIecEKu8sJpsGvIN0m6U89hVgPQANDdzAADo45w
	0thPnWKkrbl2oKqhPo5ZFZ4m5Mde5GYrQk0L1U9OAvNsKheoCIqq6kLfWubaconGTfV1BPOxQKC
	1H3S8tZuHjkB9m4bzby9vdUhKt4LJx5TJxF09etSjrhLpcki9415E8a8VrKEotjVmD9hS3oguTi
	3TFS/6qQSyvIzW12IwgCAfaNEEr9L/Tz03h7kt62Tnx/vHq3cfJwpn8Yc=
X-Received: by 2002:a05:6808:2518:b0:497:d574:6155 with SMTP id 5614622812f47-4a4d04fea24mr9432101b6e.33.1784636701585;
        Tue, 21 Jul 2026 05:25:01 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a4d3d06e08sm9648825b6e.14.2026.07.21.05.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 05:25:00 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org, Roger Pau Monne <roger@xenproject.org>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20260721082321.81212-1-roger@xenproject.org>
References: <20260721082321.81212-1-roger@xenproject.org>
Subject: Re: [PATCH] MAINTAINERS: update my email address
Message-Id: <178463669959.327261.11593714504495313126.b4-ty@b4>
Date: Tue, 21 Jul 2026 06:24:59 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 21 Jul 2026 10:23:21 +0200, Roger Pau Monne wrote:
> 


Applied, thanks!

[1/1] MAINTAINERS: update my email address
      commit: 093fbffe03f5c1bb9c10a9e5aa65b23250844403

Best regards,
-- 
Jens Axboe



