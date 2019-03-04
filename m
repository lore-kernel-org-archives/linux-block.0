Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2ABC43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 13:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA3F2075B
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 13:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="b+pyICJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfCDNEQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:04:16 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38433 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfCDNEP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 08:04:15 -0500
Received: by mail-ed1-f65.google.com with SMTP id h58so4179771edb.5
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 05:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jcu0Phd7eHOWC9lKM03+coDEMzQDtHQtO3rrxXL62J0=;
        b=b+pyICJjWPusyL2nuTMleISXn3TF031dxM3+XROdeFGWn5Vc7fgJ7GJFPxUVQFeLVz
         NCKW/vFhaJnbccEmamrgjrJYe0HeD2TYnNSaht0ZaMYB4oEc5ORVrsHK9SCZuvwVliFj
         WFapqYa5MMTmgLxvbhqYbnsSxyGBZjtKEHSZdTcshYB6IzwE197/iNlAe/e0An6dqqL6
         km13H6XnG0nfl/LZx2O/8nDJ1dndXL9w0xGFpd3zoO4psLKNLJla/DFB3BIV7qdhK1Ow
         uNtpQcoGsKdOCzAxKa0kzw0v0NUpmDH5f8fZEDZVXpo4RKOcOphEyBFNvNgtrm0b7z/o
         w/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jcu0Phd7eHOWC9lKM03+coDEMzQDtHQtO3rrxXL62J0=;
        b=Y47E5YH30LYdiQrm9TutY9RFfnj8/j33EEX3MRIHSx0v+ki2n2B1FXTWJksBBif19F
         fB4v/i4MtobGPlWoOC2CAZoRiZz1UmgTzaG2+QnviEZLKtD+0C1bpqjUyF9R/7dJPsBQ
         /I3T0FP0ElIPABTtU6mnnJxSirUrMUwja2imvHuOmwudb11ueDmPbYgCr4lO+RLaV5Vb
         dvbSG+zvQOIrrfWnWeVt9/KQby1hTCrDfccTRIRoz2zGh8DL1oRQF1xACHhxxBMd7k22
         4FkEUFy4DyhjrmSC0PU09tJGTDDc/c6sdJYs332sX1Ws9HqGJQ0iiHwWg8wxWziQtmdQ
         IqmQ==
X-Gm-Message-State: APjAAAUasycf5Sf6yNAtVuiuBSA9eGUzilHTxaGTJOU2/uvVt7rOHO4M
        U9b3ea6+HY6WznHW60t/3MX09Usm9Ss=
X-Google-Smtp-Source: AHgI3IYEGKBJctwhDkktjbNCkIinPyFQLCjqG+m7Z63W7J5itwPX3qwq6UK0lANwjm6ZRKhqnA7G9g==
X-Received: by 2002:a50:8562:: with SMTP id 89mr15129951edr.5.1551704653699;
        Mon, 04 Mar 2019 05:04:13 -0800 (PST)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id g31sm2088501edb.45.2019.03.04.05.04.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 05:04:13 -0800 (PST)
Subject: Re: [PATCH 08/13] lightnvm: pblk: Set proper read stutus in bio
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        Hans Holmberg <hans.ml.holmberg@owltronix.com>
Cc:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-9-igor.j.konopko@intel.com>
 <007EC669-9C50-4B29-9522-CE73CD3CE47F@javigon.com>
 <CANr-nt1o4ZyRW-MwwXHQ7aXTmOr8PsqRzhR3643iddh9H2kjjg@mail.gmail.com>
 <9076DF06-7B01-44DA-BA5F-9C784D56134E@javigon.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <c261bdbf-cac3-faa0-34a6-e51981f4698d@lightnvm.io>
Date:   Mon, 4 Mar 2019 14:04:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9076DF06-7B01-44DA-BA5F-9C784D56134E@javigon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/4/19 10:48 AM, Javier González wrote:
> 
> 
>> On 4 Mar 2019, at 10.35, Hans Holmberg <hans.ml.holmberg@owltronix.com> wrote:
>>
>> On Mon, Mar 4, 2019 at 9:03 AM Javier González <javier@javigon.com> wrote:
>>>> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> wrote:
>>>>
>>>> Currently in case of read errors, bi_status is not
>>>> set properly which leads to returning inproper data
>>>> to higher layer. This patch fix that by setting proper
>>>> status in case of read errors
>>>>
>>>> Patch also removes unnecessary warn_once(), which does
>>>> not make sense in that place, since user bio is not used
>>>> for interation with drive and thus bi_status will not be
>>>> set here.
>>>>
>>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>>> ---
>>>> drivers/lightnvm/pblk-read.c | 11 +++++------
>>>> 1 file changed, 5 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
>>>> index 3789185144da..39c1d6ccaedb 100644
>>>> --- a/drivers/lightnvm/pblk-read.c
>>>> +++ b/drivers/lightnvm/pblk-read.c
>>>> @@ -175,11 +175,10 @@ static void pblk_read_check_rand(struct pblk *pblk, struct nvm_rq *rqd,
>>>>       WARN_ONCE(j != rqd->nr_ppas, "pblk: corrupted random request\n");
>>>> }
>>>>
>>>> -static void pblk_end_user_read(struct bio *bio)
>>>> +static void pblk_end_user_read(struct bio *bio, int error)
>>>> {
>>>> -#ifdef CONFIG_NVM_PBLK_DEBUG
>>>> -     WARN_ONCE(bio->bi_status, "pblk: corrupted read bio\n");
>>>> -#endif
>>>> +     if (error && error != NVM_RSP_WARN_HIGHECC)
>>>> +             bio_io_error(bio);
>>>>       bio_endio(bio);
>>>> }
>>>>
>>>> @@ -219,7 +218,7 @@ static void pblk_end_io_read(struct nvm_rq *rqd)
>>>>       struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
>>>>       struct bio *bio = (struct bio *)r_ctx->private;
>>>>
>>>> -     pblk_end_user_read(bio);
>>>> +     pblk_end_user_read(bio, rqd->error);
>>>>       __pblk_end_io_read(pblk, rqd, true);
>>>> }
>>>>
>>>> @@ -292,7 +291,7 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
>>>>       rqd->bio = NULL;
>>>>       rqd->nr_ppas = nr_secs;
>>>>
>>>> -     bio_endio(bio);
>>>> +     pblk_end_user_read(bio, rqd->error);
>>>>       __pblk_end_io_read(pblk, rqd, false);
>>>> }
>>>>
>>>> --
>>>> 2.17.1
>>>
>>> This is by design. We do not report the read errors as in any other
>>> block device - this is why we clone the read bio.
>>
>> Could you elaborate on why not reporting read errors is a good thing in pblk?
>>
> 
> Normal block devices do not report read errors on the completion path
> unless it is a fatal error. This is actually not well understood by the
> upper layers, which tend to assume that the device is completely broken.
> 
> This is a challenge for OCSSD / Denali / Zone devices as there are cases
> where reads can fail. Unfortunately at this point, we need to mask these
> errors and deal with them in the different layers.

Please don't include zone devices in that list. ZAC/ZBC are 
well-behaved, and an error is a real error.

> 
> For OCSSD currently, we do this in pblk, which I think fits well the
> model as we exposed a normal block device.
> 
> Javier
> 

