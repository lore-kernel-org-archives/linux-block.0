Return-Path: <SRS0=KeVv=B4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE49C433DF
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 14:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67CC020829
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 14:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Wi5qTeMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgHROu4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgHROut (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Aug 2020 10:50:49 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1D5C061389
        for <linux-block@vger.kernel.org>; Tue, 18 Aug 2020 07:50:48 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so9881330pgf.0
        for <linux-block@vger.kernel.org>; Tue, 18 Aug 2020 07:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AxSVAIDTjxeDoHyUfMnUFBwLfqca7Uti0hu9KCTKI8Q=;
        b=Wi5qTeMdCinEBvRxNWS2z005O7s98JlKjft0mLpCkReytlGjizsMXO22ZZKs3uV4A7
         77OxGM9FAysrxvbOgva4uwf0MoVH0qjD9BU9fabU55NGp2Jbogpywpldx6AiqnHqIHcw
         nSTkkgImJ8cmIAGl3uRJ5qIoVbjNXUtIDSrrXstNr6DbnNaKu/MJclfjwl2jtl7dkDNC
         KTywk7tU4ZbKllo0bPNa7wPp2jogt8e28FrEveXn425yL89YpFQ5eT6lLjTs6OlM8EEd
         qcAvOAvMWVuxFhJ7ANXCw9Mq3C9cEYVP+gAkkJlPItBGL24ggPWJ5hUxP+YcXDnRcBJd
         Ut8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AxSVAIDTjxeDoHyUfMnUFBwLfqca7Uti0hu9KCTKI8Q=;
        b=cZNIV6w25uGUCVd8CEtrpO352nGDpPH2QO0DEA/8WecKYFXrxKG4bHmHJhksYDUtGP
         MZKT+vR62bPZxzsz0vqAq/kQTUTKtmptFIfYo5BNUn0B/JQY7r7g7dABWWOV9FI1UR4v
         sl2Tc4y3+e03iPDmgy1o1jncrfvOjmpi5g7yinS3TLHPMgCboJy84iCZgOyMQPSpwGLB
         FyKc5Dd3wrQl8KIP0YD1EmttbIadu+pE5XgTs0Hvg/DK1MtJkWQ3x1xCT2GWfyQwuGMf
         ZEnqygobTBsJDa64NAyEJNTNTvGJ0EjLTqNt//SLENLvj58KAE+DH8QIJGE1nZ50TfYY
         Xylg==
X-Gm-Message-State: AOAM533Yrm0ChEiecw7YJjjKGtiu2NqXPUqCugmRDLp6Wsi0wFVtQz3q
        dMKiITL2Xs+b+iDI0mxPio10+w==
X-Google-Smtp-Source: ABdhPJzLsoUyCg4+f+IOnRkrMhZhF6KvnwmN87XSXk2pm6pALuxE0RJFJiBizOUZcvamUulfbZhtVQ==
X-Received: by 2002:a63:e018:: with SMTP id e24mr13237714pgh.175.1597762248225;
        Tue, 18 Aug 2020 07:50:48 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:9214:36a5:5cec:a06d? ([2605:e000:100e:8c61:9214:36a5:5cec:a06d])
        by smtp.gmail.com with ESMTPSA id c17sm24530216pfp.214.2020.08.18.07.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 07:50:47 -0700 (PDT)
Subject: Re: [PATCH RESEND] blk-mq: insert request not through ->queue_rq into
 sw/scheduler queue
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <20200818090728.2696802-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <92162ee6-0fa0-dafd-69b1-af285ee61044@kernel.dk>
Date:   Tue, 18 Aug 2020 07:50:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818090728.2696802-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/18/20 2:07 AM, Ming Lei wrote:
> c616cbee97ae ("blk-mq: punt failed direct issue to dispatch list") supposed
> to add request which has been through ->queue_rq() to the hw queue dispatch
> list, however it adds request running out of budget or driver tag to hw queue
> too. This way basically bypasses request merge, and causes too many request
> dispatched to LLD, and system% is unnecessary increased.
> 
> Fixes this issue by adding request not through ->queue_rq into sw/scheduler
> queue, and this way is safe because no ->queue_rq is called on this request
> yet.
> 
> High %system can be observed on Azure storvsc device, and even soft lock
> is observed. This patch reduces %system during heavy sequential IO,
> meantime decreases soft lockup risk.

Applied, thanks Ming.

-- 
Jens Axboe

