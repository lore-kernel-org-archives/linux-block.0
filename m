Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795144843;
	b=turcKot2740NlDXV+8PUJS9fiBaDg0fmDHXOaRX+QClDeLCW09lHnKgVf8VNg6IuIpGg
	 DSj/zVn0nSKJq6OAAMVnOy2zoPUMU+dQILvBPjBhpTOhSEkWssgrUKXojdhi58HJGYF1B
	 gb+l5oXCGcYcV17qw3qCKQCt7Gk62qVLIKVHEbS0HEgPFHIOQ31HwuAbO9E/7NjIECA+Q
	 OMJlOThkTtsJYtgLm7DVLzljfjfa3cJB77G4MkNj7qoNd5voGZGk7wNi+5XN98OhUyynp
	 4Davow09YDKvpRIPr+B+tQbjBWd6P8znUfPo5mW7EV5NQYsdbmDZBYxmPjVflORgI0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795144843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=rh9OdkWtHfKHMpmbCseobiABMwvQGYP8FzFYBlimNyo=;
	b=Jxyq4NHtpDuzZeUIuXVA+GL5VlST5TZ1v+6Ql0P/wEK0jBm+JjOk85al0jIY0Tw4oBJk
	 BpEAExHxe4r8kojcExbbTBFJIvTbQ7GJLUqQZrisnrh844usv2ym0tIe7iQrGHKNg+5w3
	 Gz7IKz07B92JpS1xIBRU6bzdATVMhskLCabPaZ5K0rtYgDkp7WyY5ZH7jfTAXU3kUbi4w
	 CpVW9C1NRR/i/F0zOAsRe4gcDysa3ip4fjAIU3xZFArO0n7jUrsbpzg5Jh3hFahReZ5Dr
	 4ov/uKUsxXO1CJxC6ITIqcElJhjs9R63JGF0zTdeVP57yWbqoNyccUAPbg/g8EaLifA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smartx.com;
	spf=pass smtp.mailfrom=smartx.com;
	dkim=pass header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KeaA2QQh;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F6D606A320
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 03:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70F6D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KeaA2QQh
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b0bbdeae06so285507a91.1
        for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 19:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20260707.gappssmtp.com; s=20260707; t=1795144842; x=1795749642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rh9OdkWtHfKHMpmbCseobiABMwvQGYP8FzFYBlimNyo=;
        b=KeaA2QQhdmspjfd4kyLeas+YEhNMaC6wgUi5XuOPuIAAI7jtDB+eoVHUyPPVTDX4MN
         TsAYcX9+6uIHGZVxdeHHGVqiJKN6TqeYxv4J5m5CZrtdx4xvVXGLAHqYckQj0u1Zl1kl
         7nqBmbNvNclQj15M+hFBqNshpS0Y2pUvN+mlf80/5N63Ls8cDRPwbyUUNaoDSSaGqzsB
         yQbkQwaS1wYjLvwycZ+qKdUdo1c1VIe0SlFoXkOTefzNikSDeFSvnRrRhWjsTg4+P1cR
         aVxr1laFMX7CVpPlZk8mRLF77ejy0SsiZ8n+jVInO252cjXsXYKdxNHXwRt5ZZsoNaA6
         lZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795144842; x=1795749642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rh9OdkWtHfKHMpmbCseobiABMwvQGYP8FzFYBlimNyo=;
        b=dZAaK//WS7U1Ts5n09v0sbj36U1QlkxrM5eWG0nVwk4SeVo6ebaxQN08Kyf7MAdzsO
         CVXaCgByLulExWA1V2nhvwOu+wD21XlrupDAXQA0XvfQvXXpXNJdltSCT/18M/JtwNYw
         grceD+c5WhIKHVLy/MyGH/X1d259N5mwdD7kjTcsTKoKRwM30qaFEdst2tZicglmabzS
         iVZdx1n1JP7FZ1RoHuIVaGoaYssLFt4GBcDIMkV0eNvMtv9EmDfS5kSDdOuund1ah9GT
         ATW5hAXEsNqYdessisaleu3cdKesae6yJbGL5rA5blqBQQdXMYR9CYplFOd9OtOi4JJU
         /TLw==
X-Gm-Message-State: APuU4Z+JJDFKw7FCZjxsZ+nWDMZSEaJAfywRiTPaliP9iHttRU9eZDo9
	1hnf71dXdkZ0ure/cgcT9DWEKZiR2gflDS+dCptCTPjbYVhjqIUbYcOU8qPCOTWttf/rxcKdknf
	1XVcgSNHxNP1CoOTa0l0VgIlb3FF3N35dpfWFSYlno/gYCmfhz52+Fht4Pw==
X-Gm-Gg: AZFdTZfZUslMMICBe4BcQhXkrWfmkcWmBVsAeZ5X1L8GBsD2vEjE8BrSY5wDPvlNdWv
	VG+mX5u5RceRAWsypbO9ohPefJndqq008/++yp77ZE9b5UksIBGO7UNb5yRnGL8qGighU38dLJg
	dcTaKNX9LtnsrXWDuW/3n701Wm26X7J1+czflzzjCJH0egh7bGhZmxTuie5kStnZvOTpMJU81Sl
	ivlRwQSavtHQIEv5k0/EcjeXDgTns6Cu4CK9v4KqFQQIGiGpcfQW+mgFXcI6HRKKn13+lRGCDdM
	V4F1YiBmn84vbOuCENhmqcluwWVoNsYKk0UV2hxAvYD+H07ILXtN2UqYh5oIUi8sOs6cmhaCsBF
	9IJAox7Fn7WuoX49Cg0VsbDlfO8ECgqgTxbxBrlQuJLHsDatLInIMgJ2o58J8oPOsWywN2iMZBZ
	ySkpqsCoXiApKzhJe94N0Kn0wR51ccX6NVlJ52bcPES/X/EeLA+B08uCa2R/s7nVW9zCxepiNDZ
	6213xRVtAYM5B5hORA1nd9YjVhyi4d/FHlfoYk+7ChrIYSMgx9YiKk9Ws+9vsXvbZJDeoPQxQTe
	cX1BgxMsu2MXb3QaU8ONR0HiKnogxOt78kX0kcz7uLn8s9XHNoZ2mBPBT7kJ
X-Received: by 2002:a17:90b:2e4b:b0:3ab:884b:659e with SMTP id 98e67ed59e1d1-3b41c8e1705mr1226931a91.9.1795144841801;
        Thu, 19 Nov 2026 19:20:41 -0800 (PST)
Received: from localhost.localdomain ([103.26.8.217])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3b41cfbaf2bsm803404a91.2.2026.11.19.19.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 19:20:40 -0800 (PST)
From: Lei Chen <lei.chen@smartx.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lei Chen <lei.chen@smartx.com>
Subject: Please disregard the mistakenly sent v2 series
Date: Fri, 20 Nov 2026 11:20:34 +0800
Message-ID: <20261120032034.1068133-1-lei.chen@smartx.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jens,

Please disregard the [PATCH v2 0/5] series I sent earlier today. It included
follow-up megaraid_sas and mpt3sas changes that are not intended for this
submission at this time.

The intended submission is the [RESEND PATCH v1 0/4] series sent afterward.
Please review that v1 series instead.

Sorry for the confusion.

Thanks,
Lei
