Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF575100F
	for <linux-block@vger.kernel.org>; Mon,  8 Jan 2024 15:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VQCL2RKb"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bc1e4d0fd8so201963b6e.0
        for <linux-block@vger.kernel.org>; Mon, 08 Jan 2024 07:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704727675; x=1705332475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mza8wGzVwh87QsS4G4xBbGk97Y3XpgS2h/zjkGJ7iZ4=;
        b=VQCL2RKb9/H8aXZjm7Y/+S4YEhzTTFlXeNpmzlfjR8xemIfJYhoUzdDFd6v6ELE3bG
         pDFwDD4lTElKVZltx0239VUG0tMbnOJ+FeMkbqF2fqxyWxFA1FNYEyWU8bNwZupYxrz7
         Tn3L/QHUSUpdlXsoYdjzkQIShU9dM7tHcKE4+nzfgtrkwqXhAuwhhPDbIoxfX7yYc9d+
         NLgXJDTPATYXABq7XquJJWWa5fE+ZKlQLE9XMbUk+mLtrA6VbRPNYv8LiLxXSpOdmk08
         N8AwsiMUYU0whDng0iLn4RaST+v2Qqj3N5bCzCELr9sAsq1Ccx07ItF/vWAfoPJq23G/
         drPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704727675; x=1705332475;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mza8wGzVwh87QsS4G4xBbGk97Y3XpgS2h/zjkGJ7iZ4=;
        b=wDoYXnMllMfWavhbCCKbrOWl5gKdm3oyx2omftGP0MY4+SPNSpeWmcp9LQOkAtHBXJ
         7sO6Z2FXR3rboQxRDr9ViapRTA8g7AWOJFi0IUwa8V26Jq4W+NrnD9TdfP9awRzfzH1d
         LhXi8gC1Aotgqsm8T4X5du6NYaEgUKBQdWJGgvShUZgcBYq3mutwXsN8QhKriv9TlLUx
         thMv/+xKopFqk0ojWPxldMk4UnHC5G9+1F1FTcpkkiy3N0h6qLtZ/GasX8Sj/bRj+rtP
         0HBW4m3dC89jEHnRGfChYjh0ZKxDxs4jJBgtiXT2YniQDfOpkBdyGQrMs35TdffxTslk
         99DQ==
X-Gm-Message-State: AOJu0Yx2375UdslBmZX4Rw8N4PQM5Q9EsnVJ5gaTXjQengukutZK5QDq
	kp7cHlWtp3L6ijJbO4J1qkQ5IewKwEa+Ow==
X-Google-Smtp-Source: AGHT+IHz8AWNzbRYNP0v4fO8P0B+pmvSE/0jPk5XXoPnYNYG45y8Qqkj1+a9HwKiH6Hh+KvhftiNzg==
X-Received: by 2002:a05:6808:209a:b0:3bd:30b2:388d with SMTP id s26-20020a056808209a00b003bd30b2388dmr2898839oiw.2.1704727675569;
        Mon, 08 Jan 2024 07:27:55 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca13-20020a056808330d00b003bbbaa26bc5sm1352628oib.45.2024.01.08.07.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 07:27:55 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org, 
 linux-scsi@vger.kernel.org
In-Reply-To: <20231228075141.362560-1-hch@lst.de>
References: <20231228075141.362560-1-hch@lst.de>
Subject: Re: remove another host aware model leftover
Message-Id: <170472767480.1174555.17063907693858879983.b4-ty@kernel.dk>
Date: Mon, 08 Jan 2024 08:27:54 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-f0463


On Thu, 28 Dec 2023 07:51:39 +0000, Christoph Hellwig wrote:
> now that support for the host aware zoned model is gone in the
> for-6.8/block branch, there is no way the sd driver can find a device
> where is has to clear the zoned flag, and we can thus remove the code
> for it, including a block layer helper.
> 
> Diffstat:
>  block/blk-zoned.c      |   21 ---------------------
>  drivers/scsi/sd.c      |    7 +++----
>  include/linux/blkdev.h |    1 -
>  3 files changed, 3 insertions(+), 26 deletions(-)
> 
> [...]

Applied, thanks!

[1/2] sd: remove the !ZBC && blk_queue_is_zoned case in sd_read_block_characteristics
      commit: 6945a1804e5c2a3382232a8d6c2143930b833362
[2/2] block: remove disk_clear_zoned
      commit: 4e33b071bb8e8415fb9847249ffcf300fa7d8cac

Best regards,
-- 
Jens Axboe



