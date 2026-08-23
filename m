Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF78318DB01
	for <linux-block@vger.kernel.org>; Sun, 23 Aug 2026 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787476199; cv=none; b=IiV9WBWU4txGuim2EZYoBXjlXdva/W4OMTeo3CkCunWscqjYtQdO230+VC05Oh6RyNDUsECMWguS/cWp8DAPaqV3+AXlpR3TPgFok2hK4Y/AEfg5P5/ZpkFawaU9GYXj1OWUWpm+bqOVIwOrZNz2etohY/5yomgbrxYEajPwn9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787476199; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MCEs02jQU11Xm+a1g6zw6gmtyUg8Pc9LtROQhOzuNmzUuaNH5Y8dVWNUUfP1Ki5pRGzoPb0efU4vrZ0AoUlv4cS3F6bFdY0xfLwM18nHkV2HVLzYu41lyvGBn9maWI9SHuMZ8MVqwmpDkYNd0QD/CF8ISEa7IwPdrcSB1KLoMaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a3efa2b38aso4565409a12.2
        for <linux-block@vger.kernel.org>; Sun, 23 Aug 2026 02:09:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787476194; x=1788080994;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=AHk7JyC/LaTnv7Y7DeH+D7yi6FCrKKPuJREGz5jtZ+tYBXLZ60q4BChDJ8+4Avouzs
         9yf+TUWi50LP4kepozYBew9ZeF3+/JNQhb1E7HIENA7FNmeP56/V+ERmCuoGyOG8kdeY
         KaOVAElN/CiTZsDyAnDbN33rpmlmhWKD1vhbIDxBq6as6qm1ayRWAjbsgh05P+RDtZCW
         546+JSrqAkXFqEjcbbhbmWZtwA/YDoi+1tL9SR2IVJOOVG0dW0sBXJGN2+dVd+dHWXF1
         p9eIgMKM+BwFStT8l9zh9v2TORUyIRyHqC2IoDjgaqpuiGXGReR03rcv3uP0YIU6n/qh
         Fsgw==
X-Forwarded-Encrypted: i=1; AHgh+Rq+jH7z7rZQHPSFRSlup9z5hsY5OW0q8uPHhlE5xDn9IbYlHhWzMYevY5i2ifec6LboukLP1crjln7NyQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lqwpQGXBdvxb0Iffmdotiv6knRhTbGbJ80BKbDH1ycQm80QjTw
	Y/Lq4E4feHDWm46D7uroB8RYw2A3pZTYCxSOfXdRuwoNlKGEXFjvCUS+
X-Gm-Gg: AR+sD13MO8hKoZfwHeSfJeruJPTjQQEWZpBdEtAY2DNEd1NieV0zzhYRJoIhiuK/pZh
	G2Lv4V12qh95vCf+qqSDrPRWQ1fTb8UO8CsxXnJoLTb+pCvQuleoYSFqgCJ1/NTW3PGALQXoDWk
	Y48Ri9kPCIHQYxpDjRlAsd7VXRs+jfZONCpq0DeKdJjKgxrk2+TeJKKH614wDCfhBaox1TNsglK
	V9ItAhDiBTuGtSaPONkoK1ID307NeDolIAKFviSSDgGZ7hs+TKqXYPok9IZKQTefhjampxTUZMN
	1zzFztTNkYj6TuDh7qYsE1F5ruRm4jf0TvSC6G9a6aaq7S1Kk1cBTFJSfqV48JWyof7PMCOY5o+
	xnqnPrP/8sg7Bphfq68OtfDWMud84fWhvz2IG3YoJHS0GgAh4QbWFPJvSIGxaoVhb8YPIw6aFZs
	/1e+UJYuLZanAwk8PE9ygIdm9lqkZDlA8x4ClxE7vrUynMTFQWotRGU3vXGzyyq4396cDgd4mLX
	Fdl3kdBb3vdIwAZbiA0fyvItZMBjQ==
X-Received: by 2002:a05:6402:444a:b0:698:351c:979c with SMTP id 4fb4d7f45d1cf-6a42f16f016mr22623575a12.2.1787476194451;
        Sun, 23 Aug 2026 02:09:54 -0700 (PDT)
Received: from [10.50.4.207] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e2d8ae9sm2326174a12.28.2026.08.23.02.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2026 02:09:53 -0700 (PDT)
Message-ID: <4daf6da6-e01a-4120-a9b8-d666fc67e21d@grimberg.me>
Date: Sun, 23 Aug 2026 12:09:52 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/5] blk-mq: fix status for unaligned bio
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk, hch@lst.de, tom.leiming@gmail.com, coshi036@gmail.com,
 Igor.Achkinazi@dell.com, dlemoal@kernel.org, Keith Busch <kbusch@kernel.org>
References: <20260519172326.3462354-1-kbusch@meta.com>
 <20260519172326.3462354-2-kbusch@meta.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260519172326.3462354-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
