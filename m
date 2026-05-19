Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D2126A0D5
	for <linux-block@vger.kernel.org>; Tue, 19 May 2026 11:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779190146; cv=none; b=eeUGmFiVrhBZoacKAEvk5wp6qcsfSbEcZz9m2JW9wG8iSt7RcLI95b+Yp11SEDDxnFBsXU1Q7fDyHsDLShAY0kOOw+XXj9WMz0HRlwlk1lmt9wRLOKQ+rkg2VYH7Mpprs4Gs39H+269+GaL7scuyz8/yRWmoCepHVlKUtjrm+P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779190146; c=relaxed/simple;
	bh=szo2VVDxR9awOEL/+X182mFYbjmEhAJ/MspfhKVa/3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmwUE9mexUBfNHWxp19TE9XzSnAf1fsQjWjvJDgMODeclJirzy1fNyuZVPWmnUBXjPB738JFvIQy6Fne9v1gFQzhIagw+cZLviU7TuGyXxJY8XDsRmXP80jJXkRXwzuXAByQb4yBXGteyTUihmVbYpG0+pC28f5Dh5k2GZQkyKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlUvSxdo; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlUvSxdo"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-479ef2b7979so2641962b6e.3
        for <linux-block@vger.kernel.org>; Tue, 19 May 2026 04:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779190143; x=1779794943; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QSDvgGmb6zPH7zSSup9Opz0c2vS1ZlQJf1syzf4z968=;
        b=KlUvSxdoijGpdTCeGAymxdZtJDreqRkSYTSwq5ZtF3Mj/d7OL2IznxQ5vfu1FcmBFh
         3Byh2plqf1kjssjOk5XZ+Fwp2qmilerBFmzUegxOQ562QjI7Ur/umkyYwPsm0SU1zXWw
         V/O1jUo0vwewSS2yy02Xmiju0Qbd3Mh6/eBOgG6SZ8rv23ZJu72EE9q3Qve0THgdHU7j
         61iutM3djs1COoXJqoYQoCQxEhq9Bi3iRHnEkoVLRNTcBw2h2P3eTKB7gbGZBKVf9Qfz
         sVaszWdpd1u4fuXvi84yMypolL1tMF3iRsv6+fzEZD3V9W4AABqoMDWDGEdxb18//cUa
         1SJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779190143; x=1779794943;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QSDvgGmb6zPH7zSSup9Opz0c2vS1ZlQJf1syzf4z968=;
        b=i+2PBaMR+KpdPCsYeKMaOCm3ku6rYh4CDzNFEkaqoVBBLYfKpB58c/jeXGwVW+ttqI
         k6sUtpk/JQqymVExn75T32CvK4XMWOVr/Mht6bwNAnTmQ++5YQd+RkMy+UG/hRuxIaPw
         x15P065Kmlz4wVgzTcWRqw2qp0DhnOmnRpwRef3no/j+npZitwvV/p2ISSacuO2FvQRa
         vCc8piNHMGRpUm4kelzWYkSCMmabdcF+l6cRwjwyLB2EjIdn14Da5QTAn4xRC8ADVIeN
         ngJj0QqYCOdLEUG3L3M7yAyyof8X2OW6A3qB/koxUj+c1jxGc8Iumt23/oOPluok6MHf
         MZNQ==
X-Forwarded-Encrypted: i=1; AFNElJ8+qk8LiUFz/0zuTypRwVAietCTzwAJfNFwPA1cWENOkSDvbeP3+FTpkpPGe0skDnhxLaW4tyw08+vnBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYK7ir0+owH+phjhbp+kKXDSlShp4H444G328rDItnhM/k8rdi
	6B4Dfc25D1Icfma688cobCN4Cxp/jwk19B/gfTU5PT82VwF6+e22k+pw
X-Gm-Gg: Acq92OHMQAMmqjt8zPIOfELHQmea4Xt0jAu/KgF8PINHSw4rNC+uD8xpCuRUZ2jGVep
	xFh9Dfnj0cNwT1hErTwbAkWiS/IljXQH/ijVWmj8KgWtN5pdtSjL25iI9HabiljH7cdFw4f3APl
	w3mOXrDFkpe3eCH5AlY/I8KcBioFMt1f1QrfmldC4bBO5483bLRw641zBk8affY2kF5bu+9Fi4R
	0CgOOLZ13Qcs7TQWuIsHO5vpUSl54FqM5TdDS0AoEmmlMxDsqalwb+IGQud8CK9mhTxS3CbTnkk
	7EMV/8tSD3XdAACUxDq8gFOnnBdnafkQ2s+kmopH1tecHLstTiFlGtm4GEGURJuo/jhfghOx2AO
	yjC46/SIj87jjeL1Mvnb9pBaAHgfMNwUl5NbZr+5QPPrSHpSLI7gTIN5Rcvq4rw8fVUWGJZvLXq
	vIfB3C5N4tHFbWvZ2Hi1bGTQRCn/nOeyIr+6woIOJrQo88Ei8/j0xvwQ083MCCmu9UO1bzrAVzp
	qGcRIKMOUu9tLskUCi8
X-Received: by 2002:a05:6808:c291:b0:467:70eb:36ae with SMTP id 5614622812f47-482e57c78c0mr12490521b6e.29.1779190142634;
        Tue, 19 May 2026 04:29:02 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-482ee0999f3sm6376418b6e.0.2026.05.19.04.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 04:29:02 -0700 (PDT)
Date: Tue, 19 May 2026 19:28:53 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Hongling Zeng <zhongling0719@126.com>
Cc: Hongling Zeng <zenghongling@kylinos.cn>, axboe@kernel.dk,
	ming.lei@canonical.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH] block/loop: Fix NULL pointer dereference in lo_rw_aio()
Message-ID: <agxJdUf1b0JSDAux@fedora>
References: <20260519040103.22776-1-zenghongling@kylinos.cn>
 <agvqK_4EelxnXUvf@fedora>
 <6A0BFDE2.5000808@126.com>
 <agwgbZmZiwzZe4-D@fedora>
 <6A0C29F6.5080704@126.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6A0C29F6.5080704@126.com>

On Tue, May 19, 2026 at 05:14:30PM +0800, Hongling Zeng wrote:
>   Hi Ming,
> 
> Tetsuo’s syzkaller trace confirms the root cause:
> 
> Timeline:
>   T6142: lo_rw_aio(loop3) starting read with raw_refcnt=0x0, refcnt=1
>   T44:   lo_rw_aio(loop3) starting read with raw_refcnt=0x0, refcnt=1
>   T6148: __loop_clr_fd(loop3) clearing lo_backing_file with raw_refcnt=0x0,
> refcnt=1
>   T180:  lo_rw_aio(loop3) starting write with NULL file (already cleared?)
>   T180:   CRASH - null-ptr-deref

IO could be from writeback or early close, so the following patch should help:

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0000913f7efc..24654a03db71 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1118,6 +1118,8 @@ static void __loop_clr_fd(struct loop_device *lo)
 	struct file *filp;
 	gfp_t gfp = lo->old_gfp_mask;
 
+	drain_workqueue(lo->workqueue);
+
 	spin_lock_irq(&lo->lo_lock);
 	filp = lo->lo_backing_file;
 	lo->lo_backing_file = NULL;
@@ -1857,9 +1859,6 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	blk_mq_start_request(rq);
 
-	if (data_race(READ_ONCE(lo->lo_state)) != Lo_bound)
-		return BLK_STS_IOERR;
-
 	switch (req_op(rq)) {
 	case REQ_OP_FLUSH:
 	case REQ_OP_DISCARD:
@@ -1901,6 +1900,11 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
 	int ret = 0;
 	struct mem_cgroup *old_memcg = NULL;
 
+	if (data_race(READ_ONCE(lo->lo_state)) != Lo_bound) {
+		ret = -EIO;
+		goto failed;
+	}
+
 	if (write && (lo->lo_flags & LO_FLAGS_READ_ONLY)) {
 		ret = -EIO;
 		goto failed;

> 
> Key anomaly: |raw_refcnt=0|while |refcnt=1|.
> This means |__loop_clr_fd()|runs while I/O is still active.
> Regression introduced by:
> 6050fa4c84cc ("loop: don't hold lo_mutex during __loop_clr_fd()")

Why do you conclude it is caused by above commit?


Thanks,
Ming
