Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C76C1607AA
	for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738004057; cv=none; b=oDg3AqwNLL3PMPiERiRzDh2Rka2J6iuXyeLKBz7yTwU61tJIT1ObDuhMr3u/+m4fZCzPqjzPsK6lv9K6lqMhGO+mVDB9M6c1H9/3kvl6/aLhZ0nc2/vtzJqq4ovhYbp2Y8GfwISMuKd/wpvI2O0iLbj+fDifnEULowQi2PnVYho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738004057; c=relaxed/simple;
	bh=X4x6cLXxnF3YBraFA4F6G39tyFA7xGE5YQkjAwJ3eLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NnXwehCZC5T4aQs8nG5quq4cH4TKaM8zVjthZ8Eb/U/lo/jSaKpMjMA/W5ByxyGz67IA56xDb5tz7scNdPpk3XWfssdRMJc6ty/xd+jbHbZFLrjDv9HXbY0XLqoYxKXJPY2bIWgbvFQVvGWFmpf1oe/Ik9rRREiLPR+PiKilDZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CUkSXd6K; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CUkSXd6K"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-851c4ee2a37so324919139f.3
        for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 10:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738004051; x=1738608851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sIyBoJGroUyTZpx6n/1BSJQGh7wzm8syWELiQ274Xzo=;
        b=CUkSXd6KUtEIcmcYu6JIQW2snChjb1hurpE6rb/DTJY0sznoV0q/hv8u3gSCyattPJ
         2a9u9f/eZbpVNtJJn3x9x4wzOTNIKLqRmPOtbnkd0HShKFtUwqPFQyJoFYzl7ZeDmVBK
         vJu+ccmXi8HXtMNp4uJp/TH2x3+r/ITHgF47W5FJVswVo7VtXReIdZPvU8HQWUDp1rsI
         faUo5vGP10ckJ7IIGuuwAssmsKS8SQxAiWoQu6cwMs4SuVGc6lou/IeW1LZCRHMLzmR1
         9qmb7+gvjel7VHtNXHW916J2k4ga/ANfZN0IvEn6Fs7dA4VFdkX+5xlBqoLXVKJ26RF1
         GYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738004051; x=1738608851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sIyBoJGroUyTZpx6n/1BSJQGh7wzm8syWELiQ274Xzo=;
        b=lLpMZP54Ao/vQVYIFsITzJj1Nr0J2xmqGh12SIeIcwKLqtSDmXGqnQDl/s5aV1ei14
         /sGcfC9MQRQsyio1C53ISZtcAfP2ECKbmn4zzPYKR6Pro2BYbr90MVbMxTOo3pDlhDub
         ouOga3YA03rY6NOsxgoNOLaKaCNoQ+3sD2bu1rVTkZ+/ZEhyFDasQQ2X/y2+zLIG0V0W
         58x0eeczZ3vZwsXOi1XyLpGS6g4niHkyVlTwWQ1nMaLhftEFav4QI68XvNRaZeKEhCa9
         SgNKcK3A7n9RTjWDJKSUeq/QqSV0TJqIKGp25u16cnv0VBy4pNi/igwuePAreVC4wwHg
         ZYLg==
X-Forwarded-Encrypted: i=1; AJvYcCUFY5VmGcoSiwtQAE1xsUhrhY79jOuMcDa5GIfc9517F4+V/bRZlXhDhfA0WK0zz1DAZQKZ1H1LB4XQNA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq9cEZvqR3/2+sCyo8T2NHs0oJ/ASs3vNLVo99jYta+l4k2Zm3
	GO24gNLuFRiHgoFfrY4HxCR9OeeDOsyvnGWmiWLICbsV+pvGcoLdSkG6dKT4UgY=
X-Gm-Gg: ASbGncs4aYotppj2mvBLt56lP2thobk54tlvzdWetTkGaazct1TiidYoAIGNAPYqG/e
	qyhpfBBOBCHF+hKrSj48ds2qhPd5HfPEEVY9O1oOJDQHf3RRDG8udukg7VWa65ilSzh1A5HDUA3
	cTTu+LVlCE24N7R1XAeIvfG3eJNk363zn04ptaRUAMij1JW+CURhlfJRhJdgas9rWP9FCa1SX20
	Ts9ep//LlvJ8tOgfEfisrAjASSuygb6EDgbx6T/41mT6oMJ7e0lnT3VxDaOWzV9LhEkdJUhTOA/
	eg==
X-Google-Smtp-Source: AGHT+IFv9j+W6RuVCqdh4BJBXNTF9oEOZFuXXEm2c24r/6X+ifQU1oBGtRPGZlVEgbHvG/0hDG84JA==
X-Received: by 2002:a05:6602:6d1a:b0:84c:ea14:931f with SMTP id ca18e2360f4ac-851b627fbd6mr3512940939f.11.1738004051522;
        Mon, 27 Jan 2025 10:54:11 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8521dbb3acdsm288925439f.0.2025.01.27.10.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 10:54:10 -0800 (PST)
Message-ID: <108b6ae7-a272-482b-b3da-60f1fc6617ee@kernel.dk>
Date: Mon, 27 Jan 2025 11:54:09 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Direct I/O performance problems with 1GB pages
To: Andres Freund <andres@anarazel.de>, David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-block@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
 Jane Chu <jane.chu@oracle.com>, Pavel Begunkov <asml.silence@gmail.com>
References: <Z5WF9cA-RZKZ5lDN@casper.infradead.org>
 <e0ba55af-23c4-455e-9449-e74de652fb7c@redhat.com>
 <Z5euIf-OvrE1suWH@casper.infradead.org>
 <f3710cc4-cbbf-4f1e-93a0-9eb6697df2d3@redhat.com>
 <6ulkhmnl4rot5vrywoxvoewko7vbgkhypcwxjccghdu26kwsx5@bnseuzrsedte>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <6ulkhmnl4rot5vrywoxvoewko7vbgkhypcwxjccghdu26kwsx5@bnseuzrsedte>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/27/25 11:21 AM, Andres Freund wrote:
>> That's precisely what io-uring fixed buffers do :)
> 
> I looked at using them at some point - unfortunately it seems that there is
> just {READ,WRITE}_FIXED not {READV,WRITEV}_FIXED. It's *exceedingly* common
> for us to do reads/writes where source/target buffers aren't wholly
> contiguous. Thus - unless I am misunderstanding something, entirely plausible
> - using fixed buffers would unfortunately increase the number of IOs
> noticeably.
> 
> Should have sent an email about that...
> 
> I guess we could add some heuristic to use _FIXED if it doesn't require
> splitting an IO into too many sub-ios. But that seems pretty gnarly.

Adding Pavel, he's been working on support registered buffers with
readv/writev.

> I dimly recall that I also ran into some around using fixed buffers as a
> non-root user. It might just be the accounting of registered buffers as
> mlocked memory and the difficulty of configuring that across
> distributions. But I unfortunately don't remember any details anymore.

Should just be accounting.

-- 
Jens Axboe
