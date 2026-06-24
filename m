Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311041A3160
	for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782315542; cv=none; b=MMm8kBZV1C01EpvHvpsLsR8cGVqBgRhq3dnJjRO3yUVZG+A+XBb5jLKLkfHrhJP2CjISN4jbBfVjs2qbsrgYvxCpeuHJTY90aeNgQ9lGhmV88TrCPj7U6h5WxvZlSQuhhdrjbQFgwQwXj164s+6doaJQa/bMs7H+B6JUDJWj+d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782315542; c=relaxed/simple;
	bh=e4yoGdlJkqL3DjPOOBqXd7XVft8e4mPVnwHoRYDuX1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sC2m8u9IKuNXoQZadNR2Cy41frHtj4sjWE3NMHbfpEYDogcKUF0KoUac79vD7OR8ZA14s0vxTXPeh+G5lfKCK/Va/GjqCuxCk0qraHZN8gA5JZ66NafUi3x6Ix5RSp2WihMhcuNXxSdmIH2QxVbjXjTcCAPkTZEXOweT7jjnDHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AEA6E68B05; Wed, 24 Jun 2026 17:38:56 +0200 (CEST)
Date: Wed, 24 Jun 2026 17:38:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: handle REQ_OP_ZONE_APPEND in
 __bio_integrity_action
Message-ID: <20260624153856.GA13186@lst.de>
References: <20260624080014.1998650-1-hch@lst.de> <20260624080014.1998650-3-hch@lst.de> <CADUfDZo4hysS6qj=Z=dEzVk=DQe6D7-zTFODLk8RGTJ13RY5uQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADUfDZo4hysS6qj=Z=dEzVk=DQe6D7-zTFODLk8RGTJ13RY5uQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 24, 2026 at 08:29:07AM -0700, Caleb Sander Mateos wrote:
> I take it 4-KB integrity intervals don't work due to the lack of
> remapping for REQ_OP_ZONE_APPEND? Sounds like we should come back to
> the discussion about cleaning up the ref tag seed and remapping, then.
> I never got a reply from Martin on that thread. I guess remapping is
> necessary at least for partitioned block devices, but we could skip it
> for non-partitioned block devices if we initialized the ref tag seed
> correctly.

We don't actually need the partition remapping because there can't
be partitions.  But I see on-the-wire reftag value that are 8 times
what they should be, so there is some kind of unit mismatch that your
series fixes.

