Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C8383CA1
	for <linux-block@vger.kernel.org>; Wed, 10 Jul 2024 06:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720592635; cv=none; b=jcKvyLUBmxR8q+2eKEyrRWuxM1CR7/vLlHhBL50fKGeN/wJ8kiEYBDheMcsSjj4CrDQuo06o854CPvO1Ymirey/XvmXNsRl6xxw2xUnT/EInWrEHvVhHp4W/1+7DPNSbihUFGGJPiuKtiKyCxz6XvXqG0fDUT7TMb2/j6dBfWxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720592635; c=relaxed/simple;
	bh=6s7so5c7HOknihvumh3Haewm4qizE8uH5cVOjlcBNW4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R5BEBkdwV7sIWrAkHdAXGoXhmG9oibbtwnqBTsRy8Hn2VbNFEQp/239yROAnSSCZDO9W0G+bmawg9/x5sRq37quQ8I5WrxKQ/WuGhXpHGfWVP86PVhIVIc6qug/RbyOdwjpCm2/yPYsM7E6kDO4B4gcfX4Pg5nOn/L5/jyL5+Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cAoOEajs; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cAoOEajs"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ee9cb8d487so2834991fa.1
        for <linux-block@vger.kernel.org>; Tue, 09 Jul 2024 23:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1720592632; x=1721197432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=assg/spa4cOMqEpYiqy3ecAcAwnhbvPRfb3jWzWA0iQ=;
        b=cAoOEajsdhDU8va5s4PHGyPaNulXDepCAefXzmlZnAWnst8moQ5y7AQaqh1jXiBNp2
         7FOQa29N26sqz2xs3H5NgHjg2EPhZQ5rCO/UDgkpEAoRG2+BH+9K3bMd+qwXNIWgENDq
         9VLav8cwsJSYX/99U7eQ5qR7feS374tthDGjz2/mRzqy+mADE83nrHuBgDu+zurQH8SG
         sopn9KeaOoqC7O1fxdYOJvnz/D/dakD+NPrUeDkxMvF36yLdSEKWZGBHbldggjgbEPWO
         BCmofiytZC/E2Aqy7eoGb7rispIIIHC/XO/N+yi041IBqCLujFD3+1Llrn+ZI/mJ1A0R
         nH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720592632; x=1721197432;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=assg/spa4cOMqEpYiqy3ecAcAwnhbvPRfb3jWzWA0iQ=;
        b=fIcvnr7Qvsr4XrdMIdT/LN7GQNK6EBIXDGsgekEJKoD58lUeHd9CrzqiBajOPq37Vr
         XdKeD2oZU6etgPz1BWxEeiiVjYtQYJPBDd4zMRvEfZJa2CS03JyaVa1bDJvoBN7yu8DG
         IKI1My/T/xS/oyrokvAV8d19dMa7rM/ktxhVMYZluFf2fD7/38BWymaEXUwJwQ++XNuN
         sdgLdKCCZsBHFiIY2wyViWrFiS2cDJmnu7X8EUreh23rpi2l32jHdOWy3xDp1gRTyvF2
         hcJOmlr7saltaa5EmCby9GasxMI9Z6f50cskj0JC14bo9bVmcbevcrZwUY3kRh4zSYb3
         OG2g==
X-Gm-Message-State: AOJu0YyJ7sfBOr6h3S1xrLWusnxlORs0+ZmBBvUIVdCHsurZ9b4f4MTU
	7sn1HVXcBNk4mQmt656boC+tQowJVKx2OBpW6iPMh3CY4Gi0gidb9flT5MFwc18=
X-Google-Smtp-Source: AGHT+IFrolNW5lOMuUJhl618lI6yjdNOR6K82mCSLOdcX6udq8FJVW5dASBzQo09mgslsZx9YSpn/g==
X-Received: by 2002:a05:6512:31cc:b0:52c:dd58:1a97 with SMTP id 2adb3069b0e04-52eb9a0498bmr3119303e87.5.1720592632042;
        Tue, 09 Jul 2024 23:23:52 -0700 (PDT)
Received: from [127.0.0.1] (87-52-80-167-dynamic.dk.customer.tdc.net. [87.52.80.167])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52eb90670b6sm463892e87.197.2024.07.09.23.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 23:23:50 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Denis Efremov <efremov@linux.com>, 
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <20240602-md-block-floppy-v1-1-bc628ea5eb84@quicinc.com>
References: <20240602-md-block-floppy-v1-1-bc628ea5eb84@quicinc.com>
Subject: Re: [PATCH] floppy: add missing MODULE_DESCRIPTION() macro
Message-Id: <172059263066.380385.1122582379768544116.b4-ty@kernel.dk>
Date: Wed, 10 Jul 2024 00:23:50 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Sun, 02 Jun 2024 17:05:31 -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/floppy.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> 

Applied, thanks!

[1/1] floppy: add missing MODULE_DESCRIPTION() macro
      commit: 3c1743a685b19bc17cf65af4a2eb149fd3b15c50

Best regards,
-- 
Jens Axboe



