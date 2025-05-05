Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9768625E476
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746456442; cv=none; b=kYeDNCeZFOBGLvz+mzSlEOHHPJBqZ6yAVEO1e4tf9/m5h9NM8cbzlyaBY5FwUPX1EPhfloUAqz+FsxkES3ITKvqH3+/Ehn3zWE1VhsrNzEHCW9DwK7GMyaIf4i6xdWe9nnF9R33u4eQ/ek8vm03iiNnkV5FbtREX8IRYov/b/14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746456442; c=relaxed/simple;
	bh=RpJVwCDKSnByw8jtUR+cMwoe+OU/wu1hEclu+sJDocE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=VlV4FkZki7NZnLXn9b6neKbJwinRSxgR5PmbAh2SAIzNizmqhhQiob1+gOinQk23E1PnBdBOAlIZZaL5YDM/IH+E6/iOANGrLJBlTJZ8XN5s7AA5EHnSJxXqw6FnHue2iASKaNDiiB/e5UmuRqPy7h8wzvAwqXUeudvXvjJVdw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ganm3R+2; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ganm3R+2"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7406c6dd2b1so1422697b3a.0
        for <linux-block@vger.kernel.org>; Mon, 05 May 2025 07:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746456438; x=1747061238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :reply-to:date:from:to:cc:subject:date:message-id:reply-to;
        bh=APu7gvDG+GWIH3CqaZfGtDjeCKACn6athf5zXmMCeek=;
        b=Ganm3R+2Nr2hPFIMI/w2gj6KXCmoy8uCUxnfBGhPhF53TSJelEVb9M8nJ4gNoIR17g
         ZFs8hOxGbyMnKdTnTsNBPUVa+ItzG+bDUbX0fpZwgWSb8HjuDbLEuhGHt/IanPCGaCyl
         CkKDZ3CnB8LUxlz0NWDMUpRcrMDi4F7/iNk8WUMiuQ9HjIvPBzMrhq/DpD4CcTQEjMcj
         AtqgdrURqH2V+fzVpYOSA32RUAYcwIfbLml1fGVtv3oeOcQpOi4aXyTDF8V3FWLU91K6
         FMzyKUjl0yiK42rLPR8fDX53wWjQYmYqAuVwsmbkB2RrkRWRE9sZl0Z2VNjbqKLzfqks
         mCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746456438; x=1747061238;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :reply-to:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=APu7gvDG+GWIH3CqaZfGtDjeCKACn6athf5zXmMCeek=;
        b=ArvJi8kZB/tb2WEVpT7Qq8MnH7DenDcAe4tjqAkQPZ6VUGtxXc04FBaE2l0+FKBEsp
         1IieV8oJMQjpZMxjATmCoWL0Up5M0bsf6aYCs6uhA9WDPUSCxBW6j96Ajz8TJ1DF3n7j
         ZMx4WAdydheBwZljy3s3EZ61VQYmmxcswbeY6FSp/xk0Ou7/Vads5g4ZD0eO5HX6EP7D
         opIeGP4BL6eRU1lzBQJPpz4v9eCVXyhVfg76bcW79a1a0eMh2OzTlQL4hyeqIJch7WIm
         9XoCAlWQIO+UrWN48QsTUj2YhORrnYzZKzBS+PP5xR+81kiilfINhHTP1PwbCohJm4Me
         +RZw==
X-Gm-Message-State: AOJu0YzNJZarEclPlSesVdOk9VCcCjsz9hFZ50ER5q5PdLicco2C6+yT
	GJJHiT41Avkq1Wf3v2xG6lyzZDk6rrsPata04VLDPXv3XV/dEGmQV/5L7VRSEFo82w==
X-Gm-Gg: ASbGncvCHAfHrCc0RxWJzha+UEj6qz+ieP7zI/kO9incNaPufsB6ukuBDdrd2ushZ6u
	ecTUGc1dDUCfmKizutD4pNPq/ZUX9IEENwJ3OgSWcnOzfqowSUdBpWIhRl8ErpJm14H3dIZz6AO
	4CKhrqjhY98rklH+mFgTmaHd4E8ZSLlhalRYZFOWBepwIbyyN5OHjUHPDgBHHB/kKXuNPketSgB
	Volvb1IfDpyhv+0dMLDRiB1SuUXU3oUtXA5+bfgnxHOjDbWGdtrMNbWl8nvsv6gIiV8wcvwxW7a
	8+UlACwPGWEUY+B8SBYDcAD0eM7V4JjjuIDnngSoauDQQCA9Nzxb8V+s/l2KNTP7bTi3JHKxQal
	9wbqtGZPcJDrCDzrO
X-Google-Smtp-Source: AGHT+IGmwIoMCVjjOdyycckkqKCzT96NURw/m2pEIo0md9NLtdzh6/isYyaKSad5QLZYxTgG2vs03A==
X-Received: by 2002:a05:6a20:438e:b0:1f3:20be:c18a with SMTP id adf61e73a8af0-20ccc24c1b0mr18449726637.10.1746456438240;
        Mon, 05 May 2025 07:47:18 -0700 (PDT)
Received: from 179-190-173-23.cable.cabotelecom.com.br ([179.190.173.23])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fb3925875sm5688672a12.1.2025.05.05.07.47.16
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 07:47:17 -0700 (PDT)
Date: Mon, 05 May 2025 07:47:17 -0700 (PDT)
X-Google-Original-Date: 5 May 2025 09:47:14 -0500
Reply-To: sales1@theleadingone.net
From: Winston Taylor <sglvlinks@gmail.com>
To: linux-block@vger.kernel.org
Subject: wts
Message-ID: <20250505094713.E291C6602BE3D6F2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello ,

 These are available for sale. If you=E2=80=99re interested in purchasing=
=20
these, please email me

 960GB SSD SATA 600 pcs/18 USD

S/N MTFDDAK960TDS-1AW1ZABDB

Brand New C9200L-48T-4X-E  $1,200 EAC
Brand New ST8000NM017B  $70 EA

Brand New ST20000NM007D
QTY 86  $100 EACH
Brand New ST4000NM000A   $30 EA
Brand New WD80EFPX   $60 EA
 Brand New WD101PURZ    $70 EA

Intel Xeon Gold 5418Y Processors

QTY $70 each



CPU  4416+   200pcs/$500

CPU  5418Y    222pcs/$700

 

8TB 7.2K RPM SATA
6Gbps 512   2500pcs/$70


960GB SSD SATA   600pcs/$30
serial number MTFDDAK960TDS-1AW1ZABDB


SK Hynix 48GB 2RX8 PC5 56008 REO_1010-XT
PH HMCGY8MG8RB227N AA
QTY 239 $50 EACH


SAMSUNG 64GB 4DRX4 PC4-2666V-LD2-12-MAO
M386A8K40BM2-CTD60 S
QTY 320 $42 each


Ipad pro 129 2021 MI 5th Gen 256 WiFi + Cellular
quantity 24 $200 EACH

=20
Ipad pro 12.9 2022 m2 6th Gen 128 WiFi + Cellular
quantity - 44 $250 EAC

Brand New NVIDIA GeForce RTX 4090 Founders
Edition 24GB - QTY: 56 - $700 each

 Brand New ASUS TUF Gaming GeForce RTX 4090 OC
 24GB GDDR6X Graphics Card
 QTY87 $1000 each
=20
Refurbished MacBook Pro with Touch Bar 13 inches
MacBook Pro 2018 i5 8GB 256gb quantity $ 200 EACH
MacBook Pro 2019 i5 8GB 256gb Quantity $ 200
MacBook Pro 2020 i5 8gb 256gb Quantity $200
MacBook Pro 2022 i5 m2 8gb 256gb quantity $250 EACH

 

Refurbished Apple iPhone 14 Pro Max - 256 GB
quantity-10 $35O EACH

Refurbished Apple iPhone 13 Pro Max has
quantity-22 $300 EACH


Apple MacBook Pro 14-inch with M3 Pro chip, 512GB SSD (Space=20
Black)[2023
QTY50
USD 280


Apple MacBook Air 15" (2023) MQKR3LL/A M2 8GB 256GB
QTY25
USD 300 EACH


HP EliteBook 840 G7 i7-10610U 16GB RAM 512GB
SSD Windows 11 Pro TOUCH Screen
QTY 237 USD 100 each


 Best Regards,

300 Laird St, Wilkes-Barre, PA 18702, USA
Mobile: +1 570-890-5512
Email: sales1@theleadingone.net
www.theleadingone.net

