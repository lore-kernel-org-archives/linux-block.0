Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419A22D0C7D;
	Thu, 13 Nov 2025 22:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763071581; cv=none; b=IE1ZvdmWwd2a1QwWFG54VMahNOF+9NYLzScsJ+nkOIweSbrKe+pMxFheICIZmM5PinPjNRPNfcMtMr7XYlsiT/29oRXsj9E/7vE3pXTYqQOU6Jz8ZaNy+vFWD9S5lV1yBqsoo935gIYKYtS/yvdV8HGfwJulnN+/+5d0H9In9ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763071581; c=relaxed/simple;
	bh=dEZtN5l8FYb9oDr6Sp4FgBYW04B5QIT07xtH71+3Wig=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DBaRIcJIyjigvplUaBELaD8M10Xw2tmbV7at3BjsXW287LsjErzO+SkOPMIwqjgoN/4BgPvABqJ9XRuF8/+EinyIFQoeqLy7ccFPgk4dX3qU2VhVO6fAuZ1gv1eXV3IgbCJSBmXcozZb/Bxoe699psU5IhulUVmDg69s/mjNzRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cFWxT07B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cFWxT07B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF3FC4CEF7;
	Thu, 13 Nov 2025 22:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1763071580;
	bh=dEZtN5l8FYb9oDr6Sp4FgBYW04B5QIT07xtH71+3Wig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cFWxT07BKJi/RCzyhJaYQdT829nry3EOcIBz29aJ37aBheUeq9un+bwu3wV/ESIcg
	 GZ6T5qH8y7ZrbZxIHMXDl58vY/5bgHUYm6QiwH6odDLJszyZq0oZC3MS3TpCJG00Wm
	 g/T6vFHHZH6pCyInjp8ca8o887jKxo/ZN98jpSqw=
Date: Thu, 13 Nov 2025 14:06:20 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Caleb Sander
 Mateos <csander@purestorage.com>, Uday Shankar <ushankar@purestorage.com>,
 Stefani Seibold <stefani@seibold.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 01/27] kfifo: add kfifo_alloc_node() helper for NUMA
 awareness
Message-Id: <20251113140620.bc768aa94d734a654c31857c@linux-foundation.org>
In-Reply-To: <aRUypQzcovGikrV0@fedora>
References: <20251112093808.2134129-1-ming.lei@redhat.com>
	<20251112093808.2134129-2-ming.lei@redhat.com>
	<20251112112914.459baa16c4e9117d67f53011@linux-foundation.org>
	<aRUypQzcovGikrV0@fedora>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Nov 2025 09:21:41 +0800 Ming Lei <ming.lei@redhat.com> wrote:

> > > +#define kfifo_alloc_node(fifo, size, gfp_mask, node) \
> > > +__kfifo_int_must_check_helper( \
> > > +({ \
> > > +	typeof((fifo) + 1) __tmp = (fifo); \
> > > +	struct __kfifo *__kfifo = &__tmp->kfifo; \
> > > +	__is_kfifo_ptr(__tmp) ? \
> > > +	__kfifo_alloc_node(__kfifo, size, sizeof(*__tmp->type), gfp_mask, node) : \
> > > +	-EINVAL; \
> > > +}) \
> > > +)
> > 
> > Well this is an eyesore.  Do we really need it?  It seems to be here so
> > we can check for a programming bug?  Well, don't add programming bugs!
> > 
> > I'm actually not enjoying the existence of __is_kfifo_ptr() at all. 
> > What  is it all doing?  It's a FIFO for heck's sake, why is this so hard.
> 
> It is basically a clone of existing kfifo_alloc().
> 
> Do we need to clean kfifo_alloc() first? Otherwise I'd keep the same
> pattern with existing definitions.

Is OK, I was just whining.  Possibly de-over-engineering kifo is a
separate project.
