Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9B81684A4
	for <linux-block@vger.kernel.org>; Fri,  4 Jul 2025 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751643068; cv=none; b=JV8xOLHIF5y3NIvXdoLt/f8YMeUAKMrZVLzTxIbQlSPLYjsLfj8UFIjiNqipDlfrM3Ik541gPzUXLkj51EBBVYUCagcPJx/eE6qyqzaaeaT5doE/NmT+g53uEAjpxpjXrxEEuU35Ha6EFvrfhsv1w7LzBgfnRWs6joSexQ5hb6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751643068; c=relaxed/simple;
	bh=nHadSmOQ4fj+9ocF6rtES/ek/GuvZAir7sGoHBqWim0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aWXdjlTkUcXCgpmPDhg1KP70onskNaoGJepdnLbxirZXaf2kdRWHCdT0e8dbUzAKLbwSc9+THMDyEDiCb5GQhAKAN5UyY5FAVY+2vp4vEeLx83QPnba8m/0H2FVHZ0BsFen5cH4dS05MWBopVb0nk5nMkFgo9qyVuKEJI1N2/cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TvFn2PDE; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TvFn2PDE"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-875b52a09d1so32083339f.0
        for <linux-block@vger.kernel.org>; Fri, 04 Jul 2025 08:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751643065; x=1752247865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9U2YxSqLeeEvmDWj03WV/W/8jXHi/A1A5Rn3s5NR3A=;
        b=TvFn2PDEE08DvdNjlBnqzAndh4c0St6Y/7jdZgEcbLFuiljZ5rGnOSJbOLZcUKFHtp
         O9+hawkMyI6UOVuh429NsvuxJlTP/MGVW/Z1oC5gGvQpBMCzHt91NU3YcQ5iQ1V7c+Gv
         oM+vxkMGY6wgnxsfXaCj8Dwxq6soSHgiZmphNChGJFmEWltkb0TZIzmaNFLTB143ENZW
         2snHLK3nD4fajayCubJ0wUYEcn+F09JQBvJpEYjdCe4DL+4TlsZoIbFWYZyHFYEjImkU
         WD1PeQWJ71H1QykiGYi972nH2VGKTut/Q6wBkX1bPn3qOMOgVViqfQfDvtzqKAjAy/Bt
         bF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751643065; x=1752247865;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9U2YxSqLeeEvmDWj03WV/W/8jXHi/A1A5Rn3s5NR3A=;
        b=u5rm6+3Ws06wDrlb9olnS5Fwfd1AE4elNFbVgPsE/+CLGESLLtyqcbAUtvsI08x4yJ
         9MzBxj173NcDhFlWAhHScHkw5BfeSXNBVAj0eSAMlBQn2hUxzf8DLI8neQBEDhRZofsw
         ntO+74bpRdikSdJ+spEvj6hipUfKWNP84Kxk0Bl4VuycgVRdHBKy4rQJ1Z0wP5jYbMgl
         Tev9YXW890UNFw64A6UmLdudypo+kYL6o8hDCmn7LxpE0/uTV7pdPLbZ6e1u/ZkDj9lS
         1XdVJ9BRLaXulbn6Ri+8YD4Kuxq3DTk5S3V8W/p9YmcgZsW1vVBv8yBy+rNjdzoAieOd
         x0zw==
X-Gm-Message-State: AOJu0Yx20TBmm3f09ZSiq30B/n/uzlQ3wL9DkQi6cTtL7fRXy/Bp1ox7
	DAOEF3vKIdX3osU9oWiSfopD/ASoTQwU3loZozrbQ9H5ZHPo00+nUV+ekJ68EntecQw=
X-Gm-Gg: ASbGnctYKrYOLgvO2k/5o87wkocepYDvFYDEoipK1rOQhVVgAxS6t5S7KrThvpfbVGp
	JSikEPonHKOKUckV1Kp7rxRpdPlUKvizDFGfmih9zAF3E2N4OVtv4E91NJKt98vt4bbSojkYMjn
	GhT5N5oh0zKyUZd2kZ/2709O50wi9GTeK6JP7MC8NzP+GotdBeKDHGSmXTuWZ74iSZNxgns/6D2
	7Ta8MVNnO/8LCtA5VCu9KjSnLSIdru0R0wG24zJnPz/KUWA03ajBNNefozu+Vz9DEHpDAoSCtbH
	7dCZZH9xauQELTHQfiEprlxkjfusz534qCis2ewyfT0y88QJ/VqkdQ==
X-Google-Smtp-Source: AGHT+IHEmIEl2VIpJwn0U2kmzedfnLAA7Xc0aynsYELESl9e1a7hV/8vJyBS3dHfv/hzMTr/lr+CkQ==
X-Received: by 2002:a05:6602:3a07:b0:873:35c8:16f9 with SMTP id ca18e2360f4ac-876e47b0dadmr215484139f.8.1751643064818;
        Fri, 04 Jul 2025 08:31:04 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-876e06c9440sm53826139f.0.2025.07.04.08.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 08:31:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250703-ublk_too_many_quiesce-v2-0-3527b5339eeb@purestorage.com>
References: <20250703-ublk_too_many_quiesce-v2-0-3527b5339eeb@purestorage.com>
Subject: Re: [PATCH v2 0/2] ublk: speed up ublk server exit handling
Message-Id: <175164306375.597273.4784854727001872046.b4-ty@kernel.dk>
Date: Fri, 04 Jul 2025 09:31:03 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Thu, 03 Jul 2025 23:41:06 -0600, Uday Shankar wrote:
> Recently, we've observed a few cases where a ublk server is able to
> complete restart more quickly than the driver can process the exit of
> the previous ublk server. The new ublk server comes up, attempts
> recovery of the preexisting ublk devices, and observes them still in
> state UBLK_S_DEV_LIVE. While this is possible due to the asynchronous
> nature of io_uring cleanup and should therefore be handled properly in
> the ublk server, it is still preferable to make ublk server exit
> handling faster if possible, as we should strive for it to not be a
> limiting factor in how fast a ublk server can restart and provide
> service again.
> 
> [...]

Applied, thanks!

[1/2] ublk: speed up ublk server exit handling
      commit: 2fa9c93035e17380cafa897ee1a4d503881a3770
[2/2] ublk: introduce and use ublk_set_canceling helper
      commit: 10d77a8c60b2b117868a64875a55c4c8db6f1f2e

Best regards,
-- 
Jens Axboe



