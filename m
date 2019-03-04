Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246B1C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 13:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4612075B
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 13:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="ttvaV5Lm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfCDNId (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:08:33 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43344 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfCDNId (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 08:08:33 -0500
Received: by mail-ed1-f65.google.com with SMTP id m35so4170115ede.10
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 05:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vODVFa/9qcNUISUGCqB6SQRPCEmDckGrim0UtC3BStI=;
        b=ttvaV5Lm+ajQ4lGl1jiQa28IpBfWHXvJazrqis8b5S9SistZY4TbrSN5/9WLz68ODt
         UNNoCgkkjd06tL+DppfakVHmMgj196keyD5Z7jmZm010nZZxDKLtx13HzqPWYQ/lSGjO
         kAbBUcePN0iCPMsH2n7L9SG7OmDxK5BsIuPNJVoLRhH60JW4w7ZXHwZu/3JHsDJ3CKgv
         pJI72Dil7bErVM4Y6Et7bnodmYJGKCfwVOYbEWsMsgIPX2znNzEX8CBBmZLyBLDtN3MC
         SvwVdo+Ob9fa91a7ga9jpemK2P5+6igyZmvsjnOu3fyPdpjfXw2mCgj+5vSZdSz9e6WS
         N7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vODVFa/9qcNUISUGCqB6SQRPCEmDckGrim0UtC3BStI=;
        b=VSMAIEt9vpEb6FqsehbQ2nbq0WolR1iG/3d4PgXABcIH6KOqbtY76VM/q2NdUG2xJe
         67SDLlVbZ39EpnNFZl8pHdnXtMomPngc8rX+G0fNyO1CfetU3JpaeGoR90zC22x4TUCa
         BfbyKIvIDgjNPhbIQd4VvzkzCGwp2pEymDI8srQQLb94lbLOJoxk7l8lYBYHEe16lsLW
         rcnYwvsd+e9aRFqcFU7GspYwO5s7OGoxUhGppcMRgtmpXITNafz7IA+4h35v6RbjLPMO
         bAnqdYSpKdpMTv2zZjnKNMVY0vJW+qXxMRJVs2qXPkNizza8q5CIN7hhzRtCYcrWDCk0
         f1Gw==
X-Gm-Message-State: APjAAAUVn8u5pgwFD3yL6cgijsrC59+KGXn8HTnhnHNiuNR38Fv1Eqh3
        8v7YRRCBH1t3Va/VP3C1Y5GivNuS1ic=
X-Google-Smtp-Source: APXvYqxTLI4odGIiFwY4EBLHaeR70JVT/DUjjYYMYhehia35Zoe0Hog8ZN07rsabNXPwjbgNr8cN+Q==
X-Received: by 2002:a50:8693:: with SMTP id r19mr15837986eda.60.1551704910404;
        Mon, 04 Mar 2019 05:08:30 -0800 (PST)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id bq6sm1178138ejb.16.2019.03.04.05.08.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 05:08:29 -0800 (PST)
Subject: Re: [PATCH 08/13] lightnvm: pblk: Set proper read stutus in bio
To:     Igor Konopko <igor.j.konopko@intel.com>,
        Hans Holmberg <hans@owltronix.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-9-igor.j.konopko@intel.com>
 <007EC669-9C50-4B29-9522-CE73CD3CE47F@javigon.com>
 <CANr-nt1o4ZyRW-MwwXHQ7aXTmOr8PsqRzhR3643iddh9H2kjjg@mail.gmail.com>
 <9076DF06-7B01-44DA-BA5F-9C784D56134E@javigon.com>
 <CANr-nt0HeMvSgBOdbSaL+6tadEn9_K6LThaHfGpib+4vc6xthg@mail.gmail.com>
 <9c5a361b-d7f2-08be-7b3d-6eae68594e1d@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <4b92af86-c5ba-aa09-f39e-86975fd35460@lightnvm.io>
Date:   Mon, 4 Mar 2019 14:08:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9c5a361b-d7f2-08be-7b3d-6eae68594e1d@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/4/19 1:51 PM, Igor Konopko wrote:
> 
> 
> On 04.03.2019 13:14, Hans Holmberg wrote:
>> On Mon, Mar 4, 2019 at 10:48 AM Javier González <javier@javigon.com> 
>> wrote:
>>>
>>>
>>>
>>>> On 4 Mar 2019, at 10.35, Hans Holmberg 
>>>> <hans.ml.holmberg@owltronix.com> wrote:
>>>>
>>>> On Mon, Mar 4, 2019 at 9:03 AM Javier González <javier@javigon.com> 
>>>> wrote:
>>>>>> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> 
>>>>>> wrote:
>>>>>>
>>>>>> Currently in case of read errors, bi_status is not
>>>>>> set properly which leads to returning inproper data
>>>>>> to higher layer. This patch fix that by setting proper
>>>>>> status in case of read errors
>>>>>>
>>>>>> Patch also removes unnecessary warn_once(), which does
>>>>>> not make sense in that place, since user bio is not used
>>>>>> for interation with drive and thus bi_status will not be
>>>>>> set here.
>>>>>>
>>>>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>>>>> ---
>>>>>> drivers/lightnvm/pblk-read.c | 11 +++++------
>>>>>> 1 file changed, 5 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/lightnvm/pblk-read.c 
>>>>>> b/drivers/lightnvm/pblk-read.c
>>>>>> index 3789185144da..39c1d6ccaedb 100644
>>>>>> --- a/drivers/lightnvm/pblk-read.c
>>>>>> +++ b/drivers/lightnvm/pblk-read.c
>>>>>> @@ -175,11 +175,10 @@ static void pblk_read_check_rand(struct pblk 
>>>>>> *pblk, struct nvm_rq *rqd,
>>>>>>       WARN_ONCE(j != rqd->nr_ppas, "pblk: corrupted random 
>>>>>> request\n");
>>>>>> }
>>>>>>
>>>>>> -static void pblk_end_user_read(struct bio *bio)
>>>>>> +static void pblk_end_user_read(struct bio *bio, int error)
>>>>>> {
>>>>>> -#ifdef CONFIG_NVM_PBLK_DEBUG
>>>>>> -     WARN_ONCE(bio->bi_status, "pblk: corrupted read bio\n");
>>>>>> -#endif
>>>>>> +     if (error && error != NVM_RSP_WARN_HIGHECC)
>>>>>> +             bio_io_error(bio);
>>>>>>       bio_endio(bio);
>>>>>> }
>>>>>>
>>>>>> @@ -219,7 +218,7 @@ static void pblk_end_io_read(struct nvm_rq *rqd)
>>>>>>       struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
>>>>>>       struct bio *bio = (struct bio *)r_ctx->private;
>>>>>>
>>>>>> -     pblk_end_user_read(bio);
>>>>>> +     pblk_end_user_read(bio, rqd->error);
>>>>>>       __pblk_end_io_read(pblk, rqd, true);
>>>>>> }
>>>>>>
>>>>>> @@ -292,7 +291,7 @@ static void pblk_end_partial_read(struct 
>>>>>> nvm_rq *rqd)
>>>>>>       rqd->bio = NULL;
>>>>>>       rqd->nr_ppas = nr_secs;
>>>>>>
>>>>>> -     bio_endio(bio);
>>>>>> +     pblk_end_user_read(bio, rqd->error);
>>>>>>       __pblk_end_io_read(pblk, rqd, false);
>>>>>> }
>>>>>>
>>>>>> -- 
>>>>>> 2.17.1
>>>>>
>>>>> This is by design. We do not report the read errors as in any other
>>>>> block device - this is why we clone the read bio.
>>>>
>>>> Could you elaborate on why not reporting read errors is a good thing 
>>>> in pblk?
>>>>
>>>
>>> Normal block devices do not report read errors on the completion path
>>> unless it is a fatal error. This is actually not well understood by the
>>> upper layers, which tend to assume that the device is completely broken.
>>
>> So returning bogus data without even a warning is a preferred
>> solution? You want to force "the upper layers" to do checksumming?
>>
>> It's fine to mask out NVM_RSP_WARN_HIGHECC, since that is just a
>> warning that OCSSD 2.0 adds. The data should still be good.
>> All other errors (see 4.6.1.2.1 in the NVMe 1.3 spec), indicates that
>> the command did not complete (As far as I can tell)
>>
> 
> My approach was exactly like that. In all cases other than WARN_HIGHECC 
> we don't have a valid data. Without setting a bio_io_error() we are 
> creating the impression for other layers, that we read the data 
> correctly, what is not a case then.
> 
> I'm also seeing that this patch is not the only user of bio_io_error() 
> API, also other drivers such as md uses is commonly.

Yes agree. This is an actual error in pblk that lets it return bogus data.

