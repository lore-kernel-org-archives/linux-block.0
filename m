Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDC637AA9F
	for <linux-block@vger.kernel.org>; Thu, 14 May 2026 09:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778751358; cv=none; b=n/+UCAKHIzaR5PR3XQdatAN92sHRt3JLn6XuTF7pgvMgtxyrerJs1gXRL5ApMqMCa+pK0SwTSehV6gDLIVHjcpiyEfAG56cqwgynZrbE8vFrZgTEaXwOPVIiN5wosy0T34T6E5WcnKOVJCRzswBIyIcXMQ4FyOQD3z6hq+PlpxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778751358; c=relaxed/simple;
	bh=hbjgTnMFdB0UHkD6SvXfaCN8oJ+sSKw+zWFMv0dICEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+6OwT5qb7LD9ShQ/a+xs8ZMhWNFliD4I6BMF9QBxiHwWIBoS76HAWqsiHhWoalaoL65a41qmnuOpG4LdnlBCLX9KDzqJ76wz6FlNKHF8/ldScYM0/Qz1T+t2UO4lD4RFC+/iiWVeiLkdkBTbIMHSVknZT06uCofCIgGol35yz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SovgS0yB; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SovgS0yB"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-479e6bc357eso3076543b6e.2
        for <linux-block@vger.kernel.org>; Thu, 14 May 2026 02:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778751356; x=1779356156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yGQU1E4xrz5jY9kkhMp7qvRw5Q77txT+qGRo31Fr7zg=;
        b=SovgS0yBRM5/K00iDKjbrO6ebA+8wmRQrzDoeP6ZbidpqbZ710ziexRVZIPGwxUbuu
         vonYk3zJh8mOagJi80Nga0eMY1kJO4BRrAYTm2q0zeXDX1Fwj8+mDvCHuCSRw5RzU2JP
         nhl7n1ch3JugyzDTGJ9mQhhLl+rZonBQM1bFlEuirfvW/fUBcBadsQs8B8/JWTqiVRAT
         4dcQQUdPs7zFnIybRZR/MGMfel5jOFmkosZcp+qcrNV+0i6/aSqF2PDgX64cydDaQkYw
         i5b3m907Tooyn0oV2rNLQWhqOOS2LXrMNhlFTk5l5dAFzXRZLWdu6YMPOAhEFrdlb0KD
         SmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778751356; x=1779356156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGQU1E4xrz5jY9kkhMp7qvRw5Q77txT+qGRo31Fr7zg=;
        b=Ksy/6hvBhUbmSTB+Oqk5v8dBNCYWS2YY9o5DBUl4mjccYyZY8coCLx/mi+sxDDaqP2
         n/ksfFcoLFPYRJlR7BQyWomiUjoEioWYpf+5TujAbSnlMC/qOR+X+oxM0BP/Ev8vjJIB
         wZh5dYju6jfU9vSb1pQ2cU5e4ti/gimlWr1E2w1gLdsZymErpqpJ04V+zUbrP4E072Ko
         hWAPZqqExG+hLoSQWYa5wNPCQTpsBipNf0Fhh6Bq1Phmng+ebRtaT94nJ1dVelC9lgN7
         2HulgxIaBLX/h3TTdDyLUUzcUHRiDYdlMuifhl6xtp8NCIIKKUKQYgoP5zKHVNPSrlIr
         25hw==
X-Forwarded-Encrypted: i=1; AFNElJ9U/OHDKzahSH/eosxYXru4wzjHIOWp3mun+TbCLfX06S5lpLSe5Q+8mQmkDJZK87CB7aFDL6mx69HXNg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5NjZDcwCSUoE2q6ER1zPlnapgs6PNuoq06FjU8NmPr4FG+MLz
	GYSEJtStVT3TfplbisU4oRz52KifKc6dpPSwGce5bdj5VeyXY5QRxEtL
X-Gm-Gg: Acq92OGfMhJkLX8RjaXHmLOJL6eKjX2SznaDEPDTKwgBtcubGh6C/XTXlHKBarBvZfS
	m3P9ucUN1D7oCKV4V9pvedYGKxL0bIyRYfGh12FsbVPcab/53x7mtG/2Gke7zSJfoFUhHRQ8Ild
	1OroJ18RVaGMhtWb3EGqLMNB38X7ctBFvF15jIEHJGhKAu1gwwlyyzQTuQ7eaUdQagEy92/m0vS
	dK0xF3s2mDW8CAzao0Ej09Q89Wy0uB7DBISTFxHhz5xtUndWZaP5Ax9zhOvqzAqpk9q8KFJIIRx
	m4fImCmZnCWmtxKGfflRysxOjR91ETvn6podLSLl5fEvoemwRx1OpjsSu3F0JvxFy7/sZZBdKQN
	Bg62EdhXQkQgNigsufFNz3QXxhzjnnGp77r3vFSZOIr0/9SQMfIpDSk2XQMbs9yPiBPi6q7uGmh
	BDcV7WMPffb20c+m6Su3OvId9DIL6N+oEwl0aaV8JgEVX7UE8waOj2C8vA77jsr2T00gcQmo2Hx
	cxlsCxlmiE4K93gNBK5
X-Received: by 2002:a05:6808:6701:b0:467:26e4:728f with SMTP id 5614622812f47-482b2abe939mr4063997b6e.12.1778751355874;
        Thu, 14 May 2026 02:35:55 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-482d379f062sm1022887b6e.6.2026.05.14.02.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 02:35:55 -0700 (PDT)
Date: Thu, 14 May 2026 17:35:49 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7.2 1/2] blk-mq: introduce blk_rq_has_data()
Message-ID: <agWXdbdCNrQ_RwOU@fedora>
References: <20260513211846.1956810-1-csander@purestorage.com>
 <20260513211846.1956810-2-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513211846.1956810-2-csander@purestorage.com>

On Wed, May 13, 2026 at 03:18:45PM -0600, Caleb Sander Mateos wrote:
> Add blk_rq_has_data(), an analogue of bio_has_data() for struct request.
> This skips one dereference relative to bio_has_data(rq->bio).
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming
