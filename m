Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D971DFE34
	for <linux-block@vger.kernel.org>; Tue,  8 Oct 2024 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394124; cv=none; b=ZaT5eRx0FxDVPdGShC2k+Ha1uvgz+IzxyrAs5vwWiQGCfsOmpg7Bi900Cn70jS4dBAm55I01+lukkcrxLNFGFPxn4zxiaXmwsgluEm0+zA0CkpvhRHAbpc4BTQuZ313XfSYunD+28JQgGJ8hRsCJaPJTQV9cMA/CCs/v1vTR8To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394124; c=relaxed/simple;
	bh=sXRgsqscMJfrNdBHQXKCj7kVH0hkiBpVEZlWsfzAKWI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FgaN1Fj5SPNLAqo0HASt5rOvNnRWvcCb0Kq1+BSS8hGzmUa2TgAwbX6saoxYQInGLxB5JqgFQI7h01Jtxp2RfnPMmys1WbTKdWaHfXbNN9vv372mXShdiLRWK6J0t1c6sauqKbCYKAc0sp+1Q5rIFIBO0fWA/0TSHEQbVGy48Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=g0bI8018; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="g0bI8018"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a344f92143so29632995ab.2
        for <linux-block@vger.kernel.org>; Tue, 08 Oct 2024 06:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728394122; x=1728998922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzR0xmpXK4sc+02GZuYOyWk1D+MeANshvVkuAjLRRQE=;
        b=g0bI8018Pj8GBSyyFWVv0Klypygo9QEE0urCstYWT2BIpdN4IyXLVTiN/3FEy/LjeU
         KHcm7lKoyx0F4wURa5xc5sYUHzWI+srV/eBzoXWTsGj2AS4BkXA7+IJb2QN7I4zNDMxj
         AEpU8jNxJTBK8QeiUa5Rwo38qT8BG9PzQJ0iA2/q1cEVR0MS8vfEj8/mwQD9O/MmEkuh
         BlcP39+1+HYbjCkT3/T3I61D163VRt2rZgoHrfOI2C4QBJdgXPubZOLKfXyz864JtNRz
         CP2+mMEZrslNdje023w2/OdtyaxzIr0DOgP+o/CiqlT8Fe9W8tLAeEwwcp655FlKIjvy
         YbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728394122; x=1728998922;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzR0xmpXK4sc+02GZuYOyWk1D+MeANshvVkuAjLRRQE=;
        b=sQzvMA9DfY3LVJpJ1ZX2OLAH+DQj1WGMH4H2+b/2ZtF5EMnFj8sAqvSt8nqXp8iDoi
         tfcJdL5GWJbzpIsuww0abHXmRaWX83O3BSHqaMlzEnjFmeoaksIHK6lnXpfESGlS9bZr
         FNSHgWS2wqxvPJq4y3qeHrJOFYUsmzOww55WD5BYmj5jeyaAxlfJhqZ/cq5BSUZh6WC3
         eHZANYs+3N+h0jJEr7JfTQwxic5NB14aZDgADGb0iIwfQgM3In6gZo0olbUflNOt9ylb
         bA6Axy3Ap9p1YXlPgMzLB9ywkyQzkFcTwtM47KOE1eYUatjNsXOnbPvsxZRd7P8lqJgV
         1gPA==
X-Gm-Message-State: AOJu0YxVZAXljN9ydcyosU6e09MC6q+UgFoRaj/8DoY3okiBCIYxo84M
	uDt7pXLkps0TWJ5x+OX9lA5YEhRD9SL248OpslVWYFha4mNW/QyKYir/Xx7+KBDPXbwQ4Prligb
	Npgo=
X-Google-Smtp-Source: AGHT+IG4d99X/ULTUiQtZzdG6GX3bZ6nDeNUAwg9pbTaxl4nCm2PVmPJBbIXLnOW7Zr2Ok4X46GQDA==
X-Received: by 2002:a05:6e02:13ae:b0:3a1:a57a:40a4 with SMTP id e9e14a558f8ab-3a375b9cdb6mr148432075ab.14.1728394121981;
        Tue, 08 Oct 2024 06:28:41 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a37a7e7cb2sm18287785ab.6.2024.10.08.06.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 06:28:41 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20241008050841.104602-1-hch@lst.de>
References: <20241008050841.104602-1-hch@lst.de>
Subject: Re: [PATCH] block: return void from the queue_sysfs_entry
 load_module method
Message-Id: <172839412106.7534.13389872662371366979.b4-ty@kernel.dk>
Date: Tue, 08 Oct 2024 07:28:41 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 08 Oct 2024 07:08:41 +0200, Christoph Hellwig wrote:
> Requesting a module either succeeds or does nothing, return an error from
> this method does not make sense.
> 
> Also move the load_module after the store method in the struct
> declaration to keep the important show and store methods together.
> 
> 
> [...]

Applied, thanks!

[1/1] block: return void from the queue_sysfs_entry load_module method
      commit: a2c17a5ea44f603eb4fbbdc13bdbcec587060635

Best regards,
-- 
Jens Axboe



