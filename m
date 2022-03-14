Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9278C433EF
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 17:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbiCNR1V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 13:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234685AbiCNR1S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 13:27:18 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8F83EBB7;
        Mon, 14 Mar 2022 10:26:06 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id n2so14151109plf.4;
        Mon, 14 Mar 2022 10:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JiAEz80uXNjWxHdEaM3dOIOkBrsXYkLwZFYsFCmv7oA=;
        b=0F9PBW6/NN4YtPOC2BMVX+b3VvwJUGJpQiBhnqjPsvxU6s6KWSqpzai8DhGqc8/QHn
         OZn+LdIzG54EqewCS9eJZBEbkgMiTEKAgVpqmr9V7RM1GMp/O7PfaB3AK96YxpvzEiNe
         L63dtmITswebwozttRNgUF5qDT+zNGpCVTSGeGc8dAAiEIMEKrTW8rWP7RBrtyJj3hnE
         Vk3XMd7PEd3r/uKX4HIAc6zGM8Qzwgsi+/LB40FmvT8fPn0UZXcLUrxiG0u3bXtO7fIj
         tOIBI7qP6uwKSz1fm3/xuA5BV03RjDe/tQ62+iOhCTFhFkWivhlPBVr4Cb4HB2jFe1Ca
         p+oQ==
X-Gm-Message-State: AOAM533hSFOuYdpaQ4C+908MBFH9uecnwceY6/F9CK3VnY4aX1AGQx5A
        OQj8EylI6Bcm0RmpnK3FYeY=
X-Google-Smtp-Source: ABdhPJxJYEpiDDkj+9EMvcYJoMCC4h0muPOnrjAXIBQETH0hU2v5FoFoRlLzDDZycpHQhaPDTT/GvA==
X-Received: by 2002:a17:903:22c1:b0:153:6afa:c05e with SMTP id y1-20020a17090322c100b001536afac05emr6741180plg.15.1647278765758;
        Mon, 14 Mar 2022 10:26:05 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:bb55:7e0d:fcdf:716b? ([2620:15c:211:201:bb55:7e0d:fcdf:716b])
        by smtp.gmail.com with ESMTPSA id hk1-20020a17090b224100b001b8cff17f89sm93729pjb.12.2022.03.14.10.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 10:26:05 -0700 (PDT)
Message-ID: <db9ddec3-19c5-2ce4-59b0-614218e27b17@acm.org>
Date:   Mon, 14 Mar 2022 10:26:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] block: release rq qos structures for queue without disk
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        stable@vger.kernel.org,
        syzbot+b42749a851a47a0f581b@syzkaller.appspotmail.com
References: <20220314043018.177141-1-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220314043018.177141-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/13/22 21:30, Ming Lei wrote:
> blkcg_init_queue() may add rq qos structures to request queue, previously
> blk_cleanup_queue() calls rq_qos_exit() to release them, but commit
> 8e141f9eb803 ("block: drain file system I/O on del_gendisk")
> moves rq_qos_exit() into del_gendisk(), so memory leak is caused
> because queues may not have disk, such as un-present scsi luns, nvme
> admin queue, ...
> 
> Fixes the issue by adding rq_qos_exit() to blk_cleanup_queue() back.
> 
> BTW, v5.18 won't need this patch any more since we move
> blkcg_init_queue()/blkcg_exit_queue() into disk allocation/release
> handler, and patches have been in for-5.18/block.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
