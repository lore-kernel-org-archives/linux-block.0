Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F47955E40
	for <linux-block@vger.kernel.org>; Mon,  8 Jan 2024 19:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fNMP14m8"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-360412acf3fso1115875ab.0
        for <linux-block@vger.kernel.org>; Mon, 08 Jan 2024 11:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704742051; x=1705346851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dp8RbIsL2tudoP6bPRYhCXV90X7vPN379OVYR5btXk0=;
        b=fNMP14m8LhFYt6PT91Cq/Pts0O4a/zUiajwyBiNYxwsub97N/L56VY4+06lMDs0pOq
         M9J9I1oDGHzHR5ZC9OcJuDZH24Jc660IH6wEGBK6Wmdqfsu/ED3Ngsnx7H+qcPON6ec+
         MzG8OjFV7TTBScUehxw90WRubszfOI1iQQYuc9n3qDyVyKWo8kNu2tANguBGUo9zFHTc
         cd8L5HFI00ecCWDAfeHaQgZVMFAC68k0sKxG/ebCL39G6la1NfzKorECXIwOdny9lg9L
         esJHZ36abIFTdFB6xMsotyP6I5Er6eciyYCc1Hi9Y/EwbfaUXZjWB4zDeub+zO8tf9IR
         THSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704742051; x=1705346851;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dp8RbIsL2tudoP6bPRYhCXV90X7vPN379OVYR5btXk0=;
        b=YxXDwYhDtVE7kC1ArltuRj4DRQBJ2V0WolD1QFmfqVEBnntpHu+CROCHpQE0xzDSzH
         6ZJEUPCn/VvaWTE41dHJPlD7wo2co9irZ2cLb95MRIGsH1bwcXSZmXUk815z5VdiW3+X
         3pF3FEmoMRMHSG0S4lY/2nvl3LLv1nUFOkYFSAnSqjMDOudbyAx+pvSiUruAuvDePSwB
         IbO6yPveixXTI57QWM3rT0ee0kokaeSEURCqrcIjha0n9Oyn4gGUdK0uIZMVNYve8Sfa
         rfZCoroQvKgeVTqCw1CtUwBzVTFK+V7kD1e2r6mu/3F6JSXvfEaqwry9mlciGkNmHN5n
         p0HA==
X-Gm-Message-State: AOJu0YywIrncZAUuqW+6bo7vSj6x9ggteyCLk1jkcc/CNbpMGWa20LoP
	fM9WOl7xN6gwIWPyeECkE3GCGcqxk/PoNQ==
X-Google-Smtp-Source: AGHT+IEMg9RhGno/op7HM5cfHBNuNqxXVETZ/uM/ShC0hHH5s6DqY2zitOBukgT/VjGkDIbb8e8Bow==
X-Received: by 2002:a6b:ea16:0:b0:7bc:25da:84cd with SMTP id m22-20020a6bea16000000b007bc25da84cdmr6929974ioc.0.1704742051361;
        Mon, 08 Jan 2024 11:27:31 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id q21-20020a6b7115000000b007bc1e8a24fcsm89043iog.32.2024.01.08.11.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 11:27:30 -0800 (PST)
Message-ID: <f691a3f5-7de1-43b7-bd64-3b224981a5de@kernel.dk>
Date: Mon, 8 Jan 2024 12:27:30 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: move __get_task_ioprio() into header file
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20240108190113.1264200-1-axboe@kernel.dk>
 <20240108190113.1264200-2-axboe@kernel.dk>
 <a7c35161-45af-4f57-bedf-7a28674fb39f@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <a7c35161-45af-4f57-bedf-7a28674fb39f@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/24 12:24 PM, Bart Van Assche wrote:
> On 1/8/24 10:59, Jens Axboe wrote:
>> We call this once per IO, which can be millions of times per second.
>> Since nobody really uses io priorities, or at least it isn't very
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> We have plans to set an I/O priority for most Android processes in the
> near future. According to what Damien wrote on linux-block, there is
> probably a significant number of hard disks for which I/O priority is
> configured.

The rates at which Android does IO means this won't really make any
difference, should probably have qualified the statement with "nobody
uses io priorities and does fast IO".

>> common, this is all wasted time and can amount to as much as 3% of
>> the total kernel time.
> 
> Anyway:
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Thanks!

-- 
Jens Axboe

