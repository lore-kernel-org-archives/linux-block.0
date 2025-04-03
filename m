Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2960219E97A
	for <linux-block@vger.kernel.org>; Thu,  3 Apr 2025 05:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743659103; cv=none; b=MmABJM4VwG2NLyv+8izvzVhfIrmLI7H7ekTgOxQS0ER3aBs/WjCu4a7wtRnEmxukJGTueG/miQQSmDJTrvT+qyB7GReiqdTYnHIcK2XCAhVFVUH8Pza8uQ9oXovYIdVXfDesMsBbhOle4Ff7W7WUIss/DOaQADjLIZMNydpmJjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743659103; c=relaxed/simple;
	bh=Isrn58Gso0pJvdDkrZw7TvJWASXuFJsOZDvtzHHJCz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIO5YW83JRRaMPDaseyXTGIyhU8d5A9At6A88icNLkFhJ3V5r6UOMdZGj92td12sVy/fkHRIotPxuz07fatg7eEiheBQ/5GtKpxrjFN3ToiEH0O26QXEec5SQsCZzdbxY+QmLlTOykwEBpz1RsuIzxTE1wbKyqFsS5c2Ud3hNRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2738368C7B; Thu,  3 Apr 2025 07:44:58 +0200 (CEST)
Date: Thu, 3 Apr 2025 07:44:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
	Nilay Shroff <nilay@linux.ibm.com>, Christoph Hellwig <hch@lst.de>,
	syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
Subject: Re: [PATCH V2 3/3] block: use blk_mq_no_io() for avoiding lock
 dependency
Message-ID: <20250403054457.GC24133@lst.de>
References: <20250403025214.1274650-1-ming.lei@redhat.com> <20250403025214.1274650-4-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403025214.1274650-4-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 03, 2025 at 10:52:10AM +0800, Ming Lei wrote:
> Lock implied in blk_mq_enter_no_io() won't connect with any lock in IO
> code paths now, so use it to prevent IO from entering queue for avoiding
> lock dependency between freeze lock and elevator lock, and we have got
> many such reports.

Please explain what this actually fixes here.

