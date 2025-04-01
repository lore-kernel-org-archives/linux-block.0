Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFB070830;
	Tue,  1 Apr 2025 01:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743471619; cv=none; b=OvqN0I8djIyMGsNcSUc31nYu8Y6vsO9Q6I6Zr4aepw3IqXKHpLt+NB5IzNhaTYyuklv4wgEUnSFAklQVkTSZdaATtgPV7DdIs2oe2X5bECfLIF3PE/ngnZIxCab1MIhHqWXV1ia5k/Kd1hyjEOWSh5YUnCBcl/vnn2IdBRcgG2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743471619; c=relaxed/simple;
	bh=U4gNIwCOm/SqsSvywqeoGSyu+0kNBYn/3W7M7AGnnIQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjuWiJmyFtHXzP/hdBme8XyOgmuhJkdoHsWJmhaJFG/NcZiS+RApxS2SUsrAKsZz26M/c30UBwyOyuI/G0JvB6JqVc8HQsWDIamHbbi49IWq9A1WKQvkIMNQ5i9Z8k5vI9Pn1ISTBIv0DNqktvNNeOc9UdBrXs4/OuE5KXghfpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Co5ZYNoE; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Co5ZYNoE"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3995ff6b066so2782928f8f.3;
        Mon, 31 Mar 2025 18:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743471615; x=1744076415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7yvVaeLNnzl4CaH0kZ/bBt05ELoD8WPueO+YtgvCv9g=;
        b=Co5ZYNoESGEEupEfODzBmvBIv6E4TCue3Ejsyv0EsTJvX1XKXJE2OLj87kRZjJxm5G
         /gm0TGq1zYeZP/4e740dq/BDt7LhKIqMlFbNmaep4NwUyAvTUa90DAau9E7kTGT6KEec
         /LapVy6V8kvuVggbbz0NgymVyQbEajhOpMcHx8yU4ZVDEqVRUdVRRjiEpH2hm1RexVLW
         s+Fnap2XG2G1V7zNs5TVuNPqdhZiyKxgBvzdvg0HkbU+r/uqOFofeYI0yzrMcKATCAql
         3VFuCxiUZ7hOGoVZeVQpN+vG7qrHFQWK0ZdCGzG5QYMdah9KPYoKQ4hQdih0M+VAh+Ra
         EppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743471615; x=1744076415;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yvVaeLNnzl4CaH0kZ/bBt05ELoD8WPueO+YtgvCv9g=;
        b=weRpixG8NxvTSdY/bd1DhBeXEUuwtMMoXZgUM78mBN83cEY1tgIDRy2k4s5JVVBZOR
         0ZX4L2pFJqET09peVgw/ivsLOODWLwLdEG2x3VVJziCELTUyuZhuXdFENvRTGvDUcxfb
         9uJSDL/rc5mbwlHMYhnraQLz5AUqgMO/LwusoiZ+qIuQPjLWaLHyR6/KOnc81hCjJK2Y
         g25hPBflVYJVlo0rUuciPfw8+m8CCwwJ2a25DSgCgRCBG504Ri8rUT9S/sBZUwHNzAKU
         W7gbCgWl6UDcyGfgScSDgAR7pkeJBYlD1aW9Bqn/skEUbtqI6w+P1hTQmEtnfA4QOCzh
         fA2A==
X-Forwarded-Encrypted: i=1; AJvYcCUyBLME3caPHiAHMR2A56+5vOLlykMcSMk9Cp1sDGzJbc8kVmhvMCnNeXtHHe51i6j+/RiPCG6K7nd9fUhw@vger.kernel.org, AJvYcCW9S1eS/CPCVtTbEwGMAUFpVhyWhUFjILjCf+dhdCZqnFxEHcL4GIowd5XvzhDQTNhc5YR0XkBHznRXyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFF5VR3njJnv5FTrodVg3THNz4z/FUm1/qg9KVzioqwgDSTNaY
	amJgklEP2xMd28G9ftxXO8DDPk6ugweYIi2mxScb/PzDscDmVxhB
X-Gm-Gg: ASbGnctAAMJUepdb3nQAzyO2R6Dm9KiBYPoBEL3cfi35OG6e19gMUuOXj9STVLFcAsw
	VXPGMRHDH3hAxCRSWLGyyazmsNnauNUFbej30kDoVTP7bv351Nltf9JX1Po3NdgTiI51TNk8l5Y
	ffxyfOuAd+vr0jjhoKSKwh6M4L2r72nmT/pM1qw5vyOU1J9dr/PmPyAPxIKi/XgITb/ptRuR5aY
	AgwdWZMNc7GYlhtTBQiCr2fQ8BMoX6ktcbBtlEev7B8XxavzsJIX/+pj9HzjFdpDhDxgAHgIFm8
	aMfJqAWKmiNikQA5+zMXNF6dmKpAFwdf42j7SfhtSRHa9aLOahdncpKDVsiZlVxrrY6CKJJru/A
	S
X-Google-Smtp-Source: AGHT+IETpkoeDHGWHjvibfEQoZfm1mFJCBzs0UJc3sbI5za/Db8R1xcGPQcEpCpAZVcim3KgcrM1GA==
X-Received: by 2002:a05:6000:1a8e:b0:391:3915:cfea with SMTP id ffacd0b85a97d-39c121139b7mr9382454f8f.38.1743471615191;
        Mon, 31 Mar 2025 18:40:15 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b6588d0sm12554125f8f.7.2025.03.31.18.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 18:40:14 -0700 (PDT)
Message-ID: <67eb43fe.df0a0220.385bb.dece@mx.google.com>
X-Google-Original-Message-ID: <Z-tD-VOLwR7Vd2Yx@Ansuel-XPS.>
Date: Tue, 1 Apr 2025 03:40:09 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
	Douglas Anderson <dianders@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Riyan Dhiman <riyandhiman14@gmail.com>,
	Konstantin Khlebnikov <koct9i@gmail.com>,
	Li Lingfeng <lilingfeng3@huawei.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] block: partitions: of: assign Device Tree node to
 partition
References: <8cfbf225bcda906df0c89dd18ba07ecfa17123c2.1741107851.git.daniel@makrotopia.org>
 <c0b234511303c2efbbff336ed4d5bb993b54f16b.1741107851.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0b234511303c2efbbff336ed4d5bb993b54f16b.1741107851.git.daniel@makrotopia.org>

On Tue, Mar 04, 2025 at 05:06:17PM +0000, Daniel Golle wrote:
> Assign partition of_node so other drivers are able to identify a
> partition by its Device Tree node.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Christian Marangi <ansuelsmth@gmail.com>

-- 
	Ansuel
