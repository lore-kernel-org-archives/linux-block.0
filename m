Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6978A2E0413;
	Thu, 13 Nov 2025 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763063539; cv=none; b=OrDoUDrr/Cn1F0/gfC/+ZD+UwVYgDOWjROG4RAHh52DzCXLU2SBsLdAhOtolGqviZuiJzyFgc1SgOP+cUJcjDNtLkMFV5KhfpUSaR91PNSm6laU55E1+eSco1q4L9XffbsRefT59gBEeoXeniA5V5gZ02GPgjnQ7Lx3tEw1//N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763063539; c=relaxed/simple;
	bh=QbTUe6a1+4aEbxz3ZqTrn1EgdpNUmW80HgS3yuxDreU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tx92bQS/HBjJrQVJIfPR2Zk/Wx/aKg2qQNZaexi21vxleUvpWbJTSYDGxjj6XFxpMtEsYA0l1iDwLguQn3K7j/Wfx6/TcIEGmmxQaM8Mw5usx5MoWUpAU/MxkufKswvGemM50iiEgZEiQn85ZAFpMVsaNDGhySI017MWVobhAPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+vNXREO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+vNXREO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A566C4CEF8;
	Thu, 13 Nov 2025 19:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763063539;
	bh=QbTUe6a1+4aEbxz3ZqTrn1EgdpNUmW80HgS3yuxDreU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N+vNXREOvbzwz9oe5TmZlFRg8Ktk0X3UM/yagsN9Y+pfojKv3kDTQQ609dXj6Uckl
	 EGvM8cFZ0C9jhYfFrh0/hkyuniIJXN3py43mvikWFQcRGoRL5H7+0DMtjzrLL17OLP
	 bgvDfPlKONVssTXYe7BONJTPLHuKaAkMq2+R4O5+7MxCQbLxCMscI7XVcdoaXPzXYq
	 1utYXcMWIZAFtgTEcsIOs3OXjUVFxJdrTg25wH0oXkXnk0EULF50nJ4aQsZmFwqT01
	 wV6O/FrUSLicfHTaqBqvaGyL+cWr48y4eRs9Cu6UpeHd8wvpGCy8s9Ck0LrCOp6GJy
	 ab6No2JhtE6Ww==
Date: Thu, 13 Nov 2025 14:52:16 -0500
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Leon Romanovsky <leon@kernel.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 0/2] block: Enable proper MMIO memory handling for P2P
 DMA
Message-ID: <aRY28IRvBFmTW6cz@kbusch-mbp>
References: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
 <176305197986.133468.1935881415989157155.b4-ty@kernel.dk>
 <cec91b1e-a545-4799-97c3-676e3b566721@kernel.dk>
 <4f75497d-11cb-437c-ab90-d65d4d2e0a52@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f75497d-11cb-437c-ab90-d65d4d2e0a52@kernel.dk>

On Thu, Nov 13, 2025 at 10:45:53AM -0700, Jens Axboe wrote:
> I took a look, and what happens here is that iter.p2pdma.map is 0 as it
> never got set to anything. That is the same as PCI_P2PDMA_MAP_UNKNOWN,
> and hence we just end up in a BLK_STS_RESOURCE. First of all, returning
> BLK_STS_RESOURCE for that seems... highly suspicious. That should surely
> be a fatal error. And secondly, this just further backs up that there's
> ZERO testing done on this patchset at all. WTF?
> 
> FWIW, the below makes it boot just fine, as expected, as a default zero
> filled iter then matches the UNKNOWN case.

I think this must mean you don't have CONFIG_PCI_P2PDMA enabled. The
state is never set in that case, but I think it should have been.

---
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index 951f81a38f3af..1dfcdafebf867 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -166,6 +166,8 @@ pci_p2pdma_state(struct pci_p2pdma_map_state *state, struct device *dev,
 			__pci_p2pdma_update_state(state, dev, page);
 		return state->map;
 	}
+
+	state->map = PCI_P2PDMA_MAP_NONE;
 	return PCI_P2PDMA_MAP_NONE;
 }
 
--
