Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9F3559313;
	Tue, 22 Sep 2026 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082984; cv=none; b=RkRel2pQ7pcqzzIzPS5Ql2INBZS6an/7RjYo13ejtQhfNznXhdD1TF6q+rxdjfY5zb/PyeUv4poI6kpzufhbUI6fdMUOy8ckvZqgI+IueVv20pfLJV06a5Kc7lxBUs7ifu5si/TxuWni3Ll0dEaHQGVIYi3Yfa/IStL/yX0z2jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082984; c=relaxed/simple;
	bh=Y8SIGh6YdZZ1CNW2JjI2lgNP0I2lOTxj/HFJcJxssAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nA5t0XLtI/BfQMu4lTKsMcWtjoIdoHf8t0ONQqVF0J9ANWZqHCDL1OAnY0kKz+06jI9GxDlUreTIl862OH0a1MvbiVmF4QZmDs08Q1pAiaASUWicQSteJ1qMLzhdbZo3jbrz7qdMusiKHASpsJTuIU0CdRwGxOaZ41Emsr8gejQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A774668C4E; Tue, 22 Sep 2026 15:16:11 +0200 (CEST)
Date: Tue, 22 Sep 2026 15:16:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
Subject: Re: [PATCH v6 04/13] block: introduce dma map backed bio type
Message-ID: <20260922131610.GA30468@lst.de>
References: <cover.1789997898.git.asml.silence@gmail.com> <a3ee719abc440ca139f1a945fdaf43a45f0c6b57.1789997898.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3ee719abc440ca139f1a945fdaf43a45f0c6b57.1789997898.git.asml.silence@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Sep 21, 2026 at 02:38:48PM +0100, Pavel Begunkov wrote:
> Premapped buffers don't require a generic bio_vec since these have
> already been dma mapped. Repurpose the bi_io_vec space to strore dmabuf

s/strore/store/

Can you please expland on the splitting considerations a bit?  Preferably
both in a comment for the details, and in the commit log for how we
arrived at them and why they are fine for now?

Otherwise looks good.

