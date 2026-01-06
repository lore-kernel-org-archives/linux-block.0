Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1197B1A3179
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767702639; cv=none; b=tJ/c+Q3OmMVl7KQG6B5DRpvCRQHKRdyTAvViaVLpdEJJaunN5MjnMLMs4fIGDSsdaqwCmrBPc4bp/d8ESPe0WGKrBcg04SejU5VKLs1IVfL4opxN2bsgOP2U3sg5hij7hNZPBFK4mwTtncH5et8mpW/eF46b3YEDU8M0nyz2t0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767702639; c=relaxed/simple;
	bh=gB36QsoXU0TpS239Nema2PzGFrocJoq6IaXrZ2FkwNs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Xqiicv3vcSnkws62V+bkqi/XJHuLLR2RYwhlL1k85bO/tXmzr5r8YRdPKHGf8ZeybjNC1efxzc9cR2VHz4YoxkA0wG032I+bmWf6TmaG89VbWMJPASfHzkO/HxjDpbjfQnyBOZ1mztDl8XRTYfrZnWTmvlokgwCC4Oxh29uwGDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=d7WufLH6; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="d7WufLH6"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7ce229972d9so525510a34.0
        for <linux-block@vger.kernel.org>; Tue, 06 Jan 2026 04:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767702636; x=1768307436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRD6jeYRVssN659Sw64j7XEIC4cPwxx4Q1nuaQx4yCI=;
        b=d7WufLH6V8duD7q1WuUyl627/RWnFyk/ankOMhSVY6GK/7H3oYalA0tYCnzDKiM8ob
         WsUV0Zq2NR4QQLVN4fMXK3eBdlenEaY5hDtX3C3uiwVFV1U/I46E7JQcQsp7Xg+TnlOS
         CCePODz69eh7mI1ran76z7daMjV6y1zZ9JQxc2MY4YLAnvc9E/Q/hK7Xc08CAn2dXB9b
         o1zXp+Dpo8AFjFZe3FENZ6Wx66b3WyP/UJGGYuzl30cD5Y5gftFJzf4bWXOE0bsnPKgh
         ZL1jopXNyuL+WLXbqMgvpxcIvH2OnIJoORUfZhDtdXrEnnOEX/KHafHrYgY+0aAn3hE+
         VNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767702636; x=1768307436;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eRD6jeYRVssN659Sw64j7XEIC4cPwxx4Q1nuaQx4yCI=;
        b=mItzp+1MCv5ElqmRPuOlK4jmHyu4k74qWNulhkRO82DbLGckfEtSsAnfSyOlxzus3g
         vUEYbsvUWCbje9G1efCFFPHxYj89QXlG6I/u9u4JK8s5H6SBFG4xBvI9A6LdbsFrvkjr
         GDFD86TZjg5vr2eD4CSKkD3p+wkIpBmh+lQiO8NC5IviCZ2AnB89u2Yr/iLvaPebJlfL
         7BtoEUoJ8D3qFweryN1ou+POulkRfb2Ovyb0teoyr9c8plMYT0sHAq0sPNE/L/ansjuA
         zxjsApze8hx4kNEDlFOO2ekI23Z6lPquiTdyaIhqUvhR30lJjrwchDBNMYnpFrMYVJ/R
         +oZw==
X-Forwarded-Encrypted: i=1; AJvYcCUQcfZB59OmanaToq/P03OXcSoCdQAXnMbxwlinbdZyZ/QBWGuvrJhwaKVLE9iqMEkfw66flzz/kySiqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxC56Njh7JP/CRkPfsTDo273oDhRl+hRhtKrfYoDpkU2sX4yhJO
	OFyTxBs0lWbro7HvzJ76RmNjFlGs+DXXvlX1Lc949C1pAW1XM2Tto10R5qvOoRsU/HI=
X-Gm-Gg: AY/fxX7Fs/l2vWkwEayXs3XeA4/3P89DzGAWt6tnufeq0RuZFIiLP5N2qZNPIZaxfB5
	4CcY6t+Ez1npfvuzQqnCYqwAo1y2Qqar6EegGz+SQgfzAWdmMmxVnVHy5znWs/RIEmMqFPK6idD
	0NLb3Q/qUYJhVbKgd8G1HIqG7zznVQLoWdHLZBQrfuksdkBAHYMD7kDV8kKwuctHbGUb38X+5Mn
	FTOjWf+Rhx7/VnioGF5Axbg5Qwa+LPC9c9gpQ4EKU6Ug0MC9s0Qn+WVwmfxadrso3FPvIVeJVlF
	svMUfogzdO59EZUG212G5D3hvpfL8u4NdCpFdP5e+D4vQhmjdQ+h+v443vQzRwgRD2K4KpWv/P5
	fKzzJ9TmhWoggr0biAVyv6RQITgk1yTe6097Z4+zMVT95xnobEydvxPozxTaOzjLJFmD37oHlYP
	OH04I=
X-Google-Smtp-Source: AGHT+IEtZa9I+uCqm09OkXqO3MU9uobkzq6ZOZ/pse7UNNQlUp3JEKnyhaX9omCuNpUegRYFCc62Hg==
X-Received: by 2002:a05:6830:618a:b0:7c5:3afb:79db with SMTP id 46e09a7af769-7ce4676e4cbmr1304877a34.35.1767702635955;
        Tue, 06 Jan 2026 04:30:35 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478af6efsm1328600a34.18.2026.01.06.04.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 04:30:35 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
Cc: jack@suse.cz, syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kernel-mentees@lists.linux.dev, 
 Yongpeng Yang <yangyongpeng@xiaomi.com>
In-Reply-To: <20251217190040.490204-2-rpthibeault@gmail.com>
References: <2crvwmytxw5splvtauxdq6o3dt4rnnzuy22vcub45rjk354alr@6m66k3ucoics>
 <20251217190040.490204-2-rpthibeault@gmail.com>
Subject: Re: [PATCH v2] loop: don't change loop device under exclusive
 opener in loop_set_status
Message-Id: <176770263471.676302.4742936561051912973.b4-ty@kernel.dk>
Date: Tue, 06 Jan 2026 05:30:34 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 17 Dec 2025 14:00:40 -0500, Raphael Pinsonneault-Thibeault wrote:
> loop_set_status() is allowed to change the loop device while there
> are other openers of the device, even exclusive ones.
> 
> In this case, it causes a KASAN: slab-out-of-bounds Read in
> ext4_search_dir(), since when looking for an entry in an inlined
> directory, e_value_offs is changed underneath the filesystem by
> loop_set_status().
> 
> [...]

Applied, thanks!

[1/1] loop: don't change loop device under exclusive opener in loop_set_status
      commit: 08e136ebd193eae7d5eff4c66d576c4a2dabdc3f

Best regards,
-- 
Jens Axboe



