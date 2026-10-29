Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793276464;
	b=tsWlLrpgeP6yEwtuzFR8AfktJaZXwovNpLkFV+K4ajjXD5rAk5Lv4uPq17TUGbUzY9c+
	 0LCEOG07VCjBlChEYM7B3vTvvLuORWuVlAm/vGR+7PfZKTXJNe+kSuiu799MKIraRADXw
	 OHh5ec5dlJlJ/jTYZeNDG/jBiPyftBZqxGuOPX4JnCXf8LDES8TWrPR2oRm9VrCgp8puQ
	 0kO3HPYgCb+pgWldR6QGCK6/z1uSC4es1FrWqnsR1kfixrWh6tO2wTWv1nIrfGW+l49TS
	 idZPuDPd+jj2GuBRTW/ZU8j5r/7pNu3/6z6wjgbjSptyznobdmUdSf5FI3aclGzjUKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276464;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=i3fiR/sAc3MoSh1uvdBFwJ3whZ8RDFm7WQNOOBsAd4U=;
	b=4kXsglW94BNjhWtuITNUNLIZfblJLtH8v1+9y7Xlcdzx5Oz8kbwqW80qW05C1GZNUHXO
	 Q7n/88B+3ukuceC9f++m1uleJRgHEVwQRZFiimYJa9+frfZJascs8v9L9UyzOSfVTmLeN
	 n0/pIGRNDh2ejB2rGKldh+OXynX1BWmUXVgOP0q1lXWFcowauLgU1ftqx+tHVwyAzaDxH
	 exRM36Q29TZUsfwrsZXCuzLBq66/lV/kmx6aVqiBhNkUzFbc2Q43egfGUYy0VMnw68X9B
	 CDW3infJUqRwgYl8rNYHvtl3qpu9MEpcC4QiUKHd7KfmHZKRN77eZQscivDlbch+iGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C73F606A31A;
	Thu, 29 Oct 2026 12:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C73F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6EF7468BEB; Thu, 29 Oct 2026 13:20:58 +0100 (CET)
Date: Thu, 29 Oct 2026 13:20:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kyle Bader <kbader@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
	Kyle Bader <kbader@ibm.com>, Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Tushar Gohad <tushar.gohad@intel.com>, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: only fail dma-buf bios that need block layer PI
Message-ID: <20261029122058.GA24811@lst.de>
References: <20261028181412.1919506-1-kbader@redhat.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028181412.1919506-1-kbader@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 28, 2026 at 06:14:12PM +0000, Kyle Bader wrote:
> From: Kyle Bader <kbader@ibm.com>
> 
> Any dma-buf I/O to a device with a PI checksum fails today.
> blkdev_init_dma_buf_io_ctx() returns -EOPNOTSUPP at registration, and
> blk_mq_submit_bio() fails each dma-buf bio with BLK_STS_NOTSUPP. The
> checks prevent a crash: bi_dmabuf_map shares a union with bi_io_vec,
> and bio_integrity_generate() and bio_integrity_verify() walk bi_io_vec
> to compute the guards over the data.

Please cut down the commit log to the essentials.  It's basicallyr
currently all P2P I/O to devices advertizing integrity data is rejected,
but it should only reject those walking the bio_vecs.
