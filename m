Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AE814F98
	for <linux-block@vger.kernel.org>; Thu,  9 Jan 2025 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736437891; cv=none; b=Co9j3EMbEpz+IMmRI4KSBEzafykkinFy0NhvR+OIsuRw/EEdnwBMFH0vfSBQDID+0obKQaLlLh1+t1Rlf2qRnwZ4RGW+pBLj8Gc1N84JaeKsIn+hkjsk4FSpoC0C3OPh3JRt2WxjMfZnuIFAQ6UI9hAYZAo0I6FvnVwzZnAJsJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736437891; c=relaxed/simple;
	bh=4aiYhWhM0g7QwkF5ksl0tVwtxnGmzyXfyE4QoE5rUjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2F0qd8vcCWmGZ8N480wS1JKErTQUbJwr1Hpj7WTmZiNXcsHzL1jq9Ha3jcNlWAILQRBze9In0zjvUPoe18BsdTKO0bS3hHrgyNDVzl0od+f2tuh4Y6TxU6rqbNnG3ig+FiUdROSxFpotpSj54JFhRICKbG/F8B5nhbg90J+MqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Es6LonE5; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Es6LonE5"
Received: from cwcc.thunk.org (pool-173-48-115-53.bstnma.fios.verizon.net [173.48.115.53])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 509FpKcp017820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Jan 2025 10:51:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1736437881; bh=8AaJlJVyf44Gqzx9KGrBZrl9Suzj2EPcpxvpZkAG8ts=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Es6LonE5RpXW2VtJUqI6+Wj2zBVvEkhXe8uOcgV0ib+StY4U6o7m1DUIxOR0BVJ3X
	 ISIigO6M299Se06tuMjK4OSfwuMoL3Hayx8qgmN8IG/p+USuABEvDehXq5LR0swPFX
	 8lVuMoCld92PWMl0MpE/xbZh+e1D28B2PaiMduYjZDz6vvDZb97Hp45GjMF3KgkiZW
	 eCVv+UrZhMaocVJr0+CGNKn6VBBbmAfEKKpL3zkUxVR1/aCjrAr6yWRSnalhFqNU/7
	 EXrsBikhF/RR5uXbOV9E6JQOaDN9bgvKT77MJjAoVawuerMFJXAincm1+0ESKviqHu
	 Rxus2iPAy09ag==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id EDD7E15C0137; Thu, 09 Jan 2025 10:51:19 -0500 (EST)
Date: Thu, 9 Jan 2025 10:51:19 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Travis Downs <travis.downs@gmail.com>
Cc: linux-block@vger.kernel.org
Subject: Re: Semantics of racy O_DIRECT writes
Message-ID: <20250109155119.GF1323402@mit.edu>
References: <CAOBGo4xx+88nZM=nqqgQU5RRiHP1QOqU4i2dDwXt7rF6K0gaUQ@mail.gmail.com>
 <20250109045743.GE1323402@mit.edu>
 <CAOBGo4w88v0tqDiTwAPP6OQLXHGdjx1oFKaB0oRY45dmC-D1_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOBGo4w88v0tqDiTwAPP6OQLXHGdjx1oFKaB0oRY45dmC-D1_Q@mail.gmail.com>

On Thu, Jan 09, 2025 at 11:16:41AM -0300, Travis Downs wrote:
>  - So the question is large about the possible outcomes of doing a zero-
>    copy O_DIRECT write (where the block driver will ultimately be reading
>    directly from the pages allocated by and passed to the kernel by the
>    userspace application) in the situation where a portion of the the passed
>    pages are modified in a racy way by the userspace application by a
>    subsequent O_DIRECT write.

Yeah, sorry, I thought "modified via memcpy() was via a memcpy to a
mmap'ed region", which would mean it's in the page cache.  If what you
mean one thread modifying a block while the O_DIRECT write is
underway, the answer is "it depends".  For non-Linux systems, it will
almost certainly be racy.

For Linux, if the block device is one that requires stable writes
(e.g., for iSCSI writes which include a checksum, or SCSI devices with
DIF/DIX enabled, or some software RAID 5 block device), where a racy
write might lead to an I/O error on the write or in the case of RAID
5, in the subsequent read of the block, Linux will protect against
this happening by marking the page read-only while the I/O is
underway, either if it's happening via buffered writeback or O_DIRECT
writes, and then marking the page read/write afterwards.  Doing this
has performance implications, since changing the page table and the
need to do global interprocessor interupts is not free.  So we only do
it for those block devices that require stable writes, and even if you
are interested in a Linux-only answer, it's still "it depends".

Cheers,

					- Ted
