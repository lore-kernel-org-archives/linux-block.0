Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A551AAC9
	for <linux-block@vger.kernel.org>; Thu,  9 Jan 2025 04:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736398677; cv=none; b=FGMDI2ESIclELHnrbH0q5ugrgCks7C5xarwPX3VssTBaV+yYMRx0r0p7N4x4WqjWRrhEDmlVO75sjLihTHFeuNAWajVHXnWxJTm6JMao2Fv1Bg5du0OiAaMKM+2zCjJ4BSqotlWLNiJk+CMk8nRH1IrjSBhxFQ/TcwrmA3PxEWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736398677; c=relaxed/simple;
	bh=+L51x9xUqGjUS62qW1huHmOORbzTw1amS4/WdPbPoOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jl8/mr93cfwORFcWVp5s/51FLuAJ9KxxeUR8XB0dsVOYAMa4jurb0L+LoSnW24HAvoaJf4ettkK8P83Rwe/Y6GSFYLjXcFCrfWYjaO4twRqyiYq8sZ6PemksYI4t4v7HGathrYc8hCFRV/nyt5DaYFrsTDSIGI+oDX9ljLz1H5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=NY85Vf8a; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="NY85Vf8a"
Received: from cwcc.thunk.org (pool-173-48-116-211.bstnma.fios.verizon.net [173.48.116.211])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5094vhPd010888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Jan 2025 23:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1736398664; bh=4igc/mM2Tjhse1Geg4vTgxp/w3pQbkhGpu9s3T+/i1I=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=NY85Vf8aYd8WBLXHDTLrZoeuO03B+YbIC6Vdd1FH8nnyXI4MLVsqz4dxqZcdLzRVQ
	 Pry1eAW3rK7CmuSmNntT+RU5UYtSgR/yQ9s+uVqqndfjtcOP9BCyn2WBPF4H9lYZth
	 eDKP6ulPH6HH2hu8SOreHRpD1qp2pb7W95zk998bCG5vQMyV6zjZWQsoNvRmuyQe10
	 RWKWSaFdq7RqyG0ufHrbnsndZenD7qzYe+2hSfDvHSVu/6IYyZFm6LpwZHJbaEBwzF
	 Nq9MV6WpcpDJt6N3hJ33+rpfJ/9loDyFAGH3nA5cTDHADazzFVVdqTDbXA0meedhUy
	 N8wJ3SDT2O9pw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 4B52515C0108; Wed, 08 Jan 2025 23:57:43 -0500 (EST)
Date: Wed, 8 Jan 2025 23:57:43 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Travis Downs <travis.downs@gmail.com>
Cc: linux-block@vger.kernel.org
Subject: Re: Semantics of racy O_DIRECT writes
Message-ID: <20250109045743.GE1323402@mit.edu>
References: <CAOBGo4xx+88nZM=nqqgQU5RRiHP1QOqU4i2dDwXt7rF6K0gaUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOBGo4xx+88nZM=nqqgQU5RRiHP1QOqU4i2dDwXt7rF6K0gaUQ@mail.gmail.com>

On Wed, Jan 08, 2025 at 01:33:07PM -0300, Travis Downs wrote:
> Hello linux-block,
> 
> We are experiencing data corruption in our storage intensive server
> application and are wondering about the semantics of "racy" O_DIRECT
> writes.
> 
> Normally we target XFS, but the question is a general one.
> 
> Specifically, imagine that we are writing a single 4K aligned page,
> with contents AB00 (each char being 1K bytes). We only care about
> the first 2048 bytes (the AB part). We are using libaio writes
> (io_submit) with O_DIRECT semantics. While the write is in flight,
> i.e.,
> after we have submitted it and before we reap it in io_getevents, the
> userspace application writes into second half of the page,
> changing it to ABCD (let's say via memcpy). The first half is not changed.
> 
> The question then is: is this safe in the sense that would result in
> ABxx being written where xx "is don't care"? Or could it do something
> crazier, like cause later writes to be ignored (e.g. if something in
> the kernel storage layer hashes the page for some purpose and
> this hash is out of sync with the page at the time it was captured, or
> something like that).
> 
> Of course, the easy answer is "don't do that", but I still want to
> know what happens if we do.

Don't do that.  Really.

First of all, your program might need to run on OS's other than Linux,
such as Legacy Unix systems, Mac OS X, etc, and officially, there is
zero guarantees about cache coherency between O_DIRECT writes and the
page cache.  So if you use O_DIRECT I/O and buffered I/O or mmap
access to a file.... all bet are off.

By definition O_DIRECT I/O bypasses the page cache, so if there is a
copy of the file's data block in the page cache, for some
implementations of some OS's the page cache might contain the previous
stale version of the block, so buffer reads might not have the updated
copy reflected by the O_DIRECT write.  And if the page is mmap'ed into
some process's address space, and the process dirties that page, that
page will get written back to the disk, potentially overwriting
O_DIRECT write.

Linux will make best efforts to maintain cache coherency between
O_DIRECT and the page cache.  It does that by writing out the page in
the page cache if it is dirty, and then evicting the the page from the
page cache.  In practice this will be good enough to keep programs
like a database which locks the database so it can take a consistent
snapshot, and then does the backup via buffered write, when the
database normally uses O_DIRECT for its transactions, it will work ---
since if the database wasn't locked while taking the backup, it would
be completely a mess, and the O_DIRECT vs page cache coherency is the
*least* of your worries.

But in general, don't mix bufered/mmap and O_DIRECT I/O to the same
file.  Just don't.  It might work, but remember that raison d'etre for
O_DIRECT is performance in support of databases and storage systems
where developers Know What They Are Doing(tm) and Follow The
Rules(tm).  Linux's cache coherency is best efforts only (and other
OS's might not even bother), and database developers and sysadmins
would be sad if we compromised O_DIRECT perforance just to make things
100% safe for people want to do things which are breaking the rules.

If you like breaking rules, don't use O_DIRECT.  You'll be happier for
it, as will hapless future users of your programs.  :-)

Remember, good programs are maintainable and portable.  What if some
one attempts to take your programs and tries to make it work on MacOS?

Cheers,

					- Ted

P.S.  I commend to you the ten commandments for C programmers,
especially the last one.  Remember, all the world's not Linux!
	   
      https://www.lysator.liu.se/c/ten-commandments.html
