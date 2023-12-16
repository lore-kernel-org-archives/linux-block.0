Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E230013FF8;
	Sat, 16 Dec 2023 04:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C266968B05; Sat, 16 Dec 2023 05:27:31 +0100 (CET)
Date: Sat, 16 Dec 2023 05:27:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 02/14] fs: Convert clean_buffers() to take a folio
Message-ID: <20231216042731.GB9284@lst.de>
References: <20231215200245.748418-1-willy@infradead.org> <20231215200245.748418-3-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215200245.748418-3-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Dec 15, 2023 at 08:02:33PM +0000, Matthew Wilcox (Oracle) wrote:
> The only caller already has a folio, so pass it in and use it throughout.
> Saves two calls to compound_head().

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
