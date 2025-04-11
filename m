Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5042367D1
	for <linux-block@vger.kernel.org>; Fri, 11 Apr 2025 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377064; cv=none; b=desw7APsY8VQomu45iEI/LTdQLjhinnNaGaVUG0N1J3WYusXzY88EyakInLeJGxe6aknINASL6VeAnFb3VgCkVUmfaSOe0wYlbnaawblnKtxbzkuBmRKfEBSU5ysIXGUk76NjPVzZQmRHbA3QAmeLVtTErwmOL2LX7T5EJdIMwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377064; c=relaxed/simple;
	bh=eAFIWIt6j3rAMdwqcH4pcdzRZAYw4+2Ucoav5WKaFB4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DyuKmuoenQwQmsE7S4RHHZUrcc3+hRJ8a1pWmWAqH4bKnSsqtNxAlO+othk7G6uyH4AWEg6aax2qbO+wSyJiT6LtWkaGnlvT8J37KjzKnrZBkPyblJKk9RFKIGGQeaTU1eepDcMuwi+vl/hUEqFYIie8KiEeYc2FnJSkqAQVDr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UhORnLnB; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UhORnLnB"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-85e46f5c50fso183539339f.3
        for <linux-block@vger.kernel.org>; Fri, 11 Apr 2025 06:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744377061; x=1744981861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjVCOEySwmgLRw3+r4LCbL5rsgRNuVtTfmLLfJr5KRA=;
        b=UhORnLnBy//k+j0jyEzt2qMZAKPvWKq0W0t2oGjdrm21Ha/7jY3xhYgtHmqNehjsiT
         nA2PDcEdRbHdxsiBiYzxUKgYEHgt9c/VLPDm09A85AQ6aByez0Ug1u9ietqkKQVRy0xk
         rR+il15Av54ge0KpaUs/SEJKbZL54P1KAgp0hgcQvVPYWO/I+qBCcgtFqxD60pdNiCvQ
         I3nkQO/aMUBnQIxaQGGoMXUQmqUQAojCI7KsvTM0QYWMv9N888XkM12jG35mEzTf9PnX
         yfh6EiTaI8K7daUU5WJgr71OfzwH3R0HuKKpF/e5SIPWGBds1B6SXzHnCGtsLFiHsk2O
         b18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744377061; x=1744981861;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QjVCOEySwmgLRw3+r4LCbL5rsgRNuVtTfmLLfJr5KRA=;
        b=aMnZ2u97oWEdyRuz34HnCm9u7zPX2uqaEiSVKJ7GdRAhOkfTqWrsI8lcJBeqo1SMse
         4hGAGHDX0/iH784iWKL9dSe1i3iToupXr1YfEnacCMcq7jsFOLas3ZbxmIqUZe06QTao
         kvdx9hxLGB/FB7mfUF1wXyvxDwYe6eixqo1tfb+78uAz6hhzRKCvC4yCjJHULsbNIJ0G
         ZjrmE9S6qkPNyp4aiEp3tle5DbfFDLs9OPTXTqOqqcKKnzLlUFBVyJ3ckEeRyJ+wp3rj
         Z5v7P68wzM9/Y/2UQYoP+5JWemu/eACpK0RfPQFixz0qT1J7aHffRAUORlfAlioytWod
         fZmA==
X-Gm-Message-State: AOJu0YzIz71xVJ0krVFxCzwWQD5g4nPezrslQWm2tAi5FQOlusaXiR3t
	PgScnOxbd4QU20IPaq9EmhDRkqsgGeTQ+gP+l3sMqjaqHv3233/YytlVdZUnyQU=
X-Gm-Gg: ASbGncuyScwpYcM4uwAKjxs/fqOYH7S0YAWMJxDJaxDTlG3fbN+aW76Bt6IKA513n2g
	eNmwjWKu55s42hVD6BNbT2dq+Sq/D0YvAGOiBfI+ijWrhj9NuEEvXeJZAIWOr7OB7U2c9DXp7TA
	ICh3kJx283Gc0KhOIAEA4SAxTM6Zs9VG83sZHgSJeM7hohTja4bzKvGqTYENBB482fwRv7VOVHA
	PRiSJOFLmuEQE65pfv9x9IKzh2rnbJXMTv5XrI/3BD+2H+eMcsKwnw2dYFCjYAAKrw0CWtG99pl
	2+xCbycZmwNrnRj21gZmMsdxJM6U8L0=
X-Google-Smtp-Source: AGHT+IFYDWFGs85o/BU9KC2T7o5KYrQ+mIxni7M1yZjTZK6fAtYcTZxVSgCcRWhZa4R+QtDF3VO4UA==
X-Received: by 2002:a05:6602:3788:b0:85e:8c26:170b with SMTP id ca18e2360f4ac-8617cb0568cmr268622939f.2.1744377061450;
        Fri, 11 Apr 2025 06:11:01 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505e2e610sm1208191173.108.2025.04.11.06.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 06:11:00 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Chaitanya Kulkarni <kch@nvidia.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Zhu Yanjun <yanjun.zhu@linux.dev>, Zheng Qixing <zhengqixing@huawei.com>, 
 Yu Kuai <yukuai3@huawei.com>, Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250410154727.883207-1-thorsten.blum@linux.dev>
References: <20250410154727.883207-1-thorsten.blum@linux.dev>
Subject: Re: [PATCH] null_blk: Use strscpy() instead of strscpy_pad() in
 null_add_dev()
Message-Id: <174437705991.412953.12819263778991723071.b4-ty@kernel.dk>
Date: Fri, 11 Apr 2025 07:10:59 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Thu, 10 Apr 2025 17:47:23 +0200, Thorsten Blum wrote:
> blk_mq_alloc_disk() already zero-initializes the destination buffer,
> making strscpy() sufficient for safely copying the disk's name. The
> additional NUL-padding performed by strscpy_pad() is unnecessary.
> 
> If the destination buffer has a fixed length, strscpy() automatically
> determines its size using sizeof() when the argument is omitted. This
> makes the explicit size argument unnecessary.
> 
> [...]

Applied, thanks!

[1/1] null_blk: Use strscpy() instead of strscpy_pad() in null_add_dev()
      commit: 3b607b75a345b1d808031bf1bb1038e4dac8d521

Best regards,
-- 
Jens Axboe



