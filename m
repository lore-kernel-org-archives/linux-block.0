Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E36E3CB2E0
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 13:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774962449; cv=none; b=DZKalANNZ/Iounkjq+wP+B4nsicWM0UInD81tyJfXvsM0QFKDbLs9Wt5Dc21HbE/z2TqCdtBqtHDLlqwPo/Kq1XevtEF74FJ9NENDsz87srByyw55AmWmANwNnPne9wFLo81e2GQXHZhGPSV4m1U1lTURzaYc4BgPmY6GwBKpJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774962449; c=relaxed/simple;
	bh=j9U61ILI49d1aKj4jK0JLNF5o6WGHXnfr7TNTgci+58=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lq0P7oHi4+/ERMrg/bsk2O+b4CQsYoB56FQC2N1a9deVEwXPnfQt9tnsHsEdktO5RMhJmXNf3XTyYmVkGdNnXXJbc/JgrEiOTtOeo+dN8nuZhbMyHSnbYk8kAszyU5gevb3Yftdy1zXGnXkTtDK1V5GdpGhpvf0f+5n5xgO/Dds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=As+s7xit; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="As+s7xit"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d7653db148so3055912a34.2
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 06:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774962446; x=1775567246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+luZrtmJ+KQw8Pgvb+YDR6Xmi7DpQBHnXamiACyhX3Y=;
        b=As+s7xitQZbBOLqQ2LW1trNPW5biMUJ5Gl+uy9fBcuMJqCPy1zoMhAOQbWU+sDqBFk
         mk2AWMstLIRZJKlWn6OXbT4YdjWfvVK/vPDLm2uEYTuWGYVeGN/yYHiGm0LdJogCo3oe
         +c4HXkgn8AsYFX3JqkMVBQRR6S+ud5Yin5xbjl0sBgvVCIJFWeQo6mS45R1tmQXqya5v
         /u6wTq0TGGHoWWS/qPPAPxbLbVACpUjNC7gdgq4H1c5y3hwFZB2NJhnv8IfwDl6WTTR8
         sYko0PBl2Nyh5vj/rGPt3ArXPOhVIvfz4DroUXY3v4jHFqJl8U8xFPIyj6CDjlIDVO+Y
         la3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774962446; x=1775567246;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+luZrtmJ+KQw8Pgvb+YDR6Xmi7DpQBHnXamiACyhX3Y=;
        b=eKqOfZDYN1Gggv8SWvWSTM/hr2kAave+wWufvQgGr+06BV5R6Ib/bsFPOrG2C3RckJ
         aWGgAXkz7VWpLiFeDbh94/wwG0zLiBpiGGHAlEOblr6hoCv6IYd9lIYDegWyzhtwH0QD
         JyDfwCdibk1IrHOZdCR7/gCvLwqCFqyq8PqWTXBf8xQ2pdfO/XzoNfXlaAjDlYa2zjRJ
         HK/QsgEnt2Iax9ur3R+cdGHMic53O4vqFIz9aU8uJjCquZ9oJhtK4QaZDsqG44KV/ge9
         wiHH1QpSxFu7Ug5jCM3PcmzCg6NxaSaIoTKYzhbjINva9uLhX+jMBmPKtfvQcf0RCQgt
         NOCg==
X-Gm-Message-State: AOJu0Yy+XwB4qxnMiz5lsIOicy1pFz3EXxfN7Ck5eSqZKbLAYx+r26sS
	CsNWstG7DExfBpgQiguL+CfxAeCJCJuwECYo7/tjqOuEaQmWox4tTFDS9/z39UiDveo=
X-Gm-Gg: ATEYQzxduUAu9adJKncnLlB2g3Cc2RQdckzvvZX43mquB+MxPImTZoqCVOe7xiheUNN
	8kIeVPmWWmP9WGg1c6CxPVlpflQ+2HzQ/9Dth4PWiq2CGJBTbOxk1pLEnmYbeYhJNMa8NUI0cEJ
	oEUXs0vy8ATtNFsZpW9UytHD7NTbZBRIolchELo2hdCeeHKHL9JdcowoH/KoId4Fuco7nKVBELG
	WvvhDZSSDn3TAYco+S686K7VnyCmC8GxNt+7zlE6FkjnQBWc976/OnioMlnh+1NQzBnz887L4m0
	weUlUY7MENMpP6Rzk6E0H4TwcTrAAp7u6xuhjCGbud4ezw2On3J8NUUFX1uQijW3zMp+YYE7ZU/
	jeDELY9vk3U8cc377GWgbGJdeC+5PuZfeetDSlXMIO4ck/U5QYIjQyUwvHzz1Wq3+aZImeR1vsR
	jP8fNLZ6oaPW49wK3SuI6HPJERX2l1avrpGYJONX1WPS+4W8LrqQtNkF7wKYIeSMh9G8AEEN5AU
	GNhVtBMDoavg2c=
X-Received: by 2002:a05:6830:370b:b0:7d7:b701:ef54 with SMTP id 46e09a7af769-7d9faf64220mr9852235a34.29.1774962446300;
        Tue, 31 Mar 2026 06:07:26 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a335414sm7901689a34.6.2026.03.31.06.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 06:07:24 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: brauner@kernel.org, hch@infradead.org, 
 Daan De Meyer <daan@amutable.com>
In-Reply-To: <20260331105130.1077599-1-daan@amutable.com>
References: <20260331105130.1077599-1-daan@amutable.com>
Subject: Re: [PATCH v3 1/3] loop: fix partition scan race between udev and
 loop_reread_partitions()
Message-Id: <177496244468.811501.3934411568463650977.b4-ty@b4>
Date: Tue, 31 Mar 2026 07:07:24 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1


On Tue, 31 Mar 2026 10:51:28 +0000, Daan De Meyer wrote:
> When LOOP_CONFIGURE is called with LO_FLAGS_PARTSCAN, the following
> sequence occurs:
> 
>   1. disk_force_media_change() sets GD_NEED_PART_SCAN
>   2. Uevent suppression is lifted and a KOBJ_CHANGE uevent is sent
>   3. loop_global_unlock() releases the lock
>   4. loop_reread_partitions() calls bdev_disk_changed() to scan
> 
> [...]

Applied, thanks!

[1/3] loop: fix partition scan race between udev and loop_reread_partitions()
      commit: 267ec4d7223a783f029a980f41b93c39b17996da

Best regards,
-- 
Jens Axboe



