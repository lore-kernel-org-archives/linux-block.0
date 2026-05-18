Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82742FFDD5
	for <linux-block@vger.kernel.org>; Mon, 18 May 2026 22:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779144118; cv=none; b=bd3zHvfpfoyPLLi+/tFn7Y9ppdjAOMYvjn0QyUQ2uFz/oKJMBythqRYYyUh2mNpJ4VoisQvABL/RT5DPOJPW+wtNIEwM2p5Yje+jn/BHd0sUdsDppiMa9745ePG2rQ+dF9RONwZqvb6HVDbUacLz6AheX00bKsCvW8zFk1rZS90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779144118; c=relaxed/simple;
	bh=/m9Na+4BY6gmj3jriRMHq3pbKkdV5/qYlv0Jn+T/IOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cq7EdSOH1yhS582rdzxO7Ts9B4S7y1hg+o2i4G89yplUJObCZ6Lz68FZ1aBPPzb2xd4m0XZ4x4N24hzJxk/eUBWltlbYtw7tJgfUW5C1sHt5yBr8OaCMX2VyIk01ZFq7IgjdtUcT8Xgyge3HV45PrexhtCfxtltGMH13LNvmSyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3SDih/1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3SDih/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D752C2BCB7;
	Mon, 18 May 2026 22:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779144117;
	bh=/m9Na+4BY6gmj3jriRMHq3pbKkdV5/qYlv0Jn+T/IOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P3SDih/1oJoL53BNzkIbzPha1oyZ50G9QNgJt5uLSnjNqpLa+oc5/40TUyDynToQ0
	 LnwVHg3OowFqBo5OrA5u2I/AfEVMw7ttgD2Eh7rKb3dpj59CzG6LSEKTb1lIytyVoe
	 ghL6Uxk5zfZwJINHHOvgTcXRsWe3PcDpIi/03deOXiZnnse6BkhPcvUMDsGZzUjnmn
	 cn9ofFhst63H2h9tzSAHpFESIlcP3jtooe3tAZtDKzETLRwjnN2uFM6h2gqT8qFVOQ
	 /Df6G/DttIjIqJhemOd1LngHslzU4MoTwdoaPZkvu4RbBlCRQQg2nvEkTuWXWdopF7
	 D1K9YL6xFEKrA==
Date: Mon, 18 May 2026 16:41:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chao S <coshi036@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
	sagi@grimberg.me, axboe@kernel.dk, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH RFC 1/2] nvme: downgrade WARN in nvme_setup_rw to pr_debug
Message-ID: <aguVs9t5Pvz_y8CI@kbusch-mbp>
References: <20260427003457.1264511-1-coshi036@gmail.com>
 <afzWCpJSqvjnTgpF@kbusch-mbp>
 <CACd_6n29MeACfWpqK5jaSPOVK+q5yop+eeuO_Wk0M0E5Wr7ujw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACd_6n29MeACfWpqK5jaSPOVK+q5yop+eeuO_Wk0M0E5Wr7ujw@mail.gmail.com>

On Sat, May 16, 2026 at 11:53:54PM -0400, Chao S wrote:
> Not the freeze.  The WARN does not depend on q->limits, but on
> ns->head->ms (read live at dispatch, set inside the freeze window) and
> on REQ_INTEGRITY, never set for EXT_LBAS-non-PI.  capacity==0 only
> gates submission (bio_check_eod()), not dispatch: a writeback bio that
> passed bio_check_eod() under the old capacity sits on the task plug
> holding no q_usage_counter ref, so it does not block the freeze;
> blk_finish_plug() flushes it after the update committed head->ms != 0
> (dmesg: the capacity-change line prints before the WARN).

I'm also not what you mean about the task plug here. The plug list holds
requests, which hold queue references. The plug does not hold bios. If
you're not using a preallocated cached request, then the bio just gets
stuck on "bio_queue_enter" until the freeze completes with the new
limits, though it does proceed with potentially outdated assumtions.

So I think the problem is that the early checks are done outside the
queue entered context, and some of the following code depends on those
checks being valid.

My suggestion in the other reply isn't quite right for a couple reasons
(partition handling and issues with nvme multipath path failure), so
don't bother trying that.
