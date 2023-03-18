Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0811CC6FD1D
	for <linux-block@archiver.kernel.org>; Sat, 18 Mar 2023 02:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjCRCWA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Mar 2023 22:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCRCV7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2023 22:21:59 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F4E75A40
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 19:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679106112; x=1710642112;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=92vBV1JlnRUnhURLU6qm4vY83eYmKrAT4PBcDCXHYNY=;
  b=Lof1FjTq5MEWip5XR5BOK0Kk7x0UwLXTMzMewmcexfcAJ9+E1FhEiT+Q
   u5/6wN6GuKXzKjKPDCf8XAEs656Op1KyNA/d8g/6yDdaRd1i3IBUXgrdZ
   S7lN0Ri7v6W4fF17ltDS4jWAB9HRBmN96bWstJxCl9eB8Swi03UhLNFQY
   UKbcPv0yC3EGhNevi2FzbqV0B3gWZiJTNneu37Bq7Qzxz1g6/EPI79h09
   O2UEEQfdV74BOXVAfNKPv9Lg3PsBYd8O9CMmq0Rry9oXLO60uf9EtchTb
   IYUBCBPwsKu7A00ftEch+BnajtrxVMYE9FVzL02eHpX0cu1xy0Qo1QI+I
   g==;
X-IronPort-AV: E=Sophos;i="5.98,270,1673884800"; 
   d="scan'208";a="225903129"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2023 10:21:51 +0800
IronPort-SDR: 7cBpAI7b8+sFKHO9sXlET+ent2Ys7vEHO0/k5sl4TG3uiE4Zll7s5tHpfZH16M4getgU4Km0QA
 dVjUbh7YA3dtf7h2KglOwPVRI+xO03UUcEwLlSj50MoSmaqCOO/rhLhe0uJ/ZNZ3/Lc+tOaxTJ
 NoeBi2utata1HsdGxVizpPDtBWHhQH3nUlspVRrsk8XmSOxVgh1MOf9uaP7/D2jZVoWigx5OWA
 DWNDUw8fB6/tljkurSkc49+QGrKtq9RHTTjGMPE9TnvY5CfFEZwMt41DrdSPXwAMKX7v1CN62Y
 D+4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Mar 2023 18:32:34 -0700
IronPort-SDR: rGUw6nbySoOXSoLoZ+IM6BICjHXp5nn1RSa5PwUQrE1+e6a/o9BErN2zXDmbby+89KK+UBqk1N
 Mxlo3FLxrnPr1U8xaQvxAly8LChxvs4HakBMr+mHtyhIz5TTS4PI+DFgVXO7xOseufmgV6yZLP
 P1yMwgxYMefNnV2rG9sA1XDxWQQxesuSMs2vDLnUklEeb35w0GQ2drgn4h4uU78xAD0ZIneeGp
 ndFXsgTk5OpEppMkk+GnemIVoUFL4HLYsOVUWUFt1clExDNMmXZSU70pI2LL9L8o00mo136qj+
 f2I=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Mar 2023 19:21:52 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PdlB73KYlz1RtVx
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 19:21:51 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679106110; x=1681698111; bh=92vBV1JlnRUnhURLU6qm4vY83eYmKrAT4PB
        cDCXHYNY=; b=dq0a1zTaE+tgeLqXJwp4qQcklOBCGVIOo4PTIizDTBwv4r0Tn2o
        MsZriJEdGgfThEIJGOmrVyggDd6DDLpF30AHpplnlraG06gVlQSgXSSUuWGkFx/k
        fVIIe7yz3CXP9RkgLjep0Jse4GDwaBrNlKoXFPftb7PaK8UHXB3Mu6iFbuNGOAyL
        /IfV9+PphrKdJtYXYVk8awjUEGaYFOrf8SQhw6SLDD7HHL6sxAn7U2Qtbb7KAOq8
        /ZBzYxK7fO6vqKtlCWRiaj5s3CgWh/Fpx5PDQNPWBPKrTQarrkhGmpepj5YXlfm/
        ob2/wU6u3MU5eVYnXzh4GuyVd003LXMB70w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZMhJvOQmQGz6 for <linux-block@vger.kernel.org>;
        Fri, 17 Mar 2023 19:21:50 -0700 (PDT)
Received: from [10.225.163.88] (unknown [10.225.163.88])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PdlB531bQz1RtVm;
        Fri, 17 Mar 2023 19:21:49 -0700 (PDT)
Message-ID: <e470167d-f0c0-f6de-41b3-e4b05248ab70@opensource.wdc.com>
Date:   Sat, 18 Mar 2023 11:21:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] block: Support splitting REQ_OP_ZONE_APPEND bios
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
References: <20230317195036.1743712-1-bvanassche@acm.org>
 <9987139a-f423-3d2e-5abd-877b3d147134@opensource.wdc.com>
 <cc9e00f6-9106-e701-4e50-f87c5796b0e7@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <cc9e00f6-9106-e701-4e50-f87c5796b0e7@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/18/23 09:09, Bart Van Assche wrote:
> On 3/17/23 15:39, Damien Le Moal wrote:
>> On 3/18/23 04:50, Bart Van Assche wrote:
>>> Make it easier for filesystems to submit zone append bios that exceed
>>> the block device limits by adding support for REQ_OP_ZONE_APPEND in
>>> bio_split(). See also commit 0512a75b98f8 ("block: Introduce
>>> REQ_OP_ZONE_APPEND").
>>>
>>> This patch is a bug fix for commit d5e4377d5051 because that commit
>>> introduces a call to bio_split() for zone append bios without adding
>>> support for splitting REQ_OP_ZONE_APPEND bios in bio_split().
>>>
>>> Untested.
>>>
>>> Cc: Christoph Hellwig <hch@lst.de>
>>> Cc: Keith Busch <kbusch@kernel.org>
>>> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>> Cc: Josef Bacik <josef@toxicpanda.com>
>>> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>> Fixes: d5e4377d5051 ("btrfs: split zone append bios in btrfs_submit_bio")
>>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>>
>> Nack. This will break zonefs.
>> zonefs uses zone append commands for sync writes. If zonefs does not have
>> guarantees that a single write is processed with a single command, the user data
>> can get corrupted because of the possible reordering of zone append commands.
> 
> Hi Damien,
> 
> It is not clear to me how this would break zonefs? Is my understanding 
> correct that the size of bios built by zonefs is such that bio_split() 
> won't split these?

It does, but your patch removes the guarantee that the split actually never
happens, and thus that we cannot see silent data corruptions due to append
commands being fragmented and the fragments being reordered. I do not like that.

I am not sure what is going on with the patch d5e4377d5051 you mention, I have
not followed that. For btrfs, since file data mapping for zone append commands
is updated on command completion, reordering does not matter so splitting is
fine I think. zonefs has static direct zone sector to file offset mapping which
cannot support reordering of zone append fragments.

Given that explicit split in commit d5e4377d5051, I can see that a fix is
needed, but I do not like the solution you have.

> 
> Thanks,
> 
> Bart.

-- 
Damien Le Moal
Western Digital Research

