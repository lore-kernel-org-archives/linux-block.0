Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEF22B2D7
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 20:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768249375; cv=none; b=lPdIYT2BYv5RegLYh+nYLldLe31pjIqJoAu8dB29wLsA2KyaXv3JD+Z4hULa2rmSCV48xZoGptl7rxrd3T3FAidd6yIjKJP7dBPUWnzeAbedlQiTE3SxVlPCblLLD03btrL9pplMLeOrPVbGlq+b7ylF5+wOnNhP6i5+ZsgH6hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768249375; c=relaxed/simple;
	bh=VLm0Mq+Xbhw/4KcFwhFW0O10++JM7RrRwqkrv4L1Hc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ovhPFjEoDM84kP9ehixRMmc+kSNqyWvsNGHCCpmOyrA9tJPVhhpMd/BnwoNZ89OGvPQDZVbWsi3Vh56bXMOftIG5YukqqdcEaoHbl+1UGQ6nzrZhVO9cJw2135OpAcCU2xHsganQ3gSXP/ACbaeQAxHZxuL5/Md5vn77RRcjpxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iKMWt/jL; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iKMWt/jL"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4511f736011so3163118b6e.0
        for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 12:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768249369; x=1768854169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IwWB+/fY94QWljmsXRrsjQLvx0GIiS+pb/U2oEVnEX8=;
        b=iKMWt/jL9SyrG4fjKn/e+71xNhlrODAxxIK9P49KqMT8B1PL17KTKTlH6+F7h53ONx
         60id+QaXkl7zfqb06N0WmoVrIW/NSZ5X6yyHqr6dL13L/DKAUSyQdqMOGFxvHr/6247+
         +F4T91ch3dbFEbiCx/W2zyynK33B5LRlCE4sVUwL8zp3w0LZW4osyGqSmSXDU0x3C0Mn
         LwhdwP+ryTUUDYjDVmQuRsj/QrgHgscEDGC5ISakIvw7OJ/60CNQeOIXU50r0PwaZw4S
         oWioaDx1ruh/LcIcpAYb6hz/YKEIcRpUfRFegOYf2ohC4TY9VIjcv7jAAwkJgUF0HEM5
         XHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768249369; x=1768854169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IwWB+/fY94QWljmsXRrsjQLvx0GIiS+pb/U2oEVnEX8=;
        b=IKgB4Qy2W+QcYU1AIyn1hft94CgIgK/q3uTiy6qyHIQ53PEThcQfeLjlnzMsBHIBvE
         PAcRcXpLiVYxIc29MbaqYrcbsni0+DGtInQMFvGmygzhC9i6kOlMQKw1IXDrU7PkzSBd
         dWzQ69S4He1RyOIlCa07ovkMWR7SYz2P3OUrFPYYawzrlEbSWAxln7ckGi0rzd0yZUS+
         GS+gEN/XC8OH7c56vai8DJ7+FAglXHIiEBakT2RkCkf+nVts2jxl5gdwrHulNqjut0up
         A+LemqwyDxxvy1yL9xAx/AC8GPMFN9KaRenuSI+hsNywEv299rOENbppKUDntSzXWZ2E
         zK5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLOghKDXKyvuBY1amZmFAUjtU72J52vxXJSpzqpAydBXnYQRs7NhLFURKZ3joNfUFvxcyg9y2AjVF6SA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8RkI34jQZAdg4CFAcPO0TNnQFGSmvp9sHXQzlaQerBFQfCouW
	6PNILIBg17FwWl6sVdf2Ece2he+Gbi3YkJ9lADVls2+glgFZEU5JcmGqeqNR5nQI+P0=
X-Gm-Gg: AY/fxX5I4WQrP1CblVlcbO1upHw955rtBeqirJPWicEmI15XiN2P32iM6PEI8HUOpwT
	0PETkc4KK31CulBFBu60vIyFN9OFjoqXVVFcgUJNJX2loJDOLA+q34CmeJIkLa2wTYjTkaZ2v+e
	9vjqKX7YQEluzeGpDVNofv7K609+Ak25dXNyO9ELVZe5g5b1CWh4Le6aPj88z/KyEhuGotEUtuU
	Pr++mxlZrUFOS8tvaRC9xUjF+7okgvFkjuUqwMXbDwRdIBSY68onz77AQQfCphHBeyvuOYmmdL2
	VJqA0Sj+JActpAWXgzzMgIBCsSFrXphW4BrNVlPV+A/xWPQQej8gA2uPRpgsx5bDAwe07blv1k9
	/EXhzeajBb5SoY78qerBDyqttWj9ivQAhLm9u9zYgpzTxxZac8kzjs3sNz5EXvfiPn74NcvUvSK
	QStJQn5xI=
X-Received: by 2002:a05:6808:2222:b0:44d:9f05:7159 with SMTP id 5614622812f47-45c6223caa1mr322649b6e.29.1768249369411;
        Mon, 12 Jan 2026 12:22:49 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e183916sm8728075b6e.5.2026.01.12.12.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 12:22:48 -0800 (PST)
Message-ID: <7ac7d7ad-45ec-478d-b37e-ba369b9cc147@kernel.dk>
Date: Mon, 12 Jan 2026 13:22:47 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] block: add a bio_reuse helper
To: Christoph Hellwig <hch@lst.de>, Carlos Maiolino <cem@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Hans Holmberg
 <hans.holmberg@wdc.com>, linux-block@vger.kernel.org,
 linux-xfs@vger.kernel.org
References: <20260106075914.1614368-1-hch@lst.de>
 <20260106075914.1614368-2-hch@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260106075914.1614368-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/26 12:58 AM, Christoph Hellwig wrote:
> Add a helper to allow an existing bio to be resubmitted withtout
> having to re-add the payload.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hans Holmberg <hans.holmberg@wdc.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

