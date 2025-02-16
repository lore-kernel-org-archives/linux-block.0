Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9F413BAE4
	for <linux-block@vger.kernel.org>; Sun, 16 Feb 2025 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739724691; cv=none; b=R0BvIs595RmESoWGFpYMmcuRqYyaP1usgDCjYmi7wWlwawNNxY0ucQJrO7kkqPRLPbn/9jjNR4QUxvfFLGBEvFRJQgdCG4sGMcwMBCZPZsYalJfzIOI4kRrQVeGZ0R16o42uMuVu/8IKrvOznQWoF133yyw7+vMcgfFuqrbR7Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739724691; c=relaxed/simple;
	bh=mQ97y95LIdrraB03cZEreLekHPsr6H/Eh7BYqk2gmiU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=VT0XQUOapS4OG6gSZkIOuwd/ePnmx5GKtJHoAqO2VlboHBIVxUAobphFncQphjdGwQtHlLlQ6bZaVYiF7GNpFEPrxr38LfcUot60mqFAxkTvYoU+pF/LtNDAkug3PPtrjb8A+nH49Vu+rjhqMO4geOkZtyqKrRCobdEGNPGJbr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFnyFpgw; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFnyFpgw"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6dd0d09215aso30015316d6.2
        for <linux-block@vger.kernel.org>; Sun, 16 Feb 2025 08:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739724689; x=1740329489; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mQ97y95LIdrraB03cZEreLekHPsr6H/Eh7BYqk2gmiU=;
        b=OFnyFpgwmZ/7frdq7V+nz8emc5g4sB7c3ZMfArTR+Whdp+mWTUaWiEdEY0XTzMe7qK
         BPXs3jrTIMmmFoleOdxxbxgzHbtzI5oxX4kwUQFlhblHe5/8ajA9yLR8UfozCGPT58xo
         8dqgPe3gwn+SZluPchuwZQA6nXjWm44i5BWmb7ziCIrZMkEuT/S7e75LriBYcC3a9nLJ
         uvlOrw/H2ifNXbDszg7nyGhj5Tav8pPoBu1w0gSZVDr1EecVUVMrzhGu/pEP87OnskkZ
         2vfXLqssolqSv/YDxFiVhPW//uF/g/gdRkDjRAGI85wDnP3AKvyMaVL7izj+40n5kbYM
         SeQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739724689; x=1740329489;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mQ97y95LIdrraB03cZEreLekHPsr6H/Eh7BYqk2gmiU=;
        b=cbwx1vsENZmeiFn7lq2BHxhuLVLnsmFMFhtUTFzQ1OZW+TEcY11uD/UoQ8qVQ4fGmG
         hDkRmC4Rpik5Smm9MnMq00ELrY3ctszp4bfddDQLPnUopmoWg+c4M8ScyGXU41JMRLeC
         Lw+hT3Z0TtxLFTZxSfO4xs6xF3LcXc98PaPhn9fiCk8+xRvkBaoGkqfPJ4x8pyAnYulS
         W4aHZ68AsMy07ldWKF55/fsl31a+A/PBnRAQuGe/SHrVdiCtQQ5M2BeqgFQ7MuHvYSO0
         yLAQxP1mJzenIbBc01yNf0LElwdJ0q8okJSA+HkOw7jfN1nthp5xu18MRJkgnjdfAcbU
         Mqpg==
X-Gm-Message-State: AOJu0YwY22gfCwYRlCUutO+kuDXQNge9uDKkZ+32AqGVMNYTSMgrSS+y
	UGHUiIzjbalkZjYFKo8fsN54S8hSUy3ODFgYShmC4iBkrx+flQ4Qz7zF3e4Jb91T2FJUXxaF0NN
	fmyV1ONYp5wONEaR7BRKTOBhmj2HLwA==
X-Gm-Gg: ASbGncu4OG1l87sVAtNUyaS8bOwT9tWLM60iqXS2FjyISPnUpWjsF+ufmoghXLJ2cLU
	9btmzk8WM5aVnMxJkkDZtI81MHgVFTnCAzEZVUdkEWbsh1riKx4TFXjkJCPkDNCpuTdvBl4k=
X-Google-Smtp-Source: AGHT+IGdb9hA8iMaUhoFuizK2XH9j5890+/SmM0ARq0RAmuJlNNsp5Sh/O7CtWn3MWorHkmb2kp39NnBfg4BwUQg+IM=
X-Received: by 2002:ad4:576b:0:b0:6d8:d84d:d938 with SMTP id
 6a1803df08f44-6e66ccf044cmr105549776d6.28.1739724689022; Sun, 16 Feb 2025
 08:51:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Racz Zoli <racz.zoli@gmail.com>
Date: Sun, 16 Feb 2025 18:51:18 +0200
X-Gm-Features: AWEUYZkbY64Rbvtl-7auv0AvhDbVJTAPJi2iXhgS3l2ZsdFdauoaP1au8z5i80s
Message-ID: <CANoGd8nKbSu2iw6GnZ0ArDocsFdtpypyVa6WC6K2T00L-n+zyA@mail.gmail.com>
Subject: Block changes hook question
To: linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,
I apologize if this mailing list is not the right place to ask this
question, but I`m working on a block level backup utility for linux,
and I don`t know how I could detect block level changes in the linux
kernel. Searched the internet and the documentation for days, but I
can't figure out how could I hook to any function on the block level
which would be executed every time a block on the disk changes. Maybe
somebody can help me with an idea.

Thank you very much,
Zoltan.
