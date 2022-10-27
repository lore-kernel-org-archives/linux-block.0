Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE40BFA3740
	for <linux-block@archiver.kernel.org>; Thu, 27 Oct 2022 21:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbiJ0Vgd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Oct 2022 17:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236925AbiJ0Vgb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2022 17:36:31 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1EF72B44
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 14:36:30 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z14so4345266wrn.7
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 14:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4zUOXl+ydt9ggQeBGTEBYo/+nvhUshlZBtk4vvgeoU0=;
        b=eLIY8/OEf2Rk5EzC0rTJKukYrm+e9afSF6CmUp5vxf0B1fzhyx7PkqzxJ5IxnCBsA0
         kVXUCxQU8hdhlAsPrdPC7I6Y9z/dfnY0J840bAh0T1XbblpcJoTacP51xpAhE/by+mIL
         6cJzrWBJUJwwLxJQCcjwJpQJxOlTnwqA9QulgbpKSyeEL/F2AyHfcvNfhyKEBNzroe39
         nkzoyrRHZsmxpuB/V+gSdxuc9EzDA6QO0qmp+xAoVWLDITbPAhdMFOdRUPeJqeVXN7kv
         ummU8PJkktU6dYZXZaCIoo2wyAmwtF14aP/cujFh0mHGOwqks7DMM6pHlQ2sljOkj3no
         BNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4zUOXl+ydt9ggQeBGTEBYo/+nvhUshlZBtk4vvgeoU0=;
        b=s/wIjzcpQCqt4d+X1rQ+Es+Teyo2yK8qkoOkXwCh81ys2G8fmfY5ze0rcz7YdjSzad
         AIyknwExfYeycf89ixMq5lUGw+kX3XM2BrbMA2uMFf7EZgj4Avl3/1EV3Pd0Um1olL8a
         XRyhoo1FfNL8Otrsg5f6bkM6VyxNqS0L61XPbeBywS74o4zHKHVG7UaLUfScQrFG3LBo
         kQqg+inf7hrQsTYLn1Vy0Wn92+KwFNuX4zwn0xCsi4hPvANtzPTbinKIwMO9Uv10tZsO
         3pwkgE29MvO5KPLgcpnIIRmwqib78ck9xQOYDpjFFaWSXWtbEkatCvHZ5Hpa2OtCriy4
         TBmw==
X-Gm-Message-State: ACrzQf238Xe7eSGyEc96/5ose3BjuvkRVTT0uFZWU3fMAYroCMh5JiaN
        lZu1Lbs/4lemB/1GA5gxq67nAcKGejib7g==
X-Google-Smtp-Source: AMsMyM6HI3g1tscqqOt2FOnqAieXki+0ViN/A9zFeTxPQ3Dk6ix/VJu10X+HgVfrjvcKluGk+28XMA==
X-Received: by 2002:adf:ed01:0:b0:230:d7c8:9a91 with SMTP id a1-20020adfed01000000b00230d7c89a91mr33790635wro.511.1666906588849;
        Thu, 27 Oct 2022 14:36:28 -0700 (PDT)
Received: from [10.10.42.20] (213-205-70-130.net.novis.pt. [213.205.70.130])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c029a00b003c4ecff4e25sm2644529wmk.9.2022.10.27.14.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 14:36:28 -0700 (PDT)
Message-ID: <57d3d732-7fcb-9334-a30b-4bbdfc66bab1@gmail.com>
Date:   Thu, 27 Oct 2022 22:35:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] block: fix bio-allocation from per-cpu cache
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>,
        linux-block@vger.kernel.org
References: <CGME20221027101534epcas5p3b8335c05a1003531f1a4488dc27f27ee@epcas5p3.samsung.com>
 <20221027100410.3891-1-joshi.k@samsung.com>
 <38b863cd-9cec-1300-6d92-a0a5b89b3399@kernel.dk>
 <1620b347-b473-1a8f-136d-a480d641b5d7@gmail.com>
 <f45e0f35-833f-2cae-ca53-86d439a2e2d3@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <f45e0f35-833f-2cae-ca53-86d439a2e2d3@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/27/22 21:52, Jens Axboe wrote:
> On 10/27/22 2:45 PM, Pavel Begunkov wrote:
>> On 10/27/22 21:44, Jens Axboe wrote:
>>> On 10/27/22 4:04 AM, Kanchan Joshi wrote:
>>>> If cache does not have any entry, make sure to detect that and return
>>>> failure. Otherwise this leads to null pointer dereference.
>>>>
>>>> Fixes: 13a184e26965 ("block/bio: add pcpu caching for non-polling bio_put")
>>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>>>> ---
>>>> Can be reproduced by:
>>>> fio -direct=1 -iodepth=1 -rw=randread -ioengine=io_uring -bs=4k -numjobs=1 -size=4k -filename=/dev/nvme0n1 -hipri=1 -name=block
>>>>
>>>> BUG: KASAN: null-ptr-deref in bio_alloc_bioset.cold+0x2a/0x16a
>>>> Read of size 8 at addr 0000000000000000 by task fio/1835
>>>>
>>>> CPU: 5 PID: 1835 Comm: fio Not tainted 6.1.0-rc2+ #226
>>>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g
>>>> Call Trace:
>>>>    <TASK>
>>>>    dump_stack_lvl+0x34/0x48
>>>>    print_report+0x490/0x4a1
>>>>    ? __virt_addr_valid+0x28/0x140
>>>>    ? bio_alloc_bioset.cold+0x2a/0x16a
>>>>    kasan_report+0xb3/0x130
>>>>    ? bio_alloc_bioset.cold+0x2a/0x16a
>>>>    bio_alloc_bioset.cold+0x2a/0x16a
>>>>    ? bvec_alloc+0xf0/0xf0
>>>>    ? iov_iter_is_aligned+0x130/0x2c0
>>>>    blkdev_direct_IO.part.0+0x16a/0x8d0
>>>
>>> Was going to apply this, but after running some testing, it does
>>> fix the initial crash but I still get weird corruption crashes
>>> with the series it's fixing.
>>>
>>> Pavel, I'm going to drop this series for now.
>>
>> I found one yesterday. Is the issue reproducible?
> 
> Oh yeah, triggers in < 1 second for me when running my usual irq
> peak bench:
> 
> t/io_uring -p0 -d128 -b512 -s32 -c32 -F1 -B1 -R0 -X1 -n24 -P1 /dev/nvme0n1 /dev/nvme1n1 /dev/nvme2n1 /dev/nvme3n1 /dev/nvme4n1 /dev/nvme5n1 /dev/nvme6n1 /dev/nvme7n1 /dev/nvme8n1 /dev/nvme9n1 /dev/nvme10n1 /dev/nvme11n1 /dev/nvme12n1 /dev/nvme13n1 /dev/nvme14n1 /dev/nvme15n1 /dev/nvme16n1 /dev/nvme17n1 /dev/nvme18n1 /dev/nvme19n1 /dev/nvme20n1 /dev/nvme21n1 /dev/nvme22n1 /dev/nvme23n1
> 
> Interestingly, doesn't trigger in qemu with just a single device.

The bug I mentioned is splicing from in-IRQ put, which modifies
the non-irq list. We need to hit that ALLOC_CACHE_MAX + ALLOC_CACHE_SLACK
in the cache to trigger it, so makes sense you see it only with
very high qd tests, matches the profile.

I'll resend the patch set with a few changes, but would be great
if you can say if sth like below works for you


diff --git a/block/bio.c b/block/bio.c
index 0686a3774157..af715aee239b 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -764,6 +764,12 @@ static inline void bio_put_percpu_cache(struct bio *bio)
  	struct bio_alloc_cache *cache;
  
  	cache = per_cpu_ptr(bio->bi_pool->cache, get_cpu());
+	if (READ_ONCE(cache->nr_irq) + cache->nr > ALLOC_CACHE_MAX) {
+		put_cpu();
+		bio_free(bio);
+		return;
+	}
+
  	bio_uninit(bio);
  
  	if ((bio->bi_opf & REQ_POLLED) && !WARN_ON_ONCE(in_interrupt())) {
@@ -779,10 +785,6 @@ static inline void bio_put_percpu_cache(struct bio *bio)
  		cache->nr_irq++;
  		local_irq_restore(flags);
  	}
-
-	if (READ_ONCE(cache->nr_irq) + cache->nr >
-	    ALLOC_CACHE_MAX + ALLOC_CACHE_SLACK)
-		bio_alloc_cache_prune(cache, ALLOC_CACHE_SLACK);
  	put_cpu();
  }
  
