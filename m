Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3581F0E2E
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430679; cv=none; b=e8OftTiV2FJKasjTgsmggjGzWLOHGTWnCV6cYJdHMC0PFVjiAIhtlLfuBopxqU2Tnk5psH5/TH9i/F19Dox4jJMfzEzlrRh86kM50nQWEhQkzvqngXsAFDTSPnJnt3K2QugwLhG2rxE7/ccZm985KNxst4IpZJfDLqWCaZlfkx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430679; c=relaxed/simple;
	bh=Yi9alki3/czo+nMmtW8KKc9BPrma/aJL0PzJbvWbD5I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pL/N8+vTXhI5jbgXtl3JlqT0lPxBdvRjPyh25Ze0kpVHBJhg8sQHAGM9YCcbGPN+CT+ruPP2q0esybBBhuOG3c+bzr9DffhdVLP/Yda0u9T2K0K+ZtgKpiJylDiQLcgqQCYGHmWPV/WZEX1hSsQZl0qHbfF1JFVxdxHt1kPIDYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=n3cmd5tJ; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="n3cmd5tJ"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-4103fb72537so9173885ab.0
        for <linux-block@vger.kernel.org>; Tue, 09 Sep 2025 08:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757430677; x=1758035477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cS9b0uFaTGrmrTbYZ9i09A0Kf7zFcLmqjsgw2bdqtEY=;
        b=n3cmd5tJIOCHKXgJ8b63Avz3rUov2w7ykDhPS/9JmuYjNqKv7F3wOLf5OqYmH61ePH
         gIMnHb91L/8JlpL6V+35rAy9C4pVgunrViA+to+XTUtZo6DjP0owdPtGnq/hxT3odqDF
         ImnVkq8TRLJmJ0voimf4qDBdXG1fRx0CMlDsjfvif9r6U0cmqSSZSPwmObmoqme4tjya
         KJIAnEdbaPFJvjVEFTJPy4368WtOnc1LipeVygpdA1/9O8fHNf87kf6p7vlit2PfRQaL
         cQSKgI3fkLIyZ0H5jUoUumipjt5qlf7PEydvMkE7Ff4+4RBlpZhTa+CP9H3redeRCD40
         yXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757430677; x=1758035477;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cS9b0uFaTGrmrTbYZ9i09A0Kf7zFcLmqjsgw2bdqtEY=;
        b=msgnHCqov5NHDkJR85KfzlGUHMPeel6L2HpqlGeg8ebXwB6Tc9xXgRVSX/ams7C4cB
         GEnXiyiZYAl8xunkfeESHXGIaf7A5m4A6vx0pQWXWYIWCFwCVMyuWq+f2Q/yI7Bp5flU
         eWRH1VUPxMyLXc8ILrrQ19X4AnR2mHMhA4CN9TOqa8aTlG022kf+sSYRJDlWf1Nc05fT
         h7Q6RReXtg/jxhFijQRSJWvNe6/tAJ5uiKYorlzSX2SkESqo1ilsOsC0cDsrIJmhZa4r
         G0ER+2f783PDrZeO/WfzATXcmqISM+1H07KC8wxE4aeFSHDhsouqiQOM/fyVO/M9f5XR
         R0pg==
X-Gm-Message-State: AOJu0Yy/SfbqlyF6yW0x9OmONLs4fMXFCFRQTOTjjTs77P3wj9BMZlyO
	AkJeIWSzUH1rULCOWW8eVHgFLJ1T6uGw8Jnmd9BA/r/7K1BaCLCtYz1gjLZi8eclesA=
X-Gm-Gg: ASbGnct9wKcQCDoj7G6IOGXXHK8WCzO+31wwYwgTvrYE04QQvpbb1aJQb+KZlJz3yJ3
	UY3h3O4z/2T3oi1gyrD2VUYPCCkuZV1HpWFE0iRFRaC+bHP/ex0yLyTN6J9iogqAYaZpAPlYMJQ
	lC2I6+5StN30ffnPdxcAXs4ucq/LfuFvQmLast8asEJaPtNaehLjnreKjOGRBEp4q1eoElFwAId
	k0Ya0C2mkp11FpFAVba5KeEIOa+YcsKp7n6HUS4uqeV9nSF+wxCg4nzx040UpfB5YO7MXXX1Paj
	S1wHatAh2ZSWPbaigMmL7J6H9AnVaa9LcUxxBAv9+pXWK9VhTCCcf7mn8nKl80XYMiKGsW/P1/2
	BIRiR57FywxfdT3YDXMAQSvIq
X-Google-Smtp-Source: AGHT+IHfZ7aZ9S/jsfKaKrcPjZ/IctI/GBXuJKA4st6w1Jd821n8kXWKAx/LIw2xQak6G/2Gts4/eg==
X-Received: by 2002:a05:6e02:1a0c:b0:40a:e839:a2e4 with SMTP id e9e14a558f8ab-40ae839a49bmr89695045ab.30.1757430671708;
        Tue, 09 Sep 2025 08:11:11 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-51010a3aaa4sm8372222173.7.2025.09.09.08.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:11:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Denis Efremov <efremov@linux.com>, 
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250908201021.439952-1-thorsten.blum@linux.dev>
References: <20250908201021.439952-1-thorsten.blum@linux.dev>
Subject: Re: [PATCH] block: floppy: Replace kmalloc() + copy_from_user()
 with memdup_user()
Message-Id: <175743067102.108760.5963545648599826112.b4-ty@kernel.dk>
Date: Tue, 09 Sep 2025 09:11:11 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 08 Sep 2025 22:10:20 +0200, Thorsten Blum wrote:
> Replace kmalloc() followed by copy_from_user() with memdup_user() to
> improve and simplify raw_cmd_copyin().
> 
> No functional changes intended.
> 
> 

Applied, thanks!

[1/1] block: floppy: Replace kmalloc() + copy_from_user() with memdup_user()
      commit: 6214cadd79c610ca903f993c7a6c46a713715e7b

Best regards,
-- 
Jens Axboe



