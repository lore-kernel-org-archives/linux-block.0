Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E80C10F03
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 11:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8996520872
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 11:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbfCYLM2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:12:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:63136 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730785AbfCYLM1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 07:12:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 04:12:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="154936391"
Received: from ikonopko-mobl1.ger.corp.intel.com (HELO [10.237.142.109]) ([10.237.142.109])
  by fmsmga002.fm.intel.com with ESMTP; 25 Mar 2019 04:12:26 -0700
Subject: Re: [PATCH v2 04/16] lightnvm: pblk: OOB recovery for closed chunks
 fix
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Cc:     Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
References: <20190322144843.9602-1-igor.j.konopko@intel.com>
 <20190322144843.9602-5-igor.j.konopko@intel.com>
 <652D902B-21C8-4599-8298-F73E0620CC95@javigon.com>
From:   Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <64d5fe55-b8ce-da89-8459-5ef3cafc2226@intel.com>
Date:   Mon, 25 Mar 2019 12:12:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <652D902B-21C8-4599-8298-F73E0620CC95@javigon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 25.03.2019 07:02, Javier González wrote:
>> On 22 Mar 2019, at 22.48, Igor Konopko <igor.j.konopko@intel.com> wrote:
>>
>> In case of OOB recovery, when some of the chunks are in closed state,
>> we are calculating number of written sectors in line incorrectly,
>> because we are always counting chunk WP, which for closed chunks
>> does not longer reflects written sectors in particular chunk. Based on
>> OCSSD 2.0 spec WP for closed chunks is equal to SLBA + NLB and here we
>> need only NLB (clba in code) value for calculation. This patch for such
>> a chunks takes clba field instead.
>>
>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>> ---
>> drivers/lightnvm/pblk-recovery.c | 8 +++++++-
>> 1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
>> index 83b467b..bcd3633 100644
>> --- a/drivers/lightnvm/pblk-recovery.c
>> +++ b/drivers/lightnvm/pblk-recovery.c
>> @@ -101,6 +101,8 @@ static void pblk_update_line_wp(struct pblk *pblk, struct pblk_line *line,
>>
>> static u64 pblk_sec_in_open_line(struct pblk *pblk, struct pblk_line *line)
>> {
>> +	struct nvm_tgt_dev *dev = pblk->dev;
>> +	struct nvm_geo *geo = &dev->geo;
>> 	struct pblk_line_meta *lm = &pblk->lm;
>> 	int nr_bb = bitmap_weight(line->blk_bitmap, lm->blk_per_line);
>> 	u64 written_secs = 0;
>> @@ -113,7 +115,11 @@ static u64 pblk_sec_in_open_line(struct pblk *pblk, struct pblk_line *line)
>> 		if (chunk->state & NVM_CHK_ST_OFFLINE)
>> 			continue;
>>
>> -		written_secs += chunk->wp;
>> +		if (chunk->state & NVM_CHK_ST_OPEN)
>> +			written_secs += chunk->wp;
>> +		else if (chunk->state & NVM_CHK_ST_CLOSED)
>> +			written_secs += geo->clba;
>> +
>> 		valid_chunks++;
>> 	}
>>
>> --
>> 2.9.5
> 
> Didn’t we agree that the patch was not needed?
> 

I hope I explained what was my motivation for doing this changes. And 
don't know honestly if we should fix this here or in the spec, so that's 
why I send it with v2 too. Matias should decide.

> 
