Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFFB3E44EF;
	Mon, 27 Jul 2026 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785148642; cv=none; b=ICqRD2MyaAp3dHDSf9OhZVlE9H2ZW0BGRtHyOmmMscSKdJrkVcOY3MxYfvoJyUSLTJiawaoZnK9ajDfsDC90XtZUxWX1v5/KGxcbMVEYTI80U0TfMi9KHfzBSHkvCQAbDriUwAUH0GdPU+PBvq8DH2ipNjMFj2QB6jQHXNx04JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785148642; c=relaxed/simple;
	bh=PfKqu2R7oO5a1NehM05V2fnlMnef4AVqzXwMk4A4toE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dkl3rBFtnFaGGJKYCnfbbNQ0G+lADXNpz95UKvzNfg0+IuetwnuKLlJncLv200CT0IkXZ0iB30PYoapyysq9TItqGCwA/7/phcFHaxLD6o05T5A9NhStu2xnkyfid8lRuXdpxd95Na3T7djtaVSt+vAwk7FBX5EeDjivK2ALBd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1c20e8b689a711f1aa26b74ffac11d73-20260727
X-CID-CACHE: Type:Local,Time:202607271743+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:0627ccfa-a07d-4f9a-943f-10d877152789,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:e5c1714c7d1e9842402734d9955606ef,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0
	|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1c20e8b689a711f1aa26b74ffac11d73-20260727
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 681009878; Mon, 27 Jul 2026 18:37:04 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: bvanassche@acm.org
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: Re: [PATCH v1] block/mq-deadline: hold elevator_lock in debugfs next_rq show
Date: Mon, 27 Jul 2026 18:25:00 +0800
Message-ID: <reply-mq-deadline-next-rq-af98cabf-followup.20260727.182500.liuxixin@kylinos.cn>
In-Reply-To: <reply-mq-deadline-next-rq-af98cabf.20260727.174500.liuxixin@kylinos.cn>
References: <2e689b2c4021.1784615432.git.liuxixin@kylinos.cn> <af98cabf-89a6-41b0-9929-ec3e24783503@acm.org> <reply-mq-deadline-next-rq-af98cabf.20260727.174500.liuxixin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py

Hi Bart,

To add to my previous reply:

This part needs dd->lock, for example:

	per_prio = &dd->per_prio[prio];
	rq = deadline_from_pos(...);

because both the per-priority state selection and the subsequent
deadline_from_pos() walk access mq-deadline internal state that is
protected by dd->lock.

Separately, q->elevator_lock is still needed earlier to stabilize
q->elevator and obtain e->elevator_data safely during an elevator
switch.

Thanks,
Xixin

