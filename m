Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A6815CB;
	Fri,  8 Dec 2023 02:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pL7RE0MC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA2FC433C7;
	Fri,  8 Dec 2023 02:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702003480;
	bh=wuEMZ81uJKarUyz9kBDH4zgx1rrGtZ2JyolpU+3aRiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pL7RE0MChzRmd5+zFgBRqP2gm0x35pQjDnQ/pvXGYQbkFekqXMJF4XBtatGzh6Mw3
	 DXX1DS3AJ1wUYSsDsQEH62rAJMpMU0OiePmTuAdnJwmQNQxhRgr/tZ9xdhhRmYz/ic
	 JkDlnfgOfacefgnnOF6C1/t5Yr+9FxoT3VT4frjyUuEvXfA2e+ouWVcilcMHNJ5jaW
	 554KkpfVUeFErCu85NQXOzaOYPFBXQYu81R3KA4uS9tYeLmafcTQkcWfub+dyP5hi1
	 PXTWMyXcKOREPs6aFr+QSRcVwE18aQho0GDSUOvDNhUipxsYBz+u4OIOR/V+c9jeiV
	 jiV1SVn7fO1Qg==
Date: Thu, 7 Dec 2023 19:44:37 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Li Feng <fengli@smartx.com>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
Message-ID: <ZXKDFdzXN4xQAuBm@kbusch-mbp>
References: <20231207043118.118158-1-fengli@smartx.com>
 <ZXJ4xNawrSRem2qe@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXJ4xNawrSRem2qe@fedora>

On Fri, Dec 08, 2023 at 10:00:36AM +0800, Ming Lei wrote:
> On Thu, Dec 07, 2023 at 12:31:05PM +0800, Li Feng wrote:
> > virtio-blk is generally used in cloud computing scenarios, where the
> > performance of virtual disks is very important. The mq-deadline scheduler
> > has a big performance drop compared to none with single queue. In my tests,
> > mq-deadline 4k readread iops were 270k compared to 450k for none. So here
> > the default scheduler of virtio-blk is set to "none".
> 
> The test result shows you may not test HDD. backing of virtio-blk.
> 
> none can lose IO merge capability more or less, so probably sequential IO perf
> drops in case of HDD backing.

More of a curiosity, as I don't immediately even have an HDD to test
with! Isn't it more useful for the host providing the backing HDD use an
appropriate IO scheduler? virtio-blk has similiarities with a stacking
block driver, and we usually don't need to stack IO schedulers.
