Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8EA9470
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719924375; cv=none; b=TmaGTMA6lKfUPxpn7dAH0T9r3xW49G6tx4RzvMF6zcfIsZqYjKO3kCxNYTqR/p206iBYJFH8AVv63nAHIrR+f08C97mwQzIHuMkP2+dhCWQQ20//aJqoIdmUALa5/OWv2p6dLO0ULO1d8nfZ+KKZemUkRrh3UfHuFAfSB/I3wKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719924375; c=relaxed/simple;
	bh=dbhYkUaHenpMsa174BTyilW4Y8SWzhjbaGUDlez0G10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KoKk1HvZyiJeaVXT1Q8avnmSjfm8M3RyqyhyH71mHcMKaXZYZ4cDnT1DTm/zy5UCi9BY8ortuhzUzoYqn0h3LGoY3upibxKDS+EoFkVSuS8KzTDkbwuJoLd/4ZT41it/Q9rhQFpTPoNMgW1S6BparEGR486R59ZOicHP2VJ9DyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hr37M57m; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hr37M57m"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4ef5a2f4e6cso1456297e0c.2
        for <linux-block@vger.kernel.org>; Tue, 02 Jul 2024 05:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719924373; x=1720529173; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dbhYkUaHenpMsa174BTyilW4Y8SWzhjbaGUDlez0G10=;
        b=hr37M57mcp6PO8x8TVO7z5Pp08QeWb2hflYwZ37p1DuzJh1f4ItZlUzLrbEFRp1ceo
         rh/pQUpjOx2XSA1n06FE82CL0RNI+p/G7QgK3C9LaMQga3Qq/eCpjWNPJZ4yeQ3y/y7w
         BU1fLmXC10h6n3OYC90y/SfI/ibAn52R3yGLl5CyY0BlPhYraJ8EFfJMfXfbDKbO2BKG
         XTl7gKUBrugGLxHoZsnI/GcxTwgFJ9ZVePwFryPHsFxWl+uhIE5OI56Lm50kx6bFAjEr
         GbgnnY9+AvACrXZmA80RkHj+c9wSJtIA7r/hMqmoTLnFAMTu/SZoHoTX2p35ITEoKeT0
         E62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719924373; x=1720529173;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbhYkUaHenpMsa174BTyilW4Y8SWzhjbaGUDlez0G10=;
        b=oS5q35fAxHP23EP78PIpmhwWyKJNLT/HTFXqw90TbdEOPyrWX5HjgiJu3JPkdqbtUt
         1FCb2CIzP9ILEWFsgvzY4Fhxarxjfb9/54jtrVeN/Yledn90mIbpnW7II7+3oHTU21zg
         dZTVEMfisdRa7WJW/0E5+PFQb2O3hwrq2zh9jbQubEu4dbTYljSa1qoi58V1KiyCv4rh
         8CoEYBzRHwxWAVDfA+YBdXe8MAkdh5UktbCJjToleXrchvfWCenQ7vt3ULS188ixgPSH
         BvDKNkZZCs8d1zZQ26qINR5OtDFYPJrYmIjJ8Zlhahf0XjDXorq/ZkO+3OwOj8wluEn7
         Gv5w==
X-Forwarded-Encrypted: i=1; AJvYcCWe1Kp8oXjCzf3bw2OqMTWExFHRwkGikHdQ11jd9y+Ots8Lch+CYx3/LYWdIMQNWRDDrOXPwSzLOT/8byybnY1vOaQD01DeUAx6NpE=
X-Gm-Message-State: AOJu0Yz0ClTs63x8r5uUTwMjRTDcCq3SIMqBgQPsrqGvcrpw6wW7Ryjy
	MA8qnNvb1QkUoBvmw7xPM2GIL33Hflva92TAWVLZypxrFnaw4KbcDyny55tGl33bmsPoQ5C4dwF
	eqw3AmGxo/JmlJRdj/51dJH5LR7EZYwiyYQ==
X-Google-Smtp-Source: AGHT+IGtuilS8OrtSTHaTVFS7PG8gi3OC5c/N7vOek9S/mBqWtgDv/oGql1N/DndQ44qYN/bJ69ULvwbVRPEsTlyaT0=
X-Received: by 2002:a05:6122:3b8d:b0:4ef:5b2c:df25 with SMTP id
 71dfb90a1353d-4f2a5680940mr9872470e0c.6.1719924372702; Tue, 02 Jul 2024
 05:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701050918.1244264-1-hch@lst.de> <20240701050918.1244264-4-hch@lst.de>
In-Reply-To: <20240701050918.1244264-4-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 2 Jul 2024 18:15:35 +0530
Message-ID: <CACzX3Av74rMmNDaOJZ+oxM=hTG4VD8f6mExcMscJjmo781Abtw@mail.gmail.com>
Subject: Re: [PATCH 3/5] block: call bio_integrity_unmap_free_user from blk_rq_unmap_user
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	Anuj Gupta <anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Apart from the typo that Kanchan mentioned, Looks good to me.
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
--
Anuj Gupta
