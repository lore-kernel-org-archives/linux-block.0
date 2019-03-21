Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EF9C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 13:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C6A218FF
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 13:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfCUNVw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:21:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:37867 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728113AbfCUNVw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 09:21:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 06:21:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,252,1549958400"; 
   d="scan'208";a="216205234"
Received: from ikonopko-mobl1.ger.corp.intel.com (HELO [10.237.142.155]) ([10.237.142.155])
  by orsmga001.jf.intel.com with ESMTP; 21 Mar 2019 06:21:50 -0700
Subject: Re: [PATCH 15/18] lightnvm: pblk: fix in case of lack of lines
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Cc:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-16-igor.j.konopko@intel.com>
 <FFE27E31-83ED-41CB-9D6C-327C3E3BA7D9@javigon.com>
 <b6536c70-2593-7751-de3d-beba51dad092@intel.com>
 <0983C3F3-0141-43B4-A97D-A4ACB797E4D0@javigon.com>
From:   Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <c6e06dee-42b1-6fdc-2993-280acb121d54@intel.com>
Date:   Thu, 21 Mar 2019 14:21:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <0983C3F3-0141-43B4-A97D-A4ACB797E4D0@javigon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 18.03.2019 20:21, Javier González wrote:
> 
>> On 18 Mar 2019, at 14.28, Igor Konopko <igor.j.konopko@intel.com> wrote:
>>
>>
>>
>> On 18.03.2019 08:42, Javier González wrote:
>>>> On 14 Mar 2019, at 17.04, Igor Konopko <igor.j.konopko@intel.com> wrote:
>>>>
>>>> In case when mapping fails (called from writer thread) due to lack of
>>>> lines, currently we are calling pblk_pipeline_stop(), which waits
>>>> for pending write IOs, so it will lead to the deadlock. Switching
>>>> to __pblk_pipeline_stop() in that case instead will fix that.
>>>>
>>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>>> ---
>>>> drivers/lightnvm/pblk-map.c | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
>>>> index 5408e32..afc10306 100644
>>>> --- a/drivers/lightnvm/pblk-map.c
>>>> +++ b/drivers/lightnvm/pblk-map.c
>>>> @@ -46,7 +46,7 @@ static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
>>>> 		pblk_line_close_meta(pblk, prev_line);
>>>>
>>>> 		if (!line) {
>>>> -			pblk_pipeline_stop(pblk);
>>>> +			__pblk_pipeline_stop(pblk);
>>>> 			return -ENOSPC;
>>>> 		}
>>>>
>>>> --
>>>> 2.9.5
>>> Have you seeing this problem?
>>> Before checking if there is a line, we are closing metadata for the
>>> previous line, so all inflight I/Os should be clear. Can you develop on
>>> the case in which this would happen?
>>
>> So we have following sequence: pblk_pipeline_stop() -> __pblk_pipeline_flush() -> pblk_flush_writer() -> wait for emptying round buffer.
>> This will never complete, since we still have some RB entries, which cannot be written since writer thread is blocked with waiting inside pblk_flush_writer().
>>
>> Am I missing sth?
> 
> So this will be the case in which we are in the last line and
> pblk_flush_writer() needs to allocate an extra line persist the write
> buffer? Shouldn’t the rate-limiter take care of this? As I recall, Hans
> implemented some logic to guarantee that at least one line is always
> available for GC, which in turn will free a line for user data. When we
> hit this limit, performance will drop dramatically, but it should not
> stall.
> 
> The reason I want to understand the real case behind this fix is that by
> calling __pblk_pipeline_stop() we are basically stopping all other
> inflight I/Os; we should be able to serve all inflight I/Os before a
> mapping error triggers the pipeline to get into read-only mode.
> 

Javier,
my understanding was that if we hit that particular case, we are simply 
"done" with pblk and there is no way to recover it, so I made this 
changes based on code analysis, if it is not true, than this patch does 
not make sense anymore.

Hans,
could you help me to understand how rate limiter ensure that what Javier 
mentioned about? Thanks
