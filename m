Return-Path: <SRS0=MX1A=5N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772D2C43331
	for <linux-block@archiver.kernel.org>; Sat, 28 Mar 2020 12:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33AB0206E6
	for <linux-block@archiver.kernel.org>; Sat, 28 Mar 2020 12:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tv9lXVkC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgC1M5o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 Mar 2020 08:57:44 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35983 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgC1M5o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Mar 2020 08:57:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id g2so4590228plo.3
        for <linux-block@vger.kernel.org>; Sat, 28 Mar 2020 05:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GPReoKNVZW+mzx3T797PiFAFYu6BaP2nNmpUKla68Y8=;
        b=tv9lXVkC+ylWkYm10Vy0+AAjz2f3GeF2nfhd4nwOzmX/P3HQ9pLSHdrVSxUZxufR2S
         e9YsRQyY6JZGyxoIEAkp6/7qJ3u8xciT+InNhKZ59leSmh2PsrGUKT5hJEnOn7XakQYG
         B8LqetvjnE/7AZvN5fhLHiR7u4U3LZPVl8k4fDo71AMaMmrLXjrxOCMZao6+MBszxt4u
         uSwTsSm2YgevyNzR9rtpBEws3ghr/RaMoYO6p84Gbmqlo70vtxfk6chHyA2rtLLn7Rg6
         CAOnr3VYwuHdl0pYw+Cm/Q6WU93XE354NOLDCiZ6s+GibPo5m2cGCe7/8uqFW51/Tjfz
         QzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GPReoKNVZW+mzx3T797PiFAFYu6BaP2nNmpUKla68Y8=;
        b=pCSLZFXMrboAHAjegdB5JrjQf+blS3vc4lvU7EzhUkROEqH+L4srWI3W6SRM/BL1S4
         B6V1jVf0V8UHPDWRoZlF02zpE5JgrNbGHuwG3a4cH9mKZ/oyMNpmsLv/cIw1cL63P+Aq
         cu+P7l9N/hAWYM+2WjdKpSNd9ktwWKSreqkFVQAyRtq7aajI8sonjtVyXMyVLdTXAAgO
         Y95vfH2nU0e+SDo8fjZw0DKXO1uL+x2LxDn1aGn8Lsi/MYD64f7NswBZm5wm4zM1TI0N
         eebIrVyAPIGfQRlIm381RKA9fXWvIcN04XvOP5J1cyIc7cKgc68AlUu/Zl9oGh/Dspt5
         rTfg==
X-Gm-Message-State: ANhLgQ0PdwuPf8/jXx7Yi0gOv9P0/ZvUwCwlUg+fkr4kPurBWEBYNWvI
        8twUWMDtszInq+ciC7NYhuo=
X-Google-Smtp-Source: ADFU+vt1H+sT3LBgl23FZaghxrgRXDwrSVtsmvR1AFwXIyfiezqXNIKuAUM77ziyz1eIu10fW6Bbhw==
X-Received: by 2002:a17:90a:1acd:: with SMTP id p71mr5107202pjp.112.1585400262570;
        Sat, 28 Mar 2020 05:57:42 -0700 (PDT)
Received: from ?IPv6:240b:10:2720:5510:5c8f:768a:547c:1376? ([240b:10:2720:5510:5c8f:768a:547c:1376])
        by smtp.gmail.com with ESMTPSA id y22sm6180923pfr.68.2020.03.28.05.57.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2020 05:57:42 -0700 (PDT)
Subject: Re: [PATCH] block, nvme: Increase max segments parameter setting
 value
To:     Ming Lei <tom.leiming@gmail.com>, Keith Busch <kbusch@kernel.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
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
From:   Tokunori Ikegami <ikegami.t@gmail.com>
Message-ID: <a0e7a985-a726-8e16-d29c-eb38a919e18e@gmail.com>
Date:   Sat, 28 Mar 2020 21:57:39 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVM=rT=86JrmAkySTg=gknfFL8Q1NU0uXWzoDMKMyL_mow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 2020/03/28 11:11, Ming Lei wrote:
> On Sat, Mar 28, 2020 at 2:18 AM Keith Busch <kbusch@kernel.org> wrote:
>> On Sat, Mar 28, 2020 at 02:50:43AM +0900, Tokunori Ikegami wrote:
>>> On 2020/03/25 1:51, Tokunori Ikegami wrote:
>>>> On 2020/03/24 9:02, Keith Busch wrote:
>>>>> We didn't have 32-bit max segments before, though. Why was 16-bits
>>>>> enough in older kernels? Which kernel did this stop working?
>>>> Now I am asking the detail information to the reporter so let me
>>>> update later.  That was able to use the same command script with the
>>>> large data length in the past.
>>> I have just confirmed the detail so let me update below.
>>>
>>> The data length 20,531,712 (0x1394A00) is used on kernel 3.10.0 (CentOS
>>> 64bit).
>>> Also it is failed on kernel 10 4.10.0 (Ubuntu 32bit).
>>> But just confirmed it as succeeded on both 4.15.0 (Ubuntu 32bit) and 4.15.1
>>> (Ubuntu 64bit).
>>> So the original 20,531,712 length failure issue seems already resolved.
>>>
>>> I tested the data length 0x10000000 (268,435,456) and it is failed
>>> But now confirmed it as failed on all the above kernel versions.
>>> Also the patch fixes only this 0x10000000 length failure issue.
>> This is actually even more confusing. We do not support 256MB transfers
>> within a single command in the pci nvme driver anymore. The max is 4MB,
>> so I don't see how increasing the max segments will help: you should be
>> hitting the 'max_sectors' limit if you don't hit the segment limit first.
> That looks a bug for passthrough req, because 'max_sectors' limit is only
> checked in bio_add_pc_page(), not done in blk_rq_append_bio(), something
> like the following seems required:
>
> diff --git a/block/blk-map.c b/block/blk-map.c
> index b0790268ed9d..e120d80b75a5 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -22,6 +22,10 @@ int blk_rq_append_bio(struct request *rq, struct bio **bio)
>          struct bio_vec bv;
>          unsigned int nr_segs = 0;
>
> +       if (((rq->__data_len + (*bio)->bi_iter.bi_size) >> 9) >
> +                       queue_max_hw_sectors(rq->q))
> +               return -EINVAL;
> +

I have just confirmed about the max_hw_sectors checking below.
It is checked by the function blk_rq_map_kern() also as below.

     if (len > (queue_max_hw_sectors(q) << 9))
         return -EINVAL;

The function calls blk_rq_append_bio().
So the max_hw_sectors will be used to check the length with the change 
above.
But it seems that there is a difference also for the checking limit 
condition.

It seems that it is better to check the limit by blk_rq_map_user() 
instead of blk_rq_append_bio().
Or it can be changed to check the limit by blk_rq_append_bio() only 
without blk_rq_map_kern().

Regards,
Ikegami

