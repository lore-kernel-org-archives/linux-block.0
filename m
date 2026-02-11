Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2923F36A018;
	Wed, 11 Feb 2026 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770814657; cv=none; b=CZ4CE9Il2RjR41sMa8fRjiTcbFtQtNSTcShRzasGAUHy7xEKUgYMSfES5NAuy6Q381Schrqcl91683ZzzRIDqT+fqyKLY9mD/uxnjtvU0gaAdtTPdIt5KFK7s8CjQkNKJB8q/Iq+zDUglpuSGk/5503Ki80+SliCT13cV5yPF7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770814657; c=relaxed/simple;
	bh=XvbrZw2AZpK5leQ4f+TgiwyXrZvpb6CMDr/DqgF7/5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Roa+wjjm35KgIpvElmeRqLEJVuyCEKLDUiBjg2qZVihJP3bvbd9AJz/tcbMyd7M/uWGN/tL5+5uNpwxHzodOhXnE/yDYP5+wLrkM2sYatchFG1U/tNrG/ycU8cO5U0IS0gtreNt9m/RNGwed1T5umoWUoIErhS6sPtYNgO16t3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNU+ESGt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNU+ESGt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C7FC4CEF7;
	Wed, 11 Feb 2026 12:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770814656;
	bh=XvbrZw2AZpK5leQ4f+TgiwyXrZvpb6CMDr/DqgF7/5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fNU+ESGtDO2Ti+ttGuhiJqYiykPzuh7lsqvLwKI5znwLB5CtWsquTcLu/PDtBJ8Ju
	 rudCjda9tqldUokjmyiDQwVPkAQlU6SYuzh0gqsNqmmrKYS2KzitjTxQtSOeGrjzsm
	 ZcQ3lzOzAt8o7TQIVEkVQPCB8DpWLTpc7bwI8l+idQf0YC0PHGOljkLwPfHUTamK8A
	 GQYhycjNxmjX5/WXGTmG3PmwGy7G5g98y+FHRAAwFgqIiXTMEe0b/HFLtJbd99X6pj
	 PYghBI5O4aXsi1PAWtU+niby5D/HcyV7kWZZZB8WRI2W6eHvQ2vd2CfH32awyYvLC6
	 gEx8tRVTeX9pg==
Date: Wed, 11 Feb 2026 05:57:34 -0700
From: Keith Busch <kbusch@kernel.org>
To: Yu Kuai <yukuai@fnnas.com>
Cc: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>,
	axboe@kernel.dk, sagi@grimberg.me, sven@kernel.org, j@jannau.net,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	tj@kernel.org, nilay@linux.ibm.com, ming.lei@redhat.com,
	neal@gompa.dev, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] nvme-apple: move blk_mq_update_nr_hw_queues after
 nvme_unfreeze
Message-ID: <aYx8vo5kY-nEir3b@kbusch-mbp>
References: <20260209082953.3053721-1-yukuai@fnnas.com>
 <20260209082953.3053721-4-yukuai@fnnas.com>
 <20260209145832.GC18315@lst.de>
 <aYn-xwFHCpd7sITJ@kbusch-mbp>
 <e3e7d95b-2712-4365-922d-731449e7193a@fnnas.com>
 <aYtKFNm-wRKn6l66@kbusch-mbp>
 <20260210154108.GB2484@lst.de>
 <aYtWSscg6L9xxlzc@kbusch-mbp>
 <f3451ddd-96b6-4bc1-9d4c-964e361d56fc@flourine.local>
 <baa254f9-c41c-44f7-959a-8ce69e1768fa@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baa254f9-c41c-44f7-959a-8ce69e1768fa@fnnas.com>

On Wed, Feb 11, 2026 at 09:57:26AM +0800, Yu Kuai wrote:
> If I understand this correctly, it seems fine to make progress with this set,
> currently IO can return error during the race window, and this can be finally
> fixed with this reinsert.

Yeah, if you can just make sure to add an equivalent patch for nvme-pci,
otherwise the last patch in this series will deadlock it.

Some experiments I've run over the last day have me convinced no one is
actually hitting queue count changes in nvme-pci, so I'm not concerned
with opening that race to this scenario. You'd get IO errors either way;
your proposal just potentially gives you more of them, but I don't think
encountering that is practical reality right now anyway.
