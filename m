Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477BB2EACF7;
	Thu, 26 Jun 2025 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750952033; cv=none; b=X+FTJ3tYKvtrsY8ae5Zhd8kxm9BcHRhM/AF8QnjBPVIJbb29LD7qQl4MtmI1R8/9QSP1bGgsyiUGl22Q8hAq/MIvJSllCoyuMM4Pcg5/xZ5wlgHGfSdXNrTWeMDDFkCofNBXrBj9aFsS11qTKiR5qRKb7Nb3ArGuee6RLBhtl78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750952033; c=relaxed/simple;
	bh=9AqOCgzIq2qjVIqZ9nQZ52A6GLNyWPrnkRNtMT2sEn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seubsdFnMZLs8+ocGVUdbclK/gFfwcd+CP7/dvW+cM2dfyPx04skuw+0has7v9O6lbEgUZryQHCMogIfy5r0ZciDiep9mIqj7MTeZoz/xHy6ELm1gu5ehqI8YaRFYi4LKik3DEgZCSxXvaTRy5A1r1trtdil8kUbBGOVgVMU53U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5kBz9QU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5kBz9QU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A206C4CEEB;
	Thu, 26 Jun 2025 15:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750952032;
	bh=9AqOCgzIq2qjVIqZ9nQZ52A6GLNyWPrnkRNtMT2sEn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d5kBz9QUZI7DDU1oS4GZBrk4RrROYnRva5si5w1NIUphs4jzZd8aJi8MMIU9h5ooD
	 CIcYoLtgpAfRubxeW0EE0Gwxve+/UYGANTyWw7BlAr2w9Zms308ON6BQvgShARSIlL
	 sPjxqnIqo+xQj7pKLolLgQjy4BaVLlbSZYT4Hua48yNebQ28X0NTKY4SCiXmkyT5yJ
	 oSgCOYA3GJUaLadnnLPfZGSyr+HAPIY5AMEt0XkPnjErBoY9KcdNJUeKec6N6ZFu+W
	 Wy9Ym/BDo6fSTTz9BmqlsW6heQaprZPw9P6SF7cRoDIiHmc/Nzdfs5gwClrsX6jmE8
	 8mWIIpOz4ZThw==
Date: Thu, 26 Jun 2025 17:33:49 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 11/27] block: Protect against concurrent isolated cpuset
 change
Message-ID: <aF1oXYifR_jF7YSJ@localhost.localdomain>
References: <20250620152308.27492-1-frederic@kernel.org>
 <20250620152308.27492-12-frederic@kernel.org>
 <aFjqUXIyi9CuY0aM@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFjqUXIyi9CuY0aM@infradead.org>

Le Sun, Jun 22, 2025 at 10:46:57PM -0700, Christoph Hellwig a écrit :
> On Fri, Jun 20, 2025 at 05:22:52PM +0200, Frederic Weisbecker wrote:
> > +		 * running block kworker on isolated CPUs.
> > +		 * FIXME: cpuset should propagate further changes to isolated CPUs
> > +		 * here.
> 
> I have no idea what this comments means.  Can you explain it, or help
> fixing it?  Or at least send the entire series to all affected
> subsystems as there's no way to review it without the context.
> 
> If nothing changes please at leat avoid the overly long line.

That's definetly confusing.
I'll try to clarify that on the next iteration, or even try to fix
it myself.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
