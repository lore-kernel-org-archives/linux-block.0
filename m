Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7363126C2;
	Tue, 23 Sep 2025 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666911; cv=none; b=o11DE4qh0n6OUQ/NVp3Ig3p5symG4/OKqGj7JNPZMKayj5yNkbNveOl6T+4YOyEPi8pZtDkS7gtEBT5l5sCDhZ8L11o6vfvgHL//1Lt/VOScc6dn2A6v0Jtg5iKHRsgvJAbWCmzzyhXeXOpIr8MA2ny5hjff0KG0BuFtdZxZuyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666911; c=relaxed/simple;
	bh=K+REPAt7YGROMU060Sut8pDiJmmKCZ4JFkal1RQOmGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGVSv1ixIMK5NF8QkOFVTqi4vlcTY9kZ+CbdbS6Ls64tVmpulhVxdGnuuzgUOrGUbevDHdY62IdEQ+qzcbjrX7809l9kyqrFSbibe+L8kZA38nCeluQ8/XNofLElWEB0YH4u3CQud1OaWI/qE6vy+5H6x301CmSLDEo3GOpZmdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfvKLIEC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfvKLIEC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E0DC4CEF5;
	Tue, 23 Sep 2025 22:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758666911;
	bh=K+REPAt7YGROMU060Sut8pDiJmmKCZ4JFkal1RQOmGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NfvKLIECePVJSfIsLMzuzmM3Lfkth90P9jpbucNQ1bDMKtxnUUxV5JFtKuhdhpmWb
	 Cw3GZEX3eQpIT/PWZ/yXnZMG824R5TCQPjlm98ugF9huAG8DeaThH3gkBcbwr/TZuE
	 vm/De9fznWxi8yL9W3hbwpzVsdSjYKdJINx4sFLGsP2083YAha5J9C5fBwD4MqMtXT
	 ir+xFYNttlpYqZZmrRAZCSLQPAaJ5po2rCCjv7hee+rH9n2nEI6G7JOlhDYZQf0/X1
	 1DkImokD6CqYRTWU50ZSiWc781Xdx+oofE6BqZqS50/4CeH67G98lYY+2B9ZA6UvmX
	 2kJmK3McZDdRg==
Date: Tue, 23 Sep 2025 16:35:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	David Hildenbrand <david@redhat.com>, iommu@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>,
	Juergen Gross <jgross@suse.com>, kasan-dev@googlegroups.com,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-trace-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, rust-for-linux@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	virtualization@lists.linux.dev, Will Deacon <will@kernel.org>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v6 00/16] dma-mapping: migrate to physical address-based
 API
Message-ID: <aNMgm33W7gh75h3t@kbusch-mbp>
References: <CGME20250909132821eucas1p1051ce9e0270ddbf520e105c913fa8db6@eucas1p1.samsung.com>
 <cover.1757423202.git.leonro@nvidia.com>
 <0db9bce5-40df-4cf5-85ab-f032c67d5c71@samsung.com>
 <20250912090327.GU341237@unreal>
 <aM1_9cS_LGl4GFC5@kbusch-mbp>
 <20250920155352.GH10800@unreal>
 <aM9LH6WSeOPGeleY@kbusch-mbp>
 <20250923170936.GA2614310@nvidia.com>
 <aNLnXwAJveHIqfz0@kbusch-mbp>
 <20250923222216.GC2617119@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923222216.GC2617119@nvidia.com>

On Tue, Sep 23, 2025 at 07:22:16PM -0300, Jason Gunthorpe wrote:
> Very rare is a different perspective, I mis-thought it was happening
> reproducible all the time..

Yes, sorry for the false alarm. I think we got unlucky and hit it on one
of the first boots from testing linux-next, so knee-jerk reaction was to
suspect the new code that showed up in the stack.
