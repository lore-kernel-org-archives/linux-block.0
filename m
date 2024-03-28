Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965FB130AD4
	for <linux-block@vger.kernel.org>; Thu, 28 Mar 2024 23:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711667127; cv=none; b=ohOpdWFJJ4RHPn9oE4yW4/6HQ2j32oXoMViXxdJjItdfPFgb8pQp8JpuOZLAk2LLuZaOhYy0JoGaMws1Da2gCi3AhrAS1XpEs3XVFF/gRuUXV7zEDUSTApXVJw5Ua0uumVyb9Xtndw76ADOZwniMVOrCv5OoEg8A1g7ofjcBc5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711667127; c=relaxed/simple;
	bh=RR1NsxYBYOM1Y/zktRAsa3HBsBJLbkk3BP9brZN7qiU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OnWz9vFWQnTSVRP5KvE73VMWQ9XeJeE8c/fWosrJw8aqyCeTNCOT2F6FXtqt/b6ny2kIS1Gh3XUoTvx7zOIxzW7yySgB7N/CgGFRjgss8mVED9Hxvuc7cRFBj4uYIzlPs0YVXFsfsR/KWA5CSYlqlmObTrqv2swPhYhaKZlJCPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HC5F4SHx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HC5F4SHx"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dde367a10aso2501835ad.0
        for <linux-block@vger.kernel.org>; Thu, 28 Mar 2024 16:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1711667126; x=1712271926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jH6cSamYqu9y6NrHpddafX7jLWVjJSO+MIjSmesZ7SQ=;
        b=HC5F4SHx0PVrsYo9NkvV3tOhpzQfQ4P5rknALL4vGdDJRSmsFTwMF6JFKTtt5/wd8S
         VfawKGUJor73v9387DxzGorNIXB8GVXMETbUz4XKsS+4Qjqr+Sdwx1XoHzm0sdg5vYFX
         pDpydocDNalgAf0jbCnsNVTPxQmYbIa2iIQr9MCKkr6x7XeQD4QjXalNFpxbr8Dd/Z4w
         S07K0idKD40g+9unlGMldfJi4NuHWgZamPB7Y4pH24E5LHqlDfbc/UY5EH7rnEfSy1cg
         4pD+d2H4u0JU2idy3Gm4eQ4vqTwJ+LUmsMKQvfwnPxHzuRe59/uQjn0QrM3jomJvY1DG
         qwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711667126; x=1712271926;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jH6cSamYqu9y6NrHpddafX7jLWVjJSO+MIjSmesZ7SQ=;
        b=pDzDkixSuhzstE4jjBXfIEJbVptvdVmzaYIi+r80O5jfoAQ2f1sdjwt0phJ7Xbi6pd
         OtkiuYsOme96g+VtJwRR7pTb5xLLt3ydrdOdliTQNxCl7R9Ogqy4DpGoXWtmwZK/+KZK
         xFjb8CZ63zTpnY7tLz+Cb1P20sDq0u7oQ7cowBNp45E3GItOYEdEHoJBUg24Hm5mmuuk
         KAaxkdj87UajLvlIr+t9P0rRRjR/beSyTQZ841OS0A0zPcplgJNtZfxD/D5dobf0bEj0
         hiqiPo28xgNMWn0n15ALNA3hYMBDiHQPB5f6rMlXjp0s4jg++89ohKjn6NfzMtfzIVdW
         YBCg==
X-Gm-Message-State: AOJu0Yy2gv5KFO27CXZ4tmC14bVQ/8eEF2b6X71FzkABlW4wTnluC77y
	s4xp3XoJKctNivr5Eb3BSbC6F0uApqFe2WzuLa29RWB5Fi7xR4M8nGQwa1oZ698=
X-Google-Smtp-Source: AGHT+IFz2PM05uHbkjHCxEwx7ITQmcuHmP+Q9onJ6IDFb8FdZ5M8mwUFVEVXNdLv1bOXS14zB6XpZg==
X-Received: by 2002:a17:90a:77cb:b0:29c:7487:43b8 with SMTP id e11-20020a17090a77cb00b0029c748743b8mr839839pjs.1.1711667125810;
        Thu, 28 Mar 2024 16:05:25 -0700 (PDT)
Received: from [127.0.0.1] ([50.234.116.5])
        by smtp.gmail.com with ESMTPSA id cx18-20020a17090afd9200b0029d7e7b7b41sm4013902pjb.33.2024.03.28.16.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 16:05:24 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, 
 "Martin K . Petersen" <martin.petersen@oracle.com>, 
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>, 
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20240328004409.594888-1-dlemoal@kernel.org>
References: <20240328004409.594888-1-dlemoal@kernel.org>
Subject: Re: (subset) [PATCH v3 00/30] Zone write plugging
Message-Id: <171166712406.796545.15002324421306835511.b4-ty@kernel.dk>
Date: Thu, 28 Mar 2024 17:05:24 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 28 Mar 2024 09:43:39 +0900, Damien Le Moal wrote:
> The patch series introduces zone write plugging (ZWP) as the new
> mechanism to control the ordering of writes to zoned block devices.
> ZWP replaces zone write locking (ZWL) which is implemented only by
> mq-deadline today. ZWP also allows emulating zone append operations
> using regular writes for zoned devices that do not natively support this
> operation (e.g. SMR HDDs). This patch series removes the scsi disk
> driver and device mapper zone append emulation to use ZWP emulation.
> 
> [...]

Applied, thanks!

[01/30] block: Do not force full zone append completion in req_bio_endio()
        commit: 55251fbdf0146c252ceff146a1bb145546f3e034

Best regards,
-- 
Jens Axboe



