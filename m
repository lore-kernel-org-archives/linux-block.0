Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D54D24023E;
	Mon, 13 Jan 2025 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736781845; cv=none; b=ugiiLRm65uhLi+tgJYdoAQzUAXA4lWHzWm6Nzga0A/rXjXA9CCcPFUYvYp1nXdLLozJ1RXEp8lF0rvm1mnrkzlYIk4qpzpEm+Hz7fnyTedktfw48wwwgIATVefouj0PSLqIedWlzIjwLxernPzFMmGCrWYHk61arti6egp5twh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736781845; c=relaxed/simple;
	bh=Y4C88y0bn7yemxHxuSxh2GU1VXk+r1LxVa7cPbs2r/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wwaw1a9+iPkY6LS8wbXVPGnfJiEq9+ujwmf4+tKDWLa3FoqiInJEoag29QBq5nfYj72xXPKXEhlxlz0JkSPH5MyDX0RSFgSEyC99wyrzy/gjgKNkuRPXhzn5wvlKCQfJAt/jJzFGxBP8od7/C29kHHurKpJZhgVLW2IceF2JD6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcoBork1; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcoBork1"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaef00ab172so712579766b.3;
        Mon, 13 Jan 2025 07:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736781842; x=1737386642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g9hHRvdWIv3F+jnUoOkVpVXG9f4b9fdriEI3v5kii1U=;
        b=HcoBork1vElVNBzsPgp/O9uWqJxNBOAJBN5t4MEmA+EgVLayeUJt82mpdmAfLkTZ0k
         sdHF4TShVI8azqAt8e0Kvmm3AptJbzkwJ8NOkqSpaXGl4Mu3hyRFwsjMnAGPrdLC+fYw
         vSN57GjPT8QcoJ0u+Mi8djlp5SCCcBKmSKhqMX8eMjcvyg00QP6J83NK5NthrAV0sRGm
         LFLfMx2sEtlOGJTZQ1skjX7uWK/7WOoKyTQPzoCOpeWLrxb30MJKynC96hJKWjmh17R0
         deyQx6Ibi8QbA583XSM1Jw/a46nYVX4KwdbcW2/HNk8EZYGkzdzizObhEOmM6YeFgz32
         GbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736781842; x=1737386642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9hHRvdWIv3F+jnUoOkVpVXG9f4b9fdriEI3v5kii1U=;
        b=bzf2upgvRXeT/SaOs/0DtS9xcHZjROLYglAnXMVJ81isHGABFOLq3uu/xRfJOIaHjG
         RURVAjhF0/E13ohl3qVsf5u5T1OpuZm3GQTMwbYQV14YM6SYoBC8Rz/t4nBDM5XoqIYV
         by/lj988GBnGR+kkjjeVJqxb/Jk54cHoLdn9zb1DvAPc1xfu3gJSSOHVvaWHsYUBe+/8
         dP1o3CxP56YW9QqKwkoYwNhKlkux8m10mJPcBjdbvBlzWRUfbFr7sLXxQY9AAP01Ayip
         NGGOh33JnHaa7MEezWGVuUsNi15u8AHEp1gyOeV+w92aWgh6jRYBpZpOL5x20YvI0TZa
         buIA==
X-Forwarded-Encrypted: i=1; AJvYcCVb2BOXRMz4fODKgFJRjx0bZf8+JCvpEwyo4mbUbOTQEMEinPeYGhBhjz6sRbBp49/8FVnsvJp66suV9jHM@vger.kernel.org, AJvYcCWZGZVDA2W8xneYgie7qwEDDUa+mMMyiNm5zQOdLL6r89lo2yKuupzztSIv3lwVFy9u3bXl0G2ohrhnPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXikRmxBABDJMzigaEXe630evhgTvsWuv48Vb0Te3RJWAKiPsz
	nnDr4CIdbgH/yN2nSMLs6W0RgegBSZvnTWO4KRC9J5rFh4csDPdu
X-Gm-Gg: ASbGnctW9TrADzUPBaxeyVphFrUif8Sut4q2rv3FPp8X077Vj0+ixSo4vGE7haX0NZr
	BDInug+Hd/xMPkXmVxK93Lrv5fgethtwfoVabnL+bh7uwB3VDsT/vy58oSllPtLbMEScvkxI1AE
	iSC3Xuv35+I/aCJh/dS5kYEB7owYn4asdyAofZqHU7Asfno+qwhZbUXp1ZaZCKWu1HFN77X1ZIa
	dX7c99DSJd4bDphROL9jwohpfrQzqLFRFDHVPUGt8OFGbalGHb/332HCBYAp6z79w==
X-Google-Smtp-Source: AGHT+IFp9q5BqpiqnmEIEQZ9KMekGm9HnKIKXgsVhC0LmjI6TvAV9EQs0D5RE2AFUsi6ms0+LgB3ew==
X-Received: by 2002:a05:6402:26cf:b0:5d4:55e:f99e with SMTP id 4fb4d7f45d1cf-5d972e1d7dfmr52385362a12.18.1736781841946;
        Mon, 13 Jan 2025 07:24:01 -0800 (PST)
Received: from debian.local ([83.105.230.12])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9134403sm522348066b.90.2025.01.13.07.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 07:24:01 -0800 (PST)
Date: Mon, 13 Jan 2025 15:23:59 +0000
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
	yi1.lai@intel.com, syzkaller-bugs@googlegroups.com,
	regressions@lists.linux.dev
Subject: Re: [PATCH V2 3/3] block: model freeze & enter queue as lock for
 supporting lockdep
Message-ID: <Z4UwD64zKZqG_7gP@debian.local>
References: <20241025003722.3630252-1-ming.lei@redhat.com>
 <20241025003722.3630252-4-ming.lei@redhat.com>
 <ZyHV7xTccCwN8j7b@ly-workstation>
 <ZyHchfaUe2cEzFMm@fedora>
 <ZyHzb8ExdDG4b8lo@ly-workstation>
 <CAFj5m9+bL23T7mMwR7g_8umTzkNJa14n8AhR3_g6QjB2YCcc5A@mail.gmail.com>
 <ZyIM0dWzxC9zBIuf@ly-workstation>
 <ZyITwN0ihIFiz9M2@fedora>
 <Z0/K0bDHBUWlt0Hl@ly-workstation>
 <Z4Ulmv7e0-Q4wMGq@debian.local>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4Ulmv7e0-Q4wMGq@debian.local>

On Mon, Jan 13, 2025 at 02:39:22PM +0000, Chris Bainbridge wrote:
> Hi,
> 
> With latest mainline 6.13-rc6, I have been getting intermittent lock
> warnings when using a btrfs filesystem. The warnings bisect to this
> commit:
> 
> f1be1788a32e8fa63416ad4518bbd1a85a825c9d is the first bad commit
> commit f1be1788a32e8fa63416ad4518bbd1a85a825c9d
> Author: Ming Lei <ming.lei@redhat.com>
> Date:   Fri Oct 25 08:37:20 2024 +0800
> 
>     block: model freeze & enter queue as lock for supporting lockdep

I just read through this thread and noticed:

> The warning has been fixed by the following patches in for-6.14/block:
>
> blktrace: move copy_[to|from]_user() out of ->debugfs_lock
> blktrace: don't centralize grabbing q->debugfs_mutex in blk_trace_ioctl
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-6.14/block

I tested linux-block/for-6.14/block with a directory copy and did not
get the lockdep warning, so it looks like it might be the same issue
that has already been fixed (?). If so, it would be nice if the fix
could make it in to v6.13, otherwise many people will get hit with this
warning, and end up tracking it down and re-reporting it.

#regzbot title: intermittent block/fs/kswapd0 lockdep warning
#regzbot introduced: f1be1788a32e ^
