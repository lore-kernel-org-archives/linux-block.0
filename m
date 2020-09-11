Return-Path: <SRS0=ap3D=CU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41363C433E2
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 18:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDFDE206F4
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 18:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RWZig3lW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgIKSFu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Sep 2020 14:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgIKSFb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Sep 2020 14:05:31 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327A0C061573
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2020 11:05:30 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id f82so5127666ilh.8
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2020 11:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uYxBs9oh8IzQ8lccaaOwluN8MjJ4R0eXq85ePUW60Vw=;
        b=RWZig3lWG69iU8u/V4NBhqpp88RNlVnvzeRtUwKSc3dTW/x7NTlKDuKFplyuWq3rgm
         1F12UZRhR0YTQf5G0zDBsaJ0cr68ppFOrv8c8ZsbDaiA9+DqKHrAs5akTrJHxyKoKD7l
         4cYxxrTmtIDO7DyviAf7dg1fpNNGMyGwsOxnfxlHq2RiZj/5KaQgD+KJltHmwb/h3qER
         YraLO96fVVpFmwdVD+GAwo+ePNT6TverRjfc259KGTZDfUwKiZaPWAx+mI6PwBxneeqh
         F77nTAQKKvj3LbTvTAB+dlReO1df2ATxY/kr30zTTfwnfh0bnnf2r/8mmpNeIhggEzUw
         5dGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uYxBs9oh8IzQ8lccaaOwluN8MjJ4R0eXq85ePUW60Vw=;
        b=hab8+Hz5XziHsTjbjdioCUqkei6jYEy+2+3q3PY34zcxpAvN3oC6Yd8Ig8eo+9vhvK
         7R7dd70AWSonkcRRfzYs1drLtPYZsmAps8LdIpWPWTAlOuzQPXe8FJ9mwr1k/3ojltsa
         yik0/6bxxk3UDE+0hXu9S+JkMbi5G/HV8HgsULMhbCMZeVKv9Pn4BtR8Avei0bGSLPEu
         joOSljcNZQyRS9Pn2fW3QXHMPK0ULQvXGDjqoK+E2HsmIhh8kuFdpomiH+dLYIrerV21
         ng1UvJK86byWrKsYmBEl/r5Akfw+swC8vqu/0hZ+kn3ybiOV+xl0BmZip/J3u4rlewd9
         ZLKA==
X-Gm-Message-State: AOAM5327wHaN6Td8Kkt4s4hNnLwjgKekar9hpSd34vtXfsmcFVGXVFEX
        Yauz0h4haPY94SYGlGaswX7iBQ==
X-Google-Smtp-Source: ABdhPJxAUft2jW7eFBIb0ujKzO+cmm8v0KkScoPn+IbSxueeqSHx7Z0WkCep0dRDtv2yfkd35JEdjQ==
X-Received: by 2002:a92:194b:: with SMTP id e11mr2754962ilm.43.1599847529979;
        Fri, 11 Sep 2020 11:05:29 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e28sm1660895ill.79.2020.09.11.11.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 11:05:29 -0700 (PDT)
Subject: Re: [PATCH V5 0/4] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
To:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>
References: <20200911024117.62480-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8bb90a44-c088-9b10-8665-ec083063e49c@kernel.dk>
Date:   Fri, 11 Sep 2020 12:05:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911024117.62480-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/10/20 8:41 PM, Ming Lei wrote:
> Hi Jens,
> 
> The 1st patch add .mq_quiesce_mutex for serializing quiesce/unquiesce,
> and prepares for replacing srcu with percpu_ref.
> 
> The 2nd patch replaces srcu with percpu_ref.
> 
> The 3rd patch adds tagset quiesce interface.
> 
> The 4th patch applies tagset quiesce interface for NVMe subsystem.

What is this series against?

-- 
Jens Axboe

