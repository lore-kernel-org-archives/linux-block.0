Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789CCC636CC
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 13:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjBPNLs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 08:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjBPNLr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 08:11:47 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA19B521FF
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 05:11:43 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id pg6-20020a17090b1e0600b002349579949aso1682754pjb.5
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 05:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1676553103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8xyQD6xgd7ClyN3ylHBH+Ep3cYfAStHeMwkeGyKzlsM=;
        b=gqD21wre8NdQ765n9PLzOUFhfZYhQvcdvxqXjXjWm5R22VGytV9l2ozkKKFKIB2O83
         XCVdj8MULWKU//EneAHO18Cm09gBsDj15JSew+1jcc/PXP+nhDfMz2qcZhs+5SSo59fB
         5smms2OoyEsGTIagl2yGYKeZrAic9UOGmsmdFAq1zPgpb4ThO9vDhtSfPg0DshhUZcgE
         Kq+iR74p4+IFl3OPgf7RIJXg8xhpFekE+Okz9Oa2wdJfiXYmRAEuYrN4JR8aZ4vTyF+o
         e0BPYou1Vi5a0AgeqkCgXq6jcpWaCQdnCcmi5Ax0VRXNnwdmn4bRs1d517kAcjgfkwn+
         n54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676553103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8xyQD6xgd7ClyN3ylHBH+Ep3cYfAStHeMwkeGyKzlsM=;
        b=00KgNWTmUrA6mrVMukfUlIuKt0k1Un02pr74S+88/kxftf17ax0u9CmFFLuhpGL1+w
         aDz232EYwiOqNBl1SYz0Iz21QaNfPutvX/UDsZXc4GORGbz8zQheufh7NYeCs81bflTM
         3cXqrul6jjvfjx7QciNpmRC9d5j6whLeq9Zw7iaro6IUcz55O9M+azVlwYfaA5gLlIlM
         eWR3r52LPmwWGAfV6oBzguAXy0lkOISlqlbJ8lwBJhlWjaxJhTaAyoDMW45s3fT0/9KA
         vyg3PKEW/9DmfB6yhXtpSD9Tkclcoey06fOb3RSMfUD3BL5BtDkp7fMs64+611t29m3B
         ofhQ==
X-Gm-Message-State: AO0yUKWAP/arrL5QtMi0/+sIOqAYj+TxAthN5uhSgFos3aJkV4VAGhNR
        9HRQE9qNgqdJg0DpHo3TtfNMGWuZd4xOKwvK
X-Google-Smtp-Source: AK7set+sCLp2er0uKliZZPKNKhuH3kE4O0Ijzpb1Z8h9EpkO40jtjD4COIcw/QiNXiwxvpA/Agnkww==
X-Received: by 2002:a05:6a20:42a2:b0:be:f5f3:a195 with SMTP id o34-20020a056a2042a200b000bef5f3a195mr6338222pzj.3.1676553102985;
        Thu, 16 Feb 2023 05:11:42 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e22-20020aa78c56000000b005a8f337426esm1272683pfd.67.2023.02.16.05.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 05:11:42 -0800 (PST)
Message-ID: <9a9adcce-81db-580f-843f-ebff7177464c@kernel.dk>
Date:   Thu, 16 Feb 2023 06:11:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] brd: mark as nowait compatible
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <776a5fa2-818c-de42-2ac3-a4588df218ca@kernel.dk>
 <Y+3IUcJLNK8WAkov@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y+3IUcJLNK8WAkov@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/15/23 11:08 PM, Christoph Hellwig wrote:
> On Wed, Feb 15, 2023 at 04:43:47PM -0700, Jens Axboe wrote:
>> By default, non-mq drivers do not support nowait. This causes io_uring
>> to use a slower path as the driver cannot be trust not to block. brd
>> can safely set the nowait flag, as worst case all it does is a NOIO
>> allocation.
> 
> But a NOIO allocation can block.  I think we need to do a
> GFP_NOWAIT allocation in brd_insert_page if the NOWAIT flag is set.

I did consider that, but we do allocations almost everywhere and
as long as we're not waiting on IO, it's mostly considered acceptable.
But I can make that change, no reason not to.

-- 
Jens Axboe


