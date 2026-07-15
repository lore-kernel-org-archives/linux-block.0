Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAD12F8BC0;
	Wed, 15 Jul 2026 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131304; cv=none; b=SBhU47XidI48tJ5TXHWqa+UG7feEvmmKLBYighGi7PB0+XndtHQLY/eQaAa3wfggahp/9ByFcBmxFFl+4q+9x8xejqX63meyx36PWuRInXvfXPAfQcO/5tIfnaPlEr+i3UEPXEGRESX/mUT+j5wDenLr3L/ZAscURpLrmJGbvk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131304; c=relaxed/simple;
	bh=P6+BacNEbPVgCpg/afcY03V/sudTlkKvfLIAg0Q6rfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ea0AbLAXdjIn4LSY9mrQ65nAJmhcPMPuGVXEm7hSlMAoEloOh3QFWwFa3TYJaMtQ6ffnPQS7h+m8y1Y8qbim0BZUySXBYFR3Hsm219ey2wSr0DaBoMz3g8td1qAWDSgki5HKlhgrhIuPZFiL6J4jxYsmX9gwYzd5YjsCE1knjTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRshH5t1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRshH5t1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879B31F00A3A;
	Wed, 15 Jul 2026 16:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784131301;
	bh=7tBe5Hh5CZ9elNDX+NryJrxuUN0H1brjZYHGsOoRSfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lRshH5t1r6At+UCyzxIn+UZOUDMdzTGuGsCYdi9w4mD3TJADafkaaZoT+hRpHf6b2
	 rQ3vDn0ESOZlZFaHttSqqR8lmF1UKdBMbZP/ky1bwdubAflv3+s75ES+77aMwZm2tQ
	 xKgxwN4arecU0/X642znBfaNf4XI7cK/e7uLJRxMyYCBR3Kgjtr1CCnLjaYhDWc7Wr
	 O+BT1ResAyI+plW8ebqO+DUhPC5zOM29lETxU9Nagu9ZissqzUHyUR+MG5sxc9G2e5
	 /uPKkhHp7XxHIJrcd8iLSSEqYJeWuXQtIzIrmFfjLaqYbMEKMMwwqrmSXRqS0t49oL
	 ouWLV1Cp4OAAg==
Date: Wed, 15 Jul 2026 10:01:39 -0600
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] nvme/core: advertise BLK_EXPECTED_REF_TAG_CAPABLE
Message-ID: <aleu49e4GxG-Z7B6@kbusch-mbp>
References: <20260627061933.2187447-1-csander@purestorage.com>
 <20260627061933.2187447-3-csander@purestorage.com>
 <20260714135310.GB714@lst.de>
 <CADUfDZoGheGP6JCwwV=BCBnqxAspJ1n9Aes=UsjtS-DxAMxeEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZoGheGP6JCwwV=BCBnqxAspJ1n9Aes=UsjtS-DxAMxeEA@mail.gmail.com>

On Wed, Jul 15, 2026 at 08:30:33AM -0700, Caleb Sander Mateos wrote:
> On Tue, Jul 14, 2026 at 6:53 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > For Type 2 this remapping could work, but doing it unconditionally
> > will make all data written using and earlier kernel in a partition
> > unreadable once this changes has been applied.
> 
> I mentioned this in the cover letter (and that's why I marked these
> patches "RFC"). Unless you have a clever idea, it does seem like an
> insurmountable obstacle here.

We had a similar problem when we enabled PI at the end of the metadata
rather than just at the beginning. This left machines unbootable after
upgrading the kernel, so we have a module parameter to turn off support
for the feature. It's an unpleasant solution as there's no upgrade path
to ever turn on the feature without a format first.
