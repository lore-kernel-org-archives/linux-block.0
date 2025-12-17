Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418C232F744
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 23:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766013528; cv=none; b=Pz+U2o0cq9ZL9A+6JPBjs03SUXQ1hAlUlX1YrtzKJwOXHeML6XohPJI4P/bXWJJp/X1a0hL2BvfJvrBbVJimucRZpl+wSzoxQptEaM898NHWaO7SJ09jH5xUGjqaa6nc1A1Xe74IYIYAaGbUM7D146qkUiJqIXTXZq1S8Hdm7lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766013528; c=relaxed/simple;
	bh=C1X5R0T9A6CrUnxpIm/QVXVuRULmzTp597QRk97zyjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OX2bq2e0Cn+5T4JfYY83/QUXoQU0tS86k8eY7YP5kd93XhDiLcqmAzEEYvvkn/oi5VbD0o1WxEj4zgqW3zxCzaNvklOdgH8hdlqbPOUHLNiPgnPpJQDvt62Y+UzznHFEmEfREZVPMvKBBco6pFZQh9aUpJ3cFDJXBTtG2sURikA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBaT4sxa; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBaT4sxa"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-596ba05aaecso29365e87.0
        for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 15:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766013524; x=1766618324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZvc3rVI0di0d/Re6Le5Bvc+vMvJtdhpmIxMnxjb6tA=;
        b=VBaT4sxaHFvfVHw/0PNR0mma9L9CQCE0t1LZsPF9klP2ecyZEgzKiX754iClqRnz0f
         GmmYZH9YBVrmYyy8S74MtCYaKuLLOE2twPEfhgrGbfkH8UXctcxVy2vj9OV5ntO4+YDt
         N24t/STd7wbl7G92s0Ny+GD1Htd8YjaiuuS7DGr+Iv8Q9IUwNUEXilozkJvTMnE86WQu
         MnZ+OnIJvOTufXzIWehEwX5Rn+kCV2O/NoVJ2bWPv2EgbMUdijMRcUlXoqnDdN/RqdV2
         qtSKWp2M81Sd6yvPFFJro9CHX/HMKbmz3BzLch4xdn6FHJrroyI4t4EVNBxfQxTI6t+V
         6rDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766013524; x=1766618324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AZvc3rVI0di0d/Re6Le5Bvc+vMvJtdhpmIxMnxjb6tA=;
        b=mVQLw5QcWAhRysPmTIkHV+TfJkmE6gUbJDhWDVAhZrerf3KfcXBkEcKhT+Z9ZTXdpL
         HEES3fc41jfsFPAPk63oISTFa+2+WNrJUD1UXcCqEYUr7Dt+fnMVFWtitRymA3O4jAtE
         43aMUzAwaMO79FqJBToX8ifoIQRd1mCM/yvLMITQqzo9WZIUSSYjsWom9Rjs/eoa8vZQ
         kIOC4nVfjw107kPpkeuyR1HV+Y7n4ggB8dp3F0VRkO22vnW1S4wzj3COI+hi/il3uoxu
         nc+wMd+ZSKgcg2qfwBvbYjG7zh9jPq346R0OLs37RoDgLR5s73waWJ5S9YO+iOFiFJi6
         ++Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVTLq1QCS+io0yelfU9h7tcuQYpfcVzb9X9QyE85Tm7UXuaUE+5P4pErr6SVeVQVstuTF3cfFm5wFBNyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy/YH6gQI6aHbjxZXT3+x8GEzHYA7IB0Rdtvgo6aovi1m6pmzk
	uOmqPeNNKi80OO734s8Rc1KoPfmJT/jl4EohHV2hBIrxFFSvfNDfdrqo
X-Gm-Gg: AY/fxX64Ko6L6yYHvJeSwXefDfVBsQIZBeWGP0QZF6Ayf1wJgiRG0io7xQ+n2zzHzmt
	EVMavzihhEKbnLHFG6VYz3VMiU1Ychjg9/hJcEY4/PGRiySAezvX1Zs6N9Y/0ZIv+qnL6HnUP7l
	40zdR/oW9hnFhGg+dojBQokqNKDRji6/vYGUzo4YGkdgsV8KbAqn5o5Qydl8Y0u0muDO5CXr535
	p8P60hATLPWuT82w533O2VVDpHJo8Hs1EdNbkfbQx0EY4Zvi8wK7JQl5ok0/2HWC/I1nZLYC61T
	PyzRD/tc73foy6025CZJijMAVA+mt66OGMHNYuWEepr/LiShRySHK98Wx7oJ6Xh0oWR4Nu4JZuW
	JwiFjLysnj0MVEiRDiwY5T6Qu98kqnM2O9d5FkFclrgpHhrjOvphtZ0AfWftwe+k5W1LfgKKw77
	TH+mU6aIla
X-Google-Smtp-Source: AGHT+IFoFgIAi9PMNEfIKCxeozWxswujwd1S6MJvMAmdk00BzJYAqN7Mqo6fE4Jz6OZ88KHyEwKy2w==
X-Received: by 2002:a05:6512:3ba2:b0:598:edd4:d68 with SMTP id 2adb3069b0e04-598faa5a3bamr5789014e87.28.1766013524025;
        Wed, 17 Dec 2025 15:18:44 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-381134b5011sm2807821fa.3.2025.12.17.15.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 15:18:42 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: mpatocka@redhat.com
Cc: Dell.Client.Kernel@dell.com,
	dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-lvm@lists.linux.dev,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	linux-raid@vger.kernel.org,
	lvm-devel@lists.linux.dev,
	pavel@ucw.cz,
	rafael@kernel.org,
	gmazyland@gmail.com
Subject: Re: [RFC PATCH 2/2] swsusp: make it possible to hibernate to device mapper devices
Date: Thu, 18 Dec 2025 02:18:37 +0300
Message-ID: <20251217231837.157443-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <b32d0701-4399-9c5d-ecc8-071162df97a7@redhat.com>
References: <b32d0701-4399-9c5d-ecc8-071162df97a7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mikulas Patocka <mpatocka@redhat.com>:
> Askar Safin requires swap and hibernation on the dm-integrity device mapper
> target because he needs to protect his data.

Hi, Mikulas, Milan and others.

I'm running swap on dm-integrity for 40 days.

It runs mostly without problems.

But yesterday my screen freezed for 4 minutes. And then continued to work
normally.

So, may I ask again a question: is swap on dm-integrity supposed to work
at all? (I. e. swap partition on top of dm-integrity partition on top of
actual disk partition.) (I'm talking about swap here, not about hibernation.)

Mikulas Patocka said here https://lore.kernel.org/all/3f3d871a-6a86-354f-f83d-a871793a4a47@redhat.com/ :

> Encrypted swap file is not supposed to work. It uses the loop device that 
> routes the requests to a filesystem and the filesystem needs to allocate 
> memory to process requests.

> So, this is what happened to you - the machine runs out of memory, it 
> needs to swap out some pages, dm-crypt encrypts the pages and generates 
> write bios, the write bios are directed to the loop device, the loop 
> device directs them to the filesystem, the filesystem attempts to allocate 
> more memory => deadlock.

Does the same apply to dm-integrity?

I. e. is it possible that write to dm-integrity will lead to allocation?

-- 
Askar Safin
