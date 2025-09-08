Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCCB2EBDF4
	for <linux-block@vger.kernel.org>; Mon,  8 Sep 2025 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340441; cv=none; b=YbTmXkE/28+9g8PXh5aEz38dSVumPl+oe0wT1lVUJ8p5PCOMuJndxz0Dy5l7GOLkxd18mJevjH/xLnWno0W1nAbFD4ozy+nL26iitRs4jPCmGOrpgboBkuQoVvz+/V87xUmuTQH2gCJ3XDMAO+dWo45vT7FOBlvfxq86tGQV+JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340441; c=relaxed/simple;
	bh=9WWYFzZ2senbr5M4voEBYLXFzgtXlrDJphv3thkMcAc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Xjm7maqXnLEdN86RVOwxdpGDJNP5ARKG94oqVo+9LbETLocq90cn2Ica62kEZvXBk5dQZE5MjvUiVgf9K50KB7AwDluxwpcfgyw3mEygwPcUo8JSPr42PgnIVF27OQKHJwLq5UpZqdFLEKWzTMtmd2jVexqL9buVyrzlhjBxrsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rAre/+lE; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rAre/+lE"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24c786130feso39435105ad.2
        for <linux-block@vger.kernel.org>; Mon, 08 Sep 2025 07:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757340437; x=1757945237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPrBcS5/14Xk7A83gR859MqOgXeYkO/f7jDwqPUxbJU=;
        b=rAre/+lEEEiwjOo3CEj+rq+HMHvliyqNvpqU7MITY7RMJhz+UYyvUh6kSCeHZfLts3
         swVdaeuKfg4j8zYWgj/PyvNlN/DmjjGFGOOTc+GkvGzxYDd52DZhOT+cgX4cLdVWDClO
         i9LKGO5IYPTcI6wtTRDycjlO4GV+w3XbTSvqo0cjO5oLITfm2hSIOn3hlURLYGcjIv0E
         flbOS1+gysjUcp5FdjnxjcDV5g7cEpDKNKlQsjezNO8sgjuSemvBCFSeyCuxUm7kyTTh
         J0tIXFcUHGRdy7Qbg5VvLu89cgXOJkvS/HJ/D9lESs8S0hRi8pp8UYZBwB7ZaFsKwFv0
         waqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757340437; x=1757945237;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPrBcS5/14Xk7A83gR859MqOgXeYkO/f7jDwqPUxbJU=;
        b=oGZt5rnT4gx/GLLErsBXe/dfFlowhS0oo9zMcneSM8PxP4b76FoWYRseuuPHeYoGBq
         b81NQB0cQtWwJFR2BytiTWQY+5/m9ql4qTkE2qCG70kkRycR8qkL7diVZ0j9wp+MmbzK
         wTocP39FNJEEH9ldOdJlaEqfXxKgP19zurPD3H0gDr3nBcl/vcrzCx+Mfqpd/ryJSWfG
         4sNp4gV1BmsqYaz5dVvLvuKbVF92Tjl4yJfDB1DkVvzj8veeLHcL8yuX4uM9M5Fc5bCR
         MJBFFXbkt9jTSiVcJlt4Ceh/ZCW2jDEjJEISOfp3LPt58aFNnsng49lGtroUALnsmfkG
         18rg==
X-Gm-Message-State: AOJu0YxMKnnMk+6QBW2aQ5pJTFbWABPAC+07o+24SKJT0AN2k/vGjUP2
	eqkC/3zasqAydhdBCyCWFpsjgzp+4lBTZfCpSqIrMf5xbvB8paWapUTSXD1zaSLyNu8=
X-Gm-Gg: ASbGncufZZwUU+iTXSDQs8ru58XNeAgPB7+7C2AGcgusgfJ9UjpxBgCMQwAtBgcfS58
	DVKq1Gz1+j2SROuvmMSUzdySYpvOI6dWbc0NYeBfh90eefVo0cZ6E+kAAZg5cwjUVEec5p8aeBu
	ulytqGwj6b5mO2syDYHJlFNVPmW8lF20VmFSffwnSqQZFrxPaLEZn+5Al+3abSvmbgV5O8111K5
	r3zQhMNBuv7jGz5IYYXFrWerwVTzvUU4FcO0BzEWLyyCHgx7EcTp26mhn4jBn6AC7yBXyRMhaPL
	QdqzMCyoWa/GBRP+cue+fe6LYFqWxJni2+a1WsWT4rC094AgjLaLxpsMsrw72gF7gIGAE4qSJ70
	G1i4VYIdWkmDVXH408RtpbJxflA==
X-Google-Smtp-Source: AGHT+IE0CJ76ogwBP4CFcueYUA4kDvDNQE4LEaU7FQBCVZ977y45r3BDz4mNFdbxyt7UORUWu+aqXg==
X-Received: by 2002:a17:902:cf04:b0:24c:af64:ae11 with SMTP id d9443c01a7336-2517311203cmr107886065ad.44.1757340437395;
        Mon, 08 Sep 2025 07:07:17 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c7ecd9cafsm154811625ad.83.2025.09.08.07.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 07:07:16 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, Yu Kuai <yukuai3@huawei.com>
In-Reply-To: <20250830021825.2859325-1-ming.lei@redhat.com>
References: <20250830021825.2859325-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2 0/5] blk-mq: Replace tags->lock with SRCU for tag
 iterators
Message-Id: <175734043666.530489.6794486141498960835.b4-ty@kernel.dk>
Date: Mon, 08 Sep 2025 08:07:16 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Sat, 30 Aug 2025 10:18:18 +0800, Ming Lei wrote:
> Replace the spinlock in blk_mq_find_and_get_req() with an SRCU read lock
> around the tag iterators.
> 
> Avoids scsi_host_busy() lockup during scsi host blocked in case of big cpu
> cores & deep queue depth.
> 
> Also the big tags lock isn't needed when reading disk sysfs attribute
> 'inflight' any more.
> 
> [...]

Applied, thanks!

[1/5] blk-mq: Move flush queue allocation into blk_mq_init_hctx()
      commit: aba19ee71cd7c0253612d6a2a0b3a828ba9ece29
[2/5] blk-mq: Pass tag_set to blk_mq_free_rq_map/tags
      commit: 9ad8e5af327904dcc52e64ee5ab731c7018ffb0f
[3/5] blk-mq: Defer freeing of tags page_list to SRCU callback
      commit: ad0d05dbddc1bf86e92220fea873176de6b12f78
[4/5] blk-mq: Defer freeing flush queue to SRCU callback
      commit: 135b8521f21d4d4d4fde74e73b80d8e4d417e20a
[5/5] blk-mq: Replace tags->lock with SRCU for tag iterators
      commit: 995412e23bb2560a73db444e4c60bf5826b33aaa

Best regards,
-- 
Jens Axboe



