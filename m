Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ED2365
	for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 00:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710203338; cv=none; b=oacr+RvDDQqLyH/pt0lnbFw+7d1GzgmBkuhxFTLbrOHu9ome2N94JVoGG9VUx3MrjM7Bs7hg38XMDWe4N5GTjh4WXI8RdJne9nyhnknB1ZVneT6CdPuKPyonQRvkdi08PLt6ZcdWW/2sZZKgLl4QAjufKD0o3h+R4aXP+LtBKK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710203338; c=relaxed/simple;
	bh=bIEMZQSJ+VTf8lkIZGsjQrc+q1xSE1oT6q08tZQg5m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c++vjQiKwPDherS4YiGXZfgCxJTxeeABpmwU9KXjFvJrAbw0yGyXVEVMlYCH4LrZDM9jO8+d6Ap7XePxjd3A9QJXS5AP7gnTtQZULSPnjlnxtGgndiiUcUXmd2oH9QXwy8zggNLLAAGR4+LHAhFgqyB0+0YM0kEbA5Pf8prOR10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dd8f7d50c6so12685205ad.0
        for <linux-block@vger.kernel.org>; Mon, 11 Mar 2024 17:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710203336; x=1710808136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNiduUkWsDmsnxQfZflqFU2bptgIVV7MBusTsK18Jcw=;
        b=qEQLOPQKuRPZ7I8hyiNXEf4lu7r9vA40cbX+OD6oXCIUApe1IOkEle4pZn9TnoM8LB
         dMVcPeD8I821FulWcWBDWVq/ucu3Vdi+bq7/nhhDsvba4kOjLlbxC5A9SUGEKnNXfZXC
         TwbLxxdvt2cbocktwBK6Pvexk8eWxYJsZfmcXps36L38tB9YKraHvrqI/JjgHj8r/X22
         SuaRLc49+QXJfI1SkAaTDU9NsEva8qEtxI1D91S9MEM3kgvoar8E/1B6KPfk8+7Bqa6b
         Ye2dqTRKxHBuFJJYrRlj6+G/k46nlf2B1/rdarKX68mz1tY5PEueotvd3hGgNgQ3apy9
         ONoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWZ1iMrCWVJygI6dFpF44u1AwP088gT94nM7k6Pv7UKauwG7w0E12h85INOYM963o6JXtDIO9pBAp1hoN2WmBP1DrmKYEzKTykZAI=
X-Gm-Message-State: AOJu0Yw5/ydWffQ5b6e7EbIhvrVZU2R2MVtQ4hZtgEoZLyrMwed5zjzP
	xKMY6c5tsryccpvlpW+28YEZRjX28hPdM6JdoTy+IZKpEehjUoRWQc6kAAcmOA==
X-Google-Smtp-Source: AGHT+IHynuQn1yMVRGYJdQwAHHEoKvYgkAT8o079s/hKcWAa7K9StlvXxaoDFNDt5QUzACuJW7rstg==
X-Received: by 2002:a17:902:e9cc:b0:1dd:6285:b84a with SMTP id 12-20020a170902e9cc00b001dd6285b84amr9275992plk.9.1710203336085;
        Mon, 11 Mar 2024 17:28:56 -0700 (PDT)
Received: from localhost ([194.195.89.21])
        by smtp.gmail.com with ESMTPSA id u11-20020a170903124b00b001d8f81ecea1sm5339478plh.172.2024.03.11.17.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 17:28:55 -0700 (PDT)
Date: Mon, 11 Mar 2024 20:28:50 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [GIT PULL] Block updates for 6.9-rc1
Message-ID: <Ze-hwnd3ocfJc9xU@redhat.com>
References: <eaeec3b6-75c2-4b65-8c50-2d37450ccdd9@kernel.dk>
 <20240311235023.GA1205@cmpxchg.org>
 <CAHk-=wgOfw8NBQ2Qyh8QUjhp5z4v--PuciLE7drn5LJkTtgPVw@mail.gmail.com>
 <e3fea6c3-7704-46cd-b078-0c6e8d966474@kernel.dk>
 <CAHk-=wgXZ6dE1yHK_jQmnSjbEbndyzZHC5dJNsmQYTD2K-m61w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgXZ6dE1yHK_jQmnSjbEbndyzZHC5dJNsmQYTD2K-m61w@mail.gmail.com>

On Mon, Mar 11 2024 at  8:21P -0400,
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 11 Mar 2024 at 17:02, Jens Axboe <axboe@kernel.dk> wrote:
> >
> > Just revert that commit it for now.
> 
> Done.
> 
> I have to say, this is *not* some odd config here. It's literally a
> default Fedora setup with encrypted volumes.
> 
> So the fact that this got reported after I merged this shows a
> complete lack of testing.

Please see my other reply just now.  This breakage is new.  Obviously
cryptsetup's testsuite is lacking too because there wasn't any issue
for weeks now.

> It also makes me suspect that you do all your performance-testing on
> something that may show great performance, but isn't perhaps the best
> thing to actually use.
> 
> May I suggest you start looking at encrypted volumes, and do your
> performance work on those for a while?
> 
> Yes, it will suck to see the crypto overhead, but hey, it's also real
> life for real loads, so...

All for Jens being made to suffer with dm-crypt but I think we need a
proper root cause of what is happening for you and Johannes ;)

Mike
