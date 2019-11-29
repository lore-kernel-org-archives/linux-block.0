Return-Path: <SRS0=kXjy=ZV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3B4C432C0
	for <linux-block@archiver.kernel.org>; Fri, 29 Nov 2019 22:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703AD2464F
	for <linux-block@archiver.kernel.org>; Fri, 29 Nov 2019 22:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkCXlQ6r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfK2WRO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Nov 2019 17:17:14 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44172 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfK2WRO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Nov 2019 17:17:14 -0500
Received: by mail-qk1-f196.google.com with SMTP id i18so1598344qkl.11;
        Fri, 29 Nov 2019 14:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fLKk88eVvY3KF64ji7XbiRlsVmL1Sdrh2EvPmKppMtA=;
        b=NkCXlQ6rScWjwEgHwvckt3xNu7sJ6jJerm/xxcTbDO4SJH6IEn4mNMGqW2rnPWhzGC
         jCLnJ4gHHyetjvOqamnWw3SiIDr2sqyr38CyyMUw2awba000nlVb3rKcDuX2hupqHPKT
         8jNPQ6h8NMS36TuxewOe4uzTQy5q/ru1TM4ztufl8vySzlfBlQQDys8rShtwFQnhdgF5
         jmuEmTDZhlEJheC8/qGIw4jdbxbd88jFwlu1/pbA4nhJfJc0d+Ow5v2hcLxo/8sm+CGx
         0d7IOzCyWXlH0p/gt942I72jxhLrKTNPmtD0+wj35MMYmsPqA+oN89KlquNzMm5Edj1u
         w/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fLKk88eVvY3KF64ji7XbiRlsVmL1Sdrh2EvPmKppMtA=;
        b=MoASDAF2P0yB64vqs9yvXrKXTk/dFZWd5pRV1EL+vImyOQuS5j2fatztBX9/jXifiL
         igM7AGOykXr8n0MiGbN+q6KMD6zR5HjryA5UtQ+b55FAbNO06toF/Du9kYB25q2pv/aK
         9TIiJFQ+EVqmrTZ8Q6X+YD35E7kRjaM1GU0hQyxqaQj/ta8oD9Q7FUh7ZY147dH2Gyse
         xjBv3GVkKbnd7XddDsXXUdgewX0VLk61bmHRcaAxmcsclxj/lrRLRpm/wuvPR2kUDoXI
         LKUk49AuN5VLQU2DMIioLa5qx4ceFNIKwsX25MjGUaAFapSCRtOWzUT4+IAQR2cc6wmf
         ddkw==
X-Gm-Message-State: APjAAAWVGK/2ry1NoPPCONeTFhR4fowxDKR5sdAUiPnRsq1SVI/GMg4C
        AFrUhNwsTO4NtAnCSqAP2rXl9Axkqoc=
X-Google-Smtp-Source: APXvYqyF2ONdyB5JvKFbVfYWPrqcfOaMRSKgbmeVts93aDpsTq4P+dlAAy0ly+c6Kut/UWYfnTz5oQ==
X-Received: by 2002:a37:5d1:: with SMTP id 200mr18974112qkf.492.1575065833347;
        Fri, 29 Nov 2019 14:17:13 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a187sm10686759qkc.91.2019.11.29.14.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 14:17:13 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 29 Nov 2019 17:17:11 -0500
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@canonical.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: optimise bvec_iter_advance()
Message-ID: <20191129221709.GA1164864@rani.riverdale.lan>
References: <cover.1574974574.git.asml.silence@gmail.com>
 <06b1b796b8d9bcaa6d5b325668525b7a5663035b.1574974574.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <06b1b796b8d9bcaa6d5b325668525b7a5663035b.1574974574.git.asml.silence@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 29, 2019 at 12:04:37AM +0300, Pavel Begunkov wrote:
> bvec_iter_advance() is quite popular, but compilers fail to do proper
> alias analysis and optimise it good enough. The assembly is checked
> for gcc 9.2, x86-64.
> 
> - remove @iter->bi_size from min(...), as it's always less than @bytes.
> Modify at the beginning and forget about it.
> 
> - the compiler isn't able to collapse memory dependencies and remove
> writes in the loop. Help it by explicitely using local vars.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  include/linux/bvec.h | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/bvec.h b/include/linux/bvec.h
> index a032f01e928c..7b2f05faae14 100644
> --- a/include/linux/bvec.h
> +++ b/include/linux/bvec.h
> @@ -87,26 +87,31 @@ struct bvec_iter_all {
>  static inline bool bvec_iter_advance(const struct bio_vec *bv,
>  		struct bvec_iter *iter, unsigned bytes)
>  {
> +	unsigned int done = iter->bi_bvec_done;
> +	unsigned int idx = iter->bi_idx;
> +
>  	if (WARN_ONCE(bytes > iter->bi_size,
>  		     "Attempted to advance past end of bvec iter\n")) {
>  		iter->bi_size = 0;
>  		return false;
>  	}
>  
> +	iter->bi_size -= bytes;
> +
>  	while (bytes) {
> -		const struct bio_vec *cur = bv + iter->bi_idx;
> -		unsigned len = min3(bytes, iter->bi_size,
> -				    cur->bv_len - iter->bi_bvec_done);
> +		const struct bio_vec *cur = bv + idx;
> +		unsigned int len = min(bytes, cur->bv_len - done);
>  
>  		bytes -= len;
> -		iter->bi_size -= len;
> -		iter->bi_bvec_done += len;
> -
> -		if (iter->bi_bvec_done == cur->bv_len) {
> -			iter->bi_bvec_done = 0;
> -			iter->bi_idx++;
> +		done += len;
> +		if (done == cur->bv_len) {
> +			idx++;
> +			done = 0;
>  		}
>  	}
> +
> +	iter->bi_idx = idx;
> +	iter->bi_bvec_done = done;
>  	return true;
>  }
>  
> -- 
> 2.24.0
> 

The loop can be simplified a bit further, as done has to be 0 once we go
beyond the current bio_vec. See below for the simplified version.

I also check if bi_size became zero so we can skip the rest of the
calculations in that case. If we want to preserve the current behavior of
updating iter->bi_idx and iter->bi_bvec_done even if bi_size is going to
become zero, the loop condition should change to

		while (bytes && bytes >= cur->bv_len)

to ensure that we don't try to access past the end of the bio_vec array.

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index a032f01e928c..380d188dfbd2 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -87,25 +87,26 @@ struct bvec_iter_all {
 static inline bool bvec_iter_advance(const struct bio_vec *bv,
 		struct bvec_iter *iter, unsigned bytes)
 {
+	unsigned int idx = iter->bi_idx;
+	const struct bio_vec *cur = bv + idx;
+
 	if (WARN_ONCE(bytes > iter->bi_size,
 		     "Attempted to advance past end of bvec iter\n")) {
 		iter->bi_size = 0;
 		return false;
 	}
 
-	while (bytes) {
-		const struct bio_vec *cur = bv + iter->bi_idx;
-		unsigned len = min3(bytes, iter->bi_size,
-				    cur->bv_len - iter->bi_bvec_done);
-
-		bytes -= len;
-		iter->bi_size -= len;
-		iter->bi_bvec_done += len;
-
-		if (iter->bi_bvec_done == cur->bv_len) {
-			iter->bi_bvec_done = 0;
-			iter->bi_idx++;
+	iter->bi_size -= bytes;
+	if (iter->bi_size != 0) {
+		bytes += iter->bi_bvec_done;
+		while (bytes >= cur->bv_len) {
+			bytes -= cur->bv_len;
+			idx++;
+			cur++;
 		}
+
+		iter->bi_idx = idx;
+		iter->bi_bvec_done = bytes;
 	}
 	return true;
 }
