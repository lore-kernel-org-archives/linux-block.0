Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB5AC46467
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 17:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbjAJRm2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 12:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbjAJRmY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 12:42:24 -0500
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619255E658
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 09:42:16 -0800 (PST)
Received: by mail-pj1-f54.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so17314166pjj.2
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 09:42:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tdlg6j4tQuHi943D1bnrP/kfGJQJ0Oe1JiVqWMd0Eg0=;
        b=eljR0hv2KDOTgFIi79Srgk8qiYITpL36gjf59Jb/24TMwQm3+nZJYPQljcve1JG3x9
         AyLn8rRGi4DhDpJzd25k+a2GYFhITgn707wBC7OhL6en2QWCGLf8uqksYiCIN9CxlR9E
         xbwxDH6G41IRwHkQluS0XocsibDEbp8FXdkPO+MY3JqbmYOkqIDEz27IvR0GRLmmRBAX
         8zwFl4f3BZ03OlB8kwIeD0mWn2Tf03NIl3tZsn/vD+63b2AMFLp39GGXRjmHyH0NsgzF
         50666zcMJ7ctdssX5ZZ2vOdsSJC7/hugALyHRcghEEDxPrI9veqCapc5IqP5Xyx5msjK
         Hgqw==
X-Gm-Message-State: AFqh2kosvAljOVFXsMKXXxa9q+vo4Ehd/MsAc7xOCyadKGyn9XEqPgYM
        j/HxKznoaUPoo/HKRN4Wsnk=
X-Google-Smtp-Source: AMrXdXu7Op7moBEkrN2rqcGMYcdiSzlQYFctpVQ23NxRL/2QShD61kX0yBHl4x68eE9Nsd0r9ZdmjA==
X-Received: by 2002:a17:903:3014:b0:191:1987:9f67 with SMTP id o20-20020a170903301400b0019119879f67mr59668006pla.34.1673372536238;
        Tue, 10 Jan 2023 09:42:16 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:aeba:fdb:7986:a5f9? ([2620:15c:211:201:aeba:fdb:7986:a5f9])
        by smtp.gmail.com with ESMTPSA id j14-20020a170903024e00b0019101215f63sm8450085plh.93.2023.01.10.09.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 09:42:15 -0800 (PST)
Message-ID: <b138485d-9922-3071-9803-f51665874a06@acm.org>
Date:   Tue, 10 Jan 2023 09:42:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 8/8] scsi: ufs: Enable zoned write pipelining
Content-Language: en-US
To:     Avri Altman <Avri.Altman@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20230109232738.169886-1-bvanassche@acm.org>
 <20230109232738.169886-9-bvanassche@acm.org>
 <DM6PR04MB65758465088561BC2632D91AFCFF9@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <DM6PR04MB65758465088561BC2632D91AFCFF9@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/10/23 01:16, Avri Altman wrote:
> Please include scsi lkml as well to allow ufs stakeholders to be aware and comment.

Hi Avri,

I will do that when reposting this patch series.

As you may have noticed, Damien Le Moal plans to implement a new 
approach - a single queue per zoned logical unit for all write commands. 
I will wait with reworking this patch series until that approach has 
been implemented.

Thanks,

Bart.


