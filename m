Return-Path: <SRS0=ap3D=CU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F02EC43461
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 11:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C22EC221E7
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 11:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JUUawHsi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgIKLln (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Sep 2020 07:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgIKLhk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Sep 2020 07:37:40 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447E0C061757
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2020 04:27:31 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x123so7094957pfc.7
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2020 04:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nopPWRCL9i3gw7xBkMwWS/BG6rL2ZcEddtOrNa8g5oc=;
        b=JUUawHsiuQ1bhCa6s3UcN+Zk4MyQWzoHtJmkL8ETjz9kRCwWpcDwZdKyW53o6at0Ci
         Ctc4+Qy5j6RFmGJa33LOfjcWCvCb2UD9GY62CdXbcTDWI72T8g5SxI1yNyDOYt97j7Cj
         IgAikl7VtoCXotfb4tt79OarlHLSCCpCSVxhuGbDXpdCRtl4i657qqLeE4HZGCg0ud/m
         /dxV8VoVk/qic9zjAWeDDsIHo3wLbh8sbbxHeO6yhLa87Y/QDGL0NZEoc3740SfmeZ4W
         t+luW87Unjl96hY+FEU9hWtX3M35PGR/wHs3xQezxHAgIdL0Bhh7z4fK7RpwUE+iF1Uw
         YKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nopPWRCL9i3gw7xBkMwWS/BG6rL2ZcEddtOrNa8g5oc=;
        b=Jb75cgxdj/uN+nEwefnu6c4MXECOX9XB1FJjfBr1zCaba2V+yjHqsJIj9e6/dXNJ1n
         HJV9SiTE2VKyC3UaFFk4ekiH7UPBMYqGq6eDI39fA30aUKK/GJg81uuCkSEljCU7zlCb
         M24wrNxm6Pzdng1bi4KpYeeGN8Q6leOESwQJw37jWInoe/WuRC2m/0joDHkV0L3M+t37
         v7VN321cRxioFE34cFCYezS89aDVdmPdiHkAscRwaRxVk+a10VYQMKxkLcFGlscARTh3
         wUqY/Pkuzu+nJD1KfsHI1KFCXXC/S6RER4lV/QdicO1oudLqOvCGJ2yr4+FMMxy9IWsD
         YQMw==
X-Gm-Message-State: AOAM533r7ek/no5GqJJ9js406T6yktaZ5VsY5XRHeGnSTRRAT8m935GG
        P/+q94Uo4GYNBZmicKGMQawBvA==
X-Google-Smtp-Source: ABdhPJxDzAK04tI9vIIoxKk+Mde2cJFNzvPXiNHGN6t6uAtKklOutcnCavByjnWJtzKNRRJouO/Y0w==
X-Received: by 2002:aa7:948d:0:b029:13e:cb8d:60e0 with SMTP id z13-20020aa7948d0000b029013ecb8d60e0mr1830375pfk.9.1599823650349;
        Fri, 11 Sep 2020 04:27:30 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id i9sm2127839pfq.53.2020.09.11.04.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 04:27:29 -0700 (PDT)
Subject: Re: [PATCH V2] blk-mq: always allow reserved allocation in
 hctx_may_queue
To:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Cc:     Hannes Reinecke <hare@suse.de>,
        David Milburn <dmilburn@redhat.com>,
        "Ewan D . Milne" <emilne@redhat.com>
References: <20200911104114.163691-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <49ca5561-2c61-cd7d-d07e-868d0b31f359@kernel.dk>
Date:   Fri, 11 Sep 2020 05:27:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911104114.163691-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/11/20 4:41 AM, Ming Lei wrote:
> NVMe shares tagset between fabric queue and admin queue or between
> connect_q and NS queue, so hctx_may_queue() can be called to allocate
> request for these queues.
> 
> Tags can be reserved in these tagset. Before error recovery, there is
> often lots of in-flight requests which can't be completed, and new
> reserved request may be needed in error recovery path. However,
> hctx_may_queue() can always return false because there is too many
> in-flight requests which can't be completed during error handling.
> Finally, everything can't move on.
> 
> Fix this issue by always allowing reserved tag allocation in
> hctx_may_queue(). This ways is reasonable because reserved tag
> suppose to be ready any time.

Applied, thanks.

-- 
Jens Axboe

