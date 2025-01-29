Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6EA42049
	for <linux-block@vger.kernel.org>; Wed, 29 Jan 2025 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738160243; cv=none; b=jUPMPCKY0WuAw76hvs2NMFSfHJff5MA7vvYkaExUw+996tkJ3GMtQ7d8fnwghbpot+Ap0mdT3BFEfYaqVMKwWAa9GZsRR+yUqdyLNo+TSOUVbGyLbb/x5n4ThfNkKkRs8IfFJvZZ8xS757AiThgIO/5bh18G7kQ6PB/nd0WoxSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738160243; c=relaxed/simple;
	bh=UEzhS532+hwt1opM67nDRSyRlgihhNytgfPcLWnWGNU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GH1TXaUX6eEfIzGsKB6iXDr9lr0OOUpUfkR8+7Hc6hvYd6v/ayCxtjZ1Ss+0VimwcqJdlYHlYsuIMe+GnMyCy8AFmJT/+i6HFgZy9888+i4K6JQZ7sxsatVxXacnnZeEXvWyw3c2SGAia/0oibtVQ+i56RDtaRuL58jwrDL7dv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BlTKYRfI; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BlTKYRfI"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3ce915a8a25so22757035ab.1
        for <linux-block@vger.kernel.org>; Wed, 29 Jan 2025 06:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738160240; x=1738765040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Pt3Vj241rHbwS/dznbhD7KSksrHr+Vxru0qaVZYKTw=;
        b=BlTKYRfIpUtMIqO2VEDUlI+x5hGAfzJaWlxAeS8N5Cyxa44jbTh8T1ic9Vpjjdc7AP
         /niI9ivFti51nAgnoGRqBNaHUz20+vzSBrYER/QsP5uos0Bt45Cyt8nh8YHZylIvPk2a
         t5d4gSJ7d5B5lmK64FciVe+8YA6XWMN97uQvtzPuoYnkzo2nFX7QYOOwddsgpvh8hEfz
         EfQNbumkPCwaPpqkUSrmHN5/v3H3o+ubM/+0V5lZpc7+vm1enzufk3RaV7I9DIwbeJjN
         MdD23qsJaG8y8MDsxV1jKpCM85bhHDsKjHySo1QAEKEGi7WGtIFpmc9yLpY94tKH555i
         YztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738160240; x=1738765040;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Pt3Vj241rHbwS/dznbhD7KSksrHr+Vxru0qaVZYKTw=;
        b=JSkKMaqzyYTB2SyiA3yT/Tki40GgCZqgzAZ/C7na3mSLUIp9JG2SxUMJL+KnuMBhpM
         pS6c6qQs466gWkp9C6fLfOiIamDdzdXwFT7pjj1xOiBNiZvovfjfwBs2jCggeqf9AR8a
         Mg9ByeotYSslVDpjRW7WANw3ACMJkjZcBm7giC4UD3nHQCZPHSrJKCGxGDyLbAZBVTHc
         rYlUNdrv1lkz2OCjmDmCnCrwaOsdWFx1mJ5tr90goYNcWBG6hZf5iNc2S0M9aYuwVadB
         Hzra/xBHstEa9tKngVWVkxxPbSiveTkF+dRIAI9L8ZaQoXn07k1MmAuvK3JFFx2huqcs
         19pg==
X-Gm-Message-State: AOJu0YwDHiOd9ylw4d2N250Rdz6UL2sJmFr3LBTvMcmrpJIPQBbAqxrw
	ogWTNajaIPz5mnpdLX5Sasit3Mgdt8/msY2gOe5wjRr+h38/ixAzxohlnl/gDBM=
X-Gm-Gg: ASbGncuDypFj12C7bYMBS+mkT7TJcEWwSwrvGzB6sPQo5r27AW2RYBcPHFmo92jPZKq
	qb3z9UYZKBwYVyhN5yhZX4wZbxw+A3ro7aGlclzkMnKv64g0iyY4R+avvpicAunyeN8n6HzEPGF
	VgYIbXlIKDYC8mKwidmJyUWFQHmldo67bQ0Oci0uPA2rEhkLu4M6R8UkatjKHXyvklQrSaMNCFb
	zh7JHvRTN7JnxJWVxi4gulbhi41TATk8xqtLE5snIOIdLxwGdfwnPWKJLw/C6hu5q/b5o5UNusK
	pmAC9Q==
X-Google-Smtp-Source: AGHT+IEpvHfTHy0QgZepC/stNlH+UxtBwBDX0r/YQoFuHmw82IyBPEH1kqxubAbLQBnr3cye1w5A6w==
X-Received: by 2002:a05:6e02:b44:b0:3ce:6cb7:1e6 with SMTP id e9e14a558f8ab-3cffe39c03bmr21251575ab.10.1738160239818;
        Wed, 29 Jan 2025 06:17:19 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3cfc740f7a7sm37458265ab.6.2025.01.29.06.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 06:17:18 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, gjoyce@ibm.com
In-Reply-To: <20250128143436.874357-1-nilay@linux.ibm.com>
References: <20250128143436.874357-1-nilay@linux.ibm.com>
Subject: Re: [RFC PATCHv3 0/2] block: remove q->sysfs_dir_lock and fix race
 updating nr_hw_queue
Message-Id: <173816023843.10270.10658013197443984372.b4-ty@kernel.dk>
Date: Wed, 29 Jan 2025 07:17:18 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Tue, 28 Jan 2025 20:04:12 +0530, Nilay Shroff wrote:
> There're two patches in this patchest.
> The first patch removes redundant q->sysfs_dir_lock.
> The second patch fixes nr_hw_queue update racing with disk addition/
> removal.
> 
> In the current implementation we use q->sysfs_dir_lock for protecting
> kobject addition/deletion while we register/unregister blk-mq with
> sysfs. However the sysfs/kernfs internal implementation already protects
> against the simultaneous addtion/deletion of kobjects. So in that sense
> use of q->sysfs_dir_lock appears redundant.
> 
> [...]

Applied, thanks!

[1/2] block: get rid of request queue ->sysfs_dir_lock
      commit: fe6628608627424fb4a6d4c8d2235822457c5d9c
[2/2] block: fix nr_hw_queue update racing with disk addition/removal
      commit: 14ef49657ff3b7156952b2eadcf2e5bafd735795

Best regards,
-- 
Jens Axboe



