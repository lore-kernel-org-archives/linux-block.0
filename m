Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483313FF1
	for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 00:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710201733; cv=none; b=OX5xxqwqJbnjAHStgfkXqbOztFZ1xcH87NGOy+d99VlgkU/yVl2oRA33T/qDHXGFVGVz9niI96gE6KSG1kcRw8v9XFH7sXp1mJxHdwi7nnMelsqnS6ZNCcQ8IOD03ZWf3hFTOVWrUVrSMj33rIuoZPLg/I6mf8wFJzPbP9lbK8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710201733; c=relaxed/simple;
	bh=GvJI0U2iXY8CYcK1R+8IIsZEEi51TM5drEPlvT/9rcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qOXlDfwvBYQuwrCDA0A+L0e/GuTy+/wyYoCQ/H4NSmtwqZRckjMRnLlFMWwG0jS+eiYFPlzO03f0AgoaXwuWk7Q7G1YgfohVvdpnVcoq7Uf1t41QlZkOabgdPiyyh8EzFxrKmK9KSRQo5XtUV6+pqh27PbTNJ91N5urPpiTaLQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=G0LiYF31; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="G0LiYF31"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dd6d4832dcso5946085ad.0
        for <linux-block@vger.kernel.org>; Mon, 11 Mar 2024 17:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710201730; x=1710806530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E+XP/9ihyoW60w+ZsSx0KuX4dCdljphnN7o6z13FQuQ=;
        b=G0LiYF31hKYPdZF0QDDYe0ngkbU5EiUiGSXJX2aPF5Jvo9YbmqEWRToJHTlZgjAGDM
         HMQci4Cw7My3fKNnY8TccEawDgI+VSrlKWTnQb3c4ir7Kj0/M2VVKTOEThCyRKsJF2Xy
         AYrEIEvZ6Kg9OLwEaIk6+rGLVPW2wNC5BJQI28Jb7REbbOKMzeN6Q4UOxrrMjvfm9uFJ
         i49dt1lou5nst9qeSLLt4R7ILD+3YRsagMBaYeXDeDXcbtOpeVelaw8RwmkUylr+YnNx
         W/PRtQP6JD1QcHZvofryJBjY1zV/MERIzw5vUnwmEe3LTXdQEuz/MaIX6dKlICJe9hQr
         WLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710201730; x=1710806530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E+XP/9ihyoW60w+ZsSx0KuX4dCdljphnN7o6z13FQuQ=;
        b=lfZgzYRNPzuYiHVupGdYMYn6zoPcq2AT6jzuHPf1jk6nNq5BGKWiud8HQTVvARHXfk
         K+pWB2jmAlnIdXccr0cNWZJDTuRaSUt3pIkFeYp4XkLmXpL+A188DQcLRw1bjG8o+CVu
         uvyDZl/khmx59bfFZC712lJgpy1KE2Hq6dZCiRo985kcun5y1bVG2zXFC/7yFKiThq16
         jPcLmBCAe45nGsqew9UGcTgS1TOS+06UNBQO4FWhbRhmxUQh4Op5o7D0UJB3C0agekGp
         ecXbMog8A8QcniTxlSAf3e92tWHbFTXHkXD8aUM30VwEXlSxsdkexIyBVMvaPi+Z6xcY
         T1Aw==
X-Gm-Message-State: AOJu0YxgQTh/IXew3GhUg4Ckp/qLwXo5KP/bPVi4MZiIavq2CSw4Jke4
	uqKZWUWDY0QdcjySOko0AcH/vHi3/EuH2SMEOA9tuz8zeEOwI5Xn1rrzzMhtr54=
X-Google-Smtp-Source: AGHT+IHyGibCJP2/y8ab3N/BD2CAxjaceeUKUWTQpyIj64DX5xQTD4vWS6vhR0eKeHBNPbXRql95jA==
X-Received: by 2002:a17:90a:ad89:b0:29b:e0c5:2d90 with SMTP id s9-20020a17090aad8900b0029be0c52d90mr496859pjq.0.1710201730043;
        Mon, 11 Mar 2024 17:02:10 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id ft22-20020a17090b0f9600b0029beb8023b7sm3081394pjb.25.2024.03.11.17.02.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 17:02:09 -0700 (PDT)
Message-ID: <e3fea6c3-7704-46cd-b078-0c6e8d966474@kernel.dk>
Date: Mon, 11 Mar 2024 18:02:08 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Block updates for 6.9-rc1
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Mike Snitzer <snitzer@kernel.org>
References: <eaeec3b6-75c2-4b65-8c50-2d37450ccdd9@kernel.dk>
 <20240311235023.GA1205@cmpxchg.org>
 <CAHk-=wgOfw8NBQ2Qyh8QUjhp5z4v--PuciLE7drn5LJkTtgPVw@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wgOfw8NBQ2Qyh8QUjhp5z4v--PuciLE7drn5LJkTtgPVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/24 5:58 PM, Linus Torvalds wrote:
> On Mon, 11 Mar 2024 at 16:50, Johannes Weiner <hannes@cmpxchg.org> wrote:
>>
>> My desktop fails to decrypt /home on boot with this:
> 
> Yup. Same here. I'm actually in the middle of bisect, just got to the
> block pull, and was going to report that the pull was broken.
> 
> I don't have a full bisect done yet.

Just revert that commit it for now. Christoph has a pending fix, but it
wasn't reported against this pretty standard use case. Very odd that
we haven't seen that yet.

Sorry about that!

-- 
Jens Axboe


