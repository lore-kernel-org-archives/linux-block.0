Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5051519BF
	for <linux-block@vger.kernel.org>; Fri,  6 Jun 2025 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749222195; cv=none; b=ox6LKlj6Rg1Df+ROb0KglFXoZGlZ1pKER5TzjIWzlRLnRrlrySc88H6usAkfDQfrhIuo7rxZPqoxdIaxj5ldeZ83g4GS8fRB7gEJRCDsNNpRbmGh4qJbCf13lqU6vvwzR8NBi9g5MP47oL0tAaNLyYtjpCQ6IfpntswzNU34UQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749222195; c=relaxed/simple;
	bh=CkxnE84JhrY/kzEJTGBRDVX8IOdCdtxdRN7Eqo66oRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kUCLMuRPfbHlIPpLfcUvXSzjEZ1tm+1S6GH7Venf/O1+pZxADNcHe5UBtlIDEP95LiJWvgcJLnzYhMe4vDv09kPDT+twhTpZB/rqjGqWMJmyHNKTHtVZfivZ9D4wA9+2mr9P96eVKO39vALvasyKEXbblUB6+CeYa2WDfQW8ucY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=M6+7gjLu; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="M6+7gjLu"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-86d0c598433so67357039f.3
        for <linux-block@vger.kernel.org>; Fri, 06 Jun 2025 08:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749222192; x=1749826992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2HMsxKFr+iI0d6Tud/iM7k4FKDD8Q3Y7uGH7YipaKVY=;
        b=M6+7gjLuKuD8TrZb4RbYemEM9+BaS/WKzxrUONFJNVMhWMum+SWYkRJo4vFOqR3s0f
         in7Z3yUqP4H7eZcR8REVUIktGUmiKCJ/65eSNIc9TAniasl68VMldvdBZUWPkagiz7Xo
         hYijEle9/2UXamFCI8toQkXS35B7kkAygRhQFQQ0fj0Gj0Sb7Cqi3CQZpg90qSESZghW
         NnEwfFNsfhAG6Rcdr83SXlZE0aG/7EOHLOO7XdJ5S/PVweSSsG19DGtWLMoHdEyBiTJr
         xVT2d+FfzrDdq0F8r+F6RwvOK7GeIPB3KVv2PqyqbeAdpej/MgB1aQyW0h1q3jRzObiE
         mM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749222192; x=1749826992;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2HMsxKFr+iI0d6Tud/iM7k4FKDD8Q3Y7uGH7YipaKVY=;
        b=CpfDttSsJRYYGqM65JIg1gwdp4GGv02FfFXxfl5u/5ejPjHCOH67HQ6btou1djd+D/
         8V9SBiRgaWr0hLjRmqIR3URiaX6wOsYavW4WXZLjbZRSlc0sDxGL1vc/iTu7w/+e0GpC
         R1aPAdH254UaQ9uePzJEkrn1iqe3QJo9AlH6K/BfD0qyDcDA2XrT+O5kQBTmlZlL079T
         ggnuBD2N91DZgNXdrz3LxPtAWvPDXDOeoXxBe3Z16SVStaGmKm8CA8TRuYdyilOfLLdm
         4SbbLOkiAJACcRcu1JNWeMRI701ObI7Kigkm/2pG0m1MORtIZwx6Jd2wUGMuomd8uUlM
         Fy2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX93loAIqAtiN7aNdSjGwWsKiAutCSsXsfTJSSbAENlXDO1pq8LA2qG9NPLXbODWC/FJSC1oU9agB/A0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWsNu1SkqLbcSS02wnDHX6k+yQZgvQ76hozLB/1MovcBpH19ey
	kjsou3U44AW7DHcAp6iGbSdX8XvbFA9ahOSQC7HH2OTdgE/nsz1NPzpPuzgIH/tRXDA=
X-Gm-Gg: ASbGncsLTVvQMQe0tl2zGCx0HIohOPOqdYa1HQz7MR34DJrPUII9OkIIB0st+bWn8SA
	/QbBtkKUCQw3Iuzk4JwemXy71rgNk7DglC4GNp/KH+NJueyVxquHkWNAmaFdZylQidzxfesMGto
	HY/QgXaaasyzY2TbIeIiqvHT4n77HbYKoZyCUfT7Env/XlP0gcQtuZj0fnMVx1iJa1BKUGtTtLQ
	8OfVKu48ko7D5zLDoUGa+iWVoPyety6jiwf7DURg9X20APvO5Lz16Bfq1g+ICA3EPNq9iPriUH9
	79Y+LY83x+PTnMFtWfy8EHG3Rzqz1hmQz3O9WXGLeuiRcLA=
X-Google-Smtp-Source: AGHT+IG+WbX8uzWkNgXKj6zpzdEmc3KwbYfTHiHsNcFQomIiNJCU7RpTxEKhImMpphBDhSqMdjEhLw==
X-Received: by 2002:a05:6602:6a8a:b0:85b:538e:1faf with SMTP id ca18e2360f4ac-8733666758fmr457995839f.7.1749222192533;
        Fri, 06 Jun 2025 08:03:12 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-500df41fa3esm493580173.30.2025.06.06.08.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 08:03:12 -0700 (PDT)
Message-ID: <14194a5f-e320-45e0-8f6c-019ce3bd4dbe@kernel.dk>
Date: Fri, 6 Jun 2025 09:03:11 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v6.15 kernel
To: Daniel Wagner <dwagner@suse.de>, Yi Zhang <yi.zhang@redhat.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Tomas Bzatek <tbzatek@redhat.com>
References: <2xsfqvnntjx5iiir7wghhebmnugmpfluv6ef22mghojgk6gilr@mvjscqxroqqk>
 <7cdceac2-ef72-4917-83a2-703f8f93bd64@flourine.local>
 <rcirbjhpzv6ojqc5o33cl3r6l7x72adaqp7k2uf6llgvcg5pfh@qy5ii2yfi2b2>
 <CAHj4cs8SqXUpbT49v29ugG1Q36g5KrGAHtHu6sSjiH19Ct_vJA@mail.gmail.com>
 <38a8ec1a-dbca-43f1-b0fa-79f0361bbc0b@flourine.local>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <38a8ec1a-dbca-43f1-b0fa-79f0361bbc0b@flourine.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/6/25 8:58 AM, Daniel Wagner wrote:
> FWIW, the contributor for the io_uring feature, stated that it improved
> the performance for some workloads. Though, I think the whole
> integration is sub-optimal, as a new io_uring is created/configured for
> each get_log_page call. So only for a large transfers there is going to
> help.

That's crazy... What commit is that?

-- 
Jens Axboe
