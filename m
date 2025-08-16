Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF34C8EB
	for <linux-block@vger.kernel.org>; Sat, 16 Aug 2025 03:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755316764; cv=none; b=ccPJXc9T4Yf76x0KB0R9012iZ2t2AGk7mRTt07VDrIjpUhF5ZD1aTi5VV2KqEd/Kpk81UCdG/jcwyOZhaDHKe6YKu2wwWsk89euvHFyxcWzH2WTHvIBJFASoK/y0bSq2mGEGdO6cBfdWpQMbyYF6+/D4NpxzIesAAKH0XIBOuVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755316764; c=relaxed/simple;
	bh=pDbDhl9mZv6YLOIQGkM/1TbyRvXr+3dh3J5l1kFok3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcRlEyghiZ6O/DIFXGwNFipF/LEwtMSL/BrBtqiO77CW9mdNY0KX8hoQQ6PMPvQE9pIfKP8b9K80+GQAE05AgfD2b50HcARILB/SnEAdccGEsrvHkPHJDZYwum+6edaSwFPp7C/HJ7TzcqdD6JjdIc4IY32NdO92fMXe1Ea9kDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aexm62Sm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aexm62Sm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D37C4CEEF;
	Sat, 16 Aug 2025 03:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755316764;
	bh=pDbDhl9mZv6YLOIQGkM/1TbyRvXr+3dh3J5l1kFok3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Aexm62Sm/TlF+2Po1yWuwBCFaXE749W/mS6XmXGz80agCpIyH7KpB4Rps+VjziJLm
	 fiOu87Sr1fErxlTdtbmSrTs2bCWquIo8/nqplnFx+ceYJAJqRJddydu10bH9E37jF1
	 dD7z8RaJtr7oQHqeEpJ6ntkAQmu7rxQNl0+7/EuWVW2H6nksIwM4tS5XLentbecYsy
	 z8WLATGMNgxdHVJpioAkfSZn5A8K5+xHgiVP5ekPUzvSbhKEMV/KS7YTDpL9Jtm9a5
	 h7kSFDUwpNXKpGvV/hi0H9cGOWoN3TXOq05UX2r6Kc63heATN5YPxtUpszYxmNvaL8
	 80ACOjxihzXgA==
Date: Fri, 15 Aug 2025 21:59:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Teng Qin <palmtenor@gmail.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org,
	hch@lst.de, axboe@kernel.dk, sagi@grimberg.me,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: Question on setting IO polling behavior and documentations
Message-ID: <aKACGfROBeAGixs0@kbusch-mbp>
References: <CAHumS0BE_28D47d3Ls5PJBONTzVUCA54QwTV5UhJdDhnfCEi4A@mail.gmail.com>
 <36eb61d6-971a-4177-aa62-75197460c33d@huaweicloud.com>
 <CAHumS0Ddg7wj50jvoR1Z9dJrXeizz+=4k7Az0qB_9QH-tAhvQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHumS0Ddg7wj50jvoR1Z9dJrXeizz+=4k7Az0qB_9QH-tAhvQA@mail.gmail.com>

On Thu, Aug 14, 2025 at 06:35:01PM -0400, Teng Qin wrote:
> On Thu, Aug 14, 2025 at 5:31 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
> >
> > Hi,
> >
> > 在 2025/08/14 13:14, Teng Qin 写道:
> >> Moreover, the block layer documentation at
> >>    Documentation/ABI/stable/sysfs-block
> >> still documents the legacy behavior of the io_poll sysfs file. This is
> >> confusing for users trying to figure out reason of the failed or
> >> unexpected behavior after writing to the file and seeing the dmesg,
> >> particularly because there are many articles on the Internet describing
> >> the legacy behavior.
> >> If the maintainers agree, I can help update these documentations.
> >
> > Feel free to update the documentations, AFAIK, there are some out of
> > date descriptions and it's welcome to fix them
> 
> Thanks a lot for the information. Before writing anything, I just
> want to confirm there is indeed no more per-device control for
> polling behavior? Is io_uring and driver-specific features like
> nvme passthrough the only ways to go right now?
> 
> For users who have legacy applications that could benefit from
> polling but still make traditional IO calls, would it still
> make sense to add a per-device override? I can think of some
> ways of adding a config for a specific device so it would
> tag all bio-s for that device as polling (if queue capable).
> But I'm not sure if that has been discussed before or maybe
> that was intentionally discouraged? Would love to hear from
> the maintainers for opinion.

You can only reach the polling features through io_uring. You can use it
with normal read/write uring commands, or the nvme passthrough uring
commands. Successfully using it requires you have set up your module
parameters to reserve some queues for polling.

The synchronous calls (preadv2/pwritev2) had polling capabilities
removed due to issues. Here's the commit that removed it:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9650b453a3d4b1b8ed4ea8bcb9b40109608d1faf
