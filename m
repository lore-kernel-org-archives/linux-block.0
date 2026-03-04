Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C4E366DAC
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 03:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772595310; cv=none; b=jLTF+tvVICNE4oXERzq9GcvTeEAtmtIK+ykXcQsm5Kk9+pFil6szkbthx/sZK+Bf390/avQpHN0gx1ug8OT6gwOt1qjDv68/NdaAsEA6X02JO57Chxfbp8etLiZexO+D4Pq/1TgLnVat9wCgLh2g3WW1NCPmc5X5yWDGxyVDcoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772595310; c=relaxed/simple;
	bh=XLiJ2nD8DJIVsSYbftRzQJ/qqbqmFgul82tptWrTWOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FLYgtUtzgQw/Cy6q3zLT5Q8xAcePEW+vJ0VwrnJwlqgD+zdGma6Ov6s+6otTpNvAuE9U6XbzTsiCSKSLnsmVPw+sb4OstljY9QZgnxjLWPuOK6SbbO5j86SyRVHfyYR95v0KX23Y3vqaBlyvPNRkGSI7sn2EI4pCbbe9PyhJ79o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=V/RVqeIg; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="V/RVqeIg"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d18f80b5c2so4853006a34.3
        for <linux-block@vger.kernel.org>; Tue, 03 Mar 2026 19:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772595307; x=1773200107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NrE0zI+7ilR1NedBJHHio8t27882PDymrHrpls6UPoo=;
        b=V/RVqeIgbll4o4ue74s/NYWOyn6ZZujuTFopUtqhjail3GEAE5/viHb45qoLBheA0C
         FjThpB0c+lktkioT8cLcDCupPIwr6ZtFjugZdaWmjPYCZvExg28dp2j5GNZKC+dwFIRT
         nMYTLvuq7I98ei43l1fO8SZa0kkKx926Q5k3OSaMudvEhiEEeEmS0+UTFtTKWPCx5BtH
         jppJ7leZ920nl2rr1NSxO3EsCbm7kJQgCQktDg8tjxpMgjzbh601eaHfku+ZFLcNfn/I
         i2IKtcx8h6KQ7DdzF6qyt1xEaUJ+G7gmzB4DX6DIGKuctT6KVr0ZXVqee2uy5eeWmU1x
         Tdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772595307; x=1773200107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NrE0zI+7ilR1NedBJHHio8t27882PDymrHrpls6UPoo=;
        b=NSvEfGBqLq4klVBaI0i78kV5sfH3fuItn04wq+QrLvM59LfXGAvmraq7v5uj4wh62x
         bYNAcTQY0D6X0zUt94q8JmnlNRYilHOj/qDEOOU1IYxZ5+TXSAFYyGzJHB6J72Txxh+Z
         LXp7NUciM8iHEgzcomoJW88cTauQyGl7WimnTFkj3gBIAMrzdPMDUfkMp2iRQZp4XsCG
         GpPZIHGTNRWMHP54ARdReFLdRwW1iQC7tUYaeJNVoEcQnlPKJ66id1xB/ParPjHFnI/e
         fJvueYil9G8objUpi41YTVTqjychIgYi3N4km4rG0ofKZYomzqGPf1GtE04n3CHuco1Z
         PBfA==
X-Forwarded-Encrypted: i=1; AJvYcCUKUcJPr7ng5YvwxQWyVEn+LrLb9U53XSv+6wSISyFRfizacfP3HRbxG/BqOgbwoPO4bdTWnbb0Un+obw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0bTIVgLeCSLZiKVXGLq0mjjdnsKZsapiy6hJje0hkIiUEK91X
	1vpX9cS/QkIySqVgRZqzDIBARdSAXV4M04S3t1BfSg6Ktl1qRCTs1RSj7dBLsxELRMY=
X-Gm-Gg: ATEYQzxuJia8B+ocvMUbEvjYa49UselggI7rBkaSS0nR7c++TfAqM3LseZUbTme+Hkk
	VAC33zpBQaL9pKFv4hOl/Qn5/WQ2n5IPyIsB2BJNxEEvH5/Xhnc6ePlPMOPIre3610x/QMSdPEV
	v/nn4xJe8EszIHKMlaXo3kVkSwEI+bidk14/AqD8KSx2bdhmezvTHzD9xwjZfvLph5zM6CWZnMA
	JGjXVyfqdP/iGnQjmo2o9aFT6VQn+7bI9iXgyfGqRXsthClbPZ1v0Wa4nIuINCGaX1PqdMiEw4I
	1dmjLiXG9bY7pVI4BOsOymS79a6XxCR//66ZoloOOgbfFPx3Zb276lPzYBOtDl4n3yxLIYqL+fr
	8YkRQE4A/n8F46StWbfgP4GOo634S4++Q3/bSDfHMIFZwcPnzhTmpLVMIcS4WsJtU4UKS6NmidO
	w4i2ma75xMMSnznG0RyyS6Da9zLJ4t9XJXUDTlSB2zL8n/+Ggpmprdhcv9ZjSyuKe7IkrXWiGd8
	1LHkS6mkQ==
X-Received: by 2002:a05:6830:6185:b0:7c7:6977:17cb with SMTP id 46e09a7af769-7d6d139f788mr450044a34.21.1772595307034;
        Tue, 03 Mar 2026 19:35:07 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d586653f6asm15202012a34.19.2026.03.03.19.35.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 19:35:06 -0800 (PST)
Message-ID: <e96e851a-9050-4d8c-b1e5-bc3b5d91a84c@kernel.dk>
Date: Tue, 3 Mar 2026 20:35:01 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] mm: globalize rest_of_page() macro
To: Yury Norov <ynorov@nvidia.com>, Sean Christopherson <seanjc@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexander Duyck <alexanderduyck@fb.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Alexandra Winter <wintera@linux.ibm.com>,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Anna Schumaker <anna@kernel.org>,
 Anton Yakovlev <anton.yakovlev@opensynergy.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Aswin Karuvally <aswin@linux.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Carlos Maiolino <cem@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Chao Yu <chao@kernel.org>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Christian Brauner <brauner@kernel.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@gmail.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Dongsheng Yang <dongsheng.yang@linux.dev>, Eric Dumazet
 <edumazet@google.com>, Eric Van Hensbergen <ericvh@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Ingo Molnar <mingo@redhat.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>,
 Janosch Frank <frankja@linux.ibm.com>, Jaroslav Kysela <perex@perex.cz>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Latchesar Ionkov <lucho@ionkov.net>, Linus Walleij <linusw@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Mark Brown <broonie@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Miklos Szeredi <miklos@szeredi.hu>,
 Namhyung Kim <namhyung@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Abeni <pabeni@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>,
 Takashi Iwai <tiwai@suse.com>, Thomas Gleixner <tglx@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
 Yury Norov <yury.norov@gmail.com>, Zheng Gu <cengku@gmail.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-block@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 dm-devel@lists.linux.dev, netdev@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-crypto@vger.kernel.org, linux-mm@kvack.org,
 linux-perf-users@vger.kernel.org, v9fs@lists.linux.dev,
 virtualization@lists.linux.dev, linux-sound@vger.kernel.org
References: <20260304012717.201797-1-ynorov@nvidia.com>
 <20260303182845.250bb2de@kernel.org>
 <f8d86743-6231-414d-a5e8-65e867123fea@kernel.dk>
 <aaedwFwXh9QXS3Ju@google.com> <aaen2pGs0UeiJqz1@yury>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aaen2pGs0UeiJqz1@yury>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/3/26 8:32 PM, Yury Norov wrote:
> My motivation is that it helps to simplify constructions like this:
> 
> -               loff_t cmp_len = min(PAGE_SIZE - offset_in_page(srcoff),
> -                                    PAGE_SIZE - offset_in_page(dstoff));
> +               loff_t cmp_len = min(rest_of_page(srcoff), rest_of_page(dstoff));
> 
> Or this:
> 
> -               if (folio_test_highmem(dst_folio) &&
> -                   chunk > PAGE_SIZE - offset_in_page(dst_off))
> -                       chunk = PAGE_SIZE - offset_in_page(dst_off);
> -               if (folio_test_highmem(src_folio) &&
> -                   chunk > PAGE_SIZE - offset_in_page(src_off))
> -                       chunk = PAGE_SIZE - offset_in_page(src_off);
> +               if (folio_test_highmem(dst_folio) && chunk > rest_of_page(dst_off))
> +                       chunk = rest_of_page(dst_off);
> +               if (folio_test_highmem(src_folio) && chunk > rest_of_page(src_off))
> +                       chunk = rest_of_page(src_off);
> 
> To a point where I don't have to use my brains to decode them. I agree
> it's an easy math. It's just too bulky to my (and 9p guys too) taste.

The thing is, now I have to go lookup what on earth rest_of_page() does,
whereas PAGE_SIZE - offset_in_page(page) is immediately obvious. It's a
classic case of "oh let's add this helper to simplify things" which
really just makes it worse, because now you have to jump to the
definition of rest_of_page().

IOW, just no.

-- 
Jens Axboe
