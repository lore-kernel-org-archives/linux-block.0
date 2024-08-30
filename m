Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369AF1B581C
	for <linux-block@vger.kernel.org>; Fri, 30 Aug 2024 20:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725049996; cv=none; b=RQynqXe22KCKOv8zJJZApqKXmxt4widcLop9wQVWx4oPIgZoQXNVquL1oG9GRwpG6PDVWmhcTOHthlUFwCpKQrhICenToNd8URiGpLAGAkj7ODFLCdbNJootr8WrkpFL8yqWw2FVkNA2YmgG2BrO6ej7N8nNDvxM6LSp2MTyXPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725049996; c=relaxed/simple;
	bh=wJ9FgblT1spJdVxz8nUHJ2yhqs0T++sWHSq19dnyw0I=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=TPVz2MFhX0lbh2WBhdecR7EsHfCHsekm4BdBREpTJp3+/dTEiXnEp9aK56Il1MnZDyHAbbISarKr9hghGbE6MwUJecS915xcMbi8bXHKDNr4TyXPZD2/jrkJC2IEE7NrLphurbSToGR3Ou2/750RqfbYvSnmVWLontn2YQc0xls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=brIxzCtj; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="brIxzCtj"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d873dc644dso670895a91.3
        for <linux-block@vger.kernel.org>; Fri, 30 Aug 2024 13:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725049992; x=1725654792; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhR5riDMpMAYaxqTOshWD2vTmNWG/iQVdqDHsElzJEM=;
        b=brIxzCtjkTQZORgKrDZlSzP8jL3X28T0+JrTfZ3Bm9IqFhQ44GyLp5IrPNDPfDC0VK
         6BvvkmdBO1tqQ+OPMleUPwnTRfACOrLFFAzmGeXROSctlcCErZtYiq1AlNeHU8TDWqqg
         4wvQBbmmcqACjGSMFV9TTaZDBPkuddu4qCJ2tdHsSy4PVaU5E7iOuRIlWgwAHJKUPFfm
         tKfOwrP87nYAod8UUHCtY/QmI7dq9OBd1iE8QYYvIpDkHApGmeczC3l0HkmYvAV3rz8V
         fETKIq+nbzlmU7a/diy1kJJoW0KXl9iozB3qagTZG3kD5f1wMwqvsuaPcqM6A69VZGjn
         6ypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725049992; x=1725654792;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RhR5riDMpMAYaxqTOshWD2vTmNWG/iQVdqDHsElzJEM=;
        b=cm81hBiSaM+6vTHQF4MPO/6na6aN0BIFvSIrysaYiQHXujn4WIoPFIp+8HA4s1DrNC
         HuhpYUPTxYMrFZByyuHSCYy3SmAIv92lMS9xFwDcaKUI1+xn47HDIabESx3UevIO7w7N
         6T5DpE3b1eNJRzb9HBEAo83b1zQMN7BAqhWjh5Sh3K6KV9Mv4umtfArRWwBv3Vo238iC
         0Z1C2lOrOMFePQUxWpfFEWeSr+CE9CZMAaS19zL0sosahIvyvfS1we3bPoTuXN8wIQde
         cXHxa1JlVkzG5sfTVKnWHtX7ul4b0+qbNzU8pE3/CVldBb2cNDEYwAEuvOWMxwonvklX
         TwzQ==
X-Gm-Message-State: AOJu0YyaQlQgVcfiHkCRS4JbeywLqJUEpfqh/yBMOHOGAS9e1aMTDdtG
	OQcflRp74IiGTwGaAEVODL9Uf0FG/yi4oXLy4gDXhWPJozoAMpVYFHBOjmLF2w5HvBkC4TnpdTx
	T
X-Google-Smtp-Source: AGHT+IEh+6qgsX1lk04zguIKhI9X90oH3tQz9HfGVvCW5zI8OOF2Uqg5xoCLavQ5QXLq+F2l8znBfg==
X-Received: by 2002:a17:90b:4b01:b0:2d3:ce8d:f7f1 with SMTP id 98e67ed59e1d1-2d8561c7556mr8349599a91.25.1725049992468;
        Fri, 30 Aug 2024 13:33:12 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d84462afb6sm6828555a91.33.2024.08.30.13.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 13:33:11 -0700 (PDT)
Message-ID: <8b25d5f6-6235-44d0-843e-e954729a105b@kernel.dk>
Date: Fri, 30 Aug 2024 14:33:11 -0600
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
Subject: [GIT PULL] Block fix for 6.11-rc6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Fix for a single regression for WRITE_SAME introduced in the 6.11 merge
window. Please pull!


The following changes since commit e6b09a173870720e4d4c6fd755803970015ac043:

  Merge tag 'nvme-6.11-2024-08-22' of git://git.infradead.org/nvme into block-6.11 (2024-08-22 16:20:24 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.11-20240830

for you to fetch changes up to e33a97a830b230b79a98dbbb4121d4741a2be619:

  block: fix detection of unsupported WRITE SAME in blkdev_issue_write_zeroes (2024-08-28 08:49:25 -0600)

----------------------------------------------------------------
block-6.11-20240830

----------------------------------------------------------------
Darrick J. Wong (1):
      block: fix detection of unsupported WRITE SAME in blkdev_issue_write_zeroes

 block/blk-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Jens Axboe

