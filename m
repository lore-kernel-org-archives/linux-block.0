Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE0330146C
	for <linux-block@vger.kernel.org>; Tue, 15 Sep 2026 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789468132; cv=none; b=moVd2XM1lK70WcDekvc0BY2IrF2HPUsi/M2/369c3A9HFFxW3Aaycq7nMSA6GfLLAUvvWUj6KaHKHUZuutnd2ToR+PNcOMqZn6tXxaVCD0/JKUhV0SlLSdnrJh/lozLFKw5oZBWZPhR0lQqKt17xQpM2R7BWV3fb1Vi3p09napU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789468132; c=relaxed/simple;
	bh=SyhggNopWpCw79nKtC4JOqjNng3y5c7puwk4OgQRzr0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Q0OUK1ZYf2M+gk9OSewsf10A8Lwsd1zGgZdKCztT5qpK29b56XXmAk5Vu+NXFanRe740CV8Q4+A5LOGy4UOjQmTaF4LTxGQD6dOA1w1a3WANu4fGFgvDEM7yBqhXrtCCZsII1R2l7VZMT9p92dfaC2etWfC2zmYFCjWV3mMm51Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2N6equq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2N6equq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41FB1F000FF;
	Tue, 15 Sep 2026 10:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789468131;
	bh=1oLTFpKHOo0TG9BzbBfloOK1wt7U7Aijtk7fKV1fzUs=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=k2N6equq/8sOSUX/cwNjehekUd56PpFIZ4oET+rdNdznwZ/rCnraaRMKeQUrqm3NJ
	 V/y4Ls0La1YQlnqOov4K7sL9y6cdn1rjeGzS1U8K6Mx+Y0QnON1JuqJB9rtsKrRlao
	 f0Wn1ehPn49gGMwD/JLUgLs8u9iXCWLq/o0IjpOLdKVnre0p103qKfGl1J7gSJO9yL
	 KfpeSCxhkc6AxUvc1Itl/dTIwtNoNWONoP9AXPU77BWhs2v9y+ZmsxE8KV9xm+XIqJ
	 TSfcaa4ZreCAt2zHOB72Q4U4qUUKf+LdPQkuIFnVtaDwAC6q1JVA6VRvrRW1hv1AOZ
	 A1X15+35bVS6w==
Message-ID: <4c25b864-1e7d-4677-a136-96f94cfc3860@kernel.org>
Date: Tue, 15 Sep 2026 17:28:47 +0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/16] Improve handling of offline and read-only zones
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260908085745.1082697-1-dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260908085745.1082697-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/09/08 15:57, Damien Le Moal wrote:
> Jens,
> 
> This patch series refactor some zone related code, improves the caching of
> zone information and the management of zone write plugs in preparation for
> fully supporting storage element depopulation.

Jens,

Can we get this queued up?

> 
> Most of the functional changes here are around the revalidation of the
> device capacity and the management of zone write plugs to better handle
> read-only and offline zones as these conditions can become more common
> with storage element being depopulated.
> 
> Changes from v6:
>  - Rebased on block/for-next
>  - Added patch 2, 9 and 11 to make revalidation more solid against disk
>    capacity changes. Due to these changes, review tags for patch 4 were
>    dropped.
>  - Added patch 7 to improve cached report zones.
> 
> Changes from v5:
>  - Rebased on 7.3-rc1
>  - Removed patch 13 as it was sent separately as a fix patch
> 
> Changes from v4:
>  - Renamed bdev_check_zone_mgmt() to bdev_zone_mgmt_allowed() in patch 10
>  - Added Fixes tag to patch 13
>  - Added review tags
> 
> Changes from v3:
>  - Rebased on latest block/for-next
>  - Small modification to patch 4 to address Sashiko review comments
>    complaining about the potential for out of bound accesses to the zone
>    state array.
>  - Added review tags
> 
> Changes from v2:
>  - Minor changes to patches 1, 5, 7 and 8 to address some of the Sashiko
>    review comments (a lot of these comments point to cases that cannot
>    happen in practice or that are non-fatal and would generate errors due
>    to a user invalid use of the device).
>  - Applied review tags
> 
> Changes from v1:
>  - Fixup error path change in patch 1
>  - Use WARN_ON_ONCE in patch 4
>  - Dropped patch 14
>  - Applied review tags
> 
> Damien Le Moal (16):
>   block: remove disk_free_zone_resources()
>   block: improve capacity handling during zone revalidation
>   block: refactor disk_revalidate_zone_resources()
>   block: refactor disk_update_zone_resources()
>   block: remember a zone type regardless of its condition
>   block: refactor bdev_zone_is_seq()
>   block: improve blkdev_get_zone_info()
>   block: introduce disk_for_all_zone_wplugs()
>   block: serialize zone revalidation
>   block: drop all zone write plugs on capacity changes
>   block: retry zone revalidation on capacity change
>   block: propagate readonly and offline conditions to zone write plugs
>   block: always treat offline and read-only zones as dead
>   block: fail zone management operations to read-only and offline zones
>   block: allow read-only and offline conventional zones
>   block: simplify disk_zone_set_cond()
> 
>  block/blk-core.c       |   7 +-
>  block/blk-zoned.c      | 848 ++++++++++++++++++++++++++---------------
>  block/blk.h            |   6 +
>  include/linux/blkdev.h |  11 +-
>  4 files changed, 550 insertions(+), 322 deletions(-)
> 
> 
> base-commit: ba285edf3fd1a27f8ec739b5b396d45c98eabee0


-- 
Damien Le Moal
Western Digital Research
