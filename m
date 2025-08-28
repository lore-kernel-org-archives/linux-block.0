Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5456C250BF2
	for <linux-block@vger.kernel.org>; Thu, 28 Aug 2025 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756397190; cv=none; b=NHJU1iD97IRisrKwt+AAcUQcccVRI1obaHWcCxITOiM6CySxX/9xIdsJhZlqPe03cQ/PIGRcjWuiW2DXVJyPvFy0+n7ILv2TgPFzKILJCUBJtkMCEdSJunkTq63/sBVso7X80ZEmHnhtl+qgOU//syC1ZGgZsbAlLMNbcc99ifU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756397190; c=relaxed/simple;
	bh=Xfed49w/j895hUQ4WC6JI5uU4bCQvEoU2MX25kF5DgU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mGYVImc5CXkYN4KV51XQ5MWvpRBHWElF55/39TV7horSk573NOjuOQ/v4wWwu7RRrrVH5QIRw439a5o/XLtqSooxYG4Z0kCO40uiP9VJiiFN+MPnrZ4F4TX2R3Xm7v7SSU8FIhF424gJZ05uhTPLOQLK4Q9u5dvaKl+XEVrqUdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wj3pEbkR; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wj3pEbkR"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3ec4802d43bso11180835ab.0
        for <linux-block@vger.kernel.org>; Thu, 28 Aug 2025 09:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756397186; x=1757001986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVcgehLU7koY0n61CAA/8K7qOPY+THIxVHvuwo9n41c=;
        b=wj3pEbkRiKx3YYWHkNgdXh6ug1YOjzYoy+chpULEpyAhBBqfMz4T2BHDyqfsM1+TkR
         smOowSNaAkANbSccyYheGkW8ACMCbnRpuTicOjdC6F82Mai5ImGCh1NCfC6BkfQBhdk7
         /PaCh82c2TG7Pi+ZldbUJHBUckEdfDrwpqGjuJvcSchm6Ui7yCmWKH8yagmRGRll1bt+
         paHwi4PyDeOWHtxQqdYQW2K6e3FlTGhdO5laS+MCvTqVaYCy2DpT3UqJbuvsAyCU9KWY
         OmESi88LX5umGOfWzYiYsnCmhKIZhA4/PYJUB8j/oG03BzYn+fwEw+Y6I+FfGv5HueYB
         kJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756397186; x=1757001986;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVcgehLU7koY0n61CAA/8K7qOPY+THIxVHvuwo9n41c=;
        b=OnPYR7MRZ8K7OGgeNoXSVmE5Pp1OIkebQDXPat0268l8pdEgYj3dtJ2RR+V5jbbK3l
         n6FU2zZW2sjhpgEiLdGVzhZfzeHIfgfhbWNaZzPrj02EU2HxvlUmb0ZKS+6ibxzGRmhM
         Lg5rvtzA93ovgmG3zj63GH6qLZX5sDpmrUrUa75NjfS/DswMA0UwRmFmmBlvMKkKv/66
         RtOmpxnso5vYcBzjrFZv3/z/sTQBHIXS3V/yv5vn1wroEtJBCmlIzWbalXmKvBO3EZGR
         7oF1Gfd60gvSIsONINQnCp9EfcrycFi+fOUKZ0mX7ygW/B4d/Swq0o/DYQ1vyvaVrVnp
         rXBw==
X-Gm-Message-State: AOJu0Yx7HpO/tjQbLj6aa2KigTxDldKeCTM2b7lbkns8kXM04ocboCvi
	pBUHv5K3R9iUKGcWGA48ChrSoDoSjlnpsT2jfqGMu5i7f6zJoRrWe0UQEMLrxY6m30C2r87Oqhf
	KW9Yu
X-Gm-Gg: ASbGncur9NoA9pwAJIGACxQJzyI3qS+oW90KxXEIQABUg6K9BijgFOwwXDhXZtLGJVv
	sy3QSTWnMx2747clFQYk98JZGgyyfoNgKtA00s0Vzh63BbXR60DLezBGYmugwWgWKE3BHhODDNo
	41lS6mANCwNVo3BCaPF84iyza+nTAci3cN9lD3cuwJrxCRDDf9oAN+63GKtOifAp2dpUzcz6axj
	MuQ9ydHQ6zUwWMYSzhXo2be1eAJS9IVY9AEzEIL6HFanu81qUZ90i5vUl96+gBbBRrbyxM+CzSq
	aWx21LuqbSMK7gmoiWjGUbhmqSRyWOP0NAG5dyvO6E6p91sufxsZ9g2Z1X2Nea50jnIO05OKQaU
	YycLQEbRuFhB5eg==
X-Google-Smtp-Source: AGHT+IGtCqksd0vhhRUONKLjnY3YNB4P0OL5Hof/gDaJqktkdXZUqgz9EdCkp9LADlQTZqTe5w7aVw==
X-Received: by 2002:a05:6e02:16c5:b0:3e5:5cee:a9ba with SMTP id e9e14a558f8ab-3e91fc22d7emr358031125ab.5.1756397184182;
        Thu, 28 Aug 2025 09:06:24 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ea4c191f23sm111747185ab.16.2025.08.28.09.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 09:06:22 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>, 
 Keith Busch <kbusch@kernel.org>, 
 Caleb Sander Mateos <csander@purestorage.com>
In-Reply-To: <20250827121602.2619736-1-ming.lei@redhat.com>
References: <20250827121602.2619736-1-ming.lei@redhat.com>
Subject: Re: [PATCH V3 0/2] ublk: avoid ublk_io_release() called after ublk
 char dev is closed
Message-Id: <175639718236.484892.10632372373584799794.b4-ty@kernel.dk>
Date: Thu, 28 Aug 2025 10:06:22 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Wed, 27 Aug 2025 20:15:58 +0800, Ming Lei wrote:
> The 1st patch fixes ublk_io_release(), and avoids warning from ublk
> selftest(test_stress_04.sh).
> 
> The 2nd patch adds test case for this issue.
> 
> V3:
> - move reference counter reset into the check helper(Caleb Sander Mateos)
> - remove 'ub' re-assignment in ublk_ch_release() (Caleb Sander Mateos)
> - improve commit log
> 
> [...]

Applied, thanks!

[1/2] ublk: avoid ublk_io_release() called after ublk char dev is closed
      commit: c5c5eb24ed6177fc0ef4bb75fc18d07a99c1d3f0
[2/2] ublk selftests: add --no_ublk_fixed_fd for not using registered ublk char device
      commit: 9b2785ea8592f239836405de023c75c4f3f5ce00

Best regards,
-- 
Jens Axboe



