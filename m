Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B573C1998;
	Fri, 31 Jul 2026 08:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785486256; cv=none; b=TlbImwy7X8BpSUAX6Opr3yN5q76zcU5VD0XaiWN5X2XAbv3lik/d7HQWG1YBkaibu2GNLvCSgun6KL0pbgIGqd9f/xNqCa+yI/rvsiUMtcA3P+pZSxXcLZNobuo1NJraw1nhOhVSb3cMb90Fsw+NxJTlSKwibTzbQSezHlV/3ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785486256; c=relaxed/simple;
	bh=rluc8i/Zl9lCBStyuXlWmXrybrCA2JmGlbdo5xZOZoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o4JvUx3b9rTKZ7BTXON+ZSv+m6wUBbCRQJGVF+yyXDB9hz4B0LtqJ0Yjuoo7eMuPD3jPOjVQ0P/ZYkhWpfuNMADPFJCLs0jHOZ4c2R0b5NgdypJiI2433hKqIJUlk2DvmqlO4yrVIUFq1HUhy8OWU4i+s3NNHNGZlAaGwUb1jNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2f68db128cb911f1aa26b74ffac11d73-20260731
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:06d64418-1188-4c0e-9c3b-97a842079762,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:56855669f31567fae26ca31122dd314a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|136|865|898,TC:nil,Conte
	nt:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2f68db128cb911f1aa26b74ffac11d73-20260731
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 458950696; Fri, 31 Jul 2026 16:24:01 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: mst@redhat.com
Cc: linux-block@vger.kernel.org, virtualization@lists.linux.dev, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, axboe@kernel.dk, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: Re: [PATCH v1 2/2] virtio-blk: mark disk dead on ERS permanent failure
Date: Fri, 31 Jul 2026 11:29:00 +0800
Message-ID: <reply-virtio-blk-ers-mst.20260731.112900.liuxixin@kylinos.cn>
In-Reply-To: <20260730190926-mutt-send-email-mst@kernel.org>
References: <cover.virtio-blk-ers-v1.1780449274.git.liuxixin@kylinos.cn> <4740ae91d5be.1780449274.git.liuxixin@kylinos.cn> <20260730190926-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py

Hi,

On Thu, 30 Jul 2026, Michael S. Tsirkin wrote:
> Can you tell me was this written with use of AI? I ask because not many
> people go out of their way to put in unicode dashes. Next step is what
> emojis? Let's not go there pls.
> And if yes pls disclose that as per Documentation.

Yes. I will add Assisted-by for the LLM help in v2.

> Do we need this? virtqueue add will fail anyway.

For a broken vq, yes, virtqueue_add already fails. The useful part is
the !vblk->vqs check: after reset_prepare/freeze_priv the vqs pointer
can be NULL, and virtio_queue_rq would deref it before add. v2 drops
disk_live() and keeps only the NULL guards.

> why not break first?

Agreed. v2 calls virtio_break_device() before flush_work().

Thanks,
Xixin

