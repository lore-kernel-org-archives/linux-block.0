Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A365DC43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 17:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6BA217D9
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 17:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbeLRRDP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:03:15 -0500
Received: from verein.lst.de ([213.95.11.211]:41971 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbeLRRDP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 12:03:15 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A438B68D8D; Tue, 18 Dec 2018 18:03:13 +0100 (CET)
Date:   Tue, 18 Dec 2018 18:03:13 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     peng yu <yupeng0921@gmail.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, axboe@fb.com, hch@lst.de, jthumshirn@suse.de
Subject: Re: [PATCH v4 2/2] trace nvme submit queue status
Message-ID: <20181218170313.GA13540@lst.de>
References: <20181218045138.4282-1-yupeng0921@gmail.com> <20181218045138.4282-2-yupeng0921@gmail.com> <24f78f57-9786-effd-6ffe-f9a556211898@grimberg.me> <CAG3TDc1Od_aAq7VC5y_cu0mms2muzWXrBv-fCsHQkXEdXsBmoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG3TDc1Od_aAq7VC5y_cu0mms2muzWXrBv-fCsHQkXEdXsBmoQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 17, 2018 at 11:44:51PM -0800, peng yu wrote:
> Sorry, I don't quite understand your meaning. Do you mean I'd better
> change this:
>         trace_nvme_sq(req->rq_disk,
>                 nvmeq->qid,
>                 le16_to_cpu(cqe->sq_head),
>                 nvmeq->sq_tail);
> to something like below:
>         trace_nvme_sq(req->rq_disk, nvmeq->qid, le16_to_cpu(cqe->sq_head),
>                 nvmeq->sq_tail);
> Please let me know whether my understanding is correct.

Yes.  Let me know if this version that I've applied is fine with you:

http://git.infradead.org/nvme.git/commitdiff/ed537628e59166a080d618825a7d175565a9cad4
