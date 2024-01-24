Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F8743154;
	Wed, 24 Jan 2024 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706111060; cv=none; b=hY9aRWUGT3tt2k/ASd4HoErrTHjH8rx0EYeoR7D8A6lAG0eYY7EM/pkqSH6NhQyrSFQRpD9NM88Bs3dsOaX0v0k4IrYYfp5VdTQvusyFzcvYrVbf70Amer3pOezDSVNAbh7sAYxmSXVMzvjxrQwV4h8/zepGlMzc8fv/zt9vJsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706111060; c=relaxed/simple;
	bh=XUVYGutZnX/aj4Zc4p8aaUAv8j90EpK8WCQ5Xf58mLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlidpxJijt2HIjhnmaXMU618NrSS5NfayBRzxY5/sWENrANWa8D/4lvzKK8q9e2RdXRa97lk7qkVNbGffDrn34BZwRlERSVFFsfTfHRe4a51/gwtY1wTSCV7l5DJ9lRaJeufm2+hf824tIBCsDGsWlqrrdadxTQwHRYFh55Be5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSE/qG+l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSE/qG+l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D96EC433C7;
	Wed, 24 Jan 2024 15:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706111059;
	bh=XUVYGutZnX/aj4Zc4p8aaUAv8j90EpK8WCQ5Xf58mLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sSE/qG+lJOHta/yUc1nd3IPR6nM5p+j9OzpJE1MY2e6a28x31ny2HbHYpkWczyCzE
	 6msQW7PfXO1FnssRD5V7s6xED9FVNCDlij1HVwsICV+4sq5leli3DFJivzW4M65dDb
	 RqkPt9Ezyetiz34V+ALYEIgeprapOxIPgwIkFR71FVYX3MVL41228gbbpb94G4oZbF
	 UEUN/euua5FZRooooNpZhVJ94fJaar/JVZbunH8Sm57SfDmqW+/m65Be9SNLFQGl6g
	 MORBWbXzJGMXnwE5VtT094wUm6/UkPhloEZaRSHMKYkO7XowuQAdwOAQU8VrUm/nyS
	 ydOoRVCcW7TKA==
Date: Wed, 24 Jan 2024 08:44:16 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 05/15] block: add a max_user_discard_sectors queue limit
Message-ID: <ZbEwUDrmTlWTfK75@kbusch-mbp.dhcp.thefacebook.com>
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-6-hch@lst.de>
 <Za6zg-pA8IJkIb_b@kbusch-mbp.dhcp.thefacebook.com>
 <20240122183857.GA7029@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122183857.GA7029@lst.de>

On Mon, Jan 22, 2024 at 07:38:57PM +0100, Christoph Hellwig wrote:
> On Mon, Jan 22, 2024 at 11:27:15AM -0700, Keith Busch wrote:
> > > +	q->limits.max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
> > > +	q->limits.max_discard_sectors =
> > > +		min_not_zero(q->limits.max_hw_discard_sectors,
> > > +			     q->limits.max_user_discard_sectors);
> > 
> > Shouldn't writing 0 disable discards?
> 
> I mirror the max_user_sectors behavior here, where 0 disables the
> user limiting.  But yes, that would be a behavior change.

But a user should be able to disable discards, right? Unless you really
want to match max_user_sectors, I think you could default the user
setting here to UINT_MAX and use "min" instead of "min_not_zero".
