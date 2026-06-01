Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AE9383C93;
	Mon,  1 Jun 2026 07:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297878; cv=none; b=oIwpK5RnVgZq6O0Am+rKhvNsVfgCZwkcPlYZbbLSpy9qhOLab1c4lKk7Mz2kpIlUwy8iStEyuV61UVNLeWVYlvGEAbHB3LpraRCKeZYeE7UaPwh4DNmpN4fqARyPo+UVBRB+1E3t00smKfcJezTQegDPXdIRGd3/SuBGiowIiyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297878; c=relaxed/simple;
	bh=e2WcsbfA2GPkjJayioLZwgzmO8oYsEwxsccbXZOSoZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnA9d7yjzDyMzLj/yFX3xVwMS733i3ivqvDPos9FBB49ecHxNcdL80PZ9sN9UQ5kWRq9lScPD4wvWFNjrwTL37K5P283HdeZTCi4iPIVlIU0zQJph7U1CWGnCqHZatUUPYQ6yu13+5kQtHwA8CAr7TO01Q+riN8v57f4cM6dJPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EEC1E68B05; Mon,  1 Jun 2026 09:11:13 +0200 (CEST)
Date: Mon, 1 Jun 2026 09:11:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ming Lei <tom.leiming@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Qu Wenruo <wqu@suse.com>, Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH] block: assign caller-specific lockdep class to
 disk->open_mutex
Message-ID: <20260601071113.GB7468@lst.de>
References: <147ed056-03d9-4214-b925-0f10fc00cf27@I-love.SAKURA.ne.jp> <4cf7ecc7-932c-4589-9d0f-3e025e83e27c@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cf7ecc7-932c-4589-9d0f-3e025e83e27c@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, May 30, 2026 at 02:15:04PM -0700, Bart Van Assche wrote:
> On 5/30/26 6:45 AM, Tetsuo Handa wrote:
>> -	static struct lock_class_key __key;				\
>> +	static struct lock_class_key __key[2];				\
> The two elements of this array have different roles. From the point of
> view of code readability and maintainability it's probably much better
> to make this a struct with two named members rather than a two-element
> array.

Exactly.

