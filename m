Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFE8C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 13:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72C820857
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 13:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfCRNFH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:05:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:6278 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbfCRNFH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 09:05:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 06:05:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,493,1544515200"; 
   d="scan'208";a="126381317"
Received: from ikonopko-mobl1.ger.corp.intel.com (HELO [10.237.142.164]) ([10.237.142.164])
  by orsmga008.jf.intel.com with ESMTP; 18 Mar 2019 06:05:05 -0700
Subject: Re: [PATCH 12/18] lightnvm: pblk: do not read OOB from emeta region
To:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-13-igor.j.konopko@intel.com>
 <e26818ce-6d2e-e7d2-bfb4-da83c198952b@lightnvm.io>
From:   Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <37fb5d9c-8d6e-e5b2-d7da-433d31964468@intel.com>
Date:   Mon, 18 Mar 2019 14:05:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <e26818ce-6d2e-e7d2-bfb4-da83c198952b@lightnvm.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 17.03.2019 20:56, Matias Bjørling wrote:
> On 3/14/19 9:04 AM, Igor Konopko wrote:
>> Emeta does not have corresponding OOB metadata mapping valid, so there
>> is no need to try to recover L2P mapping from it.
>>
>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>> ---
>>   drivers/lightnvm/pblk-recovery.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/lightnvm/pblk-recovery.c 
>> b/drivers/lightnvm/pblk-recovery.c
>> index 4764596..2132260 100644
>> --- a/drivers/lightnvm/pblk-recovery.c
>> +++ b/drivers/lightnvm/pblk-recovery.c
>> @@ -479,6 +479,14 @@ static int pblk_recov_scan_oob(struct pblk *pblk, 
>> struct pblk_line *line,
>>           goto retry_rq;
>>       }
>> +    if (paddr >= line->emeta_ssec) {
>> +        /*
>> +         * We reach emeta region and we don't want
>> +         * to recover oob from emeta region.
>> +         */
>> +        goto completed;
> 
> The bio needs to be put before going to completed?

Yes, definitely, thanks.
> 
>> +    }
>> +
>>       pblk_get_packed_meta(pblk, rqd);
>>       bio_put(bio);
>> @@ -499,6 +507,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, 
>> struct pblk_line *line,
>>       if (left_ppas > 0)
>>           goto next_rq;
>> +completed:
>>   #ifdef CONFIG_NVM_PBLK_DEBUG
>>       WARN_ON(padded && !pblk_line_is_full(line));
>>   #endif
>>
> 
