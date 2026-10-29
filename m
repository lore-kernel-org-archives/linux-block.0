Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793273670;
	b=ULl4MkwJ+YHs1PWgJXXRTqra8J8Rz3+QmQtNSdWMtBLRDOnfpqIpXS9XxhYII04iPJxk
	 pf1IYxUDoyJk8Drc7V5wJLij8kibk6P22Nragu8Do7MdXb1QxZ0OzMt5m9wf6BfTPcMlB
	 TAJOXmukYJe0BL8Up3T6gMqfKdIMoMSDBs8lQUoppVhJNLVjFzViDlAhjRGHBFOynnuk8
	 uEKEJjSiR2HnqeS8uuUCJAcDUmIarFAQG3D+0NEMBVclaMN68QY3caeogMQ2IHuFyEtLo
	 6or/UxMDCNj8kBctpJCd0GeVzvpr8kE+UTCpt7meMK8Y2koLbg/A5MLUlLFLYfZbmdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793273670;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Fxs2p2vZjp5Ja+55tP7VAzUi3885HhPUvSbaP3WtHOs=;
	b=GAjcr/9k/XDB8vBx4d+3SEidkFqxbs+v0D+Y3GPbud+OFxhFjqQahQ6lOE2c4SDvz9OA
	 ZuNUtxcpX5TR/jNqC8z7dSM/NToQvpc2H4vRqdAzzbGyLArW5HjAtPoCUIcDxG2Pxrbpe
	 Gt71HeSyYKtE+z2YuJ60rl2Xeu0mknsducZ+YiVNbNJqT8vqvOVNFknYZ1Tsb6tUuYMu4
	 Fw5Z4DQ8IoqRSAk0SFjb9ic/ch1sKb5CFBo9UZxKkpZj2YzKNrXEGL3XfNUcR5B6e2Ggt
	 Q5CpZ/ivtX5d5REyGHQeT/TXoykK3J2TbrSZeDqwLhqGxf3pqAQUPkjGyRahRtvu4Jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bq1l9Kk2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F4F606A31D
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 11:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3F4F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bq1l9Kk2
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b4bd3d98bfso469054a12.1
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 04:34:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793273668; cv=none;
        d=google.com; s=arc-20260327;
        b=Ny1bSA5Jws3msGUnZZuHpgqAkVssFiWnjIxaoDwM6YpXCQBeXmd7piBQMkQ9ziS9il
         LwLm9QBYh9KwLNfegRm99NMo+de9Nm4MZ7fCg+Sq3VX9ms1bzLWMfq95nfeNxK5YfsGr
         UJXYz2JP1IDD/PJqggOZmlVhZRva2IPXubyS8nWQLft2Jnv90xqwRZ3HpiO3xy5GVp5+
         cKsU+4cTbLd+xyUMaMdTJJYpVV15pVwBQclyt2sRm2aHLwF1JkQCl/kD6hsVdCN6RxXM
         ygR4dfyN0F1e7xsGuUgVwHBl8lVNQQG5bzNWhgAmNetCUFznkw9t8a0ZMsT4f9rZA9cZ
         n/bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Fxs2p2vZjp5Ja+55tP7VAzUi3885HhPUvSbaP3WtHOs=;
        fh=gJkfi3l92NLe9efoEh3hxbkjKhCUUR1OzQxvVQgHTuo=;
        b=Gbyy4J6qJVjs5twjM/pN5newV1rWxoVv+/Ggw4GLgLyziXlnOxIdkXq99Zr6/Rn+0C
         ZqcHPultgoq1wWvBXlRFZ14guPwR+NFVKsLv9qqwD7XSjpJaQBl1fPlEWo67ZrsT/DZ5
         jKk1hwC0VtgIASToo2OswAgknKvwQSQT1FenYeBsDdxId5r/WaOJ89e0QhxazrxVcOuO
         0OFdYjwss6lzSlWVuoOSY50nxazZHhN80d+/iYoAYlRvWR0RIM0+xW6XvmveO7RWN4j2
         bFxy74/0CQGk/iAERGxT+/mN1pTBPOaOYQRUbHbYGVB2JzpwMvxGK8Z0ubZnkY4mCE7I
         17lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793273668; x=1793878468; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fxs2p2vZjp5Ja+55tP7VAzUi3885HhPUvSbaP3WtHOs=;
        b=Bq1l9Kk2klWw/DsfkHAK7wvtuf8i5DHvjE2Tdz0Pe7ATvS1JG/hCA8ilHYdAPSfWAr
         5yLtVeUXNgGFhjweQA5S8tZ5/vpSFmb+fdjcp077kbitGh/5lcgE3mvyu5QWpl4eP9Qg
         xfwA5fJeDwpLzXcY3qdyiYb/sRdPeUWiTkw0O1g9QZRU8hxSU/nS9Z+vzGY4eP7lf+GW
         CGOBBDbvFHoRrZ1orA3A74hz604qMy+6PhVlML99l9fiOIXfmf2euwDE39OUHMAAu/gk
         vuq+tUuT53zWBzmHhvuljEiPJRHQ0oUM93ciamz5y0+jOSEqVU4EB3s2RH1ZxdFDEgfv
         BOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793273668; x=1793878468;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Fxs2p2vZjp5Ja+55tP7VAzUi3885HhPUvSbaP3WtHOs=;
        b=b0NaUIwX1xZRm12UnR8minjMPfDoUBvfa1sf9L2Yka3DIsgZIXr2v/Bc4DFt/xJNoC
         5Rhi3SqXDUHGfhqTkCvYtLGhNYHeoMEAZG/1elKhrhYgXoI00hCyN5OB7TrI5oFb2e4l
         y2GoDi5Kp0oobXFMaR6ocnWunJ4T9el2UgYclX9xdUurZheRlDYJddI7TjcUsIw741vJ
         +OhTqLgG/22pzqp9bMWwWi0ax9bP2bPtqlhScHpsLWi1eX6Md7u6j+IREl92Mgta/lIY
         oizi+UPBnpczRNYJusbC8bZhX5mzwkSOqn/qDmv9iiUmux+y04UArJKYWnJbsGE+hvsm
         Aphw==
X-Forwarded-Encrypted: i=1; AKwUvBxC9uXwhsFWD9R45BsEWxfBXulXKpwfmj5VoaiITf0+wNL4+OExPJPUqHonWqzVNjAndrpvvznvAORdBQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKjLl+WjyP8vZlOFOwQtOqzT81eJDSVAE6EbEbY7uhuTzbcmaUn
	JE0qYJiXwGZT+uAhwg/GBMa0Jgyn8ZH+HwXlxqXyEE6SEoOkkXWVBtBSK4HyACfDzIiPQEKgBKo
	sLSXD8IHfApmdnu+EuaMc+E6PKIso/A==
X-Gm-Gg: AYBFou1PHz3ROuvyBFhwWxct1SdkCgZdIvvynC3CnmLFHclWAhAf0Tvsw58Ft//gv5Z
	DiG/AnOXhdiKakcOD7u3OOSz5ztWRkcj2IKGT+om5uI17N5w+/4RtJjnE7UujETDNgjlTOmoZ3X
	JmPj8Y3eyEh6omrmh+yMSx72T30Wc/e9h2lwnjnwIFr7S+u9PZ/SxFTxACkpibBobWO4jgbW9LR
	nKjOSJBr2FmIdQ7We28SoXCM79RyFe5oLbo2ymSr0NEykDkCDQJiQgf5nrMYxSjO2EcHzXWaubJ
	WqoTtLvIwWKmoJSqUPpKm6f+b29JXxyqY8oo/Z/xERGSM8uLTbYu3Xf2hMjAvLB8I9z/BetLY4y
	UbKw7ltJt4795Pdzfa2Un2vzjs+PCbxRVj648Lp3WccUI9KDcN7yuYZFYEN+Hx8Sd1aZc4/RoLt
	HLQUYIL/RxC8jQ+RTwPKveUJSxJn+kHxIzs/OszyMVacR8
X-Received: by 2002:aa7:d386:0:b0:6b1:bcb9:15a with SMTP id
 4fb4d7f45d1cf-6b49cbe4f13mr2485749a12.20.1793273668033; Thu, 29 Oct 2026
 04:34:28 -0700 (PDT)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028181412.1919506-1-kbader@redhat.com>
In-Reply-To: <20261028181412.1919506-1-kbader@redhat.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Thu, 29 Oct 2026 17:03:48 +0530
X-Gm-Features: AclHuK80QgKYucRyIWXZZ12A-Bk4L1d3Sa54QPpy49ElFlJWi5EmglCzjpxKLqk
Message-ID: <CACzX3At39QvtmM=sGh13+uCaU9RWhKW8e8r1hPLMJ3LdFAsetg@mail.gmail.com>
Subject: Re: [PATCH] block: only fail dma-buf bios that need block layer PI
To: Kyle Bader <kbader@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, Kyle Bader <kbader@ibm.com>, 
	Anuj Gupta <anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Tushar Gohad <tushar.gohad@intel.com>, 
	linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Looks ok to me
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
