Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5D818FDAB
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 01:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744853626; cv=none; b=gvfKjQQusWEVKholf5i3SppI4BAdO2keQZry/7J7e7k04YHFqY8oIWPOCAE6dhgMrfbf4+ahpYdUTExzNm7PJ8sIFe4CdDZSkupqmuebxFSRaQ7vmjnhbvMGHNHAFmCts08desgRrPxkzSmwBk9J4BuKXx2/EBkGPA8rczRCMp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744853626; c=relaxed/simple;
	bh=oU6ngNnkAwQGdS++jwKyRlJAq153BtDInEERFIy7bBI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c4zYJzsGyHYi753EjTdr4rj5qUlxYKT1OxIjNnbsDKoqAcvUkD2DB/7rEOfVjEcoA3vsFyi8CB5lBbm3Xlr5o0xTcR93hIxrBU1J3cuVZC4aLSeDlwBFwL2RPA76hufc+0sPlDQ5ZVR63LnjbnKoJmgYTaxwNjg/N1qOhR8yyCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fzVKRXcH; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fzVKRXcH"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-8616987c261so8454739f.3
        for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 18:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744853622; x=1745458422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBH+E77P4o6YKMaqBWYxiMqd3Ph7K3lMOstE/KOvA00=;
        b=fzVKRXcHrnqMs+C1QFbkR59fOcPhcm+YA4Wap9BsvU+xALkPTXn0dFSad7LlW2enGt
         MRC/pb2XWLIYUaosfeGCEdh1T5QahbPhsWFqBiwUE9zP6pvyp0XCwSoqTRBnAZ2L87Vx
         A4tvFv4LPGgP2Qyg3Bwx7b9yaNZunMzG0HHSE2NA9DPKBIb+VM0QSWnO/Bu++S2YvP4V
         HG7uRgWf/V/cVu6LXy5fPPzlXwlOjp8JJawoRcxaRD2wc1TOkQZkF7JywPKj1QHtC57E
         dMD1YYRfv5whPKujjZeUmIOE3SmYv5ESBw2gX9Fs9Y4v3h3+sd6CPL49+0u01QH3cPN6
         zGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744853622; x=1745458422;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBH+E77P4o6YKMaqBWYxiMqd3Ph7K3lMOstE/KOvA00=;
        b=vX9OPpZWSjXJtvXEmRZx4Bq7QmJggolpO4BNhXMcjDAl9PHsWLl6DYpvjdrlzYCxrc
         howM5mY31C9xeP2+/mJJFaBPTayn3fXXtjMPQLEf3gqiYZAHO2lhMp29/dDicpmY6Cov
         bbzAO56wP7CUPgBv24smbmOB4dNXlhSvbTm4CAqgRxuNdDyOM7rHrxizlwuVehvtDOHu
         cj2BTn4TWRlhxXwhmk9YQfhLC26hR5lNCdG1nKcMQ3eviF6yyAtMipbE/5A+UkuUqzcp
         rQ4L5gttjTfflOI56vlCROLL/Fnb3IRWtGfHUxnLH9ucTqlqurTJQTWtdle7DblPuIuQ
         SzwQ==
X-Gm-Message-State: AOJu0YyZPDya398sDuDD2Ck+5AwDBYmclqE/1LswBW3Bb4npqM7ZIVOw
	2CcJvKBQ1YEzdX15dWmj/jdW//eFoMY6e9W7Z7iRs60CBqI2iFLMA2ouwfdaKD0=
X-Gm-Gg: ASbGnct1kVfCt6ev7g8luZH2N8L2KS0Nj7N8mMdl3AbgOr7kPaqUgbcnyVF4OP40Qu6
	valcf1LD78iR4GoKm0bqMgA0WQboxY5uMIoAphXyGZpWQhXiyLpaHrfhQ6zqcQMvbRjvlqUBNfx
	YnkQOdAaDukmlYy/Leqf5mQ9n24gV8vhcI+DUp98fX2wNnkgbyVnJ6uxljDfbZ28BEHKlyjdnQ1
	PUVdv876aqSizq562jYq3SbV3I5Y+rJjinc8fpVGXSf2AsGNsCSU76fiRnIJHi9uEb3Geb/CJBM
	vuQYMIX7eI6y4u9AN+BQkw2BnLMKLFo1
X-Google-Smtp-Source: AGHT+IH8zg+D+WLSAmc9eisDyH1exKeNxLyQ5mH93Wcns5jEF+K5EubMZyFS5b8ZZRSGpN9+pz5k3Q==
X-Received: by 2002:a05:6e02:1905:b0:3d0:21aa:a752 with SMTP id e9e14a558f8ab-3d815af7f23mr40218415ab.2.1744853622224;
        Wed, 16 Apr 2025 18:33:42 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505cf8294sm3877562173.17.2025.04.16.18.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 18:33:41 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>
In-Reply-To: <20250416035444.99569-1-ming.lei@redhat.com>
References: <20250416035444.99569-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2 0/8] ublk: simplify & improve IO canceling
Message-Id: <174485362142.496169.9833775455671712927.b4-ty@kernel.dk>
Date: Wed, 16 Apr 2025 19:33:41 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 16 Apr 2025 11:54:34 +0800, Ming Lei wrote:
> Patch 1st ~ 7th simplifies & improves IO canceling when ublk server daemon
> is exiting by taking two stage canceling:
> 
> - canceling active uring_cmd from its cancel function
> 
> - move inflight requests aborting into ublk char device release handler
> 
> [...]

Applied, thanks!

[1/8] ublk: properly serialize all FETCH_REQs
      commit: b69b8edfb27dfa563cd53f590ec42b481f9eb174
[2/8] ublk: add ublk_force_abort_dev()
      commit: 00b3b0d7cb454d614117c93f33351cdcd20b5b93
[3/8] ublk: rely on ->canceling for dealing with ublk_nosrv_dev_should_queue_io
      commit: 7e26cb69c5e62152a6f05a2ae23605a983a8ef31
[4/8] ublk: move device reset into ublk_ch_release()
      commit: 728cbac5fe219d3b8a21a0688a08f2b7f8aeda2b
[5/8] ublk: improve detection and handling of ublk server exit
      commit: 82a8a30c581bbbe653d33c6ce2ef67e3072c7f12
[6/8] ublk: remove __ublk_quiesce_dev()
      commit: 736b005b413a172670711ee17cab3c8ccab83223
[7/8] ublk: simplify aborting ublk request
      commit: e63d2228ef831af36f963b3ab8604160cfff84c1
[8/8] selftests: ublk: add generic_06 for covering fault inject
      commit: 81586652bb1f6c797159161db8d59c18d66b9eb3

Best regards,
-- 
Jens Axboe



