Return-Path: <SRS0=FzxQ=5P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57330C43331
	for <linux-block@archiver.kernel.org>; Mon, 30 Mar 2020 09:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D4120733
	for <linux-block@archiver.kernel.org>; Mon, 30 Mar 2020 09:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMKQ0I32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgC3JPq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Mar 2020 05:15:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46391 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbgC3JPq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Mar 2020 05:15:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id k191so8363069pgc.13
        for <linux-block@vger.kernel.org>; Mon, 30 Mar 2020 02:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=fzTGHkyQjMKq4T54Wszt38MMnDiOdS3GcEbQBAx+SC8=;
        b=LMKQ0I32SgI9aIxHnTS/41xNTTBVCMnFoGlF3Db0CaUoaXGRqBI/4ZEmVpFBxRedep
         aaqQhxu9ziTICWdlUadZ8WBT0OYziUU0H4P1ZmLYOCPB6ZsZMmO86ijk3anOQEBcJJVZ
         38QiuuM0jb8UcVzBk+XtTH7QUCKZ11gsaFQsymoe4uD+UuGbViOzETodSqu6lJEmWMr1
         H+RaSumEuX+Nl45Id7uNywum8p/67BpEZEpBncpwvGa7l3SrffkNajXKh9PLcySqBXAD
         aEgVu/NLF/zo2K5mbsm2UauyRQs5KXA99WujOOpUBZ9+4TeipiDj1+QnE2DMTgp6e+n9
         67zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fzTGHkyQjMKq4T54Wszt38MMnDiOdS3GcEbQBAx+SC8=;
        b=m2n7yZFLRJEPnn4EMXYVhX3y1w0EDH/HoXWoPv4E6Np2C5Tiyw0OCVmO4pbTnJj6B3
         tViAY8ELSBHmAlgFv856Rd9GXzM6YEpraP0in9V6k+v3+U4jElL95T5LYo02NWm5NReK
         Nk+qXndMS5uNrR/rUXxa0QcxzO4da+7Z3xqvO3c3yK2V5zxlDbZBdfonriO157oA5bSI
         3RQkue/xeVQDcd1/xyGrssdfkYwZahuibHl+joe3Estwke+fopJJlKzGHpEAIkRrcT8B
         lRAhYpVHMjNMhkS5NOhF5/f1brzGqG/3pv0/adLMM68hfmO9smfpQX4bSVwb7xpA+Euj
         2xXg==
X-Gm-Message-State: ANhLgQ32kTGMvoCVGP7ZJUv3+ZBQemhS/hSz3u+SOQsvdzTbNyzZWgqV
        QoQiBEL8e+VsKpXEoFmIMQ0=
X-Google-Smtp-Source: ADFU+vt7tWn4gQIFf6ULfVVFXuAZXobPiToyhTDJUU21swxV4wp+IPR/j1GjUpkS0gVd+tWmVabEMQ==
X-Received: by 2002:a63:1547:: with SMTP id 7mr11635842pgv.353.1585559744702;
        Mon, 30 Mar 2020 02:15:44 -0700 (PDT)
Received: from ?IPv6:240b:10:2720:5510:a182:288:3ffa:432a? ([240b:10:2720:5510:a182:288:3ffa:432a])
        by smtp.gmail.com with ESMTPSA id a127sm9765594pfa.111.2020.03.30.02.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2020 02:15:44 -0700 (PDT)
Subject: Re: [PATCH] block, nvme: Increase max segments parameter setting
 value
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20200323182324.3243-1-ikegami.t@gmail.com>
 <BYAPR04MB4965BAF4C0300E1206B049A586F00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <cff52955-e55c-068a-44a6-8ed4edc0696f@gmail.com>
 <20200324000237.GB15091@redsun51.ssa.fujisawa.hgst.com>
 <6b73db44-ca3f-4285-0c91-dc1b1a5ca9f1@gmail.com>
 <dc3a3e88-f062-b7df-dd18-18fb76e68e0c@gmail.com>
 <20200327181825.GA8356@redsun51.ssa.fujisawa.hgst.com>
 <CACVXFVM=rT=86JrmAkySTg=gknfFL8Q1NU0uXWzoDMKMyL_mow@mail.gmail.com>
 <a0e7a985-a726-8e16-d29c-eb38a919e18e@gmail.com>
 <CACVXFVMsPstD2ZLnozC8-RsaJ7EMZK9+d47Q+1Z0coFOw3vMhg@mail.gmail.com>
From:   Tokunori Ikegami <ikegami.t@gmail.com>
Message-ID: <cc1534d1-34f6-ffdb-27bd-73590ab30437@gmail.com>
Date:   Mon, 30 Mar 2020 18:15:41 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVMsPstD2ZLnozC8-RsaJ7EMZK9+d47Q+1Z0coFOw3vMhg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 2020/03/29 12:01, Ming Lei wrote:
> On Sat, Mar 28, 2020 at 8:57 PM Tokunori Ikegami <ikegami.t@gmail.com> wrote:
>> Hi,
>>
>> On 2020/03/28 11:11, Ming Lei wrote:
>>> On Sat, Mar 28, 2020 at 2:18 AM Keith Busch <kbusch@kernel.org> wrote:
>>>> On Sat, Mar 28, 2020 at 02:50:43AM +0900, Tokunori Ikegami wrote:
>>>>> On 2020/03/25 1:51, Tokunori Ikegami wrote:
>>>>>> On 2020/03/24 9:02, Keith Busch wrote:
>>>>>>> We didn't have 32-bit max segments before, though. Why was 16-bits
>>>>>>> enough in older kernels? Which kernel did this stop working?
>>>>>> Now I am asking the detail information to the reporter so let me
>>>>>> update later.  That was able to use the same command script with the
>>>>>> large data length in the past.
>>>>> I have just confirmed the detail so let me update below.
>>>>>
>>>>> The data length 20,531,712 (0x1394A00) is used on kernel 3.10.0 (CentOS
>>>>> 64bit).
>>>>> Also it is failed on kernel 10 4.10.0 (Ubuntu 32bit).
>>>>> But just confirmed it as succeeded on both 4.15.0 (Ubuntu 32bit) and 4.15.1
>>>>> (Ubuntu 64bit).
>>>>> So the original 20,531,712 length failure issue seems already resolved.
>>>>>
>>>>> I tested the data length 0x10000000 (268,435,456) and it is failed
>>>>> But now confirmed it as failed on all the above kernel versions.
>>>>> Also the patch fixes only this 0x10000000 length failure issue.
>>>> This is actually even more confusing. We do not support 256MB transfers
>>>> within a single command in the pci nvme driver anymore. The max is 4MB,
>>>> so I don't see how increasing the max segments will help: you should be
>>>> hitting the 'max_sectors' limit if you don't hit the segment limit first.
>>> That looks a bug for passthrough req, because 'max_sectors' limit is only
>>> checked in bio_add_pc_page(), not done in blk_rq_append_bio(), something
>>> like the following seems required:
>>>
>>> diff --git a/block/blk-map.c b/block/blk-map.c
>>> index b0790268ed9d..e120d80b75a5 100644
>>> --- a/block/blk-map.c
>>> +++ b/block/blk-map.c
>>> @@ -22,6 +22,10 @@ int blk_rq_append_bio(struct request *rq, struct bio **bio)
>>>           struct bio_vec bv;
>>>           unsigned int nr_segs = 0;
>>>
>>> +       if (((rq->__data_len + (*bio)->bi_iter.bi_size) >> 9) >
>>> +                       queue_max_hw_sectors(rq->q))
>>> +               return -EINVAL;
>>> +
>> I have just confirmed about the max_hw_sectors checking below.
>> It is checked by the function blk_rq_map_kern() also as below.
>>
>>       if (len > (queue_max_hw_sectors(q) << 9))
>>           return -EINVAL;
> The above check doesn't take rq->__data_len into account.

Thanks for the comment and noted it.
I have just confirmed the behavior on 5.6.0-rc7 as below.
It works to limit the data length size 4MB as expected basically.
Also it can be limited by the check existed below in ll_back_merge_fn().

     if (blk_rq_sectors(req) + bio_sectors(bio) >
         blk_rq_get_max_sectors(req, blk_rq_pos(req))) {

But there is a case that the command data length is limited by 512KB.
I am not sure about this condition so needed more investigation.

Regards,
Ikegami

