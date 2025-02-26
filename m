Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E064218AB5
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 02:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740537935; cv=none; b=A6hhE4fnjqDvQpFL+1PQQIWBYXPgMjAGsXXISsCgJygF04T3tm8kw5868QLulgLy40l0eaqwTZ75GFA6GTTCeYN+YKsZ/90qjj1WxchqLBhHYlDGwIm4oulvEQDsjjZHMJUXr+a3NUE+LHHoKKVLFUy4hX+IpD7iYFoaABK8MyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740537935; c=relaxed/simple;
	bh=eQV6gPWwFTgh8YfHieTjl9zyRPPVldsLh11Xx8E4TpE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XPzhVGxJByxjt6EqliGaZnb3AP4nIwD+evHEk/VuCvLETRh6V1/PMdQIhjO7rID5rfF07lH47oFhELvSL+o92Ojbk4tEurIy4QHK1kk1B8kKfjEV9lZQMyd6NvZr8UMNAKcs0Ps148GrGLLqo2ep0xRrrt2gR/MasYYTiR3LYa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AaKfaa1W; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AaKfaa1W"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3cf8e017abcso22335705ab.1
        for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 18:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740537930; x=1741142730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVauboCEQD0GSkm2N582o8R4XiWoEllcCs3786n3A58=;
        b=AaKfaa1W4gPJ32GJSjv04o83Hi2olRvTSjqPnH2PttAiJ0w/Ks5EFV6uOs+TTIxs/C
         eT3DrfJDj7U4urFUGa40e622h92Sb5puofSJBDDlFL/pB5Yzre5UWCuOsvswOGL9UQFd
         b6p/dewP5Pwez7v1YxCU6+v56wfyp6rg8sDJm+CZr/keZdB+PJIk2kqEEWSqCgmOufq9
         k/B0cv+NAw0/zo51/pmGmEFsBsY8AdZ6Y4bYP4hoHKo6J3TSKE6KxnuR99NDXh8aJrXy
         NYtAt1zkQ0RWRPOzn4dif8ozsvAzEWyNsf/FGr4MvwugPCBJMrnrOKbnbasDYUmDFi1w
         yw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740537930; x=1741142730;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVauboCEQD0GSkm2N582o8R4XiWoEllcCs3786n3A58=;
        b=HQ6G91GZlcSuil2Fn45wk+d3LX2DjPOdcOtzyy+3XVZxqrtrQk2P5vibp2LLPCZp0S
         Ca/Wy/OD2rSMVzUiUMOsWmppNZLq7DGlWy4PbhVKXkD0nZ3gb4wdiBCKPIAdxArdPMdG
         SoaDQCIV94DZvhkYIwN3WB2pNuH1TbWOdvjrrhqui26P2Ng2Nl+2dsAm5uP604Ab8HZQ
         nqGV486O55TC/6/JuX2QP2qph89LkXtqca6K9g1HPys3pL9Rd2O0DGbRmlsiSx31f20j
         uYKcK3FzsXk0Gqjz0H3JlUIYZ2xWTrpAgpueLwI61CChT9QGTrIhlXSDidgdBQMEOzAD
         5BVw==
X-Gm-Message-State: AOJu0YyyGRprFkd2f7tu1pKYgxpp+JOQtcReIAWL1/xs89ylV89gliXA
	4t1IqQs3GhylKB36nRETdlAhIwwAjoczdXoBMqdetyVlw2nJmzNl4dM5GyNE+CvCyuI5HEhOS/a
	z
X-Gm-Gg: ASbGncsGXXbmGj04clLjADzz8aG0jYUHEi9EGNrKrROAsDuhLT9iRlLbwGOk2ceYHoj
	iqJaWjPFvlgHJj9SVmVeTIOXnrCSTLKEbOEDE3+k/iRcwps40SNaWAxr1ak5CUgwZ3qe5ZWi95T
	9lXbydIK/bXGgADHvn1UTqK8wf95iv1bUrSxuu3IuSsou1kH/2LQhykic1a2BWbVmqzSd1jqa4G
	46YfQm30AdEgxg1tmhPoQ0GLs4tC5GiaV4yuMhnYMmVuLvOUGFFm41TySAa76nVFa4gHxQRjgNs
	YqTMXeC3LdXxneJF0Q==
X-Google-Smtp-Source: AGHT+IHxSSIivA05VD61veW5lbj8YBxRnnzf9wH7zFYiR8aL8y1W7SKHXU5JcXzikTzo+i0cyuoOyQ==
X-Received: by 2002:a05:6e02:388e:b0:3d3:d132:2cf3 with SMTP id e9e14a558f8ab-3d3d1322ee7mr25933955ab.7.1740537930533;
        Tue, 25 Feb 2025 18:45:30 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f047514fbfsm684013173.100.2025.02.25.18.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 18:45:29 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc: Jorgen Hansen <Jorgen.Hansen@wdc.com>
In-Reply-To: <20250214041434.82564-1-dlemoal@kernel.org>
References: <20250214041434.82564-1-dlemoal@kernel.org>
Subject: Re: [PATCH] block: Remove zone write plugs when handling native
 zone append writes
Message-Id: <174053792948.2207090.6341081854722602259.b4-ty@kernel.dk>
Date: Tue, 25 Feb 2025 19:45:29 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Fri, 14 Feb 2025 13:14:34 +0900, Damien Le Moal wrote:
> For devices that natively support zone append operations,
> REQ_OP_ZONE_APPEND BIOs are not processed through zone write plugging
> and are immediately issued to the zoned device. This means that there is
> no write pointer offset tracking done for these operations and that a
> zone write plug is not necessary.
> 
> However, when receiving a zone append BIO, we may already have a zone
> write plug for the target zone if that zone was previously partially
> written using regular write operations. In such case, since the write
> pointer offset of the zone write plug is not incremented by the amount
> of sectors appended to the zone, 2 issues arise:
> 1) we risk leaving the plug in the disk hash table if the zone is fully
>    written using zone append or regular write operations, because the
>    write pointer offset will never reach the "zone full" state.
> 2) Regular write operations that are issued after zone append operations
>    will always be failed by blk_zone_wplug_prepare_bio() as the write
>    pointer alignment check will fail, even if the user correctly
>    accounted for the zone append operations and issued the regular
>    writes with a correct sector.
> 
> [...]

Applied, thanks!

[1/1] block: Remove zone write plugs when handling native zone append writes
      commit: a6aa36e957a1bfb5341986dec32d013d23228fe1

Best regards,
-- 
Jens Axboe



