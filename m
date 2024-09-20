Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A523E79C2
	for <linux-block@vger.kernel.org>; Fri, 20 Sep 2024 06:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726813278; cv=none; b=ICco0PgGfzzeBqToyFapSlpHwZz5oahktzHwCsmtnvComvzSZvc9UKGRUAzkYM7E0RorXcXVHnEbQlPKr897Rjki6NrE/lS0XMnfzTurXcHtAlAaXerLTHCXoDtf5a52prM8De4CB+LFvq0Ti2h2mRdUWKEaXM5SDBjw6wzxfeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726813278; c=relaxed/simple;
	bh=x/8tp2rG2IGjz3caKUOsHBf1tU+8jqDcVYS/WbSU3e0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j+YbDnfvsqP2xanCIePJe4l3+npH6tpvWdhso8UQCNO2gjC3e5hTmYf8Kg1N2KQeK+kP7Z0QRrJlBRzNGnd1RtpIISparUGS2xWy4yQWzKyxYL6FmyqqhijmmoPCj6OlOd+173wOCl3JzU34GPyiSILmZQZZlvI79tzP0/Cjk9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LTh7HeZW; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LTh7HeZW"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42e7b7bef42so4234075e9.3
        for <linux-block@vger.kernel.org>; Thu, 19 Sep 2024 23:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726813275; x=1727418075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxTie3o+2ZAtDp1PjLR/OoHHfq8L/seIGfduFy59TX0=;
        b=LTh7HeZWtIGXVPt0Mrt7EWelvIshHb7hBcYxtTAUhn4Sj7UmbIZRR0+VpT5vyuhSFp
         wk/ek9hrcI+uLCRI0E6uaghUwmQlWIUytkyKWWU/2Kt1ezc0TOuMYuMjVTd9GSW245qI
         ho6r/tYolGjcyWfNCFeo5JDLBGBTMXx1Mi0SLT2xKWUU26hqw9I/iXwlC6ksRGWhi7yF
         JP5GD5a1uA7Sx7C4ygBxEyK/RLPYeR7l12ZJ15yzcH4MR4tijiiEnRM18WrnssYXWial
         /vhpHWKOdMivuTUuZ7UMIe/fXDMsBBNxjeW55QSUMvGTwBNb6Jl60IireAG7/wZC2/mR
         9Yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726813275; x=1727418075;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxTie3o+2ZAtDp1PjLR/OoHHfq8L/seIGfduFy59TX0=;
        b=K9nx0i8c+PS4KfScp9DaliHiGtoOHcBArTrxxwPxG3xaJ4vD1WsH8oHhxbAwP+arZ6
         aFKyqrqNhU/L3NOoxWTZTvoKC1jDSjxwgxALRhDJtsY5ff73vs8v3vThymjXpv9IbAgT
         /ubooHrljI5QY/RE5i5myVipoExNf8k+LTeovAEm9WQdLjx8s5kTsv0NDTZur/bj1VwD
         xT7PYwQLQRfRLCWUCOUT9cucbKPYLagX+PKXKSceTerNj/8o+LmCdnWbDR7telhwwl2y
         IPQoAmn0TxQo8MLozauVDUqueR0bhKuLOBsIFEv65MYJ/myd3QIQrcL12Nv4UiKBwNwY
         3pbA==
X-Gm-Message-State: AOJu0YyMmvN38RyQxokakohS06NbfMoQKYujVA1CFuiuTZDi7NqW1/sH
	T62QQpC6Hccs+ssjOyvndEajEUxVcb8PMr/s6a+W2iyxxF0h2BqTtfDlPc71m+g=
X-Google-Smtp-Source: AGHT+IFDk27Z4fay6biiUFNe4AdHuKGgvRLIgi2So8WsIf4hjeHOC33tIt9lsKDztH0eS5Ca8llS8Q==
X-Received: by 2002:a05:600c:511e:b0:429:dc88:7e65 with SMTP id 5b1f17b1804b1-42e7c1669f1mr5983665e9.12.1726813274678;
        Thu, 19 Sep 2024 23:21:14 -0700 (PDT)
Received: from [127.0.0.1] ([185.44.53.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75450ec6sm39780565e9.21.2024.09.19.23.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 23:21:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, linux@treblig.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240920004817.676216-1-linux@treblig.org>
References: <20240920004817.676216-1-linux@treblig.org>
Subject: Re: [PATCH] block: Remove unused blk_limits_io_{min,opt}
Message-Id: <172681327241.42824.15179757360545790108.b4-ty@kernel.dk>
Date: Fri, 20 Sep 2024 00:21:12 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2-dev-648c7


On Fri, 20 Sep 2024 01:48:17 +0100, linux@treblig.org wrote:
> blk_limits_io_min and blk_limits_io_opt are unused since the
> recent commit
>   0a94a469a4f0 ("dm: stop using blk_limits_io_{min,opt}")
> 
> Remove them.
> 
> 
> [...]

Applied, thanks!

[1/1] block: Remove unused blk_limits_io_{min,opt}
      commit: 9ba5dcc722de4390a1d3211b2ee3c864f84f5461

Best regards,
-- 
Jens Axboe



