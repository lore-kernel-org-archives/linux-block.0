Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA0533F8D3
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 09:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763716356; cv=none; b=iear31Tz2rdrZP6GckpkRt49G/R3c1YwCikTFtne05cOK/IZDFsY4FG6iZpIs980zJcAg/ZOiXpETbufgjvDDvt70BoT+h7LArPwDMw9K0x/6xHOtrZkZis8qd19IAOTp7kcMPY5OCWKgeOZPx9SzKCuJQYWwNPe6cabnKZulTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763716356; c=relaxed/simple;
	bh=Jo3M4ay1AiTsk2kb6xW9KE9WweRmR84KuA2gn36urc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOqCZdSEBYPJ1R8AJFcxYFghTyjd/MPlgDje7CK1p+BQEWhrv+QtaIi9BtCEyd5AtgHoSY/n7Rm+Bvkijed/pqNZ51PES+CUuFBKoJzVN5h1MLj08TnPvJSfaxGB0eFZqVGYMAK0NOOzS2tzRIDadSblYxGSyqOTqWupAx/+2X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=laAHrBLP; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="laAHrBLP"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29853ec5b8cso22081525ad.3
        for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 01:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763716354; x=1764321154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z4zf6ptP2u/y60bczc9eahlu7kJvy9Vu9mf0rKKvyiU=;
        b=laAHrBLPvtPrIBmtUDz5F1EOHbwfYADgW63KOkqdN6xZUnxgTYcXO1JkYQzs3+XlxY
         SNRGgwXySc3MNBJ9WdyOXw67eFEmb+Gq3qVI9WQ7uQ0SFRYSmRYgpq0Sx7smiuHrL/D2
         4zvA5VlC/XOrODJ588o2KMUy/rM9L4vhI5tTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763716354; x=1764321154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4zf6ptP2u/y60bczc9eahlu7kJvy9Vu9mf0rKKvyiU=;
        b=jOaNS+5/TfdmDWvBSg2ZLSWyVy/Tu46Y/jYj82KE/uwPmcBCJ3XzJYK378AiYW/qC+
         W+UpETzrA5Y9u3sVBuyKJOqMpNqCbzUIjQqD8ybj0bprTWNo0IHZHS4bd4lW/qR78twI
         siahp5o46ugE6cG5qyXTAZZhOmMYi4aYFKMIJfi23uU/nTId9QzevtMSXY6ra3uMdG8w
         2/zm84ioG5TlFNxUwJ+c0NK0Zk8bqDaiXSE0Bo9ro53OwRQ+K0sPHSSoIdcD4ovBAVYM
         hIofv1OIw6+xdwdDNjY8ziDhIDPToF7fFuB+aIajGjVWfCaD1PcQGYaQpLMJuf9CeewM
         Myfw==
X-Forwarded-Encrypted: i=1; AJvYcCV+iw07XB4LQ0n7g5LyyfIfH8BMvXfz35GCAdqXoIjcZers8d1c/8k6dx+A5R8ViYogyRny6CusJbu1iQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCZWGgBLF8dOSWIZ18iAk5nPqaV5+LwPuzDvkn8SWWL7TvMYWW
	savpkgyjS/czI/gaX9sOjkKdy9V5cp1Bn5a3MVq8AODX3V7vP7o5PnwrG1rIIhAjig==
X-Gm-Gg: ASbGncuw/HAoI4L79y/hzs3qCAZp7wVZ5bUFYNbJsghmCHZBV5NOe2HXzDLH/iL99W1
	vNDUg0BVgIzP28z3TDqofSiG5zwuv+P+0JWlyf4Y2+A7BkOQZjCzMtpp2XkOtU3llpHcPKDZBCu
	WzrOaRUsibnAriPGQ7eKgnBTscu3tDtXeP9X3PprTLuSiqQaqfay5X9sbeQrnroWdWBsL3obVvw
	xBGSJ5FloipQ7HiEsS2+f4ZFcqpFRgMa/REnvSB/Qmd+plWkkQzsi9h1LIl7QwrqTjV3THV5XRA
	lO9gkrtAyXF8Ua1rURgYsV/xg4RFJ00X5XT+gou4xFpCaZbL9jIDhRtczfJSxCix1kd5panKeTN
	avgNIpPti4an1Q+1Ntmf4ELAAtXNqlBUmSo8W24CG7VMkWv0nWomo+54/EuVCIKZ3N/a3dDnfu4
	oPysACtqA9kfHplg==
X-Google-Smtp-Source: AGHT+IFs3GjIKTMQOEoJ9Sy3yvpDbt7PH4w4q+KYrUz89IL7wlZXpaEcscd2uXhqfdnu4g//o6iAIQ==
X-Received: by 2002:a17:902:ccd2:b0:296:3f23:b939 with SMTP id d9443c01a7336-29b6c6a7bfdmr23438605ad.42.1763716354046;
        Fri, 21 Nov 2025 01:12:34 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:b321:53f:aff8:76e2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b1077e9sm51510095ad.15.2025.11.21.01.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 01:12:33 -0800 (PST)
Date: Fri, 21 Nov 2025 18:12:29 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: senozhatsky@chromium.org, akpm@linux-foundation.org, 
	bgeffon@google.com, licayy@outlook.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, minchan@kernel.org, richardycc@google.com
Subject: Re: [RFC PATCHv5 0/6] zram: introduce writeback bio batching
Message-ID: <buckmtxvdfnpgo56owip3fjqbzraws2wvtomzfkywhczckoqlt@fifgyl5fjpbt>
References: <ts32xzxrpxmwf3okxo4bu2ynbgnfe6mehf5h6eibp7dp3r6jp7@4f7oz6tzqwxn>
 <tencent_865DD78A73BC3C9CAFCBAEBE222B6EA5F107@qq.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_865DD78A73BC3C9CAFCBAEBE222B6EA5F107@qq.com>

On (25/11/21 16:23), Yuwen Chen wrote:
> I used the following code for testing here, and the result was 32.
> 
> code:
> @@ -983,6 +983,7 @@ static int zram_writeback_slots(struct zram *zram,
>         struct zram_pp_slot *pps;
>         int ret = 0, err = 0;
>         u32 index = 0;
> +       int inflight = 0;
>  
>         while ((pps = select_pp_slot(ctl))) {
>                 spin_lock(&zram->wb_limit_lock);
> @@ -993,6 +994,9 @@ static int zram_writeback_slots(struct zram *zram,
>                 }
>                 spin_unlock(&zram->wb_limit_lock);
>  
> +               if (inflight < atomic_read(&wb_ctl->num_inflight))
> +                       inflight = atomic_read(&wb_ctl->num_inflight);
> +
>                 while (!req) {
>                         req = zram_select_idle_req(wb_ctl);
>                         if (req)
> @@ -1074,6 +1078,7 @@ next:
>                         ret = err;
>         }
>  
> +       pr_err("%s: inflight max: %d\n", __func__, inflight);
>         return ret;
>  }

I think this will always give you 32 (or you current batch size limit),
just because the way it works - we first deplete all ->idle (reaching
max ->inflight) and only then complete finished requests (dropping
->inflight).

I had a version of the patch that had different main loop. It would
always first complete finished requests.  I think this one will give
accurate ->inflight number.

---
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index ab0785878069..398609e9d061 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -999,13 +999,6 @@ static int zram_writeback_slots(struct zram *zram,
 		}
 
 		while (!req) {
-			req = zram_select_idle_req(wb_ctl);
-			if (req)
-				break;
-
-			wait_event(wb_ctl->done_wait,
-				   !list_empty(&wb_ctl->done_reqs));
-
 			err = zram_complete_done_reqs(zram, wb_ctl);
 			/*
 			 * BIO errors are not fatal, we continue and simply
@@ -1017,6 +1010,13 @@ static int zram_writeback_slots(struct zram *zram,
 			 */
 			if (err)
 				ret = err;
+
+			req = zram_select_idle_req(wb_ctl);
+			if (req)
+				break;
+
+			wait_event(wb_ctl->done_wait,
+				   !list_empty(&wb_ctl->done_reqs));
 		}
 
 		if (blk_idx == INVALID_BDEV_BLOCK) {

---

> > I think page-fault latency of a written-back page is expected to be
> > higher, that's a trade-off that we agree on.  Off the top of my head,
> > I don't think we can do anything about it.
> >
> > Is loop device always used as for writeback targets?
> 
> On the Android platform, currently only the loop device is supported as
> the backend for writeback, possibly for security reasons. I noticed that
> EROFS has implemented a CONFIG_EROFS_FS_BACKED_BY_FILE to reduce this
> latency. I think ZRAM might also be able to do this.

I see.  Do you use S/W or H/W compression?
