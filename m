Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B15CC43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 11:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE392207DD
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 11:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbfCYLRw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:17:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:2010 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729727AbfCYLRv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 07:17:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 04:17:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="154937821"
Received: from ikonopko-mobl1.ger.corp.intel.com (HELO [10.237.142.109]) ([10.237.142.109])
  by fmsmga002.fm.intel.com with ESMTP; 25 Mar 2019 04:17:49 -0700
Subject: Re: [PATCH v2 12/16] lightnvm: pblk: do not read OOB from emeta
 region
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
References: <20190322144843.9602-1-igor.j.konopko@intel.com>
 <20190322144843.9602-13-igor.j.konopko@intel.com>
 <771CAB97-E48D-481A-90E7-310D2ADD85E4@javigon.com>
From:   Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <982a051a-a4bd-40e6-e8c4-9470a49e9b1d@intel.com>
Date:   Mon, 25 Mar 2019 12:17:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <771CAB97-E48D-481A-90E7-310D2ADD85E4@javigon.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 25.03.2019 07:23, Javier González wrote:
>> On 22 Mar 2019, at 22.48, Igor Konopko <igor.j.konopko@intel.com> wrote:
>>
>> Emeta does not have corresponding OOB metadata mapping valid, so there
>> is no need to try to recover L2P mapping from it.
>>
>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>> ---
>> drivers/lightnvm/pblk-recovery.c | 10 ++++++++++
>> 1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
>> index 4e8f382..74e5b17 100644
>> --- a/drivers/lightnvm/pblk-recovery.c
>> +++ b/drivers/lightnvm/pblk-recovery.c
>> @@ -479,6 +479,15 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>> 		goto retry_rq;
>> 	}
>>
>> +	if (paddr >= line->emeta_ssec) {
>> +		/*
>> +		 * We reach emeta region and we don't want
>> +		 * to recover oob from emeta region.
>> +		 */
>> +		bio_put(bio);
>> +		goto completed;
>> +	}
>> +
>>
> 
> This recovery path is supposed to be a last resource to recover an open
> line. Since emeta_ssec is calculated based on the new state after
> recovery, it is not guaranteed that the bad blocks are the same as when
> the last pblk instance was interrupted. Thus, emeta_ssec is not to be
> trusted.
> 
> I would rather do the full scan at this point.
> 

Ok, make sense, so we can drop this patch.

> Javier
> 
