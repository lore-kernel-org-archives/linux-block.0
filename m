Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632A49461
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 18:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734461172; cv=none; b=t8vmtwCuyDO4A3E6XrgDDWwig1Ved53vlupsi5cuJhJS6mONik+mqGY73kNIDZZoIU2ANis1uzfmivw+k9T6BNL15mcVWZUlTLy2biTkvt5gMC3MGHld3+8h2J8vkN+o7Gcucwf1MBPQuejBlnB833D5iEcckMuWrhrGdH+zsJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734461172; c=relaxed/simple;
	bh=woeNW6J9oV3Wr3y2WgCFFAhr/UOYK1xAcW/t8sJsA0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rt7Zfmdg97j1FF4GzgfcWai+lebPqUa80yw3/rSINxzGPCHNrgvezuZuqTscgDuiUBkf2BIm86f9NC+odsYcB8uJSefduWPE0QpqHRx3Tiwyr8oGuT9aOa++2+TaG3DYZjN1Y9p/p32xC5VpCwx9l5rDyfQ6jIbWC1j9cZ7Cx70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0DoCPAOX; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0DoCPAOX"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a8146a8ddaso17801825ab.1
        for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 10:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734461168; x=1735065968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=trSjqAS3n7XY8gfJxtVldmrJMUh4rh9OA7lv5j0nbHE=;
        b=0DoCPAOXa6z5q5gKISTRj28xPK+neBWQrmEqcp11hGGSKE/H/7cX7XCsJhqmOPnurH
         BfzmCEUcXcNI7v/QagyhTy7oUg+fwhyCn6DM+AKuJxsXU3Jxwkm1VnefouMoqjlXkl2P
         T3I/qG8VVaGajl/9DFdqjSIx2TxLid7hcSKNKTWzYgRN+pJ5STHyt2YhI886Uo+68TGQ
         E5lOmVwTbF/me0viBhDjeRNRqqQwiMJki2Xm8J3tqB8J7ge2/9cjHX3j30ie/5rUjRJ7
         TD8nVtkGptt14tM3eYJTAJSEgtaxrlMjyz4S96J+mpF60NOhw9qPDUaGzNf8HLsC3SEu
         PpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734461168; x=1735065968;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=trSjqAS3n7XY8gfJxtVldmrJMUh4rh9OA7lv5j0nbHE=;
        b=uceAb3IFTA17Zln7FjAAr6xg0LFRukAkLJkLr5RrNFUE+5/4+jHMHnnoo7nKQAK0aD
         EZlgtqf9R9SEYsQBytIKska+efUqbf6buGzdYyZVX8LNMKr1lBc3RM18mJzQHw0MoqK+
         /hUw5id16SmlJBAPmSZ4zpOtYZBzJJoumY7hI1GgLlHbZ/ctOKlVogOStWR1cz3o/yXu
         kogIJOtTRHa2+tFBjwFLwspmWJhik8doHKpVViANF7HtI/Mx92YGxN6fi4yTmRQ9FYis
         UNcGRzGLvZVPlhv3XZJU1GsrTkTAlLLVzeUYx1SGTgThCiOt4sjnUa1SutqRcwIoaZIl
         uX2g==
X-Gm-Message-State: AOJu0YxelND82ODlQTGGZ2uWA1lKezBULh6zAP45MlO80PrpRZMJgDxz
	ur8tfPu4go40iHbjHerwCZpI+GKrqTPZ0g3rS/zJBVwElXlMo8dxK2V6gn54e5g=
X-Gm-Gg: ASbGnctmil1bN3RnKPbEYzr3Buxwq26lNhSOBmLP+giI//vDgyxzz1V4Udn+urUplNl
	bDKNMtnpbdRRpAnhMteV/eNnFF63ut71eoYBajU7+ys/Kl4MKUgwn9Sy6MF9arUGnhtZ8k1uq8T
	whg1PHbFAfTgHKhKbD7Uf+YrJjgD6a3EWk1DcmFd7xWShB5p2dsMs1ySazw+PA/US0tieFILTV0
	9wpLSFGk1BKE3oPXrpkuJ30/4BdGVrv9jxe7OzRyhQ9xh/5omYO
X-Google-Smtp-Source: AGHT+IHgDmbCVpIRwDzk+bhRMPkfMMC7F7MrOLwjZGUAX1yYr+PUS45/+CQBTnoW3ZX9GVlRdQVUUQ==
X-Received: by 2002:a05:6e02:1a2b:b0:3a7:8ee6:cd6e with SMTP id e9e14a558f8ab-3bdc0bc8524mr1067735ab.8.1734461168442;
        Tue, 17 Dec 2024 10:46:08 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3b24e557df0sm22460255ab.80.2024.12.17.10.46.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 10:46:07 -0800 (PST)
Message-ID: <bf847491-e18a-4685-8fa2-66e31c41f8e8@kernel.dk>
Date: Tue, 17 Dec 2024 11:46:07 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zoned storage and BLK_STS_RESOURCE
To: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bvanassche@acm.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <e75812ec-9b91-42d0-9ca5-d4bae031e319@acm.org>
 <20241217041515.GA15100@lst.de>
 <b8af6e10-6a00-4553-9a8c-32d5d0301082@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <b8af6e10-6a00-4553-9a8c-32d5d0301082@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> Of note about io_uring: if writes are submitted from multiple jobs to
> multiple queues, then you will see unaligned write errors, but the
> same test with libaio will work just fine. The reason is that io_uring
> fio engine IO submission only adds write requests to the io rings,
> which will then be submitted by the kernel ring handling later. But at
> that time, the ordering information is lost and if the rings are
> processed in the wrong order, you'll get unaligned errors.

Sorry, but this is woefully incorrect.

Submissions are always in order, I suspect the main difference here is
that some submissions would block, and that will certainly cause the
effective issue point to be reordered, as the initial issue will get
-EAGAIN. This isn't a problem on libaio as it simply blocks on
submission instead. Because the actual issue is the same, and the kernel
will absolutely see the submissions in order when io_uring_enter() is
called, just like it would when io_submit() is called.

If you stay within the queue limits of the device, then there should be
no reordering. Unless the kernel side prevents non-blocking issues for
some reason.

It's either that, or something being broken with REQ_NOWAIT handling for
zoned writes.

-- 
Jens Axboe
