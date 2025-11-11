Received: from sg-1-13.ptr.blmpb.com (sg-1-13.ptr.blmpb.com [118.26.132.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9212367D5
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853814; cv=none; b=ecVnF4C2b65EQ2xzD5BZ08GdnlUVcM5vqNlRgba9Bq7POOesGvoONIgl5sd074ZZ1XF5v9RH0SauA3Yr96MF/IN3A/PHXfYgzRUKvuA40FS1jUGsUbyaaxo7ag+4H4NBTCcx0YzBml+ppQbP/UvC8PgcXhWyjw7kOjnRP6tm+8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853814; c=relaxed/simple;
	bh=ivKh2Yc/0ceUpUxhfZhdA0TV4wEp86c5iioUH4/+dQ0=;
	h=References:Cc:Date:From:To:Subject:Message-Id:In-Reply-To:
	 Content-Type:Mime-Version; b=Qz8LWDrPrvj2tICgMVai11f64mKOp0NNqWV3xIMQP8fSMqvH9o+uqZPA3p2FBcMyCYAXnV82KdGyQ2EYHHdi51cgaV9C/0d0MyijUXEBCXtAiJH7m4rC2w8j+klGJHqtQ+TQ/zd4khkCgZoeRQNA4tE2iY8dU5U3LfxiJFry7nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=tO5vh+Xb; arc=none smtp.client-ip=118.26.132.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="tO5vh+Xb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1762853804;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=y8+6rwJgqErWpL/4ECXhYdHtNxzUCg39YKSvZcNo43U=;
 b=tO5vh+Xbzct1R/v97OzAqQZ0nFD4EMj0qAeetZ+v1g4k/30wMqYkZ2VlGWC1QIRBX0Ekz4
 a2JxBLIh+ZZeAgZbvI6IuYwr1x8B2ANkTz5DDqruJKsjNBq/LGLLU4C6j+9bXBdLXCDbKW
 bAvum1YVVXW1WI86M3lqIjdOjvc0zyrrTTBEd1G47dTKmJOSdhVskj/d+gosfEeDyfmnKe
 v8YA6Xpu3SNNDFH2GRQUuJn4NcztPXpqnZs7GZ4izUDQ4EvEqBPDhjFOzyik/FWCV6o/1M
 9NQO9cEhDpu+d/s97U2s7bHCkcuXDLnczkdpFF8FsnOHeUIbii4/hP6hVAADog==
References: <20251014150456.2219261-1-kbusch@meta.com> <20251014150456.2219261-2-kbusch@meta.com> <aRK67ahJn15u5OGC@casper.infradead.org> <aRLAqyRBY6k4pT2M@kbusch-mbp> <20251111071439.GA4240@lst.de>
Organization: fnnas
X-Lms-Return-Path: <lba+2691303aa+2741f2+vger.kernel.org+yukuai@fnnas.com>
User-Agent: Mozilla Thunderbird
Cc: "Matthew Wilcox" <willy@infradead.org>, "Keith Busch" <kbusch@meta.com>, 
	<linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>, 
	<axboe@kernel.dk>, <yukuai@fnnas.com>
Date: Tue, 11 Nov 2025 17:36:39 +0800
Received: from [192.168.1.104] ([39.182.0.168]) by smtp.feishu.cn with ESMTPS; Tue, 11 Nov 2025 17:36:41 +0800
From: "Yu Kuai" <yukuai@fnnas.com>
To: "Christoph Hellwig" <hch@lst.de>, "Keith Busch" <kbusch@kernel.org>
Subject: Re: [PATCHv5 1/2] block: accumulate memory segment gaps per bio
Message-Id: <024631dc-3c65-49a8-a97a-f9110fd00e9a@fnnas.com>
X-Original-From: Yu Kuai <yukuai@fnnas.com>
In-Reply-To: <20251111071439.GA4240@lst.de>
Reply-To: yukuai@fnnas.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

Hi,

=E5=9C=A8 2025/11/11 15:14, Christoph Hellwig =E5=86=99=E9=81=93:
> On Mon, Nov 10, 2025 at 11:50:51PM -0500, Keith Busch wrote:
>> Thanks for the heads up. This is in the path I'd been modifying lately,
>> so sounds plausible that I introduced the bug. The information here
>> should be enough for me to make progress: it looks like req->bio is NULL
>> in your trace, which I did not expect would happen. But it's late here
>> too, so look with fresh eyes in the morning.
> req->bio should only be NULL for flush requests or passthrough requests
> that do not transfer data.  None of them should end up in this path.

This can be reproduced 100% with branch for-6.19/block now, just:

blkdiscard /dev/md0

Where discard IO will be split to different underlying disks and then
merge. And for discard bio, bio->bi_io_vec is NULL. So when discard
bio ends up to the merge path, bio->bi_io_vec will be dereferenced
unconditionally.

How about following simple fix:

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 3ca6fbf8b787..31f460422fe3 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -740,6 +740,9 @@ u8 bio_seg_gap(struct request_queue *q, struct bio *pre=
v, struct bio *next,
         gaps_bit =3D min_not_zero(gaps_bit, prev->bi_bvec_gap_bit);
         gaps_bit =3D min_not_zero(gaps_bit, next->bi_bvec_gap_bit);

+       if (op_is_discard(prev->bi_opf) || op_is_discard(next->bi_opf))
+               return gaps_bit;
+
         bio_get_last_bvec(prev, &pb);
         bio_get_first_bvec(next, &nb);
         if (!biovec_phys_mergeable(q, &pb, &nb))

Thanks,
Kuai
