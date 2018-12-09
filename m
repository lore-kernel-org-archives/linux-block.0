Return-Path: <SRS0=93Gy=OS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7469C07E85
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 18:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB652081C
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 18:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cs/jyDaP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB652081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbeLISOp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Dec 2018 13:14:45 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46032 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbeLISOo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Dec 2018 13:14:44 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so3880323pgc.12
        for <linux-block@vger.kernel.org>; Sun, 09 Dec 2018 10:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+MqSEAO42VNdDFp983LulFBy7Amse3Osiu/3HOyIge4=;
        b=cs/jyDaPY/Wcv4XiPwzNHRyN4RMIndIepQZUkboIN3XftsGvr5NPY1MnhQz3jU9cFp
         Hlk+sUmSNSN9pgF8z1cUbDKqQo0NYIap7Q1jOBgqmWzyLJGy4MZeGIpvgJ7ALYnEgFMU
         4n3+iHqlDoeGEV3smrf47Y03h/0fO/hoFOCmmOzT6Bk/40NQpu2hXP2LS1hPgPFjrf5U
         KJ/uzl1gLNzPBwI0Yfrye+khFEN2Cvx2j8T+3H1tuu45ujGbZVax/XvApCtC+i1mq0hp
         v0onBFzbQqAAajUUnsYlGzCF0DLB9xfGgKcBXQctbdY1J9znWLwLdiT/pTH+ir6PvU4L
         dPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+MqSEAO42VNdDFp983LulFBy7Amse3Osiu/3HOyIge4=;
        b=n0AmwM2eY1mwra6oZAV4aJb8OZyPT7SZp90kKhLkkQznDvJq5Vi2jBdvGXhvOfWj4W
         fPK2au6sIDQjVJGa2HCn8SElPrwrhT6ZcCa/VGnx7EzJokifeVpFNtoVvpYvMOm/dMZL
         A6rQf7eGcyfif0VQ/qAU8uT0Ap856imdDjlMKyDAlWGcM+6/mfBYFW1PpjCZ2AXsfO6r
         3GbJLIc3VhaqBHNpLrkcjTju94bXe5MIMmfYBNvg+lSwYOlTIH2nnFhhscRYiRW57n4k
         4ohHmTxHnRijoLWM46SN3sPVJ+fbdPOXUrWCFbGfE59Em3zCC2t30xrio8UzmLlh4Z2d
         pzqQ==
X-Gm-Message-State: AA+aEWZp79D63/l1Hv1QRVYiPatZTLVTksQjaXVno4enOFaQHO5tTxMT
        qQIlzJGKNqwjkuRf1gDKfIgRViLKvgg=
X-Google-Smtp-Source: AFSGD/WHMT7iGPNr0M4qq6CGyGO/wYKHF8eqrPpOi+HAGcYS3qAZyTz6WgC8ivpuxl0MKsvzfgYOsg==
X-Received: by 2002:a62:4181:: with SMTP id g1mr9511913pfd.45.1544379283570;
        Sun, 09 Dec 2018 10:14:43 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id i72sm12845356pfe.181.2018.12.09.10.14.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 10:14:42 -0800 (PST)
Subject: Re: [PATCH] sbitmap: silence bogus lockdep IRQ warning
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
References: <20181209165847.GA31213@roeck-us.net>
 <f57e00fe-9f59-e1c2-2af3-8c41ebe1fe51@kernel.dk>
 <5b742063-76c4-ba63-e50c-5e4dfe1dbe42@roeck-us.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <20315f53-4954-6b32-335a-bb7c3b097aa9@kernel.dk>
Date:   Sun, 9 Dec 2018 11:14:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5b742063-76c4-ba63-e50c-5e4dfe1dbe42@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/9/18 11:01 AM, Guenter Roeck wrote:
> On 12/9/18 9:50 AM, Jens Axboe wrote:
>> On 12/9/18 9:58 AM, Guenter Roeck wrote:
>>> On Sun, Dec 09, 2018 at 07:26:47AM -0700, Jens Axboe wrote:
>>>>
>>>> Ming that lockdep spews the following trace. What this essentially says
>>>> is that the sbitmap swap_lock was used inconsistently in IRQ enabled
>>>> and disabled context, and that is usually indicative of a bug that will
>>>> cause a deadlock.
>>>>
>>>> For this case, it's a false positive. The swap_lock is used from process
>>>> context only, when we swap the bits in the word and cleared mask. We
>>>> also end up doing that when we are getting a driver tag, from the
>>>> blk_mq_mark_tag_wait(), and from there we hold the waitqueue lock with
>>>> IRQs disabled. However, this isn't from an actual IRQ, it's still
>>>> process context.
>>>>
>>>> Mark the swap_lock as not needing validation to silence this warning.
>>>>
>>>
>>> checkpatch says:
>>>
>>> $ scripts/checkpatch.pl jens2
>>> ERROR: lockdep_no_validate class is reserved for device->mutex.
>>> #357: FILE: lib/sbitmap.c:68:
>>> +		lockdep_set_novalidate_class(&sb->map[i].swap_lock);
>>>
>>> ... which I think explains the warning I am seeing with this patch applied.
>>
>> Try the other patch I sent out earlier, that should work.
>>
> 
> Ok, I am lost. No idea which patch you refer to. I'll just wait for the problem
> to disappear from -next, or report it again if it shows up in mainline.

This one, sent out this morning in this thread:


diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index a89fbe7cf6ca..23da156f7a17 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -118,8 +118,13 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
 static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
 {
 	unsigned long mask, val;
+	unsigned long flags;
 	bool ret = false;
 
+	/* Silence bogus lockdep warning */
+#if defined(CONFIG_LOCKDEP)
+	local_irq_save(flags);
+#endif
 	spin_lock(&sb->map[index].swap_lock);
 
 	if (!sb->map[index].cleared)
@@ -142,6 +147,9 @@ static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
 	ret = true;
 out_unlock:
 	spin_unlock(&sb->map[index].swap_lock);
+#if defined(CONFIG_LOCKDEP)
+	local_irq_restore(flags);
+#endif
 	return ret;
 }
 

-- 
Jens Axboe

