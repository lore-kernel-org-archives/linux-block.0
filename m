Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8691381;
	Wed, 22 Nov 2023 00:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnNvymB2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B154C433C8;
	Wed, 22 Nov 2023 00:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700614480;
	bh=u2D2TK5J9yvcZIFrTPk8qSx9G+KhwoNjbJNTBr4Lkm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LnNvymB2+kFeYw9PdwPmHqlZJWw8A2qXUFP4zLECwZkcPKbNdYe2viMbaBUgdoBLj
	 2PbFFJCDiU7Ng3BTcJ4hiYkL9NHW49VzRIIIDhN96Tm3gCIW+NDlFc2Er6uvtz5bNo
	 o0Muvl6uLG71Vy3Jb48E1Ucj4IBIypByRxDp2RkAb82rkC5GD4Jmbwg0gPCPZU+Qy4
	 GdFRVK5oKtEifttXGP4kakNdTeADEZFGHDKktttjYMJ47lMlhY0iQ2dOoNJsvlDqgG
	 0aB5JRzS3sllQJEt1O3pe26LCkFObz6+/hhsndRRNEZ+Ah3Vr7tsGRiuBiwnf9OYam
	 ijupJ5VcaTanQ==
Date: Tue, 21 Nov 2023 17:54:36 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de, joshi.k@samsung.com,
	martin.petersen@oracle.com
Subject: Re: [PATCHv3 1/5] bvec: introduce multi-page bvec iterating
Message-ID: <ZV1RTKkKUkNybFuk@kbusch-mbp.dhcp.thefacebook.com>
References: <20231120224058.2750705-1-kbusch@meta.com>
 <20231120224058.2750705-2-kbusch@meta.com>
 <ZVxsLYj9oH+j3RQ8@fedora>
 <ZVzRmQ66yRDJWMiZ@kbusch-mbp>
 <ZV1OxMPsJYq7Tyaw@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV1OxMPsJYq7Tyaw@fedora>

On Wed, Nov 22, 2023 at 08:43:48AM +0800, Ming Lei wrote:
> 
> And you can open-code it in bio_integrity_unmap_user():
> 
> for (i = 0; i < bip->bip_vcnt; i++) {
> 	struct bio_vec *v = &bip->bip_vec[i];
> 
> 	...
> }

That works for me. io_uring/rsrc.c does similar too, which I referenced
when implementing this. I thought the macro might help make this
optimisation more reachable for future use, but I don't need to
introduce that with only the one user here.
