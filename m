Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF254353ED9;
	Wed, 17 Jun 2026 06:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781677146; cv=none; b=XoQm7PlhZu1OdbJpCkfm21A0ByL2ss4xzaN/AupV4bpnBl0iCjPD0tLufAyQpO5u2Z/NGlbLyNv17G6OBT8352EtCQ7ogMmTjilKtRIHU7KXkbMkoHCLsEKrUtZIFU7QHTC/HTNkHJmBYdyi6aNkLjvnWjFx/zMXhfRKqDdwb7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781677146; c=relaxed/simple;
	bh=kK7HYyYhvCBqhWbrURHcJ95rhI7Fvwh/1nmH/AdlvJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoqXVxEurm6uTI7agQ1o8RY91Z5IQaK/Rs34A1dpcvZUS1kwCA0nVj8j+QApnm6e8z46/Mw04qfvCqqwJIPmbu53bBIUsRZghv8kXN3yXlFXNUz8+dB873S2szNo2bb5sx/UEKeHm8jVOXksVC3Oc7Kz1lzhT4kZnU+qhe1XoCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4B25768AFE; Wed, 17 Jun 2026 08:19:01 +0200 (CEST)
Date: Wed, 17 Jun 2026 08:19:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jianyue Wu <wujianyue000@gmail.com>, Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Baoquan He <bhe@redhat.com>,
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Youngjun Park <youngjun.park@lge.com>,
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org, Brian Geffon <bgeffon@google.com>
Subject: Re: [PATCH 0/3] mm/zram: route block swap I/O through swap_ops
Message-ID: <20260617061901.GB19844@lst.de>
References: <20260614-zram-swap-ops-block-register-v1-0-6c1a6639c222@gmail.com> <20260616123646.GB21024@lst.de> <CAJxJ_jhK+zkpjhs3YsQ9RoasKYh+E0NweQci0sPAEY1ne5LmBA@mail.gmail.com> <ajIYFtADxQDq8q1P@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajIYFtADxQDq8q1P@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 17, 2026 at 12:46:53PM +0900, Sergey Senozhatsky wrote:
> Those are fantastic questions, thank you for asking them.
> Can we elaborate on zram being a "legacy interface"?

Compression is functionality that fundamentally belongs into the core
swap code, not a virtual block device.  Between the backing store
less zswap and the virtual swap layer, the core swap code is not getting
to the point where don't need to rely on hacks like a compressing
ramdisk.
