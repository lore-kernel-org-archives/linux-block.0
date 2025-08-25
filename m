Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0891F2F0694
	for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129714; cv=none; b=YogAld93p40/jKcp6QzG+sTkzbr5cvwfxQIpdtmGprrxr1X+XIlRn4VY07t1sW6cL0tkHAJBBXhuN8S2Lkq8kvM8lDBIAYMT8O8SADOzrLX85ffcoPFLpOMu9xwQmuxTCohu+unbGgChb8rIvkVAWQxSwnlViQQUcyuifbnpfWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129714; c=relaxed/simple;
	bh=UkvCHo8AnnsdKPECOAK1tt2CPjzxfbeJy7x/xGsMYQU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=m1JtXGXfqc6oUbFBO2TQWR3oxRCebfvVFAN5rPEsA0LqeBoZ2lklV7mDAaSohbxFSnIdyvr4lU5uQPTE+GuT+do0pqxNZAUEqjS/7Djlv4qkS1T0JhDEdWEK7cwpq7WgHl+MM8QL6GXr83qDiDZz3Wkh38s6RZBEDx/bax2vG9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZVGIaNdg; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZVGIaNdg"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3ec3b5f05e8so7007155ab.0
        for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 06:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756129712; x=1756734512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OFQ/rLR1VcRI8EdNfUQIRb/FRTu4u4BQ9Glpx9EACls=;
        b=ZVGIaNdgWwm0gw/vPo3OH/G3AdLndad6qDUGhKvw6gBsm9H+YxhmGpGeiHTRw05cyX
         vZZgjLdT1EibDjm23IK7XH2exB+vpEsEH+2hstJbkeKtg0Bfj03yz+n+9Bg3w2dpUH+j
         MzealrXWYbZL2rz0ctwreJBjDgHoGgUt0/NBxg7LmbCyI4BawBqPyuUStj8Qa62f3L9P
         seFww4qmLovjy0F0hZzuRZp90TID/28gfXIZoPrv9dXtGYj+RwFkqCGA9Mv+qyuxvszv
         DhsqVngIfSxnhau0DEHP2dlzzx9DRuMEeUdGOIV32plpl8Mmt6qLLJYaXXLhB0FMvcMV
         Z3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756129712; x=1756734512;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OFQ/rLR1VcRI8EdNfUQIRb/FRTu4u4BQ9Glpx9EACls=;
        b=oLxiO/13NLmVjOb+rXdhZ2k6lnHrVz/8h3K779cumP96m1bgcmoSXScd7Cgn/kUCrj
         ZM0s5RDucbSf5vEsOOvUqIAGTU8NMwvDcDG3qhYcF+lln/BwIl9++bLXFwYPaPx2WZuQ
         IU16XMDVn/EOQp1+qsWY8/DABf/5pBrRS2thoMVRdz30AKd9vmkpsQ0Ing5R01YaTtoS
         5D6Yb8fb8Hv7G7j3E9GRbLz/QInl4pc+HD5B+1rfHEm/lbT93Lpp9pEi67ygret1irlK
         SlluwWhR1vlFQwJpQwHR0Y3gmsiW2g7Tdx3Hv+stU6XUoL32b5uIgmd2EAnp8fT1tvTM
         wLnQ==
X-Gm-Message-State: AOJu0Yw+3++ZWuFoVagPOQAR5bVbFRo9nzoM0SoMYdh8M0ZpsYD+37ap
	i9uyAr/GIXI6v8st6hypmPmxFy4SVF+zSBXbjC8yi+Qd3OWk0eYPFOQtLe8NII6SVe0HosBDYJZ
	d2jsm
X-Gm-Gg: ASbGnct9hbAyQXDGVl8GIhimacBuUZmaHWZwZ76eN5Bhz+NRQIh7Dlad6EgC+DLrNUe
	nH0jllEmzHoauo+F1UAKYCrQ+1Z11mBmd1kKM7rAo7mxx5R0N8VihXQlNbA1hiurgdM/iTm31uX
	aICH5ZBfenBd2jPC+oY1GrbF7InrnZ0nbEQAex6Lj/nOKCXOvVLm+8u1eopJb5rZt5LSc4Zb+bq
	rVAVmTXWnMDqkRH4GKDcKkkvj1HPwDa6+sC1W+9xu5vRXULsqCPmYIF1oK1rO+JOkuXErm2og6Y
	63mM3FUSB2idn8RQnU0VutWkSKBuzJFLvAVsIumEOPxoSwMw8SKEYGhjRNisNfKHBzamJOOc40I
	AsbhDhZXq03/tm2ppKyWuJsxfbkB6mw==
X-Google-Smtp-Source: AGHT+IFmdpQnFHY0CsqnLhTIm2CC8k9CgZ1i2H9Ua/qLSGVCLW1Nc9PYe+yiIusFAZqIr/2pS0oKkg==
X-Received: by 2002:a05:6e02:480f:b0:3e9:eec4:9b68 with SMTP id e9e14a558f8ab-3e9eec4a01fmr141394275ab.31.1756129712073;
        Mon, 25 Aug 2025 06:48:32 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ea4ea35fe0sm49003885ab.37.2025.08.25.06.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 06:48:31 -0700 (PDT)
Message-ID: <61bf6a0f-05de-44c6-b4eb-87254fca4d24@kernel.dk>
Date: Mon, 25 Aug 2025 07:48:30 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: Move a misplaced comment in queue_wb_lat_store()
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bvanassche@acm.org>, Nilay Shroff <nilay@linux.ibm.com>
References: <20250822200157.762148-1-bvanassche@acm.org>
Content-Language: en-US
In-Reply-To: <20250822200157.762148-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Fri, Aug 22, 2025 at 2:02?PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> blk_mq_quiesce_queue() does not wait for pending I/O to finish. Freezing
> a queue waits for pending I/O to finish. Hence move the comment that
> refers to waiting for pending I/O above the call that freezes the
> request queue. This patch moves this comment back to the position where
> it was when this comment was introduced. See also commit c125311d96b1
> ("blk-wbt: don't maintain inflight counts if disabled").

Doesn't apply to the current tree, what is this against? In any case,
please resend.

-- 
Jens Axboe

