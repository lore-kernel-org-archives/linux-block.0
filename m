Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09828487BE
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 10:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745057808; cv=none; b=USz2l8UbOU86qOdDavFYep1EYzotnnOttpQLJNiiTrWU/MsyC9qU+0mbhAHswmUCrjKe284vwY9MHz1ND67cOUzvizxsRqhBZgWF/bzyU+FzR4E7fSVdlMLZboBXhfowfx5YP2tCwk2WP/3lWYdsFijBGYUGsVcWi475ZvEag+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745057808; c=relaxed/simple;
	bh=6+s7R0Q03jASUqey+yKs0O0gKRZKzTkgZMkSbjHmNAQ=;
	h=From:Subject:To:Message-ID:Date:MIME-Version:Content-Type; b=vFp3Mm4h2JWWlF0++OxR9db+jzvVN8FZEK8OskkhhSKqw7EKJdSQDVrsvgRpNnH1SjU1+v1FeCfkOEjxZiRc7huXuKcB7X8ODXIjGwKJn54d0l+mJo6EcZRjci94+NeEwte03sn2rSPu0BMLzqy6s+AvMn3/GG2gO3flMLkIU9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5b07e9b7.dip0.t-ipconnect.de [91.7.233.183])
	by mail.itouring.de (Postfix) with ESMTPSA id 38ED41255FA
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 12:16:36 +0200 (CEST)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id 84D3360191E33
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 12:16:35 +0200 (CEST)
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Subject: Block device's sysfs setting getting lost after suspend-resume cycle
To: linux-block <linux-block@vger.kernel.org>
Organization: Applied Asynchrony, Inc.
Message-ID: <32c5ca62-eeef-5fb5-51f5-80dac4effc98@applied-asynchrony.com>
Date: Sat, 19 Apr 2025 12:16:35 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi!

I just noticed that sysfs settings now seem to get lost after
a suspend/resume cycle. In my case it's queue/read_ahead_kb,
which I configure with a udev rule. This has been working fine
for years.

We start out with:
$cat /sys/block/nvme0n1/queue/read_ahead_kb
128

Set a different value:
$echo 256 > /sys/block/nvme0n1/queue/read_ahead_kb
$cat /sys/block/nvme0n1/queue/read_ahead_kb
256

<suspend & resume>

Check again:
$cat /sys/block/nvme0n1/queue/read_ahead_kb
128

I'm reasonably sure it used to retain the configured value.
The same also happens with sd (SATA) devices on a different machine,
so it seems to be a generic problem with either block or sysfs.

This is with 6.14.3-rc2. I have unfortunately no idea when this
started to happen - i only noticed it now. Will trawl through
git history but wanted to see if this rings a bell with someone.

thanks,
Holger
