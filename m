Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF9C1D63F0
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 00:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774397790; cv=none; b=jVleAFTk6pDG1kITpXbRsVylRld4wqamHIYPVy2Sxva5WRsMnVtiMdEe9MbwFgF6H6Cd4ejwEsIk86OGhXh7wOIXGrVYyG12T4dqRoiTpB5P/daJ8exT9NNCZxpPFmzAJgHCIwFM4H0VFwwLGmWdLnczGjmek4MzwAcNxmwwXqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774397790; c=relaxed/simple;
	bh=MoLrdbwuxoKO2kYMSDxtCJV83ayachj6VWNdw0sH+RA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MpE9dRUwUCraCnkBlqoabExhQXANFPCw+5rC1821QmJHbMShnC+YRzgBxdUIsXAATwq+oUTRDVVsv5ZiprgtL27x+Tygp5I5Vsi8hql2oP5K3mBM3g8oGRipDWMRAj8UIjlSsbdqR0XUTthxrjL2dL/AqrbWcy4mQHDWxo2s7Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SYf+r95P; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SYf+r95P"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d7f9285560so2163003a34.1
        for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 17:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774397785; x=1775002585; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nUE46PPV8ZBQbSpBMaJf2P+/9B1olmom1CQ0qLARqFs=;
        b=SYf+r95PWmYPO1n7S4yEVApA92diDLGXIPneKoub13/8urv4UW65pHpy7F4JHtAEA+
         R3f6hdyMDSGmO4Tds0VFrI6pYtW1NpIleRv/oF2T8YQ1Jp6AqGbv/XCOrOSrNczV5suz
         9iE9z43zJrEnfAjpMIB7FaHArsxFNos4nItFpJpck7uyg2uxuK+9jdOrln9Suas8Xval
         tHEm5QRW2F2e3q50poeKOANZlSGPwVDmqSL68vwYQG2QhaZ/JMUle7UINTpSYr5n7s+g
         81OjuIAGSa/zmgMtPh0FDm+q6funlL2oOySjo0rg8pqUQNFLDkWQX67oymjyKZOpSoDF
         LFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774397785; x=1775002585;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nUE46PPV8ZBQbSpBMaJf2P+/9B1olmom1CQ0qLARqFs=;
        b=CkMveqqv2LCLceeGEgWGBiGEnajdzdK+KZYiXmv+5nle9WDn+GzhTZY1oruN7ftKVa
         3GupiNBx0wvvb8iJt+FGmJzVWlBaSvcbEDVESwpWsQLrAhS1kihVzXa6M9CYQytvSfm5
         MFEXB2rz7dEhIz5b0Z9AWveK3szyoPS6szTelNfMOKuiD8a7v7TaIwTH/xDv5V92wTze
         awIU8OW9tXli55KbVvOC/JBqBkXZZd3BZ2+mJq03DZWru12HbNh6RcHJzD9cGsojesZ8
         HV78E4pwCxVp/UoIFA+9h52z+3seYxJA8H5QS9dKsBFqAhF/uX0mPPZV9/5WO6+RD/ZZ
         brjg==
X-Forwarded-Encrypted: i=1; AJvYcCWU6CUGiUusT/7bsnLZqAeqbbA7d1Dv9AcB3wY7NkerDvLbFXKo/S8XvUQCFMg5ySNeI0MFkxQ/EwGxtA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXCsUnuV2nfAQ6rVIi0nos5CSWUN/UkUdujYyimCSYp6vtMVHc
	TOQhqu/Qkk+lQ4owmpk8z2LIMZ05I3OW8BqcL7tW48uqai7/i5HuIxH1KlrYb6rFRx8=
X-Gm-Gg: ATEYQzwv4lAepTfS/LOYSCYiOtrzdFPyFVGbFk6SZOAoZWaR6yowqG3py7b1rzi8Lqm
	SOchh1AviNux4ce9yjhXTAq0EBzle8/aCCVgGQ92Lf+ok8TFHRCHOwUt17pAx1zxz0FomJV1yW+
	NVVqWgN1Cw3dn1402xW0qAgMhmC5D9buKuxd9muoSjJpQ0IylBUHh+KCFJ4UAf9AC/B5Ki+fqli
	P5pnuilHf5mEoAwL2oibSVULKAYP9QYdAawBqWBUCZ0ylOTwKzL3eKe3R37me5smEOchN4xwY/x
	Dvyx+X+dArrZzzWVtpJAPHYh0t5Vsf7RwS5DD88YbX+IHsrHiPBE1iKplysRGZIdvNndCXvzPF9
	qBJ7dedIQ0Up20kbOGZNck2LIoSijV5bPwB0sNFGg+R4jEIcmQkzoA+0OHq1r0I0GoHp0YW+1la
	SJhYOwlofvZh3GzwQSL7MW6VA73UIwFmao3ICXUeKKbNbH1ZmLVNPu4xqY3BdTP127XBu9qznw0
	NAnGBOlyQ==
X-Received: by 2002:a05:6820:206:b0:67c:2bab:bf54 with SMTP id 006d021491bc7-67dff5f7978mr793373eaf.62.1774397785456;
        Tue, 24 Mar 2026 17:16:25 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c57bdf2b0sm9253351fac.7.2026.03.24.17.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 17:16:24 -0700 (PDT)
Message-ID: <1ec0b46f-a1b2-43f6-98ae-43bb87d0e59f@kernel.dk>
Date: Tue, 24 Mar 2026 18:16:23 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iomap: fix lockdep complaint when reads fail
To: Christoph Hellwig <hch@infradead.org>, "Darrick J. Wong"
 <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Zorro Lang <zlang@redhat.com>,
 linux-xfs@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>,
 linux-block@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20260319194303.efw4wcu7c4idhthz@doltdoltdolt>
 <20260320163444.GE6223@frogsfrogsfrogs> <acDbFtQw0mom798e@infradead.org>
 <20260323152231.GG6223@frogsfrogsfrogs>
 <20260323210017.GL6223@frogsfrogsfrogs> <acIrtFpASaBmFZPU@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <acIrtFpASaBmFZPU@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/26 12:14 AM, Christoph Hellwig wrote:
> Please reword the subject - your are not fixing a lockdep complain,
> but the underlying issue of calling code from the wrong context.
> Lockdeps as usual is just the messenger.
> 
>> Zorro's diagnosis makes sense, so the solution is to kick the failed
>> read handling to a workqueue much like we added for writeback ioends in
>> commit 294f54f849d846 ("fserror: fix lockdep complaint when igrabbing
>> inode").
> 
> The code looks ok, although I'd much prefer generalizing it.  I guess

I'll take a stab at it. This one is fine since it's an error handling
path, but previous tests I did with this kind of approach for every IO
hitting this path have been utterly terrible.

Once done though, we can swap stuff like this too.

IOW, for this one:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

