Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448F379DB8
	for <linux-block@vger.kernel.org>; Wed, 31 Jan 2024 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706705003; cv=none; b=SFarSB0xFFUGOdy1PIwPAY1D2BwUldp/NgjNxm6TkNIIutYxpoRJIIFqaDtUmqDT8laPX4qnXSmlAv5IXt8ORWrdY7yR2rhVf9nLxCuCVCF9vbKaeZihvXTG2uZ/sucfpkX5RcGN2kTRT9CGlof0e0/oJD1X7t8pY2MfiEIwP7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706705003; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PGjj7ZC6gjPGgJA11MV7KjDubgMtVLbUHcdiJe/8DiqBuenecWkXvUi7ThQzxO75zdUCW9hcR19zHshMRc+wbjnD2dR6jrRt75N6VGFUpd1MBUHJz5GG4vHNhhnv9TimZPEo7A1+6yb74OZ7SiQrTcFhiU9Mfq2OJUCUp0OwmpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33b025fbf66so156010f8f.1
        for <linux-block@vger.kernel.org>; Wed, 31 Jan 2024 04:43:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706705000; x=1707309800;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=lHT/F91OwELlc3ypVfhoGIieLbT/JBuIc+KjarofrkeyZfjGn3j1cX6D2DH4FJfnQO
         1FR78qEuY7eUxwriaBcUM0Ri19XliKUk8Ke3eTsYJ2W3u5o9wVzy09YTJjynwgZdv2ej
         zZteM5sVmfeORiotQjRkwcfmpGmauf7tM86+pBQ0gkJLY6nQWu0YjrxSe+q/UeYIaaoH
         pTbHycSp13v75YKD7GRSuDWLBl1ErhoE3LyYC+DlA5fjToJ5OZ9oal3bzMv2qSU57vGW
         UT/1CfQSAjvnGqD0aamMQEMlxZaKj1O12yYiZDcNatWzLImDUevZsM3hBrRzrVnyUaMr
         LZug==
X-Gm-Message-State: AOJu0YyW80JvuXbSY0Sqt3nkm9+bGxcC+uLGekOY33W2xhOeAtOnMFy8
	OPmwEG/d4Pge+pmnC7rWtR7oI6Y8hszKg6WGsiGyX1eA4vO2tESr
X-Google-Smtp-Source: AGHT+IERT8de8o826Yt3G9ZFoQkYkXGGwyH3NsMGVT0BS2KEdl/Wgehan7x7SNxj9TjDdaPdACNPnA==
X-Received: by 2002:adf:ab19:0:b0:337:c4c8:92f with SMTP id q25-20020adfab19000000b00337c4c8092fmr1073422wrc.3.1706705000217;
        Wed, 31 Jan 2024 04:43:20 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id d5-20020adffbc5000000b0033aedaea1b2sm7893801wrs.30.2024.01.31.04.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 04:43:19 -0800 (PST)
Message-ID: <82a3f4e7-85b9-4889-a40b-de5e90f950e9@grimberg.me>
Date: Wed, 31 Jan 2024 14:43:18 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block: support PI at non-zero offset within metadata
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, martin.petersen@oracle.com
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 gost.dev@samsung.com, Chinmay Gameti <c.gameti@samsung.com>
References: <20240130171206.4845-1-joshi.k@samsung.com>
 <CGME20240130171927epcas5p2814181a20402d08b96393ce4a5e06e03@epcas5p2.samsung.com>
 <20240130171206.4845-3-joshi.k@samsung.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240130171206.4845-3-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
