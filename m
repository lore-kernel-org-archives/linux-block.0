Return-Path: <SRS0=F1yh=7P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB84C433DF
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 22:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23473205CB
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 22:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="l7BGAYSJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgFBWpA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jun 2020 18:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgFBWpA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jun 2020 18:45:00 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18599C08C5C1
        for <linux-block@vger.kernel.org>; Tue,  2 Jun 2020 15:45:00 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j1so14316pfe.4
        for <linux-block@vger.kernel.org>; Tue, 02 Jun 2020 15:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gw+oir9vsdQyfz85spkA2bDQZBuoJ7KvGUAxwG5MV1Q=;
        b=l7BGAYSJdX8YnJAUsyKvom/jK+gebydLglTtY8cwmxlrejMoj4I1tpnmqh6WcCU1xt
         HNBDo6kbhIyp+W15ltqWMxZd/jBTxnrh0LXWX/M7xmcoL1v6vf3Z2GYQsqrivpGUK/SQ
         nHZcLQPLVFvCLuxOM+gNssMB3hTo/lb3xgnruvwKDMKK5G+bjWkr5ms1E60KnBn4BB6V
         hbo1Z8w4+amp5YVwfAFpFWHcAtVyMv4MlL57rtgwT3BqFQpRBJVygid2ZxemFRG8dubu
         jw7saUiaNO9zayf2b8IJKzofGqI7pG/rtJl6kbclBcuthMXwFVNg3cOjKUiA4JUt7rfd
         EjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gw+oir9vsdQyfz85spkA2bDQZBuoJ7KvGUAxwG5MV1Q=;
        b=fQFkpyJ9BFJOGH21xstaRxb+KZQ4BpePIu/PvQEVQU083wwxlqTjOx00y06hlTqnKy
         qYb3XLtXZT2w7VPs3fFRu0hODFaoPTLOI/g22HBaWxba0EsNAM1matMYo1PbWgXorJFm
         r4jGYrLFZ5Sd4SqmVO3PRYI2xPKd2rlJqaozk36hq0/fK9qaNcFLrDtrvekBh2yVFmH4
         0fmIZkz5GlROJvfL20WcrtVwz/9kWKVPQt4N6s2WysvEq8F4pefLJ3ONpazCuiHCbsY4
         S0p9k3aOD97HjfTaQOopaowjQqPTCLKsYk3vvgl6s3F0wI+RikjQ0I+nhASVT5Dwugil
         2JEQ==
X-Gm-Message-State: AOAM531PKflZUOXNd3QPKEyWnjEb0+QspyHA4RkrcTIaOSbA4C+KgiI7
        LKzFC8Fxm8PC5dN2r7YLKp1RPw==
X-Google-Smtp-Source: ABdhPJyvpNttiPHEgxjCiHmykrhKYBCz7667Uw1QR6Vzecz0wrAlKr6MtSY5sFvsOut+/A4a4Ay5Ww==
X-Received: by 2002:aa7:9e4e:: with SMTP id z14mr26404407pfq.227.1591137899395;
        Tue, 02 Jun 2020 15:44:59 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h35sm81928pje.29.2020.06.02.15.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 15:44:58 -0700 (PDT)
Subject: Re: [PATCH] block/bio-integrity: don't free 'buf' if
 bio_integrity_add_page() failed
To:     yu kuai <yukuai3@huawei.com>, ming.lei@redhat.com,
        martin.petersen@oracle.com, wenwen@cs.uga.edu
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20200601123856.3895734-1-yukuai3@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9a4eb4b7-76f2-0b1c-c760-a09a76ee325a@kernel.dk>
Date:   Tue, 2 Jun 2020 16:44:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200601123856.3895734-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/1/20 6:38 AM, yu kuai wrote:
> commit e7bf90e5afe3 ("block/bio-integrity: fix a memory leak bug") add a
> kree() for 'buf' if bio_integrity_add_page() return '0'. However, the
> object will be freed in bio_integrity_free() since 'bio->bi_opf' and
> 'bio->bi_integrity' was set previousy in bio_integrity_alloc().

Applied, thanks.

-- 
Jens Axboe

