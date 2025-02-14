Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9BE268C68
	for <linux-block@vger.kernel.org>; Fri, 14 Feb 2025 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554198; cv=none; b=oMRe7x4OA3Ocej8UNFIxRF9hYIuwtxf9c6eeWzoinXlD8/x0Ahtgru55YqCS4sJX2HGciRILo4/KTjcngZYFlDYCcyfNlr0+FxS8XqhNktwiHeBDTb7hqesMTRdcLapVetFeL4B+YrIP5FKmNOHeSZmoVicoXjIvrSywCiEbQfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554198; c=relaxed/simple;
	bh=dkhyM7ZfY3apnmQfYhwCim57WopohRPUGYh8hB2XQM8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=GoPW+RLzCB+pCtOxVmcUgkK5Vm7kZSpuo8cywNeDy3I66Bwr30/zcoZvJba+DtWRh1H41adF8uTcaO42YbiA5qxZreJ6xViq3Qu334pYbHrgyLa14Dtjy2sZt7+jrYvMoHd8FtUzV14amh4J4kPbkibAjTIYTmmviGgMrcVcJfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cuqrvP8N; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cuqrvP8N"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d03d2bd7d2so18411145ab.0
        for <linux-block@vger.kernel.org>; Fri, 14 Feb 2025 09:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739554195; x=1740158995; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSy3IS77CALvhus79RBOB+jgwssslV5VW1Rny6qy4A8=;
        b=cuqrvP8Ndoa+agQsm7qoo5TzZz+A6r3eiccAhyrm2VE2NlJaNd2R1h7ZL4VvW/f/20
         gUQDL5REQY3K9B0JpCt/q2bWbV8L8KqPFBfAJbCEojmB3kVh9gNcj1dk2ViBa4iewTav
         0v9iBRbnLALPQ30nwOJnEgP/akOBqKnzTGvg9xw1u3uM5BkHlh2LEnJqIyU9nhMuXhI3
         Nlz1/l89OZlzimtlmyZw6LKjAnsMuMHolbLwAB6cUaSIaXrGWaOlfWz2Nhxpo7glJ87w
         /rbyl/WKhEx4Ep2n7a4qdlBK/7BvRXIbd+D0NtyPX2WlTk2RJKrlW4dgli7qtONviXAq
         kXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739554195; x=1740158995;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JSy3IS77CALvhus79RBOB+jgwssslV5VW1Rny6qy4A8=;
        b=jLhbWEuvAgFCJFjcgEBC4p4kHLlhap8t241pdAlF0jyd5lLLtXbpsfuvlMnyzbm4NL
         EukuQKdHimKNvFA18HHraB6sN22QZFFt11Pq3Cn0K78M2A8rVIceoShT6S5IjtSXLrqb
         XtLkggehys+WdMfUsPXnloeMg6iFTUHCAd+0IPajXlTcnMgrTvQJvGJcy+x6uq9t9G7R
         P04ZNknFeSpyKXFeUzGzb1d+DQFg28JKpz14MFVWhdEDLXtgTUVwNcNxa7vs4QDerTBn
         zzAyvK+tyEj5HT4EiFlomQN7yH4CEWciHkbyrtnREu5W8DJfzb2+yibygQ/0QUrFwoI/
         j0Cg==
X-Gm-Message-State: AOJu0YxjfbnJ9YpUeIH4IF8uz9yIn6Ys4mhFGnjUPg+65B+pJyf+xMmf
	RtkWPBe4c/SjzU29tsrTzUGX7Kj7mYClJMWTURGXqIPoHZcSZgFlpX/VVukXPpk9VeEubmjE1i1
	/
X-Gm-Gg: ASbGnct2xXWlf8YMy62zbkc8njRVmlR0iwqfXAbVwx+QV/1E9/0B48vXHa7y0QqYpgZ
	OU7tJXuJVudKNZ+CQqAna3ani4VWSmhErGOQ62izHpT8bFQ8g4sODUxyESsF2LDYXp4yhWZ4N/M
	0P+NhqxxPGDBp6f2OL8+Z9veguuTruerLKKong8FRqZAkBy3+ukeYCelBbLFTXohNbhvdSuThhE
	mlanoqTOD/rTCRumdFjnUmZlHLXjzf5oeVsO9vNZHgKerNhkYN1I7uAjx9ANyFixD11ai5a5hPB
	8a4jChT/aKTl
X-Google-Smtp-Source: AGHT+IGQhseSLaNaXgNYNY5cejFmMJEHDuhXezYGgwA/wjPWpJpzZYUNrowDmQTHbNFRmzzBpT5StA==
X-Received: by 2002:a05:6e02:3103:b0:3d0:4a82:3f4b with SMTP id e9e14a558f8ab-3d2808fa4a0mr1788255ab.14.1739554195360;
        Fri, 14 Feb 2025 09:29:55 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ed2819b6f9sm890028173.61.2025.02.14.09.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 09:29:54 -0800 (PST)
Message-ID: <b187b8a3-a9f1-42d8-903e-3fa713416a51@kernel.dk>
Date: Fri, 14 Feb 2025 10:29:54 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.14-rc3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Two fixes for block that should go into the 6.14-rc3 release. This pull
request contains:

- Fix for request rejection for batch addition.

- Fix a few issues for bogus mac partition tables.

Please pull!


The following changes since commit 96b531f9bb0da924299d1850bb9b2911f5c0c50a:

  Merge tag 'md-6.14-20250206' of https://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into block-6.14 (2025-02-07 07:23:03 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.14-20250214

for you to fetch changes up to 80e648042e512d5a767da251d44132553fe04ae0:

  partitions: mac: fix handling of bogus partition table (2025-02-14 08:38:28 -0700)

----------------------------------------------------------------
block-6.14-20250214

----------------------------------------------------------------
Jann Horn (1):
      partitions: mac: fix handling of bogus partition table

Jens Axboe (1):
      block: cleanup and fix batch completion adding conditions

 block/partitions/mac.c | 18 +++++++++++++++---
 include/linux/blk-mq.h | 18 ++++++++++++++----
 2 files changed, 29 insertions(+), 7 deletions(-)

-- 
Jens Axboe

