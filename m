Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F920253F35
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751464163; cv=none; b=Cfpg8W+4gusduLjHhNynZrAmU8ZMCIcIPnP561kvPF75YbeHTJPo8H8WAAx0z+bJFHxP5McTnrDR43zCYzeJIifZ3qi0VPp5+F9CwX2PW4EZtSkEdoSFvYT2jPclPler/BLAU2YOmMxKAM3WuLqopHlbvjUhBOAYJ4AjoQ2g/ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751464163; c=relaxed/simple;
	bh=3dtWvOnwECnar+aU1A/C7ljCMWXFm3411P17BEniXz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SE+PQKiBhwDjhAJaVAR6phPar55cok8yGwZQgWWdlzPevjD7sLF+EDi80o50h0oun2xvGQ+jd7/k+0eO2andpYC1nU0IT5bM9/MBP+tYwC5FoG6XLSuFIn4EvW1HRvKMDjh2yqAANe30PP8S33oWv0Z+5yx6viKHW0c05k03M1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zc7cxcWd; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zc7cxcWd"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-86efcef9194so246560239f.0
        for <linux-block@vger.kernel.org>; Wed, 02 Jul 2025 06:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751464161; x=1752068961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UmKPSiA+DMe0y1oOP3u6y81S9PUYI+S3s8c9kqvPo70=;
        b=zc7cxcWd9yJJbPxfge2cGndAqoL7RkjmWUWiK8Wi8DMHfPlYBo4u9fYaryc/7DC7R4
         y8xvar8boyh5utrHyJOYZ5yFc0eyctLlxW38c6B9AuV5dntf/ZHoopIfwjfuNfaW2ZqV
         SL12NUZNNO2usPD19ub+KJmJ6NuPJfs3bb3mwNQYBKQK19aXU6Mn+PLo4IggQ7J+Q+Ye
         K47IwYe0LYKBCWie0wxnqo075lhJRZNfuchS8rJKegITzyK0FlLFH8T4f+9jEwNUKMfH
         9nc1LdklAf5vd+RTHgQN9yM0OyyYJzSxJP9Cc4qk2UWzMMBUAGYOObLNt1tlRw67pAHR
         Nd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751464161; x=1752068961;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmKPSiA+DMe0y1oOP3u6y81S9PUYI+S3s8c9kqvPo70=;
        b=MEm0ZUq0tSyAyDEA+rxwOSFaf8uVU2Y0JUZQj9/s6g1HMZIZ6jXr5ZVxoZboR/zZFU
         TwOzml6uFsvviBke9PFa0nTTB2ay581xFFUeYiEvs8wvNjkQJ/Uh+fqugc9Jfd8Yoypn
         iKAYM1HuDY4/IGBPsbvls396rpN8AXo3kmLaaHU8RheNPG0MfZ8NDSHxx9CYDYgXSwjX
         +JrdJac/yiWWywfGknSgVVzBWv6NzzZNBWlg2utkVkHtt2xPM3cFRL0Y4RA3i8tAIM3n
         37wKW53vAYbpapMWBQTtmMS/FCg7xdah59HzxJroNvzYA6J92LUiYVfTlYEBM35rjhbl
         mKDg==
X-Gm-Message-State: AOJu0YwBs+Eh9DX5fcQ5LmvS/fOn5yfsPC1fkUqZTg8k3+VdO4c+dXub
	P2xE3k0awrdUF92cClyQGpT6nFIPLY0n8zagRW3ckFyMfWK2AIcOi3QX7zvaOSr0CMg=
X-Gm-Gg: ASbGnctMvTVoA9wF3mn99B/tBthriacK2552Tmuq9O+nTQa9rJSVdh7/MjuGcr3XV5s
	t4vlzasBibLVyfaTpY5JN5IVvus73MjO1pH35aBp6zNVLoza63U3jIVA5VInaVaOZzsDZmhSfd5
	COqGaTfpamP4Ts4HjVnS30JXFalXQx4Pp6Vdyhw5BvLdvu8qsU8AJ0nlVr1xs4K3WHQeQhQJ7dQ
	XRZ2FOESM2Lau3jaU5IISOHVjQ9JGDHuwjAdlyWen7B5CaXY47gvF7QM0K4t65lgQz/xfaVHLYp
	4AAb2TyJFlGVSpFUmifX4rZwMjkD6nhugu0DQQbqlCW/ZMtkTSUjsXBcFDk=
X-Google-Smtp-Source: AGHT+IFoDMrG3sdUp3ZtKwsQ1EnFvJM6JH+Yf5SDSq0ZsPF51vMD1as1g7Edv8aN1+I52eNLTGcTDA==
X-Received: by 2002:a92:c26b:0:b0:3df:45bc:14d1 with SMTP id e9e14a558f8ab-3e0549f47c0mr29766485ab.13.1751464161401;
        Wed, 02 Jul 2025 06:49:21 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50204861386sm2972565173.16.2025.07.02.06.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 06:49:20 -0700 (PDT)
Message-ID: <a741131f-b06c-4565-974a-f2c1a45d44c6@kernel.dk>
Date: Wed, 2 Jul 2025 07:49:20 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bcache: Use a folio
To: colyli@kernel.org, axboe@kernel.org
Cc: linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>
References: <20250702024848.343370-1-colyli@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250702024848.343370-1-colyli@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/25 8:48 PM, colyli@kernel.org wrote:
> From: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Retrieve a folio from the page cache instead of a page.  Removes a
> hidden call to compound_head().  Then be sure to call folio_put()
> instead of put_page() to release it.  That doesn't save any calls
> to compound_head(), just moves them around.

Really needs a better subject line... I can do that while applying,
however. How about:

bcache: switch from pages to folios in read_super()

or something like that.

-- 
Jens Axboe
