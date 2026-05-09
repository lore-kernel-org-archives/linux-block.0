Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB36E38CFF8
	for <linux-block@vger.kernel.org>; Sat,  9 May 2026 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778335103; cv=none; b=Ekd2h4vNvvTTanr+s/bIFkIoyKNR6a/aofHNSl3Rt+fP8DbOZFvoHA9e1FlTO+yKAHn/Ilf+Yjw0N/o9n/R5fzmVli1Y3B3Cv8EEBbI5Fgk39+nbXArL6Ka1htiH7ckN8nMSCfK88cdnYRvxi2n6tW/hJ8DbgNjqdMOIPNLKty0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778335103; c=relaxed/simple;
	bh=M7Hg0+gE3eusbpps+buAnnwLX5X81d+g9BpOiYxCKiU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=noDlMHbRbz5dkEnPyHO9rO+x+cwXbW7aXtO3hJXD/kdy/5CXqN0ZeHjcIggwKqTGlTJmnrOlCttwRXiBuaPhsE+KkwyUlFhXChNUHFptea4p3qtU7K9KTfcxBQkHpDWf7SfZPVTq9+mgDxaKB7/ffS0zGKvKJ4z6GA4CXmuZaD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=bJgv3pZX; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="bJgv3pZX"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e363c6141dso1530255a34.2
        for <linux-block@vger.kernel.org>; Sat, 09 May 2026 06:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778335099; x=1778939899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtcoItxJPGzLDup9Ghrw2YhEOUYqeKEI+y1BljciO94=;
        b=bJgv3pZXZB7lEb9b/zf1zhliHBonI7yU0JUmTLFVudUMhgNPkJhB4xl/SUQIeObP/u
         osR9y4nnILxk2ahMQXNrfZ5p4h2X+xXJYbKcj2rsZ/TONDpWfEkY0cls1phndT5sMLP2
         V2jPUEEZZ3rTqF2POyqFPrMhHV1o8ruZ0Dxg4DWsfwFw1Pv8woSi8xq96unnLOkic5+I
         0gjTdJ4ayfcqgoU3zg2aA26bcRC3xkAwHnBbutUElrEBM/C5uvwUyTX/QLGuXHTb8X91
         RWxw92sy8SMgLvGMZnS/csu59mzDcneJlXUSoLwrdU6BmCBycs1Es+QCwrjQu2/1vJQe
         588A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778335099; x=1778939899;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JtcoItxJPGzLDup9Ghrw2YhEOUYqeKEI+y1BljciO94=;
        b=NPRoUmOjAfYuAiH9ZGh24goxHjub3IQMA100W5xa84Gz2TuXVAPoA7auSOZR+iTkXu
         edtTKw3Cpc70/BU5xftMpvrqj7qnxxGeOlo5sQdwA5kr4+VYWoqRqKbyYXKsxCfaBXg8
         4Ty2jTvV9lYtU3atH0YV+ojCCiN1BGseeji4PHpC75K5DqBQuUCoRhWED4pbaRtZIra5
         ZsoIP5ucmr2odfwIaoOZdOtjZ0Za8Q91AoTVhmGrnCuMxvOjr+FHBSEEGSjNhbQ5AZE1
         7c+WKya7XpXKipDdJocY5XkjYnNevCmPOQe8TZ7gsHkQjkvzcruNWg2x4kcQbmcqQOq/
         Sh4Q==
X-Forwarded-Encrypted: i=1; AFNElJ81IXlpwxc1qJRE9XPuFZSsiWOWggkkpruUJwEopu5qV7IIRi5DA+lbR06kg/FQ/zxbuoWuOsuk4MvIzA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyrb6Zhf5W6l6mRhfNb6LrcRZG5D3Oq6WPuUphvXWsjmKIOd7J
	iDG6mmKwGSitsxXEHFQqKuXra9/N6i07AD94wWBdNWzz3tgntf13CcIq+2hHkU4Rd4Q=
X-Gm-Gg: Acq92OFtNU+/bPRFOuKaEqDmWxqdTKtSFlWNorhlEYbdGCjnlgt6MuZSbWI2xBxC2WZ
	TkGjnzo0mLnZto1lh2PB8B80BnKc6aIl75m2/rizn9DrHbk1zE04Wu/UbwZXAk9las/G4bKMTqR
	KuQA/+9/W0tFVYpppyMhDFd/Ttcj0a9DmO7ZE7N9qf9Lc1bOrTuJvgulDuFQFYcS0qEA9W26BwI
	KQDDO6DDhJwPpJ6DddFNwCff6kvDqvzOqkh+wgnqZTuUwKmU0m6lMJq3N6+xs7oBmLcrdAzcc79
	lhnzgOtZRbiyp04WOdoW7/KM99XF7jP6CnOrGDkmRMIQYB6DhPz+k2H8PfvM+qVCS/qh3DDPCIM
	CwiJA60CvwBv+OxdlM48V6Kj40AXJ/gns94vGp5aZbrYBmfvmshPHetVN7C9lx1c+/n1O71/4Ns
	jtwpM2IZxB8pBHPjTmPerRa7uSmRkONrRRj8JKfjE4bUk0E8uGr0y9JF9v5c66TULyHKoU1X7WX
	Wa/ugvDss71Hao=
X-Received: by 2002:a4a:ee12:0:b0:694:8646:9933 with SMTP id 006d021491bc7-69998c9f9f4mr9127230eaf.9.1778335099502;
        Sat, 09 May 2026 06:58:19 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43556bbebe6sm4395297fac.0.2026.05.09.06.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 06:58:18 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, 
 Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org, 
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
In-Reply-To: <20260506124541.1951772-1-christoph.boehmwalder@linbit.com>
References: <20260506124541.1951772-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH v3 0/2] drbd: switch from genl_magic to YNL
Message-Id: <177833509787.32015.11244289527797673484.b4-ty@b4>
Date: Sat, 09 May 2026 07:58:17 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Wed, 06 May 2026 14:45:39 +0200, Christoph Böhmwalder wrote:
> DRBD's genetlink interface was defined using a custom multi-include
> macro system, genl_magic_{func,struct}.h. This system generated struct
> definitions, netlink policies, serialization functions and more
> from a single "magic" header.
> It never really caught on; DRBD is its only user, its internal macro
> jungle is next to impossible to understand, and even harder to debug.
> 
> [...]

Applied, thanks!

[1/2] drbd: move UAPI headers to include/uapi/linux/
      (no commit info)
[2/2] drbd: replace genl_magic with explicit netlink serialization
      (no commit info)

Best regards,
-- 
Jens Axboe



