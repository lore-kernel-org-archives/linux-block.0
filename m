Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B342E3384;
	Tue,  1 Apr 2025 01:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743471558; cv=none; b=ShadA0Qv3F43EgwRQqM3WW526W1TP0GHU4464ImikiUs3JB+9guoXtFzzxyiMW87Q26MYql2l6j9RfdRKlcuZpO9sdIu5qj/Ak8E0lnJjl3jaB9fUnefSuIsCaeXGvIevt3q3LMn5mJ4YmDHkh+zI0Xb7qT1ZOD31g/hKENsHpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743471558; c=relaxed/simple;
	bh=jJEbw1Nb/9PgurACrEiw4f2T1+PSQlueI4VqYMNluxM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlzb6MSFPS7Elxc6e8QZk3WULv1bySu39OA525WeY1X/E75DQ9B2Nhail8jwE+gTSq2WOf36pRq5ki7VTzTRfztUV7yv0Yj5x0BwgDDUEoYrpGhkMSsWPsG2D5d5voiVvO9VNHre0Eg4z1+4OE6NfXXbQ4bBCKquXrOcg9n+Jx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xomh9IFL; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xomh9IFL"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39c0dfba946so1941616f8f.3;
        Mon, 31 Mar 2025 18:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743471554; x=1744076354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZlx+oy55uJEPY4Z/JyLhzT1Dr8cDMWctmHXtwFyuxk=;
        b=Xomh9IFLBbOdAlssxnZKEfxkVy+fc/6St4ot9VXCoALQGhM4OHmqC1BzeSOe4nqHx8
         fHfcVnkLrFBqYfdcf6qAEtWBGdDWskK3np0hQCRQTQGrUFIdIcp8w7xMmIZ1TeIKiJmm
         Z1C5MuZqrmfJmI5wE8oK7U6FeYJwz61GQW+d3gAJZ5fMp3mO5CF4ar9ehE6EZlFig4EK
         Q6vS/LKdcEd0kDpkzcc6/FbXsVKuUS6GnJynStSv3EEbr15b70Loik4jyOJxyzLG3ze2
         LI79yvbXByljC8w1XAGY8WPf3HrCZhnuvYJOTkoDYCG3/R9jqpUWgxArF/6aE4Y3TgWW
         9Wlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743471554; x=1744076354;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZlx+oy55uJEPY4Z/JyLhzT1Dr8cDMWctmHXtwFyuxk=;
        b=P+PXx+ByH/EM4H6IA9ObwgEbeBZSzVPEWTZj9vIs48GkOMfLAEz4ufGbgdmI0vGyjz
         RvWS9RyCCM4iOircDC8INCHrRf5YUKvCYJO8uCN7IneDYY34ImqHRh3VaPNeIfJGMRso
         L+UoSth7iy2VdXotbjTEwRjOiuGaWH9De63WX3cVyIUv/0m8QjCw8IsVq5T4Es4bl9gR
         uNI4UwdVy3wn1aAqGb0YnZoey9e1reFBAD8xIh1su9pZ8tvQk6n6afCBPTStuTAci7fb
         hM8I4jVHZB+rY/uGTkTtpSQvQMbzRWS4N1o6r29/WA0p6j32vhx8Ic3eVGPeh+cKPJQx
         4RqA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ/Qbh7hGae6TCLBufil8b37OHOBy3jIBA6IM8/l36MD2PV19lboCLaeifQYviPtM2zJtjoCNWCpMP6QI1@vger.kernel.org, AJvYcCWzgbS/npMUQuo9ENK9oesvH4rzLG7mIvKh0ur4b99qXD5bglUIf01K413w2KE7Hrdvttkcqlk/HKHcTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQquWt7aXWzoZZ4UnuL+WAI4i9gqXVTBtnsOu0+5pAnAM0gGDv
	WmYNte7a1g9ILnC5jj2Ke08jbn5g5OOA13KJjP8V4g5TXZZ96aPo
X-Gm-Gg: ASbGncvybp+CR4Rze1CtbqPWo4w0azIdYjk3oyC47q4x6+Lv4IPf183dt9hwt0RiU2m
	QyDxo0OrfwMJ6UzAkRr1M0YVUk3lwLEjib4DK/Gyl89zqjtg9gI2KjMbbUh2+nqJ3HUSSf1ms5h
	H0YkbtrTelKToaVpguGYh9tknwgLq7ccYTm15TkDMUYKTn6nqXZzpsGd4Yt2ECPCR29EOJkrV7H
	+3ifgJqmT/9GP6djV+D08b+MyxQuEDRmmnLtCsMGfnDdNDm+7bC5DnuijyJJwZ+i+61IEape5Oy
	0tVi/u7C1nmG8kM6Z6Ue3ZSYtoTyrAiPEA2MNpHhIIjaHSaJW3PXggvh/XT9R0nom5HW1n6WH8r
	N
X-Google-Smtp-Source: AGHT+IGxQ4b9OrX31VDjNf1mBUv2DLwWFOTCAm3wocNfaEUdeYICFGDP9tmsD5tTc6fZ/y1jgEjk4g==
X-Received: by 2002:a05:6000:144e:b0:39a:d20b:5c25 with SMTP id ffacd0b85a97d-39c120e34ffmr7997471f8f.26.1743471553696;
        Mon, 31 Mar 2025 18:39:13 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8fba3ed8sm141011235e9.6.2025.03.31.18.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 18:39:13 -0700 (PDT)
Message-ID: <67eb43c1.050a0220.142b98.3224@mx.google.com>
X-Google-Original-Message-ID: <Z-tDvTkRwfBIH-2Q@Ansuel-XPS.>
Date: Tue, 1 Apr 2025 03:39:09 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
	Douglas Anderson <dianders@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Riyan Dhiman <riyandhiman14@gmail.com>,
	Konstantin Khlebnikov <koct9i@gmail.com>,
	Li Lingfeng <lilingfeng3@huawei.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] block: allow setting partition of_node
References: <8cfbf225bcda906df0c89dd18ba07ecfa17123c2.1741107851.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cfbf225bcda906df0c89dd18ba07ecfa17123c2.1741107851.git.daniel@makrotopia.org>

On Tue, Mar 04, 2025 at 05:06:01PM +0000, Daniel Golle wrote:
> Allow partition parsers to set the Device Tree node for a partition by
> introducing of_put_partition() and extending struct parsed_partitions
> accordingly.
> 
> As the partition information is preallocated independently of the actual
> number of partitions the additional pointer takes about 2 kiB of allocated
> memory which is worth avoiding in case CONFIG_OF is not set. This is
> achieved by only adding the corresponding field to the struct in case
> CONFIG_OF is set using #ifdef'ery.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

I also think ifdef for OF is a necessity in this case to prevent the struct
size to explode.

Reviewed-by: Christian Marangi <ansuelsmth@gmail.com>

-- 
	Ansuel
