Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F3F191F74
	for <linux-block@vger.kernel.org>; Mon, 30 Dec 2024 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735587277; cv=none; b=cKIg4TYxjFO/3LO44y+Ppbpvr3DzaKHMfSWF/W3O/6R5xLHn5l7OvxkePE/jF5KDDk8iy+P/M3hUu9J5TXUE1m31G6eJgZYF9XxCaaIiKIcK8Ym6t4Ig86D1VieW0GQJSMnOFTvXOdzn6OuySsHefvJw/h2nqpoHKYKKktMP+Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735587277; c=relaxed/simple;
	bh=Ft5rqy1dmn+EPNCqw07AoTV9TCinp1k5SLqqA2aumvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMcGkzBJu5iAqKQnZkbzT5zE/RIxNwMkXGh6Bz2/e4wHb10miLDagNsJupQoaF9k+s1tbyMC8uF6weXWsgRQ/kiCVzz5wuWyUTPLea9g3VFw5BqpwqXqttonsg/3V9TNO4cemHzH2mIGAzb7Xbfb0hTAWb0H3t0SvWUPWPlZb94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b=Hst42tGD; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b="Hst42tGD"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43618283dedso94770365e9.3
        for <linux-block@vger.kernel.org>; Mon, 30 Dec 2024 11:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1735587273; x=1736192073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bo+tGARv1FkPUev7If/h39q4RQYdy/cwEmpK4n2tz5c=;
        b=Hst42tGDahVwQIKTc409RQH/mtjaOeBKKGxFMM6gXMQwKKWJcX1UBPOPwSpRKupnM8
         jW9UZZipPm5ktY2TIytSqZhEjduHxEWoYKU9c+I6HaE1l4kBouL7ZbjrGSNdPnvPEzXV
         ZhznXnIwoX2+ySkHHwnDWzay/cLtZc10ozicjFaF4m9IyJj/gkuJsyF4M7RMJ/KGTsjA
         5SaH7vcG/rK3LH5LbYcnrvk+fm2gY6JhAfS0whstmybB2G59p9EbuE3p5wIZZiNK6txO
         8NxXrk6c5rHw81i27ZjsESU/P5oMRDmY7bMg+SPvGJdBEkNPKdDLwieP7x0njez+FTug
         iJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735587273; x=1736192073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bo+tGARv1FkPUev7If/h39q4RQYdy/cwEmpK4n2tz5c=;
        b=f9CsX5u32Nhb8ZfgfJm1xsSv+z8Zqufunj8ES49gL5hZ9cFlAJgR13eDfhG7/mht7V
         D4wgVnWMNLYtrW5uYOmh3fPrnlG+rlxI5E9eaFxxPay5Zv6uV9mX8CZcT+oUur+WsddH
         7JSfKHD4BVpGI+dwveEp5bcad8S8If85cp5y2z1nqrY20ba7mtBQ+IQAmVDGYBbjchgP
         axu8/mgwhszVPNNVOFJBX18+on9ulqjg2K7TebztqaQG2KcgU1kYMF87oNmRlPKP5m7C
         Z2ju8qZyTi/IjBDgKi+NmPqWYkIy/udHmnMO+iKSV4PfVYgBNv+l7XICc/nnUZ+xr+Tk
         Cw9w==
X-Forwarded-Encrypted: i=1; AJvYcCW5Ngig/Y9zjuYZgCabLNB2U3bKa6peGLKICEHXqnZIJQ2aAOK1paP0G3SZOMg6Sv/uXwjrfB6mLGoVtw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4uC67urZXvajlCxx2dKG/bKnlqXU0Z9oKnJsC8u3HQhCmF12b
	7ktWZCeP50Bl8v9O07rjnKn0qYPW3bi83hTduuIZpzVGjsuSOcbMvyWV8+paGrVV8N7oqX+RKpq
	8
X-Gm-Gg: ASbGnct5TYEqptP7tQkSo1lgn1QPEC6d3ga63nMRlMNYN9Fc84TRVDkXWOxqSwNbmyU
	MjBNouYxBnQ85jKkvwaIUOwIPDiE6qx9ysm33Jix3ehr5tgCuZum2TnL0XN/yDCAMFnWN/Z1Cn3
	TJhQxhBcNA6mfEeQNDs6gYk1EBA0qYOg4GqU/DZy55rpq89r98KdXN+Yiv1kmv/uEgsmNvW/5wp
	t9uPHWULV3TyPLDl4RIA8KL8mbR5P1ic2UQa1G8aGjX9GZZBLrF7sJM5hDL37w3q2HlbL6Fbife
	8hQPqgLnO0eu1jMOcXDO4AVqlniX1iDYPOQ4AIem3vXMDtPlnGKcIqRR+A==
X-Google-Smtp-Source: AGHT+IEWij3ECV7Z0ZF4pq+JGgel1dBVOdWetOERyB7qJRMSZkmBc6hIVjxzMvsnAcwwblzhPOT9Cg==
X-Received: by 2002:a05:600c:4709:b0:435:14d:f61a with SMTP id 5b1f17b1804b1-43668b48075mr271964105e9.25.1735587273229;
        Mon, 30 Dec 2024 11:34:33 -0800 (PST)
Received: from localhost.localdomain (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661219a7csm362767025e9.24.2024.12.30.11.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 11:34:32 -0800 (PST)
From: Phillip Potter <phil@philpotter.co.uk>
To: axboe@kernel.dk
Cc: phil@philpotter.co.uk,
	linux-block@vger.kernel.org
Subject: [PATCH 1/1] cdrom: Fix typo, 'devicen' to 'device'
Date: Mon, 30 Dec 2024 19:34:31 +0000
Message-ID: <20241230193431.441120-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230193431.441120-1-phil@philpotter.co.uk>
References: <20241230193431.441120-1-phil@philpotter.co.uk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steven Davis <goldside000@outlook.com>

Fix typo in cd_dbg line to add trailing newline character.

Signed-off-by: Steven Davis <goldside000@outlook.com>
Link: https://lore.kernel.org/lkml/20241229165744.21725-1-goldside000@outlook.com
Reviewed-by: Phillip Potter <phil@philpotter.co.uk>
Link: https://lore.kernel.org/lkml/Z3GV2W_MUOw5BrtR@equinox
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/cdrom/cdrom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 6a99a459b80b..51745ed1bbab 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -1106,7 +1106,7 @@ int open_for_data(struct cdrom_device_info *cdi)
 		}
 	}
 
-	cd_dbg(CD_OPEN, "all seems well, opening the devicen");
+	cd_dbg(CD_OPEN, "all seems well, opening the device\n");
 
 	/* all seems well, we can open the device */
 	ret = cdo->open(cdi, 0); /* open for data */
-- 
2.47.1

