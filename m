Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ACC23770D
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887194; cv=none; b=SVQYXXZFemE78HZuv0KuZCemooP5PqYaAgc3wyS9rOplmPiHilwGRmSMi1l3Wj8C8Lacy3PeLddqx+Ru32Boxe9lYn/hobxTboRiJlidOmy0PwXxOTNMqKNViXBtexHiDf6IMSHqEKp7wMXmbSUSNPX/rH7RfWxPT56ZoE37Igc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887194; c=relaxed/simple;
	bh=oLapzg2kmr8ra4GmoxtioxQBLEe8tuDRu4pDXkNj86s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=IgvjoVecjNxej7m13ure/cZ+vVQatRlYjLt7PXwAU3Iy3YjDIENm+8HP53QRTzqwrnUqhN/N9U0rYjpmQE0pw8qgcoH3Z+si+7VGrzKPrUjx6tsSYMYY0bXkxrPBxU0OApMODjm/NO2DCClun3uTk/dabEdL8QbMkcz7M49JwAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Lr2Igzv5; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Lr2Igzv5"
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 290163F29B
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 13:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739887188;
	bh=TFVkVW8mqzZvRa2FQ2uGvuEytv7Dg/puiNRGWYVs8Vg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type;
	b=Lr2Igzv5rW//ZpPmpTs5fv5QaZMpExkorvB9Q7Phdowo/RelQ3+cZkvEnlf6iuDw4
	 BLGlmP4KYx0TQ4g55pVohU4eVnTabYPnaJVgVSK83GTnC7WrE3VdAvbgSwEJYLTFIz
	 hMCai/rQPYZWpuuDKPyS4+v+TmT/ztgvLU0Pk5pyeViQPrwA7SwXdPGoxZ8OoDJWJs
	 bybk0xEQd8qCk2l1Q1to0ee3kM27zxv6Y4b1jd0ZxcL0zF8UfyTNZUB+vks+zaBIs9
	 SmbQBrR/ISQlmRzqDi/NKVaxnqt7ZfdxPDFRxTZ12d4Zx2ID4PQQG/GJrnIB49VbjT
	 +LnXd3FJpwOSQ==
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43933b8d9b1so29372135e9.3
        for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 05:59:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739887187; x=1740491987;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TFVkVW8mqzZvRa2FQ2uGvuEytv7Dg/puiNRGWYVs8Vg=;
        b=iEWa7jPwccSKt/HkFlsu2ndU6iNIyU0vv45xgxyHToj8d0KjA/qoTcq4z15DdvHzuG
         I6YHGmnePMVMZ+DPHybJ4yt2U7RvGEjE+DoeyXPXtCnCdPVSPyPfyIZKtRAdV+8/mMyw
         srQMfCfLm/xhzVmSZAhn2rzySeDfDlw+132Ie73oeVtG1MPGusabZDMVEWGoa+U2g8nI
         ng8kb+arXsYIiSJ5it4sON8HRJlljGpmD4za7V7Dj/BQ38Dhiji2JUgewPx+2FSk/Ubm
         Tt+BgBz3QvJwQOU+20kk4P1g96xDV9YXvZyMwM8P1GEL4B3VV90lsIMQiv1GNK1EAdKa
         yHiA==
X-Forwarded-Encrypted: i=1; AJvYcCWDTLEjwO4dNzhedeF6lqOrTP2395aezU8koVWgLU9bwW7e0kLlmjssPRPLyIu9U64F/RkuYheAVIFC+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQjCZZAA31lzGMh/7UpohK4bnIJQj0QHXermwLpSnW+VXIFCFo
	uTudftqRQDjey9Et/MExxyx5+VAUesJNSmbZvVDojxzj/e4WQKS2od67lo6F83WdawxNPgCI3lN
	Jx5xrgC5zJxjgU2FQSAa6Ujy55ci3KKtN5OU0kaYQchwl7nrWnXyDN3p1W+tXGRT8X8oBFYMIft
	uY4rloeMSc6rM=
X-Gm-Gg: ASbGnctHuYjhkemv2bs6ylbedB3CzUfqMHevyV+gmKtiJjCPVrjmsuuKAVr/Mmx1Xl4
	b9kpAE7611NExnJsNBIKjVg9a0k6v7bZqdrCW97NLZrAiVziksrYs8oo5p9R67T+55No21SJ5t0
	K/PUHwfBU4OpfNfm77RwK9qbqPhJYSsIvdgtD03PpaA7ilYSrQ40X5yi3G2j4NtXpsbO6bwPI/Z
	4JfHTV0JcYrSjNWQZMj8yVefINil3R50rwhWOhHQxUzc7b8PVkdofE9YbQ71LIeO5MR/7VZK2b8
	eoezg9ee6vtuqvquvOBxKij20OrCDQV8rEs/L0Z6QhvV5ujBCuk=
X-Received: by 2002:a05:600c:1c28:b0:439:42c6:f11f with SMTP id 5b1f17b1804b1-4396e6ab033mr122972825e9.4.1739887187459;
        Tue, 18 Feb 2025 05:59:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkuueM4q9zjyh2zOdRzt+GIWkGfCPkA6ywuytmuiaFKbIi3h6FEUwjrGAeEowaXsN5ZS1O9Q==
X-Received: by 2002:a05:600c:1c28:b0:439:42c6:f11f with SMTP id 5b1f17b1804b1-4396e6ab033mr122972595e9.4.1739887187111;
        Tue, 18 Feb 2025 05:59:47 -0800 (PST)
Received: from [192.168.80.20] (51.169.30.93.rev.sfr.net. [93.30.169.51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1b8397sm182603185e9.36.2025.02.18.05.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 05:59:46 -0800 (PST)
Message-ID: <54095d2f-daea-4e4a-9542-f6a2b7603672@canonical.com>
Date: Tue, 18 Feb 2025 14:59:45 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Olivier Gayot <olivier.gayot@canonical.com>
Subject: [PATCH v2 0/1 RESEND] block: fix conversion of GPT partition name to
 7-bit
To: Davidlohr Bueso <dave@stgolabs.net>, Jens Axboe <axboe@kernel.dk>,
 Ming Lei <ming.lei@redhat.com>, Pavel Begunkov <asml.silence@gmail.com>,
 linux-efi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Cc: olivier.gayot@canonical.com, daniel.bungert@canonical.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dear maintainers,

This is a resend of a patch that I originally sent in May 2023.

Resending with an updated list of recipients since the list has been updated.

Original submission:

https://lore.kernel.org/linux-efi/f19a6d8a-c85a-963e-412e-efaa7f520453@canonical.com/T/#t
http://www.uwsg.indiana.edu/hypermail/linux/kernel/2305.2/08638.html

--

While investigating a userspace issue, we noticed that the PARTNAME udev
property for GPT partitions is not always valid ASCII / UTF-8.

The value of the PARTNAME property for GPT partitions is initially set
by the kernel using the utf16_le_to_7bit function.

This function does a very basic conversion from UTF-16 to 7-bit ASCII by
dropping the first byte of each UTF-16 character and replacing the
remaining byte by "!" if it is not printable.

Essentially, it means that characters outside the ASCII range get
"converted" to other characters which are unrelated. Using this function
for data that is presented in userspace feels questionable and using a
proper conversion to UTF-8 would probably be preferable. However, the
patch attached does not attempt to change this design.

The patch attached actually addresses an implementation issue in the
utf16_le_to_7bit function, which causes the output of the function to
not always be valid 7-bit ASCII.

Olivier Gayot (1):
  block: fix conversion of GPT partition name to 7-bit ASCII

 block/partitions/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Thanks,
Olivier
