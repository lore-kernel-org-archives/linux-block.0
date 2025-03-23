Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11AD1FDE07;
	Sun, 23 Mar 2025 01:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742691733; cv=none; b=XPn+ZalqhyYBr174R4uEIpjG2RpCDO4mkCFGVCy1H3BJoQnBGycfJEMco4PVs0MVBGnCjThTd/wGEqkRAfec1e3+bTpWc2MmxugqGhkA1svbJL5Jznv5h7eYFRNr+IDgyetTjpeJWY5MH1W298uKwPRqNjHe2L7YSGBYC2DBdkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742691733; c=relaxed/simple;
	bh=Ksj6kRjx99oAfhdgnyVT4Uj8dlQB6UBKFAwF5s+xPlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZvZVLK9ih0Er5Fs8Fh/NyjeI48oTz7s1EJctnDsuaeWB6EFVFiq/U+DNdBWvAic1RfsDurqpEgKoa8kInAal2cJ6OVi6a+CDbt1i92oPLjtbCAcZ+eNRNq4zOQ6kWOmb8fijxPgdMJL+NhsYudf7xzQvSZFsbNsugJkLudyS6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoBLcu/j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoBLcu/j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8769CC4CEDD;
	Sun, 23 Mar 2025 01:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742691733;
	bh=Ksj6kRjx99oAfhdgnyVT4Uj8dlQB6UBKFAwF5s+xPlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CoBLcu/jy/tQoEJPKu4zMxzpXJQK+xwszeEO/+RObGT7IVe41R4YLh7oM/1WbG2+C
	 RCu6SXeajWsTP5VqnQ3NDK9v/zYKtWM2bn9az2UWxngflbCe0Si4BJMRfMcJRVJim/
	 gHVVGEf7cgaKVzBApnrnzpMXK6vzQztobCpuUjrW5RbvxU8ZoKKpN+jIXU+qPWgqHv
	 A4Lw7of4DJ6Ury7X0esaOC62ZhTk5rlpVeQhx6iAhxxDLhuK06CsBmldeLuYufN4PZ
	 gEWzErqKBdElrxe5P+ToGo99IHs8/IXf81ppfcCZYb/LTs5d+CDAksSBrR1OHGyyKQ
	 owxGZ31uXdkLw==
Date: Sat, 22 Mar 2025 18:02:11 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Oliver Sang <oliver.sang@intel.com>,
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
Message-ID: <Z99dk_ZMNRFgaaH8@bombadil.infradead.org>
References: <Z9kEdPLNT8SOyOQT@xsang-OptiPlex-9020>
 <Z9krpfrKjnFs6mfE@bombadil.infradead.org>
 <Z9mFKa3p5P9TBSTQ@casper.infradead.org>
 <Z9n_Iu6W40ZNnKwT@bombadil.infradead.org>
 <Z9oy3i3n_HKFu1M1@casper.infradead.org>
 <Z9r27eUk993BNWTX@bombadil.infradead.org>
 <Z9sYGccL4TocoITf@bombadil.infradead.org>
 <Z9sZ5_lJzTwGShQT@casper.infradead.org>
 <Z9wF57eEBR-42K9a@bombadil.infradead.org>
 <20250322231440.GA1894930@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322231440.GA1894930@cmpxchg.org>

On Sat, Mar 22, 2025 at 07:14:40PM -0400, Johannes Weiner wrote:
> Hey Luis,
> 
> This looks like the same issue the bot reported here:
> 
> https://lore.kernel.org/all/20250321135524.GA1888695@cmpxchg.org/
> 
> There is a fix for it queued in next-20250318 and later. Could you
> please double check with your reproducer against a more recent next?

Confirmed, at least it's been 30 minutes and no crashes now where as
before it would crash in 1 minute. I'll let it soak for 2.5 hours in
the hopes I can trigger the warning originally reported by this thread.

Even though from code inspection I see how the kernel warning would
trigger I just want to force trigger it on a test, and I can't yet.

  Luis
