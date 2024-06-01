Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD338849C;
	Sat,  1 Jun 2024 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717257704; cv=none; b=MukHyTqboeVXBEnPYwJl0ZqEbszKA0NLiZGrbmfbSeoPDIJoh1zKe5FthFxHdTeqP++PCQ+OWRz68DofVYecq5NbQU/3rzwS1RQSo21IQcJh0rsauJK5GUVGNPiYwH+fSWzriABgkAjKcdDE20yKb/EvfVkij9xYY9IJ0gMzXWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717257704; c=relaxed/simple;
	bh=05XcYlktPM9pcAbcI9h/LPTYxBT6cd0X0+gq8dP8Swk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ON7PZqtM6/dc6Q25+85h3UQvfnq4QpP7pAZE65ekuAU5v8M8W1z+4uh59zZw8wF+VFzMfMlApy7yZ3msU8K+pWc/phctn6/AxX03BPIaQbI6Gu53pJfYHFtLiuyD6A06c7a5fnZZklr0eYTAAnbNexcGIOtb4kJ/m3Gks5f6sb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBW/k6tO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBW/k6tO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA5CC116B1;
	Sat,  1 Jun 2024 16:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717257704;
	bh=05XcYlktPM9pcAbcI9h/LPTYxBT6cd0X0+gq8dP8Swk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aBW/k6tO1AlSkw9xyimIASc2BVuXv2zG1SJq7TJAMI4fnlceS+O4aznhSSgmqAb7L
	 oAj2bHpB8+Ati8UbWWlQJcPrsHsZec1izqTtk4DR7hFILXRIHAQrdT8K5dwQUb/KGQ
	 wjnB1AQ86sXN6wtzG6zb0BLzcwKrGW4gdOnu89prB2HekO29VQ6FMRoivn5Eo7T986
	 VO4+TC8LLDP37vBdA0kvPXnjIL7j2s2eDPB6K/L7KY/PaBag8wBkYa+tLIeKC3aa1d
	 CsT6y/ssq+/b4DxI5RhDa/9B4IPZIWGypFpPwnFjOoAFQ5g5wg1bN2+024tXH2ZP9x
	 KKLadKjVdV5bQ==
Date: Sat, 1 Jun 2024 10:01:40 -0600
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
Message-ID: <ZltF5NvDnKFphcOo@kbusch-mbp.dhcp.thefacebook.com>
References: <20240601134005.621714-1-nmi@metaspace.dk>
 <20240601134005.621714-3-nmi@metaspace.dk>
 <ZlsvHV6y4DEdC8ja@kbusch-mbp.dhcp.thefacebook.com>
 <875xusoetn.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xusoetn.fsf@metaspace.dk>

On Sat, Jun 01, 2024 at 05:36:20PM +0200, Andreas Hindborg wrote:
> Keith Busch <kbusch@kernel.org> writes:
> 
> > On Sat, Jun 01, 2024 at 03:40:04PM +0200, Andreas Hindborg wrote:
> >> +impl kernel::Module for NullBlkModule {
> >> +    fn init(_module: &'static ThisModule) -> Result<Self> {
> >> +        pr_info!("Rust null_blk loaded\n");
> >> +        let tagset = Arc::pin_init(TagSet::try_new(1, 256, 1), flags::GFP_KERNEL)?;
> >> +
> >> +        let disk = {
> >> +            let block_size: u16 = 4096;
> >> +            if block_size % 512 != 0 || !(512..=4096).contains(&block_size) {
> >> +                return Err(kernel::error::code::EINVAL);
> >> +            }
> >
> > You've set block_size to the literal 4096, then validate its value
> > immediately after? Am I missing some way this could ever be invalid?
> 
> Good catch. It is because I have a patch in the outbound queue that allows setting
> the block size via a module parameter. The module parameter patch is not
> upstream yet. Once I have that up, I will send the patch with the block
> size config.
> 
> Do you think it is OK to have this redundancy? It would only be for a
> few cycles.

It's fine, just wondering why it's there. But it also allows values like
1536 and 3584, which are not valid block sizes, so I think you want the
check to be:

	if !(512..=4096).contains(&block_size) || ((block_size & (block_size - 1)) != 0)
