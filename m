Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E11B433D0;
	Tue,  8 Oct 2024 15:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728401736; cv=none; b=TxG9DzSZLp7RRB4LfIf/LFPN43b6OqI4XoqTCbggdQ0sU5mTzTAoB19h0ugqWULQnuaZR0JK3Qo91XvUVKDIpjij6l3LBQXhCAntmpKdiv2LK3ZN3iX28EmdsYDvceMAQwVQvL20FTeh5FTsmEBT/5dsEPXpZRqz9yknUIBBF6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728401736; c=relaxed/simple;
	bh=BdFp0G9NXCYerm9aRjpbvzTi0frjXpESVZCwZdltNV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lM1wSCBrFWuMrPZnWOrzo9++HPUoWMHXJlwcOegV+s6z+EgN+Fbt4eoX8n1WoQKr+ZEm5PbtM8Szy0AlKL35AsX+k7pEhPk+M+u5Xx4hb3rtOnrcP+IMvuF6i7W4QXlfwZxYM3Oqe9y4It2Nss84Xq8NoB/cazHJ5YLDe3Tjmww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+3fLnV6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+3fLnV6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2C9C4CEC7;
	Tue,  8 Oct 2024 15:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728401735;
	bh=BdFp0G9NXCYerm9aRjpbvzTi0frjXpESVZCwZdltNV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q+3fLnV66tzcStKdpnQICdQesmSCkNIgrHq9aeJuJmVRFR9JraF6MTqDr4r6IGfxs
	 GhLIfd8d+C5RMbWnjiGRrLDv/Q53ZboSLBTeaB4khJwvBDBXIhuoCmnwI0Tz9apksL
	 EV+37yxVw/Z/TMo/w3CwbhufP0YSzJZXuktoWj43CtYkY06w+lPMjf2js3Wxlq9aEK
	 +xXMcTXMh4kXsfvIx1CgOBjFTCNK3twAEUhnrjrJHk481ELG6NfK/oSGp6jyQSUStq
	 xBJUb0H81JK8y6GQpXhvdj8wM41UI9OZ+Tr3D4RjCyr2t87NBG957RzURWR9yLcmSg
	 Ggvnmhbw33BiA==
Date: Tue, 8 Oct 2024 09:35:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: SurajSonawane2415 <surajsonawane0215@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH v3] block: Fix uninitialized symbol 'bio' in
 blk_rq_prep_clone
Message-ID: <ZwVRRLOq0BlpsBrn@kbusch-mbp>
References: <20241004100842.9052-1-surajsonawane0215@gmail.com>
 <20241008120413.16402-1-surajsonawane0215@gmail.com>
 <ZwVHF_0Z0dNnYW58@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwVHF_0Z0dNnYW58@kbusch-mbp>

On Tue, Oct 08, 2024 at 08:52:07AM -0600, Keith Busch wrote:
> I think your commit message is missing the real "fix" here. The other
> place that goto's this label is if blk_crypto_rq_bio_prep() fails. At
> this point, the cloned 'rq' has all the bio's that get cleaned up in
> blk_rq_unprep_clone(), so that failure scenario is double put'ing the
> last bio.

Ah, forget that. The existing code was NULL'ing the bio before
prep_clone, so the scenario I described doesn't happen.
