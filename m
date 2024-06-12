Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD4517F388
	for <linux-block@vger.kernel.org>; Wed, 12 Jun 2024 14:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203977; cv=none; b=a1O9Lj02CysynPc7aifstW/I/+ExXrKfC+nH+SUtcDYrQl7EcBiHvu4VF1BkXkf1Ez7s8wFKAYDxytlwKMm9g4MpScf2Zn8avvZ2w4bfvN9pZ4MjnYHJkTNFaqoUyZHKJrgIab61GMAHHzklYyq5i7Lv1bVBDTCE0gXgcUgT0oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203977; c=relaxed/simple;
	bh=63uDnaLNPzf7zYzjBBak3Mlpdy0J42gOZiMjhyZQs3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghfN99Ml1dTWtySBeenrtZqBBpYfkKyyXsIWG5oOBpkS7g5YgZOTgXQ1jZGLMKmf8CNCivo7dAwb71d+O4jNw1Z1zuaPFjpoYyt66sCcHShYjmoh9ZKN6a9YsiGZjJMQkjVeEzI0ADzLv3wysaXrdbbjX15as5gnChHwS+GbnmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=PPcurIWF; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="PPcurIWF"
Received: from macsyma.thunk.org (unn-37-19-197-214.datapacket.com [37.19.197.214] (may be forged))
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 45CEqWtO008694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 10:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1718203956; bh=Ad/lS1KWrRm2Xarx3jCuFG9NWf2VJ632aU+pWHVzie4=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=PPcurIWFchb2ph0NOrKu1dfvAgQTefNT5cBb0QiCyd2Fz4Ngk03gVLv9R670Z10Py
	 7InoHeMYTRZ7Ij9b40IUne+q7d1kq1UJk4OOF1ai8LYJ9r74bLaeywrar44/dv+bjL
	 TE2Rh8bAqm3iOCtcKy2VfqB44oWHh9VTM1LR95Ew6j9KLbOY3dXkaLOwTqzhfoAAZv
	 JaHTl1BaeDrRHnhRxWj/g4s5SIWXvG+j70tXlaRo67TVvWk815iTHTBrpCo51IG2bs
	 SiHoOuLOYzLd1Z9dZcOqQmMRBCnkZKOlEbpQtbJ3+R/zDwB8YJvgkmiq8/L6rt3bHR
	 SMZG9OHY76C6w==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 7124034167F; Wed, 12 Jun 2024 16:47:16 +0200 (CEST)
Date: Wed, 12 Jun 2024 15:47:16 +0100
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
        Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: Flaky test: generic/085
Message-ID: <20240612144716.GB1906022@mit.edu>
References: <20240611085210.GA1838544@mit.edu>
 <20240611163701.GK52977@frogsfrogsfrogs>
 <20240612-abdrehen-popkultur-80006c9e4c8d@brauner>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612-abdrehen-popkultur-80006c9e4c8d@brauner>

On Wed, Jun 12, 2024 at 01:25:07PM +0200, Christian Brauner wrote:
> I've been trying to reproduce this with pmem yesterday and wasn't able to.
> 
> What's the kernel config and test config that's used?
>

The kernel config can be found here:

https://github.com/tytso/xfstests-bld/blob/master/kernel-build/kernel-configs/config-6.1

Drop it into .config in the build directory of any kernel sources
newer than 6.1, and then run "make olddefconfig".  This is all
automated in the install-kconfig script which I use:

https://github.com/tytso/xfstests-bld/blob/master/kernel-build/install-kconfig

The VM has 4 CPU's, and 26GiB of memory, and kernel is booted with the
boot command line options "memmap=4G!9G memmap=9G!14G", which sets up
fake /dev/pmem0 and /dev/pmem1 devices backed by RAM.  This is my poor
engineer's way of testing DAX without needing to get access to
expensive VM's with pmem.  :-)

I'm assuming this is a timing-dependant bug which is easiest to
trigger on fast devices, so a ramdisk might also work.  FWIW, I also
can see failures relatively frequently using the ext4/nojournal
configuration on a SSD-backed cloud block device (GCE's Persistent
Disk SSD product).

As a result, if you grab my xfstests-bld repo from github, and then
run "qemu-xfstests -c ext4/nojournal C 20 generic/085" it should
also reproduce.  See the Documentation/kvm-quickstart.md for more details.

						- Ted
