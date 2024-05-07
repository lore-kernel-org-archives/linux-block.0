Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1AE15EFCF
	for <linux-block@vger.kernel.org>; Tue,  7 May 2024 13:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715088887; cv=none; b=uqhop46SdhIB0asjIlKKSkC2QVpBsYNxrsSOyGLIAXLABnKqHJyl0QDjq29Yevg4qtcuyw5YdT+nLb6cnB+9BHykNkDOZRCb8fr1avkEmfgVrqkcLagVjR4qNWBuKdHJqv+coIrc3pZar0uhhuE67rNDMuysx4YTs/FNhA+fWYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715088887; c=relaxed/simple;
	bh=bV3hZF+yWnUvLfolt0qL3m4QpmW8/sDlFRD//n8L/aY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RxGq3BG6eYru+//toFvUcu4iYAppoER5Szl0oJxMroedtRgLwW5IQwa2r5Nd8gBb7jaV+7oShzpSm9UCVmbwzjZpzaxXanoecrYF5VFxbG66gQ1Uf3CxIwa436lpJqxCduJChE4JTq/3N6BX5nuHZbFEsw1icCYRAYrnPy2dRKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=d/ZoamSZ; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="d/ZoamSZ"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7dee044afe7so5827539f.2
        for <linux-block@vger.kernel.org>; Tue, 07 May 2024 06:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715088885; x=1715693685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KP5HKRW4kBbKaUQGr7WJW/KutC9oC2MC2S4+gvWBuKE=;
        b=d/ZoamSZxjkvWrrT1IMnPjBogp7aF4nGIKxTB+uXxJOsWbIZSeYZx7XBltN96MBlQk
         8tB1owEP+Sq59e+aiay7+QEqKGYaRV7LMii6hgkaVGmXBl14rd4Tyc3gRzOazu22Z9oT
         m/iOa4Wm5Bc2SiavE0gfOi66WP++JsHD9ubhyN25XFE1pH+i8ZM9btDDBTsKFIxHse2i
         VNkHmz/hODE6fGbDTAesR+VQi3QZEPyvBPl+i02MCabTbS0xgxnKe6XLNyyciUeKZssB
         c862NBTqVEvNr7EgZkyxZ61vUZlPtZoe4dEh8w7KeuL3SesZBhQJSIMIfFBoRn5kHBuQ
         HQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715088885; x=1715693685;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KP5HKRW4kBbKaUQGr7WJW/KutC9oC2MC2S4+gvWBuKE=;
        b=PnFbyBvoCgcpbvXKRoNRiqAlvX1hYscqQmJzpqxh3MYhtp1Ma9Q3E6Ruo3TSIpvpfY
         mxvf93Gbm6CNIOmot66ouXXic2KE3K2H7r4HXeA1rwOhakO7N8KSgsEjzMXaalXZ0u6F
         9zgNy1glMj39wGWdOzBKDG9Tm164gEBTGFW9fba+ZxxcqVz+7yUYmoocR0d0QV5KAx70
         RqrsQjVmsZ+PMOsuyudzpo5Hx6axerLGJMLHAQz4AuC2PH0ni4A5ETztKhYmMoX+w+M4
         Eo2M29MySb3uA8JzcWLo3B5P46D0wqCsXzaC9msgv97BNwm+rbErmsXxonaRMwojeU+q
         yDKA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ+14DklbU1MIh0DjBsaMKvOwWThTYwswtehFabJm5Z2W9lavLDNZFfCjuD15Uoke3im+FoxDHlHXRocPGv78fK4RdvpmnqslWU8o=
X-Gm-Message-State: AOJu0YzTmgSMqRdDBdsyFkyHWRqZW0wW+WCVO8sdky82qR/fijGI0Ext
	LUxnSTTJeGm9J18RH/YYXEZDskiUgUCIq961pjAIuA8S7u4uNXVzjp5617wvd4QUIW7oVwC+jhb
	d
X-Google-Smtp-Source: AGHT+IEfjA72JzoPNtuzqqBb/n6TSa5TGv07xhF8//9/sK/vhyY+R3mRWtXhNQLSmyncdcc61+6t5g==
X-Received: by 2002:a6b:3f45:0:b0:7e1:8829:51f6 with SMTP id m66-20020a6b3f45000000b007e1882951f6mr974176ioa.1.1715088885335;
        Tue, 07 May 2024 06:34:45 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x6-20020a056638248600b0048859a02138sm2249450jat.86.2024.05.07.06.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 06:34:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: song@kernel.org, linan666@huaweicloud.com
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
 houtao1@huawei.com, yangerkun@huawei.com
In-Reply-To: <20240507023103.781816-1-linan666@huaweicloud.com>
References: <20240507023103.781816-1-linan666@huaweicloud.com>
Subject: Re: [PATCH] md: Revert "md: Fix overflow in is_mddev_idle"
Message-Id: <171508888455.12290.2983821888497713665.b4-ty@kernel.dk>
Date: Tue, 07 May 2024 07:34:44 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 07 May 2024 10:31:03 +0800, linan666@huaweicloud.com wrote:
> This reverts commit 3f9f231236ce7e48780d8a4f1f8cb9fae2df1e4e.
> 
> Using 64bit for 'sync_io' is unnecessary from the gendisk side. This
> overflow will not cause any functional impact, except for a UBSAN
> warning. Solving this overflow requires introducing additional
> calculations and checks which are not necessary. So just keep using
> 32bit for 'sync_io'.
> 
> [...]

Applied, thanks!

[1/1] md: Revert "md: Fix overflow in is_mddev_idle"
      commit: 504fbcffea649cad69111e7597081dd8adc3b395

Best regards,
-- 
Jens Axboe



