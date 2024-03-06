Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6101353E8
	for <linux-block@vger.kernel.org>; Wed,  6 Mar 2024 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739322; cv=none; b=uPp5/65egpqPXcXzz8C7lY8iNOLSy9lh/2jm7vzsd63gj7ZXS2nV31g3fPY0wJHZ5O7pb1zDKTF0/9GFvlXjSVn9oRHixLfFwsFvNyN1vFbRzaS00BLHwqKXsiSCFP5wZLeZ/MDEt69iEFF4AEUMo+4+dDRty7F3CaAHilJeYlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739322; c=relaxed/simple;
	bh=/42T7teKnYAjF7gcXT8nenhwMz8CKK+bqZoZ5fECbnY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jNA6kAzpxDzgsYxK/PbB9vg9nNwt1TRwqKFYI7zVbb0wqE676l/h5dQ5N1Oo1RpkxN2MAIiWQMkNXCKg+yVoPDI8mBsicaLzcva4bmvUqBhVgWUJEExHdyWZ44QvY1jKTE+fXSnDtlKuJ8oPM4TvItnLuZJGyO8gyu5uaqzcWww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HdDF7EE6; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HdDF7EE6"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-366005db3bbso88825ab.1
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2024 07:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709739320; x=1710344120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugl7hQ7dxIuc10ZgZC0LVwQl8WAeXbzZsKqdDCAqzX0=;
        b=HdDF7EE6pVa36hF49k+sRg2ZQhcdcqp5frJjgcXGwqOjjAT/ZkLaBcwECvp1zSJD2R
         KdcTzigpwd1jw4l1FOU5D/LvDFcObKrGd4gVF0oafMeWmvh9CQGBmcOyfYvRhNXSglY0
         p/xgBR03HjIy8Gtd6qLcWFzNr3uZugh/QjLCw7H6NYEIdJSHdYROU9QSIrzaF+5MJbgZ
         C4yF+q058djZyVKE06N+UghnKzvvk7fn9VQIB9jllwoA+evy+mUMI83Kw0CI09znc2VZ
         ylMLH8FuVoWgDIfF52tUrC7H4QoDcXHszHgIYqLFKM6ne6yJUBBpho89Cl+bRtuRvgjY
         kucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709739320; x=1710344120;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugl7hQ7dxIuc10ZgZC0LVwQl8WAeXbzZsKqdDCAqzX0=;
        b=dG58Ucm23HobGTvb2y9LXoq3NIjHADcPk7yLZSD4ZrlFu7/qVCIOes6rQc1O8MFOwG
         gx/3K6/3XmzMYLXChHj9jrTDKAFmP3vOHfqARE6uIrhgPZhLTBGSH78301vnN4qb40rX
         D9X8Mp8YqEQuZvm03YajffMM49bdV3oSr5aG3Q4WQYpC/wgyAeebsoZ5tcNk0WwI4cwY
         kXocxE/83YZvK4QRUQlLpBbfHQ9uaGScMAw0s+G67tDqU0pNx+yc86Tsd//TE/F9Su7Z
         H5QKcwdsOQ1x8ebroqVjBez4YrZaPoccXPVAQEvybZ/16IUp7aElMdU2PCO6FmEi2l2T
         ekfA==
X-Gm-Message-State: AOJu0YxERQGzT7/C20EGeR/gcqTWAey4pMP1WOqJIF5ktxqReYJvv1Rr
	bJiKCAO2+sT2JLCVHE0tGjNvvpfBH6GhudqFasQr9p+ZTIwxdzyWzUNNhlqDpsY=
X-Google-Smtp-Source: AGHT+IHNN9/hZNpGt+f6tkfdNK5OXE1aLfuZGKCuxtNGQ4QFSKxvpLVH72xvdiZO8SOrNXdtgB2J7g==
X-Received: by 2002:a05:6e02:1d1e:b0:365:2bd4:2f74 with SMTP id i30-20020a056e021d1e00b003652bd42f74mr4202384ila.0.1709739320415;
        Wed, 06 Mar 2024 07:35:20 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t2-20020a92cc42000000b003660612cf73sm324467ilq.49.2024.03.06.07.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 07:35:19 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Stefan Haberland <sth@linux.ibm.com>, 
 Jan Hoeppner <hoeppner@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20240228133742.806274-1-hch@lst.de>
References: <20240228133742.806274-1-hch@lst.de>
Subject: Re: convert dasd to the atomic queue limits update API v2
Message-Id: <170973931869.23995.8429422816795215869.b4-ty@kernel.dk>
Date: Wed, 06 Mar 2024 08:35:18 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 28 Feb 2024 05:37:39 -0800, Christoph Hellwig wrote:
> this series against the block/for-6.9 tree converts dasd to the new atomic
> queue limits update API.  It is compile tested only as I don't have any
> s390 hardware.  If this is fine with you it would be great to merge it
> through Jens' tree with your ACKs
> 
> Changes since v1:
> 
> [...]

Applied, thanks!

[1/3] dasd: cleamup dasd_state_basic_to_ready
      commit: 41463f2dfde2824a817789d635be8111cff463f5
[2/3] dasd: move queue setup to common code
      commit: 0127a47f58c6bb7b54386960ee66864b937269eb
[3/3] dasd: use the atomic queue limits API
      commit: fde07a4d74e3b511105e0b6c9372d42376fbbecb

Best regards,
-- 
Jens Axboe



