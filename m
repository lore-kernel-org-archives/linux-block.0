Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DD738D
	for <linux-block@vger.kernel.org>; Sat, 27 Jun 2026 23:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782602952; cv=none; b=l77PnDIhEifXLSKHfS+s6FunBoZ4C3olQRaS53WBdXURiKyXE/5iYb9saUu/le8HhBYiyoJzlHvQf3HZhiOP9OmiAY6PF14Y2Z66lXRZqONolsHhsy6EWDIoFUP5pQaowN1q9Wp3liSrGr0GN0T6u4iiUY8HTe1KKF43mKViob0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782602952; c=relaxed/simple;
	bh=qZH/vLziPpGFkaHRQVYGhPXdoiOMCfjDzJOMJvF/wyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qI8239cS5Aqsw2jpuatg1GJItes5JTxmfgnb5f4SbByNi1ncKEr3jcWZpG8PpvxYwKzbf03M8KJCnQaVDayAPMaSnVU3f+c6FKy0IfKQNqiDHl/0pRL6TcNkydoO3OCqupTAkOH7Ik8F6dujeVKeT0UF5wo1ugpgqxRHXe5jtAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=VBZv59so; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="VBZv59so"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e9565cc13aso681654a34.3
        for <linux-block@vger.kernel.org>; Sat, 27 Jun 2026 16:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1782602949; x=1783207749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bTFP5CSo5QZCJqZ+KzYyZeTm5wMD2RDlL7lOuaGwi3A=;
        b=VBZv59soxFApnihf6l5a4ki4deMTOmFZS8p10H0++KEoTdYukYJD0zKI8rR/9ub2qv
         +qNbSkMWaQUiYJbi/96O6PQWQqCxn2Ecmm52zS+WAnnhsQB6JgrfHHVlxkebV2FYynVd
         jAd5xwnzLqblaoi2ckNqeyb3bLDFjU0j7VZDkzjCkkMqJe/i2GBtrWD+nAtC+013EyUg
         y/5unb95vzMJsL6QXcFW8MTs2UaMAkiQ9rgrPfMYm+9SEGAna+mhVVBpu+6U8QSOzXCs
         hku90PYv1TKg/uzzjY/CCLB8S3KwvzqXoJyUVWEDNjeHXZCfyL0WsmwRy3uADySwKF7J
         GR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782602949; x=1783207749;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bTFP5CSo5QZCJqZ+KzYyZeTm5wMD2RDlL7lOuaGwi3A=;
        b=mP3ACUBr9qHHBXz4v5cd9/N3IxGcUS99Wt0bI6EgOBe6CcsP4FR5Pt5lpY5eIpJIH1
         /4NF4BLBaqve3I+zt46K2gKa+yXeGzWRKjmVxFZ3R3dswAAjLJFevBWJU3d/SxJcvmZ4
         AI8WekWLldIqRqzTdMXx3dTOkjj7gl6pQTecSHCDPeEq7W05WgWQasBWaLcyln87nhXF
         2amFZur8Zk8c0VjTbY/lGQ37adHvr5SLeGcTX1ksFX+bzS7WipCIO1OujWP/v1RYmlOo
         sTvVQlGSi/Q/r+djgfFyouFbETkt2dBTZjsBdhdVOF1qrWs/4AbrZLJis7PdX03Nkhd1
         AAGg==
X-Gm-Message-State: AOJu0YwyD3tYPp7IvRnd/Gosc8ulB7seHGOM65mSecnUFmz3LYAOO/7k
	QP9wzB43kqmf6h7e+h7OKh7oxE0x1zxtFLNdRmTJZNYB4Qp6ig9vSdjAMm5RbFZDLJJ6YePOM8T
	3rS4Ih/U=
X-Gm-Gg: AfdE7cnVelACjsMIfLk4NmOAZXypAmfX+0YxxRHCwrCszp+wpzZrWhfxvyrK281txQX
	ObVCogHU8F0FKB9cj9kAYzcc22mKKRqCVLLavaGBrIV6oXvXPLJ0Cxm2AuH0pp/XVu2+rGN1fJi
	qrCf7FVaiHRnzQW3OqCgFJSV3cU3wstzMyj0FLeer8bJYXK/KT7craSmPyKuBkAb+uuV0WJ9NAQ
	DwmIM8PhRS3nVygFXAfkYbG3ZeR5LFmKD4tm48+VMuGgzX0wkz8+8Q7V6GWSgCxYIt1gDbs4Il1
	kQmj3f8vRSknAE7j94UHBDB7TghTAJmJ1hpvuWbqbyZAjwuRYKxpcmtjl1l4LFEm2mc9Nce/pIT
	hhMIUsgR05q2HWYOq9KXU9RS3PsMoNSm468/XIZmLu8Z4VoW9wqPKyqOZ+r3r+p8uIKc5+bJSqC
	zIB/042tsslb/TtqSVXDjo6x2Aj7gxmMOUgReJN7SB0hbtd/WyyvFvTVEhwnudT1OAV9SxGmI=
X-Received: by 2002:a05:6830:81d7:b0:7e9:b4cf:683c with SMTP id 46e09a7af769-7e9b4cf6a9fmr4341287a34.28.1782602949587;
        Sat, 27 Jun 2026 16:29:09 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9c48735f9sm1770198a34.2.2026.06.27.16.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jun 2026 16:29:08 -0700 (PDT)
Message-ID: <8069f6ab-f732-4a57-94b0-881eab59d9e5@kernel.dk>
Date: Sat, 27 Jun 2026 17:29:06 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix error injection static_branch dec imbalance
To: dayou5941@163.com
Cc: linux-block@vger.kernel.org, liyouhong <liyouhong@kylinos.cn>
References: <20260627023749.1048910-1-dayou5941@163.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260627023749.1048910-1-dayou5941@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/26 8:37 PM, dayou5941@163.com wrote:
> From: liyouhong <liyouhong@kylinos.cn>
> 
> error_inject_add() only increments blk_error_injection_enabled when
> adding the first rule to a given disk, but error_inject_removeall()
> always decrements the static key.  blk_error_injection_exit() is
> invoked from blk_unregister_queue() for every gendisk teardown, including
> disks that never configured any injection rules.
> 
> Removing an unrelated block device therefore decrements the global
> static key without a matching increment, which can silently disable
> error injection on disks that still have rules in their
> error_injection_list.  Repeated teardown of unconfigured disks can
> further trigger a static_key underflow WARN in jump_label.c.
> 
> Only decrement the static key when removing a disk that actually had
> entries, mirroring the list_empty() guard in error_inject_add().

This was already fixed in Linus's tree by the time you sent this out.
One more note below...

> diff --git a/block/error-injection.c b/block/error-injection.c
> index d24c90e9a25f..d210bd5fd8fb 100644
> --- a/block/error-injection.c
> +++ b/block/error-injection.c
> @@ -118,15 +118,24 @@ static int error_inject_add(struct gendisk *disk, enum req_op op,
>  static void error_inject_removeall(struct gendisk *disk)
>  {
>  	struct blk_error_inject *inj;
> +	bool had_entries;
>  
>  	mutex_lock(&disk->error_injection_lock);
> +	had_entries = !list_empty(&disk->error_injection_list);

I'm 99% sure this is LLM generated, they seemingly love to use bool
variables like this, where humans rarely do. If this is the case, add
the appropriate annotations as per our documentation.

commit 214cdae69dba9bb1fc0b517b7fb97bab385a2e3a
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Jun 22 18:07:52 2026 +0200

    block: fix incorrect error injection static key decrement

-- 
Jens Axboe
