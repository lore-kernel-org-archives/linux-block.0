Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7BB15EFAE
	for <linux-block@vger.kernel.org>; Tue,  7 May 2024 13:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715088752; cv=none; b=ecnDJ1OjFznOECc9sPJj9kyfvPgk/6TChpDYIsV1fSoOOgN1tyaA2nIFHE/kbbkU4hbVbQy8KwfNQt+eaVpeYdcwNQvwrTy+imqnscbawtwY+OQhw1F3fFsK01HJMV8cT4rFlYe6WpJiwPymkDneHeRz87b29LeJY6tfdSs+GBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715088752; c=relaxed/simple;
	bh=k6pSVcceaxwAAJTy4YX1HKLpF7J2HxiuW5h8z6oQNzI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MtvjjhY2TrLsFSVzMJU1AzzcSxaeTK3//2kUioPxL03iWUQ5XPrnXohVSoVoYvoA6luXZWp9HRd4fsABZ9yrjKiGEjHRHFb380VY0y83xQ53gcPQmjGX0smecz8ttdIbDSgNpqin1WrskpebjMsI3bJZZ1hlmk9AebB+Tjfti+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HqsoLqVE; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HqsoLqVE"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36c86ad15caso564105ab.2
        for <linux-block@vger.kernel.org>; Tue, 07 May 2024 06:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715088750; x=1715693550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67ULBmYkXMeSOYar0fWizuEeqwDWQyJQLFC/+ljYcKo=;
        b=HqsoLqVE2aKIou3NB0/LYHigGl4rAbFqgxqYa7QBAH4CvOljiS5xlpLxNfK5HXiRzs
         5uLbM0PgWvkvuxzzyRJc1H3ZVXJ0pKDWe1caLAe0X5Drh1W9pI3vOXA4j3FZICDaEq/6
         xZXJFgZ21Y9IB0U4WNsTQKDP0DFWEzfmLaSZyvxQTfn8o1eaJSnub/ikJWtUVhHbfeJO
         x9iB4CcaU3tjKqLqot/PeD9Tq+A7oTE+Ht/Mx2SFrUV83g8T318U8zLZPxhkvR4hsISE
         OwGGAjE8PtP+A9vP+OOqT3wsfwvmiKRSy07+n3ZgnsW3FVkYzzkzGJz6JHWT0uj0f69q
         lXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715088750; x=1715693550;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67ULBmYkXMeSOYar0fWizuEeqwDWQyJQLFC/+ljYcKo=;
        b=as2osUHQ3cCLJM1CSa51cUpImMr8+C9zVTshj4oxXBtORTCeNdMzJ7JTCT/+xzml/T
         Eh4uTe681mgWbbqavUfAeSZl0gF/lIyzPL4JEt0DXzW+SLvLj9Dkh0o3UvPxaI6+slS3
         isEEs4o9NwMvVvGlygjSCiwGxghE1K/m69MIECGUIyO12CWWalcTHaXAQnBKLzRnKJIm
         pxcP212aJkuKGe8dck+ldYX/Z5Hftvj9BuVTugbLw/n+FZmRmnTVadbP2+Q0deVykFAI
         kAQbx2wx85ky/r5ak04Xptdjl/E5rtej4kwJXKCuNf/wTw+EvDf3nJ0Pstn8igZc9q+w
         zCkw==
X-Forwarded-Encrypted: i=1; AJvYcCXkMWfl9+PorErA3gctD3+tHAvhrDJkEyt3KDlAdJg5AWYX0lRliVI/0nHDh6F1Vl/7gQ+BQ4jioh76HKbVUQpxufRnv+BAH1wTIYU=
X-Gm-Message-State: AOJu0Yx7srihQEj2vGrd4KoV4z8WMtsRdNy6C5YNPzw6pvKjDUQSRga5
	f9WptTZDh2aKhfNvC1X3079ek33kHeBQ5ETG13pejDU5SbPOZDpnK37+Nb0RS5U=
X-Google-Smtp-Source: AGHT+IFH7mjfTRiR6AQaq1lZNlqPTZWIWFPzXf9zuuVMkFfKzroGmxSiiCeBxXn5rP1xIU6p3vGXpg==
X-Received: by 2002:a5d:930d:0:b0:7de:e495:42bf with SMTP id l13-20020a5d930d000000b007dee49542bfmr6446702ion.1.1715088750557;
        Tue, 07 May 2024 06:32:30 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id kw24-20020a056638931800b00488b8c8eae9sm727626jab.104.2024.05.07.06.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 06:32:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Conrad Meyer <conradmeyer@meta.com>, 
 linux-block@vger.kernel.org
In-Reply-To: <20240506042027.2289826-2-hch@lst.de>
References: <20240506042027.2289826-1-hch@lst.de>
 <20240506042027.2289826-2-hch@lst.de>
Subject: Re: [PATCH 1/6] block: remove the discard_granularity check in
 __blkdev_issue_discard
Message-Id: <171508874935.11829.2769498627059589937.b4-ty@kernel.dk>
Date: Tue, 07 May 2024 07:32:29 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Mon, 06 May 2024 06:20:22 +0200, Christoph Hellwig wrote:
> We now set a default granularity in the queue limits API, so don't
> bother with this extra check.
> 
> 

Applied, thanks!

[1/6] block: remove the discard_granularity check in __blkdev_issue_discard
      commit: 0942592045782e76a9d52c409955c2dc313cbd30
[2/6] block: move discard checks into the ioctl handler
      commit: 30f1e724142242a453f92d90b33e030014900bf0
[3/6] block: add a bio_chain_and_submit helper
      commit: 81c2168c229bab0665e862937bb476f18cff056d
[4/6] block: add a blk_alloc_discard_bio helper
      commit: e8b4869bc78da1a71f2a2ab476caf50c1dcfeed0
[5/6] block: add a bio_await_chain helper
      commit: 0f8e9ecc4636e3abb4f3cf1ead14c94cce7dfde8
[6/6] blk-lib: check for kill signal in ioctl BLKDISCARD
      commit: 719c15a75ebf3bda3ca718fe8e0ce63d262ec7ae

Best regards,
-- 
Jens Axboe



