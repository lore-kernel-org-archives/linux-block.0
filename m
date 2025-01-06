Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D1C1448DC
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736175250; cv=none; b=WGbTe9hEut3vZMUPsoZm0nvH/ratheGsE9y+QoJa6pFLGrqp2OfPwLfLxFMUhP/4BvP2HFjr9AvNPdVMhlWc4CMGpR7152lXMQOgAnprwMpJyNJ0PMru6rwXU7aQ6yeEOFB6Mxv3dR24kSNeqPLJDtXahInGtV404oMXotOIR2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736175250; c=relaxed/simple;
	bh=kvaOSKkVjzUmmo8j89cHb0SZXb8wXHyD+ZVuTm1ERT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYBPXo/Q8/swcGGBVDwobv0XsOaeSSLl/7k7iQk2TPbT6cs2b6VVpFm2K2iLClm4ZxSCkexs85v0wkE2eHB6k0t0LBDZpBhxeaulbFJ5qfQUfJ1TFWeykr9NLeQRL4xHc/CHktS1WbeNyrqjDpbnbHpzK3FqqfthruaEJ1IWA+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sbT0UtMN; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sbT0UtMN"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-844d555491eso492098639f.0
        for <linux-block@vger.kernel.org>; Mon, 06 Jan 2025 06:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736175247; x=1736780047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U2z9KsDn18F1V7k+iJeMAgiJaCVKeooIHSLCAYIzOnU=;
        b=sbT0UtMNYNDTQW9q+v2FLAlivy9FWI7rVBiq+atLVQO8hqjD2FSnPo4bHRVeUaH3u8
         IMZftNN1j+tAmRNKl5TtUOKJ4ZhZ6W6AFQhprZy0nKP1Bsv+EcJZcmV7dGyZUPTc6pYf
         BEHECVLzVIdXwU2D0di+CylIq+ygyAuJyC9P414tveG+tbxWVKftjhHSWkwWoK0sH9iC
         JoPpw8xScak206UEIv5dwpdYNph4uaGuzBDGjOxdWUttuzyh8IRxIuO7vnI6UD+blsaL
         Zd/SmMYPXnDJhPqMjVpZ/Y/o7FXqJaPnaQbm/3WOMF7+DEAxkhwik9AUfDab9Wf2irbT
         Gp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736175247; x=1736780047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2z9KsDn18F1V7k+iJeMAgiJaCVKeooIHSLCAYIzOnU=;
        b=xRWHq7ei+QtEc/EkqXmYotFmt6qbUIr8eq6MRnzG8oF8/QsVClNu2HXo/FG/8+j+aN
         nzXNf1WiIoKZiIkJrYDTqN7ujKcpv5nW1i8CUKLlhUS2pSWdsOrruedx2h0m7i1n1WZy
         7XWmI/Aw8g9/XBk4+zXEy7qDRPJ/fpVw4/ZDhYNZU+9pRMrofasAh4o1syDuBmWoUQkp
         pkpakRNBnGXt8xggJ6e33vaORsI1FU7Bhxb0oLt6vc5RvNaWJDacAAHaMFQga4R4+0nH
         YhHXI5mlXHxqBD108FHWRwRqGIINkW+2dzmGrSRWSkcSAlW9VVNBiIwI6GvU9qvsCb0e
         wMIg==
X-Forwarded-Encrypted: i=1; AJvYcCXxV72TAN2bPDdCrGXCjamv7pkAFztKW6VkZ9boOy7FfK0zXq0TrBwvKfUtqYOs8j1HjvrPiB80KS9RNw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4TM03CZr4AACRM01RedlGDpUw7w6jYNAVTgcCCnul/Iz4LLoQ
	v31xfG2zDODJkBYpg9M6ywUtnlMYEkLOEx2SwBCQ1YMsAjd+2TZMZDlIBR+bWhEu5tBI2kwunBs
	G
X-Gm-Gg: ASbGncsFAgBdXEBBSQQ1KYRz5ABvgEU0aS4oKcBoIqw3hzsqkV9zl50qlRNp0lGfX+c
	4bxMD4EGt40yaHg8oV2qVEFY+wYfIOoGHUKFZ1MTLnqZLv+BC7GhA/9HbHxZ5Are9WCYhi02pVJ
	+uL++wMZgen89WbEitwZDbuSm4q23DBlHE9jC67ZRikOisfXEJlJKsr6nH323TWu5vJRyKEq/P2
	0TKpPVNsFHU7Smmd5zFoOTyH1Ucu65bT11sGfalwDx9l6794N5T
X-Google-Smtp-Source: AGHT+IHC9NQNkjvrJg9264CCHTHBlhqAe7p+Yq1/H48JbXEcKqIoEDPZxZZtj4YBdfrii+lYGwYtGQ==
X-Received: by 2002:a05:6e02:194a:b0:3a7:7124:bd2b with SMTP id e9e14a558f8ab-3c2d514f8e4mr497256845ab.15.1736175247276;
        Mon, 06 Jan 2025 06:54:07 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3c0debdac82sm97755665ab.22.2025.01.06.06.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 06:54:06 -0800 (PST)
Message-ID: <2f7c9abe-a23f-4b2f-99aa-e6d220c74dd0@kernel.dk>
Date: Mon, 6 Jan 2025 07:54:05 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] New zoned loop block device driver
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20250106142439.216598-1-dlemoal@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250106142439.216598-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/25 7:24 AM, Damien Le Moal wrote:
> The first patch implements the new "zloop" zoned block device driver
> which allows creating zoned block devices using one regular file per
> zone as backing storage.

Couldn't we do this with ublk and keep most of this stuff in userspace
rather than need a whole new loop driver?

-- 
Jens Axboe

