Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LTp9w+Pj"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C349E18D
	for <linux-block@vger.kernel.org>; Wed,  6 Dec 2023 13:34:30 -0800 (PST)
Date: Wed, 6 Dec 2023 16:34:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701898467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JfTfgeKvI5T6VMc/0k0zRS053aDBKMmp57C0Z7pwgG0=;
	b=LTp9w+Pj3M8wkdwFgP7qAhkJL9B6PDheGDmTOpK4mSfcyT6RrrZBCjfJ/UoIcn5yN/OePQ
	06yeokFgJzKrvhjJ8nEWD++Nv8fzU8rYPFRzs/jhlKUdwbGs/wk/ObaJmnGWa3PxkH+iWI
	ihdfyXlXxO1cfSaXWtbpSscPyiHC8JQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Phillip Lougher <phillip@squashfs.org.uk>
Subject: Re: [PATCH 1/3] block: Rework bio_for_each_segment_all()
Message-ID: <20231206213424.rn7i42zoyo6zxufk@moria.home.lan>
References: <20231122232818.178256-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122232818.178256-1-kent.overstreet@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, Nov 22, 2023 at 06:28:13PM -0500, Kent Overstreet wrote:
> This patch reworks bio_for_each_segment_all() to be more inline with how
> the other bio iterators work:
> 
>  - bio_iter_all_peek() now returns a synthesized bio_vec; we don't stash
>    one in the iterator and pass a pointer to it - bad. This way makes it
>    clearer what's a constructed value vs. a reference to something
>    pre-existing, and it also will help with cleaning up and
>    consolidating code with bio_for_each_folio_all().
> 
>  - We now provide bio_for_each_segment_all_continue(), for squashfs:
>    this makes their code clearer.

Jens, can we _please_ get this series merged so bcachefs isn't reaching
into bio/bvec internals?
