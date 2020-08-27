Return-Path: <SRS0=E5Vf=CF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBCFC433DF
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 16:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 947502080C
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 16:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ugyty4oM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgH0QO5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgH0QO5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Aug 2020 12:14:57 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED71C061264;
        Thu, 27 Aug 2020 09:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=e1CYi8h9cIcfFWE3IwWVVfAtEnrhdJEfYw9kxMmTqF4=; b=Ugyty4oMVrd/CQtmGftGd1GHb6
        aP9yz/7iv/vaDj3FW7ESNBCoYx3laUXuM5AV4erwj+OZQgdgnvrxa4PH8Hd2gXf/dCOSAoyNZ9WPu
        qRocjg9sCU/zF9nu5tx3vdHkPguoaS7u4wydF6xrUa3c75EDHa2FnOf0Yq6y22FjAWqpCM/j7PPCa
        bzB/ajdtu2nm89fAAAmawCjU0nvX4B/9d3GSeNBXn1cJMVKmwW9qfeBkoKcy9uSNwkPa2N593nl+x
        yWBm54w+j6VI/3ly+oNqHEYAYBAClr7AMdK1415pinIZnuatzQhubdkey/nZQBTQkzOR+r3xc4ZKQ
        8tWI8ghA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBKYA-0003Lq-Ca; Thu, 27 Aug 2020 16:14:54 +0000
Subject: Re: [PATCH v2] null_blk: add support for max open/active zone limit
 for zoned devices
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200827135018.63644-1-niklas.cassel@wdc.com>
 <6d9fb163-f9d9-1f2d-d88c-db9d3a6185b4@infradead.org>
 <CY4PR04MB37513D874343FBD2D682DA0DE7550@CY4PR04MB3751.namprd04.prod.outlook.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <068d4bad-6061-277d-48d3-82a907f8c4a2@infradead.org>
Date:   Thu, 27 Aug 2020 09:14:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CY4PR04MB37513D874343FBD2D682DA0DE7550@CY4PR04MB3751.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/27/20 8:04 AM, Damien Le Moal wrote:
> On 2020/08/27 23:51, Randy Dunlap wrote:
>> On 8/27/20 6:50 AM, Niklas Cassel wrote:
>>> Add support for user space to set a max open zone and a max active zone
>>> limit via configfs. By default, the default values are 0 == no limit.
>>
>> Hi,
>>
>> How does a user find out about how to use/set these limits?
> 
> For the setting part, this is for testing. So any value, even extreme ones (e.g.
> 1) would be OK to check that a software correctly handles write accesses to
> zones for a device that has open/active zone limitations. A more practical way
> is to reuse values of real devices. For instance, some SMR disks I use have a
> max open limit of 128 and max active 0 (there is no limit for active zones on
> SMR disks as ZBC/ZAC specifications do not define this concept).
> 
> Another example is our soon to come work on btrfs zone support which shows that
> at the very least 6 active zones are needed. So tests can be performed with that
> minimum to check the file system and that its block allocator does not go
> opening/activating too many zones.
> 
> For the using part, the above btrfs example is good: if the FS tries to allocate
> blocks in too many inactive zones at the same time without first filling out
> zones already active, it may exceed the limit and writes will fail. The FS must
> thus be aware of the limits and its block al;locator tuned to limit block
> allocations within a set of zones smaller than the maximum active limit.
> 
> Does this answer your question ?

Yes.  Thank you.

-- 
~Randy

