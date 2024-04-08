Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C262D13FD77
	for <linux-block@vger.kernel.org>; Mon,  8 Apr 2024 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712589501; cv=none; b=T31ySNULsfXeZgkgNT2SeATV2Xsk0brP/AsmZPAZl6o1urzUVcE/hfd33gUwwtj29qDd2BuvrAO8pECwXPRBa0ZK5oPierfIBJf43p8wZ9DD0+oVszNmFnD3QSP2ER7Ycoug4i2mHcgSdIglZgBJVLcmQ8uGHdFjCwqCg2l6CAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712589501; c=relaxed/simple;
	bh=yiHdSG0mXd1YMauTD9dApzRIRS+aHRtmApfD0zf6hJU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oGzATRzT4K4hq1AeVzV5p9/BuVQZRtXCna/q9eX7uX4n/T9yxd+QkcnpjDQPYTpeZGu23Eg6NwmixQOGI8KRVbQBbP7xDpmLntjVbKks9lxHaasLg/qQUxI5FMJ9Y7GtZGD+lg7mB5nLDnhOUM1zN8DAwUVk9RyCRb+/ylYl94Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poettering.net; spf=pass smtp.mailfrom=poettering.net; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poettering.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poettering.net
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id 0621CE80190
	for <linux-block@vger.kernel.org>; Mon,  8 Apr 2024 17:13:05 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 2A98B16019A; Mon,  8 Apr 2024 17:13:04 +0200 (CEST)
Date: Mon, 8 Apr 2024 17:13:03 +0200
From: Lennart Poettering <lennart@poettering.net>
To: linux-block@vger.kernel.org
Subject: API break, sysfs "capability" file
Message-ID: <ZhQJf8mzq_wipkBH@gardel-login>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

So this broke systemd:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e81cd5a983bb35dabd38ee472cf3fea1c63e0f23

We use the "capability" sysfs attr to figure out if a block device has
part scanning enabled or not. There seems to be no other API for
this. (We also use it in our test suite to see if devices match are
expectations, and older systemd/udev versions used to match agains it
from udev rules.)

The interface was part of sysfs, and documented:

https://www.kernel.org/doc/html/v5.5/block/capability.html

While it doesn't list the partscan bit it actually does document that
one is supposed to look into include/linux/genhd.h for the various
bits and their meanings. I'd argue that makes them API to some level.

Could this please be reverted? Just keeping the relevant bits (i.e. at
least the media change feature bit, and the part scanning bit) is
enough for retaining userspace compat.

(Please consider googling or a github code search or so before removing
a public API like this. This compat breakage was very much avoidable
with a tiny bit of googling.)

Lennart

--
Lennart Poettering, Berlin
