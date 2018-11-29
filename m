Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8996C04EB9
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 21:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A55E2145D
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 21:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="miRlz2X/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A55E2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbeK3JA0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:00:26 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:47043 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeK3JA0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 04:00:26 -0500
Received: by mail-ot1-f65.google.com with SMTP id w25so3226304otm.13
        for <linux-block@vger.kernel.org>; Thu, 29 Nov 2018 13:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WjyyU2nfHn333o+WFidX2MYdlAp3raR1k93A0v2A0NA=;
        b=miRlz2X/aZP8dScekdW66GloBXyXoqUvS+S7GJLxjxlBXjOT5VpfBlTpvKudY4dLTd
         4CmUoD14VWud/EP2GB/KaY15muM63Fj8qi0nOq1chQshcSoE3QAyfUkVmJN53ovmcLCI
         XQ2V9jK7BKUXxxzJZhUM0cHe0rMyx4RFPMKX5TsBmH+FOt279uuBjQscWwKt6C4sElMr
         f1nUq2Kkx/oGcQyAvA3mGO3DXdaPLE5SQtOcHFhL8Gm/aLsU2dzaQR7kujcFQQivpFyc
         Dk0KNN2azpH+SvyYDrp8eRJV87d2gh0RncPbsnDb8qILreom4qUq/5Bek4G/JjazslBy
         mB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WjyyU2nfHn333o+WFidX2MYdlAp3raR1k93A0v2A0NA=;
        b=S1jF3YTEwLGIr3R+mfYECTZSs+00so3lmPYvrs93ieqav8faf3TiaHkK89Yoyr4F0Q
         26YmglueRBGzUHewGmMZyeGURrAyxnMl1O5kuK0a4ItHpqHpdAUZq+/Nd6AMjI1Ss38J
         A8SJi3COQYIJKGvciRuklQ75+4vrCbLcxVZswHraTPJasq/OTtkCR6gDB+kc2jnM8hKJ
         K+tih+8EGjowPElEKKOKak0Vv0MuHqp9n6LGeVkzGDJ1MioWHHrTOuFCBuZogJeTycFW
         EX9M3Tj9al7odiehO4Pk9KVDd0urY4ZYWjKtpAKC9FoTC1Glwekk89LARYROLyViFl0A
         q7NQ==
X-Gm-Message-State: AA+aEWYvdP8FNBhZvpdoqelKLpnqLX52mRMp0FVN/NJOyr5WJCV4GTTW
        h7lNc5oPymfJPJOjIDeDdvpOihJNPzk=
X-Google-Smtp-Source: AFSGD/WE2yglJNu//Egb+31Qjkt8gawkz0spi4nYoVgdFGmd8G3JFngfGkwOGIcvBlpDx7ppLvmlQw==
X-Received: by 2002:a05:6830:120c:: with SMTP id r12mr2140148otp.252.1543528413190;
        Thu, 29 Nov 2018 13:53:33 -0800 (PST)
Received: from vader ([172.58.43.181])
        by smtp.gmail.com with ESMTPSA id d10sm1264511otl.62.2018.11.29.13.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 13:53:32 -0800 (PST)
Date:   Thu, 29 Nov 2018 13:53:30 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] sbitmap: ammortize cost of clearing bits
Message-ID: <20181129215330.GB25153@vader>
References: <91b96e21-45c9-63ca-334a-6f597b34123e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91b96e21-45c9-63ca-334a-6f597b34123e@kernel.dk>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 29, 2018 at 01:00:25PM -0700, Jens Axboe wrote:
> sbitmap maintains a set of words that we use to set and clear bits, with
> each bit representing a tag for blk-mq. Even though we spread the bits
> out and maintain a hint cache, one particular bit allocated will end up
> being cleared in the exact same spot.
> 
> This introduces batched clearing of bits. Instead of clearing a given
> bit, the same bit is set in a cleared/free mask instead. If we fail
> allocating a bit from a given word, then we check the free mask, and
> batch move those cleared bits at that time. This trades 64 atomic bitops
> for 2 cmpxchg(). On top of that, we do those sequentially, hopefully
> making that a bit cheaper as well.
> 
> In a threaded poll test case, half the overhead of getting and clearing
> tags is removed with this change. On another poll test case with a
> single thread, performance is unchanged.
>     
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> This patch is on top of the round robin fix for sbitmap just posted.

So I think this can lead to hangs due to interactions with wake_batch.
Bear with me:

Let's say the sbitmap_queue was created with depth=64 and shift=6, i.e.,
64 bits all in one word. In this case, wake_batch=8, because 64 bits
clearing should be enough to wake up in 8 batches of 8.

Let's say all 64 bits are allocated and there are 8 waiters. All 64 bits
are then freed (in the cleared word), so we wake up the 8 waiters. Let's
say they all attempt __sbitmap_get_word(), fail, and get to
sbitmap_deferred_clear() at the same time. One of them does the
cmpxchg() on cleared, setting it to zero, and then the rest see that
cleared is zero, so they return because there don't appear to be any
cleared bits. The first thread succeeds, and the rest go to sleep. 

Now, when the first thread clears the bit, it only subtracts one from
the batch, which isn't enough to do a wakeup. Hang!

This example is contrived, but in general I think that the window
between the cleared mask being zeroed and the word being cleared is
going to cause problems.

> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> index 804a50983ec5..cec685b89998 100644
> --- a/include/linux/sbitmap.h
> +++ b/include/linux/sbitmap.h
> @@ -30,14 +30,19 @@ struct seq_file;
>   */
>  struct sbitmap_word {
>  	/**
> -	 * @word: The bitmap word itself.
> +	 * @depth: Number of bits being used in @word/@cleared
>  	 */
> -	unsigned long word;
> +	unsigned long depth;
>  
>  	/**
> -	 * @depth: Number of bits being used in @word.
> +	 * @word: word holding free bits
>  	 */
> -	unsigned long depth;
> +	unsigned long word ____cacheline_aligned_in_smp;

Completely separate note (assuming that we can iron out the race above),
this triples the size of each map. Does the word have to be in a
separate cacheline from the depth? Ignoring resize, depth and word are
always accessed together, so it seems to me that it would benefit from
sharing a cacheline now that clearing happens elsewhere.

> +	/**
> +	 * @cleared: word holding cleared bits
> +	 */
> +	unsigned long cleared ____cacheline_aligned_in_smp;
>  } ____cacheline_aligned_in_smp;
