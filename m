Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84194C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 15:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463122063F
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 15:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="LRIbNHju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfCDPMX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:12:23 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46252 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfCDPMX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 10:12:23 -0500
Received: by mail-ed1-f67.google.com with SMTP id f2so4512606edy.13
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 07:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y5houJc0P2UtvOwihz4yHXSO3Pt5SSdXHwbp7NwdCrg=;
        b=LRIbNHju8DFTQGWfmlIFeEDRpwilFBcdreLgXyuxu1WlcYn3hNNAPfhTVxnrW0KV2C
         KLPts9nXji5grCLo9EYhry8d0stPWWHwsRTzCaRmBjwToIqP2kw65dGLCT1Zmd9odfMt
         SaxByqP4PsAhDkuoLP6iMBN66pncLI0k4igwAVAoTqiFAIpiHK65Ts28u3tksIIxdhZs
         TglqeOYALUjOAiPOmAQT+6ym5/PsSPEpxks/AM6pKufGYXH9lhOnoGdmlWtWd3Cn4kHi
         9exDCbOPL3NSPxKtIxExLWBcTjOlqwq3YL+GDCX916WIsaaNUcf5bcudyY1XwO+yikbu
         ikew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y5houJc0P2UtvOwihz4yHXSO3Pt5SSdXHwbp7NwdCrg=;
        b=ZyvwSrzdaMbGkCMKb37nClVYo8kiBOq7fEj38XWbBsZpp38SH4nsqYl+9zJrDIHE/a
         WbUXarPxB7O8Q4ijX5Ew2ImP3O0bYfZWnDMLmxngQvkxJudQQ6jbkLEW+LJxFuLovNL0
         H6G7s9hrkOYovLUEJ0XlL2MlQ0ythKBH/ySXnUTszQndU9F5UxI8hRC8dUDbMU/2OHtA
         zYijUiFjKAJnWdSmLQaBQZ7k1Zs8s6CUCE60Hgv4No7WwgUv1ji4C2wyKRzBSfO2/58h
         xsA+C+zI946mm34DcMG5vRqFDqDE0Dd8aPeLTr8eZG78GCvpM4ILDfUxOfDMdtbhl1JN
         ChtA==
X-Gm-Message-State: APjAAAWWilZfFCOc2DPLaZOGTfwnmA47f21E/Ax06M72VK51bTgi4vQu
        rFG7Llbcx0QxVVeoCHaIoJj5XgM2nHc=
X-Google-Smtp-Source: APXvYqwrkgSr2QxHAU50r83AIvKzfCY1Jl2NLo4qblCAON0Tvt178gQ7dnFnglfrqVq2bfLmbMJB+A==
X-Received: by 2002:a17:906:14c9:: with SMTP id y9mr13049646ejc.182.1551712341023;
        Mon, 04 Mar 2019 07:12:21 -0800 (PST)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id g25sm1236424ejc.55.2019.03.04.07.12.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 07:12:20 -0800 (PST)
Subject: Re: [PATCH 08/13] lightnvm: pblk: Set proper read stutus in bio
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        Hans Holmberg <hans@owltronix.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-9-igor.j.konopko@intel.com>
 <007EC669-9C50-4B29-9522-CE73CD3CE47F@javigon.com>
 <CANr-nt1o4ZyRW-MwwXHQ7aXTmOr8PsqRzhR3643iddh9H2kjjg@mail.gmail.com>
 <9076DF06-7B01-44DA-BA5F-9C784D56134E@javigon.com>
 <CANr-nt0HeMvSgBOdbSaL+6tadEn9_K6LThaHfGpib+4vc6xthg@mail.gmail.com>
 <9c5a361b-d7f2-08be-7b3d-6eae68594e1d@intel.com>
 <4b92af86-c5ba-aa09-f39e-86975fd35460@lightnvm.io>
 <8A1CEAAD-601B-4AC8-81DC-C7A5CB24001D@javigon.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <afb2814c-dbda-1c4f-b30c-d7bda9c7bb29@lightnvm.io>
Date:   Mon, 4 Mar 2019 16:12:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <8A1CEAAD-601B-4AC8-81DC-C7A5CB24001D@javigon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/4/19 2:45 PM, Javier González wrote:
> 
>> On 4 Mar 2019, at 14.08, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 3/4/19 1:51 PM, Igor Konopko wrote:
>>> On 04.03.2019 13:14, Hans Holmberg wrote:
>>>> On Mon, Mar 4, 2019 at 10:48 AM Javier González <javier@javigon.com> wrote:
>>>>>> On 4 Mar 2019, at 10.35, Hans Holmberg <hans.ml.holmberg@owltronix.com> wrote:
>>>>>>
>>>>>> On Mon, Mar 4, 2019 at 9:03 AM Javier González <javier@javigon.com> wrote:
>>>>>>>> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> wrote:
>>>>>>>>
>>>>>>>> Currently in case of read errors, bi_status is not
>>>>>>>> set properly which leads to returning inproper data
>>>>>>>> to higher layer. This patch fix that by setting proper
>>>>>>>> status in case of read errors
>>>>>>>>
>>>>>>>> Patch also removes unnecessary warn_once(), which does
>>>>>>>> not make sense in that place, since user bio is not used
>>>>>>>> for interation with drive and thus bi_status will not be
>>>>>>>> set here.
>>>>>>>>
>>>>>>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>>>>>>> ---
>>>>>>>> drivers/lightnvm/pblk-read.c | 11 +++++------
>>>>>>>> 1 file changed, 5 insertions(+), 6 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
>>>>>>>> index 3789185144da..39c1d6ccaedb 100644
>>>>>>>> --- a/drivers/lightnvm/pblk-read.c
>>>>>>>> +++ b/drivers/lightnvm/pblk-read.c
>>>>>>>> @@ -175,11 +175,10 @@ static void pblk_read_check_rand(struct pblk *pblk, struct nvm_rq *rqd,
>>>>>>>>        WARN_ONCE(j != rqd->nr_ppas, "pblk: corrupted random request\n");
>>>>>>>> }
>>>>>>>>
>>>>>>>> -static void pblk_end_user_read(struct bio *bio)
>>>>>>>> +static void pblk_end_user_read(struct bio *bio, int error)
>>>>>>>> {
>>>>>>>> -#ifdef CONFIG_NVM_PBLK_DEBUG
>>>>>>>> -     WARN_ONCE(bio->bi_status, "pblk: corrupted read bio\n");
>>>>>>>> -#endif
>>>>>>>> +     if (error && error != NVM_RSP_WARN_HIGHECC)
>>>>>>>> +             bio_io_error(bio);
>>>>>>>>        bio_endio(bio);
>>>>>>>> }
>>>>>>>>
>>>>>>>> @@ -219,7 +218,7 @@ static void pblk_end_io_read(struct nvm_rq *rqd)
>>>>>>>>        struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
>>>>>>>>        struct bio *bio = (struct bio *)r_ctx->private;
>>>>>>>>
>>>>>>>> -     pblk_end_user_read(bio);
>>>>>>>> +     pblk_end_user_read(bio, rqd->error);
>>>>>>>>        __pblk_end_io_read(pblk, rqd, true);
>>>>>>>> }
>>>>>>>>
>>>>>>>> @@ -292,7 +291,7 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
>>>>>>>>        rqd->bio = NULL;
>>>>>>>>        rqd->nr_ppas = nr_secs;
>>>>>>>>
>>>>>>>> -     bio_endio(bio);
>>>>>>>> +     pblk_end_user_read(bio, rqd->error);
>>>>>>>>        __pblk_end_io_read(pblk, rqd, false);
>>>>>>>> }
>>>>>>>>
>>>>>>>> --
>>>>>>>> 2.17.1
>>>>>>>
>>>>>>> This is by design. We do not report the read errors as in any other
>>>>>>> block device - this is why we clone the read bio.
>>>>>>
>>>>>> Could you elaborate on why not reporting read errors is a good thing in pblk?
>>>>>
>>>>> Normal block devices do not report read errors on the completion path
>>>>> unless it is a fatal error. This is actually not well understood by the
>>>>> upper layers, which tend to assume that the device is completely broken.
>>>>
>>>> So returning bogus data without even a warning is a preferred
>>>> solution? You want to force "the upper layers" to do checksumming?
>>>>
>>>> It's fine to mask out NVM_RSP_WARN_HIGHECC, since that is just a
>>>> warning that OCSSD 2.0 adds. The data should still be good.
>>>> All other errors (see 4.6.1.2.1 in the NVMe 1.3 spec), indicates that
>>>> the command did not complete (As far as I can tell)
>>> My approach was exactly like that. In all cases other than WARN_HIGHECC we don't have a valid data. Without setting a bio_io_error() we are creating the impression for other layers, that we read the data correctly, what is not a case then.
>>> I'm also seeing that this patch is not the only user of bio_io_error() API, also other drivers such as md uses is commonly.
>>
>> Yes agree. This is an actual error in pblk that lets it return bogus data.
> 
> I am not against returning an error, I am just saying that this is not
> normal behavior on the read path.
> 
> The problem is that the upper layers might interpret that the device is
> broken completely, which is not true for a spa failing. Think for
> example of a host reading under mw_cunits - in reality this is not even
> a device problem but a host bug that might result in a fatal error.

Agree, and the host should manage it. The drive shall return a fatal 
error when it is asked to return invalid data. E.g., mw_cunits.

> 
> Matias: I am surprised to see you answer this way - when I tried to
> define a sane read error path with meaningful errors starting in the
> spec and all the way up the stack you were the first one to argue for
> reads to always succeed no matter what. In fact, using ZBC/ZAC as an
> example...

What I objected against was having error messages for each type of error 
that could happen. Instead of a single or few error types (that triggers 
the same set of recovery procedure at the host-side).
