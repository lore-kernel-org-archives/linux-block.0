Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0F02F50
	for <linux-block@vger.kernel.org>; Fri, 29 Mar 2024 15:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711725886; cv=none; b=EhGvKiTlEXMUpoTPeUMSWLF826sgKiubM84Ip9GT1w2stzsiylDss4wtq1qZF/X66Av+WsnVyS0tQFcSm5mDJTpXbfWr0KRsaeoevbDfSVfEqm7LRG9dwRqIGFipgsVNQchFXIQY/uiNgVyfJWOjq0Hit19HcOEHHqToSzRm6dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711725886; c=relaxed/simple;
	bh=udc+KXuYlF9D9IDWOeqTCJcTiUCYqup37o6QbhGf1s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0eZUvg8Q6l8CflxHavAfZM1K5Vj0kwFTO2g8DUtBg+s9z+p64zQz5gebzkNdgpnCmyD7Cu9ZXtj6U9lqwygVpo931B1S2uxMVV+dAVjHEU9cFfOohsNxs5tC9BdkL1dRvm4JOJVC2/soPthluA1hejBMCcooXyd/5Ybo/ja+UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbDG7mOD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbDG7mOD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14CAC433C7;
	Fri, 29 Mar 2024 15:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711725886;
	bh=udc+KXuYlF9D9IDWOeqTCJcTiUCYqup37o6QbhGf1s4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sbDG7mODHnjbLuGKhFVUArG8D7iNlmfBqpB8lZqee4Whzsj8tah26oiuj+ZKJROw8
	 rQXOkwG8USHMBdTH832VQWTnXppFd34EgGwvLyoX/sGPPMDXl9+cAZuP3YNhAKu2n2
	 /tsFF63GoQ9AYZRdbdgAxsP47xjPDAPwbuC5lo5OR//VcOvYtIm3uWGyO8i+UCMwbi
	 PqfIuq5ofkmVyY7Fxxq5U0x8BpD68Z1e3qTtm4Dj/PAAEB00DvasNTJM1G/DDRc6h8
	 uOoM9RuexkZw+sXX99kRwE1w5la/nsUIkb3KIaKw2uKyu24nIxwDo4YhDaL2xtWpZI
	 GgL2Gg/RWb7Og==
Date: Fri, 29 Mar 2024 16:24:41 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, 
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: handle BLK_OPEN_RESTRICT_WRITES correctly
Message-ID: <20240329-weilt-bakterien-51b26268830c@brauner>
References: <20240323-seide-erbrachten-5c60873fadc1@brauner>
 <20240323-zielbereich-mittragen-6fdf14876c3e@brauner>
 <ZgZJ54rW2JcWsYPA@casper.infradead.org>
 <20240329-erosion-zerreden-c65a45286fae@brauner>
 <20240329-eckig-anklopfen-527dbbfb1452@brauner>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240329-eckig-anklopfen-527dbbfb1452@brauner>

> One other observation. This line right here is suspicious.
> What I expect to see here is something like this:
> 
> Kernel panic - not syncing: VFS: Unable to mount root fs on "/dev/vda2" or unknown-block(254,2) ]---

Sorry, I looked at the wrong codepath here.
