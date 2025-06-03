Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAB88494;
	Tue,  3 Jun 2025 23:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748994553; cv=none; b=Zlsz9B5PxVDzGeGuB1Ve6xt9UAp693EDAcgaZ/TlOAo4hAZQI4mmgO/lslY81657R/VFLp9YC+HladRUM2iUYj/vG46oD8x7963blztNtZrb0rvOmZJSSFbSiXxrPS9iHx2gXpAlzXKYyVeQmqZy2SxK06W0WBj5/6ZDwPSgkiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748994553; c=relaxed/simple;
	bh=YV4RHlYa+iw+dMXA/ajVhbrZILDAjbAxorgvqTf6xa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8Lt5Yniz9x2otHGKtPAHUOtPeFM821F4dZsLoP4OwQcnMG4Y/4unqdc51GCwiScca0oJWuWvIqvQYx2IQsFa7t42YzhZqKCyXxaKN9rUrKoIbkrKrRtsCqfZQMU3AcluVQoVqlP36SgyfGStmkfAGE5bDAuB8fWt7SIAoBfyuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7IUdGyV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7IUdGyV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E84C4CEED;
	Tue,  3 Jun 2025 23:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748994552;
	bh=YV4RHlYa+iw+dMXA/ajVhbrZILDAjbAxorgvqTf6xa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U7IUdGyV7uA24k0zemL5YARhpidnPSbe2W0Rt0F3JJXQy6CzY60p2XGRjzzAclofY
	 2JBTePYxkKvcisxpPWimzE9WBlzmIAtP8Iw6IriWiu3PM/gBMF/2dzuR9LDNl9lOMt
	 ZeyUeM1d+hHKGPeFSI1XAGCbyFGZ7Sc2oMQOf2XhFXAedHD7aB/3xrLa/JuCZ5z2jG
	 I3AwdLaPMtd4TVh75st54r4ukVmacK8Zk8GMkxmyourLmUSw87qNFXX/uhbxoLesJO
	 WBkv7p8DzOYwv/qPKeeY4WsH2OeCRsrmjRLIU4kjusZaKgAPaTeYTr20wMwvETmGTO
	 0aINCn0tJewIw==
Date: Tue, 3 Jun 2025 17:49:10 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: flip iter directions in
 blk_rq_integrity_map_user()
Message-ID: <aD-J9mzq_bJe26rD@kbusch-mbp>
References: <20250603184752.1185676-1-csander@purestorage.com>
 <e37d8707-8770-4f20-a04a-b77359c5bc32@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e37d8707-8770-4f20-a04a-b77359c5bc32@kernel.dk>

On Tue, Jun 03, 2025 at 12:54:05PM -0600, Jens Axboe wrote:
> On 6/3/25 12:47 PM, Caleb Sander Mateos wrote:
> > blk_rq_integrity_map_user() creates the ubuf iter with ITER_DEST for
> > write-direction operations and ITER_SOURCE for read-direction ones.
> > This is backwards; writes use the user buffer as a source for metadata
> > and reads use it as a destination. Switch to the rq_data_dir() helper,
> > which maps writes to ITER_SOURCE (WRITE) and reads to ITER_DEST(READ).
> 
> Was going to ask "how did this ever work without splats", but looks like
> a fairly recent change AND it's for integrity which isn't widely used.
> But it does show a gap in testing for sure.

The change is good and correct, but it doesn't look like normal tests
would find a problem here. The iter direction in this path only adds the
FOLL_WRITE flag, which appears to just check for writable access. Unless
you're specifically testing something using read-only PTE's, a test
wouldn't have triggered an early error. ?
