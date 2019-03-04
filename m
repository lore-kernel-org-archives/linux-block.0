Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F93FC43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 12:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7702820815
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 12:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfCDMv3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:51:29 -0500
Received: from mga18.intel.com ([134.134.136.126]:8052 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfCDMv2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Mar 2019 07:51:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 04:51:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,440,1544515200"; 
   d="scan'208";a="119453386"
Received: from ikonopko-mobl1.ger.corp.intel.com (HELO [10.237.140.180]) ([10.237.140.180])
  by orsmga007.jf.intel.com with ESMTP; 04 Mar 2019 04:51:26 -0800
Subject: Re: [PATCH 08/13] lightnvm: pblk: Set proper read stutus in bio
To:     Hans Holmberg <hans@owltronix.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-9-igor.j.konopko@intel.com>
 <007EC669-9C50-4B29-9522-CE73CD3CE47F@javigon.com>
 <CANr-nt1o4ZyRW-MwwXHQ7aXTmOr8PsqRzhR3643iddh9H2kjjg@mail.gmail.com>
 <9076DF06-7B01-44DA-BA5F-9C784D56134E@javigon.com>
 <CANr-nt0HeMvSgBOdbSaL+6tadEn9_K6LThaHfGpib+4vc6xthg@mail.gmail.com>
From:   Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <9c5a361b-d7f2-08be-7b3d-6eae68594e1d@intel.com>
Date:   Mon, 4 Mar 2019 13:51:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CANr-nt0HeMvSgBOdbSaL+6tadEn9_K6LThaHfGpib+4vc6xthg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 04.03.2019 13:14, Hans Holmberg wrote:
> On Mon, Mar 4, 2019 at 10:48 AM Javier González <javier@javigon.com> wrote:
>>
>>
>>
>>> On 4 Mar 2019, at 10.35, Hans Holmberg <hans.ml.holmberg@owltronix.com> wrote:
>>>
>>> On Mon, Mar 4, 2019 at 9:03 AM Javier González <javier@javigon.com> wrote:
>>>>> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> wrote:
>>>>>
>>>>> Currently in case of read errors, bi_status is not
>>>>> set properly which leads to returning inproper data
>>>>> to higher layer. This patch fix that by setting proper
>>>>> status in case of read errors
>>>>>
>>>>> Patch also removes unnecessary warn_once(), which does
>>>>> not make sense in that place, since user bio is not used
>>>>> for interation with drive and thus bi_status will not be
>>>>> set here.
>>>>>
>>>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>>>> ---
>>>>> drivers/lightnvm/pblk-read.c | 11 +++++------
>>>>> 1 file changed, 5 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
>>>>> index 3789185144da..39c1d6ccaedb 100644
>>>>> --- a/drivers/lightnvm/pblk-read.c
>>>>> +++ b/drivers/lightnvm/pblk-read.c
>>>>> @@ -175,11 +175,10 @@ static void pblk_read_check_rand(struct pblk *pblk, struct nvm_rq *rqd,
>>>>>       WARN_ONCE(j != rqd->nr_ppas, "pblk: corrupted random request\n");
>>>>> }
>>>>>
>>>>> -static void pblk_end_user_read(struct bio *bio)
>>>>> +static void pblk_end_user_read(struct bio *bio, int error)
>>>>> {
>>>>> -#ifdef CONFIG_NVM_PBLK_DEBUG
>>>>> -     WARN_ONCE(bio->bi_status, "pblk: corrupted read bio\n");
>>>>> -#endif
>>>>> +     if (error && error != NVM_RSP_WARN_HIGHECC)
>>>>> +             bio_io_error(bio);
>>>>>       bio_endio(bio);
>>>>> }
>>>>>
>>>>> @@ -219,7 +218,7 @@ static void pblk_end_io_read(struct nvm_rq *rqd)
>>>>>       struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
>>>>>       struct bio *bio = (struct bio *)r_ctx->private;
>>>>>
>>>>> -     pblk_end_user_read(bio);
>>>>> +     pblk_end_user_read(bio, rqd->error);
>>>>>       __pblk_end_io_read(pblk, rqd, true);
>>>>> }
>>>>>
>>>>> @@ -292,7 +291,7 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
>>>>>       rqd->bio = NULL;
>>>>>       rqd->nr_ppas = nr_secs;
>>>>>
>>>>> -     bio_endio(bio);
>>>>> +     pblk_end_user_read(bio, rqd->error);
>>>>>       __pblk_end_io_read(pblk, rqd, false);
>>>>> }
>>>>>
>>>>> --
>>>>> 2.17.1
>>>>
>>>> This is by design. We do not report the read errors as in any other
>>>> block device - this is why we clone the read bio.
>>>
>>> Could you elaborate on why not reporting read errors is a good thing in pblk?
>>>
>>
>> Normal block devices do not report read errors on the completion path
>> unless it is a fatal error. This is actually not well understood by the
>> upper layers, which tend to assume that the device is completely broken.
> 
> So returning bogus data without even a warning is a preferred
> solution? You want to force "the upper layers" to do checksumming?
> 
> It's fine to mask out NVM_RSP_WARN_HIGHECC, since that is just a
> warning that OCSSD 2.0 adds. The data should still be good.
> All other errors (see 4.6.1.2.1 in the NVMe 1.3 spec), indicates that
> the command did not complete (As far as I can tell)
> 

My approach was exactly like that. In all cases other than WARN_HIGHECC 
we don't have a valid data. Without setting a bio_io_error() we are 
creating the impression for other layers, that we read the data 
correctly, what is not a case then.

I'm also seeing that this patch is not the only user of bio_io_error() 
API, also other drivers such as md uses is commonly.

> 
>>
>> This is a challenge for OCSSD / Denali / Zone devices as there are cases
>> where reads can fail. Unfortunately at this point, we need to mask these
>> errors and deal with them in the different layers.
>>
>> For OCSSD currently, we do this in pblk, which I think fits well the
>> model as we exposed a normal block device.
>>
>> Javier
