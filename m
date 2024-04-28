Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D8664CC0
	for <linux-block@vger.kernel.org>; Sun, 28 Apr 2024 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714329986; cv=none; b=dAuno9M+LuzeiumdNjNe+xPxErZy5pmgf5AG877B9BBTqlomikQrpAsvh0Yd+ofBCtpeIhJcnrSX2OGNM5rhGb5O1x7ZsDKRCMzJ+H4h5etmw45J6/SHjEzw5QC7CIGvpH0bMdteNaUVSdEDDma3gbfvuOUVuJYQa8JJ3o7P8T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714329986; c=relaxed/simple;
	bh=UCyUGbVStsQ4PqcA5v9cIrp44bn4QBwbJ1SKpM09zOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXgR0vVR+GABziq7Y04tFEPgUzk4jjAxViMwwZ9lLBjzcc6ooOqRhweYMkBupXflNz4K9yWg53TBY4vTfr/Gd5UmfuC82uPm0Az3Y6r2nLpvS0ghR122hMM5Ji7Mhv+j+lusYrZm1q7n0QH3kqcwsvSbZVrpTElX/R6fiUxcyB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OD+kJilx; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OD+kJilx"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a51a7d4466bso412787666b.2
        for <linux-block@vger.kernel.org>; Sun, 28 Apr 2024 11:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714329983; x=1714934783; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jGHcgF+VuTvfty4lb510NeRVdXMmfzGhEByfgWFXZww=;
        b=OD+kJilx9xZ9IEnsJx70FScd6agDuG5vRjpJ0LOL784/QHP39vMTjDMQvdRcOeThli
         4WI/T/8IxkN0k4h+Y7p98Sq9F9JeqIOc61MG5SLD6Jj+ZKAUlL1hilvyPcJa9z0IRV61
         ZND9lUMZ4R4febOMl3bHzZyfJ/6NkBW/fNS2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714329983; x=1714934783;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGHcgF+VuTvfty4lb510NeRVdXMmfzGhEByfgWFXZww=;
        b=Ppm69S150JbrakfLsxaJDLRqWzI6BBLnZdnhyCe1lv+BtollSxyJlWr0ADoyQw+Z9r
         7SqzdXdlUjg+9OOYsi7coTPdlaABoQRN5wiSc8g1l8Q+TOvL5+eAjdRn4SmaUii9K5Z/
         If0Y64jZf9X79qzGPT962KYpVyrsR1po+f9/nMRlcgzL+naJBkggUP4nturKtc2Mpjgf
         MNZJMwY/Q1EFIBTaLigA5gob4EOMlpbjPNTxYK4BtTOoYSA+rkkdNEkPhzidxfTkSu3c
         UsH6BI5pvlkZb5gMLERJuQaXucFK6G98Qot0KlitXoR6igOeuqZd6vAOi1CKucpjntK5
         Ub3A==
X-Forwarded-Encrypted: i=1; AJvYcCX2l71nmnmW++HgrQMzD050bKk9+UYLSoRMJeOs48lK7s7de3VJgbtHl/TGS4PEu856vIF8HVOzAC3IyWVkBC9b1RWWnbdost6LtMo=
X-Gm-Message-State: AOJu0Yx0qTlhsCKxNIw9+X6wLK2Z0X048tLlW8Dw1Mb6ZQTY018ysqk1
	M1iMBD/A+2i2ld7i021+cBdPlZv8k2TO4TT2OtC+IFeCUJNegzMTUYoPGKbVy129FJdlPWVKvQi
	GOugH+g==
X-Google-Smtp-Source: AGHT+IHoYW/wAKhPBEyR+yVkQy/s+LImYH1+2QDS2FU9BzZIX7xsLpsPQ23f9XJAi3JyizrQ6XpLoQ==
X-Received: by 2002:a17:907:76a4:b0:a58:94c1:88c9 with SMTP id jw4-20020a17090776a400b00a5894c188c9mr6047115ejc.54.1714329982777;
        Sun, 28 Apr 2024 11:46:22 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id jr13-20020a170906a98d00b00a4e03823107sm12937850ejb.210.2024.04.28.11.46.22
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 11:46:22 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a51a7d4466bso412787166b.2
        for <linux-block@vger.kernel.org>; Sun, 28 Apr 2024 11:46:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVytfQ58xZ12SX72mFK+oId08O5Arxw0HoayEOCZ8FzfTiALACzOsg8midyqc2vQs5IAUeHgoMBdF6BWQHikjBlUKlD+Zw/t2eWq28=
X-Received: by 2002:a17:906:c7d6:b0:a58:a13b:37b with SMTP id
 dc22-20020a170906c7d600b00a58a13b037bmr5288677ejb.56.1714329981787; Sun, 28
 Apr 2024 11:46:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427210920.GR2118490@ZenIV> <20240427211128.GD1495312@ZenIV>
 <CAHk-=wiag-Dn=7v0tX2UazhMTBzG7P42FkgLSsVc=rfN8_NC2A@mail.gmail.com>
 <20240427234623.GS2118490@ZenIV> <20240428181934.GV2118490@ZenIV>
In-Reply-To: <20240428181934.GV2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Apr 2024 11:46:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPpeg1fj4zk0mvCmpYrrs0jVqrFrRONNFgA8Yq6nLTeg@mail.gmail.com>
Message-ID: <CAHk-=wgPpeg1fj4zk0mvCmpYrrs0jVqrFrRONNFgA8Yq6nLTeg@mail.gmail.com>
Subject: Re: [PATCH 4/7] swapon(2): open swap with O_EXCL
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	linux-btrfs@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Apr 2024 at 11:19, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> FWIW, pretty much the same can be done with zram - open with O_EXCL and to
> hell with reopening.  Guys, are there any objections to that?

Please do. The fewer of these strange "re-open block device" things we
have, the better.

I particularly dislike our "holder" logic, and this re-opening is one
source of nasty confusion, and if we could replace them all with just
the "O_EXCL uses the file itself as the holder", that would be
absolutely _lovely_.

                Linus
