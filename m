Return-Path: <SRS0=vHgh=AF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8E0C433DF
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 22:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F82E2073E
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 22:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgFXWyO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jun 2020 18:54:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44230 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbgFXWyN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 18:54:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id b6so3863790wrs.11
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2020 15:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=33903KaPiAOi/i63l5Msg94Z9C+lGW9AhLEb2Yr0CGI=;
        b=IC7F6abPbgofGcmue6NaI1zsxxoRrXd166mh/j5/YZ/qB7Av2Z8MopNl1KlMWEsKMI
         XQcgM9+2lQcaRu1TsB1YITW1NUtElcaLUU5WTvlh4nlOGKa8opozZfAeWYBsa+bImZKH
         uTYRIFTS+ACOnl5bU0/w+5MkNpx1KKhRDrOi07btwHkRmOzVb9R7uCeZo3SvQo76VURX
         Kn7KhdXzeDETRZNeuCJxAkoMaCkzwnUfBNbVHd2PBvuQ7jYZiC12n4dNgSkLE6zCC+Cq
         tYOg7qup4XGNO8xCBfhIuOQbX6jPmxnx37ouebLpXt5WgxjHaTBGHO9XAnWcCFvgDd3C
         EmZQ==
X-Gm-Message-State: AOAM532BjJFWV55QBi79L0D/WFcorAr9G3CMVJ6Yj9leq6an4CiAws0v
        NkxiXhiSdC82ejoU4cjcLXA=
X-Google-Smtp-Source: ABdhPJzCWUw8kGbErxQBOztMvbk5ui8rJevdqB8idOw43yREDr8283C2QqGnF10QwDcftrN1JgFjdg==
X-Received: by 2002:a5d:5388:: with SMTP id d8mr25648959wrv.35.1593039250720;
        Wed, 24 Jun 2020 15:54:10 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4c08:474f:e61d:6947? ([2601:647:4802:9070:4c08:474f:e61d:6947])
        by smtp.gmail.com with ESMTPSA id l17sm10028400wmi.16.2020.06.24.15.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 15:54:10 -0700 (PDT)
Subject: Re: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set
 support
To:     Keith Busch <kbusch@kernel.org>
Cc:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Daniel Wagner <dwagner@suse.de>
References: <20200623112551.GB117742@localhost.localdomain>
 <20200623221012.GA1291643@dhcp-10-100-145-180.wdl.wdc.com>
 <b5b7f6bc-22d4-0601-1749-2a631fb7d055@grimberg.me>
 <20200624172509.GD1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <e59e402b-de74-e670-59d1-a6c51680a31d@grimberg.me>
 <20200624180323.GE1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <1ddbf614-f5a7-a265-b1a2-7c5ed0922f18@grimberg.me>
 <76966a48-0588-3f3c-0ec1-842cd2ac413d@grimberg.me>
 <20200624184016.GF1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <06623bef-7269-f45b-9f43-8c854ddf812d@grimberg.me>
 <20200624214916.GG1291930@dhcp-10-100-145-180.wdl.wdc.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c217a3a9-990f-b134-b3d5-ea719d9e2062@grimberg.me>
Date:   Wed, 24 Jun 2020 15:54:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624214916.GG1291930@dhcp-10-100-145-180.wdl.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 6/24/20 2:49 PM, Keith Busch wrote:
> On Wed, Jun 24, 2020 at 12:03:41PM -0700, Sagi Grimberg wrote:
>>
>>>>>> If the controller does not support the CNS value, it may return Invalid
>>>>>> Field with DNR set. That error currently gets propogated back to
>>>>>> nvme_init_ns_head(), which then abandons the namespace. Just as the code
>>>>>> coments say, we had been historically been clearing such errors because
>>>>>> we have other ways to identify the namespace, but now we're not clearing
>>>>>> that error.
>>>>>
>>>>> I don't understand what you are saying Keith.
>>>>>
>>>>> My comment was for this block:
>>>>> -- 
>>>>>        if (!status && nvme_multi_css(ctrl) && !csi_seen) {
>>>>>            dev_warn(ctrl->device, "Command set not reported for nsid:%d\n",
>>>>>                 nsid);
>>>>>            status = -EINVAL;
>>>>>        }
>>>>> -- 
>>>>>
>>>>> I was saying that !status doesn't necessarily mean success, but it can
>>>>> also mean that its an retry-able error status (due to transport or
>>>>> controller). If we see a retry-able error we should still clear the
>>>>> status so we don't abandon the namespace.
>>>>>
>>>>> This for example would achieve that:
>>>
>>> We're not talking about the same thing. I am only talking about what
>>> introduced the DNR check, from commit 59c7c3caaaf87.
>>>
>>> I know you added it because you want to abort comparing identifiers on a
>>> rescan when retrieving the identifiers failed. That's fine, but I am
>>> saying this fails namespace creation in the first place for some types
>>> of devices that used to succeed.
>>
>> OK, now I think I understand (thanks for clarifying that the discussion
>> is not on patch 3/5, but rather on 59c7c3caaaf87).
>>
>> So the original proposal was to check NVME_SC_HOST_PATH_ERROR (and now
>> we have NVME_SC_HOST_ABORTED_CMD) but with the review Christoph gave
>> it seemed to make more sense that we generalize and check the DNR bit.
> 
> Okay, I didn't question this approach when it first went through, so
> sorry about this digression, but I really don't get how this DNR check
> helps at all.
> 
> The code currently returns an error if DNR is set.

Right.

> Based on the commit
> messages, it sounds like you need that error to skip comparing
> identifiers through nvme's scan_work calling revalidate_disk():
> suppressing the error has revalidate_disk() fail with -ENODEV when
> comparing identifiers fails.

Your understanding is correct.

> Since we do return the error when DNR is set, we skip comparing
> identifiers and return blk_status_to_errno(nvme_error_status(ret))
> instead. How is that errno an improvement?

See nvme_revalidate_disk:
out:
         /*
          * Only fail the function if we got a fatal error back from the
          * device, otherwise ignore the error and just move on.
          */
         if (ret == -ENOMEM || (ret > 0 && !(ret & NVME_SC_DNR)))
                 ret = 0;
         else if (ret > 0)
                 ret = blk_status_to_errno(nvme_error_status(ret));
         return ret;

So we don't actually propagate the error back if its a non-DNR (hence
retry-able error). The errno was there before in order to not leak NVMe
errors to the block layer.

> And then if DNR is not set, we suppress the error and proceed with
> comparing identifiers??

Wait, I think that I re-read it it's backwards. The intent was to indeed
clear the error for the DNR case and propagate the error for the non-DNR
case!

The code needs to be:
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2afed32d3892..3e84ab6c2bd3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1130,7 +1130,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl 
*ctrl, unsigned nsid,
                   * Don't treat an error as fatal, as we potentially 
already
                   * have a NGUID or EUI-64.
                   */
-               if (status > 0 && !(status & NVME_SC_DNR))
+               if (status > 0 && (status & NVME_SC_DNR))
                         status = 0;
                 goto free_data;
         }
--

This way, if the controller failed the identify it will be with DNR
status and we will silently ignore, and if the transport failed its
a non-DNR status, and we propagate the status back, skip the id compare,
and then silently ignore the error in nvme_revalidate_disk (as above).

Looking into the original fix we had internally, this was the case, and
got fat-fingered in I can only assume...

Will send a fix right away, good catch keith!
