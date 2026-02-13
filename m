Received: from sg-1-12.ptr.blmpb.com (sg-1-12.ptr.blmpb.com [118.26.132.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D46F24677B
	for <linux-block@vger.kernel.org>; Fri, 13 Feb 2026 05:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770961218; cv=none; b=dZiPba6yujf3w4g2oYd6wO27xNDOnCKcLnBjMydFxOTkUr6MC0x7VnWR1v7z/1GRX6638X/odH35BtUpbvx8eGGKLvz9FY50dnpiYXowxaOB5AwJla5RWcWcEpt9g2xuJ3UovDwdplT15SOoBrDb2+cP0aAExzNob1WQAY/ITcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770961218; c=relaxed/simple;
	bh=+6lsmNm9wphqJ24y8FQPYzZCLpAxsG55lgs1zXhsbm4=;
	h=To:Subject:Mime-Version:References:Cc:Message-Id:In-Reply-To:
	 Content-Type:From:Date; b=E3BMEYkOK8tJBy/MrsEO2/FGB1U7x4PS/iZ9zuG0ol4EdGuYT78Khk/U3HWZ+ipzriuFjR0dTrD/OlTCezY1VXVarEaSShwGrd24CQAlRWIYRexIPsv2jZf/dCofbIGk9XwKYDBBVhzVtp19hNCqSzjs2P7QvrQ/aEQn3ocXgWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=ZS4LpFHw; arc=none smtp.client-ip=118.26.132.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="ZS4LpFHw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1770961203;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=+6lsmNm9wphqJ24y8FQPYzZCLpAxsG55lgs1zXhsbm4=;
 b=ZS4LpFHwroAqFIlbJGjBgR3llpP+yjrqNSmCOq+jepj+yCyLzmC9L8DESZ1QC7Da71xH2m
 Q/JS6fZPu80FT+eXq7P9vTmkpKzFVPvd2znA+hJpBVj7m/G9aeI2+cxHXh6IGKOthxI9wB
 XCntRxu63sY1nHnvCQ2LZ8XlXIIgA21MTHN8yzqzfSJMBAzl9xqYoiW+gtk5PkrYeV70DN
 VglZYPHta1EXhZBPVoCO5xmwm0fvzXG4PTWdjQIOpSZVRwTnIcuXgX2IHkeNr+hqeX6UWx
 Xeo4uBzkqD9erwMowC7OZ3YIWZfKk1jPK/XChQdKd+edulpbu1qNn/JPCuisjQ==
Reply-To: yukuai@fnnas.com
To: "Ming Lei" <ming.lei@redhat.com>
Subject: Re: [PATCH] blk-mq: use NOIO context to prevent deadlock during debugfs creation
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [192.168.1.104] ([39.182.0.132]) by smtp.feishu.cn with ESMTPS; Fri, 13 Feb 2026 13:40:00 +0800
References: <20260212080135.1673063-1-yukuai@fnnas.com> <aY6sDstii_R_zOfs@fedora>
Cc: "Jens Axboe" <axboe@kernel.dk>, <nilay@linux.ibm.com>, <hch@lst.de>, 
	"Steven Rostedt" <rostedt@goodmis.org>, 
	"Masami Hiramatsu" <mhiramat@kernel.org>, 
	"Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, 
	"Yi Zhang" <yi.zhang@redhat.com>, 
	"Shinichiro Kawasaki" <shinichiro.kawasaki@wdc.com>, 
	"Keith Busch" <kbusch@kernel.org>, "Sagi Grimberg" <sagi@grimberg.me>, 
	<linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>, 
	<linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<yukuai@fnnas.com>
Content-Transfer-Encoding: quoted-printable
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Message-Id: <5c47b46d-1aa7-4ce6-baa8-97f8a3ecc327@fnnas.com>
In-Reply-To: <aY6sDstii_R_zOfs@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
From: "Yu Kuai" <yukuai@fnnas.com>
Date: Fri, 13 Feb 2026 13:39:58 +0800
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+2698eb931+566ba2+vger.kernel.org+yukuai@fnnas.com>

Hi,

=E5=9C=A8 2026/2/13 12:43, Ming Lei =E5=86=99=E9=81=93:
> On Thu, Feb 12, 2026 at 04:01:35PM +0800, Yu Kuai wrote:
>> Creating debugfs entries can trigger fs reclaim, which can enter back
>> into the block layer request_queue. This can cause deadlock if the
>> queue is frozen.
>>
>> Previously, a WARN_ON_ONCE check was used in debugfs_create_files()
>> to detect this condition, but it was racy since the queue can be frozen
>> from another context at any time.
> debugfs lock doesn't depend on queue freeze, so the implied deadlock isn'=
t
> obvious.
>
> Can you explain a bit why freeze from another context may cause dead lock=
?

It's probably fine to freeze from another context concurrently, I mean the
checking will cause the false warning like:

Re: [bug report] WARNING: block/blk-mq-debugfs.c:620 at=20
debugfs_create_files.isra.0+0x54/0x60, CPU#220: kworker/u1036:7/70421 -=20
Shinichiro Kawasaki <https://lore.kernel.org/all/aYWQR7CtYdk3K39g@shinmob/>

So checking itself is racy and should be removed, meanwhile there are two o=
ptions:

1) use noio for debugfs creation;
2) move debugfs creation out of queue frozen from nvme target;

BTW, I added the blk_queue_enter/exit() protection for 2 because I think it=
's
safe, and can prevent deadlock if there are any implied deadlock related to
queue frozen.

>
>
> Thanks,
> Ming
>
>
--=20
Thansk,
Kuai
