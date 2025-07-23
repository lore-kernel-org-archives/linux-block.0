Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A636242A8C;
	Wed, 23 Jul 2025 04:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753245534; cv=none; b=j0+speWOAXD5X684VXWw+6l/EGgNEWOohIjjgpYgN3GrcbVpbBsXV/uwhNfdLtKfDNE8orKpUhJRUJ9pe5H30uhxuR7fLZdczfnO+vAmeccVX6ejZ4PzhO3+9DlTs9ywQ8LxVCfQXv71VwaljeeefZexIbRYFUQVf7+W63w6y6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753245534; c=relaxed/simple;
	bh=B7R3Z2iHzNDRVbgo2d90J7OtK3lh2IDEfxR1eGVCago=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kUORP7eOUICqPVC1FRXmgC4uxT4sFztosflodo9vgV81HbYQ0n78czwCQG0TxtHIu1Gu9WhkiIdk8r7RFn2RkTgkzuZ5EtFG6o0wJSW+80jkRJt7YXjNfDc+cCCBO8DHhiu7u5KasiR4hjTGeB130mQr02VuWJNsudNcO26RMcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3tiAtox; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3tiAtox"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0017CC4CEE7;
	Wed, 23 Jul 2025 04:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753245534;
	bh=B7R3Z2iHzNDRVbgo2d90J7OtK3lh2IDEfxR1eGVCago=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C3tiAtoxhiT0ZfHtu5XStuAYcX5/DES9J8fJmhGvFi3cuCfZhtayJouNj4zKCGi/g
	 jqoPVZCAtbqRPzd/4E/y8dd83GK/cVbppyW1JYmE3vh4dhEtF+w6NzFHFOCb5jygVh
	 JZbzvkdEk+0v8I5JxTYn+rjIsfE8IggtUfn8X5hED3EbBMI5hQK4Ne+q8AVrE6cize
	 4mp4sqa4iGQNd7p62yvQu2z+8czwb4panefKM2/AOgZew7uEhY13e2/1T+32ZAjsxk
	 Of9atfq/yQP5GE1kjIQtZJ+HwIOG4+AV3OY75BE5FksA3XnquW4IPH/Cm8fYIU5vVC
	 Yj2EYW398OcbA==
Message-ID: <b3d86423-acf7-4d12-b4c2-ead8958b35cf@kernel.org>
Date: Wed, 23 Jul 2025 13:36:26 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] lib/sbitmap: make sbitmap_get_shallow() internal
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
 akpm@linux-foundation.org, ming.lei@redhat.com, yang.yang@vivo.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250723024923.3211744-1-yukuai1@huaweicloud.com>
 <20250723024923.3211744-3-yukuai1@huaweicloud.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250723024923.3211744-3-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/25 11:49 AM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Because it's only used in sbitmap.c

s/it's/it is

and in the title: s/internal/static

With that,

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
