Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4395217BA9
	for <linux-block@vger.kernel.org>; Sat, 15 Jun 2024 08:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718438881; cv=none; b=LTLkySENfuFed8//gqAtUaKo7QcJaAj4N1WOAGsiXWDHUrnQjVTfFUzgvsGZ1s1saPF5idfjUv634ETwwZxMkw1BVPmp8wesK6fgbdVZZ3rpFVa8DMUI1DZ0epXZAvdYBUKVNJKtl86KVME/VgX18WTY7unTLIHfK20BycmQaQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718438881; c=relaxed/simple;
	bh=zpTDiiwYRHFfQwWxieiObPybAsuSt+nSdOvDRnB85dY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PouVOxefaoBRhFG2+uAaZ8+O42X6gbS5s245itWlEysfaXg0NY2GII/JeXo0XzIINVVevkL3N+MmlxeQj4zLX5D8037D7NSHkk/AebHAYv9Nf9FtU6DzkRjfLSYFtzP+K6Fv/1uezIm1zyV8gkIZLZ9L2c0LXFWzqbxGaxm0uH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=CjYg5+K2; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="CjYg5+K2"
Received: from macsyma.thunk.org ([154.16.192.69])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 45F87bPV000998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jun 2024 04:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1718438860; bh=+/ngTIzUuX7XPploPv7z+d8ZCh/mJEmERdsDc2gEMQs=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=CjYg5+K2+Wt1RLQ4rv/rviuM5Rz8VL+A3E1rEEB4T/+8o2YS/oBowYjanddtdm/0C
	 4G7N+4tRWRA3fPsh5hq/AIj1G0Pa4hCSMaH6i4rwrLmBScFI2VFgH9qDgGA6d8nrvD
	 2oQDe1t4ZrBpP5mRxtXccrh2xJ+Qaer0EQcL26vKfcUVwuOqEAIfL0XvDugL04HN1z
	 ge9vs5n04NZOimsUAZeWuYz9RnBKirMAW2GOKPLtdrvyZWugpczGMTfigg7a67WGNe
	 KCAMalwB9RtUKWGD88XTRBOVb0oKMdNjo0rL3EvmPVDHZvhQBQ4MSLrb1fNX9erl6P
	 n0GWoI8nalb+Q==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 3C980341697; Sat, 15 Jun 2024 10:07:37 +0200 (CEST)
Date: Sat, 15 Jun 2024 09:07:37 +0100
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org, netdev@vger.kernel.org,
        linux-mm@kvack.org, ksummit@lists.linux.dev,
        linux-security-module@vger.kernel.org
Subject: Re: Maintainers Summit 2024 Call for Topics
Message-ID: <20240615080737.GG1906022@mit.edu>
References: <20240531144957.GA301668@mit.edu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531144957.GA301668@mit.edu>

Many thanks to those who have submitted topics for the Maintainers
Summit and to the Kernel Summit track at the Linux Plumber's
Conference.

We have extended the deadline for Kernel Summit proposals by a week,
to June 23.  If you have something that you would like to share with
the kernel development community as a technical topic, or something
you'd like to porpose as a Maintainers Summit topic, please submit
your proposal in the next week!

Many thanks,

						- Ted

On Fri, May 31, 2024 at 04:49:57PM +0200, Theodore Ts'o wrote:
> This year, the Maintainers Summit will be held in Vienna, Austria on
> Tuesday, September 17th, 2024, just before the Linux Plumber's Conference
> (September 18--20th).
> 
> As in previous years, the Maintainers Summit is invite-only, where the
> primary focus will be process issues around Linux Kernel Development.
> It will be limited to 30 invitees and a handful of sponsored
> attendees.
> 
> Linus has generated a list of people for the program committee to
> consider.  People who suggest topics that should be discussed at the
> Maintainers Summit will also be added to the list for consideration.
> To make topic suggestions for the Maintainers Summit, please send
> e-mail to the ksummit@lists.linux.dev with a subject prefix of
> [MAINTAINERS SUMMIT].
> 
> To get the most out of our topic discussions, folks proposing a topic
> should also suggest relevant people and desired outcomes.
> 
> For an examples of past Maintainers Summit topics, please see these
> LWN articles:
> 
>  * 2023 https://lwn.net/Articles/951847/
>  * 2022 https://lwn.net/Articles/908320/
>  * 2021 https://lwn.net/Articles/870415/
> 
> The Kernel Summit is organized as a track which is run in parallel
> with the other tracks at the Linux Plumbers Conference (LPC), and is
> open to all registered attendees of LPC.  The goal of the Kernel
> Summit track will be to provide a forum to discuss specific technical
> issues that would be easier to resolve in person than over e-mail.
> The program committee will also consider "information sharing" topics
> if they are clearly of interest to the wider development community
> (i.e., advanced training in topics that would be useful to kernel
> developers).
> 
> To suggest a topic for the Kernel Summit, please do two things. by
> June 16th, 2024.  First, please tag your e-mail with [TECH TOPIC].  As
> before, please use a separate e-mail for each topic, and send the
> topic suggestions to the ksummit discussion list.
> 
> Secondly, please create a topic at the Linux Plumbers Conference
> proposal submission site and target it to the Kernel Summit track:
> 
> 	https://lpc.events/event/18/abstracts/
> 
> Please do both steps.  I'll try to notice if someone forgets one or
> the other, but your chances of making sure your proposal gets the
> necessary attention and consideration are maximized by submitting both
> to the mailing list and the web site.
> 
> 
> If you were not subscribed on to the kernel mailing list from
> last year (or if you had removed yourself after the kernel summit),
> you can subscribe by sending an e-mail to the address:
> 
>    ksummit+subscribe@lists.linux.dev
> 
> The program committee this year is composed of the following people:
> 
> Christian Brauner
> Jon Corbet
> Greg KH
> Sasha Levin
> Ted Ts'o
> Rafael J. Wysocki
> 
