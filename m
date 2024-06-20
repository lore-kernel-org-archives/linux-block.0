Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122791ACE7D
	for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888166; cv=none; b=ANkb0OdzaDrDl5bSikztLvthC6Cb1Iv+u/uyAkBwUm55dwq+S3piCtFSZGBxmeSC597RKFB7KAfh3EZslsa6MGFbe0W+eoyTMM6mIZ6SO35rwIMzN01pVTpYvSyzV5jzwwYAUxoT1EQsHqReX2+T6epsZRZHq8h7Fq4VFjQ7dJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888166; c=relaxed/simple;
	bh=ateVPGwZWRqWgrzEePkU8GYxba0F7RUIaMPla2FOLzY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UwxtSizkzhU8ULye929QuDZdOdJJwViSr9gJUB4QndUnNd20NaIlqJUpp7GTTZo1DXABxuuuf48/6WeJMEw7sBiYVeTCYBM9pAbkYy2oypDMWasdljsl47Ihec8EeQBHBr/3ESvb6LZqWl/nmEpeSHzwK3fwTOhqR/Oh1Y/0bsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=tdKYfe7x; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="tdKYfe7x"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7119502613bso121832a12.2
        for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 05:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718888164; x=1719492964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5St0ktoDMEqWPkouwya5YeNzIQyT2jMo5H1z1O9YFw=;
        b=tdKYfe7xNp7H+LTKjrMGpQgqu0Zb1Jrs6amdi7oUtLg8JgVCdct2d6QWdfMoe8M/7l
         yFOnXwpBMTiSdXWWsOXqB+8QeI9mVp8PdtSW3fR+kuT1Z6bex51ns0cZu+xGlmHn6ktf
         5Gqf9KGTGdgfJ3vxcMqs2SsrJUvtKgkXcRkFRnuybbuffO6sx2Dww5D9ZQuVckzX5Pfv
         ogYqnhm2BrBuLvtllgIDywMdXNsjIOcKGZ20wUA2vHh7xeJQPm6CY/2LDT9RH085i+WH
         k2f8NTG9r7+M1dMmgsehhqFHJWdde5/79mZLK7rzo1R5xtaqGzfscCI2HNDipY1Jn2/2
         JQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718888164; x=1719492964;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5St0ktoDMEqWPkouwya5YeNzIQyT2jMo5H1z1O9YFw=;
        b=lQYyak73/uOi2s4s5g09bur+mv8pAFUYXyibWyqsbfSIKwk7UUVdKLTBp7yuXS6z3N
         kbw2283t6/tKKUQmwGLFFDH0QOwhU/PAniqlIufOUB6AznkB66axnqwmpGefsMs7+eI8
         C68bzOAPQNwULyxAZwnDJIh2OsqAO12DwSOdSeVrc/b5Q6TplIMY/bQ25WouGxuaBmgr
         o9afFY/3LosvOS+su8dcQIlZZI5YTrKFwCXO9B5HCjAyy5pzFihmQGQp5A3s4Sq2yql9
         a9ybdEbxoSgGHsib5MJAm6NPKGx4QndJWph0ZE5l+01bHej9rUwkjVRaBfqWaXU2MNhj
         9cEg==
X-Gm-Message-State: AOJu0Yyv1YJm7FWeeXWQ0Rhn1aTvtdj3y5VMlSByyIGHxq8dOgaO7+vO
	FM+l6UgLtZkxV448er1MSMmcChBt8Iwfm/Q5rsRjbx42pxcqxERoXizsJrU9PgA=
X-Google-Smtp-Source: AGHT+IF5S0Ljn2maa2dnbZdtaRiMlVn954LGvI/2QWQL52Y/NiRCwRjwjJjG+fkms6qwgwCF9cVu0A==
X-Received: by 2002:a05:6a00:2da8:b0:704:173c:5111 with SMTP id d2e1a72fcca58-70629cdba7bmr5533386b3a.3.1718888164151;
        Thu, 20 Jun 2024 05:56:04 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb8eeb4sm12207576b3a.205.2024.06.20.05.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 05:56:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: "linux-block @ vger . kernel . org" <linux-block@vger.kernel.org>, 
 Andreas Hindborg <nmi@metaspace.dk>
Cc: Christoph Hellwig <hch@lst.de>, Miguel Ojeda <ojeda@kernel.org>, 
 rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@samsung.com>
In-Reply-To: <20240620085721.1218296-1-nmi@metaspace.dk>
References: <20240620085721.1218296-1-nmi@metaspace.dk>
Subject: Re: [PATCH] rust: block: do not use removed queue flag API
Message-Id: <171888816288.139187.2534771851579551640.b4-ty@kernel.dk>
Date: Thu, 20 Jun 2024 06:56:02 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Thu, 20 Jun 2024 10:57:21 +0200, Andreas Hindborg wrote:
> `blk_queue_flag_set` and `blk_queue_flag_clear` was removed in favor of a
> new API. This caused a build error for Rust block device abstractions.
> Thus, use the new feature passing API instead of the old removed API.
> 
> 

Applied, thanks!

[1/1] rust: block: do not use removed queue flag API
      commit: 5ddb88f22eb97218d9295e69c39e0ff7cc64e09c

Best regards,
-- 
Jens Axboe



