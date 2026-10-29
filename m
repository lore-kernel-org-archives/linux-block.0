Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280328;
	b=LDJ9BZ+TA7lrO0TShE5MQ5WJS7UCF8B7KQfkDHFYPbEhXi0ZSbSq9ltLpzsqwzVtSv7f
	 0gcnGuO8WZV6rzjLdTiCi/98V4MD4Ru4NVI5/E+nv5JSplzXfajUmpG64UJ05yRpvcHDa
	 hx26kdrWsYfDh9sSY0ZqmC3tSHO2MB3aOEQor9InZcwnVfLnZtXw76RWlzGhsszRJJOtj
	 R1oxEKd4Wbk0lEG0p1kdmtiPsOzNrsaq2Pm+DVdBFtAR8JIimWNCCL3jTPuWpgYkV//Rd
	 x55T56D8BJbVaQCaoTSFJB6mfIhSym5ULU7EOUh1ZM3ZPFmWlJnZZOhodMZKb1Q21bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=gTNgSkRYszqmliUX3vVTL+yOABAEQxIW2+ufpymi6qo=;
	b=er5WUA6MKnkEKGQShTu50/2Jb/P0tIhL8X9RvHSNVa3R78b9c8GGMOfXG+sWD47hk2zH
	 QNhWWN2f7pG49/OxjN3g6qyhDCsx7ohLUeSH+9c48a3xLuYanHBwMDV1vDsrO0PTXngzy
	 ePo1qb99lBHxRnplbZ0jYypOUku3d+Z/in/O15SfQB79b9JdQLjSoKRfYQTTfMCAT6YMt
	 3BNxmvRSTiTVZhwSM2rHtbWSVJaCjDUayJuK7AabZWkfTW5PUUhEzFkOp4psQQQL3Z5R3
	 PLDSdiMdFF7afwY6ZZwOviGPE1fhJt8HqvkjAxguXA+eo9dsOq3vKEAv+SuB3ye4yhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HrMtGLCo;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22006606A321
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 13:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22006606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HrMtGLCo
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36a18fc7a38so4255440eec.1
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 06:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793280327; x=1793885127; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gTNgSkRYszqmliUX3vVTL+yOABAEQxIW2+ufpymi6qo=;
        b=HrMtGLCogVI9HhcfrSHNaZCH1BHQTSDgjf+OZm6rNOLuCF0EfJvKU1X8wBqrtETDGz
         W3CLYknnsA/k6V4hRo1z44UTzlK71rzNTpOPKJMjg5GMlsQ0ZVLbQCgHN0oN75c3vwen
         uYGXtIq1YGBTXf+5Q4dEE6h+CHo0i8TWEYSc1LF0zDqzJO/j/0s9ANN1+Rlw51QV2dPW
         ej/gTCnk/wAq21wSMwKVsu2EHLbb+NoixtrLGdn5IPvK4IzOaxeXB6hLzRq92GPnKMmf
         AM0f2o3afroRQVuWDtXcT2YuzgEZIBwUzm73tCyZRoSAmZRHc/URLiM59tmpDb9debSD
         xgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793280327; x=1793885127;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gTNgSkRYszqmliUX3vVTL+yOABAEQxIW2+ufpymi6qo=;
        b=O+9ZD+2DrAUK+zUc6p4Fga34egjqKpWWKnjzYdToTnVoTfOJN0QSAV3Zt9i8WfotJt
         b0dva8pPBXBq++HdiBWKr8zjPpP+SAQnMAMLDV6dsmSDRNgswyRH9gc4pG3ykXRU8nMx
         5/fpTwpadXBmNvwA8vB1zLMgr7yp333WyBZI8p4+gLsgQVwghn46GUXd2lwzowGGcV/o
         61TWd+HoOlzxkRFD9k4LDDsNKhdO4pucWGQGlUjaHrga+vX3kaAewHo4WQW/kLrhqrnr
         7K3l/Nc+Sy4tXkSt19/HdRQmfqd7OWVyUIwPh5NuCQ7oLnGv8m9Vpu2sv2z5XTHXRJgP
         JGKw==
X-Gm-Message-State: AFq9FYJD705ORrWczMf9g3NClk4PJENLWx0dJEKJCZWpyg/LJfJ/K1JS
	TyAiaT1huRidG3qxx9WivcFasTVXh21HRbqJJ/BEBd7xiPA2pEOCquTgbBxoaqgGgkA=
X-Gm-Gg: AYBFou1St9whvd6brz0kzvQWdCS8A/kWYBeK+OVGvO6M5DHGrLgkN+VBTjzUJCWUH8w
	HZGC1LRmxjCbsKQfbQvhHPf//Ca1iTRmxsWP4m93UzOk5nJTqPtgJKsAm/nX2riUyAhIykPLzWj
	YBvbsI2Al+uzdBHdx/SXMShpfwPnIbyOFbHWQoHEC78xQE4qWwPqeE+dEPXuk8fs4VCbvfkCsfG
	+kKXHlTFko3m1FVCehQP8PwLANiiQZlDha5blV5f4C9yvneru5hgz/qy25p9mQ22PTcB8qQd7oI
	G2bvmXhNnuKEGGCjzlBDYE66vtf8mesd9po3Vlp/hM3LduH0NGJNO+V3X/dWyYbJaKRRk4qUqDb
	FcYjihYgYfM3vnI0bxfbNyBap2VhBvtnS481YzrnxDxsKZApy14r8xgGKa2MW47wrAXgUmAIfb8
	Qw4YE2hjtKliSop1bN1NToliSK2McTFijEwMoZcJGNncrApziu06mqxt5hRGd/+CUhQk9JfaH2N
	IDNreOIn+DSpy9JYqFTj0RNMIBsmEyIJ3Ch8ptuXo+dNKMu+sSHM5DrFciGSGQ59g9NeolFvhLT
	JwfGjLyX7zMedIFrJNPIm6wS7MW/i4jCnqi5kpd+tCaqdibdaI7aTAYlFt8KlMyJjcZiYFCZXrN
	wTFdIFabl1oTb5Q==
X-Received: by 2002:a05:693c:41d7:10b0:356:b370:a0ee with SMTP id 5a478bee46e88-36a2044d2a0mr7649136eec.20.1793280326895;
        Thu, 29 Oct 2026 06:25:26 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a26d59f0fsm14713192eec.6.2026.10.29.06.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 06:25:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
Subject: Re: (subset) [PATCHSET 0/98] Various block related fixes
Message-Id: <179328032631.1431986.5042945197386743579.b4-ty@b4>
Date: Thu, 29 Oct 2026 07:25:26 -0600
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

[12/98] drbd: stop the start_resync timer of a dying device
        commit: a439d3fe3ec2bfe0b4ccb77973ae97949bcf46ec
[14/98] drbd: take req_lock to skip the initial sync as peer
        commit: bf7fff620c890a7ee0b444f1c7e9f0d1263a30ac
[16/98] block/rnbd-srv: don't free the device on a sysfs error
        commit: d9667ade40f986c565769a900ced6ee95edd33c6
[17/98] block/rnbd-srv: drop the sess_dev kobject unlocked
        commit: 81941915d53ef3384ab4e4b68e92673e66cf66d7
[39/98] rnbd-srv: fix use-after-free on two CLOSE messages
        commit: 4912dab88baa5f7034dc9e38807804d470ae5438
[40/98] rnbd-srv: publish the sess_dev at the end of OPEN
        commit: 08ebf69c78a02afb39b7728f3358c09bc4cf067d

Best regards,
-- 
Jens Axboe



