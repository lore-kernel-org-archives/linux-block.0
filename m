Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3D92E3365
	for <linux-block@vger.kernel.org>; Wed,  5 Mar 2025 19:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741202171; cv=none; b=C/NEB4tXBxGMaGmJhXL84pqLPDapfpQZq/Qc6QLd40IBsI0K+miCep8/mo560fMxkO5mMBzpJ77jBZPMX/cH6auTKNjxaCE/XlUSCOhqA3SFMJxPm8bbZPPfCEskqwQsKOOIACOJTm4jHJZbeGga714SRG2xSuCa1/nNTMLk8dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741202171; c=relaxed/simple;
	bh=rvMwyLL3nCfHYqbuO+HPKde/vFlvvsarWtubcbl4aKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dq7cGfS3ZtsPz9V7SL/R8UG5qcT8Weozt3D/4e/THBcfDl+5i66tznOhHK5YIFpY14YJ9a+gdXGpQmRF1HItbY8cpIDNa+mKZwO+aFjQbWsokpU2UI6OHLsQmrLPSRX4q9eSPgqP6mjQzaSGvmV1ytrnlGITI3pYPaSUAJI7+GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDJ0L718; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDJ0L718"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F49C4CEE0;
	Wed,  5 Mar 2025 19:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741202170;
	bh=rvMwyLL3nCfHYqbuO+HPKde/vFlvvsarWtubcbl4aKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CDJ0L718E/UxyX+Yud0aEicur7N3SLcu05xFrTd9V4/nNv04Q40FFiBoCcqW2yt30
	 Exmtcfp9BjizHckb1CNv9iCdfQoCgjvZrrqnCWPC0A8ZUEA30lSb/zjc3B5Rahult8
	 fsWJ0Y3STJUpvlwif+pZPUKfMi3B/XMS8qZmDvQSotuhwbLzIvxFvtPsEQLIiMRAeI
	 3pEHTxbOYUW77EsYAFYOQ2EMgWvp6L26beIfbe+ZaEs2Z3/wiEMew52rthmRwTHwOG
	 7bKa7nyZCsl3YywU3+puGeobQJ5xLWyzqZBz2u72qTggkuZF0DS+RdJeYOrDNKRKEG
	 DIXCtWGn90qfg==
Date: Wed, 5 Mar 2025 09:16:09 -1000
From: Tejun Heo <tj@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>, Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH 3/3] blk-throttle: carry over directly
Message-ID: <Z8ii-QViMUjOoYgt@slm.duckdns.org>
References: <20250305043123.3938491-1-ming.lei@redhat.com>
 <20250305043123.3938491-4-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305043123.3938491-4-ming.lei@redhat.com>

On Wed, Mar 05, 2025 at 12:31:21PM +0800, Ming Lei wrote:
> Now ->carryover_bytes[] and ->carryover_ios[] only covers limit/config
> update.
> 
> Actually the carryover bytes/ios can be carried to ->bytes_disp[] and
> ->io_disp[] directly, since the carryover is one-shot thing and only valid
> in current slice.
> 
> Then we can remove the two fields and simplify code much.
> 
> Type of ->bytes_disp[] and ->io_disp[] has to change as signed because the
> two fields may become negative when updating limits or config, but both are
> big enough for holding bytes/ios dispatched in single slice
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
