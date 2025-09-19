Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7B731A811
	for <linux-block@vger.kernel.org>; Fri, 19 Sep 2025 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758301599; cv=none; b=Z4A257x4CnLVupn5sVRh4uitSfixMiMWDfCv1/7RGo4MIa9kiWLk0kqk0tIcyGtWZFYI40toTHo1+jdVeuWBvq0GpxP++s/P5SdgLLTFtkyxYlXpIVwBz7NU0te6jUdBrtd7K4s7TSZL87E4INSVrqEmStOByc/6dWtPqqRGYfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758301599; c=relaxed/simple;
	bh=q8hVKWTJYFegeK+gcBPDI5sNVfJB9gAyqBbqKkBR/hM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G8yr9dUt8GxKxfmqgKih0lRi7d6TqjGkPDTtExKOOmJWU0uxkPenKtKduBzNdGxM77g6Aw4wr9vdQobXmFLEO15LOyokY/JSrj26XAqvcxfHnvz+hXF9QTGYN6FwQvYmpvosjxe3piaQGZcu7Lb7HjSrFqKtcwGh0Z3wkzfhlZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dEu51Wd4; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dEu51Wd4"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-88cdb27571eso88796039f.0
        for <linux-block@vger.kernel.org>; Fri, 19 Sep 2025 10:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758301596; x=1758906396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xszZQkvWINK5WulR3oXM0DZacWHWOr6o1TKTnr/+EE=;
        b=dEu51Wd4iY0tT1PRC8AXmYSzNp3/M8jEPAX6Osol236IDICTFPF55YSrhkTm2MQIVv
         H666IJi5qpiTdbcdBgSs082G8iK0qXKiuc0mVH98lxTsrIOcmZ/aS3E6ZrTN3P7t5tps
         LDpRxtPP9zNZrRtFc82w4IEcdc3IExPt86EAaB29DbFCErqsbQEUZh7TrPDLDWgxDBGm
         YjjZhrNm0Mu7d1SXy76GFAZUu1jAXZudorY/Q/CxX0pap1u0UEwwEIAu3Hqbqd71HlpQ
         7rSYD4MDdU3TrCEjxbipzfAIXkErFV2VF2J4MEsH9TAphUtAGHI5D1k9Z3t2UcC2b6js
         vJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758301596; x=1758906396;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xszZQkvWINK5WulR3oXM0DZacWHWOr6o1TKTnr/+EE=;
        b=uA9k79/RZeVzBGhhY5KMOpcflh0cfPMYpgFdOd/L2Z4OfZrmOQsfIAj3ETZznNRm54
         PgNoMk+hR3WaBd1EVmg1Yl02GjQl3orWZkSlCsO8j84cR2IatQrBXnedK+J4X+J+1u81
         wpFH2YNAYUvLA2ybC4PuUjNHyFIt45louQSPmEEdvNbKRUc4Rc+8VPt/MuUBnJDnEYV6
         uZ3P4HhS7DFxpYl+IXT+wJbQZVysaBhQ9d0F2cHloYNbB4f0oLTdAMGIcjoFN9CNrgpO
         30g96cf8JXto7izQtExxSwlu3Qt6MguZsJn7OSGmYuGbwFfjnykTHDNoc/5H4oPaNKyu
         kMQA==
X-Gm-Message-State: AOJu0YwBzRyS2HSYJSCa7luUuAFVENNjthuMD8P5eDRQDx1Y1JWaydJK
	sdG5Hu4aZQyumDp/R01ZGrtMgV5Z/x7u2kp1TN0zodJMx61Jlhf/scmmcaPbW4yImrVrW1ihPSZ
	5siC0
X-Gm-Gg: ASbGncuSo8oVFGFNJlTPwVK5xyhfOH14g3567j5usKKN2qiprIi+haE0IKfPaUJm/6I
	5WvVnLYXBSxWTxd0Yk1SatLeaL2iQ0Gm4iaUixOOE36g3B4J+Mb6L4l81buv1SA+15mvJ3N9Co8
	oFnE+bOFX/s3m3HKDEaC9S7lsauFuDHhRqnBJ9SjXD096j0IXhMacv1J953UOhtTBAWf5NIjZaN
	4dw7R0HZp1nRK8ypyMmYqsn2Bp7uF0cIMrMj/dJ4xD+gtc720+XqbsPBwDLyb2g9pBAZI1YtrmT
	VxytFt0DBkAkyNNB8RCFezWJaYIAg5w30PbfJnB1faDlhrhRaMf67UCl8UQGQBDNxN8kStt3/Fr
	r3m9zbLuC1zHsmw==
X-Google-Smtp-Source: AGHT+IEWozrJP43M4DVIrxcb0S2DwxZPhA4LrRW0lqAN04mhddqVBixtfK+2/UInAStgyEXg1YXAIA==
X-Received: by 2002:a05:6602:164b:b0:887:3ae9:c3d9 with SMTP id ca18e2360f4ac-8adcd809f54mr646108739f.2.1758301596382;
        Fri, 19 Sep 2025 10:06:36 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8a46a68330fsm188484939f.2.2025.09.19.10.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 10:06:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Caleb Sander Mateos <csander@purestorage.com>, 
 Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Uday Shankar <ushankar@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250918-ublk_features-v2-0-77d2a3064c15@purestorage.com>
References: <20250918-ublk_features-v2-0-77d2a3064c15@purestorage.com>
Subject: Re: [PATCH v2 0/3] selftests: ublk: kublk: fix feature list
Message-Id: <175830159548.906981.4104343901277988094.b4-ty@kernel.dk>
Date: Fri, 19 Sep 2025 11:06:35 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Thu, 18 Sep 2025 13:34:06 -0600, Uday Shankar wrote:
> This patch simplifies kublk's implementation of the feature list
> command, fixes a bug where a feature was missing, and adds a test to
> ensure that similar bugs do not happen in the future.
> 
> 

Applied, thanks!

[1/3] selftests: ublk: kublk: simplify feat_map definition
      commit: 1f924cf781de47432f220185bb2beeb12c666aa1
[2/3] selftests: ublk: kublk: add UBLK_F_BUF_REG_OFF_DAEMON to feat_map
      commit: 742bcc1101bcaca92901fe3fe434e4b1a467b5e8
[3/3] selftests: ublk: add test to verify that feat_map is complete
      commit: a755da0dd0530e53aa026fd4d08b3097e1be6455

Best regards,
-- 
Jens Axboe



