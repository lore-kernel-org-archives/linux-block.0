Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A32056754
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705999788; cv=none; b=LRF0ao8+MhdUx5v0SHsU0jm2eeLPNSWL6m+L5OUBGNUiQkMIRkhcC0VDzS7uYcb4Iq+iR2Mw9Rw04+LU8ENKCYCvJfGvpAoFD9RK15GapmkgXZJvrbj2ZfwHJ7ijvTzZbv0Ad0ZG2lUppYXz/jZdWriv9ZNAGyk5bmJazB5CZnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705999788; c=relaxed/simple;
	bh=m7Bxr6C3dWl+isy1ZLzMhTw7oNf5zzOpJV9iVJ4aixg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=D2FzRFCHPBSuoowkOX1jSKJL4+qzn8A3yFbaDmpMz/8RQ4GYH3jnYZSM5PMxrOZL56dQkA24jprQxNaygmP4E/KuY1Nzyq4JsC+JG1J9HuhARoONrcKK9cTrei3IrNPlSR5aeALxynCMwGmPMvYdJhDmpfig8i+2GPJ4YGA/gqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3B03E68C4E; Tue, 23 Jan 2024 09:49:43 +0100 (CET)
Date: Tue, 23 Jan 2024 09:49:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: can we drop the bio based path in null_blk
Message-ID: <20240123084942.GA29949@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)

As we found out recently null_blk never splits bios in bio mode, thus
ignoring a lot of it's paramters and having buggy zoned device
handling.

Is there any good reason to keep this mode around given that all relevant
hardware drivers use blk-mq, and the non-so-relevant ones not using
blk-mq probably should?
