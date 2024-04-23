Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFA5136652
	for <linux-block@vger.kernel.org>; Tue, 23 Apr 2024 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713887217; cv=none; b=LMUtI01b0yXWRm5tqJxm02v1hLq4Co1Z5BoZHyUzPBTx6a/v7wtEXmR1rAOT33cuvY6cJpKBUwyIu37ynxKILWtRiiZdPUHoBnz+sDBnFXPfs8YvOItkdg5ZPY17ERvgCXqMXSlEdNkdm9sNu/02zGfwDsIuxoT2ZU7CCPoypOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713887217; c=relaxed/simple;
	bh=brq2CClPPyQHuEfV64LF0s5NQmFo5uF2Npupa309pew=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Rf9nLA5HcsW+E7lgCC7i9uHuHUYVKzqXmKbHs698WDvJ4gwdDeoc3Tnh6uoa+PcmW6t20WDWSTrEgKRZQ3CR1JBRekJObnEGcMnPeyfwNL8MTgVBBciDNuJUyU9Uf2nRy0HZdowi8KLrzjwOkPpjYPEFO5JpWlnocCBLq60TBmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lwnaJ30g; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lwnaJ30g"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36c05d8fd4aso1857965ab.2
        for <linux-block@vger.kernel.org>; Tue, 23 Apr 2024 08:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713887214; x=1714492014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VSBfpqdVGZyyQyUJQfAu4m7SnO7sit0EnOXAqllto6Q=;
        b=lwnaJ30gr6gIrU34ZlpHaw4SvBThCfC/ZtQrJW4RSqH7fk7lHn+KwlLmg2opvcNMzP
         EUZZ6dnFKNM/63iPLOstCK/X8F2ZRhP5xc6AwaqEJDbkJ+YZZ71duFQYbG/YfRM+eyk6
         ZiK3GEAYSa1MRoLV9umO5asy54l4qT0z3C6nu/8hAIQoaOU78M7qCISlcOBM10BExeUm
         yIkWrHOrosa2xrHBvcUtV3vp1+9RYsNgp+6urI9ku1SGxK+oKF5gf/RzZUmQXWnvCy+z
         ueiKLBZ5R3NJu5g44GXrlBgjREYEauVMbX4m3DMzCtn8T1TZxaAZWk1tMh8U0LSeM+fH
         h09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713887214; x=1714492014;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSBfpqdVGZyyQyUJQfAu4m7SnO7sit0EnOXAqllto6Q=;
        b=RAB75AXFF7x27qBNbrRVkKZMDbomQN3E1WBgF3l10l/8jbtGBtpF1LB8Vg7crBKelm
         6q7EeM+UEljRredLPcrw94Hnurjjzqck6XQf8Trb/Y4ZSuH+BU6qBljF/GDakm1WkFXv
         AEDjdVPftdfnOJR6LL9XWNpcznUrUaOycWzoB4D82rEYVJWNCL90YGZ6itD+I0V/90uz
         AHwlzkO8zppAsee8CON6ViQbJ6Z6aeWAnbwe0BITFitZ5UQZv04BVWKUwLWw7IapSzPG
         VloNt0yQlQtvb3xJOv+7dTVjzSHt1qxcrqksJzl/Be4uTLB7fOnQZXOzycxUHxxfKb18
         Kz1Q==
X-Gm-Message-State: AOJu0Yy1phk4mSpUwHnKVPYmr0bKpnAhQ/4vxJGE7lMz0y5+mHiWuZZI
	o3weaWJ3N2/rR4NsjHqlIIO7OluGOCyXdUdsovNjaVLE5S4Uf6cOyBwvr6a3RQaSuOaIKB06Je1
	M
X-Google-Smtp-Source: AGHT+IFqlXyg33Zjnw6GHEu4nw/z0tIbK3F+yIn2n8xUQt7NqdPsVcqWf7pdcal7LIugjQkJBSj4uA==
X-Received: by 2002:a5d:83c3:0:b0:7da:2b78:af10 with SMTP id u3-20020a5d83c3000000b007da2b78af10mr15444239ior.0.1713887214577;
        Tue, 23 Apr 2024 08:46:54 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id lc8-20020a056638958800b00486d2717b97sm159272jab.137.2024.04.23.08.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 08:46:54 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20240420075811.1276893-1-dlemoal@kernel.org>
References: <20240420075811.1276893-1-dlemoal@kernel.org>
Subject: Re: (subset) [PATCH v2 0/2] Fixes for zone write plugging
Message-Id: <171388721392.8010.7468542863972391405.b4-ty@kernel.dk>
Date: Tue, 23 Apr 2024 09:46:53 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Sat, 20 Apr 2024 16:58:09 +0900, Damien Le Moal wrote:
> (Apologies for the churn. I sent the wrong patch 2...)
> 
> Jens,
> 
> A couple of fix patches for zone write plugging. The second fix
> addresses something that is in fact likely to happen in production with
> large servers with lots of SMR drives.
> 
> [...]

Applied, thanks!

[2/2] block: use a per disk workqueue for zone write plugging
      commit: a8f59e5a5deaf3e99a8b7252e96cee9af67858a9

Best regards,
-- 
Jens Axboe



