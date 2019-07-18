Return-Path: <SRS0=jAbK=VP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2393EC7618F
	for <linux-block@archiver.kernel.org>; Thu, 18 Jul 2019 15:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD62217F4
	for <linux-block@archiver.kernel.org>; Thu, 18 Jul 2019 15:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfGRPzW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jul 2019 11:55:22 -0400
Received: from ale.deltatee.com ([207.54.116.67]:43482 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfGRPzW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jul 2019 11:55:22 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1ho8kS-0003pV-83; Thu, 18 Jul 2019 09:55:13 -0600
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Omar Sandoval <osandov@fb.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Michael Moese <mmoese@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Stephen Bates <sbates@raithlin.com>
References: <20190717171259.3311-1-logang@deltatee.com>
 <20190717171259.3311-4-logang@deltatee.com>
 <20190718070330.GC15760@x250.microfocus.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <1c81c160-7c32-7a88-53ae-ea54030b8d19@deltatee.com>
Date:   Thu, 18 Jul 2019 09:55:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190718070330.GC15760@x250.microfocus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: sbates@raithlin.com, tytso@mit.edu, mmoese@suse.de, chaitanya.kulkarni@wdc.com, osandov@fb.com, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, jthumshirn@suse.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH blktests v2 03/12] nvme: Add new test to verify the
 generation counter
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2019-07-18 1:03 a.m., Johannes Thumshirn wrote:
> On Wed, Jul 17, 2019 at 11:12:50AM -0600, Logan Gunthorpe wrote:
> [...]
>> +_discovery_genctr() {
>> +	nvme discover -t loop |
>> +		sed -n -e 's/^.*Generation counter \([0-9]\+\).*$/\1/p'
>> +}
> 
> Sorry for not having spotted this in v1, but do we really want to hard-core
> the transport type in a library function?

My opinion is that this is unnecessary until we have users of the
function that need different transport types. It's easy enough for
someone to change when they need it. It's a pretty standard practice in
kernel development to not add a feature that no-one uses.

Logan
