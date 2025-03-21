Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D45C2AD0C
	for <linux-block@vger.kernel.org>; Fri, 21 Mar 2025 04:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742533044; cv=none; b=dAZxnsD4iJUrGUoSH+aso1/r47EbetLr4yeIu33ISSNC3fLQVeFHr/+ulXEq6KTMcpUKsjZ16ZFepEvwD2UblUlRrGzFjqvr9AV52s6Cn1Nmw5YeYsWCpxPlr4S4g9cZzl/nv6AsEJPCzHFTeISdG7gv87RjWE8kndEZZOLLuIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742533044; c=relaxed/simple;
	bh=rRmUba39KTsEHOeZzHpKubZyYOoZt779v9WaFak49HI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LC8oyoFNgYX10WbyfWVWGiv55hnSVuk/KVPIMdaDhAMiataFEymJ7mTXuPL5rLtkz9TJG286JBpTQ/G23XLZMtFbFtw2zZJXixAbykPAdyVdYvTHcc0RJFSmqtdXiJwmoYnKtRsl6DBHskBN/EGSTdbaBlHML5TX6v7uz5+FXOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-222.bstnma.fios.verizon.net [173.48.82.222])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52L4u4WI017316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 00:56:04 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 131D02E010B; Fri, 21 Mar 2025 00:56:04 -0400 (EDT)
Date: Fri, 21 Mar 2025 00:56:04 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org, david@fromorbit.com,
        leon@kernel.org, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        axboe@kernel.dk, joro@8bytes.org, brauner@kernel.org, hare@suse.de,
        willy@infradead.org, john.g.garry@oracle.com, p.raghav@samsung.com,
        gost.dev@samsung.com, da.gomez@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] breaking the 512 KiB IO boundary on x86_64
Message-ID: <20250321045604.GA1161423@mit.edu>
References: <Z9v-1xjl7dD7Tr-H@bombadil.infradead.org>
 <87o6xvsfp7.fsf@gmail.com>
 <20250320213034.GG2803730@frogsfrogsfrogs>
 <87jz8jrv0q.fsf@gmail.com>
 <20250321030526.GW89034@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250321030526.GW89034@frogsfrogsfrogs>

On Thu, Mar 20, 2025 at 08:05:26PM -0700, Darrick J. Wong wrote:
> > So now applications need to be careful to not submit any direct-io &
> > buffered-io in parallel with such above patterns on a raw block device,
> > correct? That is what I would like to confirm.
> 
> I think that's correct, and kind of horrifying if true.  I wonder if
> ->invalidate_folio might be a reasonable way to clear the uptodate bits
> on the relevant parts of a large folio without having to split or remove
> it?

FWIW, I've always recommended not mixing DIO and buffered I/O, either
for filesystems or block device.

> > >> And IIUC, what Linux recommends is to never mix any kind of direct-io
> > >> and buffered-io when doing I/O on raw block devices, but I cannot find
> > >> this recommendation in any Documentation? So can someone please point me
> > >> one where we recommend this?
> > 
> > And this ^^^

From the open(2) man page, in the NOTES section:

    Applications should avoid mixing O_DIRECT and normal I/O to the
    same file, and especially to overlap‐ ping byte regions in the
    same file.  Even when the filesystem correctly handles the
    coherency issues in this situation, overall I/O throughput is
    likely to be slower than using either mode alone.  Likewise,
    applications should avoid mixing mmap(2) of files with direct I/O
    to the same files.

As I recall, in the eary days Linux's safety for DIO and Bufered I/O
was best efforts, and other Unix system the recommendation to "don't
mix the streams" was far stronger.  Even if it works reliably for
Linux, it's still something I recommend that people avoid if at all
possible.

						- Ted
