Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA31B224B1F
	for <linux-block@vger.kernel.org>; Fri, 25 Jul 2025 07:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753429660; cv=none; b=kE49smUAn7m5ktWMMvjlcDK7PUEz5EURl9pUvNbecPf6hx4H171Wl0bWnIHnq//wZP1JJ5zOSvv8JF7QBaBIFbH4RTmc6nRl+kF63ISWaEI4czUTIiZF2ho89Se/1OiRSVbGpnjGhvmDd07FRdgp9aXg2oqBHf2eQDZjO/rbmfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753429660; c=relaxed/simple;
	bh=6aKQxPLJm86iinj3SgtDljcu5SlapFV6C34x/TU5I5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hi/DeqStwOlQpkR6XFwoInEmiU+z1EQvOH6sQrXUKWllxeouhRU/mecZID/zSRvY+IbG/QDImOeT3v9KbS/HBoMKVt0x+23UxY/PGxq3CPugXiwO1BZhzwFSn/m41MH8udhxul0kraz7Qu+sGhBlwHhZA2OsiQzvCOFmZ/lpOxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XlamKxp2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XlamKxp2"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-234bfe37cccso15195675ad.0
        for <linux-block@vger.kernel.org>; Fri, 25 Jul 2025 00:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753429658; x=1754034458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pbHfEdsfKeW3Ro0FE+/3vNweKKctdvcx0ysGRNJMYRQ=;
        b=XlamKxp2bA9cZTt8TjTWqwnTDKQuKzTTmAPtFafoJ0xgsuYy3ZAi2Tye0ERU0WRtxW
         RMUp0QNei5+PkM42QSAWbbQhosKjOSU16eNFblmg7qC1CE0lFNLvdW2Ip5/oUO366eSu
         NIDpGOsPk/yvKaiL939HHOzmbxZ90Njaqp56k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753429658; x=1754034458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbHfEdsfKeW3Ro0FE+/3vNweKKctdvcx0ysGRNJMYRQ=;
        b=QlHoIV461T5ek2PzP8O6/IzwPGdrOYTeCvS1ifoJ8S2TYYMwLzqA4hoDJNYv7cVv8q
         NQruCI9ce3ru2PyXpL1Gh9qS8zhG7O2VkhT3qTNe1VBp31YHy7H7m7I2ON7D/V8Yu7T3
         lshEODWvBPCD5MeNyAUUv7zYhDQYAK8F01Uzm4/ImcxHJGC7HVBhfSdj83WwHGVG4lAV
         KXESbmpNMpe6qQcpYG30iIdOdzuCTQiWE6xrewaejMsicpk0D6OJpPtQqXcxPOBgRT86
         BjMHxjZd5cjQ3ayWiJgoZlLhJZXeDGznt56AS+CE1eIB3No6wCE7lv+3lNqew8sU0Snl
         Kp6g==
X-Forwarded-Encrypted: i=1; AJvYcCUhbyKwWNzUgy50S8xwWsbwbqiFihOXRcte2x+EX2PxIP+65/abV9ioznFIFhsGGMEfgCkNYCmBjqZILg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrZXaJ0UPNoBxnK8Vgo7cm92rJxH0EbzRZe/aHI1BTTH53MPuc
	+1NYF83QgWwQHft226nLYcdhQ+amLECiRaZGBMRt26DPg8x6u/bp9AdZYqcgQT60OA==
X-Gm-Gg: ASbGnct5hB0w2rtXEM5Ez9C/Vr7W9hQUELvxmR2NOcWAvbK1PVBCfB0laGh173Ciom3
	RKgfHYxBQZNaKMHpVDu3mfro/6TVlpnZPlUClQ/iOH2CHindRaDd/30ZsbKxJaxp7T9kH7v+Cr1
	6Ttcvfi7ebujV4ONrRRKXqd7z2kFikz0+jJf4I72HvGT7y54GypzSe6CuvnhoRH2NJTws+NuRyG
	EehtmpucI96JYccRJ2cNG1TDv4BnDW28GeV9gpoYgg0rKov0O3TI/1qporD/lsFgwc6/7g0QYx7
	oLQBNzWI6L9au78dMzhN9dyhkTcB9ECu+ixvkr4fyW+/2tqdcXioDrMWAJfhYF70ScxyC6CgLi6
	DgXde0X0DkrmhNcr+uOEoP+B+Tw==
X-Google-Smtp-Source: AGHT+IEdRJwQ3rQ5V/fiR0qq9nIpl2g3oSLrSDM9VbQL4T+8/gPpt7ppYqzAAyiYy8krZFxaJx97KQ==
X-Received: by 2002:a17:903:1cc:b0:235:eb71:a389 with SMTP id d9443c01a7336-23fb30c8a10mr14800305ad.36.1753429657970;
        Fri, 25 Jul 2025 00:47:37 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:9f06:aba2:20da:9eaa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fb431d102sm5207825ad.18.2025.07.25.00.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 00:47:37 -0700 (PDT)
Date: Fri, 25 Jul 2025 16:47:33 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Phillip Potter <phil@philpotter.co.uk>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, axboe@kernel.dk, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH 0/1] cdrom: patch for inclusion
Message-ID: <4ifniioxsakjgvuqxhkm73e4htopanqhm7uhp7o57gb233vyin@kjwdyvfzsgqx>
References: <20250722231900.1164-1-phil@philpotter.co.uk>
 <eyejjkuzdzl7qlq3os534ckt3jsvvnvp76pyqcrpzcignj3oms@w7cvw6oht5lk>
 <aICXICNEcwutw9C4@equinox>
 <nlskide2ahqj4gn4jvvazhhmdajqsacz5ch3zukgg2fbfmw2dk@tkyujyzz4pks>
 <3a5hhkymroystnc2ztkyejgyvfsaamfrlwwoagorymonftlkln@7qzlqyaq4zpa>
 <aIM1Cx-YLm3nky58@equinox>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIM1Cx-YLm3nky58@equinox>

On (25/07/25 08:40), Phillip Potter wrote:
> > The patched one doesn't.
> 
> Fantastic news. Thanks for testing this, and for your other testing
> too, much appreciated.

Thanks for working on this, folks.

> Have a great weekend.

Thanks, have a great one too!
