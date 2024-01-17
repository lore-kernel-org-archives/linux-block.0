Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E7924B25
	for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705522665; cv=none; b=TEQI0BVmTZnD/V3Ul1Zrn7HNXaDmODEe3EXZHDNaERYQ+waGdDBR/TAWm3p/QylnD+60lR6uECxdJb0wGkGAFCJFRVQ3Pc0AUv6YAGOq1/f6oz3WbIN/8lcpZQTpyI5mn1qkGekYgOEuhZ2UTSKc0n313SaEpIfX3vGGewqxffE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705522665; c=relaxed/simple;
	bh=+2ZSoO1ZaIhXpAVpjkwPklSbkZYVdgtWw9yT7eVwQ6c=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=qoaollMh8FzUA1TSsXniHEiU6DwJuSBqbnJepxTgxHCfxIuxscCHDEooqbxghjSshkY31BCwYin85ckQ19MXDjTZeLFlzKXIG2Ev+InBpISQkXv/oKTgfKgjSVoTz8b7n+bZR1mJnM2nonDjl2WyzIVFsquC0cIknXOMf/m9DRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=k34StExL; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="k34StExL"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-35d374bebe3so8807225ab.1
        for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 12:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705522662; x=1706127462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ZDzwKFdbr5kcHk9jMrCcU9xNwk9atuhANr3VTJdGzg=;
        b=k34StExLdwDZfcXvCWh2Zd9ZsZYObT/kx+Kw81crLATyYqPAoCLN5a3H1yETSrF2HL
         uvj3uAUco/7/pkxg1zk7px7eYp/MLBAe+/bgep0+iR2vfIyjiQRpKU/O3c9lDGgEgZsc
         8AJCo6jqnypD0CtI96fJy679mIR6RU/C6sShjgQkaYcDXvkBMlKGbi6Z7bEVLr0BkpbQ
         gOF4z9ZGN/msg1CRF7pKab3/eSXF+4agTp2np57aQmUBHZL8JLX3qHvBMAtWa01P5d9C
         4dbc2v0mxnXmUkT+gB48i5QJANY9vctJ2CaypxYYbBp4eHi/NzodDLuw1xx44YO/zrzi
         RUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705522662; x=1706127462;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZDzwKFdbr5kcHk9jMrCcU9xNwk9atuhANr3VTJdGzg=;
        b=S9OWixJARVQXv9PYIjqBM1i8/Pt9s1beUH/u9LIPqDfwXmp3CZfziWRzSC52Sa0mSJ
         xsV2GGWM1Jdxdd48DXsnvpibAMFWj6ZcOkrL3TXeYDZOQPpQkWQ33S64fVqpGVt0XpU3
         2wqzo2JB1nbsRTnCzpCvuNNs0HLKyohXI7EimfxutVOAONQTt1/Obf8iGL+zr7i3oJo6
         dPoh88+JsYHSSOw8IHMN4Cp502UJvqXmwAWlP58WoJ6pFwWxJ8z7EVIkiO7HYwwGIIA0
         +BZ5+/xUUZ+R5e567jeWiPJpqgxjQWSFx1SDJ31cr9G0iqbpxkB4pJCVkU3ocG/VpSGj
         No3g==
X-Gm-Message-State: AOJu0Yy+93cozYJgTKb/GlBZQU0ryRgUFXjsxf4WfvnB7QRNB9CpvFLe
	hx6V5mmrXwDTPeFmoxUmL1Hbu10bbfgh5Z9RcdPlt98nDRIwFQ==
X-Google-Smtp-Source: AGHT+IGiyGjyCDBmUUQKGsBRrMtHBe8I8FYv6dJdCX71r9hr1AUjIF9prlacQZ4s7BQu9rIWEGSeyw==
X-Received: by 2002:a6b:6810:0:b0:7be:e376:fc44 with SMTP id d16-20020a6b6810000000b007bee376fc44mr15666852ioc.2.1705522662446;
        Wed, 17 Jan 2024 12:17:42 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x17-20020a02ac91000000b0046ea90fa158sm506865jan.16.2024.01.17.12.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 12:17:41 -0800 (PST)
Message-ID: <e4347147-f88f-4a83-ac48-fde1af6a89e9@kernel.dk>
Date: Wed, 17 Jan 2024 13:17:41 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Race in block/blk-mq-sched.c blk_mq_sched_dispatch_requests
Content-Language: en-US
To: Gabriel Ryan <gabe@cs.columbia.edu>, linux-block@vger.kernel.org
References: <CALbthteVP3BnZuQuGWfW-SviB64CwjACP2v1N5ayDVFpnjEOtw@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CALbthteVP3BnZuQuGWfW-SviB64CwjACP2v1N5ayDVFpnjEOtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/17/24 1:16 PM, Gabriel Ryan wrote:
> We found a race in the block message queue for kernel v5.18-rc5 using
> a race testing tool we are developing. We are reporting this race
> because it appears to be potentially harmful. The race occurs in
> 
> block/blk-mq-sched.c:333 blk_mq_sched_dispatch_requests
> 
>     hctx->run++;
> 
> where multiple threads can schedule dispatch requests and increment
> the request counter htctx->run simultaneously. This appears to lead to
> undefined behavior where multiple conflicting updates to the hctx->run
>  value could result in it not matching the number of requests that
> have been scheduled with calls to blk_mq_sched_dispatch_requests.

I suggest you take a closer look at how that variable is actually
used.

-- 
Jens Axboe


