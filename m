Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB0947A0A9;
	Tue, 14 Jul 2026 13:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037200; cv=none; b=AczsWcthKhvmY8E+UK/J4cELddxeAJvzPsRVfZEGfekTqnKjGTkVm8bn/k9qNx4LPOSFaU40Cn7xp89rV0YnZLrs1g51JfW/Q+GojZh3zDXQDZV89JfwFizxmoguO7hNnQkcNvlQdNMqkcC32DejHuOv4O56zoB0MjMxhn59i8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037200; c=relaxed/simple;
	bh=Eq6GXVyYsbPKzg1i1/RNjt8f3O56MsKOzyQV2B05ngA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZpvCjphm9UXFtD318hwkPa5zi0OC/d65UQDPPnoLxWY/w4782yQCQG8zdumsFdRAE7fJpNf8UCiBI54AsOuqZiXWBzK5T0Yd3tNRkjKCTrwGOHIyHHI+QNDTXhAjmmdHZ+GuDzCYrR1RBUpKiMbzSquxo9uj8E322IPgRb0taI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BFDE868BEB; Tue, 14 Jul 2026 15:53:11 +0200 (CEST)
Date: Tue, 14 Jul 2026 15:53:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] nvme/core: advertise
 BLK_EXPECTED_REF_TAG_CAPABLE
Message-ID: <20260714135310.GB714@lst.de>
References: <20260627061933.2187447-1-csander@purestorage.com> <20260627061933.2187447-3-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627061933.2187447-3-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Jun 27, 2026 at 12:19:33AM -0600, Caleb Sander Mateos wrote:
> NVMe Read, Write, and Write Zeroes commands include an (E)ILBRT field to
> specify the expected initial reference tag for the controller to check
> against the ref tags in the protection information buffer. However, the
> NVMe driver currently always sets (E)ILBRT to the lower bits of the LBA.
> The block integrity layer generates/verifies the PI ref tags according
> to the bio's ref tag seed, so it must "remap" the ref tags, adjusting
> for the difference between the ref tag seed and the absolute integrity
> interval number (= LBA).
> 
> If a request has an integrity payload, set (E)ILBRT to its ref tag seed
> so no ref tag remapping is required. Set BLK_EXPECTED_REF_TAG_CAPABLE in
> NVMe devices' enum blk_integrity_flags to skip the block integrity layer
> ref tag remapping.

I don't really understand how this is supposed to work.  For type 1 PI,
NVMe requires (E)ILBRT to match the lower bits of the start LBA:

  If the namespace is formatted for Type 1 protection, the value of the
  computed reference tag for the first logical block of the command is
  the value contained in the Initial Logical Block Reference Tag (ILBRT)
  or Expected Initial Logical Block Reference Tag (EILBRT) field in the
  command, and the computed reference tag is incremented for each
  subsequent logical block. The controller shall complete the command
  with a status of Invalid Protection Information if the ILBRT field or
  the EILBRT field does not match the value of the least significant bits
  of the SLBA field sized to the number of bits in the Logical Block
  Reference Tag"

For Type 2 this remapping could work, but doing it unconditionally
will make all data written using and earlier kernel in a partition
unreadable once this changes has been applied.
