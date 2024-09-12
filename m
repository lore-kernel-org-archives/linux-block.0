Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597C11BC08F
	for <linux-block@vger.kernel.org>; Thu, 12 Sep 2024 14:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152430; cv=none; b=DLhke9CJSpX5JwJkuyvAcarDq028N/KmzWKmEW2Qll7BnONhJN0/IAfBY4mKNKGRe68vT4K2s0/E0nKlxuu0YoLxcHKAJvMUvKVnOP1sJmmVZw5z3Y+8xWvTMBxpI5iFmrUUL7lbWfslhjSjSzG+FTvoLlCa7seiuIJva9/AviI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152430; c=relaxed/simple;
	bh=VLgQVidQ6JkwNHBG+bT7z+vat5MVRXiuTmpzNYEBtjo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O0qNJTWhJ6B0m/CUTXWfJQSRu5Gwjb6tMyjTzk47G2o2gZyonD0Ik2l48SkHxpkThCuU8ds0jrz/68ui+PXH7PXrlCt1n6DvEejBUhMYGWMEE6GS3iuZMhXKhwhRHpghQ7D+4qqhmH0XSirN+yjchHVGNxcd7ZIsPu6l6Tj8ddY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Pbm2HzJL; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Pbm2HzJL"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-82aa7c3b482so36706539f.2
        for <linux-block@vger.kernel.org>; Thu, 12 Sep 2024 07:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726152426; x=1726757226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuqxE552eGXfY1QPIyif8tITUzuqDHdFknJEPi/61EI=;
        b=Pbm2HzJLGlJjw/8u8R304Kf/0lNOwgPO9fY/m/b0stzmPnnX4KTD+d/nYNxhWFhRI1
         G8/r7Y65/FDXgRipKhqfBbcDUu66aGZyAInZ0MFBH10hSknHVuIj7MQUBGTEDD+4eppB
         hWJDXIaIlPRHLSqWfnSvdIkftLSCl1ZVNNstOHwxOBdY8XvJskxfGbnUpc9MSpy3aVkQ
         7uqpTqKFpQaBaMqg08KPIB6SzmZESR6NFJ4Bma7IcJysCdPOa2VsSH/PGVGYZr0SvBlI
         srhEE7DCv2aoXxc5BYf/48eDnycIg9RB4FvcUJsuIwL0C+qsbC5T/k19Jmc1WqueJrLE
         uZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726152426; x=1726757226;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WuqxE552eGXfY1QPIyif8tITUzuqDHdFknJEPi/61EI=;
        b=ZY1VSbOLm+cnjAhQZnyfJSGs83Rg7MiQ1f2l64orlZd8/gKevErG3nejKqhe3C0NXt
         7nRa6QoIka/ZwJJK6JQtgrL4RMhBRPyhLTxvMKsqd14qVs/Ps1NIfTRQO8LrntPHo2nO
         bZwaQPPWIk6sd5lBsAL1d++BMUfuggzb8pRrhTHO+Z8VABfwB1LYZWJSOAKM7Jg18vtf
         D6zo6IKknwATRsqTwgZvT8mLgRWCbvJZ5T8ikvTfjRi2llFUwBQ7v9k2GqyNsRsp33Ob
         f9p0FubTAMAtt8ttv0IfDaGq0nYYEugO2nW55vlSuQHL9MpBEijub/AjVDtVnEgpC7Rl
         teHg==
X-Forwarded-Encrypted: i=1; AJvYcCXTU9mB2NxcKkKjTR6G9o4b3VLcjCcCC9qdyziRJ5/lnYjJ9Ht1+RjukXIQaoFcQJ/jeEVyRlBcqeuH8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzD9iqJPPL7+ifUGEZbAw4EYFmdIJfC6S101K0qJtO+n0O+9h1w
	3GkDPj/Vg/gQBwM1/rj/KcRL/h2XLu2wun7EMfdOQnKnoaUkmLcQ4mBUpKPuXABBAe5WzH+1viD
	/
X-Google-Smtp-Source: AGHT+IF/1lFIcEGDucV4K4EUBkE//+6FWK/0zRbuXQuHpWpvj6rxbxk4lY+FKUQePA1L6vRyxhJ6eg==
X-Received: by 2002:a05:6602:6d13:b0:82c:f30d:fc72 with SMTP id ca18e2360f4ac-82d1f8b72dfmr410240439f.2.1726152425689;
        Thu, 12 Sep 2024 07:47:05 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d35f433db8sm633355173.18.2024.09.12.07.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 07:47:05 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: hch@lst.de, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240911132954.5874-1-riyandhiman14@gmail.com>
References: <20240911132954.5874-1-riyandhiman14@gmail.com>
Subject: Re: [PATCH v2] block: fix potential invalid pointer dereference in
 blk_add_partition
Message-Id: <172615242499.556162.4004565592803835809.b4-ty@kernel.dk>
Date: Thu, 12 Sep 2024 08:47:04 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Wed, 11 Sep 2024 18:59:54 +0530, Riyan Dhiman wrote:
> The blk_add_partition() function initially used a single if-condition
> (IS_ERR(part)) to check for errors when adding a partition. This was
> modified to handle the specific case of -ENXIO separately, allowing the
> function to proceed without logging the error in this case. However,
> this change unintentionally left a path where md_autodetect_dev()
> could be called without confirming that part is a valid pointer.
> 
> [...]

Applied, thanks!

[1/1] block: fix potential invalid pointer dereference in blk_add_partition
      commit: 26e197b7f9240a4ac301dd0ad520c0c697c2ea7d

Best regards,
-- 
Jens Axboe



