Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD9C1624D2
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 04:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747888202; cv=none; b=t2Cd+DpPpZyvv4P1ymAjJjy2rUweGHGZUH1E+DFt3lqCyQQ9U9wuQ6yZBaLZRrVKD6MYuFrNtg8qyh0mAuI/I3vKZdBVayDo4s6ydmIj2NqNmrTqiTb7wocOxsBgG06rqsfp9Kjn2P6UJlLXvDt/yNreHw1YhZfth5Bw4s4ZyiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747888202; c=relaxed/simple;
	bh=97ruOcxigrpBRwQGdKQtJ+Pl/tpRdk9Whg+hn7cxaFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eORpZLP4IKc58bkuwqISTPc2PdVG7/2xUH1Dw8OKx13SYYVbohIgEix9TpK+9YNccbNfuM9ZLQM99om5bSIU3Sem/gXZyuIvRO12vF+H49Odb0O6B28ASls6L6Lwv0hW06dg2T3QunlTQd2T7n96mS04erIBq+a7VUyuE8ovg3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzC84e8n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzC84e8n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B7AC4CEE4;
	Thu, 22 May 2025 04:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747888202;
	bh=97ruOcxigrpBRwQGdKQtJ+Pl/tpRdk9Whg+hn7cxaFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fzC84e8n7qnFGZDCleQl2m0oHjiCWVStb4iis69dBCBEb/HqZ0fHXF16IZwEaFyNf
	 B3AJ29YtNOh325PswiP/byoS5PW3gPIyTHYjDCMYKjSlQ3vNjwpwoRQqNINA91Trx8
	 ygKISCTaPI6HWWSwyCWra5IS7iFet/1GL9SAuWdSQC8lCHrPSfElNlnYdGrFswFsxV
	 KVtPQa0TxRekTxnC4JnwwnGhwNVtCVr+0rOHTjTc3ACjXw1Gmh9AH2TpCWc0EOmU8c
	 XjPseF1QlL3oCbC1sliBfF5bGS5til/PysBKqrKSmHe1kthauL8UTq2L9j70R3T9wf
	 Q0tcr1DtSTI0w==
Date: Wed, 21 May 2025 22:29:59 -0600
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/5] nvme: add support for copy offload
Message-ID: <aC6oR90OFDSITndh@kbusch-mbp>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-4-kbusch@meta.com>
 <CADUfDZqVeaR=15drRFvdrgGyFhyQ=FtscaZycVrQ0pd-PGei=A@mail.gmail.com>
 <CADUfDZqC0kiLTDFv3kXNaDr25rb+6RGG3cW3r=mox2vdihpsow@mail.gmail.com>
 <aC6Ymfrn1cZablbE@kbusch-mbp>
 <CADUfDZr8DJUPhLvVFK9OPSv015VDSBGNv7z_rrioHFAqOALUOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADUfDZr8DJUPhLvVFK9OPSv015VDSBGNv7z_rrioHFAqOALUOg@mail.gmail.com>

On Wed, May 21, 2025 at 08:41:40PM -0700, Caleb Sander Mateos wrote:
> For the record, that change broke Linux hosts sending DSM commands to
> our NVMe controller, which was validating that the SGL length exactly
> matches the number of data bytes implied by the command. I'm sure
> we're in the minority of NVMe controller vendors in aggressively
> validating the NVMe command parameters, but it was unfortunate to
> discover this change in Linux's behavior.

This is a fabrics target you're talking about? I assume so because pci
would use PRP for a 4k payload, which doesn't encode transfer lengths.
All the offending controllers were pci, so maybe we could have
constrained the DSM over-allocation to that transport if we knew this
was causing problems for fabrics.
