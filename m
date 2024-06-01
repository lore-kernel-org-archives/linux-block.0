Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7589B10949;
	Sat,  1 Jun 2024 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717251873; cv=none; b=KXv0EccHTffBTkOoSizopTpIR5o8TGocatKto2ANfDpEgGe4jZX97TxpiCLbTBRzXRDjO4aiheQ1PynSgf3sundvcYvKWfgbvg2UqAWWndEvIri7hG66WUfBv+U3W1M5/sKh2veE70n3UAjpRp4k/ZQyvq2QLhyFbq3a2Q/WFsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717251873; c=relaxed/simple;
	bh=3hpQGG0DXNOz5SDZzCSta1IGiF02qt2SWM+gfOhfF/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1S/EZKTMJ0hNEzr2/IBrxrh9cSgFIX44SetWT75hinXYyLjPC1LWT1TofLOaIGtTNVF/zkH8nVHzzSXe+VT0E7Uzmm41o4xGXUswcMnrFBbaKAAkZauuWJGsGnfo8lUg3tXTvaPYlUc3w2ePSPp7dxTAma4PpVJgbS3NObjS8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJyxFB3o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJyxFB3o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF01EC116B1;
	Sat,  1 Jun 2024 14:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717251873;
	bh=3hpQGG0DXNOz5SDZzCSta1IGiF02qt2SWM+gfOhfF/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AJyxFB3otjuYJSZT9fWb84TQMFrA2DG/52s5pD4j4oi/54cIya+Zufr0luSztLMbF
	 ElRL0+vsQ0oDJIbOJ7NoBLGhYiZjquTcvcig2Cr7YnpR25alKPPYPLqdnlmA7Aivyz
	 GAgwl9B0FSwxiA2lZLlgUuZqjyTJVmCsmIa5ynLP9SGKhjUQzi6OcwSmonDP3IQoeF
	 klkp8ZxDNqMv+ZDZDGG3DgEsUptU1RBcKProhdwf9b36Es+TvYlMkGSmqI8dCmAzeC
	 5zj8CdYaJZVk+DxxVuxZ9GvZFT/1tZ2LNZnZtqkddgafQ55TuE+mzYqwl1gImTqq78
	 bPZNWoyiX+2mg==
Date: Sat, 1 Jun 2024 08:24:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yexuan Yang <1182282462@bupt.edu.cn>,
	Sergio =?iso-8859-1?Q?Gonz=E1lez?= Collado <sergio.collado@gmail.com>,
	Joel Granados <j.granados@samsung.com>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Conor Dooley <conor@kernel.org>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>,
	open list <linux-kernel@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH v4 2/3] rust: block: add rnull, Rust null_blk
 implementation
Message-ID: <ZlsvHV6y4DEdC8ja@kbusch-mbp.dhcp.thefacebook.com>
References: <20240601134005.621714-1-nmi@metaspace.dk>
 <20240601134005.621714-3-nmi@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240601134005.621714-3-nmi@metaspace.dk>

On Sat, Jun 01, 2024 at 03:40:04PM +0200, Andreas Hindborg wrote:
> +impl kernel::Module for NullBlkModule {
> +    fn init(_module: &'static ThisModule) -> Result<Self> {
> +        pr_info!("Rust null_blk loaded\n");
> +        let tagset = Arc::pin_init(TagSet::try_new(1, 256, 1), flags::GFP_KERNEL)?;
> +
> +        let disk = {
> +            let block_size: u16 = 4096;
> +            if block_size % 512 != 0 || !(512..=4096).contains(&block_size) {
> +                return Err(kernel::error::code::EINVAL);
> +            }

You've set block_size to the literal 4096, then validate its value
immediately after? Am I missing some way this could ever be invalid?
