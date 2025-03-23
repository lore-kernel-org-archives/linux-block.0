Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA84BAD24;
	Sun, 23 Mar 2025 07:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742713650; cv=none; b=KRiT3gUPVYvw/pvR/S2/wbxxu8J9pY9teOCa+8nZmSSER6ajvYPpwSw+Ay0eb3v7z0l6vdkruwl380C8DcPx8EnDhwG6Zzs/nbtsGbTS3sORqvHQmzsW/lS1FFmJxDCxVJ4ujpIEbKB7adrZypThvLGRmjTqEfnstax5dj7536Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742713650; c=relaxed/simple;
	bh=waNR4m35arNyjJJa0jtGjNQD6uPw/33mh7/K0+sSIU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3tCssTpE+Kp6PGXlFgbBv4tyMKcuC57Fnzvrtgws08lhfA7x8mAPQHNZhiGPV5uwRmHS0kEB/L69oqx7+rmDAHb/FSeHrrwEtDX/yqEo2oPGgNwKHmubRR76DLlkbvZfQIP3Gz9TTub6lA1dP4c4ja6q5e1x2yK4qCjm+OO17A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtaPfMGI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtaPfMGI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6291C4CEE2;
	Sun, 23 Mar 2025 07:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742713649;
	bh=waNR4m35arNyjJJa0jtGjNQD6uPw/33mh7/K0+sSIU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DtaPfMGIzhAvrqUamGTqwM1triUwq3WJtmXy2fQM/+l/eFBpbreqQ6PJGuA7YlHxL
	 MB3p4OjJjZU/C6YWcUXLA4zDZqvW2omU0/cFsmt6135idyi4+0iGCdqp4M9XvxJxFF
	 32bdFKkg+/m6lNWc9T+RGWXE8xTy+/U2CQj8Lq1AKhELBZ3um48DbTfk+2QOV+lRyS
	 oH5DWdSgtSlotIj+XTfFV8SFwnX8Z5XCkwnK0BCb6Oje9qdHVq1hZ20NX6KScKifRi
	 jnUspnRHfa+5/ivFqTYm4m/LuWnJTZu4jOwppG905ycdAUOfAse+jzkOXB1MovafSd
	 M64Oe4gdkbOyA==
Date: Sun, 23 Mar 2025 00:07:27 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Oliver Sang <oliver.sang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	David Hildenbrand <david@redhat.com>,
	Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
	Christian Brauner <brauner@kernel.org>,
	Hannes Reinecke <hare@suse.de>, oe-lkp@lists.linux.dev,
	lkp@intel.com, John Garry <john.g.garry@oracle.com>,
	linux-block@vger.kernel.org, ltp@lists.linux.it,
	Pankaj Raghav <p.raghav@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	David Bueso <dave@stgolabs.net>
Subject: Re: [linux-next:master] [block/bdev]  3c20917120:
 BUG:sleeping_function_called_from_invalid_context_at_mm/util.c
Message-ID: <Z9-zL3pRpCHm5a0w@bombadil.infradead.org>
References: <Z9krpfrKjnFs6mfE@bombadil.infradead.org>
 <Z9mFKa3p5P9TBSTQ@casper.infradead.org>
 <Z9n_Iu6W40ZNnKwT@bombadil.infradead.org>
 <Z9oy3i3n_HKFu1M1@casper.infradead.org>
 <Z9r27eUk993BNWTX@bombadil.infradead.org>
 <Z9sYGccL4TocoITf@bombadil.infradead.org>
 <Z9sZ5_lJzTwGShQT@casper.infradead.org>
 <Z9wF57eEBR-42K9a@bombadil.infradead.org>
 <20250322231440.GA1894930@cmpxchg.org>
 <Z99dk_ZMNRFgaaH8@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z99dk_ZMNRFgaaH8@bombadil.infradead.org>

On Sat, Mar 22, 2025 at 06:02:13PM -0700, Luis Chamberlain wrote:
> On Sat, Mar 22, 2025 at 07:14:40PM -0400, Johannes Weiner wrote:
> > Hey Luis,
> > 
> > This looks like the same issue the bot reported here:
> > 
> > https://lore.kernel.org/all/20250321135524.GA1888695@cmpxchg.org/
> > 
> > There is a fix for it queued in next-20250318 and later. Could you
> > please double check with your reproducer against a more recent next?
> 
> Confirmed, at least it's been 30 minutes and no crashes now where as
> before it would crash in 1 minute. I'll let it soak for 2.5 hours in
> the hopes I can trigger the warning originally reported by this thread.
> 
> Even though from code inspection I see how the kernel warning would
> trigger I just want to force trigger it on a test, and I can't yet.

Survied 5 hours now. This certainly fixed that crash.

As for the kernel warning, I can't yet reproduce that, so trying to
run generic/750 forever and looping
./testcases/kernel/syscalls/close_range/close_range01
and yet nothing.

Oliver can you reproduce the kernel warning on next-20250321 ?

  Luis
