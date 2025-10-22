Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBF13043CE
	for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 08:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120398; cv=none; b=eqV16C4vTRZyfw1wRr7iuAHvS+pfI/r4V0b7oGlG1glfBhEhzxwGjjTOYX8eL2lkymTyj3IpkJU+T4JGNRTp/wT3dAl3UsR7kLXpdf0scDn6ULIPQ9eYOiKta+C0uU3ANa2uhf++RWWNxvYgErkAwhbHOCLE5rZuwtHapd/hd3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120398; c=relaxed/simple;
	bh=eyBdO2wWOgqsPzs2lpBJ9/L31r8e4dCSgvgCYmxIx6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QF+eOX2Te49NTbhe+bUrxh15xCcrcw9zz0TBaOpYtLc0We1fbTwgyZMMzbtK6XysROmX3TQb2h77OuMx1irwc0Q+V1gINak2RkyVgELGfpMr/8min4OlvPdc6siiFMTdfFEgWY6fSSIFThBTeoH8p33iZFcNEBThl+KNRZ2jTTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUx/AVC/; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUx/AVC/"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63b9da57cecso11112151a12.0
        for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 01:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761120394; x=1761725194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toHlnWQqNYbfD0u6quHogsDi3+miz5wiSuRT4/A88gI=;
        b=aUx/AVC/VZbpE2oN97dtsPHXthi3yMi5uzy00pyB+I/2aKpB1pOF2pRPdY6cZntp6p
         +DxMKa9u/iHSxDOYlybze4ivOTbEBXwIlPobhtH9vR+ofclCSVUnFdLZ2x75oKao2T6F
         BzGLltxDdG1BTWxSKuNX4gqbmqd/hSjjIIFVs0n0Ch4mlkoUiC6dBoLKKuDIBPDKTFUi
         kFk5uj7UUBrRa5xQZqggiEu3sdLoHgwuGvH/67ISB2+jrRmwVgOB6jqYyuXpupwhrpaf
         63/jcsA3jGWujqwOZrdyACWvjfRvauXk4GbFXeQNuFeYqpEhKr8/+iUckaeissAGe+rY
         jSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120394; x=1761725194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=toHlnWQqNYbfD0u6quHogsDi3+miz5wiSuRT4/A88gI=;
        b=SbRCSRWi2LrObICT//Qs/LIhHRrPzs8+xQBsfSygRKDkS6PcEM873IpnT2PEASeVij
         KlnG68QRgoW+oD32clVtnGTbb9oIUrbiCldDlKr6u8vLigEnt4FiWB0hN7Df1DrZ5EkX
         P7FwLh0JzWIc10OZG0WS8tXmvSdLcVCerKma5sZqJUwSUYYkOjwGRf1IESstQwF4RU4x
         avy2PvUGn2a57KpDVdyeY59hctmfg/SIs0EVewzS1KF177qowWvX2T5ZC9a4uHSRDuXE
         E/SwC9I2T2DOFMZQtjc5iucG9eMaf0kSPIuw94NxhNsPSNlGwUNdaDew1PkJ3RskmN8m
         75Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXfuuCWxVUfmwC+eUi5Nqkhn3M6AlHP5OsmFYK8SNvcNFCx1Y+h0l/zp0o+/xydwjtVQ2OsxGESlz+/fQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyybCoRqC4FiJYSdHxauWI6c2cDfiuV+AzgIJw5WgYv//FUX2+z
	iqvYSxrogBevX0JoiAo+nXG+v3wUQVE2wKICCwqABDE20i2VwgBVUYbl
X-Gm-Gg: ASbGnctO4h+67HzVmkx4o8h91UUKK9SYp0+x6s9uQzQsRmR+Ytg7M39q2+Uc04l+3RW
	oKre9Vbryq+/ezRlxRMjwbLvbBhxfhUt/36kkCQXZK6Ek9HQZoj8s6H5SomciKVGvAtI5qKWfCq
	G0bp4KT6ar9b9FWqdX0+M1jM/c2R+rM6rKp3O4OPidjMeroghCqpm2VOTLNenoc+hj5kpVl5FQL
	sVGUDnSo1gAVi3VvQU+t16QOEBzkAvBLcqz8Z5dACG+BwNxZpVMqkfG1h6pLVmfuD6sgiA98lzK
	O/oHU710B0wXocsFdM+usF38zAAj2yib7hs7JaL1BPdxxIXUjmxHt8I/SNKkWrMmTzPJSj6tLXB
	zRG7y0Dlu9YmPHhKHxDFKxwKEGGN8rQAlGa057KDWD7gMNKmK6FpZXbIXb0bbX93RyWGgki1iG6
	Ow
X-Google-Smtp-Source: AGHT+IFKMamBOdEkXZztW4+a96FX3cVQPwKK7mU8xvsOl5ZRh1X2aHXQdNoBVmqwPChAhbEjv7M9Xg==
X-Received: by 2002:a05:6402:2791:b0:63e:23c0:c33e with SMTP id 4fb4d7f45d1cf-63e23c0c43amr1116868a12.27.1761120394218;
        Wed, 22 Oct 2025 01:06:34 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-63c4945ef49sm11192106a12.29.2025.10.22.01.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 01:06:33 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: bagasdotme@gmail.com
Cc: akpm@linux-foundation.org,
	andy.shevchenko@gmail.com,
	arnd@arndb.de,
	axboe@kernel.dk,
	bp@alien8.de,
	brauner@kernel.org,
	christophe.leroy@csgroup.eu,
	cyphar@cyphar.com,
	ddiss@suse.de,
	dyoung@redhat.com,
	email2tema@gmail.com,
	graf@amazon.com,
	gregkh@linuxfoundation.org,
	hca@linux.ibm.com,
	hch@lst.de,
	hsiangkao@linux.alibaba.com,
	initramfs@vger.kernel.org,
	jack@suse.cz,
	jrtc27@jrtc27.com,
	julian.stecklina@cyberus-technology.de,
	kees@kernel.org,
	krzk@kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mcgrof@kernel.org,
	monstr@monstr.eu,
	mzxreary@0pointer.de,
	nschichan@freebox.fr,
	patches@lists.linux.dev,
	rob@landley.net,
	safinaskar@gmail.com,
	thomas.weissschuh@linutronix.de,
	thorsten.blum@linux.dev,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3 2/3] initrd: remove deprecated code path (linuxrc)
Date: Wed, 22 Oct 2025 11:06:25 +0300
Message-ID: <20251022080626.24446-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aPg-YF2pcyI-HusN@archie.me>
References: <aPg-YF2pcyI-HusN@archie.me>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bagas Sanjaya <bagasdotme@gmail.com>:
> Do you mean that initrd support will be removed in LTS kernel release of 2026?

I meant September 2026. But okay, if there is v4, then I will change this to
"after LTS release in the end of 2026".

-- 
Askar Safin
