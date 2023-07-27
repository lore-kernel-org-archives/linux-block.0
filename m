Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A922CC001E0
	for <linux-block@archiver.kernel.org>; Thu, 27 Jul 2023 14:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjG0OxS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jul 2023 10:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbjG0OxI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jul 2023 10:53:08 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970D6F2
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 07:53:07 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1b8b2b60731so5880625ad.2
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 07:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690469587; x=1691074387;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7j0doSYB+krYoA89ohqUV8FcPzSi5ZXUP7M4gytUG3k=;
        b=g+flYLIlValDFftUrTVvkf5wFk13CEIRMP7rMSJadhXd0pDjk//2zzZ6o//z22c968
         lu+KJ34t2/N4zGgN3NfDrYmLiiXNxzglMKZ03Bm6B0dl8iX8DGYSYp4P+8HVRDZg5Vmb
         ykZ0PusV1StnzNqaJ4+DtU9Ecg/JZcvlmjp0Z/RsP8chO4TbVPQfJvRc48hnPHRrtYrQ
         XOldSgw8T0rQBPRWH0XtbE7WbSShDFcu0KgGj1xnRqCZYZPli/76V27qeOlN6lwsZuNk
         xhuDInyAeaZ3F0A2glBpQmPPl2Li9gACbAj/lqlNoG3EPd+ILpUn8YyrPG5Mubv5+kz0
         2H8A==
X-Gm-Message-State: ABy/qLamEk42aXPPEt14gEjFmQB96945xBnesiLJlELWZttjWQVyg4Qf
        UrWOvFf37pDI1ET0qfd04Fg=
X-Google-Smtp-Source: APBJJlEftm8GuUJB7+DAqT7Y3DLjA9HSUsVBw+wPnffa/1+Q2jSR/gRD/QaMzgNKSONMgOKhLMEdYw==
X-Received: by 2002:a17:90a:cb8a:b0:256:807e:6bd with SMTP id a10-20020a17090acb8a00b00256807e06bdmr4214393pju.28.1690469586878;
        Thu, 27 Jul 2023 07:53:06 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:32d2:d535:b137:7ba3? ([2620:15c:211:201:32d2:d535:b137:7ba3])
        by smtp.gmail.com with ESMTPSA id gg7-20020a17090b0a0700b00268062f93e5sm1313645pjb.15.2023.07.27.07.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 07:53:06 -0700 (PDT)
Message-ID: <b89708b0-7e33-2249-71b2-0945ab15dc64@acm.org>
Date:   Thu, 27 Jul 2023 07:53:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 5/7] scsi: Retry unaligned zoned writes
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20230726193440.1655149-1-bvanassche@acm.org>
 <20230726193440.1655149-6-bvanassche@acm.org>
 <c4e4b310-c6c6-e7e7-b5e3-ff44dc63097f@kernel.org>
 <8f2000c0-e9fb-0c7b-5dfa-6807230688a0@acm.org>
 <97122568-61ed-d376-c438-a07880b7db8d@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <97122568-61ed-d376-c438-a07880b7db8d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/26/23 18:09, Damien Le Moal wrote:
> If you could also test the series with zonefs, to hammer it some more that
> would be good (I unfortunately do not have any zoned UFS devices to run that
> myself). You can run zonefs test suite (see
> https://github.com/westerndigitalcorporation/zonefs-tools/tree/master/tests).
> Simply execute "zonefs-tests.sh /dev/sdX" as root and everything should run
> (need zonefs-tools and fio installed).

Running zonefs-tests.sh on an Android device might require a 
considerable amount of work. zonefs-tests.sh is a bash script. Bash is 
not available on Android devices. From 
https://android.googlesource.com/platform/system/core/+/master/shell_and_utilities/README.md:
----------------------------------------------------------------------
Since IceCreamSandwich Android has used mksh as its shell. Before then 
it used ash (which actually remained unused in the tree up to and 
including KitKat).

Initially Android had a very limited command-line provided by its own 
“toolbox” binary. Since Marshmallow almost everything is supplied by 
toybox instead.
----------------------------------------------------------------------

Another challenge is that zonefs-tools depends on at least one header 
file that is not included in the Android NDK (blkid/blkid.h).

Thanks,

Bart.

