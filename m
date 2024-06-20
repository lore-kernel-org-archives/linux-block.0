Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B7C1AD405
	for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718896919; cv=none; b=HWK6dzdq5VIdrL6fs0gMPsDQzEBECvCoNzvA6fJMe2C3MKITlDK3VQYAADwUP9s2zpvF9z6c5QsRqXcA2M22ASYd7wgd6ojUv89egxxzpBznZ1MoyhnzK3HIIk+pSozOwi03lW+jFvFkFr2uISz643EWtgQeePuflRfpxyzowBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718896919; c=relaxed/simple;
	bh=0VfEbqmlOUQ+zPYRUL/IOuev2P5Zh4WeBNpMp1Cizo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rb6j0+Cy5r1NeUtNlC+BvBLwizgNc7BfdhEl++959so4mff74LWstivZUUjMHHk0YJoGgVNxBzi0YQZm8pbzY0UZzo6FORv1bIMYL4kDOFSeHUUn8I+4VI26oG9C8iv6TWq6MSXfQSpn32RavACYWenvH87QDyLjhrVO9A6Yj9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fR/8tzi5; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fR/8tzi5"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-254ceab70e3so151765fac.2
        for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 08:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718896917; x=1719501717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9eRgwO/9COpxcofzFfOFxfJtOVnLPVv3E1DKVsbAftQ=;
        b=fR/8tzi5zJGuhPFxdnVYlUXTu5P1PLg49jbamExtdQJuUVOrMKVbWYoWOV9Pk0Trkk
         Nn19bxFUq0LcN+YTKdFos3BfQoNpvE/h2vibOi0TzyvbErCiMBD8LnHuIX+qIB+2nWNR
         5qDO1BPdeftr02p0TSiYJySxvRzSg64tIQQbktfjq0DTiUmIR+zoAySRpjMWfLO8KpB5
         B248UZytnH3uLgRMYg5Vc6jislYKG+YQrTYNiue3Ft6SE5cnRvTP2aA41O4KeAP+4NgE
         /MEZpUPfNVOh2BcLlNJ5Q3sTE+0Q+6F647IXnZRQGnXINe5Evt/W13G9JqxGUdeAhQfp
         OKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718896917; x=1719501717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9eRgwO/9COpxcofzFfOFxfJtOVnLPVv3E1DKVsbAftQ=;
        b=kxB/mQqcqqVYan7uXjYa1hW5Xet9GtWeJN1i3Iic/FHTuo1WqcQQO+GHymNVQW1Vxq
         cMulZlD6C7f+qsjWa4tviESGvY/bbfhb6rBXWePtjUW3/iP0dSBTph0O73LydSsif75H
         4ZC/qKqWhsYHa/FiVfQAVBDJ2NW2OKS5otVQGkfa8LOem1AxjQn3I8jxW+ZNQLCyu9ip
         jlkkB6LEaf4hI57agS1uAE4sdGfTmwVDUXaTdSW0onomY/Em8cf+mITCmrAGJjUO0O0y
         OAA/8Jt9xxmaa6CGhMCGMuHpGu2UtUvZnqF6upXhRx0cYttAFWH+Cwm+8U3wXi5VkNo3
         1+bA==
X-Forwarded-Encrypted: i=1; AJvYcCUiBDkBgyLgzw60r6H85qXyV6LIbBMu9OJB7pVj5LY6pPmXdesJEea9qycJ55k6/za4ARASs7s2iZf7bj8NdjhMONLeOzUR2pH64DE=
X-Gm-Message-State: AOJu0YxYtI+FmhiS+vPTpOmaOudbaFh0n6rf7p4FWy8bobgBkY4Howu9
	ttpG0Qd1n6cvD8CbUb2jhqZJRO/97pzWA25so/xWjXkXrGA7rTOLL0PUUwREwhg=
X-Google-Smtp-Source: AGHT+IHGpP0EBmPWd6UInic4MRJR4Lqjws9grnz0EiC/pvvYKid6gK40o+JqvLJ7p0Yih23/lzz1RQ==
X-Received: by 2002:a05:6870:1714:b0:258:4ae8:4aec with SMTP id 586e51a60fabf-25c94d411damr6291640fac.3.1718896916689;
        Thu, 20 Jun 2024 08:21:56 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569930f69asm4297303fac.45.2024.06.20.08.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 08:21:56 -0700 (PDT)
Message-ID: <9ef3f46e-1534-4d93-be98-22cea3bbef58@kernel.dk>
Date: Thu, 20 Jun 2024 09:21:55 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bvec_iter.bi_sector -> loff_t?
To: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Hongbo Li <lihongbo22@huawei.com>, linux-bcachefs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
References: <20240620132157.888559-1-lihongbo22@huawei.com>
 <bbf7lnl2d5sxdzqbv3jcn6gxmtnsnscakqmfdf6vj4fcs3nasx@zvjsxfwkavgm>
 <ZnQ0gdpcplp_-aw7@casper.infradead.org>
 <pfxno4kzdgk6imw7vt2wvpluybohbf6brka6tlx34lu2zbbuaz@khifgy2v2z5n>
 <ZnRBkr_7Ah8Hj-i-@casper.infradead.org>
 <0f74318e-2442-4d7d-b839-2277a40ca196@kernel.dk>
 <ZnRHi3Cfh_w7ZQa1@casper.infradead.org> <20240620152026.GA25908@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240620152026.GA25908@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/24 9:20 AM, Christoph Hellwig wrote:
> On Thu, Jun 20, 2024 at 04:15:23PM +0100, Matthew Wilcox wrote:
>>>
>>> and have O_DIRECT with a 32-bit memory alignment work just fine, where
>>> before it would EINVAL. The sector size memory alignment thing has
>>> always been odd and never rooted in anything other than "oh let's just
>>> require the whole combination of size/disk offset/alignment to be sector
>>> based".
>>
>> Oh, cool!  https://man7.org/linux/man-pages/man2/open.2.html
>> doesn't know about this yet; is anyone working on updating it?
> 
> Just remember that there are two kinds of alignments:
> 
>  - the memory alignment, which Jens is talking about
>  - the offset/size alignment, which is set by the LBA size

Right, that's why I made the distinction above in terms of size, disk
offset, and alignment - with the latter being what we're talking about,
the memory alignment.

-- 
Jens Axboe


