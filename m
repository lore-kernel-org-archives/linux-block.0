Return-Path: <SRS0=keWk=7B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3F4C433E3
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 15:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AC2D2075F
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 15:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbgESPai (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 May 2020 11:30:38 -0400
Received: from verein.lst.de ([213.95.11.211]:44598 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728847AbgESPag (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 11:30:36 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2C09668B02; Tue, 19 May 2020 17:30:35 +0200 (CEST)
Date:   Tue, 19 May 2020 17:30:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     John Garry <john.garry@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: blk-mq: improvement CPU hotplug (simplified version) v2
Message-ID: <20200519153034.GC22286@lst.de>
References: <20200518063937.757218-1-hch@lst.de> <6241656e-0bf7-b32d-493e-e3f870a4d031@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6241656e-0bf7-b32d-493e-e3f870a4d031@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 18, 2020 at 12:49:14PM +0100, John Garry wrote:
>> A git tree is available here:
>>
>>      git://git.infradead.org/users/hch/block.git blk-mq-hotplug
>>
>> Gitweb:
>>
>>      http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/blk-mq-hotplug
>> .
>>
>
> FWIW, I tested this series for cpu hotplug and it looked ok.

Can you also test the blk-mq-hotplug.2 branch?
