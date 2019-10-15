Return-Path: <SRS0=Qtc1=YI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2DCECE588
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 15:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA4C2086A
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 15:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732528AbfJOP65 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Oct 2019 11:58:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:19886 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfJOP65 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Oct 2019 11:58:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 08:58:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,300,1566889200"; 
   d="scan'208";a="396854430"
Received: from unknown (HELO [10.232.112.172]) ([10.232.112.172])
  by fmsmga006.fm.intel.com with ESMTP; 15 Oct 2019 08:58:56 -0700
Subject: Re: [PATCH] nvme: resync include/linux/nvme.h with nvmecli
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20191014171607.29162-1-revanth.rajashekar@intel.com>
 <20191015075642.GA32307@infradead.org> <20191015075711.GB32307@infradead.org>
From:   "Rajashekar, Revanth" <revanth.rajashekar@intel.com>
Message-ID: <221d39c9-0b5a-4f37-c5db-57902cfaa557@intel.com>
Date:   Tue, 15 Oct 2019 09:58:56 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191015075711.GB32307@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 10/15/2019 1:57 AM, Christoph Hellwig wrote:
> On Tue, Oct 15, 2019 at 12:56:42AM -0700, Christoph Hellwig wrote:
>> On Mon, Oct 14, 2019 at 11:16:07AM -0600, Revanth Rajashekar wrote:
>>> Update enumerations and structures in include/linux/nvme.h
>>> to resync with the nvmecli.
>>>
>>> All the updates are mentioned in the ratified NVMe 1.4 spec
>>> https://nvmexpress.org/wp-content/uploads/NVM-Express-1_4-2019.06.10-Ratified.pdf
>>>
>>> Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
>> Looks good:
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Oh. but for this to be picked up please resend it to
> linux-nvme@lists.infradead.org

Sent out to NVMe mailing list :)

