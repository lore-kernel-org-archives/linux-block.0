Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0938C27281E
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781273413; cv=none; b=fjusFury9HclxBjR/tGMZNQAEq5+e6p5IFG+W75UVsyFcBydor/tI4RtdEtF+r6vXJzDPmSdi+epsIzsVlyc0XnEs7K3t43UtcDz1c74wTv7E3sBWi/r2x8oCx56xfMw3TwYsmcAaOIpidZY6gQGqNwaM/SNqLCQE58B8iWsgUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781273413; c=relaxed/simple;
	bh=SwcMhVo3e/OSlG5u9jKKasCTCA1E0yZ6CzAo5ieB8Pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1RB7tdbeRAfpAI2l5auP3XSxURBSX+xJsk6oxPaZ/jOexnc3ETAyMrfF2aHJPOG93QLX+6SZbyUCZQzicZgEOdKeazPn66xC6MCr3d+J1obAdugg2ndSp2FjPjmbQPl7UjWzBjPzoPmGeEluXpbI8LC9/C55EzkdCrFznakPPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tylXjQFX; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tylXjQFX"
Message-ID: <33309e37-e999-4c4c-a2b6-5eff22b1e933@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781273409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VgkFgiq3UgWO4mv31jMB1PbxwSyhPsMP6dnk06G777U=;
	b=tylXjQFXt9nqjJiTMazYQ6lwhdfPDtErq2oXG2P57stw+kOht1lpyupI4/HoeVo9nbbQUj
	TxlvRg0sqjAOU6uWisuUa52BhH0vLhbWuijbf01r6ibi9CZ7aQN3edFG+GoqhMcm6Hs1K/
	gTrNXgiGEmNhn5RufSkLile51kJd1Sk=
Date: Fri, 12 Jun 2026 16:10:06 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: configurable block error injection v5
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>, Damien Le Moal <dlemoal@kernel.org>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 linux-block@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260611140703.2401204-1-hch@lst.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Haris Iqbal <haris.iqbal@linux.dev>
In-Reply-To: <20260611140703.2401204-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/11/26 16:06, Christoph Hellwig wrote:
> Hi all,
> 
> this series adds a new configurable block error injection facility.
> We already have a few to inject block errors, but unfortunately most
> of them are either not very useful or hard to use, or both:
> 
>   - The fail_make_request failure injection point can't distinguish
>     different commands, different ranges in the file and can only injection
>     plain I/O errors.
>   - the should_fail_bio 'dynamic' failure injection has all the same issues
>     as fail_make_request
>   - dm-error can only fail all command in the table using BLK_STS_IOERR
>     and requires setting up a new block device
>   - dm-flakey and dm-dust allow all kinds of configurability, but still
>     don't have good error selection, no good support for non-read/write
>     commands and are limited to the dm table alignment requirements,
>     which for zoned devices enforces setting them up for an entire zone.
>     They also once again require setting up a stacked block device,
>     which is really annoying in harnesses like xfstests
> 
> This series adds a new debugfs-based block layer error injection
> that allows to configure what operations and ranges the injection
> applied to, and what status to return.  It also allows to configure a
> failure ratio similar to the xfs errortag injection.
> 
> Changes since v4:
>   - don't unlock in removeall to avoid a race between removeall and setup
>   - document why we can't match 0-sized bios
> 
> Changes since v3:
>   - use a static branch to guard the new condition
>   - split out a new header so that jump_label.h doesn't get pulled into
>     blk.h
>   - more checking for impossible conditions in blk_status_to_tag
>   - more spelling fixes
> 
> Changes since v2:
>   - improve the documentation a bit
>   - fix a spelling mistake in a comment
> 
> Changes since v1:
>   - drop the should_fail_bio removal and cleanup depending on it, as it's
>     used by eBPF programs and thus a hidden UABI.
>   - as a result split the code out to it's own Kconfig symbol
>   - various error handling fixed pointed out by Keith
>   - documentation spelling fixes pointed out by Randy
> 
> Diffstat:
>   Documentation/block/error-injection.rst |   59 +++++
>   Documentation/block/index.rst           |    1
>   block/Kconfig                           |    8
>   block/Makefile                          |    1
>   block/blk-core.c                        |   87 ++++++--
>   block/blk-sysfs.c                       |    5
>   block/blk.h                             |    3
>   block/error-injection.c                 |  315 ++++++++++++++++++++++++++++++++
>   block/error-injection.h                 |   21 ++
>   block/genhd.c                           |    4
>   include/linux/blkdev.h                  |    6
>   11 files changed, 490 insertions(+), 20 deletions(-)

Thank you for this series. It is a nice addition.


Reviewed-by: Md Haris Iqbal <haris.iqbal@linux.dev>
(for the whole series)

> 

