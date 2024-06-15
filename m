Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3311361
	for <linux-block@vger.kernel.org>; Sat, 15 Jun 2024 00:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718411150; cv=none; b=Rcx9u3EtpVml9LdqTnkB1WK4TMtU4DwubzPFdc6EtNmuxpCsvAG2PpIkk4lX1Ug0qdpsUiyMpsBM4lPHLdlOION/+wK5xF+vO9DEoXFSWxd7gTayTT5LGcDoiVKUarAWYIsvLgiPIzQsSozSWbI+4g3WkxpoipJSsDO7GPlkd5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718411150; c=relaxed/simple;
	bh=l0U3qMRsLnZY2lqgtOcYQhCI9pd+f4Bj85pMynNRZ7g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pNYLhkOB98jh3s76iNzpteuMV3xMpckISZzgIrTApjXLOoLq6/fDhzBp4zAbucUYZshiPhYCjOsXzvTZkSSBQmmWQJpN3erIMws7MP36cvzz9+XPP3DVMDAMRR+8Kb1JWYfdhwD5rYeoH3VKmZKsW4jKwbeRSnRZ4qBK8xnL3Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=e4OqhDM0; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="e4OqhDM0"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f64a3e5d6fso1510285ad.2
        for <linux-block@vger.kernel.org>; Fri, 14 Jun 2024 17:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718411146; x=1719015946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZ1xWC5EmOpv9HIfdMEnyUpCiKtYSD98i0rZtjKhl9Q=;
        b=e4OqhDM04cVQLldVMilHNuxofkMICXCGcbdPGmMrfcSxl5H2ldrIpwIRgv/xDZDjrK
         6OfDdpZcKjYuKThc6TLgvxvB4LynsHzwjrTGOnMEHnARoX1fOELGNP7Ovip/8+PObF3t
         yVTk6EAFgTgj/hz82eazrLB18I9s+jzdALmQKAANqILz4IwE+uHEzxa9d6erMBEd+1Pl
         h1Hd3YfUG1HreQFp+trxeqcT9y0KI/cgds/PdChVwWxlSYESUk0crOT6xzE1xj/LJT61
         2QYZqS+/ANOyCRfPpZX3RVvDvjpMZ2f9Kekvj8wJGofUF5ctJNQtdSobyEbGVpHOnQ6U
         OwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718411146; x=1719015946;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZ1xWC5EmOpv9HIfdMEnyUpCiKtYSD98i0rZtjKhl9Q=;
        b=nTNRuun07JK9Q/R9lTP7ek3qVMQ3I4bpDOxyJVJtJ91ICs2owmcwvL6MC4GmmfzO0q
         Y+jCtYQaHNT/QFJhvZdLwccQJxoOn9t6tVOcKbQWHOZYJuxNbN9ZKDjiaXexZSJdpof8
         aIUIMzYTO4o7zGx8k5+TC5KTTGfd52+RWboRLmXC/rnXYFe5bYsQb8kwrtXHGdUrWxQB
         C+Uc63ewavD2O7M0QVufJ28wQkFGKQp8I2Ij9hNQbVOqbXo48d9JN1o41yTSGZNFRI40
         f9tI3JjqzwYN39fuoJqwTYfVB8DAqKVVIyoYloKcMyPuIE2aYOIsnLVuO9busozESEh7
         w5kw==
X-Gm-Message-State: AOJu0Yxn7jGzGviRc2/WxfqDWhI+yvh7IUAxi9M67v8z7Gyyebx4uUvW
	mYG/WYmVJuX+CuTyU0bCqNtvZakJ82aR3Eh9N/m3KBHGNV8z5Bq/0tHuNZunhFKjMglFC7/f8hv
	c
X-Google-Smtp-Source: AGHT+IHZ9UTPYHt91tC5/5Qvaoyc7IMwpsJEF3kdU4Z0NlVDGI8Sbduufq7pAraYmmhrTrg6mthYkw==
X-Received: by 2002:a17:902:e543:b0:1f7:2dca:ea32 with SMTP id d9443c01a7336-1f862c1db23mr45192005ad.3.1718411145945;
        Fri, 14 Jun 2024 17:25:45 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855ee80f2sm38478875ad.175.2024.06.14.17.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 17:25:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: "linux-block @ vger . kernel . org" <linux-block@vger.kernel.org>, 
 Andreas Hindborg <nmi@metaspace.dk>
Cc: Christoph Hellwig <hch@lst.de>, Miguel Ojeda <ojeda@kernel.org>, 
 rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@samsung.com>, 
 Boqun Feng <boqun.feng@gmail.com>
In-Reply-To: <20240614235350.621121-1-nmi@metaspace.dk>
References: <20240614235350.621121-1-nmi@metaspace.dk>
Subject: Re: [PATCH] rust: block: do not use removed queue limit API
Message-Id: <171841114473.4596.16051114715055838099.b4-ty@kernel.dk>
Date: Fri, 14 Jun 2024 18:25:44 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0-rc0


On Sat, 15 Jun 2024 01:53:50 +0200, Andreas Hindborg wrote:
> The Rust block layer API was using the old queue limit API, which was just
> removed. Use the new API instead.
> 
> 

Applied, thanks!

[1/1] rust: block: do not use removed queue limit API
      commit: 5e3b7009f116f684ac6b93d8924506154f3b1f6d

Best regards,
-- 
Jens Axboe



