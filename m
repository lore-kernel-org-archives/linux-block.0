Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FE54CDFD
	for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 18:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpPOn1su"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d3e416f303so17404745ad.0
        for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 10:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704910136; x=1705514936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8LMnQx2W0/C0sZnAs2bu/EDFWZs/fAlz6/Q7ipTzQ6g=;
        b=DpPOn1suS+BQ6qmklM1iyONOkWd06jahgizL24vhgsZOBJmJm4BCYulPY6WYPzCQVo
         B450Pot/VHswFyqs/679HuLGQ0fc7XtZyNl8P587/J8NS9fACbCwL0wGf+1fu2WcgXuW
         S4MpxpJPtIXZZ5bLRHAw+R3osMAg0Ni+X8eKD1tHRf5Vi53hVCJDV1WqrVlSmjyl8FLk
         rkkUBBhPNRGisk+3WSLf3ZGV+yoYUjkySOH6YJxpIeA7OHxuHiQK305v+4j0IYdk0Jfg
         MIS7po97dIsMa2q49/jndx6IZAC9pJcyL9eOMWGX4NTlVU4kSbGGW6hpSva2hKiKCu9/
         7FKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704910136; x=1705514936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LMnQx2W0/C0sZnAs2bu/EDFWZs/fAlz6/Q7ipTzQ6g=;
        b=ZXfUQ3LUwfo4OTFlhBZ/Y2M+T7NdP1Z4TUwRU4n6J008Dw8KQ73NQh7NX4vk/8eQoX
         zdOATLue+SKsRmOwB9xnYroQJBQsz2p9K5dv7gTTk4Qd/vHgXlttCuS0ocKaK6hXpSug
         xphhRJahaloSLplOUTax33zAPAknc3vYkC7DQfhDVHy4dQN/C42w3shAREkjBekB/ndo
         Z7V2PNEqKHn90mYgfbKVVImzbwX3xO4pC6sw9mQ3lW05m75eZMagZgxJbLpKOYrUbS+s
         ydca9wQkeUmu0/MfeUgE0eMmI58bo61RxK2Vti39J+7j110H/jOe8+tqEhfkLrExlT+S
         zi5w==
X-Gm-Message-State: AOJu0Yx7O6772LWRLhiVAjfBIN9ltrFb4aa93x+2yMQrKE2qd46Gu0yZ
	kAqNYEl3dFv/yOKchkveJs8=
X-Google-Smtp-Source: AGHT+IFLCzJucW0CW4fEwPQVu/BVknqTM5luvMhKi0bs/a0TdqDg8yVxDQrMNk0Fhe+FMsjPxwUH9w==
X-Received: by 2002:a17:903:2342:b0:1d4:b6e9:9e42 with SMTP id c2-20020a170903234200b001d4b6e99e42mr1371629plh.21.1704910135635;
        Wed, 10 Jan 2024 10:08:55 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902bc4a00b001d4c316e3dbsm3957961plz.114.2024.01.10.10.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 10:08:54 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 10 Jan 2024 08:08:53 -1000
From: Tejun Heo <tj@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block/iocost: silence warning on 'last_period'
 potentially being unused
Message-ID: <ZZ7dNfAZputj8DQH@slm.duckdns.org>
References: <06a7b6da-f3de-43cb-8ac5-bdd090a7d33b@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06a7b6da-f3de-43cb-8ac5-bdd090a7d33b@kernel.dk>

On Wed, Jan 10, 2024 at 08:32:19AM -0700, Jens Axboe wrote:
> If CONFIG_TRACEPOINTS isn't enabled, we assign this variable but then
> never use it. This can cause the compiler to complain about that:
> 
> block/blk-iocost.c:1264:6: warning: variable 'last_period' set but not used [-Wunused-but-set-variable]
>  1264 |         u64 last_period, cur_period;
>       |             ^
> 
> Rather than add ifdefs to guard this, just mark it __maybe_unused.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401102335.GiWdeIo9-lkp@intel.com/
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
