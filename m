Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AB73FD152
	for <linux-block@vger.kernel.org>; Mon, 11 May 2026 15:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514118; cv=none; b=OOKiagJ5h5iZkiuiwNcfIvx8DkUhr8Kj/HTyM9Au+fM5Bu3TkyBcKdaVmbGUc82/lS/LepO7X8/BcM+W+TEfgHjp/5TjAeIjrXRtDas7ySWRfOkXvROqD7Pm3NoU1+XOAyFFFpyXM856gZNvL8Dn8n3eGdp5fsPWG1F6mEPzRsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514118; c=relaxed/simple;
	bh=kVG0WDPsto5l7ZUTqiWn5Cqkt7EpnbeAgtsdgTQEtD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKK0QrfBG6GQNOSu49vdF8a2UppF7TobaJdIYTrnwlRCmMSSvJGY1/H4H0lAdALPOnjzL1yYIXNsLaHF8X1yQT4cVvD05yOyUyZ2DA4Zo8HET5ZgFaz31MacmdaEU5waWlaakYB6NR8RCWFN+eeUE2FnysioJ9NdIw1FfTE57+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=TgswUlui; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="TgswUlui"
Received: from macsyma.thunk.org (pool-173-48-82-102.bstnma.fios.verizon.net [173.48.82.102])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 64BFfkGf012506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 11:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1778514108; bh=rkkf7GYy99no7sSxomt4p8c6EexRWWpSm7wuNfMKLIE=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=TgswUluicpDMnqN+xplQQqegb2mx2o+JcJ/m+Wz2zMrx/K4ByctL+Bm0mCKarKsYI
	 1hkV5v7rgK736DEuA9/SddYTryhkVcbXSD9j5vAksGmH2MbVtbz3OaFA/CtnIhc5kq
	 CFOdmyniVX7z7910dyC2b33IYF/izWyMo+fp7mCKR8XiWk1yviYACuZxDYnwYs7Inn
	 t8yaYw3agbTcvgaR853qEF/OIxdD9MKiQBUYwj0WSKX3d9y7yfOClRSqioKQHkFg7N
	 0qkmx2H59GK+QagkMQX6Ocvyd6wl5wT6TscGsY6HHPMEB7SHZnZqiLlkBgI2B61qzK
	 74kRLtbiYhAlA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 48DF86708EBF; Mon, 11 May 2026 11:40:46 -0400 (EDT)
Date: Mon, 11 May 2026 11:40:46 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: xfstests-bld kernel config and automated tsting (Was: blktests:
 status, expansion plan for the storage stack test framework)
Message-ID: <20260511154046.GA21199@macsyma-wired.lan>
References: <31a2a4c2-8c33-429a-a2b1-e1f3a0e90d72@nvidia.com>
 <agHGnYHo4HEKhYJb@shinmob>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agHGnYHo4HEKhYJb@shinmob>

On Mon, May 11, 2026 at 09:27:38PM +0900, Shin'ichiro Kawasaki wrote:
> 
> - For easier config:
>   - Ted has the config generation tool.
>   -> I'm interested in it, and would like to take a look.

The config generation tool is part of my xfstests-bld test appliance:

     https://github.com/tytso/xfstests-bld

I have blktests support integrated into gce-xfstests.  After setting
gce-xfstests per:

https://github.com/tytso/xfstests-bld/blob/master/Documentation/gce-xfstests.md

Using it is basically as simple as:

cd /usr/src/linux
install-kconfig --blktests
kbuild
gce-xfstests --blktests

The install-kconfig and kbuild scripts can be found in the
kernel-build directory in the xfstests-bld repo:

https://github.com/tytso/xfstests-bld/tree/master/kernel-build

Note: In addition to --blktests, install-kconfig supports other options,
including --lockdep, --kasan, --ubsan, --arch arm64, --kcsan, etc.


Unfortunately, blktests is currently not supported in kvm-xfstests
(aka qemu-xfstests, since it also works on MacOS's HVF).  It should be
possible, but currently kvm-xfstests doesn't suport modules, and
blktests is pretty fundamentally tied to modules.  With gce-xfstests,
we upload a kernel.deb install it in the system under test.  With
kvm-xfstests, we directly boot the kernel directly out of the build
tree, which is much faster (5 seconds from "kvm-xfstests shell" to
shell prompt)--- but doesn't support modules.


Projects to improve blktests in my test appliance:

   1. Add support for modules in kvm-xfstests and then enable blktests for
      kvm-xfstests.
   2. Add support for some kind of machine readable test results file
      (e.g., junit XML or  kTAP)

The reason why (2) is so interesting is that it allows for a
convenient report generation which summarizes the test run, e.g:

ext4/4k: 615 tests, 1 failures, 74 skipped, 4701 seconds
  Flaky: generic/234: 20% (1/5)
ext4/1k: 609 tests, 78 skipped, 5586 seconds
ext4/ext3: 607 tests, 159 skipped, 5044 seconds
ext4/encrypt: 590 tests, 191 skipped, 2768 seconds
ext4/nojournal: 607 tests, 1 failures, 158 skipped, 4111 seconds
  Flaky: generic/234: 20% (1/5)
ext4/ext3conv: 612 tests, 2 failures, 76 skipped, 5212 seconds
  Flaky: generic/234: 20% (1/5)   generic/409: 20% (1/5)
     
(Note: ext4/4k, ext4/1k, etc. are different file system test
scenarios, which run on a different VM)

The other reason why (2) is handy is that it enables using automated
bisection searches, e.g.:

   gce-xfstests ltm --repo linux-stable-gc -c ext4/4k generic/234 \
       --bisect-good v7.0.5 --bisect-bad linux-7.0.y

So if we had a machine-readable results file, ala xfstests's "check -R
xunit-quiet", I could add automated bisection for blktests failures to
gce-xfstests.

Cheers,

					- Ted

P.S.  For more information about my test-appliance system, see:

https://thunk.org/gce-xfstests
https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md
https://github.com/tytso/xfstests-bld/blob/master/Documentation/gce-xfstests.md


