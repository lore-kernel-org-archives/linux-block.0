Return-Path: <SRS0=RRdq=EE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85376C4363A
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 14:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2267B20727
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 14:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IB5rE6UZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgJ2OzA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Oct 2020 10:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgJ2OzA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Oct 2020 10:55:00 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDCDC0613CF
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2020 07:54:59 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id x20so3291219ilj.8
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2020 07:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XFoROk73a/XXJEseX0yuJjHe8vXTqL1xoK95/dOWNqc=;
        b=IB5rE6UZtAb4aoo/uj0PgEbc+yHU1rZ1jJuzLJTbmVqDwKsLAKmJvJopnTbfHJ0m6e
         eE5Ig+6pfIVePjZsnekYXXewGdPaocu4UINfHxr3QGRJCN5TflhO7QNrscogpFIVHIG7
         xAdJ5G/dwQoaQQlZTbomXI/16IkMfQh/LpjdvEtSVax4ABMcbx5mgqjHw0JDKVYOTOSI
         KcvY4QsGTcTNfldqYDE9R2k/eBIbMGKHMNv7RryDPQo1lyQQxM5vKtJz/EymLPprgptw
         mUE+HAUQuQ2COpCqAwHwci/GJhBEIWzpVVrHpcLFMq3T+8HzJ/X2H5RJvbl1+g05gkLf
         /qBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XFoROk73a/XXJEseX0yuJjHe8vXTqL1xoK95/dOWNqc=;
        b=Ste+k31UncLdfpSC0ydxSvtCRC/e59FoWVa6v1n2w2qFs2LnObK3FfqdWFLwSP7GAT
         sPzQQeSdcwAiCruK2EJp1ElTBg0nN20xcJy87hXpC+XYMOc6ixERo8WBbtb23UPfykFL
         8JGNFAjvSrkkPHm/6/SU0RGyM84CIl6URYi7IgVlRn7+cBiw0aqEl401rqmFA4ocuwP5
         CAxD4/Ew87qrgXDognw7YaKEbTLNHS183pclOVRVewQd0SCzfnTaOUFdM0sIX9pfXoL0
         DM4XGrA9206jYH5xwNKIaDF7Zj8fuSn1qeNl69IMx/ulv3GDv+ynMnKvakiM4yTg+q8Y
         w9QQ==
X-Gm-Message-State: AOAM531/NkBVAaMh0+7ZzEKOW19nlY3/ix/vqBUlxPQ5e98zN+CFLYZu
        NtFmlswS5b3HgssWG/gQUn/kMlrsmzmwHQ==
X-Google-Smtp-Source: ABdhPJzH3AtusSBG5TKEe4gJ2Ke6wyh4zCMPLEnAb75Xqr9/wjy5gFAtC0CIvhn64JCFyYFnUXEQhA==
X-Received: by 2002:a92:9907:: with SMTP id p7mr3624323ili.200.1603983299040;
        Thu, 29 Oct 2020 07:54:59 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f12sm2200291iop.45.2020.10.29.07.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 07:54:58 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for 5.10
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20201029144934.GA143642@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <306d09c9-be4c-d535-c397-920b960a265f@kernel.dk>
Date:   Thu, 29 Oct 2020 08:54:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201029144934.GA143642@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/29/20 8:49 AM, Christoph Hellwig wrote:
> The following changes since commit f255c19b3ab46d3cad3b1b2e1036f4c926cb1d0c:
> 
>   blk-cgroup: Pre-allocate tree node on blkg_conf_prep (2020-10-26 07:57:47 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.10-2020-10-29

Pulled, thanks.

-- 
Jens Axboe

