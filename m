Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE03D1F543D
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734531765; cv=none; b=klenzmQF3XxElhlBehfVOEE6eEezBmxNWthYs9gfJ0G4YMiUax+lpRfi4brc1ixAmxTQTFk5gqWiiKKwMdcYk9P6CbWuJQYGwZaTeET5eptuCn1Ot4aadIsncvy7HsO8X9J3iGFT7xMdwO+DH/J/6BT03Z2sWiBbrSW0mbSPvgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734531765; c=relaxed/simple;
	bh=2cCO4TPIhqj1S568UCAXFktOpIrfcOCGMJSHp79/37E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MFDUwULC5Bq0eBZoKbPs24Jl8k/Vv8RNgdhFEmQcBkpvwDqLlOMELmb2JqpyYvTwDJ73Mn9zYvPL256/j7lEKQ5oTlUZg6SrVc9sItHXepZiyM9+nE+q4ZOUzh+57Lst3XASQhVekiCImvUTshuX/JZj+GqmUi8D8GN9OmAO99M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dOtCxDfK; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dOtCxDfK"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-844e39439abso178012539f.1
        for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 06:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734531762; x=1735136562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fwaa/EgDeMA9up2TWsDbHlLa7APuFdygjy4wgwg8iAg=;
        b=dOtCxDfKkX88TBwkr+XbWIlWzsNj+EkvhG1K5cyk1ECaSGesImJfMAhwgBmImiyE+e
         H4+66NEzR5FabKlCuDbvTwvw7kA5CWQ39wp3GRAGfTMZ1uoFqYW5zdZ3YwhHymID0ptf
         ORZ7YfclziZSVUvf2x+M0xpJpU+SCEfMY1ASBmXnBzCzSchRb6O/XIyCjqhpq1rtlbPe
         G6KnFg/KKhrY/CS0OMtPndDtvrtl9etQWXbSmATI0g4rXFhfLYr3Za72Q0iJUBRcUwRM
         AYEh9urz5wqvH/PJbFz2coNjv1AlINA8mISLK3Kr/VavabotFu3z3yU/DcssuLQOBpxo
         TEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734531762; x=1735136562;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fwaa/EgDeMA9up2TWsDbHlLa7APuFdygjy4wgwg8iAg=;
        b=MNjP39PjrijHRHqPmnMOOqgmKHpDBJr5HZHpmeSIWk6ORqnQ0IbZV3uxaEqNT4Lm3Y
         F+kamjNajM4ui2cWETTTSm/huZarw1GYjGUZuBmP3WxLfGbxaUexkQeKSKFIfKjZM6CB
         Lh8Xe7fz0yKmMqQAnD0SLgCHHNu1sSAfCYfvNjXyUBtA75YDHwtljnMbPz2Pd6lMPhvA
         CKUTfsf8fy6NZs2cghxYgowKojx3aqB+3OfyFNhlQ+fkWibIfieh5kWVbefMgbXVhwRK
         zhN62lG8Ngg3G2hfc/BmlpPibpz63yrhKxfx3W8DzMhpA1JunBSv0X+V18VaK+tBCzZQ
         TvqA==
X-Forwarded-Encrypted: i=1; AJvYcCVoMP87dqjI4qIo9MXk9UBU1ns9wKaWTKIEaq0m9Yv381P8H+zeHLYiM5kTva5EBpbhMYB0nE8Pyor5rw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOh3sX2HTLKP0Jt90EicaB/dPjWnro2F9Y0Pkb64TW/nd+PXa7
	fZZnjTfiFOOYtg6vw44zTwbZqtWNa4m0GgTyKSU2Bipw98Zd6iyBu2zXQ0spIS0=
X-Gm-Gg: ASbGncshGKgZw/p93K+6evizscElWfErCKX57vIQB3UYxb9mYb3BfwsStJG4MeDkbDC
	DpwY06fuS+z9+k1Kqdyk2nvF/a+QpwJEBrV61JHEtR0Bq0lHr6NkkMTwznAvuOYz6Ybp7jQbyLD
	iHf4Qa3YR4otvf/okNli4gzYfUCgXSTiRtVkshbepKu8McqW3jIHIEieEmADsk78mhB57UoCGum
	VqRk4DYn6lw7z1tlF03iKiK+nU2TE5OsHVwENOFSU4tjkI=
X-Google-Smtp-Source: AGHT+IG89IFUUyc3IF//BxitryJKyat/xuxYfF6x/T3Q0v8wGvopf45eNMGXg+AVFNkeeO+fDQ1W/A==
X-Received: by 2002:a05:6602:14d1:b0:847:51e2:eac with SMTP id ca18e2360f4ac-8475855c0b2mr288106139f.7.1734531762581;
        Wed, 18 Dec 2024 06:22:42 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844f62583ebsm231384539f.11.2024.12.18.06.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 06:22:41 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, hare@suse.de, kbusch@kernel.org, sagi@grimberg.me, 
 linux-nvme@lists.infradead.org, willy@infradead.org, dave@stgolabs.net, 
 david@fromorbit.com, djwong@kernel.org, 
 Luis Chamberlain <mcgrof@kernel.org>
Cc: john.g.garry@oracle.com, ritesh.list@gmail.com, 
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-mm@kvack.org, linux-block@vger.kernel.org, gost.dev@samsung.com, 
 p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
In-Reply-To: <20241218020212.3657139-1-mcgrof@kernel.org>
References: <20241218020212.3657139-1-mcgrof@kernel.org>
Subject: Re: [PATCH 0/2] block size limit cleanups
Message-Id: <173453176105.594208.15853494245370355166.b4-ty@kernel.dk>
Date: Wed, 18 Dec 2024 07:22:41 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Tue, 17 Dec 2024 18:02:10 -0800, Luis Chamberlain wrote:
> This spins off two change which introduces no functional changes from the
> bs > ps block device patch series [0]. These are just cleanups.
> 
> [0] https://lkml.kernel.org/r/20241214031050.1337920-1-mcgrof@kernel.org
> 
> Luis Chamberlain (2):
>   block/bdev: use helper for max block size check
>   nvme: use blk_validate_block_size() for max LBA check
> 
> [...]

Applied, thanks!

[1/2] block/bdev: use helper for max block size check
      commit: 26fff8a4432ffd03409346b7dae1e1a2c5318b7c
[2/2] nvme: use blk_validate_block_size() for max LBA check
      commit: 51588b1b77b65cd0fb3440f78f37bef7178a2715

Best regards,
-- 
Jens Axboe



