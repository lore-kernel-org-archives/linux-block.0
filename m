Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9426C34B437
	for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771596566; cv=none; b=VaD9B9HWzh5YPQLzAoE4ysJqsZi4PjEV7TcrveFnn8/e4qr4cRNeUzgVklHBDwlP4DCmcjujjYs6PjWCZdLLeIOGnXZ2RYmEK/MDVve+mKsY5WRIVho1aNPCChh0tv4vPvRPkz0h1rvOs7WhP+ARSu5AY9IZ9hLeu2cWfPabHnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771596566; c=relaxed/simple;
	bh=PTSO/YkUpfmOIn94JPRxGsqH4ok7zfKeQzMGFFqtubM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BM6aZuRvnTo9i/1LjqYNj3PP72e1kPpjbaq3R84sJoSR8wJCmbyCMr4edg+4HE+D/1bMj6SamvihUI5QnyjJCnzaxbqqofS55JlZK3SimsH+xej/m8GMcvF5GIl7T0t89z/OAKUtu/6yypXOnamYZpehkxoyq78FbAkP9+dTcMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ucpeUUWD; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ucpeUUWD"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-413acc82f38so751368fac.0
        for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 06:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771596563; x=1772201363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6agG1a/ZZ7prFDRVGuF7sIP7aaRyumONnsIWUYhmn9E=;
        b=ucpeUUWD6SHvInp4P4AIAVGBCIMfUseDJ6HLstwHHrEZHaWEzx3ZS6XHEEfXEkNCIP
         TTluddkd6QwBDOjtPW8cAory88ZrRsbTdZuh9JRuyXsznJ2hT+Y5toJMyood5phNG+T6
         ZtHU1bgwnpj0yk5lgU5ntynKEvpLswS8eiOlaMCmKxOYbXIg/QVHBfY40iGNXJ3JSUBn
         AqgKsVvzxW616mw5T2QexC0WEZZbx8RbVlWvVw31UICwaupB+NGYUnwwMTe3Pck4EGUm
         oCAgWK+q0R/cWJIzndUwx7IrxZhW3W0OqTgEFY1mikiyDyilAdgSEp8Hj2JE+1QMigVs
         vUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771596563; x=1772201363;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6agG1a/ZZ7prFDRVGuF7sIP7aaRyumONnsIWUYhmn9E=;
        b=H2hMPnqHliT63sdtfmAezgnksNYDJ2itMq5QGHGk5xOJTW2UivfOdeHeYPzw3WWtZQ
         2gDZC9wH5DYLC+J4zdgRWJJTD9HPGaXPpPetg0UkkNOIdhY1S47BF+8VnGzYMLIv3F+y
         uAao9fFTsf+sxuJEIHV9YJaeL7kZBqx+DwcNzcqzniYpzHAuWbomODAhJrOgjFQti8/G
         v7oZ06/UI7dpR6SfZgONVISGU2Gc9DRIwfKwme+9Mt7ZAFdcLmkMWZuM0NXYpSKnnmVK
         +6mKssfltAHlpcfBZkiu+lZDYGqn8z0Id2wtLBshgVqCFhIu8F2alAWhj6XcTeDThfbt
         ZC1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXicKrckXZBZdxLVD4bM9JGEvlPJN6g9dWlt+jXKCch07QK0p05k1MwT72PLkK2BIFIfww2nDAlkfAd+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxED6l1cM6HVZWslW6vW3iaYM6hNNtn0x45VUHcOmrc7AcqBykm
	arHd46N43nZMYS9peUfphuvyAXIRlO2f221+0Po1k4lwLhZl/8C7eHMY4nh2bi4+Uvs=
X-Gm-Gg: AZuq6aL5bkzR6EvAtAYxUN19DCUcozZsh680Ojl4+LBV9HE48Nh1i83nfFRKb/mxBYZ
	XiPDTPCVnVZ2xOukdRRmVOZIm9yGOf3OuYdNwiSj0UmL+TQwG0b/PJBrmgOo764ejCKgrAUE2yw
	eKJkjAohfWswoJJSCzDuVsCskzapi8fndW0Vug3VNf9gJDkQZ2NkF3C78Jpyv61kWF4yD+NME6e
	Y6fkod7RBBqHS9vZRdP6BAif9s4ZjyUmGUPvp0o65GmD/rvjkknTheJfSoJ1KqJYFscuMKlGcBB
	qeVfLrhJ69FmoE4dMHN6598p2re4/vIaxsvNl8hSvc52ZUHrzYHTGspx9ix+MioZc3em5jrwBAt
	OuocP4q9sk7olKH08IhVa5x4i++mTHuyVO7EtjqM9NEB+gevgo/A4tQCSOmJXt85aD323nUJWGC
	ZJzHxaAMl2GpsctPdD64yrzjrWeDFp7yprsTlssU6YLvm8Jxyb4DwCEEUAcQ4jKLwMLFt0hEcMd
	ehzRQ==
X-Received: by 2002:a05:6870:6b0a:b0:40e:dcbd:e92d with SMTP id 586e51a60fabf-40f0d1bbcafmr13285290fac.0.1771596563456;
        Fri, 20 Feb 2026 06:09:23 -0800 (PST)
Received: from [127.0.0.1] ([187.199.77.89])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40eaeb42708sm27916776fac.0.2026.02.20.06.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 06:09:22 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, 
 Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org, 
 stable@vger.kernel.org, Tuo Li <islituo@gmail.com>
In-Reply-To: <20260220113937.2691322-1-christoph.boehmwalder@linbit.com>
References: <20260220113937.2691322-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] drbd: fix null-pointer dereference on local read error
Message-Id: <177159656185.567740.9381187974299808709.b4-ty@kernel.dk>
Date: Fri, 20 Feb 2026 07:09:21 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3


On Fri, 20 Feb 2026 12:39:37 +0100, Christoph Böhmwalder wrote:
> In drbd_request_endio(), READ_COMPLETED_WITH_ERROR is passed to
> __req_mod() with a NULL peer_device:
> 
>   __req_mod(req, what, NULL, &m);
> 
> The READ_COMPLETED_WITH_ERROR handler then unconditionally passes this
> NULL peer_device to drbd_set_out_of_sync(), which dereferences it,
> causing a null-pointer dereference.
> 
> [...]

Applied, thanks!

[1/1] drbd: fix null-pointer dereference on local read error
      commit: 0d195d3b205ca90db30d70d09d7bb6909aac178f

Best regards,
-- 
Jens Axboe



