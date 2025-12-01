Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8F043147
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 02:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764557439; cv=none; b=M8jpNDY/FsJLOWfSeu59isrZmuepUwjgkscTT9WIxPRM3wEgWtiSvn4ILfotg05uU+9a12wpHYwan6ASeLhNUR/1uuyQyCdugYUB9TMsnOSAtY/VuRr3bQS6JE40ZZShA7C4PvU1EfxVPb9JQhaPmWnRAkhp2LJNBQOwnhpFerM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764557439; c=relaxed/simple;
	bh=McahQMX4npFaztqn+I6uavKzDZJGL5e4QOv1p6qUxKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nUYvmxfefdym0D9nERHGbOPO8CbytcOARSup1mcVJiOi0NkNLbgiY0Oc5rix5luT/Aq63Lb/fzNli7sVCEh6SBVPZmeFfkhabU7L3762S9lq95IUVXTDNVe/zbfUjWSnGVNk3Ex664RDnPP9R16FMF441UeSg0VcDiMCHDFsv4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jFfL8auS; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jFfL8auS"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-4331709968fso17992765ab.2
        for <linux-block@vger.kernel.org>; Sun, 30 Nov 2025 18:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764557436; x=1765162236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9+/1o+9VIMQkz7uLQx3rrNKYhBslArlEWQEAso4I+Lk=;
        b=jFfL8auS9cSVJfT/bjTXjWY5XWlIJPcbFJKEHjANuQcYqUUW8rHqa450lPuznaMKwS
         rpy7BkeZlpQda/JHErNUCSbR/N3S2gJC/PqgxRsVq63S/2BfvCPUOs2Rv3286z6fpthZ
         FvcorUwojEpU5gMRA6s/SNdYUrBcoZMx88+Fuz4oPPBarVM6SE3yK5+6WVj6enw+PoMl
         wqzPsRREqmUhYGtcj0vrYnNN/Q96Mihk+/mcrK5BAcpxhvNTCK802nC7H0sEmDl9GHuw
         Ll2eX+UUPQTP9R2RuCGNqceePp0Gwkpx+KSmLNzR2tJl+yeIdI7AyTpjfgsi/ZqXTBTy
         CbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764557436; x=1765162236;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+/1o+9VIMQkz7uLQx3rrNKYhBslArlEWQEAso4I+Lk=;
        b=FwaFIVITDKlD5Lf6HehJ8jO9nOg40UqAY5orLBUXEGiJ+zNDlkozNEk8gSfexhP2Jm
         o0TCZ5YzBOh17QhSDURJ4KVpav7Onu99tegNfNqhXgkBOAa4ZbnoolL6jfUtB/G3GCKx
         W0z+5dMP/vAPDxvC+9NJiaiRvvB3VibO1wd1I7IEB4gRAdPEXBVKygrNRkQclfcvTYDH
         Tg1lzbPoyb8KM/TIjhehkGMSatd4HUe4Iry8drJqaWPQlGHgo3cUCk48tKdRtVHB7Dih
         AeuNmCQ0Ejn4RcFvZFIWH+VPTAJXOaaHcCQqQvyU27CCJH2S0oxWx0Y9bjcBGNTB9A+D
         K9/g==
X-Forwarded-Encrypted: i=1; AJvYcCVhrnGLY6GBzcdlWIhxy0XOfKvDEjETCC8T36dUJ0GnxfWbq4uX8qGvCAregAglxyDJKWt64QGfAID6Ww==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjrO74xaqY9QDgcRW7DcI2aV/hEtOLeanwMUC40rFqW9WspBc3
	CYwfBBbqZHhNDD3FlmmyTuWP9RKWr2t5ODVVn50dOsqRta4jodTIcK9dbvXqL0ZEcbE=
X-Gm-Gg: ASbGnctxhJfjf4U3ISP2DVWytZrg+7ZW0SKRf8Wy/44eYEyQY9FaMTVRwu1xVypyA7q
	xyHzdgkGDaUG736pxHT26VYPXfTfV/OaA+KxSOrGw5lORKfUz7noJqXXTktOzd18TGaT5uGIVjh
	LAmEQPt1SMEJroQHMGc/vCq6mFZum4Q1dq8ws2fqkfFW3xyL4eTWBxnv/JCjH+Dy0ByMw/dUkmu
	GolQpqOC1Zm+aRL/6l3lH9EewlTXDEAZBO3W+Js1xmRzuHrpxfLV52L3V+4fby2mWUKDhRtC1/k
	xZvHWHistaYvROnbQfdXmW0w9cKIPn0bSZP0zGE1fJNtJ0B5Ez70PlZDp8h+UzJrNXmBF1HDbd3
	QRq1TjLXnuzUOGAMfI0bnIyHjrUwy38RTmo+ap4z9BTeHOQzdmG+9XIszpDDupBNJGW63hdkgO7
	JUMwg25TTO
X-Google-Smtp-Source: AGHT+IERTo1jrLZ06qBryle/a1O2Lf9QepMt3lraKHUarGFdKcdPhN8siNqlrIDujVyGAYjAU4BM7A==
X-Received: by 2002:a05:6e02:2787:b0:433:7a94:6fcc with SMTP id e9e14a558f8ab-435b8c17ffamr308574535ab.2.1764557436053;
        Sun, 30 Nov 2025 18:50:36 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-436b85c5193sm59530935ab.25.2025.11.30.18.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 18:50:35 -0800 (PST)
Message-ID: <c79547eb-bbc5-41cc-8fa0-fe7ec951c988@kernel.dk>
Date: Sun, 30 Nov 2025 19:50:33 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] nvme: Convert tag_list mutex to rwsemaphore to
 avoid deadlock
To: Hillf Danton <hdanton@sina.com>,
 Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251117202414.4071380-1-mkhalfella@purestorage.com>
 <20251117202414.4071380-2-mkhalfella@purestorage.com>
 <aSPYT6JuQLCE3E7K@fedora> <20251201013625.9583-1-hdanton@sina.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20251201013625.9583-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hillf, if you have nothing constructive to add, please just keep quiet.

-- 
Jens Axboe
