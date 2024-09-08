Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1566116BE2D
	for <linux-block@vger.kernel.org>; Sun,  8 Sep 2024 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725807411; cv=none; b=qZm9hHYmCASSjslJszgGYfJy/EvE9EQ3AQnIlBhDHSohTws2Unu8b+HH48zZipw7ehghNw1dz5jR9yl9jm2DXvo41wS12el0ADr6ujLcGvZW/T4mDwAUxsBCBnfr153WDTUS9lSxIswg2FiP5DLm0Y/mJTiDeG681+A4Y8KY1YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725807411; c=relaxed/simple;
	bh=gj7bb7SJX5rL+hy9m0Uae5pb7Iz+mG4IdH2GHeYE5B4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lHPLPxjPsY9eHiXcARRD5oe8ByL1qL5eMrEuJkM3nH8M2tioDI1E3mSDku4+CflpShRuyQlfL7U9gjvMybUZyJnlUAWMArdkJ+hY6vIxyJZm2t8ydvWm0FU/QK+Rljr2uSHZLp1zCMh/4w374iKgsI6ZcbmuSUJ+Y8Nn0l3yLO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=N0uMopeZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="N0uMopeZ"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-201d5af11a4so35438445ad.3
        for <linux-block@vger.kernel.org>; Sun, 08 Sep 2024 07:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725807407; x=1726412207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lg+u2OwY8qEhGEiX0X0SwLVFMX4Ul5s8cmDp0Oo4fsw=;
        b=N0uMopeZgSQqoIwiZi9rO9Y9zIz1asE+S7tpu8TLFrNpHNHYFAFC+pa8GCZzl6vFVJ
         NrUIHD67Q9QMPOZ7yXwCz2f0/v7Puwg+BqBUfpol7hqSnDYK/tz7DXR6fCDi99WYyIIG
         ZgHdAt3Ekv/b9lXhEaqFrI+ezg5I/Zp6nubEBKrO8BeyJ7gtIGRDmLRhAGbUVRLM6ZxL
         maM3zjpz5JXxTNPKy6fAb+8aOdUCS9xykLtdVMlG22sOluOs3Q6PDUPA6IZVybAeLZnK
         VBlJ+y6nygnw1K9K0D3LCs71WXC+mrNEZhkD3UkvWHdjrruvBIMsQPQjCgXIx44NjZpr
         t63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725807407; x=1726412207;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lg+u2OwY8qEhGEiX0X0SwLVFMX4Ul5s8cmDp0Oo4fsw=;
        b=aUKpZuARfuZ7zZAq4NBEJ5a4gYAL7VRJ80RS+k7VqNk/ONPthqZ5W/ikPI8KnCZY7i
         DnVIz5p+sXcGnMGWt2KZEY9lXc7StHtD5WEdJbSehmBD8wxJFmBlR16GZoAAWZOhLQpP
         dc5E6/nJC3xR14vRJehHYrmjLV9QzA8URnwzwVtfB97x7N0GQj/IJOxnVTTjRiZimJyy
         OtoJeMkqojfW6w7EclTHW1+Z5Aepc7cZ4ZAwCro7Pof61mlm6PO6gjxNmhQiS+y/9yAq
         kUWEb7FS/bi4zqECehI5BUwjnqatgcJsX8Sv+0S8VDZfZz/BPXHq5xQha6OcSJkcjHDe
         9RKw==
X-Gm-Message-State: AOJu0YxtGf6Gmz4UB0by/J4dTLudfR0GpObKJDNXZ2h7IUhKC4AyRo1d
	bFutsQK/Vn9G2mwnoIjsRz2ffC7m9SHRAMPu/Y6mbASEBMwk/zlcJ2KstsZt9Q9Hjk4gqhgkvPE
	K
X-Google-Smtp-Source: AGHT+IHivU0RZPlm25kL+zspgueyi0VwFtERukXLB1xicb6yfy2lBB/D8ucTny6ekbrszjK5jCprLA==
X-Received: by 2002:a17:902:e805:b0:206:c798:3cd8 with SMTP id d9443c01a7336-206f0624258mr106711115ad.54.1725807407499;
        Sun, 08 Sep 2024 07:56:47 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e0f6f5sm20951925ad.11.2024.09.08.07.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 07:56:46 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Keith Busch <kbusch@meta.com>
Cc: Keith Busch <kbusch@kernel.org>
In-Reply-To: <20240906194540.3719642-1-kbusch@meta.com>
References: <20240906194540.3719642-1-kbusch@meta.com>
Subject: Re: [PATCH] blk-mq: add missing unplug trace event
Message-Id: <172580740577.254205.6859138568079413429.b4-ty@kernel.dk>
Date: Sun, 08 Sep 2024 08:56:45 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Fri, 06 Sep 2024 12:45:40 -0700, Keith Busch wrote:
> The single-queue optimized list flush doesn't have an unplug trace event
> to pair with the plug event. Add one.
> 
> In the unlikely event an error occurs and falls back to the less
> optimized plug flush path, it's possible a 2nd unplug trace event will
> be logged, but it will show the remainig count that weren't previously
> handled.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: add missing unplug trace event
      commit: acc8c0a9887558966295e3c0881e633154c239a9

Best regards,
-- 
Jens Axboe



