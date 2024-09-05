Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A591494B0
	for <linux-block@vger.kernel.org>; Thu,  5 Sep 2024 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725560320; cv=none; b=dH0BgUkhVuuDSP7DzSEAkjhmrXFVSN1ifK1xxrRM+s3icx0FxnZd0NKUSZhWlgF2N4mScxzeKY01A+tTCMNJttIh+P8/3p36Efir7WqEJN+eR039QEBIEpJkYmFoyiOqgwyIuKeTLuA35d0xWzuYi+O9pWEREkQtJwl5HwJFLuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725560320; c=relaxed/simple;
	bh=BnujZW8k15XcPpguIkLQEgFDBvJgBiU1+JzWaa605Bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oqVbksJ1q4zaEBgvo/OnPRSB/pA9zFpHwYI1cWPxV5UPzAqdHCB2wD4dJfWBhaVZh6DqraS9ovraOOPT+iulTkAiykUnXHi7FXtc8Nadl2950l4dECO1x8eh7LVT61d6ptVE8SMtYUKEXurO/N3PrT5jqkXl9HvE4blVYnyptv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ZhoCBwJj; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ZhoCBwJj"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4X07066kfBzlgMVL;
	Thu,  5 Sep 2024 18:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1725560309; x=1728152310; bh=ev9n/8RXsY0qxNf1WOJvQnyJ
	BoIo9GcpS6OIPYipa2k=; b=ZhoCBwJjhamMw7mHSRrTry8okJ0xlAC5oTipOgzh
	LAThIJp1vsM4nZXe6MzrPFam8DIpA9aVpfL6sHe8kvDFbsXJY4H1SQFmpZkjTauK
	0GML61+zWqZNNlYSVA4NFgqZusDRgagPJ4kbNQ1clJpP3ut2YvsLRdFRXDyPK+f2
	NIz5h0cO5qx48zuExQ5G/7B0CiTU5WVypHSfd++3daUXxT5R3a6uuCH+fNb0qw0F
	L8YLprpk9xyFjGJl7jNTzEA7SSvd8RGJLcinRG+ERRQnw+6EO+MxRLBwB1JmYEXb
	GMr167NoDhKZ77SvJZQ1TDn7SaBjm+SSK9B33VCScwUUoA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id NtI0ifngq3dz; Thu,  5 Sep 2024 18:18:29 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4X07046b1vzlgVnF;
	Thu,  5 Sep 2024 18:18:28 +0000 (UTC)
Message-ID: <6ea50dbd-06e3-4edf-9bd5-b12b904f94ba@acm.org>
Date: Thu, 5 Sep 2024 11:18:27 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: move the BFQ io scheduler to orphan state
To: Linus Walleij <linus.walleij@linaro.org>, Jens Axboe <axboe@kernel.dk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Paolo Valente <paolo.valente@unimore.it>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <6fe53222-876c-4deb-b4e1-453eb689a9f3@kernel.dk>
 <CAPDyKFoo1m5VXd529cGbAHY24w8hXpA6C9zYh-WU2m2RYXjyYw@mail.gmail.com>
 <d8d1758d-b653-41e3-9d98-d3e6619a85e9@kernel.dk>
 <CAPDyKFp4aPXF6xuuQf6EhGgndv_=91wsT33DgCDZzG6tyqG9ow@mail.gmail.com>
 <dea642a2-85f8-445b-ab84-a07d41acf2e2@kernel.dk>
 <CACRpkdZnc_6T6tQtCDZvWh_QMFqm6OJm+7Dk5A5W8UC5hV95rA@mail.gmail.com>
 <805c9f7b-49fb-444e-a81d-5b9d457bf262@kernel.dk>
 <CACRpkdYr=baNp9n2GDtyw9zH5yzi5psbBWHu9jCitby2rS-fhw@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CACRpkdYr=baNp9n2GDtyw9zH5yzi5psbBWHu9jCitby2rS-fhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/24 11:05 AM, Linus Walleij wrote:
> For Androids and chromebooks it keeps the device interactive
> during heavy disk (eMMC) activity, such as when Android
> updates a pile of apps (.apk files).
  Is that issue perhaps specific to eMMC devices? I have never seen
an Android device with UFS storage becoming unresponsive during app
updates. Additionally, now that the mq-deadline I/O scheduler supports
I/O priorities, it is easy to give foreground I/O a higher priority in
Android than background I/O. All that is needed is to add something like
the following in an .rc file that is executed during boot:

write /dev/blkio/blkio.prio.class promote-to-rt

Bart.
