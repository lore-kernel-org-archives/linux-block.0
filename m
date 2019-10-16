Return-Path: <SRS0=Rbhm=YJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA7CFA372A
	for <linux-block@archiver.kernel.org>; Wed, 16 Oct 2019 15:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D60521928
	for <linux-block@archiver.kernel.org>; Wed, 16 Oct 2019 15:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391505AbfJPP7l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:59:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:36652 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729646AbfJPP7l (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Oct 2019 11:59:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 08:59:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,304,1566889200"; 
   d="scan'208";a="198994074"
Received: from unknown (HELO [10.232.112.141]) ([10.232.112.141])
  by orsmga003.jf.intel.com with ESMTP; 16 Oct 2019 08:59:40 -0700
Subject: Re: [PATCH v2 1/3] block: sed-opal: Expose enum opal_uid and opaluid
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        Jonas Rabenstine <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>,
        Jens Axboe <axboe@kernel.dk>
References: <20191015230246.10171-1-revanth.rajashekar@intel.com>
 <20191015230246.10171-2-revanth.rajashekar@intel.com>
 <20191016063140.GA6852@infradead.org>
From:   "Rajashekar, Revanth" <revanth.rajashekar@intel.com>
Message-ID: <b5279887-e6e3-b74e-147a-644ad6c00853@intel.com>
Date:   Wed, 16 Oct 2019 09:59:40 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191016063140.GA6852@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 10/16/2019 12:31 AM, Christoph Hellwig wrote:
> On Tue, Oct 15, 2019 at 05:02:44PM -0600, Revanth Rajashekar wrote:
>> This patch exposes UIDs to UAPI to allow userspace to use the
>> UIDs as IOCTL arguments.
> No way we'd expose an actual array containing data in the uapi, that
> doesn't make any sense.

Will drop this patch and resend the set.

Also, will wait for the rest of the maintainers' comments.

