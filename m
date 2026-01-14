Received: from va-2-39.ptr.blmpb.com (va-2-39.ptr.blmpb.com [209.127.231.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66322FF160
	for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 17:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411445; cv=none; b=T2wn3SXiH/qN/xZgkZLCqdp1qbjs9pjRT4YC+K5UELhItgKsbfVUzn/D18+xo7ACLbT3kKhE5dPUva/5HFuxEeVHQ0DuoqVn5Uh0IEpmTe7hN6oTEBIztN8tEo5phmZE1LoWbj6ua/46e4OtI4cydR+YgoKMUVAWyl6aJBQ3B10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411445; c=relaxed/simple;
	bh=hxmiHVCcKE3/Yocna+eDPqZ+73wncyP6BILnrvmtXV0=;
	h=From:Mime-Version:Date:References:To:Subject:Message-Id:
	 Content-Type:In-Reply-To; b=YTR5+6rbwZiGc42rnFndN6lZxAIfi/sKTKPUpsb9QIST4nmMea7A33/Bq4v/OXpyA6k59rGSrKzGiJC9SCUr8qkUeT6Lly/ROmn7t9AjYPrbPH7l9F7B3Tk0r0TVphzcibgD8mAx+PZMtUPkUhVYBweZRT03cMcS2ZSHop1wZnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=MCgnMKpD; arc=none smtp.client-ip=209.127.231.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="MCgnMKpD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1768411394;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=/CnDTCJeP7SqyefY7N1x7ZhXQVr6kPeznOAU4W+bA78=;
 b=MCgnMKpDNJhzEOlzF9Hte7PweY+U69GgFfUudZPmJ8MjVWeCw2L8hlWVUpqonzaos73Vf5
 px48qA7QfdESlJR3GNI96YEhRwAkupo0EQXhmIBiBU2zc8ZIL7+PKmt18mlFAcyqO0gm4f
 2FvmELjqrAOD9ivl9c4WwzOFD55Ywe/wEfWPifV1fKIZjVaMkhHYOV+3+pqF7k2d29nMwS
 SKU3IJjLBL1yjbAR3LIAXoQmRunwnzgqUrskVcy2xPPvDx4xUfS6gt5ngQofnusyLvNUoz
 yw2SJeEyhFOWm2I9hUWs1xif7kIBquxWB2YULjk8O6J6/0sns4m7v7sPcUoahQ==
From: "Yu Kuai" <yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [192.168.1.104] ([39.182.0.185]) by smtp.feishu.cn with ESMTPS; Thu, 15 Jan 2026 01:23:12 +0800
X-Original-From: Yu Kuai <yukuai@fnnas.com>
User-Agent: Mozilla Thunderbird
Reply-To: yukuai@fnnas.com
Date: Thu, 15 Jan 2026 01:23:10 +0800
References: <20260109065230.653281-1-yukuai@fnnas.com> <20260109065230.653281-3-yukuai@fnnas.com> <b6110ffc-f999-49a1-8a7e-ce51af51e211@suse.de> <25dc9258-30af-4132-bd38-ba055ed61005@fnnas.com>
To: "Hannes Reinecke" <hare@suse.de>, <axboe@kernel.dk>, 
	<linux-block@vger.kernel.org>, <tj@kernel.org>, <nilay@linux.ibm.com>, 
	<ming.lei@redhat.com>, <yukuai@fnnas.com>
Subject: Re: [PATCH v8 2/8] blk-wbt: fix possible deadlock to nest pcpu_alloc_mutex under q_usage_counter
Message-Id: <03ab5e68-1977-4938-ac03-e36f53a87149@fnnas.com>
X-Lms-Return-Path: <lba+26967d101+6f358b+vger.kernel.org+yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <25dc9258-30af-4132-bd38-ba055ed61005@fnnas.com>
Content-Language: en-US

Hi,

=E5=9C=A8 2026/1/12 17:16, Yu Kuai =E5=86=99=E9=81=93:
>>  =C2=A0 =C2=A0 int wbt_set_lat(struct gendisk *disk, s64 val)
>>  =C2=A0 {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct request_queue *q =3D disk->queue;
>> +=C2=A0=C2=A0=C2=A0 struct rq_qos *rqos =3D wbt_rq_qos(q);
>> +=C2=A0=C2=A0=C2=A0 struct rq_wb *rwb =3D NULL;
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int memflags;
>> -=C2=A0=C2=A0=C2=A0 struct rq_qos *rqos;
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>  =C2=A0 +=C2=A0=C2=A0=C2=A0 if (!rqos) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rwb =3D wbt_alloc();
> Similar here...

Just checked, looks like something is wrong while you were reviewing this
patch, the same context wbt_set_lat() shows twice in your reply.

For now, I won't send a new version, otherwise please let me know.

--=20
Thansk,
Kuai
