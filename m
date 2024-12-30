Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812C922339
	for <linux-block@vger.kernel.org>; Mon, 30 Dec 2024 19:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735588583; cv=none; b=UvZa079j7hnrvqXlqHuwQoiYWkpmIrWCUTUY3itfFJa/sMqbsh45eUpBQikU+UWwL6pKeEs1bNzshd00pbl1TiIVhCZ3u5hKevXDfT/8y9oe8OKiHPi7XJb3o4I02B0R8JevS+M82SJANX51e19ZiEY6GlN7UQAOiN4EM6ArcHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735588583; c=relaxed/simple;
	bh=PilqB0W/JEDoxRdo+v7dp5zmjN6OH50f7LeZFHLeabo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PhLg8i1HXMSnxN0aYUmhBrCek8+ToGMTr64jDqMiTQ3iredbIdoFv9mpKv1poIcVOIES+W1u/LQtCwkNrAcZKgSZ8KDtXzbZgCMubVw92bx5GUPJMlHW31DWoupRga2sCKWiX6Pwgof+OookgSbcycodMSdScr+N93TXudLloVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1uefjPJ9; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1uefjPJ9"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21a1e6fd923so69951755ad.1
        for <linux-block@vger.kernel.org>; Mon, 30 Dec 2024 11:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1735588579; x=1736193379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQ6toIhIeK3xmUyAjvDRmqrnQffvwRKM0KJpMlOAdUs=;
        b=1uefjPJ9j8z3PTFmhC0AAu81xSv4vgfhK91u0tlysqxR8oidXRwErXl3reORyxtNU4
         8Q4fJoR0QD+xulqfrEoiFSFDL9wetz92K/Bgej6IqroboiOCJkJbJCIHCr1hY72wWoVI
         qtVkO6bxdCYw/k05sqGTfQxd3SgQD1qnyPsZ6KfDjC+7dNQme7vC5HnIN30Mpc+26fMX
         PGYA2SM4BMmTEN8HeI82vJA2zMfDnfJuaJP/OKwh6CYJqG2waTXzP2iWWrIeMDdNw5Rl
         auakHs8pwtamjvDtvPqN7OO6YkBVOAHGkhqODh7CpfgP+ZXkKfgz2HCVmuRCiHolCKwf
         An/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735588579; x=1736193379;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQ6toIhIeK3xmUyAjvDRmqrnQffvwRKM0KJpMlOAdUs=;
        b=G/WpvrHLdfq6EK7GNvFCIehyeRSp5a3h+HGndNxGGKSaM9OajcqBKH8q+OXbIO80Ta
         yrNmhp9iyJPmogayzFRnZBKxzuCvFb5YdLpYvnXSA86vr+kwJsNuB02UtTvvy9B0uXjF
         GGzizkEtzvxwr/7YS1AFKyLLVcted+VANwEMV4aKlIqze2eEG3o7R4jvVE9LKTd2sn/r
         0p2kH2rJfBMfiKtsapRcVQLjwtWZ2weTf/g6rMboEwfsPVLYWafPliSs+R7qxl2v6eSI
         EBl9hNt1uE5cnaaVvZW/A2E5ax6/tBPCx5AgtOh/P41wESCUvyAkcfZRvzOVf2tfWDRJ
         tDOA==
X-Gm-Message-State: AOJu0Yw+mdkGlnxYuHnJ6i/Kr1Ua8gRAVlBUapx3AAEXx+Js8WJBOfCq
	OH9VvQK1gsbqUra08hMXCaRFKJRIb34RMAngj9PNfrsCVB6XN/vT65i8B5i4tNQ=
X-Gm-Gg: ASbGncsfaJuIZ1sF4V3wz2wrXqicYUo58Bdv6tYEdru1f/G/iLt7+wmhQt/3Gqc4aUd
	THx0IDWGS8raNWoh8SsuJY8gajjljwzP5Hn4XZgmM0EfxMIYevmeH4zyDj99ggvqKP95urkHyq0
	OwGWK9lVLgJE8USIvQLea9FAgq66LqrLqSuWnWSZxd6/aOnPB2h457S+7Z1WSp6OX34KfZhtTGI
	cZHr2F2HE75iNR4x2Dm/HzyiF+StRQiah8c4qocnsgyjiO/
X-Google-Smtp-Source: AGHT+IHYP1uYSH5WHS2c70AkD4UGDKGeZ4m0Ga3N1OfxTHtb5duWQEzmQAjuq9xhsiYX9dYZMOZPhA==
X-Received: by 2002:a05:6a00:a91:b0:726:c23f:4e5c with SMTP id d2e1a72fcca58-72abdd20f88mr51541090b3a.1.1735588578784;
        Mon, 30 Dec 2024 11:56:18 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dbafesm20101819b3a.128.2024.12.30.11.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 11:56:18 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Phillip Potter <phil@philpotter.co.uk>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20241230193431.441120-2-phil@philpotter.co.uk>
References: <20241230193431.441120-1-phil@philpotter.co.uk>
 <20241230193431.441120-2-phil@philpotter.co.uk>
Subject: Re: [PATCH 1/1] cdrom: Fix typo, 'devicen' to 'device'
Message-Id: <173558857778.559843.6500663210164021895.b4-ty@kernel.dk>
Date: Mon, 30 Dec 2024 12:56:17 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Mon, 30 Dec 2024 19:34:31 +0000, Phillip Potter wrote:
> Fix typo in cd_dbg line to add trailing newline character.
> 
> 

Applied, thanks!

[1/1] cdrom: Fix typo, 'devicen' to 'device'
      commit: de30d74f58cbecb3894c7738985bd0086d04bec1

Best regards,
-- 
Jens Axboe



