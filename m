Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C2A21CC47
	for <linux-block@vger.kernel.org>; Wed, 14 May 2025 22:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747262039; cv=none; b=ZoXoeOhy/B97LzM/zHqy1OFEXgA3HylTQ9uW9EC1wS38YynMeFyNw18xjRN1nb6oPEoqNTfTmBnqDU49zhR7i9ohUqLl4XxbP50rFFMl58yWX8QSszeYoB2dIi+3j3rcicfzzVuPlAJvwp0XiCjSwO1RWL444jAx4A9RYszWIhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747262039; c=relaxed/simple;
	bh=B8J2oivJseBMPQrUgZVW9Y0ZHXhKXI2b4ldVHnJLovQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qAs4n+b30qHX/dS/g/S6oF+5VMn9VLZN/TTUkOex253EhWrHZfcmFsF/4X+9duQvVzHj9xI2g7gemWr/4/UB5sdX2iBlh+qBf+nKQ5SdOJqNXr4K50xZ0BJ18cwdllgyhoBDslI0O8wvzlsGzDd8rUP2lnSRFwcIpAQLVuNzzyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b=ZSmtmE68; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b="ZSmtmE68"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso3091665e9.0
        for <linux-block@vger.kernel.org>; Wed, 14 May 2025 15:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1747262036; x=1747866836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WM8wBU9NOuQB9PnGaRITtJbaX0oOQfEKz4wQd9LT49U=;
        b=ZSmtmE687HhkHbU2k7U2UIhLhh2EiVIU8chno1v3yq0YinB2k+rm88jWQ6c5sHUBKy
         wcs72XS7AyR1dNJKr43VKeKrjva8rMFTtcox1eUYEQMLX01GNAA/ON0q+CGZGnFRFW3Y
         5PNMnXtLGkEf0rp2m6U9oOqGuWw9ixEntYsyA5T8noqbD1jlFMbUzfhBwr+SKb1OyUlv
         v8KywsyR1G01n71+vRqDY7mgfPiYQaCyyiQ7iCluf7EiQjmScQf06SMYQiQKGD/y5jqH
         DDwGusF5h4lVOBnt0zQrg+KWWfNi4y8/Inojr66JB7OAZZ9zAYiur804P8YGz7Z6ZAgP
         0crA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747262036; x=1747866836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WM8wBU9NOuQB9PnGaRITtJbaX0oOQfEKz4wQd9LT49U=;
        b=c3uOTQz+pMxQZ3cZVIts6JTHkZTEJF6coY2QY7//b/b2W1QBnUPQ+eta10xd+mUqis
         FNQl9wvrC5y+Lphh4g/FkhtOYKC5lHFWzpjlMeI/lgcxDmC69fY4iSKSPtDby2gAAs5g
         V6GzdLf3qv8KcqA4ZXP9sdSgt7ykEoEbKaPEr7J/xsGiuxubfv8tW5MlUEV71/0sRNAq
         Lg8f7Tc/vREW7ya/hdl+BNrzkBx9Fntg9LpOpEGBrMj3zcpdERaGyW64h6MSMmFRu2ag
         s9mhy9+9JxAq4OFnZvHMf2jRGZnFkGB/qFsG+mOQB3uP+7CX3nqyd4oCv06rMI9a8GNB
         Dyag==
X-Forwarded-Encrypted: i=1; AJvYcCW92bTxrVoJhyoWNP9kI9wPbLQqF+EmNKL960mJq+shwOP2eV2qC2wPZtmIcz/BoID5mKi+oplq7C8AfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhcIrcu90Q2IVNLUCSaqDpTcin6YY3mi+3Nbfe3OrzEbBIlZ1u
	WVCfdy4VUMlPUqIonXgiBhZAnk46YEASf4Fkz7qPy8toUuery2kchjbBfbiNDrM=
X-Gm-Gg: ASbGncumzmCAH6wkQKFJrXKpUjK2fu1XwBEzRO+ieD/Xwo2As3md8qgCDlDNc7P8Btz
	+1YztP4ThiSmZ7JIkzzPtQa0djB5fD0H6bOGSa3y7JB7IHoMHLeW4kQgKbbsbiVyWE0vZwjJ+f0
	IJ/jlCOCAJgEn9wflZSw0MUNUfbbT8+dDN78M342WyeF6snTbkpJMnQnlYaQ9S16OGYn8k6Z7K5
	fIYFRoixEU3zBb6H4lV3JNFE6BIQJ286eCZx5s/Qa79SG92XRaMYAr0V0FAlXnLkqQL9iyJaH4p
	s34yD2ADwsDmHVFoqYYiNfe6TuVlBxc5XvxEiX/t82i6g1p8Eou3Fa9u+G5O1hTw81cQ6A7nizj
	5gbdEfIq7gAR451GIx0nIBr7ZUyYuUNGWsEAZvq9O+vQ/dAeBIHTP
X-Google-Smtp-Source: AGHT+IHs6FEzhEXUDfkkEQc4LA3arxj2h4kxel1uOQ1ToUj70zYHM3kQiVFMwQcopPn+zGEUNPBqWQ==
X-Received: by 2002:a05:600c:698e:b0:43d:2230:300f with SMTP id 5b1f17b1804b1-442f1dd5c09mr52205115e9.0.1747262035575;
        Wed, 14 May 2025 15:33:55 -0700 (PDT)
Received: from localhost.localdomain (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ecccbsm21066994f8f.32.2025.05.14.15.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 15:33:55 -0700 (PDT)
From: Phillip Potter <phil@philpotter.co.uk>
To: axboe@kernel.dk
Cc: phil@philpotter.co.uk,
	linux-block@vger.kernel.org
Subject: [PATCH 0/1] cdrom: patch for inclusion
Date: Wed, 14 May 2025 23:33:53 +0100
Message-ID: <20250514223354.1429-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jens,

I hope you are well :-)

Please accept the following patch from Chen Ni that removes an
unnecessary NULL check in cdrom_sysctl_unregister. I have verified the
necessary check is being done inside unregister_sysctl_table myself, and
indeed a number of other module_exit routines take this same approach.

Many thanks in advance.

Regards,
Phil

Chen Ni (1):
  cdrom: Remove unnecessary NULL check before unregister_sysctl_table()

 drivers/cdrom/cdrom.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.49.0

