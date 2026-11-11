Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409381;
	b=NAZtQx5OhJmyI2gKp0/m8LLcHQzK2RPRrGYj6tYY7YAUAoXkgyP/XSVZcnH5Y9u69tI2
	 lY5oZT7oWU8S1QgLJw63Xq6j82QOEWtzYGMOq2PvQ2kWse/IogS8l7wYfuwv6/VLui8tW
	 eKbB8374eJNe3qfJQdN4Kp9e97po4h1lwshuoYcbo8lakO6oxi8yN3knsLoVHah5zEt8R
	 DQaFq/evurKyOdvRRCl+9Wiq1m2SnNUQkSr0ZcqwqrkycOVXE8jgXBsbXGh5FlLuYjs1p
	 meri8ud5HDmC8pBLZFgQeAnPE8D4OJNl/Dj/ESxRogo74VdvI/18Y94425MyFFXDF+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409381;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=hawEcfWYU+VZ36UK6LMrSThr4hoVCl5R4gqFfPD0QME2FCiOYnQFFwA1Q+Wj3GxVws0s
	 WksXUDXf2vDHN+sgdOTqnzpGZOrJDiUKL7uBnHz205BjTxyH9wBDSL8MAbcLgKmdawjfF
	 JrQci2Jtk/uNasZ1L0OEnDMa2LT+NiKFvPKRPg3doRdgLP32i4ZiKh+sQzvhYRRA5Pysj
	 Z4DUSOPnoo4MwNFql5EZXCM6x+xhpFwU6KCTHg95P6aVuiJnr31XwkPjoRDgyoIBhonkA
	 UfnLXGtWF+3FAsiVUqFyKyrrgZk0Ai3gdj63xra1/rKp0MKX/bkNEukwqqn4fTziXNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=E2r6yTve;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8B3606A891;
	Wed, 11 Nov 2026 15:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F8B3606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=E2r6yTve
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=E2r6yTvegWYKxuIJUczQEwcI4M
	WFvhEGpREQAmkJgjKxz70SDICYeWvWldDZ5jNgz6IpROxruzj2suKa7GU1NX/Aio/tHLEGLZcR94/
	n+DP5/VA1eKROLu6QmmRiQyR+OlgANR8fO+KrwrNwtPWb46JzLhNunkzuAF0Uy5WMYndGsvxKQ3Qn
	BdDO1F8tEpwI8K2M17tFW0rwyoDWPzoCQ2l/hyErYrkvY9acrOergYGUZtozgJUPojQH5QamNPy+w
	Ya2uyh0FIaznX0Yocv4xvc7vjfzWxO5IZmV1VnKyKvL4b4UXafjMVidDRB4tkyL6ESrTb0dpSjk+k
	JurLKc2g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR9ql-000000072ed-24iw;
	Wed, 11 Nov 2026 15:02:59 +0000
Date: Wed, 11 Nov 2026 07:02:59 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2] block: avoid repeated notifications for dead disks
Message-ID: <avSDo6mqkn0F25De@infradead.org>
References: <20261031171325.4073830-2-thnkslprpt@gmail.com>
 <20261105081007.816058-2-thnkslprpt@gmail.com>
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
In-Reply-To: <20261105081007.816058-2-thnkslprpt@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

