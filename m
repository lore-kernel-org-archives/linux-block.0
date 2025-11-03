Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EDB635
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 13:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176059; cv=none; b=HRAAP3/J/iNn1IQTCjHugjnUlQSiYgDC/mCOlYG3zdJOjwTgpazAA/MvCTlQRfW7BVjxAH73xwAk6WDT99onx2d1Far+kYUi/ebsrUQSKA5EiUX5zyCyv28DnNcJ49wLrB3Ym9ENOJEOWjRNVAabDJJuB9LEeHSL4TXodXKYVQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176059; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dchlGrwTKfDC39I3+LYh994S7J/7nl8u2wc7kgoRe08h5bQZXJuqjbvsc2J/M+SKNPDCnP0ruui15S7pdFrfoonVv/+Dc4NMs/LshvFUgDXDWQ1sboZ7Xaa5DfQEDaQTNFPkgQsaoRRRKh9MaCdVarNbigBLMTyqRYzvqL5sYmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5xE9YxF; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5xE9YxF"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso3471736a12.3
        for <linux-block@vger.kernel.org>; Mon, 03 Nov 2025 05:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762176056; x=1762780856; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=K5xE9YxFrBeO1X5k2vO1UJWe2NKn/h+6jzNhTAOVNg88ktKUJlcBO3F4YJuAUgK/Jk
         K2z2yT1sr6am+xiQuBppP1BcS9d81e/qx2cqAnzC5nlh6mq8srxnUo3YhjGAW5UuIk/l
         /PQqJ2ruqaTZWhn4mmRQJ2jgXe+NOc1Nzkute8eEZOu/aFBH1ZlHheMN4ZklIA3NHx90
         Vex2XGKoLZhtRx/CUlOiM4/oSNQd4vrgiS2j+wVDXnYCoC39/RX0rzdCTw6aV4Jkseg/
         GjhG3xa/TIo2qXiiUtS7jFN/0VEzQupq4wHI2GvZwmzqcMITrruqaGPjiE8A6sHbf1V+
         8chQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762176056; x=1762780856;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=HW3jccY89LNZ/yLY2zVbMa5jMWxVLnW4R7V53VOvDJaFzJsgJZ+BeuN6jPc9fadvzh
         kW5cLa4k/aJc2SG0PmGrTcI6d+YI/3Q/4yqTQDKaK86hRLLIBeoTdKrSmHojpD6QUoYx
         FuStltkr/3JIWJf+OQLIG+EV+l3SeR77bX1NqN0L+038kQ2OT4PkQ2d+D1H1oXFHaiVU
         ztQVhfHa4il3AGfFvGJVlcgQfCPByiMQ4A32ZuXtXX7VVTPNt2YjmcoXUOgdR/ULESMo
         qZPVt3p9Kc1+jLmh3DypRFhxI9s3OTU+jZt11YTjYNktN/kCyt7erQcLy9+1pnDG202+
         xYRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX02+QSq1PzRSmC2IsVyqyBBAG8KL/UPx/Dpk6mpEdMiVuK93L2qNHX905BsDFRuIJ37zDFIPDO9Rf+3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIeqIstddmq9+o56maPLhtze8FH+QQNsNh1YqCdxqDpRz0ANtQ
	0bwl/4gg4fchIUUQMaQWm5olYLUuzhMBgem7OcIL8+3rficeoPnkXpSg7c/sJnaXIrNs9+/j8pc
	6q1Fyd1Zh2zM5rmb/yFuAR1c3R2Rfyw==
X-Gm-Gg: ASbGnctfhGcb/wvNdp07mdKGx7uT72YUXalhdi6uBniqkjjUB3jNDXewmYDxIeY65Z6
	DvT7b3dHdpRAofxuV3S3Nj9EJ5v8MzxFHJTPtKX4upf1MtcWw43PbJwP0c8eYeTYl69mYNWsGI4
	8JRqMGs+X8gdkbIlZojKqQSduzzVxDvzuwgE7k0WnQOTpNF7yPc27ryhgBpsmRzJ8Babp8SaOIC
	ilMqXxoN9rExYwQj/K5UDlHGn74xbY3ReH6DCDFIJ+QVV8QTfm5oqYbiQqteY00S0+aDtQgumH8
	U46dTGzHCJfIFi1oUSfoNtR+bQioEMOUYVihCrC1PwovIg==
X-Google-Smtp-Source: AGHT+IF3LTr89nFjbGoS7hJbgl6+dxhH5VK2KXUzyIqEiv1KrWSuv1pX3LCfT49kdTm2AHFKxYr5TjiCqTiNfBpfggs=
X-Received: by 2002:a05:6402:24a4:b0:633:8c43:eff8 with SMTP id
 4fb4d7f45d1cf-64077040526mr10313624a12.36.1762176056159; Mon, 03 Nov 2025
 05:20:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103101653.2083310-1-hch@lst.de> <20251103101653.2083310-3-hch@lst.de>
In-Reply-To: <20251103101653.2083310-3-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 3 Nov 2025 18:50:17 +0530
X-Gm-Features: AWmQ_bkZ4vlfmlqQ5XNb-WejF0xczl_KHyuI_IT3DY2mmAwPi7-hxfX2-JDqOH8
Message-ID: <CACzX3AtB-NNfNR3EQbDzH4AnyjkLBGDuOd5fkOyJ-QzS_BsNrQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] block: make bio auto-integrity deadlock safe
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
