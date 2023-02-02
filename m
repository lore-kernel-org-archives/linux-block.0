Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1EFC05027
	for <linux-block@archiver.kernel.org>; Thu,  2 Feb 2023 18:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjBBSDO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Feb 2023 13:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjBBSDN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Feb 2023 13:03:13 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5997976419
        for <linux-block@vger.kernel.org>; Thu,  2 Feb 2023 10:02:52 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id i17so1076965ils.11
        for <linux-block@vger.kernel.org>; Thu, 02 Feb 2023 10:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=61Py2E5UozwXVn3n6QEUGPWLXlAH1Uh9+fZqJDGOGlY=;
        b=7SNY7ay4YrvT8Is9sIQlCa+8sXeYX2dSBODoUv+ho7Z4IfxsR7rRarm9bv/vTFMxDk
         h9FcaF1dxOhFQhR0gvnCF98yPkw5abfHzuDUW8n2QS7JxZsaUy8GgQGz2vG9c/k+t/7E
         VmFBMI2nALH2Hdt+xmde5E+2i65mZ5Qoxf+7MZr9Q67+rxedlKOlovhzjiP1jM+dWsc5
         sWGnqPfvKsn37BLReQEqAXuFEpUs6nuI56XGytGICVsIK8FOZfTy59isrRIjV1lEpEXz
         NyIgoXHdx7p+jQX+qLzRHku4bDz8Oy+tkT1miSDXrhQMYbfH5BkupzmGvRYSo3aZC5qc
         cZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=61Py2E5UozwXVn3n6QEUGPWLXlAH1Uh9+fZqJDGOGlY=;
        b=MtwBIm8eas1OMl4p5Td3848v+TChBSRQ4EOVimG+7g21Mw+2OTd38fWfFrPttjbKLt
         KQeXG0mm2ev/pgmf7mXNOZ+qtqMxJNRia63w8ZIwOp1n1Du/LjL2FS3/hoBfHvsSq2bK
         ihK/WBo9gixwrxRRVz+m36DTL3YMYxXTMh/7BKR8qaVhNFHQ//TI9ttxrvX2a3tk7ccO
         ev4nvLReVC544ulnbn7MQqJvUR2Qk/7ZgGEfL/jy9GdoNdR0MmxujuS+p5oAFbhbUI0B
         uG/pfyPs4lh1biaqhDNsvgdl6lMTRpplhq7qo5GoS2YCSsnCUu2uIJE+jHVd7nmpDhVV
         aBjw==
X-Gm-Message-State: AO0yUKWW1TDwNq76orPgwuN+PRgzdTE4iqKodGun1xa4Px/fKwVqpYjL
        vlwBFKCIEbHRAg/x6aAAfSd3PPeq4WBM6vYO
X-Google-Smtp-Source: AK7set/yfIhv/Oi6OxFfVBHz2pDNxC9HPzPif0jzoxB8LofSxgmdNCc/mer0rLYxwbswollEKKAC/Q==
X-Received: by 2002:a05:6e02:152:b0:310:cc70:a152 with SMTP id j18-20020a056e02015200b00310cc70a152mr4740179ilr.2.1675360971573;
        Thu, 02 Feb 2023 10:02:51 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id q8-20020a056e02106800b00310a599fd43sm91722ilj.46.2023.02.02.10.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 10:02:51 -0800 (PST)
Message-ID: <7607afd6-b26e-a2be-81c2-2d6ee20cc555@kernel.dk>
Date:   Thu, 2 Feb 2023 11:02:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [GIT PULL] nvme fixes for Linux 6.2
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <Y9vVXvMeTgA4bC2R@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y9vVXvMeTgA4bC2R@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/2/23 8:23 AM, Christoph Hellwig wrote:
> The following changes since commit 81ea42b9c3d61ea34d82d900ed93f4b4851f13b0:
> 
>   block: Fix the blk_mq_destroy_queue() documentation (2023-01-31 11:46:15 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.2-2023-02-02
> 
> for you to fetch changes up to bd97a59da6a866e3dee5d2a2d582ec71dbbc84cd:
> 
>   nvme-auth: use workqueue dedicated to authentication (2023-02-01 16:11:20 +0100)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.2
> 
>  - fix a missing queue put in nvmet_fc_ls_create_association (Amit Engel)
>  - clear queue pointers on tag_set initialization failure
>    (Maurizio Lombardi)
>  - use workqueue dedicated to authentication (Shin'ichiro Kawasaki)

Pulled, thanks.

-- 
Jens Axboe


