Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279512;
	b=f9yplGyKIf531qXZBMLxm2QIZAoAUgkMvCwMhB/2szBOkB5bnLff7y3/NhlH3G2iYnH4
	 aTrgrByC/Kg3n2A/zDwBKUFvzb+rCeY3PZUSK3LuBBO+XaFSv/qxfMIP246aZvXE2bMhj
	 B/JIifT0QiTnVnEJhF3dw9dnYe4+D2etJXywQSJxRyY+HBOa+Eg58Ru+biGQk7DZhP2pG
	 nUpf16V1e4bFUJbPYPhEj9Utx3YMrW5I1Q8sm/RspR7uUPsqpicesgZvmUyYght5e5u6P
	 1T2FrRZ+stenlEvj/a4L+k2ZKe+YzZDxrmehiz4xjQr6YM+Nw+hgdRjnxMXKg76TOLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279512;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=s3Yt0HrKdBITV3RppTf2tI5kY66FXgjfj6dvBAbyZ6o=;
	b=da589TOtdsd0sIXLAhl/N5qVatroo7OiWUO9jzOWF1cf7DkFNoe7aceHIVRPYo1+D76Y
	 43C2GxF8f9EnI4kfieMWmuJJJHSS4UJEU9RVXXBt/gZjmELPk32p0banz4nteu6FJSGmV
	 5/k6x2AEcz1kJl3s1OAOIqlG/SqUsGcTbkW351nF7Zafp0BCxahNKwZtiD9zaYl6kIbMj
	 jDz0XCqVgxGKhRoqDwLpfwz13gLeieLl9zhY0DPRkEn/82YXmSk48rCoEWSD2pqM10jd7
	 D5t+odh+aAO/VzpuZC2LclxhUFUvIWv8AAxaIyCyjzuvdTeWMiGSIHNAL5T1xnwmamA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=N8MOekKn;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A1C606A31F
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 13:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6A1C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=N8MOekKn
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3282db206d3so1139081eec.0
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 06:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793279511; x=1793884311; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s3Yt0HrKdBITV3RppTf2tI5kY66FXgjfj6dvBAbyZ6o=;
        b=N8MOekKnePbThvOr5XtwsABA5d8aGIdRk9qSUu3fV1KapdkPX+H6ZunwxfM2x4YRte
         m1Vs0SHlcSwhlbpFX4PVgfOLLct4G0F7RMYK/pAphbhT/Zgqpq4+KFbZkqiCqnZWvavs
         kLtFIxX6SrOuddoo4rgn4byAFgYU+4DNrrcKW8Ygp+oOgqasl6orlQ245sEEYtUfOXPg
         riGsXxjvxuvpqcvc8UptvwTEg4swCMhlnM/FWRJb4YAYmES6Ql7bDsBTx111XRNTwE6e
         1PHbic2jNOt9IxYFy67QcGr+P5SH7P+s3ZPaAfzF356U7Ev2DLoGuLWeON7Sc9J/cqx2
         Rpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793279511; x=1793884311;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s3Yt0HrKdBITV3RppTf2tI5kY66FXgjfj6dvBAbyZ6o=;
        b=1yxUBF5VRRdZ9vJPqvWe0xmYgTjQZcminSenWHGwOs/PhtoCeQeJkZYGbbUr6j0lY6
         8mD88Aj4DmWYvuXk+vQCH8Z3+acvuZa7w5YHgXFGKskThyWtPFoh7BWo/b3WhC9fdwjV
         2jr7/EbaD6kcfmAmlLpnq+ktl4w6qgRtqQ9fVemGBtfhKp4o0d5WyqPZHpNlmkx373hL
         Remb2nr5CZOGxd9qUbp1LAQYzAVhZwvTCQygdNNoPWzRev7KFDMP/QkKd24C8ZouoPb+
         kX1LhevW2udyPthXlRwEO9Q7k+/02kofUY1GgidLgNjtYAj6PyV6KfhYT6A7EMWtr5bk
         tIFg==
X-Gm-Message-State: AFq9FYI8ACRxiYNm163WcFAE48WpNLndWIU7WyL5UkPA2//b555SEQhz
	JWUh1KkJUTVhU6cCeWIPf3qmNtfmE0J4BFhnIpMbUwEpMrDQfvAPP1ymSTTg/SRuMwo=
X-Gm-Gg: AYBFou1FOpJtT0bfxWZxvPJdOz4scSkkonTeza6MyEFrEervPdooIPmtpHXNdSVc9cj
	W6xUfa1ZBD98FSS42/lMjPv2A5SpydeSw3+I3H0zd+4loe2Qg1nJYePWvvTA4HLz5V7zpg8KrPG
	8Y8vvnDa4R1uU/n9Z+s0KzISVHE2NqHwdZ72PnjDZsO9fcji+W6C7/4kMUpiBvPIKPQqzfyq7pL
	ewyx4jZfjvz7EkzQo+j/HI7xieG64pNaN4eySP1g6s5Fje+rKNNxIqyknkxTlfd5wxmA3JbLP8E
	zQyj5rUGB2N4BYzYzXeYi0doFwDUYXanYq2EPKOGVGtHK/mjs0xgNjhvcK6Neqz+oS606FOFFj8
	swzelolR/liOm56wviLAO6fWFvrYrWcQbmCM0rMC+s70Wx2t8AziOMQmzdEQ+atay9+5X0NAjDC
	FhIQotuI+NjcPPQ3W+C2iRMieaMR5TzQ3nIkaI0kE6A3LMaH/SzjujyAytcKeO52A6dQ2S9BjWQ
	EQwlbWyF6VFFI7HHa1exzlNfJGS75ij4styFavzGKqsllzBVhZ93WdRXzmzh1ZoXsgYAIliyJ6V
	Av69Eq6R7ViisfUm/iWYBRjjss756fZQb62uB2jg8tk1hWlVbHXARCDDm58mxE/hi0JfuuAh8lN
	zLWLNKuVRIM5mRWxw/choc2NczVkY74WuNg==
X-Received: by 2002:a05:693c:8946:10b0:369:f7d2:d7a0 with SMTP id 5a478bee46e88-36a20407ad2mr8606217eec.25.1793279510655;
        Thu, 29 Oct 2026 06:11:50 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a238d9a21sm18506359eec.4.2026.10.29.06.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 06:11:50 -0700 (PDT)
Message-ID: <3297224f-c2da-42eb-83ae-68ae275c06f9@kernel.dk>
Date: Thu, 29 Oct 2026 07:11:50 -0600
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/98] zloop: refuse zone files without read/write_iter
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 Damien Le Moal <dlemoal@kernel.org>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-16-axboe@kernel.dk> <auNCPdXOjqneFNsd@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <auNCPdXOjqneFNsd@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/26 6:55 AM, Christoph Hellwig wrote:
> On Wed, Oct 28, 2026 at 10:41:18AM -0600, Jens Axboe wrote:
>> +		return file;
>> +
>> +	/* Zone files are accessed with ->read_iter() and ->write_iter(). */
>> +	if ((oflags & O_ACCMODE) == O_RDWR &&
> 
> I don't think this checks makes any sense.
> 
> The proper fix here is to copy and paste loop_check_backing_file from
> loop.  I an prepare a patch for that.

Perfect, I'll drop this one.

-- 
Jens Axboe

