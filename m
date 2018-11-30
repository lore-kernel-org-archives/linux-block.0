Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB4FC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 20:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD5920863
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 20:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TVjKbLzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD5920863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbeLAHVQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:21:16 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44810 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeLAHVQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Dec 2018 02:21:16 -0500
Received: by mail-io1-f68.google.com with SMTP id r200so5519467iod.11
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 12:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dIYhaKgqHJONyR1GL8hB6UQTPWGnWsMcVvrS5wcrS28=;
        b=TVjKbLzc2+lk7RZSVX2T+VTDm233s7IPAkSTqFjHeuMZ0KXFKZMorV1YXBEbfyZswt
         KbVeIuHQolYfiYGC+70efscy32JOJ9mzAqqrE451yAY6vbyfT4E2WihNaMlVrN3xC/4M
         1ppWp/T39ZcJKrNBdvDhsZuXgAaY6n8uJ7MFy0qbMURRYOJ8tVoxLAnz3DJ4AkcQLADt
         LtlnTjZq0EAKvzsVE0/6etgXmS/7HLwWjx1BMVTWjv4nrOsaliMQ5GNreQNwWcQUtl/L
         HhoUY7mguFVE5AURLrBIWjO0QAiXRJY9Mf3Mgsm0h3ZuvoIypJrPYGp74Vs8pdNQMrwl
         Yk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dIYhaKgqHJONyR1GL8hB6UQTPWGnWsMcVvrS5wcrS28=;
        b=huC2Yq7o2voWJRH7tis6GgR3Azm10FRGdzrNdJO8MuUBXCOrrkS6bjWHDl/ioCRhdq
         Td/HZgJFfqhIOUsJMSph4+ThuaFNqn0pgKsyNi9HT3FgO51nSC1FYfGjUNAOonqVdH1w
         wAz1NzsreX18h8kzjJZdanHpG4Zridvx6EebVQeoz9rp7tk2NYOGNvP+Ib3l2V0bomNu
         aGKCohbyZbImTc5d3CCUg6CemSRvK/hKL/rGsa0TTnXvpJpYPeA2rStpczFoll1OkZ+H
         sA94/94MH1zaQ5peYvDXevVmfay8VRRJCG6X0sfvfWjxpIObWUMA4Kt54Dy1/5/kZoWn
         B+Sg==
X-Gm-Message-State: AA+aEWY1iBucWUhGcpN6hhcWX1r8sXYw8mXwLHaF0ZNLhyV13oYKb3Kx
        JSX52QL7x3ZddRYhTqdu+ZDydjolv2k=
X-Google-Smtp-Source: AFSGD/UWYBuSTNMD5cfJVqsvulXVd6XnvU99uiJRX73SYxdZ5PMJjiogCGmuo8j8wh1rFhvoBprfgg==
X-Received: by 2002:a5d:994f:: with SMTP id v15mr4758391ios.190.1543608649854;
        Fri, 30 Nov 2018 12:10:49 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id e189sm89309ite.17.2018.11.30.12.10.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 12:10:48 -0800 (PST)
Subject: Re: [PATCH 1/2] sbitmap: ammortize cost of clearing bits
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-block@vger.kernel.org
References: <20181130160118.24683-1-axboe@kernel.dk>
 <20181130160118.24683-2-axboe@kernel.dk> <20181130200308.GB27411@vader>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f830e923-2307-5e0d-102d-be681a3b1601@kernel.dk>
Date:   Fri, 30 Nov 2018 13:10:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130200308.GB27411@vader>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/18 1:03 PM, Omar Sandoval wrote:
> On Fri, Nov 30, 2018 at 09:01:17AM -0700, Jens Axboe wrote:
>> sbitmap maintains a set of words that we use to set and clear bits, with
>> each bit representing a tag for blk-mq. Even though we spread the bits
>> out and maintain a hint cache, one particular bit allocated will end up
>> being cleared in the exact same spot.
>>
>> This introduces batched clearing of bits. Instead of clearing a given
>> bit, the same bit is set in a cleared/free mask instead. If we fail
>> allocating a bit from a given word, then we check the free mask, and
>> batch move those cleared bits at that time. This trades 64 atomic bitops
>> for 2 cmpxchg().
>>
>> In a threaded poll test case, half the overhead of getting and clearing
>> tags is removed with this change. On another poll test case with a
>> single thread, performance is unchanged.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  include/linux/sbitmap.h | 31 +++++++++++++---
>>  lib/sbitmap.c           | 80 +++++++++++++++++++++++++++++++++++++----
>>  2 files changed, 100 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
>> index 804a50983ec5..07f117ee19dc 100644
>> --- a/include/linux/sbitmap.h
>> +++ b/include/linux/sbitmap.h
>> @@ -30,14 +30,24 @@ struct seq_file;
>>   */
>>  struct sbitmap_word {
>>  	/**
>> -	 * @word: The bitmap word itself.
>> +	 * @depth: Number of bits being used in @word/@cleared
>>  	 */
>> -	unsigned long word;
>> +	unsigned long depth;
>>  
>>  	/**
>> -	 * @depth: Number of bits being used in @word.
>> +	 * @word: word holding free bits
>>  	 */
>> -	unsigned long depth;
>> +	unsigned long word ____cacheline_aligned_in_smp;
> 
> Still splitting up word and depth in separate cachelines?

Yeah, I mentioned that in one of the other postings, there's still a
definite win to doing that.

> Okay, I couldn't find any holes in this one :)

Good to hear that :-)

>> -unsigned int sbitmap_weight(const struct sbitmap *sb)
>> +static unsigned int __sbitmap_weight(const struct sbitmap *sb, bool set)
>>  {
>>  	unsigned int i, weight = 0;
>>  
>>  	for (i = 0; i < sb->map_nr; i++) {
>>  		const struct sbitmap_word *word = &sb->map[i];
>>  
>> -		weight += bitmap_weight(&word->word, word->depth);
>> +		if (set)
>> +			weight += bitmap_weight(&word->word, word->depth);
> 
> Should probably do
> 			weight -= bitmap_weight(&word->cleared, word->depth);
> 
> too, right?

We only use these for the debugfs stuff, how about I just make it static
instead?


-- 
Jens Axboe

