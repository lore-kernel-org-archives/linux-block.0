Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF43353A6E
	for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784900078; cv=pass; b=KZIgpcB78QItciucwmCAhk15UqcrppkjX6roLKQMqUMexGH5m4k4jDNprClHKuh+1f/ECPXNgdVpr/PmKsv9jDJNAebJfICCV13fALv1Th6KwzXzvLoXWMsJ/gQm8f1r2deJ6TBt1wkIGTc360QYNgahKpyYcsvUQVFvWAK2OoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784900078; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rosc3uxKF06nN+R/8outsXL4C6Ux4KYk/f0s2r4L0UGXMs2U5n7xv13ooTQD8bJ3gK4J/OUGsfivtwFCBqtQx15JpIuI2ViU8k5HbRzKgep0m8erIWktCq6pch7Plk2DR7rr0jF7qvu/nMVIgtmG1rwhh+tVxNg365wx02w/cSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpUbj/gx; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpUbj/gx"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15dd4b9132so66250166b.1
        for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 06:34:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784900075; cv=none;
        d=google.com; s=arc-20260327;
        b=XHIaYl46q8t7sftUYC6DCtfgRPzYsJeTmygCOOsHb74Y3V2NViZma/E70mRQoL83rj
         9rDeBBBrmUxlZCPOs28MwrFGBUyH6uxA/3I3FhrP2GDFiw7fPn2fmLFv18Ko4O3i8HYP
         jInMR74ISeIc+e+hcVCnVhC6N7+spxSmDT0gYawn0/j1eIHOUdIRbOPin9HJKuIxSlJ6
         yjB1WkVpJnfSXEF4a/hw1KD/fuEyiq+4OflVothS6/tfaroU9H2BZBjVRAFMaejbYTmw
         8lASYEiIXcgtWOwXsuQOGc0UhVuiTHXQRmB3gopqSY+5p9c24jIhEpUIWkrz5UdPA5Hu
         vuPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=5UUzxGfj34aXxrLIrmJqQu9wwlvzH0kf1NqVmKB76Ow=;
        b=Wun6iDFb5CIyg2xSfZyY4dR9cjiPcjCA6+71YuOzPXeDJTTvOb1UrdvIMeC5x98Ydr
         p0bCqkCiLvubQ7Iwp1tZtZ8wAkQ53tiWV+SoGZ9MPDd7EmjxYfjVq3XDO/r0Kn8l5abc
         Ca1y9x9ryVa9sm9EJkVGLMuEjAIQb9wMQsXQDQlt00Hu9frr8ndjjtxomBy1DFQaVhVy
         hsCKAcfHjaB4AObey4k3vBQSajvTX3UfWKuP71bJd8O2zWcEDExK5tmLCDzX95jBcgSj
         lLstkN8YIurEXbf/7EUQFwMYg3J9PLZFIzNi885fZz5KnSJ5DXPkOb3WEXwz/aNd6KS5
         Ybdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784900075; x=1785504875; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=VpUbj/gxPfu2RJKKVmjsZsjVpFXa4JvxOTc/1TcRNMnnNVefaCvfqx2/odkO9g0NTh
         CnsiBs4DgQ48FWOpJDSSiPo0E6xIq/kxYpQsS4Dbv3aZurShT/W+A9qHMjEDVCTojNe5
         5zf79qnNQjhwS1zaVKbawSHze1NF4okyEJHHH4ArW6N3YMjavlI7eyMl+xOpiqmxLb2E
         NKJ06T7BITwLjVRs4DNk4bAi3fEzM1kirP5LYLY2pSojTlhlTzeIY2DM5oDjrSJ0zXy8
         zsPTuXchjV6bQkcVQAf1IJmIjWs6rbLpwnX15kRDf5kjA369ONxgdH7bmD2X4GrAZEig
         ECZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784900075; x=1785504875;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=tNkDdJdjifGk2tsbPXuU7xl6SOPDBP7FmAqPj0tkvkwIVzGzmrIZpePTFTS0KYS/xf
         IfQHa2LSWQ0h4wWoXH1vpfQL1b4UVBfRgkfQq3rmpvQzXXUST9gBCLrw+ZfZQc8VCj5h
         kk6C3WFPtk1Y/mK6uYfsmbBnjkXqbLP43MwTBhKmufw2Xq3MY0YcxW7OnkVESOMP0wbI
         KtRuG6Rne93VhW9UYvGL7GkuGkr4lxrqXl/fmwjNIBhFuCmJqLCZySvVqtnBa0Oh7RI5
         +PbrV2f0RoBkLb2/jBLtqtVp4a/AKnY94xovO9Oxk2zDmHfFUrn+gHZrwF5m+o9AL+Cv
         MA7w==
X-Forwarded-Encrypted: i=1; AHgh+RodrhCZDxAfnoWFSu7mZ44WVO56WdeJTWcGRQTfg9jeaxGU7M5RAaowYjBUKS2smhWdWuOEB9fKdp1sWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMWyipYc/aiyBofGXJ57ZYcXM+Kbduwj86uBTERUftA93AbXej
	+pv6qp3YBqa6O3h/FPTqWmmphN1ws8WOTHWw0i185VIp94sa26BmvN5QzJHxK9md3pyU21tsOTE
	Uem62hlKfoW2DZy52hTca9LVVJ3+jZQ==
X-Gm-Gg: AR+sD13lU7SBZAJJb0gCWM3j6dO21LOWdYVTs19oEqaRRVkwML0pFPzL7TiG3iw02E+
	MfFvfh6e4+DqsTkPQUMTXpwZRUEKMe8TodAGmoLIn1CI5rCwixb/vs+7L3baJrrlPe2/fMwnPzG
	PMTYt8kzt7qMYLyFMQMY/iOrMclD8bThgatzPeg1RZqaSjeBTZj1kOyPmQL5ZR7OMtEY9G/mL0k
	vPKpFKCdXl9sUWoiODHS3ip3XupIzxA20+l4PwNg/U455m0LOK9lJm+Qv/Fxi1SwygN/kGyJy6M
	xUlDZAosRqibRNonzydT205ahhO0unMsYtM=
X-Received: by 2002:a17:907:1c13:b0:c12:34ed:da14 with SMTP id
 a640c23a62f3a-c1c50b6671cmr294192966b.64.1784900075121; Fri, 24 Jul 2026
 06:34:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724051001.202741-1-hch@lst.de> <20260724051001.202741-5-hch@lst.de>
In-Reply-To: <20260724051001.202741-5-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Fri, 24 Jul 2026 19:03:56 +0530
X-Gm-Features: AUfX_mwWTg42HDw4aWDghBP51qdfXyDKkMoJixeJkgq6b4QcQa_tMbSOXy-DN0w
Message-ID: <CACzX3AvJUPUhxCPgqOW6zSF2exawYG_okkL3xAEd=s2g=EDd3A@mail.gmail.com>
Subject: Re: [PATCH 4/4] iomap: don't free integrity payload that doesn't exist
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
