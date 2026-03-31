Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173BF3CA4B6
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 07:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774942000; cv=none; b=qT++nxk3FoNds3cGzb3Mo+CKrSeWvwmIth+2O6QLLIV9cs1AzVXKVwkSNn4OD24YdQ8kjDRx7UISoTsGA4pJZQC5vQkdCkSAYi4SNMgaZcekS500NW+yKYZCFgbIq0ePtw0mGYJnCdxuTVqpt4RjJEY/4yM2G4sB5dBoNixQfJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774942000; c=relaxed/simple;
	bh=MpfTFysFV5xYeWJsDIVg3Tu9foqs/Rp+WLQMHqkX4LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2Y1CR60h9JTFNk0B+sZdoXQG9lKlmzYgL1IWVBgwd+l/MnxjwuD33wuh4q9+PXp2NUotxzWBPlWr5NR/ztuYymJPCiRLzpzx67ZXWMPQoKUxi3jn0HtbF6qiMX6k1HsvGB3bGoFU/DtEeBjewDhYrsPJQnXGo7gykG/u4lPToA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DFAC76732A; Tue, 31 Mar 2026 09:26:33 +0200 (CEST)
Date: Tue, 31 Mar 2026 09:26:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, Brian Geffon <bgeffon@google.com>,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	Qu Wenruo <wqu@suse.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] zram: do not forget to endio for partial discard
 requests
Message-ID: <20260331072633.GA5494@lst.de>
References: <20260331071537.706139-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331071537.706139-1-senozhatsky@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 31, 2026 at 04:15:06PM +0900, Sergey Senozhatsky wrote:
> +++ b/drivers/block/zram/zram_drv.c
> @@ -2683,8 +2683,10 @@ static void zram_bio_discard(struct zram *zram, struct bio *bio)
>  	 * skipping this logical block is appropriate here.
>  	 */
>  	if (offset) {
> -		if (n <= (PAGE_SIZE - offset))
> +		if (n <= (PAGE_SIZE - offset)) {
> +			bio_endio(bio);
>  			return;
> +		}

Use goto end_bio and share the code with the final completion at the
end of the function?
