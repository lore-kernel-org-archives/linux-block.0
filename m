Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D916136A
	for <linux-block@vger.kernel.org>; Sat,  4 Jan 2025 00:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735951665; cv=none; b=Z6t2B73H5eiCOzyZxO42GpdLrMF7ZzMw/G9ssE2yzg/KeWFS1lQ12W2PeKyJdM9nt7yzOqyCclmIQx8JoxLS/ZfnD6bCNVLjNzAL6X9fObFNFLtMDhWvJ0zyNcpQsA9YrOcmBAaIFlPh3j/ZS65udGtxNLDUT8rQXv8ic5FbxTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735951665; c=relaxed/simple;
	bh=yEaUBgo1yau1DDTPF+2uzp61/6hpMEXHDmq4IRtUy/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=McAWpsaclXSKp61sJUnQaI+hGIE8smoZLDmPNmKyIQUpzGkzz8pzMJ/W5dJ8Xy8eWPAHP0DFuKJfxC7qwVJEfLIm+tZmXdplFHU8g+pyTTC/71nrFgW3YBteKRUWAqL8yXPqDXsOsGnBp7b4ffWwze6zHKPaTnPRl2KJca2YeU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SOuEypC3; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SOuEypC3"
Message-ID: <906201cc-2d16-4c34-9443-737b53a8a07f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1735951659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+n3QEmeRfRYM23xSEzJP15ZH0somRZNJRx2eiFF6O8=;
	b=SOuEypC3LA+C/nZaQZz/rmfGZiSB0532CA884XVFpOxhEXGv9uTy75Pw1R0cWirbkbaG9+
	7rcSgODLQc5TYieLQ/f6QWJQ+HScL7gu6GraJG5601n89SG0Gb3k3sfv2vJouCnDmLyBLL
	VUkIwvK6sz+F6WmbNm8BHiPWRGpTPj8=
Date: Sat, 4 Jan 2025 01:47:36 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints for
 Next-Generation Backup Systems
To: Vishnu ks <ksvishnu56@gmail.com>, lsf-pc@lists.linux-foundation.org
Cc: linux-block@vger.kernel.org, bpf@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/1/1 7:34, Vishnu ks 写道:
> Dear Community,
> 
> I would like to propose a discussion topic regarding the enhancement
> of block layer tracepoints, which could fundamentally transform how
> backup and recovery systems operate on Linux.
> 
> Current Scenario:
> 
> - I'm developing a continuous data protection system using eBPF to
> monitor block request completions

I am interested in this "eBPF to monitor block request". Will this eBPF 
make difference on the performance of the whole system? And how to use 
eBPF to implement this feature? Hope to join the meeting to listen to 
this topic.

Best Regards,

Zhu Yanjun

> - The system aims to achieve reliable live data replication for block devices
> Current tracepoints present challenges in capturing the complete
> lifecycle of write operations
> 
> Potential Impact:
> 
> - Transform Linux Backup Systems:
> - Enable true continuous data protection at block level
> - Eliminate backup windows by capturing changes in real-time
> - Reduce recovery point objectives (RPO) to near-zero
> - Allow point-in-time recovery at block granularity
> 
> Current Technical Limitations:
> 
> - Inconsistent visibility into write operation completion
> - Gaps between write operations and actual data flushes
> - Potential missing instrumentation points
> - Challenges in ensuring data consistency across replicated volumes
> 
> Proposed Improvements:
> 
> - Additional tracepoints for better write operation visibility
> - Optimal placement of existing tracepoints
> - New instrumentation points for reliable block-level monitoring
> 
> Implementation Considerations:
> 
> - Performance impact of additional tracepoints
> - Integration with existing block layer infrastructure
> - Compatibility with various storage backends
> - Requirements for consistent backup state
> 
> These improvements could revolutionize how we approach backup and
> recovery on Linux systems:
> 
> - Move from periodic snapshots to continuous data protection
> - Enable more granular recovery options
> - Reduce system overhead during backup operations
> - Improve reliability of backup systems
> - Enhance disaster recovery capabilities
> 
> This discussion would benefit both the block layer and BPF
> communities, as well as the broader Linux ecosystem, particularly
> enterprises requiring robust backup and recovery solutions.
> 
> Looking forward to the community's thoughts and feedback.
> 
> Best regards,

