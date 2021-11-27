Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8EFC433F5
	for <linux-block@archiver.kernel.org>; Sat, 27 Nov 2021 13:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354943AbhK0NqN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 Nov 2021 08:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbhK0NoM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Nov 2021 08:44:12 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A9AC061748
        for <linux-block@vger.kernel.org>; Sat, 27 Nov 2021 05:40:58 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id w22so15005755ioa.1
        for <linux-block@vger.kernel.org>; Sat, 27 Nov 2021 05:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+C1eCBisUZmPf4XwFZefJXfNuaIvZbpstQOMoYzueNI=;
        b=45LlVGpAa8ZJjwB+km986MoMsAsnUJcUqiqjUEWT0aM29S5ToBEi6XxhmYa5ZejUtX
         qaBOnXSkbku2NutcT2Xjb1O0Qss+sUqAMCs8tzgEkTjOpJGlEgr3+gxLvSCpz7LM/YyA
         ahmPWm9IR+GjUEwNuujbdFUR9s21wbDOVcTOYIKG6Gkslc3nRv4GvAviUqoa1aq0Pt43
         uoGsgp+0V6KZ85RaY7NdXoF85GCfIRmEH+2UeZ2SUZX1sYPpiaBUC/PqN0ObC/kbnj1F
         tOzkUrJB9ab7Ph7krGxN2SDedltJ8jkKgvY00sXTrkAjpJ2vqE9xFkOUR1pGQCCcZ03C
         J5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+C1eCBisUZmPf4XwFZefJXfNuaIvZbpstQOMoYzueNI=;
        b=GVAfgxu1MPJ+bmOnS8KnwKUMDQDj+sdmbO8u5kjBPwcA7O4tlXMIThKTLIxMs414A1
         KkocLYGjRc0vGoJnXCoBmKVRA8vtlwfAu9lNxJkIaQvIf5de1Ho7OjCcjBGaBsvzjQOm
         KtUhoX9p7Xl5eUwVefpAqzxTYzo5OFy9r6dXjJpMFnoQxv/2mQqJrkQ2BLFzoZRJ2ztC
         EV9Ou6gQAuA++UQubJCltm2atfQrdscnvO/xzhHf1YfCq55R02cZOhpSvhrRfJf0vV7z
         +j7+54507bw7GZQbNz8dVdZ0IVX9pTvC/UqQnJWJMiVeT6CEHw8cd20kQ7Utbi5QKntR
         tJRg==
X-Gm-Message-State: AOAM531E+2kBqJEfIZQrjcw15k3KZvVUFfTlvQrbHKOseom25KPYxiNM
        Pu59LjLi9HR7z+97hdkNvQgHYCXK232D6exs
X-Google-Smtp-Source: ABdhPJzLny7SclSJ9Z+WRYPXp3qdAuXW2pq8fNtaLFr9DrbDz5Q/e3rkFakNK9qDd2AZQF9VQB1f1w==
X-Received: by 2002:a05:6602:1513:: with SMTP id g19mr43361702iow.31.1638020457843;
        Sat, 27 Nov 2021 05:40:57 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id y8sm4690925iox.32.2021.11.27.05.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Nov 2021 05:40:57 -0800 (PST)
Subject: Re: remove ->rq_disk v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-block@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-scsi@vger.kernel.org
References: <20211126121802.2090656-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ba3ceb5f-009f-c679-91a5-7d70b0588d02@kernel.dk>
Date:   Sat, 27 Nov 2021 06:40:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211126121802.2090656-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/21 5:17 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series removes the rq_disk field in struct request, which isn't
> needed now that we can get the disk from the request_queue.

Can we get an ack/review on the SCSI change? Would like to pull
this in.

-- 
Jens Axboe

