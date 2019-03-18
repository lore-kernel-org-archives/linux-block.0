Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE53BC43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 13:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853EE20863
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 13:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfCRNGj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:06:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:7083 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfCRNGi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 09:06:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 06:06:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,494,1544515200"; 
   d="scan'208";a="126381716"
Received: from ikonopko-mobl1.ger.corp.intel.com (HELO [10.237.142.164]) ([10.237.142.164])
  by orsmga008.jf.intel.com with ESMTP; 18 Mar 2019 06:06:37 -0700
Subject: Re: [PATCH 11/18] lightnvm: pblk: fix update line wp in OOB recovery
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-12-igor.j.konopko@intel.com>
 <13318131-0146-420D-94B9-5E771F344E2A@javigon.com>
From:   Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <b6ee8460-49cc-36b9-d980-5665f8f286ad@intel.com>
Date:   Mon, 18 Mar 2019 14:06:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <13318131-0146-420D-94B9-5E771F344E2A@javigon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 18.03.2019 07:56, Javier González wrote:
>> On 14 Mar 2019, at 17.04, Igor Konopko <igor.j.konopko@intel.com> wrote:
>>
>> In case of OOB recovery, we can hit the scenario when all the data in
>> line were written and some part of emeta was written too. In such
>> a case pblk_update_line_wp() function will call pblk_alloc_page()
>> function which will case to set left_msecs to value below zero
>> (since this field does not track emeta region) and thus will lead to
>> multiple kernel warnings. This patch fixes that issue.
>>
>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>> ---
>> drivers/lightnvm/pblk-recovery.c | 20 +++++++++++++++++---
>> 1 file changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
>> index 73d5ead..4764596 100644
>> --- a/drivers/lightnvm/pblk-recovery.c
>> +++ b/drivers/lightnvm/pblk-recovery.c
>> @@ -93,10 +93,24 @@ static int pblk_recov_l2p_from_emeta(struct pblk *pblk, struct pblk_line *line)
>> static void pblk_update_line_wp(struct pblk *pblk, struct pblk_line *line,
>> 				u64 written_secs)
>> {
>> -	int i;
>> +	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
>> +	int i = 0;
>>
>> -	for (i = 0; i < written_secs; i += pblk->min_write_pgs)
>> -		pblk_alloc_page(pblk, line, pblk->min_write_pgs);
>> +	for (; i < written_secs; i += pblk->min_write_pgs)
> 
> Why no i = 0 here?

Accidentally changed - will revert it.

> 
>> +		__pblk_alloc_page(pblk, line, pblk->min_write_pgs);
>> +
>> +	spin_lock(&l_mg->free_lock);
>> +	if (written_secs > line->left_msecs) {
>> +		/*
>> +		 * We have all data sectors written
>> +		 * and some emeta sectors written too.
>> +		 */
>> +		line->left_msecs = 0;
>> +	} else {
>> +		/* We have only some data sectors written. */
>> +		line->left_msecs -= written_secs;
>> +	}
>> +	spin_unlock(&l_mg->free_lock);
>> }
>>
>> static u64 pblk_sec_in_open_line(struct pblk *pblk, struct pblk_line *line)
>> --
>> 2.9.5
> 
> Otherwise, it looks good.
> 
> Reviewed-by: Javier González <javier@javigon.com>
> 
> 
> 
