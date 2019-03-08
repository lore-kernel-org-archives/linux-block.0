Return-Path: <SRS0=/NKK=RL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF13DC43381
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 18:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCAA320857
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 18:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfCHSmV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:42:21 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45352 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfCHSmU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Mar 2019 13:42:20 -0500
Received: by mail-pg1-f194.google.com with SMTP id 125so14564128pgc.12
        for <linux-block@vger.kernel.org>; Fri, 08 Mar 2019 10:42:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GWk6CdBe3JWqc4fH1gf2qpb1KW1EEm4fCsfduoK2s/0=;
        b=GcQT0DS5gVvMOv1hZPYRLTx2hiSySOHOcar4EREp4iPVQ7od3DKI1l5WLIAi61ukv1
         GOPvzcCupdEw9p4flwqwqqWikEWf0XDd1htwqq5T9GSlNaYxG6lxLKBAbx46vP5Is6H/
         Tcdrqn2kok4Oukyo5aY0D++DODqPaVRyXvDGzEbUC98VEMxLSbZLZwv8UvAawOYP5Rbd
         WbUg4vk9+qqtbPQfuL/7lptY+3gGmy0hscgJkdMu4kCfgEsPmZ/s1CMa4GDGfGBKyt9A
         67Yp5zg8OlV4qR4XB8rk0UZoTHlCu87HMKevvT5MOZFwn3VJjg8XqOgFC+DEyJxukaXR
         Tgzw==
X-Gm-Message-State: APjAAAUOHHGfsSlQVgl0XBhqoWv0dpKqmFkYoyM3NJyvAx6Wzkt5pGEd
        j6l4t7t+p8wga2DEyQMr6Z0=
X-Google-Smtp-Source: APXvYqwH5Ru2l65Ch3+Fh/7g16DZklm4HaKNayyQ1UzlC5xFJ14Lt36bD0+JvwAVyjTwpkd7b8oL+g==
X-Received: by 2002:a63:6c41:: with SMTP id h62mr17659405pgc.371.1552070539462;
        Fri, 08 Mar 2019 10:42:19 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id d26sm11796664pfn.86.2019.03.08.10.42.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 10:42:18 -0800 (PST)
Message-ID: <1552070537.45180.38.camel@acm.org>
Subject: Re: [PATCH 1/5] blk-mq: Export reading mq request state
From:   Bart Van Assche <bvanassche@acm.org>
To:     Keith Busch <keith.busch@intel.com>, t@localhost.localdomain
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Date:   Fri, 08 Mar 2019 10:42:17 -0800
In-Reply-To: <20190308181551.GB5214@localhost.localdomain>
References: <20190308174006.5032-1-keith.busch@intel.com>
         <1552068443.45180.24.camel@acm.org>
         <20190308181551.GB5214@localhost.localdomain>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2019-03-08 at 11:15 -0700, Keith Busch wrote:
+AD4 On Fri, Mar 08, 2019 at 10:07:23AM -0800, Bart Van Assche wrote:
+AD4 +AD4 On Fri, 2019-03-08 at 10:40 -0700, Keith Busch wrote:
+AD4 +AD4 +AD4 Drivers may need to know the state of their requets.
+AD4 +AD4 
+AD4 +AD4 Hi Keith,
+AD4 +AD4 
+AD4 +AD4 What makes you think that drivers should be able to check the state of their
+AD4 +AD4 requests? Please elaborate.
+AD4 
+AD4 Patches 4 and 5 in this series.
+AD4  
+AD4 +AD4 +AD4 diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
+AD4 +AD4 +AD4 index faed9d9eb84c..db113aee48bb 100644
+AD4 +AD4 +AD4 --- a/include/linux/blkdev.h
+AD4 +AD4 +AD4 +-+-+- b/include/linux/blkdev.h
+AD4 +AD4 +AD4 +AEAAQA -241,6 +-241,15 +AEAAQA struct request +AHs
+AD4 +AD4 +AD4  	struct request +ACo-next+AF8-rq+ADs
+AD4 +AD4 +AD4  +AH0AOw
+AD4 +AD4 +AD4  
+AD4 +AD4 +AD4 +-/+ACoAKg
+AD4 +AD4 +AD4 +- +ACo blk+AF8-mq+AF8-rq+AF8-state() - read the current MQ+AF8-RQ+AF8AKg state of a request
+AD4 +AD4 +AD4 +- +ACo +AEA-rq: target request.
+AD4 +AD4 +AD4 +- +ACo-/
+AD4 +AD4 +AD4 +-static inline enum mq+AF8-rq+AF8-state blk+AF8-mq+AF8-rq+AF8-state(struct request +ACo-rq)
+AD4 +AD4 +AD4 +-+AHs
+AD4 +AD4 +AD4 +-	return READ+AF8-ONCE(rq-+AD4-state)+ADs
+AD4 +AD4 +AD4 +-+AH0
+AD4 +AD4 
+AD4 +AD4 Please also explain how drivers can use this function without triggering a
+AD4 +AD4 race condition with the code that modifies rq-+AD4-state.
+AD4 
+AD4 Either queisced or within a timeout handler that already locks the
+AD4 request lifetime.

Hi Keith,

For future patch series submissions please include a cover letter. The two patch
series that you posted today don't have a cover letter so I can only guess what
the purpose of these two patch series is. Is the purpose of this patch series
perhaps to speed up error handling? If so, why did you choose the approach of
iterating over outstanding requests and telling the block layer to terminate
these requests? I think that the NVMe spec provides a more elegant mechanism,
namely deleting the I/O submission queues. According to what I read in the
1.3c spec deleting an I/O submission queue forces an NVMe controller to post a 
completion for every outstanding request. See also section 5.6 in the NVMe
1.3c spec.

Bart.
