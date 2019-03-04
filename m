Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F125BC43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 13:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F302075B
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 13:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="OFxifIP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfCDNAo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:00:44 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39995 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfCDNAn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 08:00:43 -0500
Received: by mail-ed1-f65.google.com with SMTP id 10so4159399eds.7
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 05:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zxi9bPTWXVhtXdHJimGfFzZUt5ClSvDXNOnqHq/G6DE=;
        b=OFxifIP+y5Lz9/dH1X6GK4Z01GFyHvkwOP0XmlTkFo3HFN82LSCrCeqpr36p7FWme9
         aEC92eazOgUP6CZalBSmpsAJdMgaQe+Ii+rZll5YjBrdDCMrY6w7JwC/P015so6m+Aa4
         WKtmstX4ASH7ZEeaV9aM+Znfx2/zKzOY//W3zRV4S9MFnnC0SlBZmUQi+Sdr7vbGHVAT
         0B7PUGkx/ZNBmWqA5LcTxIyavoyzbzwxAP1Tp3Ahx33dMF/UPfCz8TWRwmHoiYOdHUF1
         XgsMIgy8r+TZAYZA8Clle9/KQf1GpGCEl1KC7NMakalU8Ql4ceOvQQzuxiRFIb68OemY
         K0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zxi9bPTWXVhtXdHJimGfFzZUt5ClSvDXNOnqHq/G6DE=;
        b=frilo4X7tVKxbp2IFn0ZKYFJEK9oWUC7A1M9FWOpITxaqoOKEJ9b8tg3c3Eaz57TeI
         /4CGjJoUNwt5irz/YOI/u9ddDznSzYjoYTKwzkD9BkKx3gRhFBXXP8BVtoEHE7P6C1nu
         kYDQs5c0eI9jWYWf0Dxi5K+VPx+HIaHGKMTiKrWXvuEFiGbstStlFO+DsZnGUpuP1jsY
         PqCyp6iarNTAE+7N4GzB2ozDcaxAf3UTqKyXxWFuYCEjlM0aaypN89TlyJ+uGm7NosrH
         1QdnKTdDx84ooXfw/xu31QDMbhe5EoN0vIx06zj2ZwdOREQLw09sMOJUPIGgkUAIeoqc
         fxyQ==
X-Gm-Message-State: APjAAAXWQjRz/eed/I2SyVn+L5joKsDvMzsbECa6OG5CTu7DICUEyrt+
        aXxq3/ggOv7A6Z9pF/nFLpOi79iexck=
X-Google-Smtp-Source: APXvYqzdN02lAh72NJpRYzJQ0astsjd+0W6al7TtZNieLy6mfnrMeRwOUgmTZoN/qiS+wgDwvsHHXg==
X-Received: by 2002:a17:906:d552:: with SMTP id gk18mr12718635ejb.55.1551704441005;
        Mon, 04 Mar 2019 05:00:41 -0800 (PST)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id d42sm2098857ede.30.2019.03.04.05.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 05:00:40 -0800 (PST)
Subject: Re: [PATCH 06/13] lightnvm: pblk: Ensure that erase is chunk aligned
To:     Igor Konopko <igor.j.konopko@intel.com>,
        Hans Holmberg <hans@owltronix.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-7-igor.j.konopko@intel.com>
 <FA2EA171-4AB9-4D9C-A782-4BD416EC7045@javigon.com>
 <CANr-nt1877shJYYkMMwaC2StbrXaOjP7D0OOW5M1rW7LOXu=QQ@mail.gmail.com>
 <EE08736A-168C-4BED-8445-C0CFEDBB61D4@javigon.com>
 <CANr-nt30zr_5sMEAK4Uk7VCRJPWr30zjPUVrQPA_H5kBU-nfrQ@mail.gmail.com>
 <0a0fd388-98c0-f640-e031-1cc7d14372bb@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <387c3a1d-efe7-36c5-6233-f262f27a64a7@lightnvm.io>
Date:   Mon, 4 Mar 2019 14:00:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <0a0fd388-98c0-f640-e031-1cc7d14372bb@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/4/19 1:44 PM, Igor Konopko wrote:
> 
> 
> On 04.03.2019 12:43, Hans Holmberg wrote:
>> On Mon, Mar 4, 2019 at 10:11 AM Javier González <javier@javigon.com> 
>> wrote:
>>>
>>>> On 4 Mar 2019, at 10.05, Hans Holmberg 
>>>> <hans.ml.holmberg@owltronix.com> wrote:
>>>>
>>>> I strongly disagree with adding code that would mask implantation 
>>>> errors.
>>>>
>>>> If we want more internal checks, we could add an if statement that
>>>> would only be compiled in if CONFIG_NVM_PBLK_DEBUG is enabled.
>>>>
>>>
>>> Not sure who this is for - better not to top post.
>>>
>>> In any case, this is a spec grey zone. I’m ok with cleaning the bits as
>>> they mean nothing for the reset command. If you feel that strongly about
>>> this, you can take if with Igor.
>>
>> Pardon the top-post. It was meant for both you and Igor.
>>
> 
> OCSSD 2.0 spec for vector chunk reset (chapter 2.2.2) explicitly says 
> "The addresses in the LBA list shall be the first logical block address 
> of each chunk to be reset.". So in my understanding we suppose to clear 
> the sectors bits of the PPA address in order to be spec compliant.
> 

Agree. And since ppa_addr is allocated on the stack, it should be either 
memset or the remaining fields should be set to 0. Maybe better to zero 
initialize in declaration?

>>>
>>>>
>>>> On Mon, Mar 4, 2019 at 8:48 AM Javier González <javier@javigon.com> 
>>>> wrote:
>>>>>> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> 
>>>>>> wrote:
>>>>>>
>>>>>> In current pblk implementation of erase command
>>>>>> there is a chance tha sector bits are set to some
>>>>>> random values for erase PPA. This is unexpected
>>>>>> situation, since erase shall be always chunk
>>>>>> aligned. This patch fixes that issue
>>>>>>
>>>>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>>>>> ---
>>>>>> drivers/lightnvm/pblk-core.c | 1 +
>>>>>> drivers/lightnvm/pblk-map.c  | 2 ++
>>>>>> 2 files changed, 3 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/lightnvm/pblk-core.c 
>>>>>> b/drivers/lightnvm/pblk-core.c
>>>>>> index a98b2255f963..78b1eea4ab67 100644
>>>>>> --- a/drivers/lightnvm/pblk-core.c
>>>>>> +++ b/drivers/lightnvm/pblk-core.c
>>>>>> @@ -978,6 +978,7 @@ int pblk_line_erase(struct pblk *pblk, struct 
>>>>>> pblk_line *line)
>>>>>>
>>>>>>               ppa = pblk->luns[bit].bppa; /* set ch and lun */
>>>>>>               ppa.a.blk = line->id;
>>>>>> +             ppa.a.reserved = 0;
>>>>>>
>>>>>>               atomic_dec(&line->left_eblks);
>>>>>>               WARN_ON(test_and_set_bit(bit, line->erase_bitmap));
>>>>>> diff --git a/drivers/lightnvm/pblk-map.c 
>>>>>> b/drivers/lightnvm/pblk-map.c
>>>>>> index 79df583ea709..aea46b4ec40f 100644
>>>>>> --- a/drivers/lightnvm/pblk-map.c
>>>>>> +++ b/drivers/lightnvm/pblk-map.c
>>>>>> @@ -161,6 +161,7 @@ int pblk_map_erase_rq(struct pblk *pblk, 
>>>>>> struct nvm_rq *rqd,
>>>>>>
>>>>>>                       *erase_ppa = ppa_list[i];
>>>>>>                       erase_ppa->a.blk = e_line->id;
>>>>>> +                     erase_ppa->a.reserved = 0;
>>>>>>
>>>>>>                       spin_unlock(&e_line->lock);
>>>>>>
>>>>>> @@ -202,6 +203,7 @@ int pblk_map_erase_rq(struct pblk *pblk, 
>>>>>> struct nvm_rq *rqd,
>>>>>>               atomic_dec(&e_line->left_eblks);
>>>>>>               *erase_ppa = pblk->luns[bit].bppa; /* set ch and lun */
>>>>>>               erase_ppa->a.blk = e_line->id;
>>>>>> +             erase_ppa->a.reserved = 0;
>>>>>>       }
>>>>>>
>>>>>>       return 0;
>>>>>> -- 
>>>>>> 2.17.1
>>>>>
>>>>> I’m fine with adding this, but note that there is actually no
>>>>> requirement for the erase to be chunk aligned - the only bits that
>>>>> should be looked at are group, PU and chunk.
>>>>>
>>>>> Reviewed-by: Javier González <javier@javigon.com>

