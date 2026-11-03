Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793684062;
	b=oGKm5p3nwkMl5suvkWAs14j1svD2rjwch9u8f+/brDdZwW4GwpdMAl6dehnKP0GmqhoO
	 uRa+TS/3+Go0Q9eNx2xSD9f/d7wmGFJ1RLlstgk3BKl1GjxJdMvPLigRueKwsjTLHBuZ+
	 KYv0exdYZHx8V47IHesVnjOO2uU4f4aoDOzwz1/zqpp3BL1D6RLKFWmf6e/ShTg2cBnvo
	 wxsf4lzlgezMUz1UFnU+ijakiqm2mUf+uG+lr0vDcWxW5Z2XdtDyCDbSn++hK/SfmcozU
	 XAHrwlon0ge2VkV2Wzlg9/FSNROIAoKiVdrVfmJr2uPe1P9lKcg5PAOeBwcPu9r+PwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793684062;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=e1ii5Nc0K64GGXQlj0RdDB0bnzLArtSnWOmuU4l/Now=;
	b=dGriGulVaBfO0kjaHmWvQMyAn5wHKRZHsANwTQ0mCkAjQiol/sVloDrvotD+UmcKXQhN
	 dUp1vIv3jJaIw8OPgHFNkB72HOx/b1gOnysFEbFJyX4KSlppbS3n0uXT1HlQXvgOsJYA5
	 sbCB/k2yNhqtkCguw6aL8z3wD1vaF8NdorfmIyHS8C3eN9oPzqWzoX4Jx/SoA//kQXru9
	 qLg3tm5M/oM0zXM+ECqTlaXN65k2YSi4W6QVjTkEOSBuVSDaVJYGD9YZE5+RgK4UcKFkS
	 rn5WA3Ki4Olhfe5pYS47CQOJM6aoUEPdzNs7gTxX8hr189hg6gTZdXElwCopmjYKsZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD8F606A324;
	Tue,  3 Nov 2026 05:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAD8F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7B23968AFE; Tue,  3 Nov 2026 06:34:18 +0100 (CET)
Date: Tue, 3 Nov 2026 06:34:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Zizhi Wo <wozizhi@huaweicloud.com>
Cc: axboe@kernel.dk, bvanassche@acm.org, hch@lst.de, yukuai@fygo.io,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yangerkun@huawei.com, chengzhihao1@huawei.com, wozizhi@huawei.com
Subject: Re: [PATCH] block: partitions: reject GPT entries with
 starting_lba > ending_lba
Message-ID: <20261103053418.GB1382@lst.de>
References: <20261102080442.3775061-1-wozizhi@huaweicloud.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102080442.3775061-1-wozizhi@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 02, 2026 at 04:04:42PM +0800, Zizhi Wo wrote:
> From: Zizhi Wo <wozizhi@huawei.com>
> 
> A GPT entry whose starting_lba is greater than its ending_lba is accepted,
> and the kernel creates a partition with a bogus size. The bogus sector
> count defeats the end-of-device check, so I/O through that partition is not
> confined to it and can access sectors outside the partition on the same
> disk.
> 
> is_pte_valid() only rejects an entry when its type is NULL or when
> starting_lba or ending_lba is greater than lastlba; it never checks that
> starting_lba <= ending_lba. For a reversed entry both field checks still
> pass, but efi_partition() computes size = ending_lba - starting_lba + 1 in
> u64, which underflows to a huge value. That value also wraps in the
> end-of-device check in blk_add_partition() (from + size) and does not fit
> the signed i_size, which turns negative.
> 
> Reject entries with starting_lba > ending_lba in is_pte_valid(), matching
> the head-level check against last_usable_lba < first_usable_lba.

Looks good in general.  But should this be a >= to also catch zero-sized
entries?

