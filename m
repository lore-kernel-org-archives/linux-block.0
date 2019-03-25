Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E02C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 11:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F021207DD
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 11:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbfCYLRI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:17:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:59526 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729727AbfCYLRI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 07:17:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 04:17:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="154937695"
Received: from ikonopko-mobl1.ger.corp.intel.com (HELO [10.237.142.109]) ([10.237.142.109])
  by fmsmga002.fm.intel.com with ESMTP; 25 Mar 2019 04:17:06 -0700
Subject: Re: [PATCH v2 07/16] lightnvm: pblk: wait for inflight IOs in
 recovery
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
References: <20190322144843.9602-1-igor.j.konopko@intel.com>
 <20190322144843.9602-8-igor.j.konopko@intel.com>
 <759E29D3-9FEA-4A9B-875A-360DB96335C9@javigon.com>
From:   Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <a1913345-897d-6309-f08b-9f55c97849d1@intel.com>
Date:   Mon, 25 Mar 2019 12:17:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <759E29D3-9FEA-4A9B-875A-360DB96335C9@javigon.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 25.03.2019 07:18, Javier González wrote:
> 
>> On 22 Mar 2019, at 22.48, Igor Konopko <igor.j.konopko@intel.com> wrote:
>>
>> This patch changes the behaviour of recovery padding in order to
>> support a case, when some IOs were already submitted to the drive and
>> some next one are not submitted due to error returned.
>>
>> Currently in case of errors we simply exit the pad function without
>> waiting for inflight IOs, which leads to panic on inflight IOs
>> completion.
>>
>> After the changes we always wait for all the inflight IOs before
>> exiting the function.
>>
>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>> ---
>> drivers/lightnvm/pblk-recovery.c | 25 ++++++++++++-------------
>> 1 file changed, 12 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
>> index b2267bd..f7e383e 100644
>> --- a/drivers/lightnvm/pblk-recovery.c
>> +++ b/drivers/lightnvm/pblk-recovery.c
>> @@ -200,7 +200,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
>> 	rq_ppas = pblk_calc_secs(pblk, left_ppas, 0, false);
>> 	if (rq_ppas < pblk->min_write_pgs) {
>> 		pblk_err(pblk, "corrupted pad line %d\n", line->id);
>> -		goto fail_free_pad;
>> +		goto fail_complete;
>> 	}
>>
>> 	rq_len = rq_ppas * geo->csecs;
>> @@ -209,7 +209,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
>> 						PBLK_VMALLOC_META, GFP_KERNEL);
>> 	if (IS_ERR(bio)) {
>> 		ret = PTR_ERR(bio);
>> -		goto fail_free_pad;
>> +		goto fail_complete;
>> 	}
>>
>> 	bio->bi_iter.bi_sector = 0; /* internal bio */
>> @@ -218,8 +218,11 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
>> 	rqd = pblk_alloc_rqd(pblk, PBLK_WRITE_INT);
>>
>> 	ret = pblk_alloc_rqd_meta(pblk, rqd);
>> -	if (ret)
>> -		goto fail_free_rqd;
>> +	if (ret) {
>> +		pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
>> +		bio_put(bio);
>> +		goto fail_complete;
>> +	}
>>
>> 	rqd->bio = bio;
>> 	rqd->opcode = NVM_OP_PWRITE;
>> @@ -266,7 +269,10 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
>> 	if (ret) {
>> 		pblk_err(pblk, "I/O submission failed: %d\n", ret);
>> 		pblk_up_chunk(pblk, rqd->ppa_list[0]);
>> -		goto fail_free_rqd;
>> +		kref_put(&pad_rq->ref, pblk_recov_complete);
> 
> Are you sure you need this? You are putting the reference on
> fail_complete: already.
> 

On fail_complete: I'm always putting the "extra" reference which comes 
from kref_init() call in line 214 (no changes here which existing behavior).

Here I'm putting the reference taken for a single request in line 283, 
which for successfully submitted IOs is released in pblk_end_io_recov() 
in line 177.

>> +		pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
>> +		bio_put(bio);
>> +		goto fail_complete;
>> 	}
>>
>> 	left_line_ppas -= rq_ppas;
>> @@ -274,6 +280,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
>> 	if (left_ppas && left_line_ppas)
>> 		goto next_pad_rq;
>>
>> +fail_complete:
>> 	kref_put(&pad_rq->ref, pblk_recov_complete);
>>
>> 	if (!wait_for_completion_io_timeout(&pad_rq->wait,
>> @@ -289,14 +296,6 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
>> free_rq:
>> 	kfree(pad_rq);
>> 	return ret;
>> -
>> -fail_free_rqd:
>> -	pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
>> -	bio_put(bio);
>> -fail_free_pad:
>> -	kfree(pad_rq);
>> -	vfree(data);
>> -	return ret;
>> }
>>
>> static int pblk_pad_distance(struct pblk *pblk, struct pblk_line *line)
>> --
>> 2.9.5
> 
> Rest looks good
> 
