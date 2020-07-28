Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F076C433E5
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 19:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD9C3207F5
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 19:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Y9eOezwV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732780AbgG1TUU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729599AbgG1TUT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 15:20:19 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F4AC061794
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2020 12:20:19 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s15so1056731pgc.8
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2020 12:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6vfxP0xAICcExvQMz/4lQvBsGt+MbkdQCG7TPtmY2IU=;
        b=Y9eOezwVV/XNy3ss0E8zEQZN46Jwp7Vwk2F4dYKq4GF+o38CPH9bXtrUXOyKXIv0qi
         IxCEGapawUVePV3q40k2ellTesiBEzVplHJE1NvfhyL5RCl83HKGBpQJX0QM6eO0a6fq
         K4eY6mGRbq51nbLdHdV0aIyuHM8uJTGXUryQRTt7Lj0uw/Rn/vzZ7q/sGIcO2+P5vKXM
         D+ek+rXJ/oXKvUiOA/SsGJJtECe80pX2lqhwV2Mek5vNpO9+e9YTmFR2Dc+dekaVJzW8
         tm1bitx5pVI4Q4Wm0OEfzMIXB/vw2Lt3V5PNJbWz7GH/REb/D7Ra0sQgFciGhg/c8Ve4
         LbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6vfxP0xAICcExvQMz/4lQvBsGt+MbkdQCG7TPtmY2IU=;
        b=KA1Ivhukyaj22bsOGoUuvi/z81BZ2uuXhAsBAIX8pr4Zqg8Qb/CkTu9pl93lYBq889
         pqWWtmAaKEOa9fiscRC3cGof6id9gzbuKiwVpHYOVr3XyrdRSwmUqbAzVBAHx3AwMYr1
         N/0aBTBtpRUzotTRBjsC1J4cKJwGFPrRwofnj3HjeFQYR+g4cSVLCkIpiqzrYdmVBRkV
         7z9IEezj9FEXaIliw5x6Jk+DVYnwcOA/UTHqZHp1KITH/0bXabEB0FicmMYKc3rClijq
         3K+e4959q5rB5/NgBzetuEd+sg77DEDRsCi+WPCIG1X9sJ7OkmJ60OLkzJxAOSUuytjA
         F+uA==
X-Gm-Message-State: AOAM530JEYIjD1KpHxMtEifQQR4uXe1RtN1xxEYa2aq85dKsW22IOpT/
        UERQ1chKeSO6PhoZbz5N1lsVjQ==
X-Google-Smtp-Source: ABdhPJxBQ70KSlhfE4UBk48wOVO+oTR3dAvGMGkYXZNgophmfDok6SYnNj9+4QpInUFKqraP2ypplA==
X-Received: by 2002:a63:3c16:: with SMTP id j22mr26658462pga.335.1595964018789;
        Tue, 28 Jul 2020 12:20:18 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id e8sm8642552pfd.34.2020.07.28.12.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 12:20:18 -0700 (PDT)
Subject: Re: bdi cleanups v3
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
References: <20200724073313.138789-1-hch@lst.de>
 <0b2b59d4-da4c-33df-82b4-0d4935b91e6e@kernel.dk>
Message-ID: <08ded32a-cf3a-55b0-6a88-19d201edac93@kernel.dk>
Date:   Tue, 28 Jul 2020 13:20:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0b2b59d4-da4c-33df-82b4-0d4935b91e6e@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/28/20 9:41 AM, Jens Axboe wrote:
> On 7/24/20 1:32 AM, Christoph Hellwig wrote:
>> Hi Jens,
>>
>> this series contains a bunch of different BDI cleanups.  The biggest item
>> is to isolate block drivers from the BDI in preparation of changing the
>> lifetime of the block device BDI in a follow up series.
> 
> Applied, thanks.

Dropped:

  CC      block/blk-sysfs.o
block/blk-sysfs.c:608:16: error: ‘blk_throtl_sample_show’ undeclared here (not in a function); did you mean ‘blk_throtl_sample_entry’?
  608 | QUEUE_RW_ENTRY(blk_throtl_sample, "throttle_sample_time");
      |                ^~~~~~~~~~~~~~~~~
block/blk-sysfs.c:563:10: note: in definition of macro ‘QUEUE_RW_ENTRY’
  563 |  .show = _prefix##_show,   \
      |          ^~~~~~~
block/blk-sysfs.c:608:16: error: ‘blk_throtl_sample_store’ undeclared here (not in a function); did you mean ‘blk_throtl_sample_entry’?
  608 | QUEUE_RW_ENTRY(blk_throtl_sample, "throttle_sample_time");
      |                ^~~~~~~~~~~~~~~~~
block/blk-sysfs.c:564:11: note: in definition of macro ‘QUEUE_RW_ENTRY’
  564 |  .store = _prefix##_store,   \
      |           ^~~~~~~
block/blk-sysfs.c:657:3: error: ‘blk_throtl_sample_time_entry’ undeclared here (not in a function); did you mean ‘blk_throtl_sample_time_store’?
  657 |  &blk_throtl_sample_time_entry.attr,
      |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |   blk_throtl_sample_time_store
block/blk-sysfs.c:608:16: warning: ‘blk_throtl_sample_entry’ defined but not used [-Wunused-variable]
  608 | QUEUE_RW_ENTRY(blk_throtl_sample, "throttle_sample_time");
      |                ^~~~~~~~~~~~~~~~~
block/blk-sysfs.c:561:33: note: in definition of macro ‘QUEUE_RW_ENTRY’
  561 | static struct queue_sysfs_entry _prefix##_entry = { \
      |                                 ^~~~~~~
make[1]: *** [scripts/Makefile.build:281: block/blk-sysfs.o] Error 1
make: *** [Makefile:1756: block] Error 2

from "block: add helper macros for queue sysfs entries"

This has not seen a full compile test even...

-- 
Jens Axboe

