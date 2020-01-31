Return-Path: <SRS0=MKaG=3U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46977C2D0DB
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 18:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9E920CC7
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 18:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgAaSvo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:51:44 -0500
Received: from mga03.intel.com ([134.134.136.65]:48951 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgAaSvo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Jan 2020 13:51:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2020 10:51:43 -0800
X-IronPort-AV: E=Sophos;i="5.70,386,1574150400"; 
   d="scan'208";a="223229675"
Received: from ajakowsk-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.78.25.164])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jan 2020 10:51:43 -0800
Subject: Re: [PATCH 1/2] block: introduce polling on bio level
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, song@kernel.org, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>
References: <20200126044138.5066-1-andrzej.jakowski@linux.intel.com>
 <20200126044138.5066-2-andrzej.jakowski@linux.intel.com>
 <20200131063407.GB6267@infradead.org>
From:   Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Message-ID: <081badca-ab0f-f666-1e5e-71992f93a157@linux.intel.com>
Date:   Fri, 31 Jan 2020 11:51:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200131063407.GB6267@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/30/20 11:34 PM, Christoph Hellwig wrote:
> Can you explain this check?  This looks weird to me  I think we need
> a generalized check if a make_request based driver supports REQ_NOWAIT
> instead (and as a separate patch / patchset).

Original check used to reject polled IO for stackable block devices as 
"not supported". To solve that situation I introduced additional check 
to reject all non REQ_HIPRI requests. That check is not intended to 
generalize, like you indicated, but to conservatively select which 
requests to accept.
Perhaps there is better way to do that. Any suggestions?

