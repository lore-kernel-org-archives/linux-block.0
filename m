Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25E024BBFD
	for <linux-block@vger.kernel.org>; Wed,  8 Apr 2026 12:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775653142; cv=none; b=r7Y0lhTBYA1tSIHLMlnwBrzaDHCKLyE+vb2y+BFBmDGeflwYZ2GIxMaMC/W9QDrFGf20WLGZYWnB6VIruxtoN1k/dG8gOf9UAB3Ci038UW07foTmIN7wLUGkI02rNGbDU8i8v0PItS7NTobCcgIizBMN7Aapeo2smZ9I2LLnLpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775653142; c=relaxed/simple;
	bh=+st5AJyr8N+nqPCAMiQskoV6eyutyHGeDdDKmTawPto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ja8jmNyZtmufj5bYWkfEk+V9xDvxsUOpwU+fU5Vr+nxkaCHutxCOcaLEHhVTcMrNbctZzHmJZRBXbfFXlA4+1/yjL8rehHShXCeskyx90oHoCKOtPfcbTpzcCm3n+y7KTgdM73gx7G3c+tYhx5GaV45NfoDkTCdUZvMX7bim7+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=zeHCf8HC; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="zeHCf8HC"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d4c383f2fcso4901999a34.0
        for <linux-block@vger.kernel.org>; Wed, 08 Apr 2026 05:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1775653139; x=1776257939; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Er303R5k9tcmJC1WSDcneFV5oWb+ve6YEYG8d7FI6JU=;
        b=zeHCf8HCO+ZDcLJJXxVv+zQsKe31H082V8wiEWnsW4FRAms1UIycZAQ9v0ii7SfKSN
         kuX3QRjL68rGrokLX2uLxQcKPP+j7vyKbiJXalBqaIwDdej7N3ls2/SUs4K7H1H2Lw6Z
         PJrzuyOCn/UunGfHFbBNWTOfjSOZQJbvN/QOVb6oHTocWOcLZ4oS5YrMwiOIfk0y7uX1
         +RI2N2XvIjV4gSDi3htBK9J5esc9RN62hITPH2PPvGBjKv58q3nbmTHqDdXz4R3nf26c
         i/IHy/UNG0p5nxXcYU2R2u1LHDt2fZyK6zH55DzEWTbWAuxOh9TTtnv/K1n837xfzi62
         ZvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775653139; x=1776257939;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Er303R5k9tcmJC1WSDcneFV5oWb+ve6YEYG8d7FI6JU=;
        b=lcLhW+jeOV/PS5+D3N7sByBLKqX/fdpM/Brg8i7bATPvLsJ3gw+XNn+LirI0/JkQOp
         oajkLwYiyXNOwNPHGVpmqvD4NqKoSr4tX3oQWtNTJMseW9iyH6GK2GJW+jXdmF7XW9O4
         zKiwe55Qi5yMT0SlUoGePQ19d0fHdxObGdqsYKVky2ve2tc6EdtTuR2BY1EQEbQqLvnQ
         IPOOQI2NgBHdj3AeVdN4fIiN6RV1Y6D9+ChIngbrZWb9i0wiOOVYBNW6hLCrNWcnyli4
         A2LplE9sbmJOA4YSYIGDUHRZMf6vQ7h8ose3zH9S6QvHbJGjFmKB4KrMLDjIGnyzhCJc
         sRuA==
X-Forwarded-Encrypted: i=1; AJvYcCXhCfvKotPL4ZDOnUS5eYvB0e53oJyzCeJaEG04NKAoMMPNljWI/6Avz8blpOr8NhPtsM1rYOkRBdiw2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnBCwHciF35MHXCl9VROK0JXVU/445VQfWsISDlrgysRuU+VGv
	fcloEaAZQzscbIHVVRsusNtHVVvAzH27VG2d2kLH6Oau8AYsv2wcX5nKMsBByan6j4m1iyPDsvt
	s8PO2qMU=
X-Gm-Gg: AeBDieugEStYN38TQvJW3KcFiNdQO3PBDN40/7Fm555tj1cMtxJiaRM4UFozxK1zK1E
	36nUS1N/gK76eyf3U441iw1izF77UsQRlvHyB3A9Pf5Xzm8rGIBFcvb97jbpTy2OrIN5ETjnmkx
	Gokr+CYeIBph+2HoAtgNk4eQLYDT8eEXRlPt8Gpl/GJjuBfDpWkJB9ZXJ3kGcAWsWNMaNkbnusb
	I6rxOhWXTNIh5TsOa6PMC9vtLeTgdq5FrtmzmVanL8elIDlE5a/5Z2V6uhFAAvb2GHDDTLOl7t6
	GhPytRyA/YHG68GGHEAw9jJ01gD2FVDUW1OMkRNvot5zVsihaYVKbz7UgvpXhFRgFDtrdAsLeI1
	uVc/a+QRlWUSjig+FofeTttaNG5bG/ARPzA+zuYf6B6A9oy6oXY/oKGOKDf402A1qacDSpqHfb5
	IlkYsY/xiaiWFqyVMCwSgnOoeVy9VvvjLqEKol5yCcS4pA36yTMhgFHJW2cNWRAKVOtGsnrFFJ9
	RTAmfrG4A==
X-Received: by 2002:a05:6830:6004:b0:7d7:443b:5679 with SMTP id 46e09a7af769-7dbb75b877fmr12926447a34.29.1775653139696;
        Wed, 08 Apr 2026 05:58:59 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dbf2ddd6c8sm4058683a34.23.2026.04.08.05.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 05:58:59 -0700 (PDT)
Message-ID: <c92d5318-8c8e-434f-835e-61cf1fae4edf@kernel.dk>
Date: Wed, 8 Apr 2026 06:58:58 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/20] DRBD 9 rework
To: Christoph Hellwig <hch@infradead.org>
Cc: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org
References: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
 <ecf00b4b-c3f8-4161-a97d-3d23b423cabf@kernel.dk>
 <adXk_m3SbRcWTOIC@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <adXk_m3SbRcWTOIC@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/7/26 11:17 PM, Christoph Hellwig wrote:
> On Thu, Apr 02, 2026 at 07:30:35PM -0600, Jens Axboe wrote:
>> On 3/27/26 4:38 PM, Christoph Böhmwalder wrote:
>>> As discussed (context: [0]), here is the first version of our DRBD 9
>>> rework series, intended for for-next via for-7.1/drbd.
>>
>> Will you fixup the kerneldoc (nits) and the assigned-but-not-read
>> issues and send out a new version? Also looks this series doesn't
>> actually apply to for-7.1/block, patch 12 fails.
> 
> Looks like all this went in without any review?  Since when have we
> started these grand replacements anyway, as they are known to cause
> bugs and regressions?

See the previous discussion, the goal is to sync the two drbd code
bases. It's followed the "usual" pattern of the in-kernel driver being
neglected and development and users pushed to the out-of-tree one,
which is highly annoying.

As per the previous thread, the intent is not to push to to mainline
right now, but rather give it -next exposure without running into
conflicts between the trees. for-7.x/drbd will be rebased as needed,
and it's only in for-next for the stated reason.

-- 
Jens Axboe

