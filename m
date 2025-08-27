Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0DF1C84AE;
	Wed, 27 Aug 2025 19:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756323388; cv=none; b=RF96xcI0ZZa/sGxuHIDueve5eC6OQd24EG/V/MF9KvOy4m1GaguRHHRiSHh1qedlc8JaMjEwOgi8f0qpdS5TqUm0fodK3qob0eNikV14n7brtdFJDm0py3p2+q0f+Mw69zwkS4ebVHYeNRFbhLE2WCtdm59r/TIvkMjGJuGOrGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756323388; c=relaxed/simple;
	bh=AJPFjqR4bNUEgiq1AO3YdPthEswHpMhGIDudAn6Dyqo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ranEJ5/+QQe5SXtkMS97YHntjDnbRKS169H0s/rCkr+zPPqwAy2trJrHsyFvPQnaYQVVI1O0OWmFxOUB3jSqlSZobGwtko4MChDRMLMJ8brtE6lI7eR/E9KVA+SbW+xFNe5yJs20kRp8jNTCtYNCiVWCx8WF7WjeL3MmeXJtR6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de; spf=pass smtp.mailfrom=0pointer.de; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.de
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id 3C58BE81947;
	Wed, 27 Aug 2025 21:30:48 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 4915C16005E; Wed, 27 Aug 2025 21:30:46 +0200 (CEST)
Date: Wed, 27 Aug 2025 21:30:46 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajeev Mishra <rajeevm@hpe.com>
Subject: [REGRESSION] loopback block device on top of block devices don't
 work anymore
Message-ID: <aK9c5jJepHEWIONM@gardel-login>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Heya!

Recent kernels fail if it is attempted to create a loopback block
device on top of a block device (rather than a regular file), which is a
feature long supported on Linux kernels, and that systemd relies on
(specifically, systemd-repart does).

For example, this used to work:

losetup --find --show --offset=4096 --sizelimit=409600 /dev/nvme0n1

But now it doesn't anymore...

This is on 6.17rc3. My educated guess is that this is caused by
Rajeev's 8aa5a3b68ad144da49a3d17f165e6561255e3529, which tightened the
screws on validating the backing file's size, which now fails if the
backing file isn't actually a file, but a block device.

(But I didn't spend more time tracking this down.)

Lennart
