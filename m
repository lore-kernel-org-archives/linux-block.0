Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC24FC76188
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 15:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995652084D
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 15:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfGVPZK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 11:25:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41748 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbfGVPZK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 11:25:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id m30so17546014pff.8
        for <linux-block@vger.kernel.org>; Mon, 22 Jul 2019 08:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9jCVali6gKyIf+iTVA7FGys0/plNy2aSpdO4EPkxFHY=;
        b=jZWISgsl/6NgEd0biIfJ5O2ie9y0BAKLSZMawA6W0yVC4lIJETcVieGLWof8Qzz4Oz
         nKSd667U8Gxx/IDrk6Lm4XJtCJ3RKz7SwWpDlm2Hv6cZQERABsVJ/CGVxzxyTyO/x5N9
         7l78LARVFGLgNsxtMnyj/dUCBaRWDet16bHeENfJonKlbxZXBkyG9VfTzReZyA4dJoep
         LO5yZsf6o8b0XY+D6X+t7AedXd2sLhtM8to4tEdCn0UjKirgckHChoE9GvF52FtkCnfM
         w71Kr1/WPrxkNKOEAnLVlx/SOtYTiLqVdgSxjAlJNDPMqdpYxJ+KvW5IOlTKkp/rvu+u
         Mx2w==
X-Gm-Message-State: APjAAAUJGjYAGupA5HOuE/gUcoTRcKPCZmFxezcXJ7FSGjHSIztlCD0q
        0NQRbUz35g4oZ6V9af8uTdk=
X-Google-Smtp-Source: APXvYqzIStTvg9h7MwNPMWX/s1A/lVS1FdstXi9YHhtd8dwEX5Skqs1eRYLn0XS50glRBzcMKyx//w==
X-Received: by 2002:a17:90a:d343:: with SMTP id i3mr80813836pjx.15.1563809109921;
        Mon, 22 Jul 2019 08:25:09 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id g4sm51862448pfo.93.2019.07.22.08.25.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 08:25:08 -0700 (PDT)
Subject: Re: [PATCH 2/5] blk-mq: introduce
 blk_mq_tagset_wait_completed_request()
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190722053954.25423-1-ming.lei@redhat.com>
 <20190722053954.25423-3-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <c2722892-9cbf-0747-58a8-91a99b72bc53@acm.org>
Date:   Mon, 22 Jul 2019 08:25:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190722053954.25423-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/21/19 10:39 PM, Ming Lei wrote:
> blk-mq may schedule to call queue's complete function on remote CPU via
> IPI, but doesn't provide any way to synchronize the request's complete
> fn.
> 
> In some driver's EH(such as NVMe), hardware queue's resource may be freed &
> re-allocated. If the completed request's complete fn is run finally after the
> hardware queue's resource is released, kernel crash will be triggered.
> 
> Prepare for fixing this kind of issue by introducing
> blk_mq_tagset_wait_completed_request().

An explanation is missing of why the block layer is modified to fix this 
instead of the NVMe driver.

Thanks,

Bart.
