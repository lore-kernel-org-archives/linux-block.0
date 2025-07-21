Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA642D8DA2
	for <linux-block@vger.kernel.org>; Mon, 21 Jul 2025 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102934; cv=none; b=niJAklGO9WNvFXIwB4bGY7mJRZ11xKeNmWYt1PO7hQbZjvG/j7N6soGsEON5qaGhaGxWmq9pYtn74G2Kijc3EAenGNhlIOLhKMVXnRXr8z0JdPoDLA58wYgo4rT++w6hxw+sy4x4Tvj8m+CsdbDcVxQJCIz2VrBCKJ4lY7r8JhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102934; c=relaxed/simple;
	bh=p4j7Lgg/B4X34dI8wnTg5Z98ut3yP+q1z75vPKC7Ryg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4nX5TltPOXxYfmuvv1RMWa1bMdim8fb8NI0o+5G1Eu7E2gjpjOvKmNqenMHAF8jaqtIGr/1xCO0s+MmiKDOt3dMmD0RAdm+elIk/gTOhgNKNi8DJpmEA1ZFp3nn6qCOI1PZC7zYVWBiYyhjg1QCe8L8vn9RlIN0JRxIX5k2vsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7Javm7z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7Javm7z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3431C4CEF4;
	Mon, 21 Jul 2025 13:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753102934;
	bh=p4j7Lgg/B4X34dI8wnTg5Z98ut3yP+q1z75vPKC7Ryg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q7Javm7zFcFuqnlBXq5DnZ8OIfKUlG2F19GuY4jZoPLZAm8tNwqPxtwLmv0zcLtvH
	 4wSJhMsy4QMDfYUutnu6CB6mBLeGv9uA0MNJEQqwUZPhz30bATsrBfjT0Z3xJ9OxQe
	 bncCYoK4c7ylmnTOIZnMl/XG5xhvbYRDV8Evsp9nYg+eGYVDjfiKjcMUZWl5WCpWA9
	 lxe26tnmx4O7ktw7TpbRq0yRsEULd7u2OYrQkj5AKg4RheEgpbCvCAggFOQ1g7U6v2
	 UoYff5HXZMExGE/QWHGzP5JeHPuEj2WZ5gNWeuuJa90H7MB6p/QmRGoRBAiEnm5UP5
	 M2PlwI+eUzbzA==
Message-ID: <ec79f6be-bd33-4654-b933-edb021a5e780@kernel.org>
Date: Mon, 21 Jul 2025 22:02:11 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] lib/sbitmap: fix kernel crash observed when sbitmap
 depth is zero
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, hare@suse.de, axboe@kernel.dk,
 johannes.thumshirn@wdc.com, gjoyce@ibm.com
References: <20250720113553.913034-1-nilay@linux.ibm.com>
 <20250720113553.913034-2-nilay@linux.ibm.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250720113553.913034-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/07/20 20:35, Nilay Shroff wrote:
> We observed a kernel crash when the I/O scheduler allocates an sbitmap
> for a hardware queue (hctx) that has no associated software queues (ctx),
> and later attempts to free it. When no software queues are mapped to a
> hardware queue, the sbitmap is initialized with a depth of zero. In such
> cases, the sbitmap_init_node() function should set sb->alloc_hint to NULL.
> However, if this is not done, sb->alloc_hint may contain garbage, and
> calling sbitmap_free() will pass this invalid pointer to free_percpu(),
> resulting in a kernel crash.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>



-- 
Damien Le Moal
Western Digital Research
