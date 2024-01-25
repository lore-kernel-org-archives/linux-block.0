Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2048C73166
	for <linux-block@vger.kernel.org>; Thu, 25 Jan 2024 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706196789; cv=none; b=cDneZ+WXEWfcc12kOOF+ElDhGBUK2n24KZLWViQK7ncvVJKdX75uik6/AaB2kfCQJp3WpLOCzd/a7RQTBPX7nqx+y0lRXEB8GsRfg91HRK1wCpHG6NYU2CEf6ECxcbYpv6k5wN6uXEXaCbKVf7XyVnIjPDJJvLtPZY7moQwTYyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706196789; c=relaxed/simple;
	bh=s5NTtDSXR8T9HdgsJfOs23zILbtqhIJcem+N3YvEIWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=prMQPNij1VQ5Sbh5g/66nEJX1dtFOLIKfiJRylGeLtAXQc5ZEuVG8tNRvfPtbO8ZT/gh39KhJiH5VUtYKdcnqXgARtVFLNnUxNgxMiLXy5OvqcBf4+DbOE6wnzHyTu3HaJ45koabS1sBB0UlnTDsUJuK+l6xwwi70H//Ei+Dwhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Aep4wssq; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Aep4wssq"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-361a8f20e22so629315ab.0
        for <linux-block@vger.kernel.org>; Thu, 25 Jan 2024 07:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706196785; x=1706801585; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fRlgrjNnbSZj8pV0gjcviWY4T1PIUGSkee+euAfm/PQ=;
        b=Aep4wssqKl2djmEQxqLRMXOb8G35kI016YAHD1+NxEXWv40AOJAxnlP5H4wfPwi0Wb
         7kG9wBgABZ2V0reoppnEMClkXYYPqV1lwMn2Vo8MpkfSTR5U4X2B2DlwZXwgwYrey4zY
         IGAP76ZxbFXtXsw/zPCt2RipPkYeTOsZ+M1UIcsArPYkxOWFiiNzQcJwXq6g1dtsfR72
         Snwc0oKzdtUsQNLHrtmP8bYwgMPdbVdaB6aFMOUOjKgaAHodZt3rwvBwWfHx83xoOV29
         0jnLgMwsUMXAu+rkizMwqCsGdRl6LSUZEcHiaTwI2SGUnGcoPkVAnJW/oT4WsRUqH0fa
         tcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706196785; x=1706801585;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fRlgrjNnbSZj8pV0gjcviWY4T1PIUGSkee+euAfm/PQ=;
        b=ltIcXroSqPTo26uKEErkAv41Ixdrs3zGMgYWETZHe/sUsBuIfVw1Sp787a/lxgspt6
         sr83j9CUZLkdAttZLNWDbCCB4EBjADrtw1oe/pzFSajNj61i95zxiOxVVEzbaNChgJAE
         qmskWkp/oTr46JNVKs0cQfaHo4kyzoSSK03r3g56JtoCdon3QqlPF1MvkB0K5WR6T5sc
         rIioYF4ScdOPbjRYqKlYaR7Y/Poza7gU4Hha98cxTBWICYmJYy2fHdbQ+AoAymGAzJwM
         3iqgQlDgTXvA9PBmv9GSpmK5XeW4SP5O3Wst5SkCKFP5XtyR0xMTWK+K4MlsCZnknjYU
         bfhg==
X-Gm-Message-State: AOJu0YzeUmggrCst+2OGo+cmBsnR+slNCeCMVYTL9O23yNMdS5K8etfs
	oy0xATVNbeGU9O3Z6bT2PvqGmCWAoquJnfYG+O7cXqNQ/w7+EYQGzwlv8r3TK7g=
X-Google-Smtp-Source: AGHT+IEPDP4wlMUesm3T6swHGmmcjQRDschl7iPCjHlqz6YnohGuMWD6YQvhySNTMCgUMUqtlAouVw==
X-Received: by 2002:a92:cd83:0:b0:361:9667:9390 with SMTP id r3-20020a92cd83000000b0036196679390mr2591825ilb.1.1706196785198;
        Thu, 25 Jan 2024 07:33:05 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y18-20020a056e020f5200b00361a70e112asm4860771ilj.59.2024.01.25.07.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 07:33:04 -0800 (PST)
Message-ID: <1872ae0a-6ba6-45f5-9f3d-8451ce06eb14@kernel.dk>
Date: Thu, 25 Jan 2024 08:33:03 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Report] requests are submitted to hardware in reverse order from
 nvme/virtio-blk queue_rqs()
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org
References: <ZbD7ups50ryrlJ/G@fedora>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZbD7ups50ryrlJ/G@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/24 4:59 AM, Ming Lei wrote:
> Hello,
> 
> Requests are added to plug list in reverse order, and both virtio-blk
> and nvme retrieves request from plug list in order, so finally requests
> are submitted to hardware in reverse order via nvme_queue_rqs() or
> virtio_queue_rqs, see:
> 
> 	io_uring       submit_bio  vdb      6302096     4096
> 	io_uring       submit_bio  vdb     12235072     4096
> 	io_uring       submit_bio  vdb      7682280     4096
> 	io_uring       submit_bio  vdb     11912464     4096
> 	io_uring virtio_queue_rqs  vdb     11912464     4096
> 	io_uring virtio_queue_rqs  vdb      7682280     4096
> 	io_uring virtio_queue_rqs  vdb     12235072     4096
> 	io_uring virtio_queue_rqs  vdb      6302096     4096
> 
> 
> May this reorder be one problem for virtio-blk and nvme-pci?

This is known and has been the case for a while, that requests inside
the plug list are added to the front and we dispatch in list order
(hence getting them reversed). Not aware of any performance issues
related to that, though I have had someone being surprised by it.

It'd be trivial to just reverse the list before queue_rqs or direct
dispatch, and probably not at a huge cost as the lists will be pretty
short. See below. Or we could change the plug list to be doubly linked,
which would (I'm guessing...) likely be a higher cost. But unless this
is an actual issue, I propose we just leave it alone.


diff --git a/block/blk-mq.c b/block/blk-mq.c
index aa87fcfda1ec..ecfba42157ee 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2697,6 +2697,21 @@ static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 	return __blk_mq_issue_directly(hctx, rq, last);
 }
 
+static struct request *blk_plug_reverse_order(struct blk_plug *plug)
+{
+	struct request *rq = plug->mq_list, *new_head = NULL;
+
+	while (rq) {
+		struct request *tmp = rq;
+
+		rq = rq->rq_next;
+		tmp->rq_next = new_head;
+		new_head = tmp;
+	}
+
+	return new_head;
+}
+
 static void blk_mq_plug_issue_direct(struct blk_plug *plug)
 {
 	struct blk_mq_hw_ctx *hctx = NULL;
@@ -2704,6 +2719,7 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug)
 	int queued = 0;
 	blk_status_t ret = BLK_STS_OK;
 
+	plug->mq_list = blk_plug_reverse_order(plug);
 	while ((rq = rq_list_pop(&plug->mq_list))) {
 		bool last = rq_list_empty(plug->mq_list);
 
@@ -2741,6 +2757,7 @@ static void __blk_mq_flush_plug_list(struct request_queue *q,
 {
 	if (blk_queue_quiesced(q))
 		return;
+	plug->mq_list = blk_plug_reverse_order(plug);
 	q->mq_ops->queue_rqs(&plug->mq_list);
 }
 

-- 
Jens Axboe

