Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716267;
	b=TEQDVqahoI+cxxPABmWJWjJbtMBxrdigQXtv1TTeOskCoQxv93x8ghxBefZcQ4jyh2vV
	 tGBexMqTHkdEhDQNH+pObIo4fRc/fFElAeDLkY0eU0EdsTjQFJrZuhfpGDrAnUCKRB6dc
	 QuiGwZI5Nes20IHkyJFGETBF9jFLfBY/Sk+50zCIT5S7//sLw8OsBpo1MPZSKMaAc837i
	 nM7qAdhD8KO6rs+zo7gcRjkMM96lD7ubbR+rxVv9B80tnjQti7x4fIbyRmLvSZFsjSFgN
	 QTYAOBixjQHlUTYwXALT3crMXHMPd98igx1AJt3BR+RZ84sqWBTGiYJ4GQhwxT3uQ1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=+GXjmDSpdPKSM3dvXbu3WCZAHTmv+G6w0ssCMfJAnCM=;
	b=lyyIsy7sDT7CvyQxbFz1D8fwkyrFeJG9ejyXniLyCSfOx1bq7EHVPz+y2tGsTunRJV07
	 DJjr8hqjE+jZ7Y5Jo1R1/BzXy61pCs0QBqjB+KmbFnAPjtYHCITJ6BwwUO8wn6L/AfIHO
	 I0DPMtgZ7ybtA6KzBw/grUey1F+n9xtEO+rJbecNCEarC0vhf0lTwW4FALyfdSQKR57bC
	 XdFiuMAl04mIez9COZDbTNWJFy1UMbP2Jc3UciHuud8zZH2IcLwY+g4YueGCu8tu+xW8g
	 cBZflkUONJaj7E1EWVe2Q/gaWfsNxTYD1/xW90pEjqpyNQ/j9/iw1gBQKl/ZB/e/NVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JAL5xEbx;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC08C606A324
	for <linux-block@vger.kernel.org>; Tue,  3 Nov 2026 14:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC08C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JAL5xEbx
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1931ff67a29so8730432c88.1
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 06:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793716266; x=1794321066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+GXjmDSpdPKSM3dvXbu3WCZAHTmv+G6w0ssCMfJAnCM=;
        b=JAL5xEbxeRyI5iZfq2c75QvgWSvM8A+hwAkPoB5Ef0uYyHxKF51D+EkIcYAiVT42GW
         O8+rFQnzDXYUm2OXJlerdC3iicYR4aSaSaHH3Ep/VgS3dutNQteQPI38N9cTs923fA4D
         BIryhyqdfWTScigh6MyLKL1CJS2d6DQawQgkmWOyqgp69tkPhN8FiEZNW53On/G87OWp
         kqGTqlIrju9gHXn+A4kicd+uohnWUkqFnZgHPqVrRm/AudeUaSqo5Vxq/cHqmboyto3O
         deySONUwD/jokWH+7+DxV4OSMbR/tJKnNpueSZ3h16f9pmnrEaRKiRgNtstEGOao5RnI
         wqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716266; x=1794321066;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+GXjmDSpdPKSM3dvXbu3WCZAHTmv+G6w0ssCMfJAnCM=;
        b=gU0U6+iJ11x2GncXa5thtHyRMaCv3e3POd5CDU/zVf+bfVeh03DOuSGNhI2KqrIiWG
         KlTHnmWyy2umHcDfo3MaQBJaPQaHtlM3yKCM9k+tf5TmFGG0Ob0s4ArdhgAUT+kmtnW9
         qGySdDYE0rehiBsWQgv22ppa2fL4tZdNDO9uvf9uDqPMfgXnkO8K1pN0i10k6hThafsQ
         HqVF1YWPBY7LWPBCSn+RxQThS0BBSo0Pmc2LE7h5xjqYYIa+hTZpaRZLrhQbKwrgqEGm
         3rVeOT+pr2Ew1SR3LPLculKcXYTEp5SgCU9Xzj79V1l7dRgXyAN8vt8/JLbOBnwIH5eV
         UPOg==
X-Forwarded-Encrypted: i=1; AKwUvBy5lCcdT5XZ4brWg1bB6Q8Fu6MKCW9iZ5ReE+MbEF2WAD60+LsBNhPEwjM55Vf71huzKXrNBOEyw8btGQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/A7+rCn3L2syoteKQ3XktLEvz42vfuXoJTps2rVip0LBsI/f+B
	cwWPPUl5aMAjZIfL12vOQ7PWS4sIbhlUEVnQ6VuCs/YycuzKRU74rDi1aaxsD8QNQo8=
X-Gm-Gg: AYBFou2gSJW1v8Rz1hFhJN/cdH5ewdVgOWJxJegTjJ3p/Fnxq47h4Gauf29WsVifrIy
	Zj/u2jXjLJYVmtC5FDa4ZG25htwKq9VSppjU4zzYIIs3PjuVB8knRZL654j0DYTZQ4Q0kER46r5
	dmi1K/xTG2HDemNCfNgCui25RI5LL9o9qlAVr1SDNq59g7MfJXnPwnJgUeSE6GBAZd5VetLu30W
	V4CKW2FH3Zab1eA6Xicov9/ZiApFXTEmG3lM/Y6z869EJ7ce+T5P3ooZrwpu/54eTvnxpgHtr2V
	bnfClUqp5SbifOlo/oRxNh8a6GIQYwosZw9uRbilW+JEWUTfiai4LEE60+2KDCInm7S+YRhIqxk
	mDqB0zJzWLJKC2f4eEiMO1pmp673/BorF5kPS1TeNoGeUXU18rvdxHr9eCRq9sVjENP18beuMOA
	GljgESqFIV4+oE7op/KS+tLnWJI4ecz9sU+2gBTWL/hGiqubmLvbpaWLnj+gy+D3el7W8L968Ew
	V52nMXYzYl9yq4ceoDcFNYTHPUW2YFwRS80JuA7mHLShD6RQ2m/EYD4O8WgtoHYmlcUDJ1B7/8i
	xIJmWD2A+ZnPx6YVVJ2pH9BEggFnObCbZpmg846FIqI3CzbseRq7PcrgWQ+wzBSmcoceyFhF5oW
	gWrI24s0/yiTu
X-Received: by 2002:a05:7022:c88:b0:194:3a84:e67a with SMTP id a92af1059eb24-1ac5d0da7e6mr18645854c88.41.1793716265860;
        Tue, 03 Nov 2026 06:31:05 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b23b847348sm9534779c88.4.2026.11.03.06.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:31:05 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Eugenio Perez <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Ming Lei <ming.lei@redhat.com>, 
 Cong Zhang <cong.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261103-virtblk_sync_quiesce-v3-1-f40233f9bdd9@oss.qualcomm.com>
References: <20261103-virtblk_sync_quiesce-v3-1-f40233f9bdd9@oss.qualcomm.com>
Subject: Re: [PATCH RESEND v3] virtio_blk: use synchronous quiesce in
 virtblk_freeze_priv()
Message-Id: <179371626469.3691261.7199603294029974156.b4-ty@b4>
Date: Tue, 03 Nov 2026 07:31:04 -0700
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


On Tue, 03 Nov 2026 18:32:21 +0800, Cong Zhang wrote:
> blk_mq_run_work_fn() can call blk_mq_sched_dispatch_requests() through
> blk_mq_run_dispatch_ops(). The dispatcher checks QUEUE_FLAG_QUIESCED
> while the flag is clear. It can then be preempted before it gets a
> request. At that time, it has no queue usage reference, so
> blk_mq_freeze_queue() does not wait for it.
> 
> virtblk_freeze_priv() then calls blk_mq_quiesce_queue_nowait() and
> blk_mq_unfreeze_queue(). A new request can enter the queue. The old
> dispatcher can run again, use its old flag check, get the new request,
> and call virtio_queue_rq(). At the same time, virtblk_freeze_priv() can
> reset the device, delete the virtqueues, and free vblk->vqs. The old
> dispatcher can then use a deleted virtqueue or a NULL vblk->vqs, and the
> kernel can crash.
> 
> [...]

Applied, thanks!

[1/1] virtio_blk: use synchronous quiesce in virtblk_freeze_priv()
      commit: 6c6dec7883f8eb10b326bc9d109a4990c885d949

Best regards,
-- 
Jens Axboe



