Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C84C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 17:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877982133F
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 17:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbeLRR3D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:29:03 -0500
Received: from mga02.intel.com ([134.134.136.20]:28382 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbeLRR3C (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 12:29:02 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 09:29:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,368,1539673200"; 
   d="scan'208";a="119841722"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga001.jf.intel.com with ESMTP; 18 Dec 2018 09:29:01 -0800
Date:   Tue, 18 Dec 2018 10:26:46 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     yupeng <yupeng0921@gmail.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>
Subject: Re: [PATCH v4 2/2] trace nvme submit queue status
Message-ID: <20181218172645.GB13768@localhost.localdomain>
References: <20181218045138.4282-1-yupeng0921@gmail.com>
 <20181218045138.4282-2-yupeng0921@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218045138.4282-2-yupeng0921@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 17, 2018 at 08:51:38PM -0800, yupeng wrote:
> +TRACE_EVENT(nvme_sq,
> +	TP_PROTO(void *rq_disk, int qid, int sq_head, int sq_tail),
> +	TP_ARGS(rq_disk, qid, sq_head, sq_tail),
> +	TP_STRUCT__entry(
> +		__array(char, disk, DISK_NAME_LEN)
> +		__field(int, qid)
> +		__field(int, sq_head)
> +		__field(int, sq_tail)
> +	),
> +	TP_fast_assign(
> +		__assign_disk_name(__entry->disk, rq_disk);
> +		__entry->qid = qid;
> +		__entry->sq_head = sq_head;
> +		__entry->sq_tail = sq_tail;
> +	),
> +	TP_printk("nvme: %s qid=%d head=%d tail=%d",
> +		__print_disk_name(__entry->disk),

No need for a space after the %s. __print_disk_name already appends a
space if there's a disk name, and we don't want the extra space if there
isn't one. Also, every other nvme trace has a ',' after each entry. Not
a big deal, just minor format consistency.
