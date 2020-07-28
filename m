Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C20C433E8
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 16:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E29CD2070B
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 16:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Z/LMp3e9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731325AbgG1QZn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731313AbgG1QZn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 12:25:43 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8DEC0619D2
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2020 09:25:42 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id v6so6135335iow.11
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2020 09:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MYT8/3K7R/c49QbezBV5IoadxtpkYqUZBsW74I/Bodo=;
        b=Z/LMp3e9hgnHv/y2/1uciK3aP6hkPDVj/2+kga+pm4sBvwUogma5yUVi7EjxmSiq0s
         y4mmWN0OT92cwabH8ObN26Eqc6Bvq4m+BI7e4nXCq00b/h9A/gavGlUsmj0sBaFkeHet
         jGUJQBGnWgORdiaHk27mg1Efw6KMWcSzTpzGXgQNinC8/yfKrva8LA6PMI4ntPLz/Md5
         cN1YEYjYhm8TwgrM/N9CVTR7aE7/ZVAEqztrMnlIbc+ASgV9YV9uwPIgI34V40N5zztF
         o47SCW6+KLK/qPdCzDAYMhmiY98BPdbUPhrqwPTfMsErfUcD4V98qs8z2amEXizeHX/k
         s2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MYT8/3K7R/c49QbezBV5IoadxtpkYqUZBsW74I/Bodo=;
        b=tIYWCSxK/fdEWNd4zqtdJcyPq9tJBXeQ55EAsX1tKgYxfl/gaj24uEYySkRDlJlMkN
         Y/lHuaSvVl/j8Zj1tjhFN719kYeoDSpdIbXDe3v7lwL9JQNZEMVe9KGLLIYHtJJtRK/V
         3B60eCN/J0b+lTiq8et9TTBrbAc4OEc4TYkELIu8hPoZk4/O8YwaZ/slgAIfYT4EhGk3
         wecQWq1RNsitjyjxh6Yn06klTfX+8hRXvDGp/LqmUJpCLGPBMBRqPsiiY/dre67DRZcy
         Yl14+Pt3rtvnAFdh4K9jY6Bv4U1j5ieNmHQb7mV9WUSEfDArpct0i1WiOWrNh0NxjiRh
         Xajg==
X-Gm-Message-State: AOAM531Y4Q8B3O14paQiGbLtJiEG2FM9blMOglR3e3JBklx9EsIawd/2
        Gn/rUihIL84VXgf6N6NAgE8CGFJjSQ4=
X-Google-Smtp-Source: ABdhPJw8sHeo47ArDKOoHMnkgkespNRtWnRKYH0up0DtDleqyzXsk3UPU+IsEQ13pvkIrpXiPvGVIQ==
X-Received: by 2002:a02:a389:: with SMTP id y9mr5185167jak.82.1595953542342;
        Tue, 28 Jul 2020 09:25:42 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m184sm6240904ioa.12.2020.07.28.09.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 09:25:41 -0700 (PDT)
Subject: Re: [PATCH v1] block: Remove callback typedefs for blk_mq_ops
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200728162036.118211-1-dwagner@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <edd5e5ce-f389-3416-0d9a-929f1f7ab110@kernel.dk>
Date:   Tue, 28 Jul 2020 10:25:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728162036.118211-1-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/28/20 10:20 AM, Daniel Wagner wrote:
> No need to define typedefs for the callbacks, because there is not a
> single user except blk_mq_ops.

v2 I guess, but looks good to me, thanks.

-- 
Jens Axboe

