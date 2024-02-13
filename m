Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DD65F479
	for <linux-block@vger.kernel.org>; Tue, 13 Feb 2024 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839840; cv=none; b=dXHYxkGKLcRSREc4RFC+Snl12kp1GOZ6PpW9irULGzDhcNEJIO2hQzaFzUcgEIXnii8t/3K726CflPJTtdZvRlCwXe2EK5Ev8Ij3XmrpEoLthGWdugFohoKSmDoaJ0Ho1Jfh+xlccKRRZuvgwiBLzjb9N8wQLB9RlVTSC4sqkp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839840; c=relaxed/simple;
	bh=cVJY8fhAf4daZ0XaJxyBWXvq8m3QPKeCsnZdhumhh94=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j6TvbQ29FbXowTtU5ln9teNzQQMhlFOmp5ge+gu3CHUMkPL8URKN7inmTIoTPNKrfPIce1IAhCJJQ8EQUeYwa/4Ht3hkGAXP1d7x8de1iCmkHKWfO7Rel9Cj5iEBl4YTTJ992+VOVdyoMxyzrwlfkJszoW7qLjbZIxxH0x3v+NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UgXAX0fK; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UgXAX0fK"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7bbdd28a52aso86396139f.1
        for <linux-block@vger.kernel.org>; Tue, 13 Feb 2024 07:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707839838; x=1708444638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vN5eKHGVSgawoTY3SWmxYK09q/xOBPXGRM+bDmNYIQY=;
        b=UgXAX0fKkfUAov83mXiATOT4oCB15SP5QqLqwRxMgD0Q8YgGq17gIUKGp85MX7OhSy
         sy5lcpjvYq1eyAt2ErC2YEOMOrthAzNJy65ggUH4u3Clvw46lRnQyFRx/oaoXcZogDks
         AVnSm9Y9SOVgwGv0FofPkbXRzsOxfNkj3uXQqVGcKGcFUOuasgaT2SrjtuleYHfc2ta1
         xOKWuQb8S9XlFQUu3m5XwA5kpztKOSJhoADnw8+/kCT693rwPQE4xYpt3ZAwItT4T81a
         QToafehPCyUYL/xyPdDTwK8uz9AzEZ+mGxx9rIbuMZdGfjukIMDESMxNjQOjrQIm3JJ2
         Z6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707839838; x=1708444638;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vN5eKHGVSgawoTY3SWmxYK09q/xOBPXGRM+bDmNYIQY=;
        b=eOt1EMhLrgcukg3GR/NZXQFa19WY7kz92/9rkes4sJnzdi0nk0a29b9rIE8EziyxyO
         Ni9ABpZ4TT69bYy9VIzVZDSr2Ny4ScvxJG/kWwMv/to6xyLq40SG8j/6RpVleHvh+hxo
         aAHuYbSde/3AgXSXoMvRgcIMETGKisXaSGVqG7PGFgEQoxjBqsYG38EuoMmb/pTtzW/p
         X22Li9wvDI7mSGhhLqXHghvfF6PDgr2Lc6oM3t14j53MjmvAkpc3FfV23dwaMmV3RrfQ
         6AskeW8MOXggiVFqNQBpShlc4T68qJiY9hDHTcLSOwtQgIzalszVNEVZx1Oh4jf521ET
         69OA==
X-Forwarded-Encrypted: i=1; AJvYcCW2CX7JriPgLFCsePs6gmqMBYJ9Dj1HqTthQRx6Z7Td3MbuYcXFdLB6qHrMdVztjc+jRHWG0J376sK81Rivagle5oDRPNIIabJW+MA=
X-Gm-Message-State: AOJu0YyVZdkZZdMCgUA98s82ucT44WM1pEM4aa/JRQ5JkVJPv1uJhmWH
	7X84BWy7jSBKGMQsQj42zcU1bmYJoylz02ZRQPdOgsZNJTFGX4BL7bugqBAVTbA=
X-Google-Smtp-Source: AGHT+IGgMwma2C5QAYcywSLRlJgLRzpaImivZzVNozyBL2RlrEaVkWjg5keKGVmbB9X09MzWv2zgEA==
X-Received: by 2002:a05:6602:52:b0:7c4:79cc:c4b3 with SMTP id z18-20020a056602005200b007c479ccc4b3mr127394ioz.0.1707839837914;
        Tue, 13 Feb 2024 07:57:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVfmmNxnzDR6X1L18NCRNq2bEgAFab+05bRr/w9KpA3kXL9soT+amXyQP3RtOxQFTjcpwkrsP5hxaEBcESTCxUXkgxNo+mwEDjeCINg8/IW8hzfWjxTIecrcTdIP/jWYynMzMGq4QcmTl/GD+cFORO59Btp/nkxnoIbZEJytUv28LYH/O1ETvUVankyKCLz9JepJfR72W8KOLt1nwtmlZT7Enbac4jgxo75p9MC/uZ5fUqpyjjV3dRbkZJKVGf6Cf1tBlZhzLq2E9xFowquc+SH4jqPlDsmskdivkImIm748XSEDcvafoeENngNiPqs4kY3lfUp/H5xvre2uTjwByD0yFEIKBX345RHHdL+1zOGp0iaVPNYW2hNywHjRqNTwMg8yLvhsgXEnEg59EKfpXO0pCczVOv8jRrR3ws=
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id da2-20020a0566384a4200b00472c62c7d74sm1983220jab.149.2024.02.13.07.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 07:57:17 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>, 
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
In-Reply-To: <20240213073425.1621680-1-hch@lst.de>
References: <20240213073425.1621680-1-hch@lst.de>
Subject: Re: atomic queue limits updates v5
Message-Id: <170783983686.2333153.11971285922494532518.b4-ty@kernel.dk>
Date: Tue, 13 Feb 2024 08:57:16 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 13 Feb 2024 08:34:10 +0100, Christoph Hellwig wrote:
> currently queue limits updates are a mess in that they are updated one
> limit at a time, which makes both cross-checking them against other
> limits hard, and also makes it hard to provide atomicy.
> 
> This series tries to change this by updating the whole set of queue
> limits atomically.   This in done in two ways:
> 
> [...]

Applied, thanks!

[01/15] block: move max_{open,active}_zones to struct queue_limits
        commit: 8c4955c069ea3b77dc63b55d13afa9341e894849
[02/15] block: refactor disk_update_readahead
        commit: b9947297d00b9c75b271db88165e39c0208bec2e
[03/15] block: decouple blk_set_stacking_limits from blk_set_default_limits
        commit: c490f226a0ea22639e81ac34edc884e238ea955a
[04/15] block: add an API to atomically update queue limits
        commit: d690cb8ae14bd377d422b7905b6959c7e7a45b95
[05/15] block: use queue_limits_commit_update in queue_max_sectors_store
        commit: 0327ca9d53bfbb0918867313049bba7046900f73
[06/15] block: add a max_user_discard_sectors queue limit
        commit: 4f563a64732dabb2677c7d1232a8f714a18b41b3
[07/15] block: use queue_limits_commit_update in queue_discard_max_store
        commit: ff956a3be95b45b2a823693a8c9db740939ca35e
[08/15] block: pass a queue_limits argument to blk_alloc_queue
        commit: ad751ba1f8d5d4f4f4b429b552a154e888524a93
[09/15] block: pass a queue_limits argument to blk_mq_init_queue
        commit: 9ac4dd8c47d533eb420af6a679e66ec74771125c
[10/15] block: pass a queue_limits argument to blk_mq_alloc_disk
        commit: 27e32cd23fed1ab88098897897dcb9ec2bdba4de
[11/15] virtio_blk: split virtblk_probe
        commit: 718628adfcfdc80466eb42cd9c615d1d5514f74c
[12/15] virtio_blk: pass queue_limits to blk_mq_alloc_disk
        commit: 8b837256560c783415b42748959900befcde2d00
[13/15] loop: cleanup loop_config_discard
        commit: 65bdd16f8c72bb2178f5e4db40305bef6c96b309
[14/15] loop: pass queue_limits to blk_mq_alloc_disk
        commit: 02aed4a1f2c355e41d82a8e9831031ca9e0eb45d
[15/15] loop: use the atomic queue limits update API
        commit: 473516b361936cbc27d7728df649a5b3094b6170

Best regards,
-- 
Jens Axboe



