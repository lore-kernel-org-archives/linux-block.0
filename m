Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C1CC43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 11:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2872085A
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 11:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="u36FxgH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbfCYLkM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:40:12 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34928 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfCYLkM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 07:40:12 -0400
Received: by mail-ed1-f66.google.com with SMTP id s39so1706110edb.2
        for <linux-block@vger.kernel.org>; Mon, 25 Mar 2019 04:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZXU58uMloxYeTuHYTfwtPTLwXccbqcdXijVAoNFFORQ=;
        b=u36FxgH8OjXcql6ZgmXMmPoAoHdeE4Nd8qaywo7hFTAD9l7QFu0l3vACaC41sr+C73
         fWnAhd6yt7ysYwMse/AfWCvda+oHqHQV7dNQqT0sRNyoU6MkMsAuAnOz9KG1hqjNB60W
         OmF/0B2oTAuqwS1eko95uUMSKfWA6Ww7eF3te97J1UtDuiC5Sbh2T9Ewx3HoHQzNn9+J
         joSE89AWyZNX2FRufPDVPORlIaheOn0wWxXhQJHj2Rqw0wkB+QpOjStOfqGOn2L5WZkR
         O5QL9rR65aibsgY3M0ZsjcLA4a5dpnigkAxcfgIa4+93xF53rj1je0qyKvU+QITAN0iV
         yZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZXU58uMloxYeTuHYTfwtPTLwXccbqcdXijVAoNFFORQ=;
        b=c8CTt8wXvHJxHtJ+U9kNbkiDH8tIaiml6dyx9KWyzCuHBz7pRscpBH66eIFllkIfEw
         qxUptDmjA/ibLZrJpZiqsCX8willNXjntTevjk2pSdZzPeFw72uWbTkhgxt58iO6D8n1
         hMLiox7/TfMgK9KRzvadoxCt2QP/OWC+M3ThHL0kNa2hyHFeQkWwWOWj9n3jQTKTkVce
         gHcqSa0IgUo4+AfSew7GBH11LTouHPOJUJkg9HcVSERLh9h2tNSTGgd0T9bg7VZ6TA8/
         /o9Iec1V+2/t88llB0+BbLCRDdpA4se+K2mIN0tjB4TLR0LsInzVt2+HU/s1tpnOg9Mc
         A5DQ==
X-Gm-Message-State: APjAAAW31M/a1mcmjFYMoiqLpV4LwQZmTOqCxnYAOkmp1GtpPR84kB+x
        frl6SI9bcvHGhGRsuc8sKU5ov1XI/+M=
X-Google-Smtp-Source: APXvYqwswFOy9rGrZtgPFaDahJp+l1GQs4++rINtU/7kvCOBCKIsHSOsZVfg9IBfgOAtVjBX2awn5Q==
X-Received: by 2002:a50:a704:: with SMTP id h4mr6279192edc.7.1553514009716;
        Mon, 25 Mar 2019 04:40:09 -0700 (PDT)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id p1sm4793343eda.29.2019.03.25.04.40.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 04:40:09 -0700 (PDT)
Subject: Re: [PATCH 17/18] lightnvm: allow to use full device path
To:     Igor Konopko <igor.j.konopko@intel.com>
Cc:     Hans Holmberg <hans@owltronix.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-18-igor.j.konopko@intel.com>
 <CANr-nt3poAp1NQmK35=X=mrKgvEJnUHVN_ROxMWB1hrGoZpHdQ@mail.gmail.com>
 <2683438c-2d8d-c450-8b6f-639d0d757185@intel.com>
 <CANr-nt1HbjfxQLvmUrsA9shLmn4_VNOF42JoMV7afvjAtwftFg@mail.gmail.com>
 <001207b7-5b26-2079-b5bf-c8b7de9312e5@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <97a5a15d-8d87-620b-9c7e-14b1f524cb79@lightnvm.io>
Date:   Mon, 25 Mar 2019 12:40:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <001207b7-5b26-2079-b5bf-c8b7de9312e5@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/21/19 2:18 PM, Igor Konopko wrote:
> Matias,
> any opinion from your side, whether you would like to do such a changes 
> in userspace tool or in lightnvm core? I can go both ways.
> Thanks
> Igor

I'm a user-space freak. Let's fix it up in nvme-cli.

> 
> On 18.03.2019 15:41, Hans Holmberg wrote:
>> On Mon, Mar 18, 2019 at 2:18 PM Igor Konopko 
>> <igor.j.konopko@intel.com> wrote:
>>>
>>>
>>>
>>> On 18.03.2019 11:28, Hans Holmberg wrote:
>>>> On Thu, Mar 14, 2019 at 5:11 PM Igor Konopko 
>>>> <igor.j.konopko@intel.com> wrote:
>>>>>
>>>>> This patch adds the possibility to provide full device path (like
>>>>> /dev/nvme0n1) when specifying device on top of which pblk instance
>>>>> should be created/removed.
>>>>>
>>>>> This makes creation of targets from nvme-cli (or other ioctl based
>>>>> tools) more unified with other commands in comparison with current
>>>>> situation where almost all commands uses full device path with except
>>>>> of lightnvm creation/removal parameter which uses just 'nvme0n1'
>>>>> naming convention. After this changes both approach will be valid.
>>>>>
>>>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>>>> ---
>>>>>    drivers/lightnvm/core.c | 23 ++++++++++++++++++-----
>>>>>    1 file changed, 18 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>>>>> index c01f83b..838c3d8 100644
>>>>> --- a/drivers/lightnvm/core.c
>>>>> +++ b/drivers/lightnvm/core.c
>>>>> @@ -1195,6 +1195,21 @@ void nvm_unregister(struct nvm_dev *dev)
>>>>>    }
>>>>>    EXPORT_SYMBOL(nvm_unregister);
>>>>>
>>>>> +#define PREFIX_STR "/dev/"
>>>>> +static void nvm_normalize_path(char *path)
>>>>> +{
>>>>> +       path[DISK_NAME_LEN - 1] = '\0';
>>>>> +       if (!memcmp(PREFIX_STR, path,
>>>>> +                               sizeof(char) * strlen(PREFIX_STR))) {
>>>>> +               /*
>>>>> +                * User provide name in '/dev/nvme0n1' format,
>>>>> +                * so we need to skip '/dev/' for comparison
>>>>> +                */
>>>>> +               memmove(path, path + sizeof(char) * 
>>>>> strlen(PREFIX_STR),
>>>>> +                       (DISK_NAME_LEN - strlen(PREFIX_STR)) * 
>>>>> sizeof(char));
>>>>> +       }
>>>>> +}
>>>>> +
>>>>
>>>> I don't like this. Why add string parsing to the kernel? Can't this
>>>> feature be added to the nvme tool?
>>>
>>> Since during target creation/removal in kernel, we already operate on
>>> strings multiple times (strcmp calls for target types, nvme device,
>>> target names) my idea was to keep this in the same layer too.
>>
>> Oh, pardon the terse and rather grumpy review. Let me elaborate:
>>
>> String parsing is best avoided when possible, and i don't think it's
>> worth increasing the kernel code size and changing the behavior of the
>> IOCTL when its fully doable to do this in userspace.
>>
>> Thanks,
>> Hans
>>
>>>
>>>>
>>>>>    static int __nvm_configure_create(struct nvm_ioctl_create *create)
>>>>>    {
>>>>>           struct nvm_dev *dev;
>>>>> @@ -1304,9 +1319,9 @@ static long nvm_ioctl_dev_create(struct file 
>>>>> *file, void __user *arg)
>>>>>                   return -EINVAL;
>>>>>           }
>>>>>
>>>>> -       create.dev[DISK_NAME_LEN - 1] = '\0';
>>>>> +       nvm_normalize_path(create.dev);
>>>>> +       nvm_normalize_path(create.tgtname);
>>>>>           create.tgttype[NVM_TTYPE_NAME_MAX - 1] = '\0';
>>>>> -       create.tgtname[DISK_NAME_LEN - 1] = '\0';
>>>>>
>>>>>           if (create.flags != 0) {
>>>>>                   __u32 flags = create.flags;
>>>>> @@ -1333,7 +1348,7 @@ static long nvm_ioctl_dev_remove(struct file 
>>>>> *file, void __user *arg)
>>>>>           if (copy_from_user(&remove, arg, sizeof(struct 
>>>>> nvm_ioctl_remove)))
>>>>>                   return -EFAULT;
>>>>>
>>>>> -       remove.tgtname[DISK_NAME_LEN - 1] = '\0';
>>>>> +       nvm_normalize_path(remove.tgtname);
>>>>>
>>>>>           if (remove.flags != 0) {
>>>>>                   pr_err("nvm: no flags supported\n");
>>>>> @@ -1373,8 +1388,6 @@ static long nvm_ioctl_dev_factory(struct file 
>>>>> *file, void __user *arg)
>>>>>           if (copy_from_user(&fact, arg, sizeof(struct 
>>>>> nvm_ioctl_dev_factory)))
>>>>>                   return -EFAULT;
>>>>>
>>>>> -       fact.dev[DISK_NAME_LEN - 1] = '\0';
>>>>> -
>>>>>           if (fact.flags & ~(NVM_FACTORY_NR_BITS - 1))
>>>>>                   return -EINVAL;
>>>>>
>>>>> -- 
>>>>> 2.9.5
>>>>>

