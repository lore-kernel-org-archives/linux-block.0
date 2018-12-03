Return-Path: <SRS0=uopx=OM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3D1C04EB9
	for <linux-block@archiver.kernel.org>; Mon,  3 Dec 2018 22:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27A120851
	for <linux-block@archiver.kernel.org>; Mon,  3 Dec 2018 22:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="jBejBUsu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27A120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbeLCWFU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:05:20 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:35635 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbeLCWFU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 17:05:20 -0500
Received: by mail-pl1-f179.google.com with SMTP id p8so7174699plo.2
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 14:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hj7I4GeFND7vrkQ8VTy4myM76ZlT7HGPXBAMplE4OOc=;
        b=jBejBUsu5qZHAFv//Rix7yXFnpmcJ7pwTwAs7i8J3DEofqhxDL/aI55sb0Skf/2BPo
         9Yll+Uwngx4p/othWTtZ6rp2oEP33SWluY3vnSiQ7KLIWSfgFyJudWmoVXTsBt/TUbR4
         pctKxSXVMfony4+fIRmjsfmDcteSFj2mkQ5ZsRF9Bw04HM5ZDcy7vt0U1YPwSn2XuNQO
         tbaiEE08dM0PXJX2oa9N+yAuj4tv8QWZ5wdUtKwM4dzIw1G1VN2xVIcifeuOfNsILjJ4
         sZf8L13fsCuTyKqkdESVSz/Q4AExaKmAcemJbfZRlVesdvpU2wpujF7+yYwBMl/dC83m
         GeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hj7I4GeFND7vrkQ8VTy4myM76ZlT7HGPXBAMplE4OOc=;
        b=HRotLY+CyoPgGHM5hb9sCUHgLYHPPfyZJDUf8CR2mh0ItLsCqv12Jhe/vlHhKEUQBI
         JbfGMwsKE63nQBMtjWaIYZH3OjuRyHrlicHBA5Kr+rf8WNTbs7PyiHLNDVoR4CN+7F2o
         J6vVC/pHSKDkrn8MZa+JOf4uQGYRrvz8N+uGCSAozpUgtif0iqiOi2FlkQ49r9BPk+z3
         U2zCZNpq0XvuOifmFuN+Imd1ydcHdq8DEO5K3VmaZ/QYIrxIahCKOIWDW6bPU/nOjnuR
         2DDqt62slhHYIsGh3sQW4+BZitnfNCxtrUpq1FhDwQSX/mBngqbiw5B0XH/SOxQhtp8E
         4JbA==
X-Gm-Message-State: AA+aEWY2VfMSh8/1uFzYEY9T5juO8cd1rPMSSlzB7SvggvjM9+vpva1t
        B0rVUJCGj03XjFmbuFUWZwarDA==
X-Google-Smtp-Source: AFSGD/XvFqOfHW/vOacknN0aRhxksAsvO56EiWA81is5h2Xy4K1dDWAoNNYvknUvB8Vebbm3DXzLkg==
X-Received: by 2002:a17:902:bcc7:: with SMTP id o7mr17961405pls.281.1543874718886;
        Mon, 03 Dec 2018 14:05:18 -0800 (PST)
Received: from vader ([2620:10d:c090:200::5:8421])
        by smtp.gmail.com with ESMTPSA id z8sm31389651pgz.53.2018.12.03.14.05.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 14:05:18 -0800 (PST)
Date:   Mon, 3 Dec 2018 14:05:17 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: sbitmap: check cleared bits when iterating busy bits
Message-ID: <20181203220517.GD11220@vader>
References: <8bde3953-56d8-32cb-2c34-582d632f4a3f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bde3953-56d8-32cb-2c34-582d632f4a3f@kernel.dk>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 03, 2018 at 02:56:17PM -0700, Jens Axboe wrote:
> When we are iterating the set bits in a word, we also need to factor in
> the cleared bits. Don't call fn() unless the bit is also not set in
> the cleared word.
> 
> Fixes: ea86ea2cdced ("sbitmap: ammortize cost of clearing bits")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> index 92806a2dbab7..9f374fbcdba6 100644
> --- a/include/linux/sbitmap.h
> +++ b/include/linux/sbitmap.h
> @@ -283,6 +283,11 @@ static inline void __sbitmap_for_each_set(struct sbitmap *sb,
>  			nr = find_next_bit(&word->word, depth, nr);
>  			if (nr >= depth)
>  				break;
> +			/* if set in cleared, it's actually free */
> +			if (test_bit(nr, &word->cleared)) {
> +				nr++;
> +				continue;
> +			}
>  			if (!fn(sb, (index << sb->shift) + nr, data))
>  				return;
>  
> -- 
> Jens Axboe
> 

How about something like this:

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index f0f49bbb2617..fe9122386255 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -265,12 +265,14 @@ static inline void __sbitmap_for_each_set(struct sbitmap *sb,
 	nr = SB_NR_TO_BIT(sb, start);
 
 	while (scanned < sb->depth) {
-		struct sbitmap_word *word = &sb->map[index];
-		unsigned int depth = min_t(unsigned int, word->depth - nr,
+		unsigned long word;
+		unsigned int depth = min_t(unsigned int,
+					   sb->map[index].depth - nr,
 					   sb->depth - scanned);
 
 		scanned += depth;
-		if (!word->word)
+		word = sb->map[index].word & ~sb->map[index].cleared;
+		if (!word)
 			goto next;
 
 		/*
@@ -280,7 +282,7 @@ static inline void __sbitmap_for_each_set(struct sbitmap *sb,
 		 */
 		depth += nr;
 		while (1) {
-			nr = find_next_bit(&word->word, depth, nr);
+			nr = find_next_bit(&word, depth, nr);
 			if (nr >= depth)
 				break;
 			if (!fn(sb, (index << sb->shift) + nr, data))

Might be marginally faster.
