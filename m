Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D3FC433E0
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 18:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20F3920768
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 18:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="X59zaRHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgF3S6U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgF3S6T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 14:58:19 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32CCC061755
        for <linux-block@vger.kernel.org>; Tue, 30 Jun 2020 11:58:19 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id u8so9562275pje.4
        for <linux-block@vger.kernel.org>; Tue, 30 Jun 2020 11:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oDAg2fePJn5vkkApZ2pAJzWecVJU8GVS21IhI4D257Y=;
        b=X59zaRHZLeuwWiwz9/igCzXzHKYGsHc7FSQzAULqb9ZOVkMAnsHhOWtTnnV5uoCdgw
         8yPUIYNuw2zyeAWyGg1EWWi5Gztw/EpXW7Pm2PpL8orwX+0/S/ghpD0Rgh2u9gy5H5lk
         S8+eb8PhHe7e7UG9ckEKZkRDtt8M9c/unI/u/qlhxQfOAwaQTyDZ9aqoSye1bz9C6zvk
         1psS1maGY4aul5VlKfCQ8ovf1iRv6CdChVlIJ2alHmmmFTh/Uoz/XLDiKlj/LOC19svM
         mdaLt9tKd2SWM/C3Y+WxRm8gL79OnQUchY9afC3vx3i1qvmbxr6I4QTBydOjtw46y9EY
         uViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oDAg2fePJn5vkkApZ2pAJzWecVJU8GVS21IhI4D257Y=;
        b=RhDYehp4S9shbSgdwglVbqiWayDO2aAY60jD1KsNQUSIR6xBsxdFInEcU6jmyNdOKi
         +2AIWMPpDv6fgJOOiW6/4KlZJVT7wvdmOWTO/pB6z1slbEUUR5Hch3WkzCuynIRyRReR
         vzaZ4DP/sbz9klDA1Fo+myk5i0KuEVwfVv6AkqG9Fg0NR/Gf1Yke7Ux7OikOFv+p/i0I
         AHltMFdDfuKLgrjTbP5MYSWbb/h3nIpYf1YHBYCtqvEdTpI5IbBIh0kAtOS8jefkWpRe
         Xu3DATXesWG42Wkzl6tIl2FJkpndemehX9amOJZWBQp4kpfy+ObuGGfRgQaJmNwbFOWS
         Zg4Q==
X-Gm-Message-State: AOAM531DRsLbcsdrAmQP3D+b0IKY573Od1tLmTxHFlNbI+jWJo1OLU0T
        /UeSKHtyQCXw2HerjwwAe+3lAw==
X-Google-Smtp-Source: ABdhPJz51DB0CvSW23wYS8agnNwT1n3mpHKrcIcoayJcTQ1Qn6LVR/2aCbfsYXxb0wov0q5t2CD0DA==
X-Received: by 2002:a17:90a:d581:: with SMTP id v1mr23812220pju.33.1593543499360;
        Tue, 30 Jun 2020 11:58:19 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:4113:50ea:3eb3:a39b? ([2605:e000:100e:8c61:4113:50ea:3eb3:a39b])
        by smtp.gmail.com with ESMTPSA id nl8sm3054575pjb.13.2020.06.30.11.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 11:58:18 -0700 (PDT)
Subject: Re: [PATCH V3 0/3] blk-mq: driver tag related cleanup
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <20200630140357.2251174-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <45fcd244-eabd-1214-f934-fee5d5a2c1d3@kernel.dk>
Date:   Tue, 30 Jun 2020 12:58:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200630140357.2251174-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/30/20 8:03 AM, Ming Lei wrote:
> Hi Jens,
> 
> The 1st & 2nd patch moves get/put driver tag helpers into blk-mq.c, and
> the 3rd patch centralise related handling into blk_mq_get_driver_tag,
> so both flush & blk-mq code get simplified.

Applied, thanks.

-- 
Jens Axboe

