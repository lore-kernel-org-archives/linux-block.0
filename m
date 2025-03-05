Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0389F253F07
	for <linux-block@vger.kernel.org>; Wed,  5 Mar 2025 19:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741201656; cv=none; b=Dk91ASo/rjK408e26UJAtCmN0pqeyr0Tm2292z5jNYC5YuhaAINJerKMAfLUKQ+QGH1KBYTkpr9G57TxspeDFP8BGf+GKZQBQWVNxO57HOsv6broitW8fexfkakDm9FiD7q7DLLwptDmkPs3z++kMvVqVQtXChBB2qJjQkM5eoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741201656; c=relaxed/simple;
	bh=6kzdLM4P0SDjX+t0am6rCKo/fIv4sGsAKavBLO3IyrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7wgK9Y9XPLjaAFZ0p5RDd4vStp9HB97kojZNj7K12VZZKV40G1TmCA8APayTE/7Mwb033cqKSgvDQGOnw1BmCwfkSPn1yYJkqPd+fGInxqaYr2mGRZuHukgNucpruwq98uJDwgGHSrUSICJaqKPwgr40+Eu35TKLIRPN8DO/nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7B1eLoP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7B1eLoP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E93C4CED1;
	Wed,  5 Mar 2025 19:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741201655;
	bh=6kzdLM4P0SDjX+t0am6rCKo/fIv4sGsAKavBLO3IyrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P7B1eLoPWCuyuBjvB5aKCRnLeisgbGtptSvrScB4dYyvwUivrMeOsM3MK7tewYAUb
	 A2RAf+8t5hQSbzhmMSartV8KvACHdE1zYUULzJzqmr8uCbv87drsRghJQIUGnRTC5s
	 czAL1POnkWEkoe9DEnQJiM78IrGvM4GkVqkARLJ2Wm5TTGHG+M8LA3wTnEN7kprKZk
	 rr2Fc9lSWQpv8OE2wxLDt/Q6ZvhFAUmDyM3SKQyeYOCIjqRhLfxmwZvX/kiK1UUJJY
	 0gakgL4yqV1aG2D8Uyb1pJjcJ62+7IIGLlhBZdRNmz6ND4ztcvgW/nxn/U5McH7ztq
	 73LVAv1v3PwUw==
Date: Wed, 5 Mar 2025 09:07:34 -1000
From: Tejun Heo <tj@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>, Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH 1/3] blk-throttle: remove last_bytes_disp and
 last_ios_disp
Message-ID: <Z8ig9jN9d6RDkJT2@slm.duckdns.org>
References: <20250305043123.3938491-1-ming.lei@redhat.com>
 <20250305043123.3938491-2-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305043123.3938491-2-ming.lei@redhat.com>

On Wed, Mar 05, 2025 at 12:31:19PM +0800, Ming Lei wrote:
> The two fields are not used any more, so remove them.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
