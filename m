Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C51C1863B;
	Wed, 20 Dec 2023 06:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2EA3268BFE; Wed, 20 Dec 2023 07:36:33 +0100 (CET)
Date: Wed, 20 Dec 2023 07:36:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 14/14] fs: Remove the bh_end_io argument from
 __block_write_full_folio
Message-ID: <20231220063633.GA1421@lst.de>
References: <20231215200245.748418-1-willy@infradead.org> <20231215200245.748418-15-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215200245.748418-15-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Dec 15, 2023 at 08:02:45PM +0000, Matthew Wilcox (Oracle) wrote:
> All callers are passing end_buffer_async_write as this argument, so we
> can hardcode references to it within __block_write_full_folio().
> That lets us make end_buffer_async_write() static.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
