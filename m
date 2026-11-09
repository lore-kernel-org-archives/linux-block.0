Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794260466;
	b=BrcDBKP6ZeXoyG+OYEyUCp4zG20ll64gGZTZEUMa5E4Dz69Bds7qDBJthd9VlI4Ar7Uy
	 NLOpmP26vXZLg5M+G2EhpoN8/JrqhZYkFzMv5b05PFSX5NsSpUPQstIRiyawaccAllOcA
	 +/9XFnQN82DS08swLWPOcMPWvO4kB89ii3re328k7eMNt4DUz8T+KTYErwziqX95w+P0f
	 6h1wHldHjTK9aeCGM+yTe8t0C/+yv0IHt7HC/KtZeKS1+qD1stcNygu5AGefkputaX1G5
	 LJhBtUo72P71nLldY5qAxjUkfEkz/xNvo+sFnmWgT4GLWP5vyLylqi5MqQGj9UHqAag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794260466;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=By4KURhizAFsUCUD82I12bXsDStdt5cAmT5yhqtFyVw=;
	b=gHxohTJJZ96Cee4I7a7pe/5Eo/ZWaIrxBf4GoSjGl8TEXEtLZpnJiGp1rzCkK0MTrKbu
	 3Put0T+SbjMp54264cr/VJIPRfSib4biZgYR2J/ZRuvVawubc3v1JAYRK+dr74HO11tt8
	 Gs2vehqg1Uhv/u4zJX2zBSldUrJIoFgABzqNCZV9yQ3hRcOSRWmTF1+X8hgIjvmig31+5
	 aRyuNFt8sMbonzATAOgJmaVSce/lzENK7Rsv/oBRjnFW1bJqOyveOyC2/tgNhnMSKlknu
	 McHinVsWC1/4HbKJ5mN7nHuN82IBd6hER+4j/g+J8r77so1uBDMOmVEF9Zc3UFhX1yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=A6myxUpH;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35854606A336
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 21:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35854606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=A6myxUpH
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso880807a91.0
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 13:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794260465; x=1794865265; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=By4KURhizAFsUCUD82I12bXsDStdt5cAmT5yhqtFyVw=;
        b=A6myxUpHu+Dl5sOR5LPhYJSAl5WDkKGLETqyxqOhDqdtuA+FlC4ZbWvNWnX1VYFLLi
         +acdmzY7UW6W8txrfzT9gLMm5haMYl3ENRaHNf9Zh8EJoXSGQAu8IlWPfd6oO2Db49tp
         WT9hwp/tDx/7z8+PmqPT+UGZ/+ml/UtWxdDzTmAHvoJoG0NZzN84R7FVkUYVULSDkN75
         XYDVxtmJioh/Lt8AJBqx3trD62MJJ/QpSbZxP8MmhqYsUj9ij59LTXbUiXFJjc+Jd1Cz
         +7iplAf2ydDkhc7ivsuqG2zTqwZ+qGfjSZ7Mu2j1Q7JVRss1L0/zBvSPVWwCKILyg8O/
         npQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794260465; x=1794865265;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=By4KURhizAFsUCUD82I12bXsDStdt5cAmT5yhqtFyVw=;
        b=IYNsyIFaskIYVG28Vq+pHKgjvKIhfVNpuTY+Aa4/B451rzopHdqYK+yn0A++jCVqiF
         deAeoIf7Zj5XKbtLzI6hrGe9a3j3jpvvOpcf3OqiLVA9kTTMvioqev5yFqhPAwZnPW94
         yzQ/hB4NSAZ+GCzwpefVWuNnwhjkaoEX+DqWT6noy2hvPAAfPHMbQXxOgLmFoj7YT43M
         v4j6k6tOlryGcIhPhmveOpwxIxITTdoieXiAAcp0qErW6P/fDVE5ugJ+GvHUUEHsTke4
         tU4l/DwIVtJbqMRy2iMw7+ZkSL7u4Ppqw1yLalKqkTnVsMRReEi6GwqXkPQKAauCBzX3
         1zMA==
X-Gm-Message-State: APuU4Z9SrdOZd0cuG/IEynMMTM2TQcVn1tzRHcGWkWc4y2IVcS9Bwn3S
	ZdNpD/4Q0h/H2uAnvV6nWZCKRC62uy3Fk5s7/3I7hRCwl9zyR4XGki5ijNfXGVuPgGRdw9ppftY
	541A6CR8=
X-Gm-Gg: AYBFou0ybMcDNScIvVEsOGTH2X3728j4+ktx+W+nUlUjcf4ioJ2qTe+k0ujn0WMCdmu
	t39XG3uVsPMXCz10u9JvYD7gKsLGJKKDEDnHd56IQhFbz1/ehC9MoU6Q8iyCTw2y4dHkK1N5ZXn
	MJSHCPuie76EMUgkY82bFkCUk5bwX+pf9Q6gaUEDva9fOJBWYIplNncSGLY9arkEQlnXdyR/0jA
	EQdlUvNfKl5umA1yXYCkRu1qe730NnVQRfavHer7+5e1nvvhExZHmByZtBaeBNNt02hdQPosy0N
	ap/mi96Bt2ROhYmySSJ59V7DjGcVCv8PFD4A/Q+G7H0yCotak0jCQcE6Wa6XKic+5eZm9Hd/hNP
	p85JryY+QdN269NIk+nLa/XrkBXYRHQ/zX0nAYDCWR1A61LwpTFathmTANnz8WmMksbILVU3vvD
	xHKUxBrOmqnu9AQUH9zSBx8VTeLAeN7WwJEZVf1QPJ1fjbEmtUkShxap/Sn+7Qg9tU5wPTIHvWH
	cHo1ggCRNLJv6pGGrvAqrMX2Ju35JQoG7/k0vUb+XMBKAMf6KrvtGMzR3hQajAOwmsdyqdMJdPU
	nsjN8adcNdPOo2mq7BfV8hpcbGgxkkqGL+JFg6eLYS5bpyu9RooNkV8pAwphR4eX6Nw2kH0o5au
	C56uxhk7MHrmX
X-Received: by 2002:a17:90b:33ca:b0:3ae:2969:903f with SMTP id 98e67ed59e1d1-3b166cd699amr991916a91.45.1794260465496;
        Mon, 09 Nov 2026 13:41:05 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b16903a7fasm366974a91.3.2026.11.09.13.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:41:04 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <tom.leiming@gmail.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261105021351.2295547-1-csander@purestorage.com>
References: <20261105021351.2295547-1-csander@purestorage.com>
Subject: Re: [PATCH] ublk: optimize ublk_queue_cmd_list() for length-1
 lists
Message-Id: <179426046337.144457.268870608872473898.b4-ty@b4>
Date: Mon, 09 Nov 2026 14:41:03 -0700
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


On Wed, 04 Nov 2026 19:13:49 -0700, Caleb Sander Mateos wrote:
> For a request list of length 1, ublk_cmd_list_tw_cb() is more expensive
> than ublk_cmd_tw_cb(). It loads rq_next, which is in a separate cache
> line from the other struct request fields accessed in the dispatch path.
> And it dereferences mq_hctx->driver_data to get the struct ublk_queue *,
> whereas ublk_cmd_tw_cb() gets it from struct ublk_uring_cmd_pdu
> alongside the request pointer. On the submission, ublk_queue_cmd_list()
> can cheaply check whether the request list just assembled has length 1.
> So pass ublk_cmd_tw_cb as the io_uring task work callback if the list
> has a single request and ublk_cmd_list_tw_cb if it contains multiple.
> 
> [...]

Applied, thanks!

[1/1] ublk: optimize ublk_queue_cmd_list() for length-1 lists
      (no commit info)

Best regards,
-- 
Jens Axboe



