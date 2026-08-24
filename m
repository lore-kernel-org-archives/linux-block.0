Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22E83546F2
	for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 03:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787540701; cv=none; b=tGP4wVSPtV93lcsriIzuDiAb7yKeDKBxnlP7KQXv07GW43kj5MvBXn4/CWB8LVYcKuzlQa4ht/etPQrS8kKqFqx+v75CbJgTeFcluYehr0oI2istvNmlyYgvAvvF0jY4u/s2llm1ClzFBXoKZy8LU1bKFRifltiF9Xyqc1fneME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787540701; c=relaxed/simple;
	bh=nqMDqsqhxs5e+V1s7RrmEAKnvbAoI/GJhjYm8d5OW6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZf/zk2cALShsh1h83Kamc7SnhDWxbbBSXTEiMnXAUfz51dfyCXzX/AAnvDkw5qN8xMaY/z7CXEzZsrTX/4W2iqyi+81ISKHv23UTEM1voYvazWaARyaPvJM8Bb43W8LfH0gAuxobQlMA450+0nHmmHVJoPon3EmJz8DTN1zakw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=EvdRxAfl; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="EvdRxAfl"
Received: from macsyma.thunk.org (pool-173-48-113-140.bstnma.fios.verizon.net [173.48.113.140])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 67O34VBk017750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Aug 2026 23:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1787540673; bh=tKqX+L6ZLJVmfVKhZd8rWovTBPXmNU+zAyqE2eAvC/A=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=EvdRxAflE5W4Xhz1HzW2k0hfaLk56ENSbYsB8Ouu7MBIX4rR/b8/z/ycIcOIN9VSy
	 BWgQtqLO1P3VP5Bj0dIPKczYOhDtgkdWpwpjNYvg2Idj/dDp/zlWOD1UMkEJqlYeo2
	 M8Y2KvtxgxNkYTew1WLCvXOrhCl51WCzCxxJS9ppxRMgWQhJQYMpzAWZsOdxOAJ5Yc
	 T5LLT48r938rvbFSFQMsNlgX4oQclIeAPoKLGQhq25YlXq55/s1T7GLM82UxHAmhWs
	 ejHKOcJ2zt4uUOMhiubJ61dSBuqkPyJwLduQIbJ0IPrgt5BWXdMFAeXX+/QojP8KNZ
	 VcPOrFaGvnxyA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 0158D119F7E9; Sun, 23 Aug 2026 23:03:30 -0400 (EDT)
Date: Sun, 23 Aug 2026 23:03:30 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Noah Bergbauer <noah@ehvag.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: Seagate Flex SMR
Message-ID: <aousthEkcIvpKYKg@mit.edu>
References: <d5ff28e5-53a3-481c-870f-f6115e82f4ed@ehvag.de>
 <47d4430d-ccc0-44e0-bfa1-98fd1129af6a@kernel.org>
 <88cfe0e2-4930-44c5-a1a3-45f95c8577e5@ehvag.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88cfe0e2-4930-44c5-a1a3-45f95c8577e5@ehvag.de>

On Sun, Aug 23, 2026 at 06:45:49PM -0500, Noah Bergbauer wrote:
> > "Flex SMR" is not referring to any standard feature. So it is hard to see what
> > you are talking about. In Linux, we support only drives that follow a standard,
> > so for HDDs, that is SPC/SBC/ZBC for SAS drives and ACS/ZAC for SATA.
> 
> The specification can be found in T10/18-007r0. It's not exactly ZD/ZR as it
> seems to predate those standards, but it's close.

Flex SMR refers to an early Seagate proposal for something which we
pushed for at Google called Hybrid SMR.  (See the Disks for Data
Center Paper / Keynote from the FAST 2016 conference).  Western
Digital countered with something called the REALMS API, and this got
hashed out in the standards committee, with a resulting set of ZAC and
SBC commands which include "REPORT REALMS", "REPORT ZONE DOMAINS" and
"ZONE ACTIVATE".  The basic idea is that zones can be activated and
deactivated, and when a set of SMR zones is activated a portion of the
disk platter corresponding to a set of CMR zones might get
deactivated, such that the contents of the deactivated zones would be
lost, but all other parts of the disk would be unaffected.

It is a feature standardized in T10 and T13, but it's not particularly
popular.  HOWEVER, all disks purchased by Google have firmware which
support these commands, and we have multiple HDD vendors who are our
suppliers.  It had been our hope that other hyperscalers would find
this useful.  Unfortunately, the programming model was far too complex
for most HDD users, and so I wasn't aware of anyone other than Google
using it.

This has saved us a huge amount of storage TCO costs at Google, and it
is how I earned my promotion to Senior Staff Engineer.  So I can say
that it is a useful feature, and we're using it to this day.

> > The reason is that properly supporting the zone domains/zone realms feature is
> > *extremely hard*. This is full of gotcha and plenty of things will not be
> > backward compatible with pure SMR support that we have. E.g. SOBR and
> > conventional zones are very different before the SOBR zone is fully written.

Yes.  Zome Domains/Realms is a completely different model from the
traditional SMR, and I *knew* it would be very hard to get it
upstream.  Given that we were using a userspace Cluster Filesystem
(e.g, Colossus), we really didn't need kernel support, since we could
manage the CMR and SMR zones from userspace.

Unfortunately, some of our operational requirements meant that it
could never be fully compatible with SMR, since we wanted disks to be
compatible with traditional CMR disks from the factory, but we then
wanted to be able to dynamically convert portions of the disks back
and forth between SMR and CMR in a non-destructive fashion for the
portion of the platter that was not converted.  This was a key part of
the storage cost savings, and we were able to convince our HDD
suppliers to support us in the T10/T13 standards committees to produce
something that would meet our requirements.

> To be clear, what I have implemented is all about running a filesystem in
> domain 1. And I want to push back a little on your claim that this is
> extremely hard, because in a handful of small patches totaling around 500
> lines of code I have found solutions for all of these challenges. I am
> running btrfs on the sequential zones and it passes every test I have thrown
> at it. I can show you the code if you like.

The hard part is what do you do with the deactived zones in domain 0?
Attempts to read or write into the deactived zones will result in SCSI
errors, so making it work in a way that allows you to have some
percentage of your disk that has the IOPS-optimzied CMR volumes, or
the bytes-optimized SMR volumes is the tricky bit, especially if you
are trying to be backwards compatible with local disk file systems
using partitions.

I suppose if you only allow zone activation/deactivations to be done
only when partitions are created or removed, it could be made simpler,
but that removes a lot of the actual storage TCO advantage of Hybrid
SMR disks.  (We can perform the SMR<->CMR conversions while the disk
is serving as part of the Colossus cluster file system, and that was a
key requirement for how to justify the SWE investment of our Hybrid
SMR project, and my spending a lot of time travelling to T10 standards
meetings.  :-)

> The use case is that these drives exist, they're out there, and with a
> little bit of kernel work we could squeeze a few extra terabytes out of each
> and every one of them by leveraging their SMR capabilities. That's a clear
> win to me. Yes, they don't entirely follow the latest standards, but to me
> this is no different than the many device-specific quirks already supported
> by the kernel. And apart from the Flex-specific discovery procedure, all of
> this work should be usable for supporting other ZR/ZD drives in the future.

Oh, they are standardized, but it's just not a very commercially
successful standard.  (Sort of like Object Based Disks, except there
is a hyperscaler which is actually still using Zone Realm/Domain
disks, and in fact all disks purchased by that hyperscaler have the
feature.  So arguably more successful than OBD, but not as successful
as we had hoped.)

The surprising thing to me is that there are people outside of my
company who are interested.  You have to be running at a pretty large
scale before the Storage TCO benefits dominate the SWE investment
costs, and while I did try to get other hyperscalers interested, they
had already invested in alternative technologies, and so we weren't
able to lower our Hybrid SMR costs by making it a more commonly
demanded feature in the marketplace.

Cheers,

						- Ted
