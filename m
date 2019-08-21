Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCA9C3A5A0
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 11:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7BB22D6D
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 11:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0QAHNOG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfHULmq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 07:42:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41699 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfHULmp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 07:42:45 -0400
Received: by mail-pl1-f195.google.com with SMTP id m9so1192496pls.8;
        Wed, 21 Aug 2019 04:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=TwHGeez/RfJBGCWUFQviRPJubwEqFBJQJB4zD1JJmuc=;
        b=P0QAHNOG6Y+iBFj92LnQFxve4oHsWH/KqJJhCefazh0V65BXiiJGPQ+0X8GsD4Cj8P
         mstqQRlL2UKNEXd78XpiEaQXiwW68wYwTJ7gv/0Ie9PED6gUE8KQFDF5SMe5KQJkvcQ8
         Yz8gMHHXzYJIdB3I6M4CBEn6bfNPcOSpJUscq9GgEPqrnHv8yqv3P0BPIVx9soL9IFH4
         rl3lT4mkLEsbgeHFAugXAjWrYBLer0liGu9Z+Rr2G4BVreI73trQHpqXqe6pdGgf5CJY
         Blcx3DcmQtiJtecTPIMEREiGlhSgDa3L18qh+dxisEbMnIweJHrcv8gFHnaDJT1Pzxyb
         EePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TwHGeez/RfJBGCWUFQviRPJubwEqFBJQJB4zD1JJmuc=;
        b=dFEZqPU98qQM30MLXzEZH/8TyutwFnrM55nq6V5jHzi9RrSKYaDMEmczplSByRTn46
         YaxCYTPnIrvz6mlpyc+JESgxmK1BA45+Y8tjjMLbbiRU7hJ+2wtL6m+/UCbF/SnXKolz
         i/WUMGb6sH/n5r07DZ3fpceTqD/Xpm4mGmK7eIWJ+44DJ8jF1uDg1WAV/1OcycHLQ+qQ
         e5KK/K/NVmB3D5bIuDQW47JNVi8MlusjiVClAHNJWsYsmr0gsQZ6bA/R0T6uvgiMtQT/
         LycNWZ8qMa2UziRD7qMuWgeXErWtv/IxBGSSV0BeWIFQ+OhbYaxy35OrtikR9NPU8bBo
         KpuQ==
X-Gm-Message-State: APjAAAXTo/dFrlO1MislZRyp1GKmrJ0hCG7O2cHr8OMPvca9Na38uBrZ
        YaRGv6Zl0bYxrm2hZm7A/0mYUpMd
X-Google-Smtp-Source: APXvYqxlvNv7fcxtiJHSV6t0CI1seR6gl8Ysv5jSE/N+Lp8uRI/7GyHy2SZu25I7f5K7ORSsRHTdWw==
X-Received: by 2002:a17:902:29e6:: with SMTP id h93mr11888040plb.39.1566387764865;
        Wed, 21 Aug 2019 04:42:44 -0700 (PDT)
Received: from [0.0.0.0] ([47.244.239.6])
        by smtp.gmail.com with ESMTPSA id 185sm25238017pfd.125.2019.08.21.04.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2019 04:42:44 -0700 (PDT)
Subject: Issues about the merge_bvec_fn callback in 3.10 series
To:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org
References: <S1732749AbfE3EBS/20190530040119Z+834@vger.kernel.org>
From:   Jianchao Wang <jianchao.wan9@gmail.com>
Message-ID: <e93566fe-febf-5e99-d3e9-96a0c1f6ba13@gmail.com>
Date:   Wed, 21 Aug 2019 19:42:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <S1732749AbfE3EBS/20190530040119Z+834@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi dear all

This is a question in older kernel versions.

We are using 3.10 series kernel in our production. And we encountered issue as below,

When add a page into a bio, .merge_bvec_fn will be invoked down to the bottom,
and the bio->bi_rw would be saved into bvec_merge_data.bi_rw as the following code,

__bio_add_page
---
	if (q->merge_bvec_fn) {
		struct  bvm = {
			.bi_bdev = bio->bi_bdev,
			.bi_sector = bio->bi_iter.bi_sector,
			.bi_size = bio->bi_iter.bi_size,
			.bi_rw = bio->bi_rw,
		};

		/*
		 * merge_bvec_fn() returns number of bytes it can accept
		 * at this offset
		 */
		if (q->merge_bvec_fn(q, &bvm, bvec) < bvec->bv_len) {
			bvec->bv_page = NULL;
			bvec->bv_len = 0;
			bvec->bv_offset = 0;
			return 0;
		}
	}
---

However, it seems that the bio->bi_rw has not been set at the moment (set by submit_bio), 
so it is always zero.

We have a raid5 and the raid5_mergeable_bvec would always handle the write as read and then
we always get a write bio with a stripe chunk size which is not expected and would degrade the
performance. This is code,

raid5_mergeable_bvec
---
	if ((bvm->bi_rw & 1) == WRITE)
		return biovec->bv_len; /* always allow writes to be mergeable */

	if (mddev->new_chunk_sectors < mddev->chunk_sectors)
		chunk_sectors = mddev->new_chunk_sectors;
	max =  (chunk_sectors - ((sector & (chunk_sectors - 1)) + bio_sectors)) << 9;
	if (max < 0) max = 0;
	if (max <= biovec->bv_len && bio_sectors == 0)
		return biovec->bv_len;
	else
		return max;

---

I have checked   
v3.10.108
v3.18.140
v4.1.49
but there seems not fix for it.

And maybe it would be fixed until 
8ae126660fddbeebb9251a174e6fa45b6ad8f932
block: kill merge_bvec_fn() completely

Would anyone please give some suggestion on this ?
Any comment will be welcomed.

Thanks in advance
Jianchao

