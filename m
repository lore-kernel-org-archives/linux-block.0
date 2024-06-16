Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91440A20
	for <linux-block@vger.kernel.org>; Sun, 16 Jun 2024 02:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718505578; cv=none; b=l5zcL9aT5Yx/mpwMsVZ2vVfFaF49iGbhSUk6GH6RI7Awaeeu9bcuFWxD3Y1dhYKO9Awm6MYP6M9FL1GZvnHntYzHHdpMtSkRd/bEOmRPlLQHbSeQI3+8sI4kLn+D9pvA7yQDSN8UPVjqSh+atXa4H0wkM4J6dFJT5LlHgxbrMV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718505578; c=relaxed/simple;
	bh=YLtvi3cgRMfavP99RYY/804HpNpXhAHiewJbQFScSjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INyuLWHo+YuJvVNU+hThqmhKJUEww/a3nHQblL+RcEfVMPeQ/bhER23HAejucYW46PtwfjDfSe6qFPJNQaH0Lti2BuWsOmPEXMOzHTJ3RJiwqV63SuJtx6Z0a2BaX0LHf8AAP+gb4OscqOZFGnfLAHJsRrIjdS8UyA9mYNp09+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lf7FKzDj; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lf7FKzDj"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c2d2534c51so623846a91.3
        for <linux-block@vger.kernel.org>; Sat, 15 Jun 2024 19:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718505574; x=1719110374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yRzT6d/9o8NxOpmdEJ+roA8awtUjpg7JSQcSyhSnRw8=;
        b=lf7FKzDjgrSatnstO7iDR83w7JCminUu7r1HxF9WfEj9rREbVlYcYf/16bOD2cLYsw
         pAcgUBB38ZUGnUIIBXxyiDwnUtt5DG1/7md+ecBXSgem1LjYfGYHULEr/gKV1/0DfeNk
         j5AGhvhzUOUQTk530MxBkb4SOEfk2ggH+L/YBTMBd7w6YXJmz+tvAQGHRgmldQvtTEjh
         CwiT3OwS54xqbnSX7d10NcmKFHxYnfVXXVgk1D1CtUFTU5rSp5ikqnoirnA0R/gtCjUl
         /D4kTQwRHeSArzxNnVkcrbbU9NP8Dtb6D9MC5vyBLNlRHV4bQG9PAy4rgAu1S4K/ZRoi
         4S/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718505574; x=1719110374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRzT6d/9o8NxOpmdEJ+roA8awtUjpg7JSQcSyhSnRw8=;
        b=ZMyfaz2bTBQeXQBSs9vOYwgdTSDTxh24pkDzpOUMo3cWjAi5+m1JMAo3XISA7UR7Bu
         DkEZyyi+ToJJGj+DAVh77Ye3TSoxrqWY9zxF7EYdsTC0x+F9fkcQtw8qAIg3r6yabaft
         Bgyb4QYkSrJthoFv6cUz0757Whh+c13gbo1rXp51Y/V3pXp0x9bzJR21p336NbSkfxQr
         vRALYefsKPA2bV+G5wVvzx1hiU3ggp5XJwPElmkj/d6pa6qGWwivPxHo1GKsTEd7eKeg
         jqKbYSaNLvzx1HR4NWUpupOqqYFY2Pt09RV3ZV2rngUn4nGG10rql/vYaepvZ+X2Uo0Y
         bXZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEI2WtUslxclJMR40uBkOvLX7Ad5B013wo6SeQjaGOWsalUL92Rz6hM8f2ZmZMNrxW3LVU13B7/WY1CbP1xrlFfH0ImXufHLIWpt0=
X-Gm-Message-State: AOJu0Yw7X69bADku3gbubvVRRCEZ3gPO4zZ/8b6BH+YMpnB5StPaH+0v
	CHEltOYkKVH6nP3saz3Sr+peN1I3l+/WWKLp5ZoEgnZz+bl2UZEZeuW4ogi1vX8=
X-Google-Smtp-Source: AGHT+IEvDsJB7TktA53hqRSMvUKa578kd46EEBYJWKXK1pbkfy8WV3h3HK01JNi2yy/ww8NPpJZPMw==
X-Received: by 2002:a17:902:eccc:b0:1f7:1a37:d0b5 with SMTP id d9443c01a7336-1f862c30f6amr75257695ad.4.1718505574638;
        Sat, 15 Jun 2024 19:39:34 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f2fe6dsm56586435ad.257.2024.06.15.19.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jun 2024 19:39:33 -0700 (PDT)
Message-ID: <693af28d-5e25-432b-ab1b-37eb9026c7cd@kernel.dk>
Date: Sat, 15 Jun 2024 20:39:32 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Avoid polling configuration errors
To: Christoph Hellwig <hch@infradead.org>
Cc: hexue <xue01.he@samsung.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CGME20240531091021epcas5p48fdbd6302bec7a91ff66272c600b0dab@epcas5p4.samsung.com>
 <20240531091015.2636025-1-xue01.he@samsung.com>
 <ZlrQCaR6xEaghWdQ@infradead.org>
 <f092f5b5-68c8-4e76-9ea1-f319bcf20444@kernel.dk>
 <Zmqo2iAHlAwANA40@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zmqo2iAHlAwANA40@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/13/24 2:07 AM, Christoph Hellwig wrote:
> On Wed, Jun 12, 2024 at 02:53:27PM -0600, Jens Axboe wrote:
>>> So we need to ensure REQ_POLLED doesn't even get set for any
>>> other I/O.
>>
>> We happily allow polled IO for async polled IO, even if the destination
>> queue isn't polled (or it doesn't exist). This is different than the old
>> sync polled support.
> 
> Yes, and for that to work we can't start returning -EOPNOTSUPP as in
> this patch, as BLK_QC_T_NONE an be cleared for all kinds of reasons.
> 
> So if we want some kind of error handling that people don't even
> bother to poll for devices where it is not supported we need that
> check much earlier (probably in io_uring).

There's just no way we can do that, who knows if you'll run into a
polled queue or not further down the stack.

IMHO there's nothing wrong with the current code. If you do stupid
things (do polled IO without having polled queues), then you get to
collect stupid prizes (potentially excessive CPU usage).

-- 
Jens Axboe

