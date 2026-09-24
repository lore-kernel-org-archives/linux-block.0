Received: from mail-dy2-f31.google.com (mail-dy2-f31.google.com [74.125.229.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5FE408615
	for <linux-block@vger.kernel.org>; Thu, 24 Sep 2026 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790256934; cv=none; b=gq5Pzn74sJC5vOowK0e08iHzEhszU8RRPx41WNUMSbdhcTIl16UdoiDgxavknwn+XMgfpOx/z4eOY7A16qVDEIeQ3OBqtUunyFR7hZDZemIzQlzGBCiLqf2pfVNexWKpnoSt2E7MujVOvDHRNAlFfSD2VC11EM2b58koo5qcLVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790256934; c=relaxed/simple;
	bh=9jHCDZ/vmqzaSvN0q5leuZpLt+Evx7ZwCRLn8CHMW/U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uANoHMdkMiU/iS+j62qXs6ZmncUfk67VWRMDSBxS52eSqaVyyUvG7I0nWQ+i747qnWP3V76uEm4lkG/12XyxA1g/hGkdkrmp6ic3Zya6QLeHX1th8rucTazPA7W5gJjPRC9+scd5WOUp6jfMfK0ywJxhGu4wRIRTo20V2Vol0WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=K9YqXg6A; arc=none smtp.client-ip=74.125.229.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="K9YqXg6A"
Received: by mail-dy2-f31.google.com with SMTP id 5a478bee46e88-33c11ef641aso2350803eec.1
        for <linux-block@vger.kernel.org>; Thu, 24 Sep 2026 06:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1790256926; x=1790861726; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VkdVKqAOldSUnsrajVaqKWEtpzNt/N+Ojyt/04+6CGo=;
        b=K9YqXg6AWsJs4i0EGymekQ+8hFeQdvr84ozF3csbeaEi0UlUFQEQOX7lSeom6py/nd
         A6PaacgABGQsBD8FNV6YJi2wqeuSNMZhWsVf3CzTYus+7wZWmMVWFzdaXC13TDfvRg55
         cmS84RbBElPpOWn4R9EjylSvdym9uHtJ2qnrvyP8iinuYXynwP6g/NJllb0H5Ss2A7F1
         SmVdi47z22FG2PGxHJ6Bv80ofybnli0Ho8+qbf9Qf/taUxMlaFzuLV9BPXXBvUzpLkgG
         BpMSk6Ffwd6TR4vHAqCWjLuGQ1HXfFEJHiQGc3MKncl+UqgKub2pEErc3IZofftCsK4+
         X/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790256926; x=1790861726;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VkdVKqAOldSUnsrajVaqKWEtpzNt/N+Ojyt/04+6CGo=;
        b=Al3wMw0wEGoIRcygpjFcx/5oigxxfCZVy7YAp0lS24C8SLNK+OZAjsyim3yYEJyzmU
         06CNR3RCoildVzer2qvfm28TNZu7tcHhIhRk06A1tfMdltdtB1fifRuIbxYvs4B6VfM7
         SlvJhO9ZJppkuzx6IYKdgoHibJKp6kE33GKYKJxvYJ/wR6lautYotpKp69K6OX07TC3T
         yQi8Qt9kbyRtI+lmhH1q+W7oHmZvU5nxy7pIbgVKFc90jJE25tfi60LvRzgzNEbEyLG1
         XQV7pKTBf5q7DFRWrkXmGYLQZlFRjlY0jrZZ7JDAr6GJsMw6pLltcDRdaaJozxQxACem
         pu1g==
X-Forwarded-Encrypted: i=1; AKwUvBx7IQ9JTeSIhKhRFhbnivadNlIQBvv4UGonedaqI+pW7Qv/GguQTbVnHMDxHqCPvT/BJ5tiqkJmbRxO/Q==@vger.kernel.org
X-Gm-Message-State: AFuF++lZlEe8kNRcGpEnyVRH6SKNdsNmGcvWvzQkZDdAHxcI6Etsr9uR
	QGnU2NPCzXiFM+jE8sZR7CaCK65/nmzGSUOsdGPVULBpdpDaQwts+HDqTM1WEenNl3pKs7RWOcq
	OenPyN78=
X-Gm-Gg: AYBFou2g/q2tQ03VZ+VpPnzf3sc2zFp9VB52vfvb38dpvJ+u5bHChulpDcQVvxMpsmp
	qFTOofa8ET4KEkv/Ou2wP5/VDRBOo/0qN7lFzneOAIKCSIRWV46Oo8arKB5Xki3FgcIvEUjvlwW
	R6/q8uxrfJWMG48g+544YzAWsM6t38fuvNPHs7v4wGATdyUaJ1Dm88kzn5fiQ21OPvLkDwdqiJ4
	GcOsOSL6Y3fUWNOzMwODmIDw9fPEGvXql+IPUCMudH8G8AzmypJkwfRKwr8jcSFSMhIuqWA9jkD
	u69PdkF+5aiE6jPfrJUFh5Y6HgN6jCAMai82FTMSB+WCpDV1UXG3Z94ivflgl8vlZ4mP3PRIifZ
	mV7NJCYff/xa1ZAfj2ebnQD9hftdRPQvNL7PNNCjNPQWVT+HTypRQ0zsY2am7h/1JritHbF69yO
	LDdN1dp8E90tD8MIaM7L04d3aVhZ694lSzYbojRqrd2DERa3sL1Q5fTZ7p2sh7xSZ8oTcBNZdro
	9lsuqRfeIfA9dSiV7BYwOa8p6fncwm8ZGSTGb/wt0OYVMioHOzj
X-Received: by 2002:a05:693c:8381:20b0:33b:bd89:26d1 with SMTP id 5a478bee46e88-34004c81f1emr2342532eec.12.1790256926408;
        Thu, 24 Sep 2026 06:35:26 -0700 (PDT)
Received: from xps16.local ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96952605sm14382681eec.22.2026.09.24.06.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:35:25 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Philipp Reisner <philipp.reisner@linbit.com>, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, 
 =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, 
 Jakub Kicinski <kuba@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, drbd-dev@lists.linbit.com, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260519203057.1340528-1-arnd@kernel.org>
References: <20260519203057.1340528-1-arnd@kernel.org>
Subject: Re: [PATCH] drbd: remove unused drbd_nl_mcgrps[] array
Message-Id: <179025692530.320427.942841012071872902.b4-ty@b4>
Date: Thu, 24 Sep 2026 07:35:25 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 19 May 2026 22:30:49 +0200, Arnd Bergmann wrote:
> After the rework, two files have a copy of drbd_nl_mcgrps[], but one
> of them has no references:
> 
> drivers/block/drbd/drbd_nl_gen.c:641:42: error: 'drbd_nl_mcgrps' defined but not used [-Werror=unused-const-variable=]
>   641 | static const struct genl_multicast_group drbd_nl_mcgrps[] = {
>       |                                          ^~~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] drbd: remove unused drbd_nl_mcgrps[] array
      commit: d431e03d831c043707e22311c4bdea1907166c34

Best regards,
-- 
Jens Axboe



