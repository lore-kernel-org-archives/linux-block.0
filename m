Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792509460;
	b=itsF6bvzjylNmrcppPClcbwsrMlmrNvAWwscjUNGlTJZS3aziiKpdX7vkiYLxpIk3mDI
	 Wh8Vvt+gZfx614ndYloqx3fVGIT2+2M9k2q6uymoLvWjkgHNTH07XkeocQHx5gOSjwp1h
	 IkXp1og/mGvVmEkMMaKkoL+EQ31xL5QN1Zz8NWJ/gXvaC/JsUKAQBUthc6rAEJavp+9FO
	 1Yr36AzkJ4/qZSOC7pPdHFAtZgW+S+RFp7Fr2v6TTYPPltgO5HVf+hbCiNNf0g0Khk85w
	 PDBJQgCOCIrPkK9Q7if3Jn6/ppYskofnd2i2AjQ1XV4yZey7og9svMDQ6UjsLTjd3YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509460;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zTjUKTq2pDJiEG+CDmqesBFdpCYeamHw0/TGw/oMuDk=;
	b=rOS53ZHtsbqZyb7MnDRfmlYqlR2HbOMQ6ulUBMoeuxTVv9eiujFUXwqyYkwuHKtJYQ41
	 JBzoONmVA0TfwmNmMm3YYlL6sVkcx1zwwOtDs6HKkSpQmFkwemRIz5xtBfXgSABxNlxKA
	 ihY2gqzcAcJ8oYuLCxFerHwKFMWLPllPOlUyaRWqGyseMq1Qi1IsBkxkGnhbxnEzc+OuA
	 EiO2n4W2dP8gwf87bZFhW5DcQx6u6IQDjuPXruOUsgIpAalG6G16HrKBrMnX26s6Mr5Bg
	 6bZmOf2E/xCOff3qrF/1+Ro3P8HM6MKM3FuyjQe3Pi/AXK1bEJe/dwXLNO/KHYAUl1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QaBolOjg;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E27C606A31A
	for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 15:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E27C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QaBolOjg
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1e477fe16so17568085e9.1
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 08:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792509458; x=1793114258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zTjUKTq2pDJiEG+CDmqesBFdpCYeamHw0/TGw/oMuDk=;
        b=QaBolOjgCb0Nw5wFb7wUnII/ni7kJBHw8cIBlsbYPEEYPGKOGGB8JywIckULc+x5ns
         bOeAmRVLUXjFLtv9xCHVjz+QcHrVu3i9Wbw4KfQQ0ndLIbrIp8nakzFR5USNYueLmUO/
         JLm8jWKBJMCb6qqAvk7ErUidj5Oq9BWiy2wtUS8Ra4/83plusB+7UTcvq9MSFA4Q+YJu
         +Ocw1bbd7u3BdTm0zGEpqv8VG1P9IWiJPj6IJ07fBKRdVJulw7YRJuTD228ibo1Mfyhf
         +li4GEjJcsi/ae3fjZ3sjYaWMyBCkUKl63dzQVMCW6YDqjoDRzSiHCP+s+6vUcxD+N3v
         A+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792509458; x=1793114258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zTjUKTq2pDJiEG+CDmqesBFdpCYeamHw0/TGw/oMuDk=;
        b=G4k+nmGQ0xGph5kW6Ez3U7UlaQ5hNgm70VHkyyAh9+/+owtg9ONm+1rwInXabW7U9X
         +alaOGKWbbsI9/VobHjuWnqSAB5e/yL4Kl4hyHrs31qb25saiIjBsFgi/4AV0nzyuqLT
         SNI/pxNKaWcI+J/zmmk7Z1CncEy1RgkJVxQvvDK27unJobH8EdIJQK6oxCIjZXAoJXUx
         ONsw49Dybq19cyl64FQMj26/XQmImOjpMZa7iTiigSb3glgB3piTEbe6gMnUHCcIsSxC
         32gW981F35MwhwHCRuvllkSD7UoJp34Tg1CYqK/LfOH/4m46Npk4ESLcukZ4QyQTCXzm
         1bbg==
X-Forwarded-Encrypted: i=1; AKwUvBy8K8WFPjPDstWA4JxzLz17qXXBbNScdpBvWPIyZTXTPH48b0OpPgg8TWUbSzQ5Pha1M5N+rqs1ZZySaQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJvTsUZVrWp9YNc+y1uyMRbAD5vflZ/TJwDy7GKKp+5jG+eRGXi
	0BDosRmoNz0wdTWKbinxlq1FF7Br6QnOhX+5y6lrY+Xh0c7WbPHeTefc
X-Gm-Gg: AYBFou2t+c5XncQeR1rEbwZljQ1WIB09u/fLqlMTfTnrRCC/ptETBWI0x/5bYtPFal1
	Y8Bw2plL4GgbKLVUkHqLm0JyKwkuhGr/j2skumtLMuruTxIp1KY9zLbGCmQKYTBNz2rprsLwdvH
	2ii9Xg28hbUU3X2yi1J2a8KpFmOlsIP61Iz27UiMl85R8Emn4tY1DUAn2yZQDPI/vEWIBeHyGhh
	2y8junUz8xPZbUJkrh9GWuacpoppivW3jV41yP3pA3lVRv+mVXVEfBoW3xi+VFK4Zg8BXzeGDXI
	v57n2p8E57Qya9eAH4uyzillAotTtRBMpyvLq7JOCYxo8U6xgmZxBYY732DryykEQZV2g2ftTbx
	MJwXf3yEQkDNwiLUYDhrrR4NO3/2aGzOf1e0VTUDC8gepotv1QCKZ/3+Lj0tif4hHs//mrNNPSl
	DPotykUF8Ctqqj2c9Vc/1b7Vyyg3Jd61mTn9z6aWlfElz8LqvOs7YN/cAObP4+OoTs2HMQlUHNu
	vuoS1kphsIGTAQelW7FI3U0S4vU8SOFn9XtWkiVK9I=
X-Received: by 2002:a05:600c:870b:b0:4a1:d487:2dc8 with SMTP id 5b1f17b1804b1-4a1d760518amr238522665e9.18.1792509458121;
        Tue, 20 Oct 2026 08:17:38 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.51.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fb83ff0dsm3555715e9.7.2026.10.20.08.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:17:37 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests 2/4] nvme/071: test that nvmet sends no data for a failed read
Date: Tue, 20 Oct 2026 17:17:31 +0200
Message-ID: <20261020151732.90412-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <atdDDxISK3i_5uQX@shinmob>
References: <20261014170046.2516-1-parri.andrea@gmail.com> <20261014170046.2516-3-parri.andrea@gmail.com> <atdDDxISK3i_5uQX@shinmob>
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

On Tue, Oct 20, 2026 at 07:35:53PM +0900, Shin'ichiro Kawasaki wrote:
> > +# Issue an Identify with CNS $2 to controller $1 and print the NVMe status
> > +# and the number of changed bytes in the 4096-byte data buffer.
> > +_identify() {
>
> In most cases, the function names that start with underscore are used for
> helper functions in common scripts. This function is used only in this script
> file, I suggest a function name that does not start with underscore. How about
> issue_identify() ?

Sure, issue_identify() it is.

> Do we really need this dd part below? As far as I understand, the core part of
> this test case is Identify command part above.

No, we don't.  It was meant as a control that the fc fix still sends
data for successful reads, but the successful Identify above already
checks that: it must overwrite the whole 4096-byte buffer.  I'll drop
the read, and with it the file backing, which was there only because
the read failed over the loop transport with the default backing.

Thanks,
Andrea
