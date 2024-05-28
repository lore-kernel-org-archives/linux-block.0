Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078E016D9AE
	for <linux-block@vger.kernel.org>; Tue, 28 May 2024 12:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716901047; cv=none; b=X7ndd2Leje4BvQLESfk+0DSHpg2gr+SBNG1xv6pWP/O9Vekvvo9KecNsSp9IaNIsuKsWycbIXDPCKc7H40Zhxx4MyE1vwSAJISLmNr0MwJkHk8RfCEepB2uGvGEa+t/83FyNeeQ9qF27PfpjSlNN241BJdATx+AL3iRoPexRTH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716901047; c=relaxed/simple;
	bh=TbCEVAgT2bL4szX995m159LHLuFRWAlQTl80rsPHll0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YfBNM9Ks2JhVBdpLdQ+e0BLFy4BmAZE28KeEZJ83SpVdRdvq9vHW4L21y644qzc9gjjvWDW6KABkWD7u5wkmVv7WcC7FVlvFgtlfPcQtEk83216V0o5uLrfoUZS+kcO/eZ6+HBWXxx21eakkBZMTUUDbiH2VL8HPGEDTPrWI178=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uwVuUD+X; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uwVuUD+X"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f3221a572cso391595ad.0
        for <linux-block@vger.kernel.org>; Tue, 28 May 2024 05:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716901044; x=1717505844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+/Dy6d32ZZ6ySSxfWNm/Xvo5t84LbjhP0HqIw+U7ns=;
        b=uwVuUD+XzJM9JVTk1shNmynoZx1zEESDVCJO9D3VYPd2xBYmbkSNlCqhLL01XPvnrY
         z7r/gwyuguAPToN13KZ8YyvA6PxMfvhmovE11pNFg+R8HCc+YTpOtUGazqcbswBHk9td
         jhaCl32Vn2YBD1r9c9SfYkrur9BKEe/vXCDcfAoNePLFRV/hvQwjkNBptuDb9HhV2Fk4
         Y48uLNUq81VNxogrYuoKOo7hu3RK3uyEzyTYPIpLH3GN6GCmAFX/iCfgPOI/z9WRECBV
         1KvE8QZTR2ZOX1BonxaivTL/+fPfD4ZW/8AcZz6AlSRr1Jhs5wxTVu56XNLoZIYaQgVG
         HbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716901044; x=1717505844;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+/Dy6d32ZZ6ySSxfWNm/Xvo5t84LbjhP0HqIw+U7ns=;
        b=EyqDf9yOyAwLM3RWlmCOia1IYvQhnwvomtoizY8o6K8SpOjCJYuPHtP3wh6xWKKJcb
         +NWvJgQl4eOF+mcSPltbdyfVtmwLvKU8EuAXGLZMsAROG7AE5MzrzeYl2GB5FHEyx6Jh
         vOt0peI2GdcToWI2lWepMBoIz4YLXSqixEbWtKsGpyrmJaY5JmvTLFEFOM+rRFwnZeVr
         /5QGkPJqW+CMwwsaprbDPtXSXgWLL/zv70c75CQ+MFkksAzRvrzzFA2uUqwJfbkWY9so
         7tz/RIH/OXBC2zzyinPBLsFFw2JvC6+Agg9WsAkmYRJXV28A+Cekv8yZ4UTRwYoOdo3b
         7TFQ==
X-Gm-Message-State: AOJu0YxqhgHFdcK8bj9uB4Tvnmg98mxe8is0KyEiUFFj6aoM/NIKZC00
	RniiRTytcVkR3lFVM3U/PNS2qS6VocMaesIEDY363eUyuEgUIwsRFZYP9WpkzZoR2WLt+6tg3P0
	p
X-Google-Smtp-Source: AGHT+IE43y43apB8I/ndZQ6RyN4HcmEu2gbR2VadbedYataZfMTqNkp891yeOXO1D9FqZTM21QNwjQ==
X-Received: by 2002:a17:902:d4c8:b0:1f3:10e8:1e0 with SMTP id d9443c01a7336-1f4486d301fmr133695545ad.2.1716901043708;
        Tue, 28 May 2024 05:57:23 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c967ac0sm79255505ad.180.2024.05.28.05.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 05:57:23 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>
In-Reply-To: <20240528062852.437599-1-dlemoal@kernel.org>
References: <20240528062852.437599-1-dlemoal@kernel.org>
Subject: Re: [PATCH] null_blk: Print correct max open zones limit in
 null_init_zoned_dev()
Message-Id: <171690104272.274292.8627404989968230392.b4-ty@kernel.dk>
Date: Tue, 28 May 2024 06:57:22 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 28 May 2024 15:28:52 +0900, Damien Le Moal wrote:
> When changing the maximum number of open zones, print that number
> instead of the total number of zones.
> 
> 

Applied, thanks!

[1/1] null_blk: Print correct max open zones limit in null_init_zoned_dev()
      commit: 233e27b4d21c3e44eb863f03e566d3a22e81a7ae

Best regards,
-- 
Jens Axboe



