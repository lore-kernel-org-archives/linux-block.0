Return-Path: <SRS0=tltz=RJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DB0C43381
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 14:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B12820675
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 14:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfCFOWj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:22:39 -0500
Received: from mga07.intel.com ([134.134.136.100]:50237 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbfCFOWj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Mar 2019 09:22:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2019 06:22:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,448,1544515200"; 
   d="scan'208";a="324746953"
Received: from ikonopko-mobl1.ger.corp.intel.com (HELO [10.237.142.133]) ([10.237.142.133])
  by fmsmga006.fm.intel.com with ESMTP; 06 Mar 2019 06:22:36 -0800
Subject: Re: [PATCH v2 3/8] lightnvm: pblk: Count all read errors in stats
To:     Hans Holmberg <hans@owltronix.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
References: <20190305135120.29284-1-igor.j.konopko@intel.com>
 <20190305135120.29284-4-igor.j.konopko@intel.com>
 <7739757A-D33E-4E82-A050-09CBB32EDE46@javigon.com>
 <CANr-nt1U5Ucygm2YCg5wPKZHDdB+iM_uH-t4Mr=c_OzwTzrt7A@mail.gmail.com>
From:   Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <1f561382-de0e-2596-538d-740f9af7c9cc@intel.com>
Date:   Wed, 6 Mar 2019 15:22:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CANr-nt1U5Ucygm2YCg5wPKZHDdB+iM_uH-t4Mr=c_OzwTzrt7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 06.03.2019 15:19, Hans Holmberg wrote:
> On Wed, Mar 6, 2019 at 8:28 AM Javier González <javier@javigon.com> wrote:
>>
>>> On 5 Mar 2019, at 14.51, Igor Konopko <igor.j.konopko@intel.com> wrote:
>>>
>>> Currently when unknown error occurs on read path there is only dmesg
>>> information about it, but it is not counted in sysfs statistics.
>>>
>>> We would also like to track the number of such a requests, so new type
>>> of counter 'read_ctrl_errors" is added in that patch.
>>>
>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>> ---
>>> drivers/lightnvm/pblk-core.c  | 1 +
>>> drivers/lightnvm/pblk-init.c  | 1 +
>>> drivers/lightnvm/pblk-sysfs.c | 3 ++-
>>> drivers/lightnvm/pblk.h       | 1 +
>>> 4 files changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
>>> index 39280c1..64280e6 100644
>>> --- a/drivers/lightnvm/pblk-core.c
>>> +++ b/drivers/lightnvm/pblk-core.c
>>> @@ -493,6 +493,7 @@ void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd)
>>>                atomic_long_inc(&pblk->read_failed);
>>>                break;
>>>        default:
>>> +             atomic_long_inc(&pblk->read_ctrl_errors);
>>>                pblk_err(pblk, "unknown read error:%d\n", rqd->error);
>>>        }
>>> #ifdef CONFIG_NVM_PBLK_DEBUG
>>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
>>> index 81e8ed4..f4b6d8f2 100644
>>> --- a/drivers/lightnvm/pblk-init.c
>>> +++ b/drivers/lightnvm/pblk-init.c
>>> @@ -1230,6 +1230,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
>>>        atomic_long_set(&pblk->read_empty, 0);
>>>        atomic_long_set(&pblk->read_high_ecc, 0);
>>>        atomic_long_set(&pblk->read_failed_gc, 0);
>>> +     atomic_long_set(&pblk->read_ctrl_errors, 0);
>>>        atomic_long_set(&pblk->write_failed, 0);
>>>        atomic_long_set(&pblk->erase_failed, 0);
>>>
>>> diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
>>> index 7d8958d..922273c 100644
>>> --- a/drivers/lightnvm/pblk-sysfs.c
>>> +++ b/drivers/lightnvm/pblk-sysfs.c
>>> @@ -94,11 +94,12 @@ static ssize_t pblk_sysfs_stats(struct pblk *pblk, char *page)
>>>        ssize_t sz;
>>>
>>>        sz = snprintf(page, PAGE_SIZE,
>>> -                     "read_failed=%lu, read_high_ecc=%lu, read_empty=%lu, read_failed_gc=%lu, write_failed=%lu, erase_failed=%lu\n",
>>> +                     "read_failed=%lu, read_high_ecc=%lu, read_empty=%lu, read_failed_gc=%lu, read_ctrl_errors=%lu, write_failed=%lu, erase_failed=%lu\n",
>>>                        atomic_long_read(&pblk->read_failed),
>>>                        atomic_long_read(&pblk->read_high_ecc),
>>>                        atomic_long_read(&pblk->read_empty),
>>>                        atomic_long_read(&pblk->read_failed_gc),
>>> +                     atomic_long_read(&pblk->read_ctrl_errors),
>>>                        atomic_long_read(&pblk->write_failed),
>>>                        atomic_long_read(&pblk->erase_failed));
>>>
>>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>>> index 381f074..6c82776 100644
>>> --- a/drivers/lightnvm/pblk.h
>>> +++ b/drivers/lightnvm/pblk.h
>>> @@ -684,6 +684,7 @@ struct pblk {
>>>        atomic_long_t read_empty;
>>>        atomic_long_t read_high_ecc;
>>>        atomic_long_t read_failed_gc;
>>> +     atomic_long_t read_ctrl_errors;
>>>        atomic_long_t write_failed;
>>>        atomic_long_t erase_failed;
>>>
>>> --
>>> 2.9.5
>>
>> The only nitpick would be that if any user space script is relying on
>> the syses output for the errors, this could break them. Maybe we could
>> add a sysfs version file to mange this? Otherwise, it looks good.
>>
>> Reviewed-by: Javier González <javier@javigon.com>
> 
> Agree with Javier here, as sysfs interfaces are supposed to be stable
> (in the absence of a version file), so adding one would be a good
> idea.
> 

Let's drop this patch then - it is not a critical modification, we can 
definitely leave without it.
