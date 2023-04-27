Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86283C7EE23
	for <linux-block@archiver.kernel.org>; Thu, 27 Apr 2023 00:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242742AbjD0A0S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Apr 2023 20:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240740AbjD0A0Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Apr 2023 20:26:16 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D240710FC
        for <linux-block@vger.kernel.org>; Wed, 26 Apr 2023 17:26:13 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-24733b262fdso1098067a91.1
        for <linux-block@vger.kernel.org>; Wed, 26 Apr 2023 17:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682555173; x=1685147173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pC2f2ABxJOBHxHgnHqmtKjhUQyVzc3KlW6W3GSz/0Gg=;
        b=JvCktqP24nhhgrDUAxwg16uA1NBPZy3Mg0Cb5U3uDHaGUIg1ugG9k6j2L7lH6XONlg
         n1aig0vjz6Xsix8DILe8SLqaGygX9Ad1MT+cEmrXlErk4iwVMfZYFYv2U8quUSq2miNJ
         pzOCdjf6hLVIgAWxLU4LVBPSMGQ/UpiHQXRHiXPX1UwYjWO05gcYsMA0V3xhjRfipeOD
         7DDhUV20tJMdehtYy/mRudeD92Z4A+HJRS00zhFe+rC9++Fzz94FVjkl3iCNrUh1FPGt
         Wc2ISVsiTOJ0Pi+6FZYw3t30wJc7DuIWUeuJfkYcOoNfSnNtndrVOwntBtVTF+8Ba8QB
         0eww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682555173; x=1685147173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pC2f2ABxJOBHxHgnHqmtKjhUQyVzc3KlW6W3GSz/0Gg=;
        b=gB3fpn4CQhoFugysXhkpBkd3YB1Yrc4alQ4d8SKlOq8O6xl8J/XXW9t/d2T8BMMq6x
         9M6PLHnuwdnfoYKc1/pZGVJs7wHFPjCwKlvmRjDR9E75HhghaGLGgaMCFiR4yYShmWnU
         Wwf5vdtuY9+ZhH1pzprq+RO/zPHE3jNytX3nzi6s1qD/pQeLSaSucGkWkj+BCDkUxGEK
         OEGXxPZyL1Y6Ay/vL3id/P6NkG1Jii9CL2d9RDrbxSBQk1NCFQm1ZNuUHKdmimyjV8DS
         VtcpjMbV1reaGuNSJGHZuuXybRE6Uxm/0VfsojEmvNQ4/kaS03iCDNwZ15nlY2rG01/u
         I1ew==
X-Gm-Message-State: AC+VfDzNJoXtY8mAbDe9jTGVweLZm+lUbysSCfq2W+f4H3qK26COHRyr
        eqxaLWPEAnIUlCM6DR9R5G5inw==
X-Google-Smtp-Source: ACHHUZ7w/ClANr9wDAfe00y57HJ/0zZxhfkQ8IjHDwnNXp9jcpHLmRdlpBDc/fXziYIoxdo2+12VuQ==
X-Received: by 2002:a17:903:2304:b0:19a:a815:2877 with SMTP id d4-20020a170903230400b0019aa8152877mr669560plh.6.1682555173265;
        Wed, 26 Apr 2023 17:26:13 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id bf9-20020a170902b90900b001a245b49731sm10433474plb.128.2023.04.26.17.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 17:26:12 -0700 (PDT)
Message-ID: <0a57896e-3f61-7761-f03d-e47f0c21be7e@kernel.dk>
Date:   Wed, 26 Apr 2023 18:26:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/3] blk-integrity: drop integrity_kobj from gendisk
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230309-kobj_release-gendisk_integrity-v3-0-ceccb4493c46@weissschuh.net>
 <yq1v8ivtzrn.fsf@ca-mkp.ca.oracle.com>
 <862c1901-ee6e-44e5-8906-4bb1c3893372@t-8ch.de>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <862c1901-ee6e-44e5-8906-4bb1c3893372@t-8ch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/26/23 5:12?PM, Thomas Wei?schuh wrote:
> Hi Martin, Christoph, Jens,
> 
> On 2023-03-20 07:56:58-0400, Martin K. Petersen wrote:
>>> The embedded member integrity_kobj member of struct gendisk violates
>>> the assumption of the driver core that only one struct kobject should
>>> be embedded into another object and then manages its lifetime.
>>>
>>> As the integrity_kobj is only used to hold a few sysfs attributes it
>>> can be replaced by direct device_attributes and removed.
>>
>> Looks good to me and passed a quick test on a couple of systems. Thanks
>> for cleaning this up!
>>
>> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> 
> Am I getting some part of the process for block/ wrong?

Sorry, I missed this series. I'll queue it up for 6.4.

> It seems my patches for the block subsystem are having a hard time
> getting merged.
> 
> * https://lore.kernel.org/all/20221110052438.2188-1-linux@weissschuh.net/

This one is missing nbd review. It's unfortunately not uncommon to need
to re-ping on something like this, if you don't get a timely review.
This is not specific to this patch, just in general. Things get missed.

> * this series
> * https://lore.kernel.org/all/20230419-const-partition-v2-0-817b58f85cd1@weissschuh.net/

This one is just a week old, and coming into the merge window. Generally
takes longer at that time, as it's late for that merge window, and folks
are busy with getting things ready. If nothing happens on this one, I'd
suggest resending past -rc1 when folks are more ready to review and
queue things up for the next release.

-- 
Jens Axboe

