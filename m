Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4E1C77B75
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 21:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238565AbjELVbn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 17:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238676AbjELVbn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 17:31:43 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7644EFE
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 14:31:42 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2502f2854b2so1487880a91.0
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 14:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683927101; x=1686519101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R3gC+jvEv5mI0X+Y3TCq4mLeirosB0QpU0Eyfucx/Mw=;
        b=F2EjMalgD/cvHpGevhLJMB7ldrus7eb4rcSDy+/A9yaBLUiw4xk7QTJ1PMVblLjeVd
         s77FYYalJkH6lVcDrVjxYYY9S5cC9vMDUJLzNPKhGr6+pu8kha/6yceZLUeP77gDenB+
         O+BvjUo781jOLCU05G+0ZteSZEJiiz+jTxGbXpbV9deBF8za7bBe0Cayf5s/Prj5Kl41
         lS+JpEftKW4QHnpXqdblXRRYQ7kEYEXfP+IGkyEAr7u/4TGklBzseruCdSyhjK5EoOuF
         h/rlQtACaNQ3zOEGvCPWfIOcznLFqt2dhmcCvKc/EHW9vJVUZnCcvvaMgL9X1svtnveG
         cTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683927101; x=1686519101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R3gC+jvEv5mI0X+Y3TCq4mLeirosB0QpU0Eyfucx/Mw=;
        b=B3RJvGwyB3dxYzj2uSrDYXKXVLEaENpnh1Nm3znkvHajOtXQuMRoEL8IB9KkdZ4xI9
         ps/Kf6VGorNNa8eD6YSDyF7tBuUsweK270NfbeZtrFcCQ8mPMjPXNZkUPIaxwcmWbu1J
         KQnb1DtgzXiYpgxzs4w6rcrf3iosqvjJ6pzDRRz2yOVBwI7BrN9bdNnlsx0ZAKB49DuK
         zCkwZZkqK3u5vqMauSWAFflWQjkY9nAznLWb1FQtRwXglY2pR2PQQC/roVWWTz9rOZtf
         b6Zes47J5JOXl3HawavNFq++vO882m5+gas1jjWz6oBLaVEBnMGnna+odtzM2w5M4EzZ
         0tdA==
X-Gm-Message-State: AC+VfDzAfm+E4NIz9ouji/22vvOqeQHi+V6VVl8G80iYsBKut0k9MtY6
        zWbd3fq4NwndSQQ6IBWxs7Sjow==
X-Google-Smtp-Source: ACHHUZ4uG4x4bqNowT2kbyfcQKjpZt+baPf7UWMKG2IHxdCGFSWStA/Ms7p1sz57/xHaFUSkZHpvkw==
X-Received: by 2002:a17:90b:17c1:b0:252:85ab:41d1 with SMTP id me1-20020a17090b17c100b0025285ab41d1mr8306267pjb.3.1683927101278;
        Fri, 12 May 2023 14:31:41 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y9-20020a170902864900b001acaf7d58fbsm6516735plt.124.2023.05.12.14.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 14:31:40 -0700 (PDT)
Message-ID: <07d74584-1ea3-ef40-f0c7-7bc371fa633e@kernel.dk>
Date:   Fri, 12 May 2023 15:31:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] blk-mq: don't queue passthrough request into scheduler
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        Guangwu Zhang <guazhang@redhat.com>,
        Yu Kuai <yukuai1@huaweicloud.com>
References: <20230512150328.192908-1-ming.lei@redhat.com>
 <70478f95-2852-9bf1-f8f7-630c74641c0f@kernel.dk>
 <ZF5ZB7QWPCF0ZKWN@ovpn-8-16.pek2.redhat.com>
 <b745f17b-088c-a72c-00f2-3c0a13cdead5@kernel.dk>
 <ZF5co5g2XLIw82DK@ovpn-8-16.pek2.redhat.com>
 <ca934bc6-651a-6c96-0598-105cd4a0b500@kernel.dk>
 <ZF6fyc/vFGm56mDO@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZF6fyc/vFGm56mDO@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/12/23 2:21?PM, Christoph Hellwig wrote:
> On Fri, May 12, 2023 at 09:43:32AM -0600, Jens Axboe wrote:
>> We really have two types of passthrough - normal kind of IO, and
>> potential error recovery etc IO. The former can plug just fine, and I
>> don't think we should treat it differently. Might make more sense to
>> just bypass plugging for error handling type of IO, or pt that doesn't
>> transfer any data to avoid having a NULL bio inserted into the
>> scheduler.
> 
> I'd suggest we distinguish by ... having a plug or not.  Anything
> internal like EH or probing should never come from a context with
> a plug.

That's fine for telling error handling, probing etc apart from "normal"
IO, but it doesn't solve the problem at hand which is assuming that
anything inserted into the scheduler has a bio. This is obviously true
for actual IO done via pt, but you can do data less commands through
that too.

-- 
Jens Axboe

