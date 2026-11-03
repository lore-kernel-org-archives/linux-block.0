Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716290;
	b=RiwauLY1cVsDgYvL6tzALKQamSdQH+K+tGHlDxitzcB4POntEUMN8Jo93fWFPdrRNjGk
	 wbV5s/QxOFbrDEppyRNIn0CbLnZfTdHvKnpAIQIVHNWlBaXgih86SWEf7UAWOj3RMszYA
	 grvqCFXgvVyuKbY77yTZW08nGPD++wjXWdeJ1zOX/GSzcHS7272NodxxApMI3WDG5HHGv
	 tTuCllJBh/f04WN93LKE4OoK90WGx/ffbwQbyaWfe9JibIgf8dNVa3u3xfk12i1I8WsUh
	 +74x/m3tkaBDJjHb5N8qXCkDH03NlgFfWl8OUVLg0+ajBho9Iu/5tMx8KMdFvo3XN8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=lQP5UfoJGZ61K5R3SQuKiGS3++XV/5Fqa+MZBDFEMdI=;
	b=B2VyjOJaJwNMbITCoQa0qhdtJPELblsTWHWQLd8qc68FEoukQz0Y3eWUiH5vWl3UoMv9
	 jAO14Dar8MohOpDY+PUNsu0qUIRCVYvL1UAa2cWhfWIq6f/zRLp05lUl+hRTh+lkDYeTW
	 z5i3/5ompcjOqTFRTku9srNOL57bDRKUTtSsh3IQCwaaUqaXmLu503gr5gmivFNVVJhLI
	 uKTxOAaKAN4+7MToY3njv4A7e7nQAuylDcbzzS/s5Y2t1P96zfc+vSw6vNislPvKPPgyN
	 xvn/pOUR6hyrcgYSiFiAgPbZOyyGO+L8qIs+0AkggShh+tQ5IpmnzZ8FfvqS61iJ29g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="gKjJ/6Sv";
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674E56083638
	for <linux-block@vger.kernel.org>; Tue,  3 Nov 2026 14:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 674E56083638
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gKjJ/6Sv
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1ae58d17cd9so1141414c88.1
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 06:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793716289; x=1794321089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lQP5UfoJGZ61K5R3SQuKiGS3++XV/5Fqa+MZBDFEMdI=;
        b=gKjJ/6SvSISn5g6EFsgPui5YEYC/MbDN05MclZGEWTEgK+qxGLT2Pqzke2uXQS6c9U
         YfaHxiTLnY7Mm2g2eXYxsq+GmguraXytboIiKKpG2bDndyvwy/TGithPIDvxJSJG+G/g
         qGR9nIuGQxyGmxV6pT5DM0z8EndE4zDPoxsPKNQHUevSm/NmDC5FAzBIxehXWW1MICJP
         VkPwz9qSMV5dbjL6cWPjntuBAi8pRY0umW8vztqtlmNm6yxxkzOEyA05bn6l58XWzSmF
         ZHEi49EDPDY2thdsvCrCtfCf+SQshoj90f+9nAGDyx1BidsELgEhui/ume8n37Ga9duU
         H+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716289; x=1794321089;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lQP5UfoJGZ61K5R3SQuKiGS3++XV/5Fqa+MZBDFEMdI=;
        b=utklKCxKsU4KKXbVRrLW4vAvCWflLlrAbzSaHt5cL/3bgBBNDN3t2xNcdqq/NKOAcT
         FIRQJxm6S4KQy8OuafdV0+DvD6YxMbsCdL2yX61TSqDHVDR1yQ873R4E9PJdK8nJ/Vgc
         sxZHWW6pmSBgSa1Kl53Ubuibol1eEg5FSxWHgQDSzVcOExoRRUALivC5ZLPaqEuFinsa
         75bqLSUz3D4hNyF5rpNyQMTEkqbucD54syzU0cpm59ui8NDV1/6MrBbrUwOPIRkVSefJ
         fIQnPEIMQtDJKAiXdne9kHl2i1AIPAk3NShfnZLoa+R014ROINxXuC0ouyjfG2AjQrlt
         AGyQ==
X-Gm-Message-State: APuU4Z9JcoN3Md++eF7aXvOMlsDbWHpe24GpimHMZzmb2tVpB2fk+IgJ
	QeL8fn/7Jwa3tU9cypNfQ9eHpVJf+3EiCV6WDOofd3XgQm51gIIXTvyweDgtKqFGUjw=
X-Gm-Gg: AYBFou2sGPOdyLVgPbxZaMrA19AcJfB8kiC3rsn45ggdNkiYUmZgH03AzXUO0cf9wd5
	Mh0xh+1xtFnDj9O7kx72poJQY2DkbdP4feUtrThSMFSuFcmXLYjQ56VOIxdMmmihSPYGOQVmjdI
	J1Vdk8sD+tipBz7dcC7OdGEHUPrenglV+S3p+Lq2RkchlYHWG8DBTbaw/Tpa2jdhqNsfc4FPdUR
	zF0bLacOCyRS1wI8DKEl8zwAebLtZvN42IYRu1Lp7tVfB1ByAkdjFCbmI9EWhJmpj4g2N40GpAu
	+mUY+201E1aCDMJxOnCx5XbKSXMscZwfkG7lcbWRh1fr3URLcHsM2IL1/mKeS1ck4Ql8+CVU8RN
	+8+0yxV+wEgPOIEsrT5hLOS03pzkFQtEg//Jin/TWC7dXzbzHbzYrimJb9/WlkS1IaCyjgmtSKa
	HxuIiciMNR1dxnwZaToif6aMl1dDPHvMhGwG+pgNzcAH0hbVDKdjuizfpI1OSDwYHsEO+winI6j
	/JM8J5Y1XAiIhZZI0b4HHGCml0git78ERGmXlK+/0+jn4ZfRGRH+GA+3V/jUAZ83GEZrhly99ze
	5T9gViLDoeSJFwg6EDEdmZoJeyGyfLB1ypl9Pjqg4x7LrwS3q4WdkwZN+DWPx0n/oV08xHdKomI
	I/wuTDlinpfel
X-Received: by 2002:a05:7023:d0b:b0:144:e535:3ef6 with SMTP id a92af1059eb24-1ac5de53bbdmr21036321c88.41.1793716289438;
        Tue, 03 Nov 2026 06:31:29 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b23b847348sm9534779c88.4.2026.11.03.06.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:31:28 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, 
 Krystian Kaniewski <krystianmkaniewski@gmail.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>, 
 Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
 syzbot@lists.linux.dev, 
 syzbot+e90526cab23b9efcd03c@syzkaller.appspotmail.com
In-Reply-To: <20261014170538.1089448-1-krystianmkaniewski@gmail.com>
References: <20261014170538.1089448-1-krystianmkaniewski@gmail.com>
Subject: Re: [PATCH v2] blk-mq: fix out-of-bounds read in blk_mq_free_rqs
Message-Id: <179371628848.3691261.276757911523604089.b4-ty@b4>
Date: Tue, 03 Nov 2026 07:31:28 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 14 Oct 2026 19:05:36 +0200, Krystian Kaniewski wrote:
> A KASAN slab-out-of-bounds read can occur in blk_mq_free_rqs() when there
> is a mismatch between the number of hardware queues allocated for the IO
> scheduler (et->nr_hw_queues) and the number of hardware queues in the block
> tag set (set->nr_hw_queues).
> 
> This mismatch can happen if blk_mq_update_nr_hw_queues() fails halfway
> through (e.g., due to memory pressure during
> blk_mq_prealloc_tag_set_tags()). In this error path, the elevator is
> restored with a larger number of hardware queues than the block tag set
> actually has.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: fix out-of-bounds read in blk_mq_free_rqs
      commit: 894e4e6084924cfd590968d45fad20908e02ddae

Best regards,
-- 
Jens Axboe



