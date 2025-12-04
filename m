Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BE72F12D4
	for <linux-block@vger.kernel.org>; Thu,  4 Dec 2025 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764858330; cv=none; b=ISaEA8cach5QYvNqAYTHeq4I7N0KpGiScXMArWwiXl7IiK6cshrEML5QOc5vgfChl2pK80knXU3uWX0v23ff1UJpbTf+HwwBvBAz4QzI2nU4iKAM7ZF/90dz4wjaU6a4i3Q1Sfkhie7lOLPRW4025mnGRtKKyDuvP4gOf0NIwp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764858330; c=relaxed/simple;
	bh=KKW2Hv1hSGAsJRhdMHUXcKM+9slcRwM+prXkOMDQsWg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hdM2I6vIJV44sXmNd9765c+Ke6ICvEhp0ixAgKmH/NkrtVVEfxRifsFgZ57370KsC6TG9B9JVXCzTaqe9P7HK42mA+ZYfyo4RezneEYvxx5Rdt7drXWjYFSxfJSB7kC2uv8l089r7zHw/tVPa97coW2Hb4lbi3bqPO0sC/ftdiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=y8RutJNf; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="y8RutJNf"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7c76607b968so423504a34.3
        for <linux-block@vger.kernel.org>; Thu, 04 Dec 2025 06:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764858328; x=1765463128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3H77ajhUm7eIi3REpMEXuCO78Ltunh3YximhdobA4Y=;
        b=y8RutJNfQHcm2B1CisissnkhK4spMUtU0JxorCbm4Tl6qJ9ZrOYP+6Y107/nYbCBfJ
         I2b3xfs6OwNa94BTcOiGpP4Yp1MM7zX5NhnvPfLuc5wqc470mNmd/GzDW2MMiDpiLoQ+
         HZH/weqcF945dnmkE4ZLHp+0geoNDN0kmDE8wHBlQG2Q300ISAXwD5QpQ26rwosqWq+e
         NVQKuJPt923rKMKdrugZXjpfVwmjlczCgv6RTk4WfwFDXQrN4WEIibZ/DQ87wPmhBqXL
         rG61nn+vTSL28r0HVwZGve0club6PmuunUYPJLrKy3Lz+zsxtIn92G6/1Q5URGH2ReSj
         aZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764858328; x=1765463128;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V3H77ajhUm7eIi3REpMEXuCO78Ltunh3YximhdobA4Y=;
        b=l9Yy3vTaIoZD5rNndsfeFQfiwavHRIEdUSMXTU47L32/jZfD1e3z7YXRYVr6YVlweK
         rpikyMpBgkw2l4ig24i7KJoQzpMv+1Kcso4eaKo84uH9pDnN0iXcOTBYvuS5/SPfxaAY
         xhtraanspEW/vUnWuZcygAv1q8ydh9oh/eGbukDKGbejVUL91gpJKmVE2tWtWplVp6aX
         gTqumx8WPVVOn1+dGxwrLczOIkjORKNrIVdPD39Zfd/03RSFo4LJNMltEVGmHSVkajxF
         HMfqPSabqyZbqJ7sXQnrk9ip9dGZd/1RB1/qz3RJAWvDhQxWVHmVhvdzTCxC/KMmL+DW
         DcLQ==
X-Gm-Message-State: AOJu0YzqWqR6DRji9QOP1+uFqAX5nhCS3k+HSfC/HHyORcx/0IAFa1AM
	CbiSTH0lYzWwJcoUDy1C68a5FAkWyIW4OL/CJyeqauz4QAYaG0cOabgAnYASeOpueH4=
X-Gm-Gg: ASbGncvtvr6xgy40GJoEdKnmbsWl3ZsATJTlN+9DJCzmHC04gxKGncuvcRW/9eqQnyU
	94i2BIKvDXQJ4wqteyVETyMlkDYvNu2QNVSdxumnpxaStoTPYsqY5R+2ImAr9D0v9FLIOcEVHF0
	hePHboJyQOHWdjX5ZfiyNL1KyPo9RZqm2rqDxTBnLLUU83clR146P7640qzzLJqLG818tcxJOmk
	+rN6BYhclWXAfoRVS4TvlD+bNCONYSfpxbGu1epOlBnCjVZwcKLws5bQXZY8OapefvY2oWMSkoh
	jghGiJkgq38Q+rUohj9y8CGIrpD/HBAqwwVNFrWl4l0TKcZLB0BH/WNa+VHzTdRY8gSQhNeLrr4
	YppzZNctXr+bObUeqGoh51VtaDPbhN/W83Cw9qPzw1liasxUvwO7UZVRr8xPYOUcjAFe/80mFjj
	ey0E/JgwltuyWF
X-Google-Smtp-Source: AGHT+IGhPyQmTYxK9Fn4JQku4zR/JcXWjFyng2BsNeEz17RsboKLwPmzZSV39j3yaElTxCtdQOYnEA==
X-Received: by 2002:a05:6830:2406:b0:7c9:5b32:b0cc with SMTP id 46e09a7af769-7c95b32ba34mr1088222a34.19.1764858328495;
        Thu, 04 Dec 2025 06:25:28 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c95acd567dsm1491772a34.25.2025.12.04.06.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 06:25:27 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: shechenglong <shechenglong@xfusion.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stone.xulei@xfusion.com, chenjialong@xfusion.com
In-Reply-To: <20251203151749.1152-1-shechenglong@xfusion.com>
References: <20251203151749.1152-1-shechenglong@xfusion.com>
Subject: Re: [PATCH] block: fix comment for op_is_zone_mgmt() to include
 RESET_ALL
Message-Id: <176485832736.920754.8672810628595001989.b4-ty@kernel.dk>
Date: Thu, 04 Dec 2025 07:25:27 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 03 Dec 2025 23:17:49 +0800, shechenglong wrote:
> REQ_OP_ZONE_RESET_ALL is a zone management request, and op_is_zone_mgmt()
> has returned true for it.
> 
> Update the comment to remove the misleading exception note so
> the documentation matches the implementation.
> 
> 
> [...]

Applied, thanks!

[1/1] block: fix comment for op_is_zone_mgmt() to include RESET_ALL
      commit: 4ce1aeacddb06241a1a9c75bf1c1bc3be5a799dd

Best regards,
-- 
Jens Axboe



