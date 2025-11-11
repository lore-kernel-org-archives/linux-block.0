Received: from sg-1-11.ptr.blmpb.com (sg-1-11.ptr.blmpb.com [118.26.132.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5F7221FBF
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762856078; cv=none; b=sN5GG+Pbt9eMGYLyQFaXM7FmPUskXmPi00z3ZER8Qaea3HrbRrN8tpMZTwwrai5BZKKuxIS2cwE7j9iJlZ71hcKf1sEiLdMd6QoI7fdFp7DEV+atbhabOAtRz2twj/+rPLG1pw3QJqX63xktec9BwLizCJWbr9Qwkr1mpK5sDI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762856078; c=relaxed/simple;
	bh=jPyVX32PNdKlPsIVzZFiWiNyVCvfmMR2pcROXq0ZUvs=;
	h=Content-Type:To:From:Date:Message-Id:Cc:Subject:Mime-Version:
	 In-Reply-To:References; b=HzTRZShfdG76xsanHGzb/T5TOd+xCut0KYxWfoSEurpOWV9o4qTyojqlJkMpr0xGAYZEEJ9isvuACjZ9Y/S80zeJqq1cOLE3lgyYj3nVEF1Km7PtbrNlcOGOlG9ulBJz9GCMT8smQdwrIjnEoWuWMuq839TeYpB0HDIiLT7ZBDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=fail smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=tZnf10uN; arc=none smtp.client-ip=118.26.132.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="tZnf10uN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1762856068;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Mk2NvXdhmW/ZG3o7XVavD3RsK8Qw1U9yYdZYzIdwkVk=;
 b=tZnf10uNZs2z8d5dg1/jstkMLp2gd2NPrQrOKOTUOisgwsCASwurGiWN/SqzggyjVSX1cj
 kDhNNvUArikNoOxHXKSbCCIBw/J056THKk5WAA0YI0W0C02+tzHuVInSFHSb5xk52l9MR+
 +440w9G3RZUo2T5UL3Y6Q26kH7sNokO85eQEayUnEn91/oZ3WkzuNGuExSYJRkgcCkb1FZ
 Rkj+IptozB3s5yUSXeMrLn8tXhHTgNm66tuJtiZNGokxpvZ0JALcIod/iR1r2GV7JyhxE7
 ur2msrRYa4Zmz+dyEykjfluURMVHhhIDRhay/EoCz5KIWFK14Ruz/1J9PxREnQ==
Received: from [192.168.1.104] ([39.182.0.168]) by smtp.feishu.cn with ESMTPS; Tue, 11 Nov 2025 18:14:26 +0800
Content-Type: text/plain; charset=UTF-8
Reply-To: yukuai@fnnas.com
To: "Christoph Hellwig" <hch@lst.de>
From: "Yu Kuai" <yukuai@fnnas.com>
Date: Tue, 11 Nov 2025 18:14:24 +0800
Message-Id: <c82cd0f1-f56e-445b-8d78-f55a0c3b2b4c@fnnas.com>
Cc: "Keith Busch" <kbusch@kernel.org>, 
	"Matthew Wilcox" <willy@infradead.org>, "Keith Busch" <kbusch@meta.com>, 
	<linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>, 
	<axboe@kernel.dk>, <yukuai@fnnas.com>
Subject: Re: [PATCHv5 1/2] block: accumulate memory segment gaps per bio
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20251111093903.GB14438@lst.de>
X-Lms-Return-Path: <lba+269130c83+73a52e+vger.kernel.org+yukuai@fnnas.com>
Content-Transfer-Encoding: quoted-printable
Organization: fnnas
User-Agent: Mozilla Thunderbird
References: <20251014150456.2219261-1-kbusch@meta.com> <20251014150456.2219261-2-kbusch@meta.com> <aRK67ahJn15u5OGC@casper.infradead.org> <aRLAqyRBY6k4pT2M@kbusch-mbp> <20251111071439.GA4240@lst.de> <024631dc-3c65-49a8-a97a-f9110fd00e9a@fnnas.com> <20251111093903.GB14438@lst.de>
X-Original-From: Yu Kuai <yukuai@fnnas.com>

Hi,

=E5=9C=A8 2025/11/11 17:39, Christoph Hellwig =E5=86=99=E9=81=93:
> On Tue, Nov 11, 2025 at 05:36:39PM +0800, Yu Kuai wrote:
>> This can be reproduced 100% with branch for-6.19/block now, just:
>>
>> blkdiscard /dev/md0
>>
>> Where discard IO will be split to different underlying disks and then
>> merge. And for discard bio, bio->bi_io_vec is NULL. So when discard
>> bio ends up to the merge path, bio->bi_io_vec will be dereferenced
>> unconditionally.
> Ah, so it's not a NULL req->bio but bio->bi_io_vec.
>
>> How about following simple fix:
>>
>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>> index 3ca6fbf8b787..31f460422fe3 100644
>> --- a/block/blk-merge.c
>> +++ b/block/blk-merge.c
>> @@ -740,6 +740,9 @@ u8 bio_seg_gap(struct request_queue *q, struct bio *=
prev, struct bio *next,
>>           gaps_bit =3D min_not_zero(gaps_bit, prev->bi_bvec_gap_bit);
>>           gaps_bit =3D min_not_zero(gaps_bit, next->bi_bvec_gap_bit);
>>
>> +       if (op_is_discard(prev->bi_opf) || op_is_discard(next->bi_opf))
>> +               return gaps_bit;
>> +
> I think the problem is how we even end up here?  The only merging
> for discard should be the special multi-segment merge.  So I think
> something higher up is messed up
>
At least from blk_try_merge(), blk_discard_mergable() do return false,
however, following checking passed and we end up to the back merge patch.

blk_try_merge
  if (blk_discard_mergable())
    // false due to max_discard_segments is 1
  else if (...)
   return ELEVATOR_BACK_MERGE

Perhaps are you suggesting to change this to:

  enum elv_merge blk_try_merge(struct request *rq, struct bio *bio)
  {
-       if (blk_discard_mergable(rq))
-               return ELEVATOR_DISCARD_MERGE;
-       else if (blk_rq_pos(rq) + blk_rq_sectors(rq) =3D=3D bio->bi_iter.bi=
_sector)
+       if (req_op(rq) =3D=3D REQ_OP_DISCARD) {
+               if (blk_discard_mergable((rq)))
+                       return ELEVATOR_DISCARD_MERGE;
+               return ELEVATOR_NO_MERGE;
+       }
+
+       if (blk_rq_pos(rq) + blk_rq_sectors(rq) =3D=3D bio->bi_iter.bi_sect=
or)
                 return ELEVATOR_BACK_MERGE;
-       else if (blk_rq_pos(rq) - bio_sectors(bio) =3D=3D bio->bi_iter.bi_s=
ector)
+       if (blk_rq_pos(rq) - bio_sectors(bio) =3D=3D bio->bi_iter.bi_sector=
)
                 return ELEVATOR_FRONT_MERGE;
         return ELEVATOR_NO_MERGE;
  }

And the same for other callers for blk_discard_mergable().

Thanks,
Kuai
