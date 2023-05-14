Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424B0C7EE22
	for <linux-block@archiver.kernel.org>; Sun, 14 May 2023 14:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbjENONs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 May 2023 10:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237522AbjENONf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 May 2023 10:13:35 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC7846AC
        for <linux-block@vger.kernel.org>; Sun, 14 May 2023 07:12:58 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-7591797c638so174844985a.1
        for <linux-block@vger.kernel.org>; Sun, 14 May 2023 07:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684073576; x=1686665576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gH7nIMsPMfvbcBQe1FKo7W07N3vaxNPLcY75FzAAvRI=;
        b=TxPYKjYpYeX0PWM+HXPOGTqM3+zAoSwgMccqP/rlxpK7GpNTj7HjNw4fTDw1KPHaaQ
         1oX9HhpMzJ+sDa0G9KNXEKraZ3tXHz/UGmjxJih5+HcomNfCU7ie9qwvNly5ogI2kxZN
         nI/zquQdjKHsw6nF5GfBpb1g3BAiWPW8OS5iF8Bja2BN0srXTsu/egxY5rIRnTsBrQ52
         N4GCSd1MP4M16nQx63ySaVV/ePjgS+dH2jfjbcErcsXseWCWA95RnT7ZI/tCbdValipP
         YCI1bZjliU/c9wi/zPcFYgh5pY7HEBcfWqcnKWjGYDoh4eX4N7hQFhPxVDvuZ6xnWDK8
         kDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684073576; x=1686665576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gH7nIMsPMfvbcBQe1FKo7W07N3vaxNPLcY75FzAAvRI=;
        b=EvM758agVJqs/LivtP9x+C3Dnxtuia3x68vTdaIpNW3rGcSbUs2iOfdU8RhrfESPJ1
         SP1Df1kPM86i0nHp4uXyMYItCgcmRtObu7C1YY30euzVOdD063WUTMKrvSbP7XXWdu0I
         PGqduoZ6Ge1cSaqe0RVOMBHOVQPI0CU8HMdIqbLdBs+j5PrJebnPozD9C8OwJBi0zHgc
         jq1w1bQJa/fpeXtak1JENpJZWDTC4rxr/ijg1EWyEzkQ+7wMxZquPQmhp7EAzl6MtJKK
         QNms86hkd4+p9oBasOsoL5Y51SXP1JB2PeEegftatD8hx1MZJ+k7daVgwtY/o7Vq+4GX
         JrOg==
X-Gm-Message-State: AC+VfDwWUKYkx5i5uJ46nKaocrdD6H+ok8tR61M0qbMvfPN8sOGVKEg5
        UFqOHeEyJL9S4hYCdQGQa5k=
X-Google-Smtp-Source: ACHHUZ6O43fvm2gMbSD3fGWK7+wgkcYLJVfHvO5PgUqJl/aibtjQhBxoZFBHII06xa87r4frh8MwQw==
X-Received: by 2002:a05:6214:1250:b0:5e3:d150:3163 with SMTP id r16-20020a056214125000b005e3d1503163mr56459925qvv.20.1684073576006;
        Sun, 14 May 2023 07:12:56 -0700 (PDT)
Received: from tian-Alienware-15-R4.fios-router.home (pool-173-77-254-84.nycmny.fios.verizon.net. [173.77.254.84])
        by smtp.gmail.com with ESMTPSA id fe14-20020a0562140b8e00b005dd8b9345besm4305227qvb.86.2023.05.14.07.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 07:12:55 -0700 (PDT)
From:   Tian Lan <tilan7663@gmail.com>
To:     ming.lei@redhat.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, lkp@intel.com,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        tian.lan@twosigma.com, tilan7663@gmail.com
Subject: Re: [PATCH 1/1] blk-mq: fix blk_mq_hw_ctx active request accounting
Date:   Sun, 14 May 2023 10:12:54 -0400
Message-Id: <20230514141254.595099-1-tilan7663@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZGDPLEtUiDeIrCyl@ovpn-8-17.pek2.redhat.com>
References: <ZGDPLEtUiDeIrCyl@ovpn-8-17.pek2.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

> > kprobe output showing RQF_MQ_INFLIGHT bit is not cleared before
> > __blk_mq_free_request being called.

> RQF_MQ_INFLIGHT won't be cleared when the request is freed normally
> from blk_mq_free_request().

Yes you are correct, maybe I should capture both rq->rq_flags and 
rq->state so we know for sure if either of blk_mq_free_request or 
__blk_mq_put_driver_tag was being called before hitting __blk_mq_free_request.


> >          b'__blk_mq_free_request+0x1 [kernel]'
> >          b'bt_iter+0x50 [kernel]'
> >          b'blk_mq_queue_tag_busy_iter+0x318 [kernel]'
> >          b'blk_mq_timeout_work+0x7c [kernel]'
> >          b'process_one_work+0x1c4 [kernel]'
> >          b'worker_thread+0x4d [kernel]'
> >          b'kthread+0xe6 [kernel]'
> >          b'ret_from_fork+0x1f [kernel]'

> If __blk_mq_free_request() is called from timeout, that means this
> request has been freed by blk_mq_free_request() already, so __blk_mq_dec_active_requests
> should have been run.

We are also seeing a different call stack that could also potentially by-pass 
__blk_mq_dec_active_requests. Do you think they could be caused by the same 
underlying issue.

1976    2000    collectd    __blk_mq_free_request rq_flags 0x620c0 in-flight 1
        b'__blk_mq_free_request+0x1 [kernel]'
        b'bt_iter+0x50 [kernel]'
        b'blk_mq_queue_tag_busy_iter+0x318 [kernel]'
        b'blk_mq_in_flight+0x35 [kernel]'
        b'diskstats_show+0x205 [kernel]'
        b'seq_read_iter+0x11f [kernel]'
        b'proc_req_read_iter+0x4a [kernel]'
        b'vfs_read+0x239 [kernel]'
        b'ksys_read+0xb [kernel]'
        b'do_syscall_64+0x58 [kernel]'
        b'entry_SYSCALL_64_after_hwframe+0x63 [kernel]'


> However, one case is that __blk_mq_dec_active_requests isn't called in
> blk_mq_end_request_batch, so maybe your driver is nvme with multiple
> NSs, so can you try the following patch?

Yes, we are using nvme driver with multiple NSs. 

I can test this patch and will update you on the results. I'm just curious 
shouldn't the counter be subtracted via __blk_mq_sub_active_requests when 
blk_mq_flush_tag_batch is invoked in that case. Then this would result in 
double counting, is that correct.


Thanks,
Tian
