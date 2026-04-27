Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35434CB5B
	for <linux-block@vger.kernel.org>; Mon, 27 Apr 2026 21:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326737; cv=none; b=lb0gzIQitI1Z7swkPbNqA7NMgOIkC76gHRKuzYjMlMlAHbQt7kMmA6qAGJ+Bl1jREGdlMpuKipc0FEX6IO5VaJf1OJVHd2yBxSX1ojkXtjNDsXfipZQqX48+F5De3X318EJM0yEfSYKNC9dg1yIEuX6b5O4+MLoo40JiD2HHozM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326737; c=relaxed/simple;
	bh=4n/8iMUmkbjpeSpuiBFrlvNsvn+gn5MZeICFE3ijM1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZliMk2Za8ZvJOY/bYEM920nWmG025Gut7Q0EsRhP9Ii7YJ5UJ0CJss4jvhIMqnHE8WudNCNGBohmznhMuzmBGik5kN9AAl+Uh0cWl1J9jXJIvEa4IBGwktf08O2dmJc0+RWBNm8CvSW7JwY5J1EVB7AdhFCYIVfudjSZnTTz+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=jMfdtta/; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="jMfdtta/"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-479932ccbc8so5958723b6e.3
        for <linux-block@vger.kernel.org>; Mon, 27 Apr 2026 14:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777326734; x=1777931534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NyQFkQ1kJsVJkL1kaz+R9KQLiQC7eWiN1b2LJ11IkEA=;
        b=jMfdtta/sAwkUrXjsTt++ppZmMpciZC//BQrWOJJ/7uQD0iSIHCv+bZ/OiDJdFb+Ne
         8Fvnk812KBmtPVHqzmH0zHqJwlL9msz9VlCb3qShnyza95rFhbMDelV4gkfHZ2+Mb1IR
         L1bqVzeXqYgde6Q826qG4NtjXY1gQ90ZPrhdi4EdzIXNtnQ0htyPaJGIRMU9Cy0208j8
         DyMYPelA5AS5CLQXRy/coaUBOr0P8J//1nW6lmfCHX1KDZoFlH+COVhEdAlVVEyHRGdM
         dVUR2snPK+sTt4kdS//trYOujPDZWqic/AtOKE/jsE0dYTfAFhhMzbXWExVvZWLqfLH+
         uaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777326734; x=1777931534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NyQFkQ1kJsVJkL1kaz+R9KQLiQC7eWiN1b2LJ11IkEA=;
        b=ogiuuOVjXx9A5qubZRvb/Q6ShJBztlRKMxXA/lZYRmtJk6aKgk2rnnY6B0RNQpiYyN
         rz+7Al/uO5fN2gSOhpg7QCkzFaqF7SE/XMLlOEgcW9ECMaeXdJ3mUj7+7iGyBIrF7p9o
         D+9yzsJ0Xcthq39I0lrBjSul3UY9WFISERt606L7AUIe+45UXv7XhFMZXW8oIIa6KjwX
         c6Ur3BqEWPawIEPsHeKI8/q9QjtE2+UtI+J8sW92oMzimM0BZiyRbmOMXw0px5jQlo6U
         cP7mRUd6AGKGo+7tiDqLFKmZeIPVowXm1igd1XiNZ0pGpC3bdVwy5DiJsJ1QpXU29pJm
         A3cA==
X-Gm-Message-State: AOJu0Yx/wwtTWdY4noQPg1sCbIgEYPqG34wBUv3z0UsDFUHhCQ86/gHu
	MnkMiIc6KwGeghrEl2/6ceSan7jXemSt0BCI9y5rarjeRui05rVcyLr5TZvWztcxoIS0o4426tR
	rGOqTUjE=
X-Gm-Gg: AeBDietW3RQJ1imyV3rxdDsgTrjf39pzSZcr2k6xxlLqpDZPCwRaH8+qpqKTqT8SSpe
	zQKMNRnn6loONLTArcJni8cQT1FVZ9KszFTLBT/mn5Wx4WdyIqH9V7k8T0xreN3JIGLrLrNFB2Q
	pUzTlLsRRzkGBeaATpFbFTlY/qAuCJbl1yv0QQd+EzU7JADDP2DQ5SgdgSoL73Le3EpgRX51ACB
	a66VN/lqSZUQJEvVqJ24cA0Z4MMzznwdTG4MEYQJV9mEi51BuhOLDV/dUuN6iUqL/zHQNOcuTY7
	vQh7WC8tOd2Sddxf/pNhnxD7BUsgGzaP0cy1zP6obBkxLCexzQtY66jgWagCxdA4tEsvDJImc2J
	lGrFbVPK8hI9d6Q0aAQ928iY1s6+dvq5qG/fCaey9Lpr4H4i2ewJWDcBCY6Z19gkshCc706rl+3
	3mosOdKzoRx2gYn2HfuoaW4qrcsbORfmPQx7Kk1MpcdgaLHIGsTfIG4ZPYaAd6lBuRi/1+hxjqW
	B0+7n/kEAndfDBg67Os
X-Received: by 2002:a05:6808:4fec:b0:46a:72dc:28cc with SMTP id 5614622812f47-47c28dbea3bmr335593b6e.1.1777326733779;
        Mon, 27 Apr 2026 14:52:13 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c28f8e53fsm244276b6e.8.2026.04.27.14.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:52:13 -0700 (PDT)
Message-ID: <8816ec1a-a4cb-4c68-a99a-79e9d59cc288@kernel.dk>
Date: Mon, 27 Apr 2026 15:52:12 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cdrom, scsi: sr: propagate read-only status to block
 layer via set_disk_ro()
To: Phillip Potter <phil@philpotter.co.uk>
Cc: linux-block@vger.kernel.org, daan@amutable.com
References: <20260427210139.1400-1-phil@philpotter.co.uk>
 <20260427210139.1400-2-phil@philpotter.co.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260427210139.1400-2-phil@philpotter.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/27/26 3:01 PM, Phillip Potter wrote:
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Daan De Meyer <daan@amutable.com>
> Link: https://lore.kernel.org/all/20260422113206.246267-1-daan@amutable.com
> Reviewed-by: Phillip Potter <phil@philpotter.co.uk>
> Link: https://lore.kernel.org/all/ae59luYMh6npxD09@equinox
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Link: https://lore.kernel.org/all/yq1jytti447.fsf@ca-mkp.ca.oracle.com
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>

A few notes:

- Please don't include a ton of Link tags in the commit message. Don't
  add anything unless it's a link to a bug report, and your patch fixes
  that bug.

- Signed-off-by implies Reviewed-by, you don't need both of those.

-- 
Jens Axboe
