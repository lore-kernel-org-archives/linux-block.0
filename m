Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D882F18660E
	for <linux-block@vger.kernel.org>; Wed,  4 Sep 2024 11:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725449038; cv=none; b=ingWcjF6EWe6uRXyIfr37APng44ty2MPMgBf2ZpxJ+dulltAXKRzjPDWGbndRZ/NrDSnLdAnq8UAgk+SEKCBIfR6tNhCbK06qzFsgB+dCsjdSTzVO6miba/ADHPumSjaxWf0dTrZBixRa+CkTNx3o0rmDRl/qMuDbNMfcgLBJZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725449038; c=relaxed/simple;
	bh=OVjpEg0vvOiohK1e4x/AtP0hb9SZEpZIKsoyCVyGPhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHgDgrK/NR7A5ucikII5hf80hmmgf/1AuQLHFIhE57Gx/1It90lr+R859F92ZBQ5w3vck7NlmgzjVZzeraypOYdXBPmrZi+W5Gd6OEe+vG7YavAz/RDVDdwYKmJcoZxPh7/yQ+w7a48FgdTlE16fWe1vHgYFBOTn89ja5OMHLrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5i8XSjK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5i8XSjK"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso5874965e9.0
        for <linux-block@vger.kernel.org>; Wed, 04 Sep 2024 04:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725449035; x=1726053835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OVjpEg0vvOiohK1e4x/AtP0hb9SZEpZIKsoyCVyGPhI=;
        b=Z5i8XSjK5Iq3LHHPvwULmKoz5c/97VMF3f4u7hdu4cqu+5vkaOPWUoFrCEDifOBroH
         v8H1NRRxHXj5nG1xsahOpKNNgC8O36raGrVUj0VkEzrTwjc5zYx6J5xo3ufvvtiffOw7
         +icX26rhcCIRdpf5HpFhyzPcGIxvb39pNRwD2iMThMYisFo3M82VuRiF/4VDy0ElK1ZB
         tx5EYgYX4bdhMahdwkKtprkB30fsr+Zjn8qdT3UcrvJSa8AKKfA+c2wkoYx3o2yGU53o
         IuluhDK6ohgbX18tfaRKhSHWKj2J65Mszb+0mbhelxaHn2qBl8zArp/Td9VEtJU/aNCh
         kc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725449035; x=1726053835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVjpEg0vvOiohK1e4x/AtP0hb9SZEpZIKsoyCVyGPhI=;
        b=s3kbtZidN4PWS2j08JsVCV19DP+uUZzmFXpbuoo2RbM1cf5McehMy7ct0wof9dAnHC
         fJn7uRmuw7lRlB53ikrNBXtHmtFTcN0yYb0MwFPouaozX6vjOXvnbvAwM8kesBwBSgU3
         MlLsvNtJDJzMYTO+E+fdBleR2yfQS6VdsrnTrlF7ad8cRpMIX9svy7hhDMeFqS7+bEoi
         6ue9YNQuJh63ydmhkj9K/X1bbbnmsmp3w2qr2+jmR5egskQ0ftPR3+RHT3W1vLl4/B2D
         gOFJnbLzzk2GW7XU6B5i7uXZoVMw/jpExrvGBWCyqxoyQ+95+1lSZp91uHA4MssE3rDh
         Fr+g==
X-Forwarded-Encrypted: i=1; AJvYcCXQasBoT6JcDYQeWixLmKZh9jlcQg70HYvrGkxFEgvCdeyoT5uuXZE8sdIcC0ktr+1EYbBnC+HniOJEMw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+IuZoMuegwNunVRIhpsDMuX337gKiS15insKH28dtM7QSjxtM
	MlJ88RQuItz8S23EatnMPn1oIrHWqIfZS3IaiVqhmyFoKyiGn+g=
X-Google-Smtp-Source: AGHT+IHL9SrZmv+xtX5qZOpK4gl6E1/PjO80Mnj9EOcKO7BU8z9tUuiRewHl8axe7ZL1y/7s2pRdvA==
X-Received: by 2002:adf:e3c9:0:b0:374:b71f:72c9 with SMTP id ffacd0b85a97d-3776f452fd1mr1504037f8f.16.1725449034860;
        Wed, 04 Sep 2024 04:23:54 -0700 (PDT)
Received: from p183 ([46.53.253.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bba57bb20sm178590285e9.4.2024.09.04.04.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 04:23:54 -0700 (PDT)
Date: Wed, 4 Sep 2024 14:23:52 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix integer overflow in BLKSECDISCARD
Message-ID: <af9fff6d-3efc-485f-841c-25eee750ec8e@p183>
References: <9e64057f-650a-46d1-b9f7-34af391536ef@p183>
 <Ztfij7dEOBotfOtt@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ztfij7dEOBotfOtt@infradead.org>

On Tue, Sep 03, 2024 at 09:31:11PM -0700, Christoph Hellwig wrote:
> Do you actually have a test setup for BLKSECDISCARD?

No, of course not. It was "delete every -EOPNOTSUPP" until bug
reproduces.

> Given that
> I've been ubable to get anyone to actually help with teting it
> we might be better off just removing it..
