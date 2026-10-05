Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79A7434999;
	Mon,  5 Oct 2026 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791191545; cv=none; b=now/hl6uC8KWKkdDz7qUDJSjjAgSKYmJYmvVicyvrQAuuJboUqw7aysVjB6dQR6Mz340b+S+/quSKJhWQvz372udQwYrtAkmUEbWvNSt75IomdfPFJcg4UX3vebzVPoz4bE26zdvNe2sI95ogerKPdLt2lWX+HvdJeGmiDUwV8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791191545; c=relaxed/simple;
	bh=FvFbmcoqy+CS1e+9F4qS80J5W1BvvY9zD9RwiyhJe2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qjdwa5hDvIOKsvLSThf/ZJddaW0XSFrWI8xJ1uoRIg1uD3ETZbiggJBroFgfukWz5UrbbqWBeIzD7cBG9JWufkYncC43X8/5nvJecfuFwz5qhDFVaFkdQ5OUj8ssOYVjkSpMXCHaYqhjnQ2/hSaFTdWlW06wFVaNBK/koyhqY0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 86A1B68BFE; Mon,  5 Oct 2026 11:12:19 +0200 (CEST)
Date: Mon, 5 Oct 2026 11:12:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Pavel Begunkov <asml.silence@gmail.com>, agk@redhat.com,
	akpm@linux-foundation.org, anuj20.g@samsung.com, axboe@kernel.dk,
	bmarzins@redhat.com, brauner@kernel.org, christian.koenig@amd.com,
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
	hch@lst.de, io-uring@vger.kernel.org, jack@suse.cz,
	joshi.k@samsung.com, kbusch@kernel.org,
	linaro-mm-sig@lists.linaro.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-nvme@lists.infradead.org,
	matthew.brost@intel.com, mpatocka@redhat.com, nj.shetty@samsung.com,
	phil.cayton@intel.com, sagi@grimberg.me, snitzer@kernel.org,
	sumit.semwal@linaro.org, tushar.gohad@intel.com,
	viro@zeniv.linux.org.uk, william.power@intel.com
Subject: Re: [PATCH v7 06/13] nvme-pci: implement dma-buf backed requests
Message-ID: <20261005091219.GC10727@lst.de>
References: <cover.1790602223.git.asml.silence@gmail.com> <e99dd5221c71cbf9aafb5737468d814cb83b9174.1790602223.git.asml.silence@gmail.com> <5a35ad21-c9d4-4dab-a4f0-97baee6e2301@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a35ad21-c9d4-4dab-a4f0-97baee6e2301@wanadoo.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 29, 2026 at 05:45:39PM +0200, Christophe JAILLET wrote:
>> @@ -27,6 +27,8 @@
>>   #include <linux/io-64-nonatomic-lo-hi.h>
>>   #include <linux/io-64-nonatomic-hi-lo.h>
>>   #include <linux/sed-opal.h>
>> +#include <linux/dma-buf-io.h>
>> +#include <linux/dma-resv.h>
>
> Move up, to keep better alphabetical order ?

Doesn't really matter.

>>   +struct nvme_dmabuf_map {
>> +	struct dma_buf_io_map base;
>> +	struct sg_table *sgt;
>> +	unsigned nr_entries;
>> +	dma_addr_t dma_list[];
>
> Add __counted_by(nr_entries) and update nvme_dma_buf_io_map() so that 
> nr_entries is set at the right time ?

Yeah, that would be useful.

