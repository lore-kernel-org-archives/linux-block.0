Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44190354AE2
	for <linux-block@vger.kernel.org>; Fri, 13 Feb 2026 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770984024; cv=none; b=CXWdo6YdcSTG5Zg6mQh6tKQdIhcwjrPdi9Vx/qCTRbil/YvI7Zdj0xPB3d24fh3fSBQfO6HXyewfuedsPzScXjM3HbrAT7PO7eklj5vpZc6YxGhPnfQh9gKubZluKQX4BbbdAJfgh5zqCpDAxTWZIC3Tng2WlT55F4pSgSVz6E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770984024; c=relaxed/simple;
	bh=/Gkk/2InGFHC+cXapZagr3OjTLk+xGsRB3sdRCOh8ME=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=dOYwo3h7132aYWkKUWUlJrPnyAHq3whNIpb4vD7WQtGbAgfORRkOUvJGaTpyg6NZUXUDq1iwSCxJi5g+qPAgsD7Q9k9z8s6FCs9giF+UFJ7K6MwUZQLpW9CTvGsL9VYhd3H+hlgK0cjUxh/jC+GCjoq8JBgShObYT/NWjxzBO0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=rpIgkpWt; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="rpIgkpWt"
X-Virus-Scanned: Yes
Message-ID: <e19daf3a-b2f8-47ef-90df-5a746bf0b756@zazolabs.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1770984019; bh=/Gkk/2InGFHC+cXapZagr3OjTLk+xGsRB3sdRCOh8ME=;
	h=From:Subject:To:References:In-Reply-To;
	b=rpIgkpWtygjulF7zrWWBKMJXMsXcljIwJPF6BD1KjxxDkPR9SkzBoVoPP6qxc202D
	 uLAPT+lwpQ/mZA/sUu79C1CesVvKsmPRps7viMgxr07vkBR3hKL2yIyePiNwTWzSBY
	 uIY1U6ZFL8F1r02+/PRKDO2T1YBY9TxTEHsTPOgHAWtMAPH76+Lsg6v9/UOP3OWQAp
	 TAQHcqbka0JqrygYAEYmorzlD58E9teqo4uk8qfC9lNNn3p8K1Kz4XbGtKNoEhl+Sn
	 6hgfQzqKBiQZm6UpM7RUHpr8kLL7jO2LNHh7it62Fil+2lScIkEqHediKGl9q8Sa50
	 Rd8niLHhisbtqCf8ZhsSptOY0y4GxuohYqfC3gNS6UFRdiNZOkb8Fe6YPXTbtuCZGs
	 zyvFwMxVmBI6+1wn85eitoWFil/6nI6Lei/oaxPgfVNehnISc6iltp4Nn1LYzeVuyc
	 ri/EhE0aep9A58RmJp5/W6uxoI0HOrxE42jvHtFQvpNWay5VsrW89S+ZRcZ6SRhhNr
	 7IrBnnEnGK4pMOYoWR7rUCNnmqET571U+HgBa+38uv74ASvfARYWtqplk8DDuovzog
	 RNI4dh6r40ECESyMifDsw65zt36Q59/UZzNHu4XZ/ZXd0cpNcmSnUODaFttADibwDa
	 zX79vNfa4fQVuXqpDC1CiR2g=
Date: Fri, 13 Feb 2026 14:00:17 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexander Atanasov <alex@zazolabs.com>
Subject: Re: [PATCH] block: fix folio leak in bio_iov_iter_bounce_read()
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <ed27f009-4607-47f4-9d72-ccfc1b1e5de3@kernel.dk>
Content-Language: en-GB
In-Reply-To: <ed27f009-4607-47f4-9d72-ccfc1b1e5de3@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 12.02.26 13:10, Jens Axboe wrote:
> If iov_iter_extract_bvecs() returns an error or zero bytes extracted,
> then the folio allocated is leaked on return. Ensure it's put before
> returning.
> 
> Fixes: 8dd5e7c75d7b ("block: add helpers to bounce buffer an iov_iter into bios")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> diff --git a/block/bio.c b/block/bio.c
> index b291b9aaeee1..8203bb7455a9 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1382,8 +1382,10 @@ static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter)
>   		ret = iov_iter_extract_bvecs(iter, bio->bi_io_vec + 1, len,
>   				&bio->bi_vcnt, bio->bi_max_vecs - 1, 0);
>   		if (ret <= 0) {
> -			if (!bio->bi_vcnt)
> +			if (!bio->bi_vcnt) {
> +				folio_put(folio);
>   				return ret;
> +			}
>   			break;
>   		}
>   		len -= ret;
> 

Isn't it better to move folio allocation after the while loop instead, 
right before it is actually used - less error prone in future updates, 
tighter loop, better cache wise.

-- 
have fun,
alex


diff --git a/block/bio.c b/block/bio.c
index 49f7548a31d6..742d395f98e1 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1338,10 +1338,6 @@ static int bio_iov_iter_bounce_read(struct bio 
*bio, struct iov_iter *iter)
         size_t len = min(iov_iter_count(iter), SZ_1M);
         struct folio *folio;

-       folio = folio_alloc_greedy(GFP_KERNEL, &len);
-       if (!folio)
-               return -ENOMEM;
-
         do {
                 ssize_t ret;

@@ -1356,6 +1352,10 @@ static int bio_iov_iter_bounce_read(struct bio 
*bio, struct iov_iter *iter)
                 bio->bi_iter.bi_size += ret;
         } while (len && bio->bi_vcnt < bio->bi_max_vecs - 1);

+       folio = folio_alloc_greedy(GFP_KERNEL, &len);
+       if (!folio)
+               return -ENOMEM;
+
         /*
          * Set the folio directly here.  The above loop has already 
calculated
          * the correct bi_size, and we use bi_vcnt for the user 
buffers.  That


