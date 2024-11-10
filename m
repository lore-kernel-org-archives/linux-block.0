Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41C22CAB
	for <linux-block@vger.kernel.org>; Sun, 10 Nov 2024 03:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731208072; cv=none; b=KbAksTSRZ/R9efIKhUTLceFhOw691dDgt/BMDR7LY/lp+/KjEmIt9vu5U3F2KD5xwHps1ZhGbUUE8KSp93jhOCQI/qOvBdFPXx6NTx+UK9BwMXCquVL4gZKkS0ilgSDk9iPuGXTrBIXfJczjvryvh+HloEyBM+z35iUGi3sVJ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731208072; c=relaxed/simple;
	bh=nJFTTZb2T8v24Pdhp2OGNGD2MfnUvaN+8qgQWcHfEiw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WDosgtRe1wC2uxmeVYBNQfkx9BSwhuRlt51V337aJIgoHxnbSo9lV98vvuwbBn2zYMH7CBZ9fS24s4Znb2QrQQZEd4jYmDKgwMMQpWNevLhCjrs6gad8AxR2ss/2VvzKYK273ab2QEGg6VTWsD+b8wpM7z/9WX5pfPVjTBTaXRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VHYbPL8z; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VHYbPL8z"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7240fa50694so2316818b3a.1
        for <linux-block@vger.kernel.org>; Sat, 09 Nov 2024 19:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731208070; x=1731812870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygceEVSXrW7M0Kct/MMvW5URAdXYw4XxgxQNqTqjxDs=;
        b=VHYbPL8zl3GKZTPf0k0JEHFzJ93QcOH1n0H5oCXx3GogS/YlRDbzeGLGWGNHLIsOd8
         iZCTtBvfsput84BKPxYTRHpDJ3pjhdewuJWcCh5gPum21Oy+CvLetRcmds8wGxF/vduE
         qO0qrVlIHC0B1wUuGYZshsv2YuurHUV2uRdaQlUOsV1Qytmpo6OL6Cx9DOV9I+AxWEry
         8nQAZNEAzCwLoTfABNZWqAp1yjYB6A0EVRtQh1lRHywccqJl/hpQw8UzadjILrmeUoE7
         SzGomPMsduqaeAMgEXu347w+ukHJaXAs9gzOQryhky502Go/AZVhT/cImfkEp8w9qrgU
         tqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731208070; x=1731812870;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygceEVSXrW7M0Kct/MMvW5URAdXYw4XxgxQNqTqjxDs=;
        b=GwimeNguG6ZFDl1QK7FUfvyLmotL16EumuQQUEPZ9TpddHtODQZUiL1bx2jFHZaQz1
         KXxcUzYApP2yoC9PkicSFqfEbR+MdBgGtx0wmTIflRqZkrtITWJzJZf259rJEBC/SWYm
         ZfUKxPYAtYscRgZrpDJEqwLShLiCa5ejI/KyM4XLnJVppK3yfWhCuvUcA30wyKGG4ijL
         PvapjV/RnvJYwzWX1FqcnvtmVxEwnt4AGZBUVvFks3vmJ05W7jSwy9aoYNICDLZv74bu
         sM+9jdGmvmiZ1ZZkdxm+KGZULwaTMtk+KrhyYI+mcHq1H6UTk89tmWKRnSvj8Tlcy76u
         PrnA==
X-Gm-Message-State: AOJu0YzpddXahcLpeTkn6azN2kb9p33ryBlY25FvPhoIE69jEnlcuJqh
	g9OhwZO2/saqqIYMT5MhMkhtHjqfxQiWq5rnJVwxgqmUPrMamklr90gLprpYAnic7dHSyfqLcOz
	OdAA=
X-Google-Smtp-Source: AGHT+IFh+XaiFPVABy8TFFyuVlHt9H2lvf7SddIWTaKsifNPa3mlGku+yz1NnyWF/kMz9B/M/MrRoA==
X-Received: by 2002:a05:6a20:72ab:b0:1db:d8fe:9d4 with SMTP id adf61e73a8af0-1dc229a6b5dmr10932478637.16.1731208069956;
        Sat, 09 Nov 2024 19:07:49 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f65ba92sm5922982a12.80.2024.11.09.19.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 19:07:49 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Li Wang <liwang@redhat.com>, John Garry <john.g.garry@oracle.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Christoph Hellwig <hch@lst.de>, 
 Damien Le Moal <dlemoal@kernel.org>, Jan Stancek <jstancek@redhat.com>
In-Reply-To: <20241109022744.1126003-1-ming.lei@redhat.com>
References: <20241109022744.1126003-1-ming.lei@redhat.com>
Subject: Re: [PATCH V3] loop: fix type of block size
Message-Id: <173120806863.1615597.8815561681706905908.b4-ty@kernel.dk>
Date: Sat, 09 Nov 2024 20:07:48 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 09 Nov 2024 10:27:44 +0800, Ming Lei wrote:
> PAGE_SIZE may be 64K, and the max block size can be PAGE_SIZE, so any
> variable for holding block size can't be defined as 'unsigned short'.
> 
> Unfortunately commit 473516b36193 ("loop: use the atomic queue limits
> update API") passes 'bsize' with type of 'unsigned short' to
> loop_reconfigure_limits(), and causes LTP/ioctl_loop06 test failure:
> 
> [...]

Applied, thanks!

[1/1] loop: fix type of block size
      commit: 8e604cac499248c75ad3a26695a743ff879ded5c

Best regards,
-- 
Jens Axboe



