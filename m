Return-Path: <linux-block-owner@vger.kernel.org>
Received: from belmont79srvr.owm.bell.net ([184.150.200.79]:45476 "EHLO
	mtlfep01.bell.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751667AbcFVMax convert rfc822-to-8bit (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Wed, 22 Jun 2016 08:30:53 -0400
Subject: Re: parisc late boot crash in 4.4-rc, scsi-related
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
From: John David Anglin <dave.anglin@bell.net>
In-Reply-To: <alpine.LRH.2.20.1606221451310.11869@math.ut.ee>
Date: Wed, 22 Jun 2016 08:22:46 -0400
Cc: Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Message-Id: <EC4C2E5C-B18F-42A2-80AB-ABA286B7AA81@bell.net>
References: <alpine.LRH.2.20.1601082329270.23187@math.ut.ee> <56902D77.1020200@gmx.de> <alpine.LRH.2.20.1605162336050.12607@math.ut.ee> <9d1ae51e-69c3-c3f6-60aa-e5238dd18241@bell.net> <alpine.LRH.2.20.1606221451310.11869@math.ut.ee>
To: Meelis Roos <mroos@linux.ee>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2016-06-22, at 7:52 AM, Meelis Roos wrote:

>>>>> I noticed on RP3440 and A500 that recent 4.4-rc* crashes on boot.
>>>>> 
>>>>> I've not seen it with 4.4-rc yet, but I've seen it on debian kernel
>>>>> 4.3.3:
>>> This is still present in 4.6, just tested. All my pariscs are broken
>>> - A500, RP3410, RP3440. 4.3 is the latest working release for me. If
>>> 4.3.3 is broken, it might be possible to bisect more easily.
>> 
>> I believe this is fixed in current gcc versions (4.9 and latter). It was
>> exposed by a blk-merge
>> change.  It was fixed by this change:
> 
> Out of interest, how do other parisc users get the new compiler?

The Debian binaries have the change.

For development, I get gcc with svn from <https://gcc.gnu.org/>.  It is also possible to
use git to access the sources.

gcc -v should show how your current compiler was built.

> 
> What distro are you using?

We are using Debian unstable.  Helge and myself have setup an automated build system
with several buildds.  We are getting reasonable support from package maintainers.

Approximately, 11100 packages are available using apt-get:
https://buildd.debian.org/status/architecture.php?a=hppa&suite=sid
In terms of package counts, we are about equal to alpha, ppc64 and sparc64.

Helge has setup a Debian install disk.  Info on this is here:
https://parisc.wiki.kernel.org/index.php/Main_Page

> 
> My pariscs are gentoo and still only the old versions are available on 
> hppa.


Hope this helps,
Dave
--
John David Anglin	dave.anglin@bell.net



