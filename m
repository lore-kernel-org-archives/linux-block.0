Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C40E3A6B8D
	for <linux-block@vger.kernel.org>; Tue,  1 Sep 2026 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274428; cv=none; b=ppImJS7C+iDw5+Wve177GeOBwpzy4tVh9hkIxKdTiLlsDN/x636BF868Vb+j38589ZBe3ahyn/2FFcgDTXvCVDr9RHHeKSLywT9/6L91rm4/RxlisdkwMwkx6Fbyx9BSRVQsrY7xm6OIGidZz2XHJe9C3+Ll1BLd+swguycnFHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274428; c=relaxed/simple;
	bh=hmmmQfae2hxyCJQidJGci5Y2uZPW3r9YqvFfdm4bTmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gcd7l23U9CBFr631Bhr+xE9GMXgpBfsj9s0ZgJfjJdeaT7PInA+gu+O4qCUSrjF4qKItVLS/fj+U0sa0qtH05m30HhCxGGcXZFDGYzbDWUnTmw57bIC8EWzvcJU5dWFCXbKuUz3ZgTWTfbQoIatGfJaDG2D3qPelUlTXU9m8KiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PYUXpeIt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cMYng27y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PYUXpeIt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cMYng27y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788274426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fbyTpneZ+04gfzP6rRWP45g5+NNCS/n/AJeJwyZrfWY=;
	b=PYUXpeItEk3U7+3wEVV1EHaGFlgo7sLyJ0NUXb6uBtfcFTQjHFzynjfUPDpm3N2SSOrerv
	cAX1PKjeUyJmw9yrrgkmolF8JFq8Am7XdrIGD/vSMt47/olqzpEKNsBMvooARuw3pCT3QN
	4eFvOpHd8j/L6/nMYf7+CJUisqThnQE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-z2P8S9o2MoytsipqfJmIaw-1; Tue, 01 Sept 2026 10:53:44 -0400
X-MC-Unique: z2P8S9o2MoytsipqfJmIaw-1
X-Mimecast-MFC-AGG-ID: z2P8S9o2MoytsipqfJmIaw_1788274424
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4997b060af8so8244665e9.1
        for <linux-block@vger.kernel.org>; Tue, 01 Sep 2026 07:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788274424; x=1788879224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fbyTpneZ+04gfzP6rRWP45g5+NNCS/n/AJeJwyZrfWY=;
        b=cMYng27yoTdtueWNdq4/x2bGozJAuOPnqqzUMH/avf/o1VTFGnutt0sUk2/NqOes2v
         iyLtpFzJwGZpe9oeWRjSexuxXdRpAx4Q1i1RozroA+n/GTIipibCLWmTcst4jPg3yAm2
         lSjD50OzuzWVLEeZ/9xAthL+UofwzL7WUQAFho3dlqJDqEBuZWlU7TYQRNrdauq1iG22
         g0GF50++XJ0JLVO4D8ptYLhvuDqrSPXeGt1kB2uxpMB2R7mqkSGeQ7mYvt4M8H2wXn8X
         uM07m1DqTkMEolLxC8t7S+8iW3ENVueVShrY4mECN1JFlBYrdVO8245FHjuJ9NcU89Md
         bC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788274424; x=1788879224;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fbyTpneZ+04gfzP6rRWP45g5+NNCS/n/AJeJwyZrfWY=;
        b=cxFw5rsU3G9SCfIFuyKdcJcqsXuxdvq0uemeJLfyYRVq9AmgF5218rwq1xTaShImRm
         uRuUu0sw/Bo460hYc67qHIIIAboVfp80cOc1jcd7hX6bJKuflRymFr1VU5gjWD+TtpBA
         bc9UTZAbl2CrFJIdFwoEkX73izcCfgvinriwxMqhzrhrTO6wVJ1kX5hTGdEb1lqw8eCo
         c+pFpAlL8tHNs4yeH2JTROg48d+gfNl6cD3EVWuy6cnzXVEmS8YfLr4H5kDQ9SinMWzC
         WHRpEbfito8pqSAT57C11Ojvza4/3cRMnoDoE+ofjAbO8Mr4txWMmt99Hxm+Sal0oEWG
         RbsQ==
X-Forwarded-Encrypted: i=1; AHgh+RqiyLpxJp71AA1lCM5XpQwAOzONhBxQ+IeZPGyu9FkBBsNOO1Rj0V9l8lLiqQboIzqNoQoTeU1fPSRhHQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lvKtMpuowdt2z3G5a1x+BM3w7cmhbq+D+tqIiMWYfYWfBfJ1U6
	9j/6NpkSkqyq4TmZOXRqkbcc+VS29k/MlDrooc30AISzYcFldcWI0Ykgrtafk9o4ojm+HPRxjpl
	qzBqaY49cNGAmiEWvxstpTAEeUdAYVWemnP/0sYQB5PzC7NnlKjQqdTKYXJ0ailv9
X-Gm-Gg: AR+sD134Y3rXmIEYuS3+bineUyWCLyu17aNHxz2B1nt82LTb12UQAyfgC+gveJigp+G
	zKuvUyenqn2LDbkJJtgZ55nJSsh2cYr7cukd1Sqip0bmYTAUALf8SaWnYuBx9bD6/O8WqhSlpld
	8VZIlnEh/oqbem0qztkLZ+jNVQSmBnkLgARhXgRjU2mDRk0O4Yek0tMwrdnRn7g/b9qxyyhq2KG
	YvF4oKTtBjSHebVWHL6QxL5Bc8xJKWK1dxq8Mo1rwC/cEktSIP/VsRCLrtCjffGlKwOpkayNSlY
	h6bPkKg4/0gC3DPWt59tgNJwxYN05GI6HHm7dVay2Vpk77csfKevtdSh5zw3+UFqO85sDkWtwL1
	jfL83kPZJLVNHPk3UDvUl7Q/dtEA2LMwIaXCGv6KAJSE=
X-Received: by 2002:a05:600c:4fd2:b0:496:c9cd:e7ab with SMTP id 5b1f17b1804b1-49b91c22421mr551346985e9.5.1788274423688;
        Tue, 01 Sep 2026 07:53:43 -0700 (PDT)
X-Received: by 2002:a05:600c:4fd2:b0:496:c9cd:e7ab with SMTP id 5b1f17b1804b1-49b91c22421mr551346135e9.5.1788274423285;
        Tue, 01 Sep 2026 07:53:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce08b8esm65734725e9.3.2026.09.01.07.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 07:53:42 -0700 (PDT)
Message-ID: <4bd634b0-c8a7-467c-9c08-40e7ab37eedf@redhat.com>
Date: Tue, 1 Sep 2026 16:53:41 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] block: save page offset gaps in cloned bio
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, Keith Busch <kbusch@kernel.org>,
 Eric Auger <eric.auger@redhat.com>
References: <20260819154937.3903312-1-kbusch@meta.com>
 <178827386087.2511601.16223997201252856898.b4-ty@b4>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <178827386087.2511601.16223997201252856898.b4-ty@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/1/26 4:44 PM, Jens Axboe wrote:
> 
> On Wed, 19 Aug 2026 08:49:37 -0700, Keith Busch wrote:
>> The cloned bio needs to inherit the accumulated gaps between vectors so
>> that we can know if this bio can subscribe to the iova coalescing
>> optimization.
>>
>> When cloning for a split, the gap only applies to the front bio since
>> that's as far as has been processed. The remaining bio can reset its
>> gaps to 0 since it advanced past the checked vectors, and will start its
>> accounting from there on the next split check.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/1] block: save page offset gaps in cloned bio
>       commit: 96c8ea3c5add7920b3c43840d1ea76b3354c8d2d

Thanks!

Eric
> 
> Best regards,

