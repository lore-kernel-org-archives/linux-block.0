Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E73E280CE0
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869459; cv=none; b=Q1B9gcGKxI2R1anB17uwee4H/leRpdhMuP6ipVP/9NTZMGlgdrNF7t5OUwdt+bbcBtP1WVHayTKGNKydXlm/JOTuxnKcezU0VxBad2RulPdZeDG+KoFlZhnCEWu2pvmdXFkl0zVJEW1hBDh4OcEo4ljF8Sk+hJpPV+nOGAP36fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869459; c=relaxed/simple;
	bh=zNzBR/wZgvBggmWQ/khF4OFSadbAA0TH9VheG6vvXsI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AnHG1Map9xg2bSZkxdKdg0B+JhOLucOj74ODPPw9J/87FC4zpujQYy4aUEZbL5O09Jljgfm00o0Cj5HEbJBP7tQpe6CPxfKoq8t0MWWh+fqUwiXOGNcoKgFCAHaP3B34n7PuXJ6eCIu/YXUxGiA3Ro2hwnVSbLA2YrJ03s9aeG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Bv3B+j7q; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Bv3B+j7q"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b2fd091f826so121393a12.1
        for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 09:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1750869456; x=1751474256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMwMCyth2Egg/1nTuhCUVlgm1lii2/x1O3UKYqxEFzk=;
        b=Bv3B+j7qpdJTPRa8SgVj2KWg2RYTTyVlOk9KYCt0kw0V3+rtYLpHzuObT9xV+nMCFE
         CPhGIpcFnj6IBLuRMfktb/1G1HxrgbsgX5x0faNT8S0j6Iaf3u9XC875z5+U8SduahI1
         Wvgde+kHae044buXCq05zDAlblbvgeoWcOhkfo6GRyyBQywI+zvYgABvelV5sXi3dIKM
         SvjGOoSSs2MKkw1t7/6rjrTqmMd2Ac2w4zQM8TL/IRafzSoMtKKRCJkAiE7mu9rbV+7Q
         TybcOTaFHSOpWL8V3Ve8jWGEbmfPaL4xDgrksFOIqIBpReQPI77chN23+rSZkEl2FqoX
         nYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750869456; x=1751474256;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMwMCyth2Egg/1nTuhCUVlgm1lii2/x1O3UKYqxEFzk=;
        b=d1d/Xc7+IW/DB0yDo/9VlITknaiczKmJTAUXcOHbMqN1pxCBYPjUUBmGzd5k1vlA5W
         jw2WqOPAXigHFir71e4heirEWD+lw18i6Tx8xCT6phputkLnm7riGzaq57+YCcP8niAA
         0HZd0HuF15WfTMbmFn71SV0ZGGgczl31JYcpHwC0K0ZQNY4CJ3xjXe35aGzmAg6rbpvn
         P2EQ85f0vdOXEHc62CAjK/d0xzJsG1mE+5uXz+/Ck1jVUEbSZbDoElulMmqHvvoMbXbc
         EV/Zm+751qdKrVIs5g1NBGrqCDPcg5ABWzPABUIffx09uvysM1iJNBTDlc2TG1naUakW
         HFBg==
X-Gm-Message-State: AOJu0Ywso385WOM1iXp+AeMBxkPkDc2IxICTZs7AJwnErSjhgK6RDfNf
	750ZOJqjA44UucmU9xyUKUWZ0Vs1i44tuW15McWBCLqJiLArDtffia+56bPMnsYq0I3pdwxZiUP
	GBMji
X-Gm-Gg: ASbGncvewgKvEkZaIfZ8QqQlfzKJ7e7ogVueaJnJOwrzWmiEq673npQClEIqqe82jww
	RqUC3zGY/T1YIjyqhphxOBlIwwIZaLVgIchy8TB1XncOjNsutitiZIo7LSLXNVBVBytZ+2xPWmg
	57ew5hBMdGTjemLAMecrtuv3jBXygKtOHlaXejt/7MCqbQa3aimzLGbGdxA3Ns3ZeigYApacdi+
	RLW3slomFhzgqbtkebVycyx+fadbnOpKvwSjS5siKeDTKTjm93GxaxdXhxbYo3+N8ZKtktkOete
	rLSa9BV7TlB1mk5kE4hZ+uTkErcm+2nEIHpC21vv/TeU2qm4d8yRSg==
X-Google-Smtp-Source: AGHT+IHKOBchkezkuA+yfLjfRpwjTNZtL5mBB+DBwdFO61OhOjFAEdtxhj2u3PMvrGVSnuNB6Jh+VA==
X-Received: by 2002:a17:903:23c3:b0:236:8b70:191b with SMTP id d9443c01a7336-238c8755cd0mr3022235ad.0.1750869456370;
        Wed, 25 Jun 2025 09:37:36 -0700 (PDT)
Received: from [127.0.0.1] ([12.48.65.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d81fbcb2sm134519865ad.0.2025.06.25.09.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 09:37:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
 Damien Le Moal <dlemoal@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250625093327.548866-1-dlemoal@kernel.org>
References: <20250625093327.548866-1-dlemoal@kernel.org>
Subject: Re: [PATCH v3 0/5] Fix write operation handling for zoned DM
 devices
Message-Id: <175086945525.168912.13714943214288580323.b4-ty@kernel.dk>
Date: Wed, 25 Jun 2025 10:37:35 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Wed, 25 Jun 2025 18:33:22 +0900, Damien Le Moal wrote:
> Jens, Mike, Mikulas,
> 
> Any zoned DM device using target drivers that internally split BIOs
> using dm_accept_partial_bio() can cause deadlocks with concurrent queue
> freeze operations. Furthermore, target splitting write operations used
> to emulate zone append requests break the emulation. This patch series
> addresses both issues by forcing DM to split BIOs to the DM device
> limits before passing the BIOs to the target map() function, and by
> avoiding calls to dm_accept_partial_bio() for Zoned DM targets that use
> zone append emulation.
> 
> [...]

Applied, thanks!

[1/5] block: Make REQ_OP_ZONE_FINISH a write operation
      commit: 24cb7af081023bbb7a25ae514e6e2b398d4ab25c
[2/5] block: Introduce bio_needs_zone_write_plugging()
      commit: bf7a8b5cbbb2d531f3336be2186af0c5590d157c
[3/5] dm: Always split write BIOs to zoned device limits
      commit: 74e93dbcd320a8e9d5f7b3f238eedc7da6d6ca7e
[4/5] dm: dm-crypt: Do not partially accept write BIOs with zoned targets
      commit: 0277a0d91194b79b4a3db0c53ba205a933554695
[5/5] dm: Check for forbidden splitting of zone write operations
      commit: e04a33a18fdb259d7ad3673ddfce6112f5ce30fd

Best regards,
-- 
Jens Axboe



