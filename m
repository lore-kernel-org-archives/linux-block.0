Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E82E7260F
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 02:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764557395; cv=none; b=ELnpn2WAUf/k9tI03ctx6PerCkNf4ku2Kv8ktjAHtQUSaKlh0PDdOlxNl7yBuTpcC3gZobblEGNKdADnvhuTwJAt0s7VAp05aRCQ9dPxU4Ddt/2nnVF6fvK9OEIecVwF5vLC+8Wz5KHZaakr7HaicWbP/6kYOKX17pmxouXomXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764557395; c=relaxed/simple;
	bh=hYkEJxVrr6gPeedbWPWdpq0mOw+kd5SNTJlObMvF+hY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=G9N6XgSrKGPVdmTc4cUr83U7CnWp1I2uT2bMkjIW/gfY2lU1SGFulYXPuXOStqu/3w36F+lAuFE8FT31cewgdNRL4CjOEB+2WLmGFhqQ7UbiOwtoGZWXi+bCpmdtOuBkN+hJTf6rsKF1Kirtl1kejM0ScVz79wUSgt81NEzzsgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G08+8BpI; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G08+8BpI"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ed6882991aso29863641cf.1
        for <linux-block@vger.kernel.org>; Sun, 30 Nov 2025 18:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764557393; x=1765162193; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hYkEJxVrr6gPeedbWPWdpq0mOw+kd5SNTJlObMvF+hY=;
        b=G08+8BpIOkay6R4TxeEfs1UO1bT6utSL8C/9ybmBuwSc9qgF0MKy8TVvy12viWb/Rk
         1dMc6/gB4LfOW5Hdf7kDhT0K7CKvjBjnCO+Yqm74TOCZeg7xAthQmycKDPne5G1VlZHU
         VaDPavtUBa2iDBwdE09ZMoskebHH0k3JJ3WNsRsqu28zQZYQaoUrUN5B3hU8YqamOTRH
         Ozo7pS+LHkdPb+g1BxOPgPSM+WNhjs2fkvBekGP4LhLkjh/8SGz++3GWhcOIA5g4/fA9
         3NCbkRPLzhLylzGrQXj+AQ7Cuc+4rh76DS6JEM5BZMo/qN+XxHBorPjdBP6uMuwbnkNM
         22Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764557393; x=1765162193;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hYkEJxVrr6gPeedbWPWdpq0mOw+kd5SNTJlObMvF+hY=;
        b=MvAC3eHgEF9UjkXFuiKcGJOpcZWc3BLfxHIqWE57Zyyh3tdICPgqcvpY/66AZWyk2F
         CLTyU8EbXV3kXR35YYl4hV9rzRT21YBztfAAdVpzlsQW0kyldp9fR0RpLUpDfKyzzWZG
         RRv0qui1HKUOzWekzHZGbBD6xxbVwKFTs9GsYAgdRLQeHamJjK1DZQgQnNJ3PUsB02w3
         INBc3apC9tHkOVTIMb0+eFLJ+RZm/TMm4hJCNKR4uxAqezyNeGLcSZfEArvFeLzkz0gE
         2X/Z87igoEMJ8PVv3VHvckBHlXb5HLYEY4aSRP6Ko/bJHKQ/G98yTFPK+Yii8Fi8kxXr
         wOlw==
X-Forwarded-Encrypted: i=1; AJvYcCXe82LZfFQB5uj4P3TdkDON2bbZBKxLrswKbnRe4ZGinoYIeumy9pfAbhteTAQBN+kPprFB9jKkAWZk7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzlZrhcwrxsd7hwZuCnB0b/IpAGmjMH3ky9XEI4LL1OqLYIE4M
	FJjJJ4X3w9+WBOOuD/yZ4x96Wi76RePbkLeKgVLBKBveb6SSqzVIZzqeO5JXWdqUa0fOjsdEz+T
	DPFeCgxYT+uKzUJeP0DKLOQggrCDVzXgAE5TH
X-Gm-Gg: ASbGncs60bX5B3LCasB9/vvUuUEXGDxXRXTA6aHytDdWqL+k8OG5hclEV4oEwD7eInb
	lX8nE0Q5KM6UYnbdYJIcRazBntbIZ3DqPCbRr4lLJcI2nkaRB3H8OBADwBEQt6O/oy7n9gKsI3b
	WkQFBkbCFVI7HedwpEQNXCc+YhRlPYGGRGwXodX32lgJ/rxBvbQxARM87/qxHCEgwNpBRz7clOL
	fftHpmqOlw7Z1poHjka6OondopIKN9I5qRByE4ObF8IWInz8ulF8CJvOR8sNoqohd/QLPY=
X-Google-Smtp-Source: AGHT+IHMHWZUpIKd+U2gvM8f3QvXs4CC0pyopjWK9dMI7GD9DZxVsJO8lLrq5dpoyZwFws+kCu6JW4osX+zGhT5svzg=
X-Received: by 2002:a05:622a:1a9e:b0:4ed:806c:69e2 with SMTP id
 d75a77b69052e-4ee4b418e8amr556087811cf.7.1764557392655; Sun, 30 Nov 2025
 18:49:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Mon, 1 Dec 2025 10:49:15 +0800
X-Gm-Features: AWmQ_bmP5hMjMgqU5H0KVWtv-n5YkyzDiO8iqPzfWNNMOQJznUvcruZT5FUNQRE
Message-ID: <CANubcdUGqYsaxsd-cUtjhtCSL4G1kQGevei1m25qKm0ip0-i9g@mail.gmail.com>
Subject: Re: [PATCH] bcache: call bio_endio() to replace directly calling bio->bi_end_io()
To: Coly Li <colyli@fnnas.com>
Cc: baijiaju1990@gmail.com, Christoph Hellwig <hch@infradead.org>, linux-bcache@vger.kernel.org, 
	linux-block@vger.kernel.org, stable@vger.kernel.org, 
	zhangshida <zhangshida@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"

Hi Coly,

For this issue, I've previously sent a fix here:
https://lore.kernel.org/all/20251129090122.2457896-2-zhangshida@kylinos.cn/
Would you be able to take a look and see if that one is suitable to pick up?

Thanks,
Shida
