Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3C8238140
	for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115639; cv=none; b=VagLpvIiokLCHghCEe4SDTsYCvPc5XGVKVTkXjMMj8A4upn6Gl2ItlebcUc8YcBpar4C1PeqhVaPYCS+KI32HbO8/6lK8zwf18cu900/Xpcn2mJ8nkp9/AijJ7DiyIeRva9eCoC070H0OjccFqxir+sX2oryfBt7PXH6Asx/vfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115639; c=relaxed/simple;
	bh=6wLJteYne2ghlIdmMqTe6B8rmaVmJKXducM1/MAnUCw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TMro8jWaGdyZxeGMPh3qG7+VDtUyAlKzZNRIGInyNrd5J6S426huAaJFKyJ/Nha8K7Fm4H88WJdaTglvOOjIsBA5eiOcxfjoNojptM7Vj2c071Hz9EbZema5AF185iTqXkJIKpsEegu5VzsSwT8JHKOXZbZgtDHF9HcEZcccWmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=c71t9RuH; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="c71t9RuH"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-4242bb21f19so1042645ab.1
        for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 06:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758115636; x=1758720436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncgUhfqmU/yAI6cRRY9SdCcq0O3qaKYavijv88BflA8=;
        b=c71t9RuHAdu7qpsjYk1VazBtM4tg2qudvQda6pRGaccWbslOqEDDNtOlCcgVNQybZ/
         UQgpqFjcq9ysB5s0fJlxWZnc0kEF9rbAgC/9g72F6SeN0H2KHx76MmQvpUCtuBmpKnGq
         6LK316P0w9+PfPmFeP5JtydevNnWBgdqphiHtSGtNXiJGvqcpgjo3Jv2jWzsmurEXmXf
         3H6S+PZEHDJDI1tgxE6M0CiVbaZ/2ExPMaTlsZNUH4mOc/r0FbPXiK0xekCYTPWHwi15
         P06ndNXGbbgRwdi23TKZ1SWuogi0xiDRJdNcvkEl5Pbsg49qPyvMXcfGyFeXUfkTK4XB
         EuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758115636; x=1758720436;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncgUhfqmU/yAI6cRRY9SdCcq0O3qaKYavijv88BflA8=;
        b=SzbDpjJGFxjLyAQ0P4tpjF0VT1FcHVQY3dykwH/dgdXT6KGy/T6nzr7X98AypRBQoY
         nNo8myNGyyGFdYKeHi0pWKh9Ipk2b6HCAVvVx0H/OdqW5H0pVQgkJaphoZOzFduu641l
         oig3TlUtE7PTr43rPpWflHuqeNRJthTlOvIlqOZD6OB3mTRGdhv6kNEegEEitmNhqYyS
         vP9ri0/ZqyTA5jNRQYQO3krk+5f1L8BoeBrFW6QjgmVoAi9b9HqCnx3BAzaCCnhRN+hm
         1TRBa0npHLlXxWBlIsj70/pWwoU2SEaPzbGvyT65V+bUDuLkjFUMQjXZyuxDD+Za0R6l
         idWQ==
X-Gm-Message-State: AOJu0YyTYPLZlQ1AhXSxkWrEf9xybd0vnMKyEUmcG1oh+mMOzfiDg631
	6gV5+5RoJJ+txtazqinuy+5vnUHcNDqn8PP2vJ1kI2+2LBM4CsesZOo9M0CDlx/0Tb8=
X-Gm-Gg: ASbGncscT5y2RzshVdsM7wen48/Km+PlMu1LHhIpeFzBmLFWs8/t0dF5RHxJbrQInz+
	3AmvuXy9LmlKUjyfTqcbHTpZNCGzG0/6gs6h2+T3/9VA3jXRZCYjIlaGfHLl31BQl762ERdiFl9
	/IR3nTzeJsiZVktZHv2Kx5AeJK0pp9kSkl/JNVzcHWQ/djLqJVQRlb69RNg8j73YBWJyKLl6TF+
	m3E3shM57RmXK+3w63c70SEdoXbHiS4ksaAcsKovqaqadKphg54b5zXGJQIiiPE0B2zNiisqcWK
	PO3xC7VdFtQ/4QrhofLgv/IXVxqtQ8xPiFeMXfVcHKL8/qCQV7Zgfa/fTNqJODvWGNXGbHjiA7Q
	Qiwb9J+vVhBBqUA==
X-Google-Smtp-Source: AGHT+IF2IhkVvtdK0/Rt+fwNJ2jA+lP5SvNESzECuU5V5/QO+3CYjVCl2QHwT1P2sqjxSjffG4Qxew==
X-Received: by 2002:a05:6e02:1845:b0:405:b792:32dd with SMTP id e9e14a558f8ab-4241a53809cmr24674285ab.16.1758115635359;
        Wed, 17 Sep 2025 06:27:15 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-511f3067a7bsm6934549173.44.2025.09.17.06.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 06:27:15 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 Christoph Hellwig <hch@infradead.org>, Ming Lei <ming.lei@redhat.com>, 
 John Garry <john.g.garry@oracle.com>
In-Reply-To: <20250916204044.4095532-1-bvanassche@acm.org>
References: <20250916204044.4095532-1-bvanassche@acm.org>
Subject: Re: [PATCH] blk-mq: Fix the blk_mq_tagset_busy_iter()
 documentation
Message-Id: <175811563473.366965.7135061887872837432.b4-ty@kernel.dk>
Date: Wed, 17 Sep 2025 07:27:14 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 16 Sep 2025 13:40:43 -0700, Bart Van Assche wrote:
> Commit 2dd6532e9591 ("blk-mq: Drop 'reserved' arg of busy_tag_iter_fn")
> removed the 'reserved' argument from tag iteration callback functions.
> Bring the blk_mq_tagset_busy_iter() documentation in sync with that
> change.
> 
> 

Applied, thanks!

[1/1] blk-mq: Fix the blk_mq_tagset_busy_iter() documentation
      commit: 0b507305a08c134722f363de6fe6f1ba84e313b7

Best regards,
-- 
Jens Axboe



