Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B51E274670
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 12:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745928938; cv=none; b=LXIJG4Z6ZV593r5C/F8/8sSvezO+vxV9Tmpy1PtOSchdOvEoElD+Q5xYiJ05ReOcyoABgeTR7WIzHvVMZk8EVj22B82fTrh8zNpMNS/FEjfRgnOt40NOlC5cIt32RgsPc9qWNVxc89DUsljJZFVuVAwpWydI4T1d4T4kU1fYLy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745928938; c=relaxed/simple;
	bh=GJ9B6+bKqDDwxcNkZrP+yt93SoL4Iw3VBDJ05KXYi7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ky/thauD4klTcDnhLllWGMBC1sz1aPO3x11MJ5V/4mxDc+IHTpdAgTkPKyA/l8OXKinYf8DsyQNV3FPhRjBKRKxP4QgKevPWq3gaiyYnQx8OS0UOha6fbSSUGWHrbHwZo5tNxXtfCKYrFs953bBBvKfMM1q7kmCTAOcum2eNbjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A939E68AA6; Tue, 29 Apr 2025 14:15:30 +0200 (CEST)
Date: Tue, 29 Apr 2025 14:15:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 4/5] brd: split I/O at page boundaries
Message-ID: <20250429121529.GB12411@lst.de>
References: <20250428141014.2360063-1-hch@lst.de> <20250428141014.2360063-5-hch@lst.de> <aA_Dyp97AIAqJ70G@kbusch-mbp.dhcp.thefacebook.com> <221bce43-83b7-b5ac-c6d2-ded23158dd06@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221bce43-83b7-b5ac-c6d2-ded23158dd06@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 29, 2025 at 09:38:28AM +0800, Yu Kuai wrote:
> Hi,
>
> 在 2025/04/29 2:07, Keith Busch 写道:
>> On Mon, Apr 28, 2025 at 07:09:50AM -0700, Christoph Hellwig wrote:
>>> A lot of complexity in brd stems from the fact that it tries to handle
>>> I/O spanning two backing pages.  Instead limit the size of a single
>>> bvec iteration so that it never crosses a page boundary and remove all
>>> the now unneeded code.
>>
>> Doesn't bio_for_each_segment() already limit bvecs on page boundaries?
>> You'd need to use bio_for_each_bvec() to get multi-page bvecs.
>
> I think it only limit bvecs on page boundaries on the issue side, not
> disk side.
>
> For example, if user issue an IO (2k + 4k), will bio_for_each_segment()
> split this IO into (2k + 2k) and (4k + 2k), I do not test yet, but I
> think the answer is no.

Exactly.  I got this wrong with zram, where it only triggers with larger
than 4k page sizes, and I got this wrong here on my first attempt as
well.  Fortunately testing found it quickly.  I thought the comment and
commit message document the issue well enough, but I'm open to better
wording.

