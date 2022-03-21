Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F82DC433FE
	for <linux-block@archiver.kernel.org>; Mon, 21 Mar 2022 16:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348546AbiCUQXh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Mar 2022 12:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351059AbiCUQW5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Mar 2022 12:22:57 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9004ABF7E
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 09:21:31 -0700 (PDT)
Message-ID: <a707d1c9-3af8-d573-6d71-e4b8168a7ced@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1647879688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DixqukwzuS2LIzDuWHjwAsxz7jLNGz0GtACZ41hJOyo=;
        b=nqhpik62lwaJupQ2i0fizF35jRpWCnW828uBzWnTA/uKigz/781a7sTOcekSioEKjVRHS5
        hab4EMW08OHHdz5/NAje1/GW2MN3YBCgbDUWODzzTToOtTFfT2IFfpiAUngDb+6lDNrgju
        hXh3k6ehayg7ub1ieEXBl+7rAWxdlMw=
Date:   Mon, 21 Mar 2022 10:21:36 -0600
MIME-Version: 1.0
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        jiangbo.365@bytedance.com, kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <CGME20220308165414eucas1p106df0bd6a901931215cfab81660a4564@eucas1p1.samsung.com>
 <20220308165349.231320-1-p.raghav@samsung.com>
 <20220310094725.GA28499@lst.de>
 <e02dfd21-31c6-95b6-1127-3f18c79116ee@samsung.com>
 <20220310144449.GA1695@lst.de> <Yiuu2h38owO9ioIW@bombadil.infradead.org>
 <20220311205135.GA413653@dhcp-10-100-145-180.wdc.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20220311205135.GA413653@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/11/2022 1:51 PM, Keith Busch wrote:
> On Fri, Mar 11, 2022 at 12:19:38PM -0800, Luis Chamberlain wrote:
>> NAND has no PO2 requirement. The emulation effort was only done to help
>> add support for !PO2 devices because there is no alternative. If we
>> however are ready instead to go down the avenue of removing those
>> restrictions well let's go there then instead. If that's not even
>> something we are willing to consider I'd really like folks who stand
>> behind the PO2 requirement to stick their necks out and clearly say that
>> their hw/fw teams are happy to deal with this requirement forever on ZNS.
> 
> Regardless of the merits of the current OS requirement, it's a trivial
> matter for firmware to round up their reported zone size to the next
> power of 2. This does not create a significant burden on their part, as
> far as I know.

Sure wonder why !PO2 keeps coming up if it's so trivial to fix in firmware as you claim.
I actually find the hubris of the Linux community wrt the whole PO2 requirement
pretty exhausting.

Consider that some SSD manufacturers are having to rely on a NAND shortage and
existing ASIC architecture limitations that may define the sizes of their erase blocks
and write units. A !PO2 implementation in the Linux kernel would enable consumers
to be able to choose more options in the marketplace for their Linux ZNS application.
