Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716288;
	b=A4ltVUecORgoE0BpY1c0owXPjyWvoD/BhcGjBzJcyMxiK0rHOmh9suz2neBkkm8eGpzJ
	 YcV74uUdauLWCwwK9oCNdYHgLGRscZFc/dRLri5wtzwjWsJXupWgtcCeVj0VaQlSY4N1T
	 6S04Sryjvu210fQESj4XsWWbl6SuIvHoVp5gaXAbqi5hTTWENWQrEJyxUOT5rYJ6xnB36
	 2KPQTMcblurMtq9BX2YLibBelT/EACuQn5jbAr2RpsmpbSqfSizVRkm0Ixy6Pn7f5Fzfy
	 pKnXqM0IwSPi9kR5JLOa+uU1aUsQZunDHZ9exEls5fmPq9lmejupgJ2TuwjxJ+LDKUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716288;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=w+6rqmat8dLUzlB6PAGhcslRU/QsBUAoeXuoPxKZzAA=;
	b=XA6EI++yGrFt+ip0uAJt5ioujApCMLeFK+1gbair4cgR4n8zRwqDs6azw/9y7qolepEG
	 n46c3y1mhT/jOb+DGyHK+DQ49W6CEeLRWKJp+ju0g/N8QrUGqbGE561YMPKfAFuiVh7M1
	 0Mj5rOOtKVfOUTgexPV+wp2+wlJuQGwIwq0YLSePd3nNu96QX1JKd9TPgKEkRiKs78RjU
	 4RVYA0dnI1m4Zu+rhKQIFjCB+w1Unu4odBwmzKKILzBUmFq1Ht64G+ZH2KsVyaD5sZtSL
	 +3Sbhra7liHZukJDSTV0cw16NfqSUaNCW/cG31RE+H4lGy13HfeQaeztJs5nGhcYevg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="p/dfsP33";
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8502608360D
	for <linux-block@vger.kernel.org>; Tue,  3 Nov 2026 14:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8502608360D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=p/dfsP33
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1ae58d17cd9so1141366c88.1
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 06:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793716287; x=1794321087; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w+6rqmat8dLUzlB6PAGhcslRU/QsBUAoeXuoPxKZzAA=;
        b=p/dfsP33lVS7hQydRyF5+IF8ZwSyflCKVigobbFPeVkZb4GC8VxXqrDDnzezzKrArj
         2VEjpHCaGFAlUdOwrJDBywjmGutiF346GeJS3ktoLv4jI/sQV6KjRJ9CVtrMNWEYTypZ
         aRdJVerK/L/KBsJRVSgMPCFEOPZw7li1CHWEXtFLq/20SFFvdGCQkbAGJfalry2l34DC
         rQYpFnMpxroTzdAHgjP27ufiInji2oerWSuHhw4qzO1+tfFa9nVbuqGnmFlJ7V0N5BdP
         xCM9gF31h5sLieQUZTQEx7B4gZAcUfMqHygeNu8QzGgnO4hmIQqzZdXoa8yoa4VD18hJ
         nllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716287; x=1794321087;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w+6rqmat8dLUzlB6PAGhcslRU/QsBUAoeXuoPxKZzAA=;
        b=zwS5XdS83rlojrZXxuUlc+elbRQmxlPP7tm29jDSK4PRbRw9j7ohkKUrYdYsRM85ST
         8shlDUEWEKAMKpH4kSTxPrrGjaIcI+twH1ZcmpAlroEgQEkjDbJaWp48iLcUDzjnLmgc
         x4/Ik0pClB4n0C3m+gIQm614K0Dwg+RHTTy2EDlDp33ClomEmihDf5xBeDWO9HjW2/nP
         BvqcdXXhI+NvEKDkB0hAY77LtF9a4/d07l8PGh5MrO1jtxiFQNhr9cBpHiPdT8Nr291Y
         kmqVa5vcsLx1d5pClTkckpFWMqmDHWklbTbkNig8/d+d9dgqy4mb4iXIfzRduZ/v6F2U
         EpmQ==
X-Gm-Message-State: APuU4Z8ZYAEVzMqJ17qRBrntwLRPrZUkbnNzG4EPIiUNApgTiCcmJcye
	Fps7ZGX+ukyXYN2L+6hOALa2STBEMR1UAwldQis8jtnGe+8xxRJA/V13nWcV/lSC5+uFj3YXLFp
	TIAim+QU=
X-Gm-Gg: AYBFou0vKGUKIyR/OtRMR/DxNjs3Gqg6n5jN3K6ia4aWeUYash/FAPpcadj9IwxbAz5
	N1I8PdqtkE22CfP+kL6GXqAu1qbi6rbs3VklleViMWSFTLWpSfc8yCcTtqEp9g5A21PNmSn43WA
	NG3117pkjm17oI5Iw6BG7AAo3zse+3hF7AznLBU9+zTr/f4PmcQmm8FzJtGVVjqGHvoWODYtV0J
	O/hfw1URBqZ5ZBfQ0TjB6846UBhU9y9umsXMYFfTPeW8MMHSZq1Of1BPdrnT+E+/7RjDrqxpTV4
	NyNKEuIm9On99hVhZDu3CAhWfTLphDg7WPyOfyPjk0kDqgOrjGM686eCVaAWyy3pvcbUpqGKy5+
	pyta1YyfyM0PtWUN8/6wIUM9M4lsARp3U1uM794m/wDnKMuIOoOz81PqJhAE853CneS2QWtiArM
	rLU5oQuUDZa74ixts0hEwaYfLOGarlW/XNcNio/Zz7HlQArpvjGn9mdjPtK7PTcaXj53ze04Eam
	oftGED8crtFNS4scv4853hsHnTZNFYbVO85j6JX6aXFOsvY55nNvHsYGXyK5KPHEykmV19Z3ANK
	ihwr4bcKFaLckDWj5L4vH2ubg9AtjpjTEXcFu3hNrPGvMBQIWevbtrpJjAInl6kZAfK6WNIPeF6
	mJSOU6cT6sPqW
X-Received: by 2002:a05:701b:420e:10b0:14c:1f57:3e86 with SMTP id a92af1059eb24-1ac5e6f5fbemr20269426c88.47.1793716286823;
        Tue, 03 Nov 2026 06:31:26 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b23b847348sm9534779c88.4.2026.11.03.06.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:31:26 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: dlemoal@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20261102055558.3212814-1-hch@lst.de>
References: <20261102055558.3212814-1-hch@lst.de>
Subject: Re: [PATCH] zloop: fix block size query
Message-Id: <179371628604.3691261.8426896731163496682.b4-ty@b4>
Date: Tue, 03 Nov 2026 07:31:26 -0700
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


On Mon, 02 Nov 2026 06:55:58 +0100, Christoph Hellwig wrote:
> The block size obviously needs to be queried when it is not set, not when
> it already is set.

Applied, thanks!

[1/1] zloop: fix block size query
      commit: 8fbee85a90789d367c347b1cfd5a5ef37f3a934a

Best regards,
-- 
Jens Axboe



