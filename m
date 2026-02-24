Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613F5145A05
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 01:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771895575; cv=none; b=Gahb39w4BDxEB5efuXEfZ6BfxUphSxGegl9eV/OukJPOz7PBmEPTRVqa1RpoY+z7VQiJE04DFci7cJZ3R46KTP/UPQwBRgALZY/urk+TfKmFQJDXluTjdNGOQCxeTum8BZZfPq1hd372N871O6p/w+BL9SlZguHXOXF0T6g3+hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771895575; c=relaxed/simple;
	bh=johsvsWjrk8Y57dSXcGbZGQH4IkCGmrGJtDtc8uLSxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mRDcZ4/IuosbbRVCPSXqudQdcZ6wy+FsYQPce2b4vwMhLFWW4khG8DvrU+4Cjmdqy0dsxa599QO+fN7+BCIYPyoCX9Wyr/2e432msOzUdjscVp1MUM80YOyzniebqCctVA3Jk/0pnpFDeUscBPdOJeobNcBs+o7oIjB10AUp5jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELo0kR07; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELo0kR07"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9114BC116C6;
	Tue, 24 Feb 2026 01:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771895575;
	bh=johsvsWjrk8Y57dSXcGbZGQH4IkCGmrGJtDtc8uLSxA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ELo0kR079iwePzjDjzYE3qs7lmBSxtyyCokNSvDo45oLDnCFqBYgyvcdOzKTmXdIn
	 zZsbm1qrG8txi6iCEsSHs3AunEvj0wwCbpMXrIyzPXWQj+H3XYH1a1DW/zoCv2bvt7
	 zkE7PyDHznvvjeSxG0/UQB86Y6rqaC3db3sOwq9zx6w7IiGZn/QQlvDanjH2MRWGmw
	 1Qv3W2dxeF+YfL5Red4kAxjstsPbq9bQ6T+gXRDFvuQ4V4+lWmmBaL/r7d5Dtg59kD
	 Gs4EYEVgp2G/reYVlwuTA2hfGQ7cSMU+y0pgqqgsQeDNwU+GEVHEkcV/5JhUy2JNrF
	 AbZPbBlfBGNDQ==
Message-ID: <99c22bd8-2898-4b72-91bb-e80847cda065@kernel.org>
Date: Tue, 24 Feb 2026 10:07:38 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Improve zoned (SMR) HDD write throughput
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20260221004411.548482-1-dlemoal@kernel.org>
 <3ea1b7da-0639-4cf7-a8b4-132b26eedba8@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <3ea1b7da-0639-4cf7-a8b4-132b26eedba8@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/24/26 2:03 AM, Bart Van Assche wrote:
> On 2/20/26 4:44 PM, Damien Le Moal wrote:
>> This patch series cleans up the zone write plugging code and introduces
>> the ability to issue all write BIOs from a single context (a kthread)
>> instead of allowing multiple zones to be written at the same time using
>> a per zone work. As shown in patch 6, raw block device tests and XFS
>> tests with an SMR HDD show that this can significantly increase write
>> throughput (up to 40% over the current zone write plugging).
> Hi Damien,
> 
> Is a new kthread necessary? Has the following approach been considered?
> * Make the dm drivers that support rotational zoned storage devices
>   request-based instead of bio-based.

What you are suggesting would be an enormous amount of work (dm-linear,
dm-flakey, dm-error, dm-crypt) to change generic code into DM targets that
would be very specialized for just SMR HDDs. I do not understand why you think
that would be a good idea.

> * Modify blk_mq_get_tag() such that only one tag can be allocated at a
>   time for zoned write requests.

Sure, doing that would limit the number of write requests to zones to 1 at most
at any time, but that would also result in a total loss of control over which
zone write BIO work gets that single tag, meaning that the writes would in the
end be mostly random again, like they are now. So with this solution, I can say
goodbye to the +40% write throughput increase that I am seeing with the kthread.

Also note that this idea of limiting write tags combined with your idea of
using req based DM targets would likely negatively impact dm-crypt performance
as we would lose the ability to encrypt multiple writes in parallel on
different CPUs.

> I think that would be sufficient to serialize zoned writes. Additionally, this
> approach doesn't increase request processing latency
> by forcing a context switch to a kthread.

This point is in my opinion moot because we currently use work items to issue
the write commands. We are scheduling the zone write plugs BIO works in the
submission and completion path, so the context switch overhead is already
there. And would argue that using work items is potentially even more overhead
than using a fixed kthread since the work items need to be assigned to CPUs and
worker threads.

Granted, your point is valid for a QD=1 workload. In this case, I am indeed
introducing a context switch where there is none now. But that is not really
the use case we are looking at here. File system writeback does not happen at
QD=1 per zone. Also, this added overhead does not really matter for HDDs
anyway, and if that is really an issue, the user can enable the legacy zone
write plugging behavior with "echo 0 > /sys/block/sdX/queue/zoned_qd1_writes".

-- 
Damien Le Moal
Western Digital Research
