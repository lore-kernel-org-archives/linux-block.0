Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E669DC43334
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 07:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239106AbiFTHOa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 03:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbiFTHO3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 03:14:29 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1480AE036
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 00:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655709267; x=1687245267;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LQCjkc8AWo140OOvRLywKCQJ1P+ERh6S+u9P0Z4sSUA=;
  b=UHZ0TRKVuQBQSXqiH15GB8tIjS4g1dMf87ek1R6qYvQ4rq/fmv2ouacO
   ZN/2mlgdsCpdyWzrB7xd5uzEoL5PTUQGSqcXVucHWyy12+JhTXn076xLi
   w+Fj9+T+e6RK7zmC6UeQ34jCvD/SVo/mGLNqqkcq/LQoiMIqv22Gzj6T0
   9JEgtEzDUUH7InkXs5ONzqashGTMpHxokCksJ12zq39Auj8ZJM8bci/oC
   XFJe77meX0iRns66oIQ6i3cXE5Mu0I1/6Y3TUapauHbLhU9t562tj9lX2
   ezO7Ql7+Rw8lfAN/eAPlI1dVv3jZL9ew26oE9GeZ4zf/jQT4UOGI2oni3
   w==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="202304784"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2022 15:14:27 +0800
IronPort-SDR: khETpEJyroPSq33bv1og0KYq19pjGBhIVgVT0Z5nIxw2+wMCgxUR+sHxBL5bPXZ/c7WsX68r1T
 VJwDc9IwDaaJRGLpgGfm43/AG9ADOEfmrFuVeGeDP75dgLeu7044Mwb6lk3QRSmRJ03jmfmKyt
 GamnfbasxNYXi0cLhseMWus61FSmHtROpEhJ5mVtHcwX2q5feFCA6WoEvO2AavL2V/umkruoGJ
 noHbJh72JsC+ZpNziWkc9t98A1OA0w/ahPYtje0IAv3lwGXy2LBNJrCsueBazAFpEFaPj0Tluy
 qWEyrzShlfAAurBOKyVy0rwG
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2022 23:32:36 -0700
IronPort-SDR: +iJEt7dzU4A/JMlJX35DtX7FNGX2zpGVnULnyU3y8qPHLccERWPF7EZ8hvLEtQyoOuFc2XCRUD
 PyS2mI+UajgW3Lbv5mJQjS1AGNvo3ANF+UMM3C6FuzyKn+WmYrU+0yO7JkeRRsZYvFcnf2Gl7I
 sOqnQLRGcB5RE5Ss1kz0TmECCwF22r2xJF28Jaq76izCXQNvzFbwCChQnPFklYLEn6F1xUQ5+4
 Se2N12AkZQ560qhNTHIx+EI3ec6PVSv+ZAzJe3zdqJ67H6llvVabzA4PHnryYEcD4s2WTMvca3
 Eg0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 00:14:28 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LRLVp6PSPz1SVp1
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 00:14:26 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655709266; x=1658301267; bh=LQCjkc8AWo140OOvRLywKCQJ1P+ERh6S+u9
        P0Z4sSUA=; b=hE5C4cse7H91CDizGdPcKqgBtuJyeKrdEbOK7pIEVMhmK97zrbm
        8JTGvYQZyWz1G1I1xUTLjnlnlfeOrXnJIwoo5e1HuuFJAvcnXQftMBqsejWeaaI9
        fab1VyHXwfUOI0eD9ZnvCwGcEqytsrLglQGPnDEXyHVNYtuqRY5vw8aSZ7XQ5rUP
        bDHGCNqN8zVuT4Ucbui2ay/o2LGdEroUGsTuH+y+TngDG6vHuQe6iQl7vS4VgBJK
        AiRDbvcHTnTHUTeqBb7UFAdcT1uCwhnO/APJVCLVl3zLN10czwgguiwzty4IWiYZ
        kdyC79lCAIyMrJ2j5HPFi7rf9tyeBpUV6jQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XaAPkn_a4OKp for <linux-block@vger.kernel.org>;
        Mon, 20 Jun 2022 00:14:26 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LRLVm18lkz1Rvlc;
        Mon, 20 Jun 2022 00:14:24 -0700 (PDT)
Message-ID: <113c8918-1d11-b3e0-0435-19405d103e0c@opensource.wdc.com>
Date:   Mon, 20 Jun 2022 16:14:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RFC v2 03/18] scsi: core: Implement reserved command
 handling
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com, brking@us.ibm.com,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        chenxiang66@hisilicon.com
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
 <1654770559-101375-4-git-send-email-john.garry@huawei.com>
 <b4a0ede5-95a3-4388-e808-7627b5484d01@opensource.wdc.com>
 <88d192b5-741b-7104-7f72-0178aa18bafb@suse.de>
 <20220620062828.GA10753@lst.de>
 <2ea41701-8be5-f981-d178-0d8e703962e0@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <2ea41701-8be5-f981-d178-0d8e703962e0@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/20/22 16:03, Hannes Reinecke wrote:
> On 6/20/22 08:28, Christoph Hellwig wrote:
>> On Mon, Jun 20, 2022 at 08:24:24AM +0200, Hannes Reinecke wrote:
>>> So my idea for SATA is simply _not_ to use reserved tags.
>>> Any TMF functions (or the equivalent thereof) should always be sent as
>>> non-NCQ commands. And when doing so we're back to QD=1 on SATA anyway, so
>>> there _must_ be tags available. Consequently the main reason for having
>>> reserved tags (namely to guarantee that tags are available for TMF) doesn't
>>> apply here.
>>
>> At least in the non-elevator case (which includes all passthrough I/O)
>> request have tags assigned as soon as they are allocated.  So, we
>> absolutely can have all tags allocated and then need to do a TMF.
> 
> SATA internals may come to the rescue here; if there's an error all NCQ 
> commands are aborted. So we'll get at least one command tag back.
> As for the command duration limits I'm still waiting for clarification
> from Damien if we can reuse tags there.

We cannot easily reuse tags as the CDL case is *not* an error. So no queue
abort come with it. If we had the queue abort, things would be easy as
that would essentially be a regular eh.

Simply using scsi_execute_req() does not work since we have no guarantees
we can get a tag: all 32 commands being executed may complete with needing
sense data, and so scsi_execute_req() would hang waiting for a tag. I
could try hacking scsi_execute_req() to reuse a tag instead of allocating
a new one... Calling scsi_execute_req() from libata is really ugly though.

> 
> But I do agree it's ugly.
> 
> Cheers,
> 
> Hannes


-- 
Damien Le Moal
Western Digital Research
