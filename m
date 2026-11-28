Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795834039;
	b=J3I9RMW25o5n2tjZ8UZl7n8XHS23GROYiXvyiAazXC7RQeRNx75J2t4chuoO5qThiBwC
	 IApuJSovCWHMpWdvqIX/HjqXukWKAVWkU0Fm/pL2gXuWqjKErj4UrHoBjAVbWFqJn1iWo
	 GxdC5cr6JSeJdySHxaHlp1dZXv39NCdfEg1uch0KZHERgiJJSeG5PyxEy6QQcyWGGD06v
	 hCmWYyfsffB03qMSMZ8dG9tjSaK+MHc8QwC6jT+PgR5Osg9Mg9s9+PLZt/ISsQjWTQkpo
	 ijyXbs1gJl2q3lBCm9AvM7vhkXLtGV/zusLQVRiZ37juDPFgGTigBacoRrDG/rFPMGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795834039;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=9T+HdmC6Yapk1iAmngRWLiL6+qpvVAULPjY+mcoJnZk=;
	b=QQXZt12PVy5dfgLbWeRuj4xpljbZb/yHJzTUS7M/V/IpuQKQwtYKjnYfpiLkXlQtusuR
	 J8jAs0gSRqPnMhykCPttVcBDxVwnF+XEbEUc7QrxxNzJvMrH84d2tF5eYs5ol8FmXEq3h
	 3mwNuJUH82mGJp+YYnihaXFo5mNdZaSQ7VYqq+VrvbVYp5/qDxA6qSGCwVarHoUnJYiMM
	 jhTPndvf/rMsyQ+sNJEfDZ0+vWOi+K12J8KNFltaxgHwLi1VXXSh5SOLmDems+Aj2SUCd
	 5B7X4XbD04BDs5niSzfJ67iHHcYMfYIVaY9ZpqO+GAX3HO1QeaoyGg9+Y7I+M+NqbAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b="pi/9tMDz";
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBA3606A32C
	for <linux-block@vger.kernel.org>; Sat, 28 Nov 2026 02:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DBA3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=pi/9tMDz
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-386ab9ab619so12193355eec.1
        for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 18:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795834038; x=1796438838; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9T+HdmC6Yapk1iAmngRWLiL6+qpvVAULPjY+mcoJnZk=;
        b=pi/9tMDznb1a2G0E5fG4M6K4VKw9WxwcQlUk/AFTQmWkc06yYSLnn3wxS7EnVqDZgD
         S2FHbi/Gul7MCq9a1AsBJsvC2/vW1+hCog60VfabTHM7VHuiPhoO8hjr2PfD2IBv+Op0
         SG/5zx4sm8+TuiRU2y+Lnfi2/RMWN3RyGwEJQNgZe06gV4kNVpxcNlpyiNhnp3gEoTYv
         vxxwS0WYwN6nlPrMxQLZnslg2xZH53YM2zmO2L5UDJfI9iPV8o3ENRqveWFVShmkv6zJ
         Zw7Sj37OiGhEJxuoRY2PxcLX6wmRya6LsMCN0sWGVUehkcpVIx6gSDdx1s74soDIMtOU
         zmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795834038; x=1796438838;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9T+HdmC6Yapk1iAmngRWLiL6+qpvVAULPjY+mcoJnZk=;
        b=w5feT02NOkURQSFsoErVnuP+FctVNoyb7lY+Nfqd0HsqdrtWCG643xQnyae0L7dXDA
         mJ0+BrRD1sggt/VjT6W/7KlFH8fzsaHJDnJOKLOOi5XSUkBbnNSDH6XpjaFL7mPdx/cf
         GQ316slOZxjs4dryrhYLuEy06cXTZciUVT9ph4BDnuJ8ucD6pFXShB0zBgK25g3CEtXS
         u+Wg/TCDkGHpkcxnBeyw3Ofsb0Gx9HthPzFaNffEWfDsV/a67GYOW+ToboEj7Lm+QXzE
         VUq6uKSJZkD8Cue/pSycPWenExzuCn4RwPJPzj8itwvJ7CJxx7LCV80yGj1kRbst3qmz
         NRzA==
X-Forwarded-Encrypted: i=1; AL+hErG0SmD6W7p2n30LcXZ8luqUbpwoWqBw7R2E85RbwOYWREo/WgR6K1k+i4tqiRQ6C+r8dMqfDwP5wMBm/Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z81rIEsCdViVa2n4VJwj3R5mx6Z/0jQk5E8YqxfUFXZ0r4sHshE
	1+kXEwExweIRFly+E3l6knrqQU6PtBYOe8c3a9awc2We+gnBqsCtH3sf4qnFVYDbXco=
X-Gm-Gg: AZFdTZdCIXsqnv6h8C2dStZmWXQkYkU1rXoNayvespw1Vsuy0wCL2SH8UP2mmRr7Flz
	pd0gr56QmnJ4vgkbMQIlEoCqdztYsIzjzF7+TKkOORU+m2LPEkIFkIlAfeJNf/DS+Lf1Ph15w8c
	AczXvcip+XDvfJmIsiMUn3jpM4WAmorwN7zWSKMQ9Xyxy+oOjWkoKlijP+aZ+8+2zf2h112u+Lq
	ZWSsqDrqhIGG3GYvy8/rDSpI+KqeethKoEqizSwTcNFJ6P+Ts/nsHNjB1otVp0xV6RcwXyhduIN
	b+0eGddTzBy3l4l+pX+soc+TO5eSFAulrYGJMWD5K6u6+kpgSbdF/0ieUmN7KTXyXwDCbyRqSEN
	b+aWRMwTRa05vNmLjLFBloJ/GcBAZJHPrc49/gLlDcRFe9vx87Zuy/Z7bAAmTOFzckyqF3tskxW
	+w8ZKTYOf0QCkF8TUGuOhRSwdf5cl3ISfaH67Z1ofSkbjWkPAxhMX1uwQ7PPlBfakyPCVj27KHd
	zkCMEesZqOgS8T/HVJCBMGRX3LOWNyGeMnrmkVH7EYlNXKPL0KeuMMO1mhwCreXFm+tCx1zXzs9
	YzJABd9v/qJUyC2QfX8WamfXfpaSZFh8pxH/hoW7Ig0RWStjGI9ifMhPyHJdjqAuXtbdJZaMFVU
	X3daBaDfdNNNai1GFDKMUAATENc1H3EKj2pLLNjKnXbEn+751
X-Received: by 2002:a05:693c:60d4:b0:369:fe81:a575 with SMTP id 5a478bee46e88-3857111f203mr31707810eec.35.1795834038348;
        Fri, 27 Nov 2026 18:47:18 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm134059672eec.3.2026.11.27.18.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 18:47:17 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <tom.leiming@gmail.com>, Sasha Levin <sashal@kernel.org>
Cc: Uday Shankar <ushankar@purestorage.com>, Shuah Khan <shuah@kernel.org>, 
 linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261126231706.1303486-1-sashal@kernel.org>
References: <20261126231706.1303486-1-sashal@kernel.org>
Subject: Re: [PATCH v2] selftests/ublk: use the configured kernel UAPI
 headers
Message-Id: <179583403747.86956.3400056102579303630.b4-ty@b4>
Date: Fri, 27 Nov 2026 19:47:17 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 26 Nov 2026 18:17:06 -0500, Sasha Levin wrote:
> With generated headers in an output directory, the hardcoded source-tree
> include path falls through to distribution headers. New ublk flags and
> structure members, including UBLK_F_IO_DESC_SIZE, are then missing.
> 
> Use KHDR_INCLUDES to consume the headers from the kernel under test, and
> add the headers target as an order-only prerequisite of the ublk
> programs, as nolibc-test does, so that a standalone build installs them
> first. Baseline builds fail on the missing definitions; GCC 14 and Clang
> 21 builds succeed with the output-directory headers and target liburing
> development files available.
> 
> [...]

Applied, thanks!

[1/1] selftests/ublk: use the configured kernel UAPI headers
      commit: d9667b1a6a3387ef934667b9a2e6c099eee0e4f1

Best regards,
-- 
Jens Axboe



