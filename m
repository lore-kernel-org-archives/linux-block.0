Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBA769E0B
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 13:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708435328; cv=none; b=l6L/8/mHU1iL+V54Dcl1HkEjFvM7N2OcMjZ0HKmIwDYc5KRPGqdtQraYPanlnljJpn2oxXcKTdOryFTINaJBtoHtVJymgofmebIMKQkJxFIc7ZXcTTHPyO1HeoIJ96AdrvcSu1oq8t+BgtelQPH8/c9PQtp5DdX6P0pLLDjcycA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708435328; c=relaxed/simple;
	bh=QIL1eO76nRceXdZlGPNd9WoxMmfzOGCf/gElEI0uZCE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=inxLrdy8cVW+LARzveVeFzu5XhDfdqJjmGfSEGWlVpn0oPet+OdJ3y9Q6gSqEefLKzVElisvuojtpXPlchbvkj0mkF9zAsIjEkB2A43PjXKH9otQbg/LsIfB+Kwx/QrekmQAnLS8m+FiUBWgby4FLGvc35wUyEkKLoDQnDjBMrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WZzy7COb; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WZzy7COb"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cfb8126375so1588981a12.1
        for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 05:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1708435326; x=1709040126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwR+2EpirGuYIJk7CBP/ucNU/lMlXbrbwXNmhiDYHkc=;
        b=WZzy7CObOC+3NvXXTFSNEQV6BHOGl8ZOmy1ZS+dETolzBmtgbx6U56R62RvmnBCJK6
         SRchiTBQP2mtWD/OLlqaEyEtjH6fwlbUjUuvr/Z8wcuKMMOnDfB2bAywuE7ly40HOctK
         Luq2FmmPhaukDgzMmA/VWFkRVqw8ur32SdWGnqNGlQePjckUQJsmwwsflfIvrk2826Dj
         +RV/UEIH6TuBzqG/6U06CDbWunju10pWxHskL7lIuFSZX3OSHv+jDQtrbIdOyDIlme7V
         G+kJ9D1CHbtM7bO3UgQ0YNGsFoTUiqg/grTxQ/5CpFHJgMg9eBKnFb5mS45HuG7CWcC4
         fVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708435326; x=1709040126;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwR+2EpirGuYIJk7CBP/ucNU/lMlXbrbwXNmhiDYHkc=;
        b=CoFBDlRxl4LC6mJhfVE0fsJPZfPeEp8+THmTmK5eRqiyklmHUbLTPEuyBxY1KHP9E2
         vcsUn6nk5jJqMJ9Q02rEfjYvNX6lqzz2PMVAuN//wVqFWmDHgzo/JFOjO56+DqBJtHHl
         bpRdG8PMnHmBODYfeTTWfZ8qsR/+FaiR49SwQdU+LLYamBSJYY1yKXuadBgYoKbvElUB
         lvhfnVfmzjCicnlXPWKuJhU9DWvICByLsQrBWZlNuofl0ypILU5ISUzq3+iT2AhW9jOx
         T1JEIR96/x4+HJXLqQKE5TPypc2M4Sv0OaFkzrrGYDJLUmwiIutwqSt5s7PGvtC8FrEt
         rPvw==
X-Gm-Message-State: AOJu0Yz5dfAPPV1/j94VIHrQBta5aGytAksYRNuK0v4Gj85wwA9677BH
	WBY4Y8RL+22fmNmknvSTBD4kSAZ/wLtCVQ+5TVj4b5sYD4XgZk3QfMijXfHROlBaYwCMOhRl5gj
	r
X-Google-Smtp-Source: AGHT+IHO1zdqzGFfjLxPatoyzvBo8WJa9Zz61ltyTfKnp6/ovARNMKteUTI23MgPMxOcHz8kQYnstw==
X-Received: by 2002:a17:902:8d98:b0:1db:de99:9e96 with SMTP id v24-20020a1709028d9800b001dbde999e96mr7963899plo.2.1708435325686;
        Tue, 20 Feb 2024 05:22:05 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id iw11-20020a170903044b00b001db5e807cd2sm6188911plb.82.2024.02.20.05.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 05:22:04 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20240220093248.3290292-1-hch@lst.de>
References: <20240220093248.3290292-1-hch@lst.de>
Subject: Re: drop bio mode from null_blk and convert it to atomic queue
 limits v4
Message-Id: <170843532376.4095460.9562156686826549291.b4-ty@kernel.dk>
Date: Tue, 20 Feb 2024 06:22:03 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 20 Feb 2024 10:32:43 +0100, Christoph Hellwig wrote:
> sorry for spamming you twice in a day with this series, but the buildbot
> decided to send me a delayed warning just after posting the previous
> series, so I've fixed it up and resent.
> 
> this series drops the obsolete bio mode from the null_blk driver and
> then converts the driver to pass the queue limits to blk_mq_alloc_disk.
> 
> [...]

Applied, thanks!

[1/5] null_blk: remove the bio based I/O path
      commit: 8b631f9cf0b84ac59cd4f0c6dcd2d0cb80dd8a49
[2/5] null_blk: initialize the tag_set timeout in null_init_tag_set
      commit: e32b0855367b65095823b4427aad3da7c6a771a6
[3/5] null_blk: refactor tag_set setup
      commit: 72ca28765fc461c1aeb87372359ec0cfd609448b
[4/5] null_blk: remove null_gendisk_register
      commit: 0a39e550c18244cdb9c4e671266a2a1d682d15c2
[5/5] null_blk: pass queue_limits to blk_mq_alloc_disk
      commit: e440626b1caf3767eda2d78610dfdc0ae7fd5238

Best regards,
-- 
Jens Axboe



