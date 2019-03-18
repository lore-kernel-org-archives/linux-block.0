Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D50C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 12:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CA420857
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 12:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfCRMyp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:54:45 -0400
Received: from mga06.intel.com ([134.134.136.31]:14053 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfCRMyp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 08:54:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 05:54:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,493,1544515200"; 
   d="scan'208";a="126378694"
Received: from ikonopko-mobl1.ger.corp.intel.com (HELO [10.237.142.164]) ([10.237.142.164])
  by orsmga008.jf.intel.com with ESMTP; 18 Mar 2019 05:54:43 -0700
Subject: Re: [PATCH 06/18] lightnvm: pblk: recover only written metadata
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-7-igor.j.konopko@intel.com>
 <4017AC03-A854-4158-ADC9-E1BBAE65003D@javigon.com>
From:   Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <b0210004-8b9e-14d7-a7fe-60bb20d6300e@intel.com>
Date:   Mon, 18 Mar 2019 13:54:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <4017AC03-A854-4158-ADC9-E1BBAE65003D@javigon.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 17.03.2019 00:46, Javier González wrote:
>> On 14 Mar 2019, at 09.04, Igor Konopko <igor.j.konopko@intel.com> wrote:
>>
>> This patch ensures that smeta/emeta was written properly before even
>> trying to read it based on chunk table state and write pointer.
>>
>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>> ---
>> drivers/lightnvm/pblk-recovery.c | 43 ++++++++++++++++++++++++++++++++++++++--
>> 1 file changed, 41 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
>> index 688fdeb..ba1691d 100644
>> --- a/drivers/lightnvm/pblk-recovery.c
>> +++ b/drivers/lightnvm/pblk-recovery.c
>> @@ -653,8 +653,42 @@ static int pblk_line_was_written(struct pblk_line *line,
>> 	bppa = pblk->luns[smeta_blk].bppa;
>> 	chunk = &line->chks[pblk_ppa_to_pos(geo, bppa)];
>>
>> -	if (chunk->state & NVM_CHK_ST_FREE)
>> -		return 0;
>> +	if (chunk->state & NVM_CHK_ST_CLOSED ||
>> +	    (chunk->state & NVM_CHK_ST_OPEN
>> +	     && chunk->wp >= lm->smeta_sec))
>> +		return 1;
>> +
>> +	return 0;
>> +}
>> +
>> +static int pblk_line_was_emeta_written(struct pblk_line *line,
>> +				       struct pblk *pblk)
>> +{
>> +
>> +	struct pblk_line_meta *lm = &pblk->lm;
>> +	struct nvm_tgt_dev *dev = pblk->dev;
>> +	struct nvm_geo *geo = &dev->geo;
>> +	struct nvm_chk_meta *chunk;
>> +	struct ppa_addr ppa;
>> +	int i, pos;
>> +	int min = pblk->min_write_pgs;
>> +	u64 paddr = line->emeta_ssec;
>> +
>> +	for (i = 0; i < lm->emeta_sec[0]; i++, paddr++) {
>> +		ppa = addr_to_gen_ppa(pblk, paddr, line->id);
>> +		pos = pblk_ppa_to_pos(geo, ppa);
>> +		while (test_bit(pos, line->blk_bitmap)) {
>> +			paddr += min;
>> +			ppa = addr_to_gen_ppa(pblk, paddr, line->id);
>> +			pos = pblk_ppa_to_pos(geo, ppa);
>> +		}
>> +		chunk = &line->chks[pos];
>> +
>> +		if (!(chunk->state & NVM_CHK_ST_CLOSED ||
>> +		    (chunk->state & NVM_CHK_ST_OPEN
>> +		     && chunk->wp > ppa.m.sec)))
>> +			return 0;
>> +	}
>>
>> 	return 1;
>> }
>> @@ -788,6 +822,11 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
>> 			goto next;
>> 		}
>>
>> +		if (!pblk_line_was_emeta_written(line, pblk)) {
>> +			pblk_recov_l2p_from_oob(pblk, line);
>> +			goto next;
>> +		}
>> +
>> 		if (pblk_line_emeta_read(pblk, line, line->emeta->buf)) {
>> 			pblk_recov_l2p_from_oob(pblk, line);
>> 			goto next;
>> --
>> 2.9.5
> 
>   I would like to avoid iterating on all chunks again an again to check
>   for different things at boot time. What do you think having this as
>   something like PBLK_LINESTATE_OPEN_INVALID or
>   PBLK_LINESTATE_OPEN_NONRECOV, which you populate when collecting the
>   chunk information? Then this becomes a simple check as opposed to the
>   extra chunk iteration?
> 

Ok, will work on sth different.

> On the check itself: Is this done for completeness or have you hit a
> case that is not covered by the smeta/emeta CRC protection?
> 

So generally my goal here was to avoid reading blank sectors if not needed.

> 
