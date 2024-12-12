Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B10322332A
	for <linux-block@vger.kernel.org>; Thu, 12 Dec 2024 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018220; cv=none; b=bAoUGpIC3hAfp/k7n2q2k1raY9zYnyb5r5ii+5X9K36a5JgymCfOWlBNOOUSosKNzqZpDYMO09O3zUsneoqQ6anA/g3fjVzlcgWCaMW5NH1huQId561F8VWuEcZCcejius6wC3rEbeRgbnjoMT2O0FsxBkZI0BzZdEu1D6fis8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018220; c=relaxed/simple;
	bh=1SDY9BVwo+PHBpCEZR5tvl/g9xNA+nMDaWcxqlH5GFA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tovCckiKrbjG7qDpglAtohqOSOoRYjNRrsmdSq9Xl7s/LLShxyO7dXIVvvWHf5NIF7c0i663uY4ut4JJhIP5mnwas8QdoKmcD1NQjUdoc7f2PauhZE8ilanmqxYxCgGP1Xs4JndCMFua3j46Ekotm+kn3lrCV3LiXZDD70Ctim4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YQfzEoml; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YQfzEoml"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-844ce6d0716so59473839f.1
        for <linux-block@vger.kernel.org>; Thu, 12 Dec 2024 07:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734018216; x=1734623016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O46WXKsb1Pja6RWO4Q1M7/YVo+n25hZKtG9k7XGJdts=;
        b=YQfzEomlF2Bin/CYLKtlhDpTZQu8lJmVy9QpDoUVtI1FJ0t/VoWYi9rYFygVHHVxqJ
         C0eJzA8+myFV23UjhDB7GL5bnRL/HljWUJEv9ktBomrNXZClLUv2Wp0JvaxHSsQaG6ch
         t1tTMf9nWmtADpyyWcUa6vS5imHmLRx4rbJrZ+vC4QtpM7Jt4Tv2VE0vM4dLHusNDAej
         W+IjNYiJyVnuee9HFkfeepR+Pwvt3zCs5L8EO7uY8dypaGmcXfIkEpEePiCRynpeqTA4
         LogArdAGG35BF7xXwsCjADB+By55SHN2aYkfiXfXTaj/gmro5EtJ9cbqmG1ejdxRQhgF
         DmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734018216; x=1734623016;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O46WXKsb1Pja6RWO4Q1M7/YVo+n25hZKtG9k7XGJdts=;
        b=dZ2CptpJDgJ4uma5OLJQ1cYMGRnpY+CnlOpRiPkQw/h5BNL/Dsn/ZCJSf8oVP91ad2
         nZnUerRxCfCwxwXIER7VSY8OAb2LN9nw1RMvU/yXk4Y5cCTuRDKGiUGMv9Ph48QlrhXF
         Nx2ydbJ4Et8fBE65Siu1u7LXCZaLt62aNft/rptJ5UQRxVX4OUB36xWKMPCBD6fztKNb
         2QlnnhcjnQpeTkmYQ4+kHFb5VJGe77CH7qBhgkO4iaItxtPUVTl9dZchekyx01f2aTdL
         R5aNO6TqF0ksaYkhpJyo4UZwgMKpj5Fe2oiN3yI3jd6AIVDKbns4tzPDFVfUg3BP8Xv5
         wITQ==
X-Gm-Message-State: AOJu0Yz/WwGUoGGRCvDeagCUcg8GnwMMLoZpPwN2K9Oj4HxZjYrlKPXn
	gEkwmgv3hVtLV8ic55KfQ8oT40cVNGNiuomCN9E+0EavIo5wYmZjiHnwQhtxoQ0=
X-Gm-Gg: ASbGnctdRIfziUrunrb/9fnQOv2Lyk7QlLKeLftBa3FH7b5jHGqcKpQoaC/xjztUp0P
	3Vo6MNIpp2P6XXccTnj6XhEmUK6QVJR/c6wX6HbqZpn7e1vq4WVeo0u4d+0EZHGQ0MAsCGnBS8s
	fREU84ct6rossFvEwxTjNDNcVfovuOFcPgr8xx/x/bltYt0hpKuGHmJCG0GoY2D4kCQ1I1v8veB
	yNdaFXP5RpoFOOQu5Xl3J18ozgIXGIBXmOemdi8rDu0WFo=
X-Google-Smtp-Source: AGHT+IE58rjv7YCLLhGyEmwWvn+LLdNSd0VwA6xZR1Khddu57Fz1eLXFJrQLcrzF7mTNyvBggLiV3Q==
X-Received: by 2002:a05:6602:3f95:b0:83a:db84:41a8 with SMTP id ca18e2360f4ac-844e56ac920mr91508939f.10.1734018216669;
        Thu, 12 Dec 2024 07:43:36 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2d845dcf0sm1122658173.79.2024.12.12.07.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 07:43:35 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, hch@lst.de
In-Reply-To: <20241202115727.2320401-1-john.g.garry@oracle.com>
References: <20241202115727.2320401-1-john.g.garry@oracle.com>
Subject: Re: [PATCH] block: Make bio_iov_bvec_set() accept pointer to const
 iov_iter
Message-Id: <173401821584.916607.16305637467269534844.b4-ty@kernel.dk>
Date: Thu, 12 Dec 2024 08:43:35 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Mon, 02 Dec 2024 11:57:27 +0000, John Garry wrote:
> Make bio_iov_bvec_set() accept a pointer to const iov_iter, which means
> that we can drop the undesirable casting to struct iov_iter pointer in
> blk_rq_map_user_bvec().
> 
> 

Applied, thanks!

[1/1] block: Make bio_iov_bvec_set() accept pointer to const iov_iter
      commit: 2f4873f9b5f8a49113045ad91c021347486de323

Best regards,
-- 
Jens Axboe



