Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D773195FD1
	for <linux-block@vger.kernel.org>; Fri, 14 Jun 2024 12:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718367699; cv=none; b=nXMH5ZJj9n4w4p/YzHQ7V6YJmRKg+L8HroD43sWL3D71nPNzbUXDQEPmYJT6Hl87gNipzEBl/qJVgh31YAtYvHle/YKtNUixJzWmN3T3HkiSCFHBQqbnQ9RvdbZByhJwgJhs4USrIQgmY5Un74BW6N/uCOZWX5g14Z4H++82RA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718367699; c=relaxed/simple;
	bh=vVMnkKP23EquRnJbPIazwvrYt+/IR7+ZK7NhvQrGL3k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A0yWK5PDhVowbzbGT2KkLRBBK47SGyXcGzm3gjYfHJkQEpATbkn8lx+fdFsiA1Gall8VN6Cga1dQoxZXZynH7J9sdbeQSPXCaGIo6dRSvus4A4bokarzjmEqNI+18y/EgmIOer7oo5RmnwHF/QYNAAIuQGijK6RbIVGo2oukL5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NjiY0UgO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NjiY0UgO"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f715fd5e60so1936905ad.2
        for <linux-block@vger.kernel.org>; Fri, 14 Jun 2024 05:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718367697; x=1718972497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBGz84Kp8zPxGVcYMqV/SC8aRcbUSCJ8X0DqtX5D0Kk=;
        b=NjiY0UgOw6ApJ7NE+0JfNxdlS1kqzqHOZuCwSW9Wprg6hXrNyYDCx2NC7o66tPKTsE
         WP/Y5GRqKDV4bFS6vvCkzPLI5Lbnn4e4USFv+y+0/RRkPtfWZwsPE1cyWb1fS1sDaHbj
         vDSVuwC6rDSX47dcqv9C33zPKJcZP/b2FeotCnBWi2F8owsC2ToDBOaXqyIk6FqLROD+
         FodCTNpnpeTZ+jeEvjAX+FLguRX5F75GT7g9cJhcGx/YcaP9bwIhqTS2Pu5X2eRBM8OQ
         pHKIHO/aDEMGvxYQIXNQ7DsJqUFaqLdpwsI4ity9wq+zVD5/f+Vep9ONjrY312gOTMYk
         5hcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718367697; x=1718972497;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBGz84Kp8zPxGVcYMqV/SC8aRcbUSCJ8X0DqtX5D0Kk=;
        b=Y40s+9iu4udSVbvT9GownyZBkduh9N88iOdNt/ff0xqCiy5vw/tiaC31xjXgTPnVsx
         eizQQt+WbeniJy8EatXhDaAbLC4n3MCFLzozSHzOnyNWBevuYvz8pwp2GwVWG+R7hzxJ
         EskYhzsyGiWZ4UTusWbhyiTbVxTNcJRW4GLcrSYOz6x+bSYbzmTaB3gsC/QxBX9bw6Qh
         x+1BVjx7dnIS5uv+44FjJjy+OJ1g1iz9/sxnn8t2Id8SXeIywVr0C0r4zS2mvD5inM51
         PLRrbmGBuscXit8Uld6iRWBr2HbEteBghS22zz22r3aAJlm7Ya12e9ODZOFZMGeI4Jea
         2xcw==
X-Forwarded-Encrypted: i=1; AJvYcCVckKi68aHbRVbbopOesZmcA1Bgkx7CbMM8T1p33og2SjgyRYCbP5N+nDf6xX2j76W+wlN6DVed9peyOrKuw6AVsIZVx+DL3bwaFu8=
X-Gm-Message-State: AOJu0Yz5zThQfL41U2BFhXx+8EE1mqAf45Cjw11wz9YLSYpsSt4Z9xZB
	KH2QMI31SuDdM0c+74svknxgd6pbIkOUIFyS+f8/lWVV0zyZNU4TytmpWEWPIws=
X-Google-Smtp-Source: AGHT+IGgrI5Z53eE6slIeb5D//L9zkN9U1Fpf2jCXTu1Zs6NpCOAXPFi1P0d0VowXih3bXAEQZq2Pg==
X-Received: by 2002:a05:6a21:183:b0:1b2:53c5:9e67 with SMTP id adf61e73a8af0-1bae8259588mr3195150637.4.1718367697350;
        Fri, 14 Jun 2024 05:21:37 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f3947asm30750075ad.264.2024.06.14.05.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 05:21:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Cyril Hrubis <chrubis@suse.cz>
Cc: Jan Kara <jack@suse.cz>
In-Reply-To: <20240613163817.22640-1-chrubis@suse.cz>
References: <20240613163817.22640-1-chrubis@suse.cz>
Subject: Re: [PATCH v2] loop: Disable fallocate() zero and discard if not
 supported
Message-Id: <171836769633.229112.12813343173922846778.b4-ty@kernel.dk>
Date: Fri, 14 Jun 2024 06:21:36 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 13 Jun 2024 18:38:17 +0200, Cyril Hrubis wrote:
> If fallcate is implemented but zero and discard operations are not
> supported by the filesystem the backing file is on we continue to fill
> dmesg with errors from the blk_mq_end_request() since each time we call
> fallocate() on the loop device the EOPNOTSUPP error from lo_fallocate()
> ends up propagated into the block layer. In the end syscall succeeds
> since the blkdev_issue_zeroout() falls back to writing zeroes which
> makes the errors even more misleading and confusing.
> 
> [...]

Applied, thanks!

[1/1] loop: Disable fallocate() zero and discard if not supported
      commit: 5f75e081ab5cbfbe7aca2112a802e69576ee9778

Best regards,
-- 
Jens Axboe



