Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17411 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752296AbdKHNUg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 8 Nov 2017 08:20:36 -0500
Subject: Re: [PATCH V13 04/10] mmc: block: Add CQE support
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bough Chen <haibo.chen@nxp.com>,
        Alex Lemberg <alex.lemberg@sandisk.com>,
        Mateusz Nowak <mateusz.nowak@intel.com>,
        Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Dong Aisheng <dongas86@gmail.com>,
        Das Asutosh <asutoshd@codeaurora.org>,
        Zhangfei Gao <zhangfei.gao@gmail.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Venu Byravarasu <vbyravarasu@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Christoph Hellwig <hch@lst.de>
References: <1509715220-31885-1-git-send-email-adrian.hunter@intel.com>
 <1509715220-31885-5-git-send-email-adrian.hunter@intel.com>
 <CACRpkda8znQ=jAN-b_SCMzSJU11PZwEyw6dzOE07T-2hf9T6XA@mail.gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <24ce2510-0b66-a9ff-ffd0-b04b095f7d1a@intel.com>
Date: Wed, 8 Nov 2017 15:20:21 +0200
MIME-Version: 1.0
In-Reply-To: <CACRpkda8znQ=jAN-b_SCMzSJU11PZwEyw6dzOE07T-2hf9T6XA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/11/17 11:00, Linus Walleij wrote:
> On Fri, Nov 3, 2017 at 2:20 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> 
>> @@ -2188,11 +2327,18 @@ enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
>>                         return MMC_REQ_FAILED_TO_START;
>>                 }
>>                 return MMC_REQ_FINISHED;
>> +       case MMC_ISSUE_DCMD:
>>         case MMC_ISSUE_ASYNC:
>>                 switch (req_op(req)) {
>> +               case REQ_OP_FLUSH:
>> +                       ret = mmc_blk_cqe_issue_flush(mq, req);
>> +                       break;
>>                 case REQ_OP_READ:
>>                 case REQ_OP_WRITE:
>> -                       ret = mmc_blk_mq_issue_rw_rq(mq, req);
>> +                       if (mq->use_cqe)
>> +                               ret = mmc_blk_cqe_issue_rw_rq(mq, req);
>> +                       else
>> +                               ret = mmc_blk_mq_issue_rw_rq(mq, req);
>>                         break;
>>                 default:
>>                         WARN_ON_ONCE(1);
> 
> This and other bits gives me the feeling CQE is now actually ONLY
> working on the MQ path.

I was not allowed to support non-mq.

> 
> That is good. We only add new functionality on the MQ path,
> yay!
> 
> But this fact (only abailable iff MQ==true) should at least be
> mentioned in the commit message I think?

Why?  CQE is MQ only.

> 
> So why not ditch the old block layer or at least make MQ default?

CQE is MQ only.

> 
> When you keep it like this people have to reconfigure
> their kernel to enable MQ before they see the benefits of MQ+CQE
> combined, I think that should rather be the default experience.

Not at all.  I guess you are confusing the legacy mmc with CQE.  CQE is not
a layer on top of legacy mmc.  It is an alternative to legacy mmc.  CQE
does not sit on top of the legacy mmc blk-mq support.  You don't have to
enable legacy mmc blk-mq support to use CQE.
