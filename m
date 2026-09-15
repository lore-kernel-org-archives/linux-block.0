Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A1021D3F5;
	Tue, 15 Sep 2026 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476283; cv=none; b=nB5nRCNRWzaXZo8/IjurQKT1skSdUiwy+RKUednvUPiK5Qlg0AVFXubMSAPg38BcXradyZ2cNeSlqetPJ8+jun+UmnhyVRQlT/rU17K/e1pzd+ZGHoJdWXeSnsX22nA4MXPgyavlc9fCy2UTOkPUS+hgELbPq2bd+EqkjAF31VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476283; c=relaxed/simple;
	bh=dwSHFkKfChGSAQHdSz08eW8hNmKf9FIgIujq3jUfcfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BoEnb78k7SUJAISQjLdioH3i5wXnmZ+Va5/0lzPxE7GJUsqCZvCPUsO2vwOs90oFL+y26cTyT9rIwHYULU60nop+kzeYpxSiveG+1eDAj2IKuRW282Lp27CrvEoh8QcerDNr3i0ubaGpHoZTZ+uQZ7NVVAYOgeQWCKcEiqR9Wmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+q89oxs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+q89oxs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE781F000FF;
	Tue, 15 Sep 2026 12:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789476281;
	bh=kYjgKg8FJSch5X6qTXLbOygFuCFhkDQDgCQQ+mDGVM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U+q89oxso7DOjp1/NdLQaivsJQMsQrgc6tOA0LXDdigQuqgVQ/ZIbO0vOYO6W3D1p
	 NIw6wCHuMxYnYCpAXE8eq/XVrDPSWl2il7++GzIJOgYpWajpCYR1AOd8CcJ9F0IMYy
	 urx+6MpqfnL3m6/t5UCbvA/CqN5ds4vZU/obaNs+8HTiJzlTjVep/LEVP0fOLKITBY
	 4tetqBAMc+5sREOmQtHdyosbEIsL/E5dAXXXUTbEky2uvlV0lcUFrwniFxHgWLifB/
	 N3iSoii34TCs44zjAf+FIEPe671IiErf7SZKoL8ztuEkLJZ82K+KgJxcibC8bbj+HN
	 8i3aG6SHHm0xg==
Date: Tue, 15 Sep 2026 14:44:37 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, 
	Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Fix the thaw_bdev reference in bdev_freeze()
 kernel-doc
Message-ID: <20260915-abflug-inkarnieren-vorne-0aed591d9439@brauner>
References: <20260911233415.31271-1-kmehltretter@gmail.com>
 <20260911235451.GD6283@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260911235451.GD6283@frogsfrogsfrogs>

On Fri, Sep 11, 2026 at 04:54:51PM -0700, Darrick J. Wong wrote:
> On Sat, Sep 12, 2026 at 01:34:14AM +0200, Karl Mehltretter wrote:
> > The kernel-doc comment of bdev_freeze() refers to thaw_bdev, which was
> > renamed to bdev_thaw by commit 982c3b305843 ("bdev: rename freeze and
> > thaw helpers"). Say bdev_thaw.
> > 
> > Fixes: 982c3b305843 ("bdev: rename freeze and thaw helpers")
> > Assisted-by: LLM
> > Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> 
> Not sure why I'm on this, but this is correct so
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

(Questionable privilege of having been around long enough? ;))
Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
