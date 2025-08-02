Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BF6165F16
	for <linux-block@vger.kernel.org>; Sat,  2 Aug 2025 21:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754170947; cv=none; b=hP+lvEY9IxRk90lmCNUCWgXO1lHBMZ5rgRSPWdiZXwLvf9hCQMHjJFLOOgVguGD4RzyAUf9Ua9d6hPTXER4mH4EW4lIdb8m6afzDwAwavHLIVtamozJ7DtS0nD1tR6Y4uB3JQtW6khB70gh9zsukvYDQUJwgfzXjv+t3kmpVHZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754170947; c=relaxed/simple;
	bh=N745ciBY1hkF7XOnVB7x2+NHVTlKQ7Y/QCqDpmqIc7U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aL0GHNtpKHDYbB1COsXXykiGQg9CiCMXC6/nwjYq+/EVdKdii4De+T5PKgOE6iF4YBFVLrxBKbrpfm9lqbXWyTCvnXSXKySN7JMuFSWkZON/K68qucex6ku0XZ5GXdVEuffgtP4yng+gn6uoLIoVamnmjEX1eK/kfZxFHH6kTC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=stCQoJ0g; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="stCQoJ0g"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3e406ca2d22so10298495ab.1
        for <linux-block@vger.kernel.org>; Sat, 02 Aug 2025 14:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754170943; x=1754775743; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oFuoIDlgW+h7v2LHl/HRGX0OhwDuWjqOAfS9sfbSbEo=;
        b=stCQoJ0goDtUd9Cs4+QXK2izpq6iJkWSzWsA9JEgGUCahemt47TvNH7JxueJniC9op
         kRhQC2XgS/1R/ql9n0Up1ZkaEPXJTeb4HDWe0eHivPfDtXHvYv3L+WHjPGaVja9GvSaY
         YWlmJ+ZESayMUolJ9FlBFiEz6nW9BvUXM01Gg2AE1BXILdBzFXSqWtQ5qOzeR37g9cGn
         NdjotcJ4XYZA+4hrayC7fHhkxTYKCOrQLWEWV0mB+mgmvSDfB+aLugImLJpoNyYHjWfr
         lFfCseF7mYUvUO4glu+9nwzMdAKkTmsRYMxxKLdDW09zqKcT7JHDfEg6wusu96MAEc/n
         YExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754170943; x=1754775743;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oFuoIDlgW+h7v2LHl/HRGX0OhwDuWjqOAfS9sfbSbEo=;
        b=WiZSx6GE1YB/PgoDwi4ZX9wRKODC8sg7Thx2RpdoWzGnkzS7GdEpC8oyR7SKmi5YGV
         ix//sSxzsuOt4tLbSRhSaYJrthiBLcHa1voXZbaI90SaGRV7KnU7//Hu3SmUR73YGQo1
         L0UmOLeTvTRik2O+Qjujok//7xzH7NXh0CwX7lWzI0Y8NClPIh0s3Fe31jAo+lxpJQvv
         lrmUVJLSTAMmk8oS1tKfff+lGkXM4HR2H0eJOSHknG3wltqFcBIKXPI0d2u/Tcoo4Uj5
         mXqtw4qZFLPIcb9wAt95uoGV/rGvAHdj3md47bgSe+qmg3GoBiI5HJ3+Gpn7mhX8xYm1
         fOJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ20SNG19RZH3O3hsG4m21KCsqzr7+DvZiBOe4Dqst+sP8kSG05BxBzXCK2Eyb6roJqH0DlPQQfOMLAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLb8z7ZnUYadflA3Zx4j3axJ1dHcMn7r3Zfl4lSsUqcXkpibfH
	1bqjDR527n/rgoPyLeMFBtigfpXKh11fLR9AIWY3T+Vx+os2DTk66owmtd57c4ZFzbU=
X-Gm-Gg: ASbGncuj5QO3fR0U5dwdxfOfT3kr4b6sHjLdXQwCeRzieqtEQqB1IcSiufxIgHTOnT1
	eglbosY1UZgJgcQYbK+orbOao0xxQxFt8gkyxJlf4A8uwPOb+jSz6rgIOXfA8Lt0vsg9p7eOUTu
	oSjsFd09xPW5/kZxtalDPyZUJuULfHH3a5WB5nTda7IemfF3umkohOaFFEZrCkkLKHG1DtYwP38
	NtS0IHb6HLTMdauusDz8SxC43TWlIDEFeyr2/0/eRaKpCdec01lupE3v91xRiYbqdPaR8hx2B7Z
	X0TwEn5+Mt3JssRH5lcaiBllhBPZYiGWAfDSnzvHQ53NwTebrE8UhSL1Qix3o387rJ5d/n2Gwvv
	NYIkm9walwjpcraOUK3QFOP9ZsvOrFg==
X-Google-Smtp-Source: AGHT+IFJp6txnZ87IMnvGshOLoul1tDwvotSon4D1I4ukQAYX7s2i1BeJR8Mk4VRnjQn+VJ4DpDbog==
X-Received: by 2002:a05:6e02:b:b0:3e2:aafc:a7f with SMTP id e9e14a558f8ab-3e416122d83mr92452065ab.7.1754170943147;
        Sat, 02 Aug 2025 14:42:23 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e402b12e8asm28043035ab.48.2025.08.02.14.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Aug 2025 14:42:22 -0700 (PDT)
Message-ID: <f02514c1-6f29-4029-a80f-f68202a863d0@kernel.dk>
Date: Sat, 2 Aug 2025 15:42:21 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] md-6.17-20250803
From: Jens Axboe <axboe@kernel.dk>
To: Yu Kuai <yukuai@kernel.org>, linux-block@vger.kernel.org,
 inux-raid@vger.kernel.org, song@kernel.org
Cc: yukuai3@huawei.com, yangerkun@huawei.com, yi.zhang@huawei.com,
 johnny.chenyi@huawei.com, xni@redhat.com, heming.zhao@suse.com,
 linan122@huawei.com
References: <20250802172507.7561-1-yukuai@kernel.org>
 <0c680f7d-f656-4e79-8e1e-b6f2e5155a80@kernel.dk>
Content-Language: en-US
In-Reply-To: <0c680f7d-f656-4e79-8e1e-b6f2e5155a80@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/2/25 12:29 PM, Jens Axboe wrote:
> On 8/2/25 11:25 AM, Yu Kuai wrote:
>> Hi, Jens
>>
>> Please consider pulling following changes on your block-6.17 branch,
>> this pull request contains:
>>
>> - mddev null-ptr-dereference fix, by Erkun
>> - md-cluster fail to remove the faulty disk regression fix, by Heming
>> - minor cleanup, by Li Nan
>> - mdadm lifetime regression fix reported by syzkaller, by Yu Kuai
>> - experimental feature: introduce new lockless bitmap, by Yu Kuai
> 
> Why was this sent in so late? You're at least a week later sending in
> big changes for the merge window, as we're already half way through it.
> Generally anything big should land in my tree a week before the merge
> window OPENS, not a week into it.

I took a closer look, because perhaps you just sent in the pull request
pretty late. And it's a bit hard to tell because it looks like you
rebased this code (why?), but at least the lockless bitmap code looks
like it was finished up inside the merge window. That looks late. The
rest looks more reasonably timed, just rebased for some reason.

If I'm going to get yelled at by a traveling Linus, there better be a
good reason for it. In other words, is there a justification for the
lockless bitmap code being in there?

-- 
Jens Axboe
