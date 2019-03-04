Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91ADAC43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 12:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1AE20815
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 12:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfCDMmp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:42:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:24706 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfCDMmp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Mar 2019 07:42:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 04:42:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,440,1544515200"; 
   d="scan'208";a="119452258"
Received: from ikonopko-mobl1.ger.corp.intel.com (HELO [10.237.140.180]) ([10.237.140.180])
  by orsmga007.jf.intel.com with ESMTP; 04 Mar 2019 04:42:43 -0800
Subject: Re: [PATCH 05/13] lightnvm: pblk: Count all read errors in stats
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        Hans Holmberg <hans@owltronix.com>
Cc:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-6-igor.j.konopko@intel.com>
 <BAC8CFE4-5D1E-4FA0-80DF-9BA655D458D1@javigon.com>
 <CANr-nt3rzEGw0wNdOmm3ba9Oz10BLh_dbHoCECobMr2cfakLhQ@mail.gmail.com>
 <3E70BD55-1CBF-4695-ADA5-91C342E40F6C@javigon.com>
 <CANr-nt2Sj13VStWC4_GeTxCCVgztxqxm3HP7+7cNn+OoN=BCaQ@mail.gmail.com>
 <04F04C0B-25B6-4F1A-AEB6-36E4D6BB32B7@javigon.com>
From:   Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <e3fb769f-d20a-d5d3-42f7-5b62fc5d5a79@intel.com>
Date:   Mon, 4 Mar 2019 13:42:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <04F04C0B-25B6-4F1A-AEB6-36E4D6BB32B7@javigon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 04.03.2019 12:45, Javier González wrote:
> 
>> On 4 Mar 2019, at 12.41, Hans Holmberg <hans@owltronix.com> wrote:
>>
>> On Mon, Mar 4, 2019 at 10:23 AM Javier González <javier@javigon.com> wrote:
>>>> On 4 Mar 2019, at 10.02, Hans Holmberg <hans.ml.holmberg@owltronix.com> wrote:
>>>>
>>>> Igor: Have you seen this happening in real life?
>>>>
>>>> I think it would be better to count all expected errors and put them
>>>> in the right bucket (without spamming dmesg). If we need a new bucket
>>>> for i.e. vendor-specific-errors, let's do that instead.

Generally I'm seeing different types of errors (which are typically as 
Javier mention controller errors) in cases such as hot drive removal, etc.

We can skip that patch, since this are kind of corner cases. I can also
create new type of pblk stats, sth. like "controller errors", which 
would collect all the other unexpected errors in one place instead of 
mixing them with real read/write errors as I did.

>>>>
>>>> Someone wiser than me told me that every error print in the log is a
>>>> potential customer call.
>>>>
>>>> Javier: Yeah, I think S.M.A.R.T is the way to deliver this
>>>> information. Why can't we let the drives expose this info and remove
>>>> this from pblk? What's blocking that?
>>>
>>> Until now the spec. We added some new log information in Denali exactly
>>> for this. But since pblk supports OCSSD 1.2 and 2.0 I think it is needed to
>>> have it here, at least for debugging.
>>
>> Why add it to the spec? Why not use whatever everyone else is using?
>>
>> https://en.wikipedia.org/wiki/S.M.A.R.T. :
>> "S.M.A.R.T. (Self-Monitoring, Analysis and Reporting Technology; often
>> written as SMART) is a monitoring system included in computer hard
>> disk drives (HDDs), solid-state drives (SSDs),[1] and eMMC drives. Its
>> primary function is to detect and report various indicators of drive
>> reliability with the intent of anticipating imminent hardware
>> failures."
>> Sounds like what we want here.
> 
> I know what smart is… You need to define the fields. Maybe you want to
> read Denali again - the extensions are couple with smart.
> 
>> For debugging, a trace point or something(i.e. BPF) would be a better
>> solution that would not impact hot-path performance.
> 
> Cool. Look forward to the patches ;)
> 
> Javier
> 
