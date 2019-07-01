Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CAAC0650E
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 16:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F6721479
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 16:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mXpeBrdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbfGAQqQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 12:46:16 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:40078 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfGAQqP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jul 2019 12:46:15 -0400
Received: by mail-io1-f44.google.com with SMTP id n5so30300498ioc.7
        for <linux-block@vger.kernel.org>; Mon, 01 Jul 2019 09:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NABJ8Y8qL/QPLT6ob5dOjHtr1fst4gq36GEeQURKqJk=;
        b=mXpeBrdLN+1Pb/qqnXTe79gjLcPvyKkmbV0kYx8jFE53ewG8Pi/zKuXVCgMuq5kXxs
         XuHeZYJgpf6m5mVQPAV9x4+OOlTs1zVaThIlyR36CDfdVlH0NpsudJXBOipAlHXmlAbw
         NsYWQ/V+01tmVsVwuA68XrvytaqS6lMGNQcMHzzMF/K8RHGUENZa3ZiOgMKaIGnZhd3D
         EkwlDi9IwEBWt7tzQhkWDc1aFT3pbqm8T+FMt2qZS49jU9rUNraz+wE51okvjbgd7oUV
         SmLz7EcMeupc6rPN68AE5L0Wd3n+YwgsH3/qyT6+T8vbM1biNCoYYXOrzV4fJ3JfyrzV
         61OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NABJ8Y8qL/QPLT6ob5dOjHtr1fst4gq36GEeQURKqJk=;
        b=heG6CvbnqrVEuP8O7Uir+fY64pfnAC8yjGJyA3fDCgcUrISKicCq3Ih7Thu/TZCCQo
         wtDUA+A1Krc8+xNwzKIKagXsUUQjjaVsxpiksDtsnaRx+6G1JjpqFforIV7XnEsaruqK
         PYtAMU2PX4gSu1I3RpQR/ygey9UhmkWXXtJfPT48h6XEViBWhnh/Utuam8DuTh4kVKo/
         NzahJzsWkK0TAjKrjer5LoX7WK8pXR6AASZANvEVAUldcpxkUpt39yXkXLIq4BQZsvIM
         te1Iz8Jx7NJ3jp/hLWCYdHngg2S4B/iCq6lr72eslQgqInCsWRCnrMu4+OvrEw6x/tAc
         pPuQ==
X-Gm-Message-State: APjAAAUjtR3nffwVx8y6fzlFKFpRWyDjbGrgKRhtfeL08U+7i2RV+MOR
        1738RJKYLjjXo2l2GMWPJXU7VMzDSkAjhQjE
X-Google-Smtp-Source: APXvYqxtX9BD/WRId8znM8sG+oJXDwMepQ2tTGL4NM1sWEVTBTg+bUR/HqDCJwvzEpvrHhmb9M5XKg==
X-Received: by 2002:a02:b710:: with SMTP id g16mr29677711jam.88.1561999574310;
        Mon, 01 Jul 2019 09:46:14 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e22sm10245869iob.66.2019.07.01.09.46.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 09:46:13 -0700 (PDT)
Subject: Re: remove bi_phys_segments and related cleanups
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org
References: <20190606102904.4024-1-hch@lst.de>
 <a703a5cb-1e39-6194-698a-56dbc4577f25@fb.com>
Message-ID: <bbc9baba-19f2-03ec-59dc-adab225eb3b2@kernel.dk>
Date:   Mon, 1 Jul 2019 10:46:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <a703a5cb-1e39-6194-698a-56dbc4577f25@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/20/19 10:32 AM, Jens Axboe wrote:
> On 6/6/19 4:28 AM, Christoph Hellwig wrote:
>> Hi Jens,
>>
>> this series removes the bi_phys_segments member in struct bio
>> and cleans up various areas around it.> 
> Applied, thanks.

Now that I'm back and can fully go through testing, I run into
problems with this series. On one system, booting up makes it
crash. I've managed to get it to boot, only for the first sync
to make it crash. So seems likely related to a flush.

No console on that system, but that's OK since the trace itself
isn't that interesting. We end up crashing in nvme_queue_rq(),
here:

(gdb) l *nvme_queue_rq+0x252
0xffffffff8148b292 is in nvme_queue_rq (./include/linux/blkdev.h:962).
957	 */
958	static inline struct bio_vec req_bvec(struct request *rq)
959	{
960		if (rq->rq_flags & RQF_SPECIAL_PAYLOAD)
961			return rq->special_vec;
962		return mp_bvec_iter_bvec(rq->bio->bi_io_vec, rq->bio->bi_iter);
963	}

with a NULL pointer dereference at 0x8.

Taking a look at the series, this is the offending commit:

commit 14ccb66b3f585b2bc21e7256c96090abed5a512c
Author: Christoph Hellwig <hch@lst.de>
Date:   Thu Jun 6 12:29:01 2019 +0200

    block: remove the bi_phys_segments field in struct bio

with that as the HEAD, crash. Go back one commit, works fine.

-- 
Jens Axboe
