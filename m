Return-Path: <SRS0=/0DQ=4Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DE7C3F2CD
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 23:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1A82469C
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 23:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgB1XMI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:12:08 -0500
Received: from mga18.intel.com ([134.134.136.126]:17323 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbgB1XMI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Feb 2020 18:12:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 15:12:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,497,1574150400"; 
   d="scan'208";a="272824147"
Received: from unknown (HELO [10.232.112.171]) ([10.232.112.171])
  by fmsmga002.fm.intel.com with ESMTP; 28 Feb 2020 15:12:06 -0800
Subject: Re: [PATCH] block: sed-opal: Change the check condition for regular
 session validity
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     "andrzej.jakowski@linux.intel.com" <andrzej.jakowski@linux.intel.com>,
        "sbauer@plzdonthack.me" <sbauer@plzdonthack.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "Jakowski, Andrzej" <andrzej.jakowski@intel.com>
References: <20200228224225.61368-1-revanth.rajashekar@intel.com>
 <558ea751133ec0407cd603bae27416042bd1e435.camel@intel.com>
 <68f27a5e-a39b-3c3e-dbb3-ce0c6b56f33c@intel.com>
 <2143472fa237e9c636143e4ae6aa2a989fa8984b.camel@intel.com>
From:   "Rajashekar, Revanth" <revanth.rajashekar@intel.com>
Message-ID: <81fcc5af-7599-739f-3b08-4e6cd05561da@intel.com>
Date:   Fri, 28 Feb 2020 16:12:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <2143472fa237e9c636143e4ae6aa2a989fa8984b.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 2/28/2020 4:07 PM, Derrick, Jonathan wrote:
> On Fri, 2020-02-28 at 16:01 -0700, Rajashekar, Revanth wrote:
>> Hi Jon,
>>
>> On 2/28/2020 3:57 PM, Derrick, Jonathan wrote:
>>> Hi Revanth
>>>
>>> On Fri, 2020-02-28 at 15:42 -0700, Revanth Rajashekar wrote:
>>>> This patch changes the check condition for the validity/authentication
>>>> of the session.
>>>>
>>>> 1. The Host Session Number(HSN) in the response should match the HSN for
>>>>    the session.
>>>> 2. The TPER Session Number(TSN) can never be less than 4096 for a regular
>>>>    session.
>>>>
>>>> Reference:
>>>> Section 3.2.2.1   of https://trustedcomputinggroup.org/wp-content/uploads/TCG_Storage_Opal_SSC_Application_Note_1-00_1-00-Final.pdf
>>>> Section 3.3.7.1.1 of https://trustedcomputinggroup.org/wp-content/uploads/TCG_Storage_Architecture_Core_Spec_v2.01_r1.00.pdf
>>>>
>>>> Co-developed-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
>>>> Signed-off-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
>>>> Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
>>>> ---
>>>>  block/opal_proto.h | 1 +
>>>>  block/sed-opal.c   | 2 +-
>>>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/block/opal_proto.h b/block/opal_proto.h
>>>> index 325cbba2465f..27740baad61d 100644
>>>> --- a/block/opal_proto.h
>>>> +++ b/block/opal_proto.h
>>>> @@ -36,6 +36,7 @@ enum opal_response_token {
>>>>
>>>>  #define DTAERROR_NO_METHOD_STATUS 0x89
>>>>  #define GENERIC_HOST_SESSION_NUM 0x41
>>>> +#define RSVD_TPER_SESSION_NUM	4096
>>> This seems confusing as it looks like 4096 the Reserved session rather
>>> than 0-4095.
>>> Can you name it appropriately?
>> Sure, do you think INIT_TPER_SESSION_NUM would be appropriate..?
> Init could be confused with Initialize
> Maybe MIN_TPER_SESSION_NUM or FIRST_... ?
FIRST_TPER_SESSION_NUM sounds good for me :)
>
> Thanks for thinking about this.
Sure...
>
>>>>  #define TPER_SYNC_SUPPORTED 0x01
>>>>  #define MBR_ENABLED_MASK 0x10
>>>> diff --git a/block/sed-opal.c b/block/sed-opal.c
>>>> index 880cc57a5f6b..f2b61a868901 100644
>>>> --- a/block/sed-opal.c
>>>> +++ b/block/sed-opal.c
>>>> @@ -1056,7 +1056,7 @@ static int start_opal_session_cont(struct opal_dev *dev)
>>>>  	hsn = response_get_u64(&dev->parsed, 4);
>>>>  	tsn = response_get_u64(&dev->parsed, 5);
>>>>
>>>> -	if (hsn == 0 && tsn == 0) {
>>>> +	if (hsn != GENERIC_HOST_SESSION_NUM || tsn < RSVD_TPER_SESSION_NUM) {
>>>>  		pr_debug("Couldn't authenticate session\n");
>>>>  		return -EPERM;
>>>>  	}
>>>> --
>>>> 2.17.1
>>>>
