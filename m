Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BD325760
	for <linux-block@vger.kernel.org>; Mon, 13 Jan 2025 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736783554; cv=none; b=GNV42GTp/RJwXrlWBloNTha9Sz3yrJe8V/VSrMbd03ce21NSftq0jyYcff/inTWK5qro81Ej/E135eN8QKDsqpqywAP+qrmgB0IuOOGMWo5B+qU5LZ2SXhzYsSQ3Z10R/M2DvjR0t9ZzDubLUVFZEs/uu1LCKqHyqK3RnAd09+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736783554; c=relaxed/simple;
	bh=P7Fn49/t1DpRmieGAFkWQjWqqafWi+02WDelDO3olcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QqiSmuXfIRRM/PnJ0rYwZPCH8m93z2DAw23wmm49YAkofiB4fztOuYSaufZOvq1c6vPj+zFDlopLdz3/F1oyGWcBU/UsTTvRNWh3bJizWxyemtUNn9pOFkW8lQONRBzFqH5SSbdB8u4ORvw7MHYpybNEA6N2DuG/5pmwHWG8rEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SQxZ1sjP; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SQxZ1sjP"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a777958043so15117345ab.2
        for <linux-block@vger.kernel.org>; Mon, 13 Jan 2025 07:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736783551; x=1737388351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b7cxbbTow7iNQKCzQXtILN57RRyk69S7IZ0yWn6+gj8=;
        b=SQxZ1sjPdh4TpIFf5uEAopGggF2OvKCJrz+HVmHG7YxTrLPO6NxrUvaXLst1kyiXan
         SZU9zYY/u7kMm8NdSg1caBZchaZCgHBwUKtat9IBR8l8/3gAFPdliUn/BIZ70RCvvzZ5
         k1PHno4sAUPDOBx3VBx2JvDU4c3ScglLkE1uzlfcQU4fD0N6WKnvFOgs9yTLHos/v9l5
         o7TJLLTctZCV27yxgcnpXjX9vEcCQjoS5PtpkwqwLHzR4vKDptl/J3/GxRUFvmYP3yDa
         akpCZI3XoYeNS4ETN2ynX9CuPy4vs52Q9ufGKW5TVyBC7c1ChlhEXsyGwNgg93O0MZg0
         0axw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736783551; x=1737388351;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7cxbbTow7iNQKCzQXtILN57RRyk69S7IZ0yWn6+gj8=;
        b=rt+8qAHafqWesLT7df+Tk8d9VFQ1+9P5Ao2A4frH7BOFjrg1YxmwpKOdwlYRRb2ViD
         Ew0Djm/vO/5PSymbSG0gHcVbk6yW2GQ8VCG54db67Fo79tWjDnLcx6W8Auro7bTl9dwy
         D3ibn7Iz19EWSgwyzFRgY+vFK20MoNbZ7SlY4+rZKedTENeT8cxj81EKcvKedPnv0Z8i
         QtLTPdWRzOJ/ZadCOuMorjDR0lhpej3iAoWsZpEyCG6PKHQAXXpp30UsLE8ADNmKZeM5
         fTo2cfaamVQfyGZGXmy/ix2PtIeDcorhyv+JVBbUkl57QQKOE+0fTxIFqQmjJb+6ooSE
         x5Tw==
X-Forwarded-Encrypted: i=1; AJvYcCU3zjTHaqiBTejy+gdVth6ufGAe9iGJ6HmFUdIWNv2cbm+KekI0syg88XSuBLHXrVP6Sg3bq1b/F1exEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ2Gv3HC5VQDKikvjoR3TSpLT9rWd3u9uLqel4k5+Bo9QUMSry
	ngw2TtaC1PoGtfMTTZdy/1QX1MzlYeuXqEa+TfSNjgSAHceclyzJ7PfDBhZ7EVw=
X-Gm-Gg: ASbGncuSbtEkJ2oEVrdCVsd42eHNwzA+L7sj9jVHcQ3ZihLjen2sdflTOEAG8qpOYoR
	omXW//dd9ruGRxpEOeyto8Jk/Es+TOBw8kdagtXk/2uuDeDuDtB3p4bhxoaY3IpWQqBOtnUd6L9
	6cfH3EJhCSaFgmOf81hII7JuDO647idFVedgpDidauiVSQdMhKiDsIIZAozYaqx6bDdSNbbMPJm
	M20lua6Etd3oEz3IejCfxyOmXIWaJDGP5qcLKSR1quc6ep75CoE
X-Google-Smtp-Source: AGHT+IE2stu9drzc/N/VaaEwWSLBWoGbif0Kk3wSMExZH/wQ1mMpu3kjPdZv601I2lZ6YgUIwvWU3w==
X-Received: by 2002:a05:6e02:12ef:b0:3a7:8720:9de5 with SMTP id e9e14a558f8ab-3ce3a9a50b3mr151457935ab.1.1736783551275;
        Mon, 13 Jan 2025 07:52:31 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ce4addba24sm27298125ab.42.2025.01.13.07.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 07:52:30 -0800 (PST)
Message-ID: <8bf0bfeb-06ae-4efd-ae0f-bad6bb5646ec@kernel.dk>
Date: Mon, 13 Jan 2025 08:52:29 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/3] block: model freeze & enter queue as lock for
 supporting lockdep
To: Chris Bainbridge <chris.bainbridge@gmail.com>,
 Ming Lei <ming.lei@redhat.com>
Cc: "Lai, Yi" <yi1.lai@linux.intel.com>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Peter Zijlstra <peterz@infradead.org>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
 yi1.lai@intel.com, syzkaller-bugs@googlegroups.com
References: <20241025003722.3630252-4-ming.lei@redhat.com>
 <ZyHV7xTccCwN8j7b@ly-workstation> <ZyHchfaUe2cEzFMm@fedora>
 <ZyHzb8ExdDG4b8lo@ly-workstation>
 <CAFj5m9+bL23T7mMwR7g_8umTzkNJa14n8AhR3_g6QjB2YCcc5A@mail.gmail.com>
 <ZyIM0dWzxC9zBIuf@ly-workstation> <ZyITwN0ihIFiz9M2@fedora>
 <Z0/K0bDHBUWlt0Hl@ly-workstation> <Z4Ulmv7e0-Q4wMGq@debian.local>
 <Z4UtPNtdgVrA9ztl@fedora> <Z4UyUntV70G_RYyF@debian.local>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z4UyUntV70G_RYyF@debian.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/25 8:33 AM, Chris Bainbridge wrote:
> On Mon, Jan 13, 2025 at 11:11:56PM +0800, Ming Lei wrote:
>>
>> This one has been solved in for-6.14/block:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-6.14/block
> 
> Thank you, yes I thought that might be the case.
> 
> Would it not make sense for the fix to be included in 6.13? Or is it too
> big a change / just too late?

It's too late. If need be, we can shuffle them towards stable once
6.13 has been released.

-- 
Jens Axboe

