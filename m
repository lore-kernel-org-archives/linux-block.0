Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F70D364
	for <linux-block@vger.kernel.org>; Thu,  7 Dec 2023 00:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TOpGHcvP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE5DC433C8;
	Thu,  7 Dec 2023 00:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701910494;
	bh=7NQaJczkVv5wrigtA1QaLdfOwqAzSDMCJYkOqBKS8no=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TOpGHcvP2acc+8l2aN2+Nrzd+A9ar1eqkWzpGllk3b4EM4LXWPb2W4PGAUL+lJwAM
	 bKM14QyBxYo4nECo1dITZVL7fzf6hAnMQ8UqF+PcHOlFn73bvspEHH0625NOEmrzhW
	 l0CD22MSCSgEhntr836Phts2sN4l0L8XqqwPA9IU=
Date: Wed, 6 Dec 2023 16:54:53 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Ming Lei <ming.lei@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, Yi Zhang
 <yi.zhang@redhat.com>, Guangwu Zhang <guazhang@redhat.com>, Chengming Zhou
 <zhouchengming@bytedance.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH V4 resend] lib/group_cpus.c: avoid to acquire cpu
 hotplug lock in group_cpus_evenly
Message-Id: <20231206165453.613dbe57555f41ab4b9b0acc@linux-foundation.org>
In-Reply-To: <ZXEUyH/38KeATuF4@yury-ThinkPad>
References: <20231120083559.285174-1-ming.lei@redhat.com>
	<ZXEUyH/38KeATuF4@yury-ThinkPad>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Dec 2023 16:41:44 -0800 Yury Norov <yury.norov@gmail.com> wrote:

> Although, it's not related to this patch directly. So, if you fix
> zalloc_cpumask_var(), the patch looks good to me.
> 
> Reviewed-by: Yury Norov <yury.norov@gmail.com>

Thanks.

I just moved this into mm.git's non-rebasing mm-hotfixes-stable branch,
so I'd prefer not to have to redo it at this stage.

Let's do these things (with which I agree) as a followup patch, please.
 
