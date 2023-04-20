Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF051C7618E
	for <linux-block@archiver.kernel.org>; Thu, 20 Apr 2023 22:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjDTWvx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Apr 2023 18:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbjDTWvw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 18:51:52 -0400
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7031A3C3A
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 15:51:48 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-63b5c48ea09so1468713b3a.1
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 15:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682031108; x=1684623108;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MTp1fiEdcOg+/2l408Q2pDdeOBR6vItaeXWMAKrYvTc=;
        b=aqpXUnHOdOPa6yS1+u1pn28m2Ay8/K3phRmA95R24zvmAfUNXzoAniWgYMg3IKXaTY
         VUE+o78fSNm1ttpmVMAtAafYvUEKo+RHr4DbDXAb0h3CJvT9lwgmwlin0hdFilEbJN8Q
         jmlwWtRRqtWkFyg7jxoNi/LuQoy1XeVbySHw5jhcYVf82aCYgO5Yhn1KOSn4eP74ADmp
         BnwOuMJQPRVDFEuxNNdBuykeeAHK3vvyAT17enmY/Ch7krioU49k3NVkhK3NVwFrS3Eo
         fOVOe4vkY/+i4m5zeYG8HX3kB3tHuj2QzTbmJ+s8r/uah/HcE+4Nw2fxHF0Sxj3P+wG+
         UsVQ==
X-Gm-Message-State: AAQBX9f4rtuUiF+P5JBRLUY6VCeQUiRKomhIYtPG0rkrosww70ilp00V
        WH1VuX1UrisE3zX7ww5Y+YUYiLaNYj0=
X-Google-Smtp-Source: AKy350a7kJln3Id2mahCWhj7q0c4XlakGEuEBBtEGSuw+dVp4YCOMY6Zz3gIZXC0OreLuuXQd6k0eA==
X-Received: by 2002:a05:6a00:2193:b0:63d:27a1:d578 with SMTP id h19-20020a056a00219300b0063d27a1d578mr3437504pfi.20.1682031107675;
        Thu, 20 Apr 2023 15:51:47 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id p14-20020aa79e8e000000b006258dd63a3fsm1741652pfq.56.2023.04.20.15.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 15:51:47 -0700 (PDT)
Message-ID: <ec7cdc7d-9eb7-65a4-6ba9-1ae6cf6f43d2@acm.org>
Date:   Thu, 20 Apr 2023 15:51:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 10/11] block: Add support for the zone capacity concept
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>,
        Niklas Cassel <nks@flawful.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Matias Bjorling <mb@lightnvm.io>
References: <20230418224002.1195163-1-bvanassche@acm.org>
 <20230418224002.1195163-11-bvanassche@acm.org> <ZEEEm/5+i7x2i8a5@x1-carbon>
 <f9d35d19-d0ba-fcb7-e44b-f0b8c55ba399@acm.org>
 <141aee35-4288-1670-6424-e6c41c8ef4c9@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <141aee35-4288-1670-6424-e6c41c8ef4c9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/20/23 15:00, Damien Le Moal wrote:
> On 4/21/23 02:12, Bart Van Assche wrote:
>> On 4/20/23 02:23, Niklas Cassel wrote:
>>> With your change above, we would start rejecting such devices.
>>>
>>> Is this reduction of supported NVMe ZNS SSD devices really desired?
>>
>> Hi Niklas,
>>
>> This is not my intention. A possible solution is to modify the NVMe
>> driver and SCSI core such that the "zone is full" information is stored
>> in struct request when a command completes. That will remove the need
>> for the mq-deadline scheduler to know the zone capacity.
> 
> I am not following... Why would the scheduler need to know the zone capacity ?
> 
> If the user does stupid things like accessing sectors between zone capacity and
> zone size or trying to write to a full zone, the commands will be failed by the
> drive and I do not see why the scheduler need to care about that.

Hi Damien,

Restricting the number of active zones in the I/O scheduler (patch 
11/11) requires some knowledge of the zone condition.

According to ZBC-2, for sequential write preferred zones the additional 
sense code ZONE TRANSITION TO FULL must be reported if the zone 
condition changes from not full into full. There is no such requirement 
for sequential write required zones. Additionally, I'm not aware of any 
reporting mechanism in the NVMe specification for changes in the zone 
condition.

The overhead of submitting a REPORT ZONES command after every I/O 
completion would be unacceptable.

Is there any other solution for tracking the zone condition other than 
comparing the LBA at which a WRITE command finished with the zone capacity?

Did I perhaps overlook something?

Thanks,

Bart.
