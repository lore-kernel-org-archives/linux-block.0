Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E47326D57
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113659; cv=none; b=MJ05aWju4OwMxp1OpKqfOc3oA9S9pNM0R/mlP5pnyST/dlYvZRv0hBONDTYp2T8E00h7n7cBcY0aGwWRBa24wL4yiIiL0TTtUPU9pc73ljhcfALQrXtStcnGtBGljdBmlnOwMxnez1kBYXVjlN7NdzJbJJ+K05WT5neR4H/2qx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113659; c=relaxed/simple;
	bh=QWN6U+PG2xBUDbwq+EQBUqhkkWqwegN4Aa9Mx5Hmdac=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JaDH9B6bjPgXwENLQGIxmU8N3Td4uh6hRMTKouoxfrcaF5ob9B42kr/TRsyD7khXY4fT0FJhd81hixC/wbYtMtn3Wd9LsRox+foWjahWRhVYbLwdstDLX0VR5QmZ0shPqrsvHIubk+vzJcv0x+8B8Lo1JuwvbmLrNqmr/jNYZqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AM0pRqO7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iAKW677w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AM0pRqO7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iAKW677w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772113657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QWN6U+PG2xBUDbwq+EQBUqhkkWqwegN4Aa9Mx5Hmdac=;
	b=AM0pRqO7dYjuQJypLFktKkoIHCbvq/qYELHICBVjV17ReqnLuHAfqIioDPufjDRM3jQMu8
	DQ9/u8cXaOhv0FyVamY90yLZvmfZN/8lzPm6LhGfD9gmvRLDL35Ayw7YLRzG7kGv/uWbHZ
	O+iCKecns+EAgElxwT1uP7k5zfEuMzQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-hYZTN-xeNsuIp0dQnsNmeQ-1; Thu, 26 Feb 2026 08:47:35 -0500
X-MC-Unique: hYZTN-xeNsuIp0dQnsNmeQ-1
X-Mimecast-MFC-AGG-ID: hYZTN-xeNsuIp0dQnsNmeQ_1772113655
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4836fbfa35cso5084895e9.1
        for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 05:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772113654; x=1772718454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QWN6U+PG2xBUDbwq+EQBUqhkkWqwegN4Aa9Mx5Hmdac=;
        b=iAKW677wpcR0uHqqUOCNBuuvRqKlcN2X/1bEfdD1Rz4vv9cBGzhp18X3rfQWyzOV6J
         Splj7/xemSauwX2PNR1uXKs0o+XSQiZtUf6VqoOYhASgpMY0sElHdD7MgDwmLTxjYRTc
         LSH1wIIHSGlyQNPBx3ZoTu78mU5s+p71NEv6JhUmg0Pdju1jG5kvESi13sWiGWwisWGf
         tQ7bBh7Gr5Z7lui428la0mnKwSsGQH0TiHS+l0iA+f8w09QqZqdkGqqj1GlwsbShoqSC
         757T+RzDaPDfp0P13Etimp0bScHoTo+9WKFlQ2HZOJtMfCakBZ9t7Fg3Mn1ND3L1emNA
         G58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772113654; x=1772718454;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWN6U+PG2xBUDbwq+EQBUqhkkWqwegN4Aa9Mx5Hmdac=;
        b=Kz48EFJ+8TnDzgPGZDDunn02Yr0G/GQ1HoyCe1hV9BnxPnCUXiTjXihJGlRxI9AqHG
         AJQUPQLq/nFElURqvpOg1Cg/qLG0K6WiCg8Q+g9FTI6A3/ZE3zWZlcB1xT4q/Dfe3Flj
         RTgj3UmRTzHjHK90FwXAG0wXf7qacxyFLb/IkB9ywD3ue0/m0LM1sZ6CWIsr15CwTEZP
         QPLQ18OEcg1jK051lo596v8zkie4sObh7hF6OuCaq2fdrJNGYJttjnmruQ7e3bXYDyje
         2m3L+m0DZvduJab/KWAVcu/Y0+VsauA89NHtvx2jtFuqmX4XWaUuI1s00AAzEXcbKHym
         1Tiw==
X-Gm-Message-State: AOJu0Ywpgjh3l0CNiV0TivcShIqjdqNSYw1FqqNbuFwSpKHLNVRSW5Q6
	EFgLi9KpqRwOXUBlmbuotX7kPQham8icVB/Es7ri6GMdln4ObSoVzzwd8ovggaABgSYhRYdNfRf
	lM6pNGHOgWTm5syyeeWj5zTQI78F29mY2fsbyQu9Lvsa57lwf6hp0sVCgC3/nUPxB0lSdOnfDVn
	pSajRC5lsWrxHsV0zldNskv+Ws3eskhqiZfnhTOBNo0RYzAw==
X-Gm-Gg: ATEYQzx2e7iAth1gCWum6U/ZVOVJ7bejNSZqROJIHv39tgGfIczW5ku0IY1CKvWGOI4
	aL6dfzIUG+tNFQYdme0i2HwLcbf7on6Q1mmA7y464vCyRLgfVNmVKSURW7+GAwz2iSM9ESTrG6e
	WZ8yJFgJuCATFTsbja2OXYNVQRs2ssGBkI2d1J+A5HBIcQSrYeRJi1WsKmYYn5xIm/3P9QxQWzw
	/HFTQJugzpgER9yjwrZmAbJK+bT+RPtLwnNQ9b3pyQgWtRzhbdyVgmLsMM8Se103VIB3V4hyO4T
	zLVNbYVcWtU2ui+i58G4QKjOtduSaLulR0jcB80rfLArd3fUC9x40yL7qN0rKOl0J4e+9fJijFC
	/GS8uCWizMfE=
X-Received: by 2002:a05:600c:1d0e:b0:483:78c7:e1c1 with SMTP id 5b1f17b1804b1-483a95bd940mr341977115e9.12.1772113654188;
        Thu, 26 Feb 2026 05:47:34 -0800 (PST)
X-Received: by 2002:a05:600c:1d0e:b0:483:78c7:e1c1 with SMTP id 5b1f17b1804b1-483a95bd940mr341976635e9.12.1772113653678;
        Thu, 26 Feb 2026 05:47:33 -0800 (PST)
Received: from [10.43.17.192] ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfcbf016sm58872325e9.5.2026.02.26.05.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 05:47:33 -0800 (PST)
Message-ID: <5d95944b-b54f-45ce-8512-1e6c3438c404@redhat.com>
Date: Thu, 26 Feb 2026 14:47:29 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ondrej Kozina <okozina@redhat.com>
Subject: Re: [PATCH v3 0/9] Extend Single User Mode (SUM) support in sed-opal.
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk
References: <20260205150935.238137-1-okozina@redhat.com>
 <20260206141804.278721-1-okozina@redhat.com>
Content-Language: en-US
Autocrypt: addr=okozina@redhat.com; keydata=
 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
In-Reply-To: <20260206141804.278721-1-okozina@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

a gentle ping: is there anything I can improve on in the patch set?

With kind regards
O.

