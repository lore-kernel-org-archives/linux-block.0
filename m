Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906E1C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 21:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C633206B7
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 21:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="Vel2ad85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C633206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbeLAIwS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 03:52:18 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40755 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeLAIwS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Dec 2018 03:52:18 -0500
Received: by mail-pf1-f195.google.com with SMTP id i12so3417599pfo.7
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 13:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tJNDrBeqUg2p3c/lfV0spJxoSqBGrK1JunTBHMNbutA=;
        b=Vel2ad85pPUAJHwKUS4SScvrI8yknV5XU6jL9JnoqpWWwyFTlPDtxQJ6YvrLLs8e5Q
         xj3P5zgUJisjSDEapZu6culyccDL0dmyN5IC3PtfDJ+HhD53em4h47h8li7fcq8eaXw4
         ag2l/7lHAZ0NEQRW23Lo1txrgo4cYWAbKO6iOYydrqbztU6qbOdoweKli7UfZ3ESizHS
         8zWGgeOC5HL62Xc2Y2X4o9oyLmPHnqxFxCKgzhiwQfc03eCmJPFH5pSiqaPCJ6+fVjp2
         40/7Z0DPxffKRex5nYZQMHKlvkgfcooIi+whXFbVyvPbCpCdP0Q+zhI+cSmogrYk26M1
         x7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tJNDrBeqUg2p3c/lfV0spJxoSqBGrK1JunTBHMNbutA=;
        b=gtDzLjKZmRJSyNAmWaDj2+3mJOJ7RgveO2vmlIRN/VAFjJaIdLN/bv0h2ilkBAilmv
         xxnrIC+T2WOPBWqkJkqtbb9qe/7p+yJu60Zu7fXz+PYTEYxOY/5VKqnwvBj56NwAu8fb
         JT0ABK+1ks1gDTWxPnce+PVlzO/jfkeJWjrVvu/T/T5ua2eUYv/xbopDH7WGtNKo5TPC
         T71mwRBNABfqCJfqp/Qn8kH/MRtVREDi/xDcjkSA12tcQ8cwwA3Jx5YoEkU1zPqTimL8
         C8sFHQVSlpZQxQQe1VqVvJUXl3oJf2nvarwwVSivbGH4AdOOPju5XwXfYdOndkec9yJ8
         ZePw==
X-Gm-Message-State: AA+aEWbUUHHSiN27iEcyxeFwUmlkkz9X7pr9sLfU2iYHiQ4Rh2tm035t
        tOVyzZqnhmAFcDPw8si2sr6poaZ5dP8=
X-Google-Smtp-Source: AFSGD/U6zXNlWg9FyfQyWUbTTgHYiEmUyfHJvOGPtSDSoSOd2sOuiMpdWUZPpCRvE7vMr6cMtpUaSA==
X-Received: by 2002:a63:1e17:: with SMTP id e23mr6152696pge.130.1543614097931;
        Fri, 30 Nov 2018 13:41:37 -0800 (PST)
Received: from vader ([2620:10d:c090:200::4:705d])
        by smtp.gmail.com with ESMTPSA id p83sm14902302pfi.85.2018.11.30.13.41.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 13:41:37 -0800 (PST)
Date:   Fri, 30 Nov 2018 13:41:36 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] sbitmap: ammortize cost of clearing bits
Message-ID: <20181130214136.GB11220@vader>
References: <20181130160118.24683-1-axboe@kernel.dk>
 <20181130160118.24683-2-axboe@kernel.dk>
 <20181130200308.GB27411@vader>
 <f830e923-2307-5e0d-102d-be681a3b1601@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f830e923-2307-5e0d-102d-be681a3b1601@kernel.dk>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 30, 2018 at 01:10:47PM -0700, Jens Axboe wrote:
> On 11/30/18 1:03 PM, Omar Sandoval wrote:
> > On Fri, Nov 30, 2018 at 09:01:17AM -0700, Jens Axboe wrote:
> >> sbitmap maintains a set of words that we use to set and clear bits, with
> >> each bit representing a tag for blk-mq. Even though we spread the bits
> >> out and maintain a hint cache, one particular bit allocated will end up
> >> being cleared in the exact same spot.
> >>
> >> This introduces batched clearing of bits. Instead of clearing a given
> >> bit, the same bit is set in a cleared/free mask instead. If we fail
> >> allocating a bit from a given word, then we check the free mask, and
> >> batch move those cleared bits at that time. This trades 64 atomic bitops
> >> for 2 cmpxchg().
> >>
> >> In a threaded poll test case, half the overhead of getting and clearing
> >> tags is removed with this change. On another poll test case with a
> >> single thread, performance is unchanged.
> >>
> >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >> ---
> >>  include/linux/sbitmap.h | 31 +++++++++++++---
> >>  lib/sbitmap.c           | 80 +++++++++++++++++++++++++++++++++++++----
> >>  2 files changed, 100 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> >> index 804a50983ec5..07f117ee19dc 100644
> >> --- a/include/linux/sbitmap.h
> >> +++ b/include/linux/sbitmap.h
> >> @@ -30,14 +30,24 @@ struct seq_file;
> >>   */
> >>  struct sbitmap_word {
> >>  	/**
> >> -	 * @word: The bitmap word itself.
> >> +	 * @depth: Number of bits being used in @word/@cleared
> >>  	 */
> >> -	unsigned long word;
> >> +	unsigned long depth;
> >>  
> >>  	/**
> >> -	 * @depth: Number of bits being used in @word.
> >> +	 * @word: word holding free bits
> >>  	 */
> >> -	unsigned long depth;
> >> +	unsigned long word ____cacheline_aligned_in_smp;
> > 
> > Still splitting up word and depth in separate cachelines?
> 
> Yeah, I mentioned that in one of the other postings, there's still a
> definite win to doing that.
> 
> > Okay, I couldn't find any holes in this one :)
> 
> Good to hear that :-)
> 
> >> -unsigned int sbitmap_weight(const struct sbitmap *sb)
> >> +static unsigned int __sbitmap_weight(const struct sbitmap *sb, bool set)
> >>  {
> >>  	unsigned int i, weight = 0;
> >>  
> >>  	for (i = 0; i < sb->map_nr; i++) {
> >>  		const struct sbitmap_word *word = &sb->map[i];
> >>  
> >> -		weight += bitmap_weight(&word->word, word->depth);
> >> +		if (set)
> >> +			weight += bitmap_weight(&word->word, word->depth);
> > 
> > Should probably do
> > 			weight -= bitmap_weight(&word->cleared, word->depth);
> > 
> > too, right?
> 
> We only use these for the debugfs stuff, how about I just make it static
> instead?

Yeah, with that,

Reviewed-by: Omar Sandoval <osandov@fb.com>
