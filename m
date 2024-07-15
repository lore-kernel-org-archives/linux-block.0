Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FA746556
	for <linux-block@vger.kernel.org>; Mon, 15 Jul 2024 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721062684; cv=none; b=A+/DPi4sQj1au5FEVUQ9+cKnrOVrvQYUDGE/lp2OOLO8bzX4YQ2SkL8B1Oxt/7FSvianJuwzDklG4rTGwTcKPV2TOKhZsO5EhlxvL1BnsvVv6/FIf7RSANpkJY5CZRk/BTjgepby/JCdyzw61l7z7VdipAolLW8v++YbEmeCW9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721062684; c=relaxed/simple;
	bh=IxJz1HEy+JpE1vJBiifQpmCm2PJ240J6ITqDKSCG/L8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Pd28bGr20/D0bGIMEO7nXSswGDpko/y1IYTtqNd0PZF4nZAVl3iIlnQrTYn23c86zQZKkhgJj788L/hWS0v20/b5fNmEBK31KM7t2R+9u2V75mFcFBA65bK8hNI6R87Fdl/+8plTzhxEDNv8/oZd9ivH0GdncjoWVcUq2fIBVSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Zwm6SCo4; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Zwm6SCo4"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a77cdae5caaso39479566b.0
        for <linux-block@vger.kernel.org>; Mon, 15 Jul 2024 09:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721062680; x=1721667480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Dp6fCCpQAFiJ7LQFdQvbhCZwILPCOZWlXEg9XyHob0=;
        b=Zwm6SCo4IORJmyW5XhWW+BGQhOx+9ph2Gl+ysuliRCbfxrX62SDz53gwU5df6XLTvl
         JTQE8DdCFPAdQGWW+90dxL4rGIk7G6IpsAT2eMydlrPM9uAZpqhpfhWrn93aayoRtQfA
         nyE/+mvXlR9WS654Yjh7skzZMFvoNSziTVLdTPjEQoCuQorXt0F56mYC4McLgqOtB7lW
         9wTqbshcASWBAhG9lFJpHVotUKQdsYhoaI0c6bpO7k4Nh5IkbHOyqYhbGnKBJD+q83z2
         SYm8E8n7hz/7vYvLbQW8cw5aatHU3AqQC+ayDpquPyGTDu6QcBo0+qLIUZN329GinNSD
         hibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721062680; x=1721667480;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Dp6fCCpQAFiJ7LQFdQvbhCZwILPCOZWlXEg9XyHob0=;
        b=ap/C4rJA9v7YwYHe+8SSaIxVt9SyyFqfmnmHZe+A3/2ov0HlDRVDWp7FepowVc30Rf
         6378exVcTZoQAAbMWmG1LldURRn4JgM8+m5ZbvrzK58IFiMZjrSCwe3XebSE6j/WaKiD
         kZyaLCsGE+UAAWGIMTzRNEtcwYMcAvPF8hZ3nAznhl14GkCw7AC1IWtsgsEci17SKAwt
         nkSzXqVsB4TuFDml+0expO/owJvDXWyM3xBexuwsfHfAEtdyQdNfNKWL3A/cim281eKP
         7Tjb2jGgq0yX+rzVNkzWGui1v0TrcjXNagerAqRWTB9x1o5/m2/Ro+4DB6kLvlSVEHLu
         A8YQ==
X-Gm-Message-State: AOJu0Yykz6pUeDrRYRm5lj/crsCAD4BvUUePHy/q/tzLRFDT6cCk2/3d
	FHZeSVhTi6lPHn6RKlb0kQ5fAqm80vyp7ErD9FLlqI9ZnT4cP8eWCSxclygMl+U=
X-Google-Smtp-Source: AGHT+IFXHNVR4+Mql83LD/nzPrlDHiA9SFqIznByjudVAKR6dxhYzi7ejPm9gDaXQitj7dgXQ0e+oQ==
X-Received: by 2002:a17:906:7216:b0:a77:cb9c:e806 with SMTP id a640c23a62f3a-a79e6a915e0mr18337566b.3.1721062680449;
        Mon, 15 Jul 2024 09:58:00 -0700 (PDT)
Received: from [127.0.0.1] ([80.208.65.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc821809sm221453866b.208.2024.07.15.09.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 09:57:59 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, 
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
 Carlos Lopez <clopez@suse.de>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20240715112434.2111291-1-sth@linux.ibm.com>
References: <20240715112434.2111291-1-sth@linux.ibm.com>
Subject: Re: [PATCH 0/2] s390/dasd: module warning and error check fix
Message-Id: <172106267901.10201.11169554689467623987.b4-ty@kernel.dk>
Date: Mon, 15 Jul 2024 10:57:59 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.0


On Mon, 15 Jul 2024 13:24:32 +0200, Stefan Haberland wrote:
> please apply the following two patches for the merge window.
> They fix module description warnings and an error check in a dasd function.
> 
> Carlos López (1):
>   s390/dasd: fix error checks in dasd_copy_pair_store()
> 
> Jeff Johnson (1):
>   s390/dasd: add missing MODULE_DESCRIPTION() macros
> 
> [...]

Applied, thanks!

[1/2] s390/dasd: add missing MODULE_DESCRIPTION() macros
      commit: 1f5a33315362cb8ade2b15489c985ada0cc8623b
[2/2] s390/dasd: fix error checks in dasd_copy_pair_store()
      commit: 8e64d2356cbc800b4cd0e3e614797f76bcf0cdb8

Best regards,
-- 
Jens Axboe



