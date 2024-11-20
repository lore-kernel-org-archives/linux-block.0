Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19159BA4B
	for <linux-block@vger.kernel.org>; Wed, 20 Nov 2024 02:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732068447; cv=none; b=PWUI2QumFlWBHug2uAA+hYBpAv5aPjffqu1tu7SD03aC4xpBhr/KxOwKBf3HqW0DItDw5DfdOLTu1mGnDT/uZ4/BBjrHjklAs4BjffsJ0v6P+iql0bkDyOs5iD4kOm7SXWd85xPuqq5CK41X6Y9SYZHrFvotqGXUhKY/tTOhXxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732068447; c=relaxed/simple;
	bh=cnuOZ4I6nJiKT+9qHzZL+8BBhcFooy7D+U7xPUczsUw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ALfBn2naYH/+S+z4QqRDAJ4aAah0bPCS5wK4t5EfDe2S4FKcpSDL2uLY07x2GhHMdzk/d5CN/hIorRWuc4wVdhRlSjU5tlwSStc+eDdlU8hVI8+HTYr2SWEAfP/7LwCnYnYDbK087oPk12MHwH4EX8fhrCmv88ad3rkdU8yhCyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rxas4IZV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rxas4IZV"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2124a86f4cbso15794295ad.3
        for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 18:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732068445; x=1732673245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOma6Qw+5Vl3kma7cADksOH8uvYJlvMAtxDVDkB6KEY=;
        b=rxas4IZVtVTphBtks/2TIcNrk28yFSaBVLQe7zmQUyjHB6PljxcvgmMI+aIIw+MY2C
         lDtJcu80MSr5Lee7yXRpTqgoCcJA9XAeHYCKoCaIuUXKEJ4CyVrIL4qoFCovJktkhSeH
         PstVqzslSOpNhibv00MUxhCR8/goz8gOu010pa7klmx5o+9T3geV01tJCkxlgPTwPebQ
         0UVwrRVogVx7EfQv7O1QQE3Zzv0Cn/Q90P9ksajMf+rSCDOsIM99T+1ts+nyd/XWG6XP
         xM0+lxYrMyNJ+D+4Gn0wlTAdhpN2BrPRuEU/KUdiIfr5EtxzcvZuvWc7Cco/NFb7YjHd
         FXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732068445; x=1732673245;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOma6Qw+5Vl3kma7cADksOH8uvYJlvMAtxDVDkB6KEY=;
        b=gRpLmLIv8k1FEiUDWEAfggqPkdeAagnePhhqLUJpjQwK4NdbJNoILINxMp1zSd4NqV
         43PCBl1hGLPGKEc3PM0VWLhHCaak3iQ2pYUNnmhKdW3I0S/yAMFHX/bn0/NXInPyvOAV
         /Htn3XmQzCVGoTnouFmt84CRm8khdHWWag2947JtoORAEDjqzsvIl3d86IFi39kXe9ZV
         so5tmW2AWCnAvmiB/AWNDhI5PlJvVFuLC1dyAgROFsA28htPgZ/9kNv3TVfDNFIUy961
         z+tk5slLYie2ge4dHmoyDXrSSXDqgYNHG/8pe81aHLEpbJGaPlbsqLr+E3qG2oIJ4JVj
         qdxQ==
X-Gm-Message-State: AOJu0YwvJ76JUTMrWUg8/0bqClbn7eLX4r8VuSMBk95Lv54WE7pA7L46
	eVUeMT9kNFFDffdKUW5Peo5gBgZUdtZ0YDPGrjf1dxYGxxYn8UrH0/yr7PSshb7dRsb7MERSeik
	5Iy4=
X-Google-Smtp-Source: AGHT+IHU6ITQGmg7vC8XsAqWIF7ZgEFFgQHg6y+2n6XbdOL0iTJVaebs6cIjot9fgFS0+AN7xjWksw==
X-Received: by 2002:a17:902:c94c:b0:20b:b93f:300a with SMTP id d9443c01a7336-2126a33eed9mr15055665ad.7.1732068445282;
        Tue, 19 Nov 2024 18:07:25 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21270d53ab1sm798625ad.258.2024.11.19.18.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 18:07:24 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20241119161157.1328171-1-hch@lst.de>
References: <20241119161157.1328171-1-hch@lst.de>
Subject: Re: clean up bio merge conditions
Message-Id: <173206844429.184430.25307778854244672.b4-ty@kernel.dk>
Date: Tue, 19 Nov 2024 19:07:24 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Tue, 19 Nov 2024 17:11:49 +0100, Christoph Hellwig wrote:
> Dan's smatch run pointed out that there is no need to check for a NULL
> req->bio in the merge bio into request and request merge helpers
> because they can't ever be reached by flush or passthrough requests.
> 
> While validing that I also found a few other odd bits directly next
> to it, so this two-patch series fixes all of that.
> 
> [...]

Applied, thanks!

[1/2] block: don't bother checking the data direction for merges
      commit: 9f8d68283342a48f692f2c02231318bb4a7b207f
[2/2] block: req->bio is always set in the merge code
      commit: 81314bfbde9d089fa2318adba54891dfaadb1c05

Best regards,
-- 
Jens Axboe



