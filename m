Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FDE3A9001;
	Thu, 14 May 2026 22:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778796159; cv=none; b=nUqGjRg3ROhtawVVUKir/Z509R+gneGQq4HoaqPXKZdGB9+rdqtIlVwJmCyKaG7P4uU0f0W+zoyg6EVjzCUD4otJGCyHrIBvR5RGf0WVffvvmIgAiK3QH+e30wlVBKXE9QwxhOhWJiEkjGE8iMh+VKBR++zs/zzfV+n6Yz/8BYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778796159; c=relaxed/simple;
	bh=2X9ZgN8061Mu8+oMsn/2rf62DJhzRPO1bUbIFZDbC0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OF+LiCKWZ72bZpryTXJ3iknPTpVPtp4QLMJrkoY43CJylHt6dnq2Qs3QEVJ89dYv0a4zx3619367N5wqJd8a/9ysTLN5QFWewvfQkvZNVf96jfF3ADhqV5sSFCqYSIdqF5hz2uiqkkNawOyyFIcKFVva1GnP0YczjZyssQSGDfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKzNfJl5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKzNfJl5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C33C2BCB3;
	Thu, 14 May 2026 22:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778796159;
	bh=2X9ZgN8061Mu8+oMsn/2rf62DJhzRPO1bUbIFZDbC0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MKzNfJl5ZJpP3FvSiTlPKrUZZEDOh4enqVrhs7nN4M3ofCxcaVXlh8RsHd7h7J1m/
	 geav/iV1/DQwnT5QUe1Wif/jIEQWqoVEBClonF8Gybe6czpagJOQO2y+CW6m4fakQw
	 Wm49Vqavhj4zPjYhs3SkryL6fi73tuUnxJ4CX1PVCaTxpkgG59n80mCI58q/+S1dsC
	 9in1aAUGp8oMN5a4PXUSDYRBJeH8HZJ3yTV1S8kJqTYzVnV5DD6dHOFGpGdrJA+p3b
	 CAEZKcDHuBLamir939h5sISQe863yq3gSwg2IvGQXF/T6MWVU4tJW43QwXugouTv80
	 JwkYOD0KxtM2A==
Date: Thu, 14 May 2026 15:02:37 -0700
From: Minchan Kim <minchan@kernel.org>
To: wang wei <a929244872@163.com>
Cc: richardycc@google.com, akpm@linux-foundation.org, axboe@kernel.dk,
	bgeffon@google.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	liumartin@google.com, senozhatsky@chromium.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] Re:[PATCH v3] zram: fix use-after-free in
 zram_writeback_endio
Message-ID: <agZGfRoVRPKW3LEU@google.com>
References: <20260512074918.2606208-1-richardycc@google.com>
 <20260513140218.7425-1-a929244872@163.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513140218.7425-1-a929244872@163.com>

On Wed, May 13, 2026 at 10:02:18PM +0800, wang wei wrote:
> >@@ -847,7 +849,7 @@ static void release_wb_ctl(struct zram_wb_ctl *wb_ctl)
> > 		release_wb_req(req);
> > 	}
> >
> >-	kfree(wb_ctl);
> >+	kfree_rcu(wb_ctl, rcu);
> > }
> 
> Do we need to add a 'rcu_assign_pointer(wb_ctl, NULL);' before 'kfree_rcu(wb_ctl, rcu)'?
> 
> Signed-off-by: wang wei <a929244872@163.com>

Why do we need it?

My understanding is rcu_assign_pointer() is typically used to publish NULL to
a shared pointer variable so that future RCU readers (using rcu_dereference)
won't access the object before kfree_rcu().

However, in our case, wb_ctl is not stored in any shared pointer variable.
It is a local variable in writeback_store() and RCU readers (zram_writeback_endio)
do not look up wb_ctl from a shared pointer. They obtain it directly from
bio->bi_private of the specific bio they are completing.

Please let me know if I missed anything.
