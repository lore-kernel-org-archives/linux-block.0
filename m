Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831292F83B7
	for <linux-block@vger.kernel.org>; Thu, 19 Feb 2026 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511582; cv=none; b=Nu+o8jDrTcgXi78E9atG5/Z1zstPS4iVZpBOKlQksuCQnbIjVQCogAUE5l3doP0x30GD4wwyD0JYKkjlPLRlE0/8ulpCEEj0vjnjrrSurJ7mXHyCV7/U27wUbe32u/osmoTo8KWKX54Yl3fbTteEkt44rv+YS0IItH83NaXXQIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511582; c=relaxed/simple;
	bh=Pw0GMpTy/qByXkh48TxVsnzpcsyPbPsX//YI+H7wkFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9sHqkm0C0+jAtDOKmWinlRQ6de/19Ju2f9AJJNEHINVXADhYyraOahG90R0YacKZPY44ErP0P4+x0moH6YOW48J4OaXLL1FP0QSuHC829A6tb6L14/ufOuUQOJyb8vz6L+zOss6UxiBTBZCmwSn9LGYjbK1F2emof0jYwZAVFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=DEZWVjL0; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="DEZWVjL0"
Received: from macsyma.thunk.org (pool-173-48-113-47.bstnma.fios.verizon.net [173.48.113.47])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 61JEWgXE019467
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 09:32:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1771511565; bh=lIUfsf8JaxJ48qmG5xnIYm98ylX2DhnMOAxi5mf81Yg=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=DEZWVjL0xyfCBeyRW70yV9z+bT8dLBgE3Cr2B2R1FFbqVgTk3+cS79TVtarhMc2s9
	 y5zx36b7cGwjDDPIU1AWw8XobSbXIgAzVzvztzBkdZqcjFJNDQPiWezYsxlg+1EFp+
	 NAQuCoBvWIlevFLqB2dNFE6pFxImmljumqGA8fl4UQfqVke3xPXcQf6GsSGCmPKXmt
	 V4E5dQmrjeAAtwvTwwEDK9wAdOUwO6AYyEr05M2XZ20V4BpFkVWhICt9JfAkvDB29L
	 FNzhu9oZiB2WhB/N+ewidJlIJbLrRavHs4WbMGzOC0EMfOLieSFtmPS+RU1fyX5p0t
	 0rIcr3WomJl+Q==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id A4E16591BA5C; Thu, 19 Feb 2026 09:32:42 -0500 (EST)
Date: Thu, 19 Feb 2026 09:32:42 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Hannes Reinecke <hare@suse.de>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] Memory fragmentation with large block sizes
Message-ID: <20260219143242.GC69183@macsyma-wired.lan>
References: <f22caf98-1375-493a-a275-0500ffac3e81@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f22caf98-1375-493a-a275-0500ffac3e81@suse.de>

On Thu, Feb 19, 2026 at 10:54:48AM +0100, Hannes Reinecke wrote:
> Hi all,
> 
> I (together with the Czech Technical University) did some experiments trying
> to measure memory fragmentation with large block sizes.
> Testbed used was an nvme setup talking to a nvmet storage over
> the network.
> 
> Doing so raised some challenges:
> 
> - How do you _generate_ memory fragmentation? The MM subsystem is
>   precisely geared up to avoid it, so you would need to come up
>   with some idea how to defeat it. With the help from Willy I managed
>   to come up with something, but I really would like to discuss
>   what would be the best option here.

I'm trying to understand the goal of the experiment.  I'm guessing
that the goal was to see how much memory fragmentation would result
from using large block sizes with the control being to use, say, 4k
blocks.  Is that correct?

So I guess the question here is what are realstic workloads that
people would have in real world situations, so we can do the A-B
experiments to see what using LBS result in?

> - What is acceptable memory fragmentation? Are we good enough if the
>   measured fragmentation does not grow during the test runs?

I can think of two possible metrics.  The first is whether it results
in degradation of performance given certain real world workloads.

The second is whether given a particular memory pressure, the memory
fragmentation results in more jobs getting OOM killed.

	      	      	      	   	   - Ted
