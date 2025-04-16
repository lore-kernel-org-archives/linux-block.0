Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406CA946F;
	Wed, 16 Apr 2025 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744841131; cv=none; b=a0GyphIWFexFCtFfBPgfSP8aE6n9cRGAS16yTgoBWDw7GZhjgO6jpqQkASotXnI1H2CHKsrhkXVbVJJG8r1TrHLKrvRmcrDaATwASJ1EVeb8tkPYTlJdU4EaKUqR5ZJbXdM9r30qtBRGw4hQqLi2CSIlDw1RyIyY247//M9GXL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744841131; c=relaxed/simple;
	bh=CBe1hrz6X6KL++qECv2jjlzYIuclnyXsaN1QUDJING8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rOOStrCyivMPUpP5XlWCGTcpRyn6SYOlCZlXcd+dInVI+KzhWItAdLq5UFqYBT0ZwQoOV5+VZYG+AFO90dtsqjDdjLXHW42jAYkafg8mkRipyhoA2WijUgjw1EzIcrBA1DKPRxtaYHeJjCTPF3GmGlb6SzZHcTfYlB/VsJ0WJjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GII2Qomw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GII2Qomw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5179FC4CEE2;
	Wed, 16 Apr 2025 22:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1744841130;
	bh=CBe1hrz6X6KL++qECv2jjlzYIuclnyXsaN1QUDJING8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GII2QomwB0GYFNET8NeYCkM8tw5De00en2hglF2dWRDUtuI6WgQH2uvzXiWyDdia8
	 WnJpEzNh612G6iQ4rLr5ve2BTwdC+ciTRbFYKGryaEb0NAlArpWqMcJwTrqeTTC5qT
	 EAK4YLdPhd9sLI/dRGD+y2OSUYsTjaW56/ZC0uJc=
Date: Wed, 16 Apr 2025 15:05:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-mm@kvack.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] scatterlist: inline sg_next()
Message-Id: <20250416150529.1e24677e3798cd783f4adb8f@linux-foundation.org>
In-Reply-To: <20250416160615.3571958-1-csander@purestorage.com>
References: <20250416160615.3571958-1-csander@purestorage.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 10:06:13 -0600 Caleb Sander Mateos <csander@purestorage.com> wrote:

> sg_next() is a short function called frequently in I/O paths. Define it
> in the header file so it can be inlined into its callers.

Does this actually make anything faster?

net/ceph/messenger_v2.c has four calls to sg_next().  x86_64 defconfig:

x1:/usr/src/25> size net/ceph/messenger_v2.o
   text	   data	    bss	    dec	    hex	filename
  31486	   2212	      0	  33698	   83a2	net/ceph/messenger_v2.o

after:

  31742	   2212	      0	  33954	   84a2	net/ceph/messenger_v2.o

More text means more cache misses.  Possibly the patch slows things down??
 

