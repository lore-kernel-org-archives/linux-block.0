Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C902C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 12:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D877B2070B
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 12:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfCDMiP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:38:15 -0500
Received: from mga18.intel.com ([134.134.136.126]:7203 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfCDMiP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Mar 2019 07:38:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 04:38:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,440,1544515200"; 
   d="scan'208";a="119451626"
Received: from ikonopko-mobl1.ger.corp.intel.com (HELO [10.237.140.180]) ([10.237.140.180])
  by orsmga007.jf.intel.com with ESMTP; 04 Mar 2019 04:38:12 -0800
Subject: Re: [PATCH 02/13] lightnvm: pblk: Gracefully handle GC data malloc
 fail
To:     Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-3-igor.j.konopko@intel.com>
 <7EEAD803-201C-477E-8ACA-7F152BC3C455@javigon.com>
 <CANr-nt3w4UmOeRVeXLdq+yLGgLqcJ7Xa_Mvba=xqm1QoaUKMEw@mail.gmail.com>
From:   Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <287d779d-7a56-c59e-2d40-0a0b65e5804a@intel.com>
Date:   Mon, 4 Mar 2019 13:38:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CANr-nt3w4UmOeRVeXLdq+yLGgLqcJ7Xa_Mvba=xqm1QoaUKMEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 01.03.2019 13:50, Hans Holmberg wrote:
> On Thu, Feb 28, 2019 at 6:09 PM Javier González <javier@javigon.com> wrote:
>>
>>
>>
>>> On 27 Feb 2019, at 12.14, Igor Konopko <igor.j.konopko@intel.com> wrote:
>>>
>>> Currently when we fail on gc rq data allocation
>>> we simply skip the data which we wanted to move
>>> and finally move the line to free state and lose
>>> that data due to that. This patch move the data
>>> allocation to some earlier phase of GC, where we
>>> can still fail gracefully by moving line back
>>> to closed state.
>>>
>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>> ---
>>> drivers/lightnvm/pblk-gc.c | 19 +++++++++----------
>>> 1 file changed, 9 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
>>> index 3feadfd9418d..31fc1339faa8 100644
>>> --- a/drivers/lightnvm/pblk-gc.c
>>> +++ b/drivers/lightnvm/pblk-gc.c
>>> @@ -84,8 +84,6 @@ static void pblk_gc_line_ws(struct work_struct *work)
>>>        struct pblk_line_ws *gc_rq_ws = container_of(work,
>>>                                                struct pblk_line_ws, ws);
>>>        struct pblk *pblk = gc_rq_ws->pblk;
>>> -     struct nvm_tgt_dev *dev = pblk->dev;
>>> -     struct nvm_geo *geo = &dev->geo;
>>>        struct pblk_gc *gc = &pblk->gc;
>>>        struct pblk_line *line = gc_rq_ws->line;
>>>        struct pblk_gc_rq *gc_rq = gc_rq_ws->priv;
>>> @@ -93,13 +91,6 @@ static void pblk_gc_line_ws(struct work_struct *work)
>>>
>>>        up(&gc->gc_sem);
>>>
>>> -     gc_rq->data = vmalloc(array_size(gc_rq->nr_secs, geo->csecs));
>>> -     if (!gc_rq->data) {
>>> -             pblk_err(pblk, "could not GC line:%d (%d/%d)\n",
>>> -                                     line->id, *line->vsc, gc_rq->nr_secs);
>>> -             goto out;
>>> -     }
>>> -
>>>        /* Read from GC victim block */
>>>        ret = pblk_submit_read_gc(pblk, gc_rq);
>>>        if (ret) {
>>> @@ -189,6 +180,8 @@ static void pblk_gc_line_prepare_ws(struct work_struct *work)
>>>        struct pblk_line *line = line_ws->line;
>>>        struct pblk_line_mgmt *l_mg = &pblk->l_mg;
>>>        struct pblk_line_meta *lm = &pblk->lm;
>>> +     struct nvm_tgt_dev *dev = pblk->dev;
>>> +     struct nvm_geo *geo = &dev->geo;
>>>        struct pblk_gc *gc = &pblk->gc;
>>>        struct pblk_line_ws *gc_rq_ws;
>>>        struct pblk_gc_rq *gc_rq;
>>> @@ -247,9 +240,13 @@ static void pblk_gc_line_prepare_ws(struct work_struct *work)
>>>        gc_rq->nr_secs = nr_secs;
>>>        gc_rq->line = line;
>>>
>>> +     gc_rq->data = vmalloc(gc_rq->nr_secs * geo->csecs);
> 
> Why not use array_size to do the size calculation as before? It checks
> for overflows.
> Apart from this, the patch looks good to me.

Sure, you are right array_size should be used here in the same way as it 
was before. Will fix that in v2.

> 
>>> +     if (!gc_rq->data)
>>> +             goto fail_free_gc_rq;
>>> +
>>>        gc_rq_ws = kmalloc(sizeof(struct pblk_line_ws), GFP_KERNEL);
>>>        if (!gc_rq_ws)
>>> -             goto fail_free_gc_rq;
>>> +             goto fail_free_gc_data;
>>>
>>>        gc_rq_ws->pblk = pblk;
>>>        gc_rq_ws->line = line;
>>> @@ -281,6 +278,8 @@ static void pblk_gc_line_prepare_ws(struct work_struct *work)
>>>
>>>        return;
>>>
>>> +fail_free_gc_data:
>>> +     vfree(gc_rq->data);
>>> fail_free_gc_rq:
>>>        kfree(gc_rq);
>>> fail_free_lba_list:
>>> --
>>> 2.17.1
>>
>> Looks good to me.
>>
>> Reviewed-by: Javier González <javier@javigon.com>
