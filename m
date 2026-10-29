Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280133;
	b=YWycr+/b54IRlhtLvKQEboM88phVq0hgmHpQr5dZGXshaAX1d382s+d9qGxJoNqAy0L6
	 VWmflcj9RHSvqd3n+XJdfz1cDdW+HNA4Sdn+lo82GdrOId5jQgApVsWXCM8KCgKLknotr
	 gpPuV0yOmpHGNcrBznyiflVVzCHIwQV2AgBAZDjSVRetOTxt7zmkcOtIo9nVxuAdEhCjF
	 fZszVDxCD2IC5DjrHlozI/atvYUJnH3nEwWK7cKoPj8Y3Qzh9EbD6qmFKDSGoG0Y0m1O+
	 MWEdZKijlsSRi7C1PUAGbTF8rV6VrDaxen7tx8RBJxptogSOrk+EMXfOcRPdg01Q/gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=RbMfvykaJvSw2yziQ99b22s2iiNBdHjnvgGaDrQ+gAg=;
	b=BS8SE5G27/MtR5I3kdSoOfg1IDfR5LAj3SJr3fph6FVOvv44vq/D6Im8gJEhNm6Phecr
	 HPE/D8ofiRtAu4sfpaNdbERfufDU3n7DKtIZVA6gOBVhmT24vLkZ20BqKUC5zJdFC+Onn
	 OB4Esn/Zd2hMPxTjC4OjDjqesnmK87+w97hqr2vGsQ3y3T6sAkin55tB7twJ4dIYc8NMi
	 N3/AbPLWd/fWgzqRfI5wMfOeZY4kKkX9UDfCygSGkHQJYyEOxyt8XS1umxJ5BxDPteEff
	 wAEdRbmAPJ8q2Gdwfsq7wpwA2ASMnBw3XPdsoosI2+1cXD+L/BOSgvEI7DiaeMEYvxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kRtHH1gD;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBF0606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 13:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFBF0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kRtHH1gD
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36661f953e4so3422318eec.1
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 06:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793280131; x=1793884931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RbMfvykaJvSw2yziQ99b22s2iiNBdHjnvgGaDrQ+gAg=;
        b=kRtHH1gD5HUWmaq3jBAq/5ore+P1nRlpGoJcEKD7p4hskupb5+bix2SctRNz/t0dSR
         gNaLPv7u7cekVTDWu23t/jIxqf7nqNhKomRCalel3Xmp2U1Tcyjn14j4eNTwyJRziEI/
         cuexQvIG/3YPnVamjPIJegpeR6Lg+AQqlU/h9xU1itwf7+efeWkZKB6bwn4psd7edxks
         ZIBKCAuNPZSZpCdibRs4nUhpn+4tps8GTp0SOzMwpkZW4CG8hF+ohWCtOLBSIMHifA7x
         dcOZM7xqerWpEd3h0ePi8vEzDRnB06/lSVb+yXTYG/zGWtEeu+2BUYXADlEp7jTmbv9e
         Aymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793280131; x=1793884931;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RbMfvykaJvSw2yziQ99b22s2iiNBdHjnvgGaDrQ+gAg=;
        b=UnbuyxwW4RDQPReM6GuxKXS6j/YpOvnMk1RStvzI6DsfE/AMM6iiKvKkML0ozwlNm3
         GeCBa11YrcQCGjezB+InqF025FVgXUb4wt5ZtqUOyJbRc5ra2gWEgpp5vODPQ2GhSfJI
         Obs+QlNgvQ2dimm/qJpAJW5FtG5HdujcJHfdRWAW+s2du+RguuO+c1wOylJkdl4fJt+s
         7gcmM131wHSO9FRgomShRyq0LKqP73F/FpaoObtazhBMhpP8hqzbuAg2TotVB8ShxFhA
         TYXkQ8mPdZVSka8xFnwVvzdzBM5XI3GWturtAJBSrNyegIgJHnig5SYu1njx3I6Slgr/
         I9tg==
X-Gm-Message-State: AFq9FYIq6JStNrN5jJtPTdpLsAZXMQsGTddV3jg6EhajL0Efy1kFGwe5
	6KvyAExly0IMaySDMJMbExITDQMjb1pMPTGQIkuoAt98frq0dYunqVhjvk3yRXY7nMMsg9vkBA5
	AhuSTmnY=
X-Gm-Gg: AYBFou1mGgnd5HCO2swy+h1y87p/pQPqyOsDllLrrew00VIjp9bF+svrrE5wvl5/nIw
	+LXBtsXKEVWSX0DV9EjfyRNgkNx6LjstQho+mdaFwD/2afIgB5DGkvZYmhKMHv9GwQbpghq6M0P
	iX/0kxe+ma3fTx4RF2x8LxWN6FBaUhJx5UU6IHE2+VSNigYe30O02tujYI6cGBbFjQ1sEIvIZ1V
	112ZlBe7e149nMPP0DMBhwRalSiZnjNva1jkyBvr7kGQLr8AGn64qFMq6DbjpsQ561+/Y/+EAbP
	8HuFgPsRFGoblIR2U8S3HcJJzFhAj83PXiP2ZN6NNvrAw0W2a+pJVrEAr4iwqFNXKxZJ2c0ZMy4
	p2YReZPKHFZAhMik8xic4nyliMk+ajha7Bp98Kyb8fJUazjq8KwgiAhcWHyCKh5wQZ0FtOjJIu4
	0M7G2BWp6aIovWSZLUFgV55EvhUaZqMEub2qRl7l55oHPqNwqrqpZFp2VH+Iwri+QjrKk+/uxjs
	TVcfMAi/r0oCsMFJ3YeQkET3EI819hw/t2ghYASwo11gZ1tUYL0tSvGkh2tksxmME0f6ah0AaiN
	Ezm+CAXYkgOA192U7pleSBiz/iFi0jv7F5YAeA9I9nYs1xP9rQjZEvkQckXtLIrX5Wh3eFNLowR
	yRxq2UdZkl0V2
X-Received: by 2002:a05:7300:7991:b0:35f:227b:f8bc with SMTP id 5a478bee46e88-36a203ca56bmr8104274eec.11.1793280130739;
        Thu, 29 Oct 2026 06:22:10 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a237bddb7sm16156383eec.3.2026.10.29.06.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 06:22:10 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
Subject: Re: (subset) [PATCHSET 0/98] Various block related fixes
Message-Id: <179328013002.1424775.13240913704983704906.b4-ty@b4>
Date: Thu, 29 Oct 2026 07:22:10 -0600
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 28 Oct 2026 10:41:03 -0600, Jens Axboe wrote:
> Got a giant pile of stuff dumped on me, and went through and did some
> vetting and, particularly, commit message rewriting to get it to a
> somewhat comprehensible shape. If you're CC'ed on a patch, please
> review it. Feel free to queue it up, or reply back why the particular
> patch is garbage, if it is garbage.
> 
> Thanks!
> 
> [...]

Applied, thanks!

[04/98] block: fix use-after-free of the disk in sync_bdevs()
        commit: cebb1c2331c2af1b7f1c822ac672a7f77b54bd90
[05/98] block: don't lose the status of a failed flush request
        commit: 67c43ceaa29e9b904216651697adf20445b219fc
[27/98] blk-mq: don't trust the cookie in blk_mq_poll()
        commit: 24974185999fd80b676fbe2a6c7a97bbd38aaf3a
[29/98] blk-mq: keep sharing tags fairly after a queue update
        commit: 620cfc7a664278a55d068ed88fff1242fddc4ef2
[30/98] blk-mq: don't bring back flags of a completed request
        commit: 9531230ee1fcb8eca2c9cbb9bf02651cbf798842
[31/98] blk-mq: don't forget a timer the driver has restarted
        commit: 0db9f8968a8941d4fc9fddf220d4983d9b68deaf
[32/98] blk-mq-dma: initialize the dma state for P2P, too
        commit: 035236c9e135a2ce7d0f68cb56e63d4a3da2abe1
[36/98] blk-mq: quiesce a queue that joins a quiesced tag set
        commit: 71ec3c7d6db80737b781d2739d1325b7e39758e1
[37/98] blk-mq: exit the hctxs of a queue under tag_list_lock
        commit: 89a2381482d8ff8e4fe0b7d32797bb4f77503b89
[38/98] blk-mq: set up a queue under tag_list_lock
        commit: 4fcc499ea9bc31b02393904a1903e794d146f5f7
[42/98] block: partitions/mac: compute the sectors in 64 bits
        commit: 6c55f94317249bc195e197f6a8730c843e72ea8c
[43/98] blk-mq: free the bitmaps of tags in the SRCU callback
        commit: 10b249e9b05eed0c4c65b9b89dfc2cf33d68d19a
[44/98] block: apply the segment size to the integrity buffer
        commit: 26edfdee11eb2afe08fb5f874edcdf0786d6b66c

Best regards,
-- 
Jens Axboe



