Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B233399C;
	Wed, 24 Jan 2024 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110901; cv=none; b=l33eihwxA0trGlluH/8K02dRz5aox4qOfho9qyK+He9fKbYE2xXAt7gKquykkfWRTMDiy/kpKb7XeBRygZh4iIZXcF+pTlUZYLYV6D+TLLJ1HhpN6GMUAM33fJd6HNhciU7jhw4wohEXBKd/4O1V5UaYbwfOngiwO4FNyYg2BEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110901; c=relaxed/simple;
	bh=xLrA5RcRjFK5SJZ2Re6Tza8ZXo2JQ9yye+jrNnLv+2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGvUbU9f14yXXBFMTPgzHxXSOL2mGKaQ7EFkMMnYbpkthIRRJLxm79M84sbBb6wCpx6vqDju/+xEFUSkYRVPAvKwhQc1o20qdfEFqifwAUK/LKulbVSLCodrTE9nO7CvFuFj2ASjdG2v9Gqyba390LpHcEbnks9+jpc4hEG/oA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmR+KvCA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmR+KvCA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12761C433F1;
	Wed, 24 Jan 2024 15:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706110901;
	bh=xLrA5RcRjFK5SJZ2Re6Tza8ZXo2JQ9yye+jrNnLv+2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GmR+KvCAduSd3EVQ3DxDH1HCU25j0sc8Vc3LNulsuOfeW0hPQKuaEQ/jfLuMxsaHc
	 emQ5WcoZ/cBNkEj0nBrpxUYvEIKbOeRYtIASsHGjbyArWmpZuOnmeD32SmV/kbc5SV
	 iEgnoxT1c9moX3kGQMLysQZfACxOOOMa9D2Eu3apcalQ1FtVIdAy4efjdlvtxjU7WG
	 D+0tKM3Ni7fjfHw5hB/gQLgaXJzQN/y8MkWId/VIz5wfKdGa/gwYN9Pt5t2tUbF2uL
	 SokOxMnC2LuIYwt611hv6hlxdQDh8N4rCBwgKOum3ZireYTAD0IaGcxih2UKb5D9Bt
	 1B/6hZgeHW44w==
Date: Wed, 24 Jan 2024 08:41:38 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: [Report] requests are submitted to hardware in reverse order
 from nvme/virtio-blk queue_rqs()
Message-ID: <ZbEvstiLSMwtFb8m@kbusch-mbp.dhcp.thefacebook.com>
References: <ZbD7ups50ryrlJ/G@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbD7ups50ryrlJ/G@fedora>

On Wed, Jan 24, 2024 at 07:59:54PM +0800, Ming Lei wrote:
> Requests are added to plug list in reverse order, and both virtio-blk
> and nvme retrieves request from plug list in order, so finally requests
> are submitted to hardware in reverse order via nvme_queue_rqs() or
> virtio_queue_rqs, see:
> 
> 	io_uring       submit_bio  vdb      6302096     4096
> 	io_uring       submit_bio  vdb     12235072     4096
> 	io_uring       submit_bio  vdb      7682280     4096
> 	io_uring       submit_bio  vdb     11912464     4096
> 	io_uring virtio_queue_rqs  vdb     11912464     4096
> 	io_uring virtio_queue_rqs  vdb      7682280     4096
> 	io_uring virtio_queue_rqs  vdb     12235072     4096
> 	io_uring virtio_queue_rqs  vdb      6302096     4096
> 
> 
> May this reorder be one problem for virtio-blk and nvme-pci?

For nvme, it depends. Usually it's probably not a problem, though some
pci ssd's have optimizations for sequential IO that might not work if
these get reordered.
