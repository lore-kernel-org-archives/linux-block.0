Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DEE24EA81
	for <linux-block@vger.kernel.org>; Wed,  8 Oct 2025 12:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759926517; cv=none; b=t4oJEn22YYhnYJemnscLqlVfYcA4J5Bjubwmkfw2DDqgptlroiUHqIWVqOQr9ky/ZbcSGayBn+KaBUrc4rtK8vy1/1g9vdJVaieQwV2XirC+FlwAJFANGj+gIuwNKINn8/E0pUDurnLUyJCMDskGy8PU7LDEFxJ7fMb/WdA+730=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759926517; c=relaxed/simple;
	bh=J+ST8B1duH0xVw6MSCh6lDkEGNmwImONntlHDiFPjjA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YJ8eC8l0EU3ThxkohPQirwzIVgGnMGOsyToUcoQ+6tATsSpWRSMLEQvYjQLsWf/ABmeZ99xjN1dGn9CQr41LlpXGLVpKXaqR0BCvu+DnEvqLmBzs1liCxe7LJCiCrWj+fFxvsnFaxYikID/le8Vem8NtBF5SW+vfnSGY8Q2Ka+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zjKL47YI; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zjKL47YI"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-92cebee95a8so330800439f.0
        for <linux-block@vger.kernel.org>; Wed, 08 Oct 2025 05:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759926514; x=1760531314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7P1IY2ruXTZr+b9uSPcLMIKiYjNCkwp6VYKIvdirvQ=;
        b=zjKL47YIB1JnSjdPOQc1kq5noKO3oq2AyaIpouSII1voYgJJ6ETC7DEaXcYrW2bSjC
         1ofkWpEztHZNku/D8hrQUI72JHUnDnDKsuZp4ZOj6NajlTPQdkrsDo5AAUV6iICchxUA
         4KzxhkJfXRgv0547cnZ62fHJ175wEt6dqQ+5ejw/MSOrvDK8feAUWf8REQx5v8tIgglP
         k20OaV4ska1mSTq8w2V2MMBjhWWi0nwfUc1I4WqxSkIG1eloxIAMRorcpi8SxueAr0HK
         wnRlPDoTNHMP5AnQQW+wWT4+uPUgVry+YPCHlxzCCJtyGS79nGWKDhNIh7QDnC6O1Br3
         qYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759926514; x=1760531314;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7P1IY2ruXTZr+b9uSPcLMIKiYjNCkwp6VYKIvdirvQ=;
        b=HCC+ElNls6iImjhq83Cdoo3xWm51NGlyRr9qjv7FSw2j8BHLCRBO7USxUpwW3g1wWA
         mBiP6q+L08acd5HzjZ6NXhz8PWU6WQww5LMIeD6cyDlxxrPyqD/J/K8eusVa6YdtMQpG
         rF7nwWzO+QJhoNaspqoB1KU4PQezwwQqhxWsNEX6yl+SE/IwSE7GTl+XyHO8sZ8MqIWo
         4RRcB0byR/EUJ95k6BjLzn9UpdZ2HFsHAA5eH06qNpClesoULzfeMVByuvla08hvlKNw
         p78PHB5btDax3iPJ6llAGeDXg5ALn6zY6diSUsW6dx9t2s+zj1V4OFeHzPp3phty0ozO
         nQYg==
X-Gm-Message-State: AOJu0YxOeCv4mHeOfCfZjtjqWzXHUIT8trwoB5odl+znGmqU8hxN6Ro1
	ITt52rsgV+dMDGs3AMwGO5nMMX/lJkJxRpYCdcPRLw4lrGd6OsuSaDodSAqag8zxT5VG2NJw96k
	o1qzHHUQ=
X-Gm-Gg: ASbGnctYL/uXdjahaVSVXYoLmLFWH6rYHJ48ncD/x0eQI3uul5RmF5Oq/zIDApLZQNi
	if87EG8wRDX1WYArKwj6RZOUJwy2FhTtK/OEEsSXAL6+sI8iGha6RGZ1BZcCQ1Mnrrj7M4oyAc3
	BTclL1kdFdO3UHPcgaOtbQXD611Nz1Uyy1eHvXj+qh2NSAbEpfgxKEOZLHHSpISr4rE7vxw7KfH
	Q7To+NEbLhQuI6flgLI/qbWEKPVX3DYvxjliVS2O5u1Qp7qr1ftzNDmY5Quoa153uZup/830gEi
	lbcwm3+gz6k3UISM2nSSC2UTLczOfzxMQTt+Pkqa4C6HqzxVR/QWzkYX+FwgIiQHW0gGakDNHa7
	0eWy8L7o7uPcaFDiVZIeV4s0qtvY+9+26cjNobqM=
X-Google-Smtp-Source: AGHT+IHAtBcDrbT9BvlKU4yOyNu1cam7D59FfGTizxMcGiKYN3MdbtgMVOI7VgVCLe9zn0w1vOfqSg==
X-Received: by 2002:a05:6602:6010:b0:894:6ff:6eb0 with SMTP id ca18e2360f4ac-93bd19cef0cmr299245439f.16.1759926513769;
        Wed, 08 Oct 2025 05:28:33 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93a88961d74sm688387839f.22.2025.10.08.05.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 05:28:32 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251007181205.228473-1-pedrodemargomes@gmail.com>
References: <20251007181205.228473-1-pedrodemargomes@gmail.com>
Subject: Re: [PATCH] loop: remove redundant __GFP_NOWARN flag
Message-Id: <175992651273.2000341.9110846781378593790.b4-ty@kernel.dk>
Date: Wed, 08 Oct 2025 06:28:32 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 07 Oct 2025 15:12:05 -0300, Pedro Demarchi Gomes wrote:
> GFP_NOWAIT already includes __GFP_NOWARN, so let's remove the
> redundant __GFP_NOWARN.
> 
> 

Applied, thanks!

[1/1] loop: remove redundant __GFP_NOWARN flag
      commit: 455281c0ef4e2cabdfe2e8b83fa6010d5210811c

Best regards,
-- 
Jens Axboe



