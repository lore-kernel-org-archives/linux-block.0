Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0335C43219
	for <linux-block@archiver.kernel.org>; Fri, 11 Nov 2022 00:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiKKAms (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Nov 2022 19:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiKKAmr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Nov 2022 19:42:47 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3A961B9A
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 16:42:46 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id 4so3024128pli.0
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 16:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xM5WNzI0hwRHjliP1X8vOe9pxalT6LKCbo/mWi3YSJs=;
        b=Ks0k/pf8S/S1HZNwKLbh8GafqB1bWlwq1sI/v9pfDxFYhNglaLAjwpun9WjaZ3IP45
         DxKlrmbh/25Er18wbqq1jIHdLjB0X+A0g0SODBnycheHV2whn6s/WYuKBA4w2Q0wG91M
         f+mG8bvckQFAkHwQ3N385LuwERVCtA9iXj4qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xM5WNzI0hwRHjliP1X8vOe9pxalT6LKCbo/mWi3YSJs=;
        b=3azOJzhaV5GbIJb1i+RqRywIFXRhZT4mu7o6CRWaxHch6CcLVjbCyWEbCLOCqT5AdE
         JOrrRXQ4O1cfowd/gXFj1jLOt+RxDe0SPksA3YxvSETvf4S00eRKXLDoSBpQ61NXm27O
         nHcc+2FeK/U5yL3e2HMb0445F5FVc41CsCKmuYnTa7jaKPWQG0gjuPPepPz7hCOxVNLF
         uDgE+PPjOAMwp3wNxErZqmeJxLcjhVNg9Mlub/3sVcriibXlpNYx9kE6KKhLYQu5D65C
         GGnbnldR0/T7OUGZONaOlvj/g4rnuEL72xYNKMKZZobhjN3/enh7qeG4B6zdX1zfIVaM
         lSgQ==
X-Gm-Message-State: ANoB5pkx8GwuLMWjbSuZOPp+ilSte3af2CtdUKorcS3Rmk1qB00L4Tgs
        +4aIiYQENeF6SnBGPrbD9nxQuA==
X-Google-Smtp-Source: AA0mqf4lsQyzaHXXZR1h9k1dQs/5NsV//w58zMbDuUA6cVJJlf1B6++qWdvFLSorlO2Qcc0M6PwT3Q==
X-Received: by 2002:a17:902:bd8e:b0:186:8398:350 with SMTP id q14-20020a170902bd8e00b0018683980350mr214085pls.6.1668127365713;
        Thu, 10 Nov 2022 16:42:45 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:8d55:c60d:579d:741c])
        by smtp.gmail.com with ESMTPSA id q90-20020a17090a756300b001faf7a88138sm375216pjk.42.2022.11.10.16.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 16:42:45 -0800 (PST)
Date:   Fri, 11 Nov 2022 09:42:38 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     coverity-bot <keescook@chromium.org>
Cc:     Alexey Romanov <avromanov@sberdevices.ru>,
        linux-kernel@vger.kernel.org, Nick Terrell <terrelln@fb.com>,
        Minchan Kim <minchan@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Nitin Gupta <ngupta@vflare.org>, Jens Axboe <axboe@kernel.dk>,
        Nhat Pham <nphamcs@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: Coverity: zram_recompress(): OVERRUN
Message-ID: <Y22afneyl4pZ32ig@google.com>
References: <202211100847.388C61B3@keescook>
 <Y22ZNtdH9s+cuL9l@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y22ZNtdH9s+cuL9l@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (22/11/11 09:37), Sergey Senozhatsky wrote:
> On (22/11/10 08:47), coverity-bot wrote:
> [..]
> > 1704     	class_index_old = zs_lookup_class_index(zram->mem_pool, comp_len_old);
> > 1705     	/*
> > 1706     	 * Iterate the secondary comp algorithms list (in order of priority)
> > 1707     	 * and try to recompress the page.
> > 1708     	 */
> > 1709     	for (; prio < prio_max; prio++) {
> > vvv     CID 1527270:    (OVERRUN)
> > vvv     Overrunning array "zram->comps" of 4 8-byte elements at element index 4 (byte offset 39) using index "prio" (which evaluates to 4).
> > 1710     		if (!zram->comps[prio])
> > 1711     			continue;
> > 1712
> > 1713     		/*
> > 1714     		 * Skip if the object is already re-compressed with a higher
> > 1715     		 * priority algorithm (or same algorithm).
> 
> prio_max is always limited and max value it can have is 4 (ZRAM_MAX_COMPS).
> Depending on use case we can limit prio_max even to lower values.
> 
> So we have
> 
> 	for (; prio < 4; prio++) {
> 		foo = comps[prio];
> 	}
> 
> I don't see how prio can be 4 inside of this loop.

Kees, if we do something like this will it make coverity happy?

---

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9d33801e8ba8..e67a124f2e88 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1706,6 +1706,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 	 * Iterate the secondary comp algorithms list (in order of priority)
 	 * and try to recompress the page.
 	 */
+	prio_max = min(prio_max, ZRAM_MAX_COMPS);
 	for (; prio < prio_max; prio++) {
 		if (!zram->comps[prio])
 			continue;
