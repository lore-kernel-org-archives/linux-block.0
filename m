Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E01C25B06
	for <linux-block@archiver.kernel.org>; Sun, 14 Aug 2022 17:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiHNRNV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Aug 2022 13:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHNRNV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Aug 2022 13:13:21 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221C91BEB0
        for <linux-block@vger.kernel.org>; Sun, 14 Aug 2022 10:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660497199; x=1692033199;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X00vM0XAZLUKuxxe9zHqRF23LLYBwbFlSCVd0VEzTmI=;
  b=UqNYD4yjsZO90qGiPeXaR3GrvFR96wK84W+QGNHSv9nEKBgOfuyEqUnA
   /SfmGuQBcrdpwYxYl+asFtS1kyA5HkpfrhmqOH7M/tQQR9PZe5SWo4POA
   hz86eVARgHWLmYPIzCwjGiA8Kov1GMk/QiK8lZXSEKkU3XJCpBHtGqfvp
   nwymz3Op/YUe+gDTmx45wT6WLI5GNWW+W4+YyRGNXhmTaSEjxuuMQbZTD
   HwXVH8xdI3xBC8ltUKCT0hNohDt7axU/Hv8jP5p5hOByEZQ0H4et73D+L
   6WHULTnXestb5qdqdv66Q/PVylCxg8vj3KcCAzHrrRTm4zHXiitPDaYe7
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,236,1654531200"; 
   d="scan'208";a="320763900"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Aug 2022 01:13:19 +0800
IronPort-SDR: dyUUDYOJfoSUF7Th1XwnkWbxOylgWT+858lbDQ6TEOeuXFAOUKgKr0gYI5vU2lYF9Sa5LbXDSq
 pABi/SyTO2No7eGSRpk4501Eaky+LmEvZjljy85uDdkySa7X6LChdkmck/NNrS1rY9A1ODRBUI
 mRpYfIJEimL0FC6o2evKcVayUWM9GM7JoFDmxdFFRKoSBgJPq0l5qWub1bzCHIBa+tSVHYKNem
 xXdNjhL0HNqebRGpotzVEJKcAY0hXpgRPXW04Laie6c5XEpN17fODN7R7Vamn4VfgAsFJuBlIH
 GyUS/LIwAx+7zdXQuU6/clfO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2022 09:34:09 -0700
IronPort-SDR: KpWjp14Cq/km4ruJaE9s9P7r1oz/kbuC2rDZ8wUP1Cl/Mq/nrBC7bd14QyvkEwURlxfyx8oGSh
 JYybMFThLP4CSRply9rxlzS+GswFiw9KtIT3nPMVUOg0zF3qX3JCMnBtBobIJmpquG9DXQRDIf
 NLV3S7x+p3ErXbmNmkxko/WtD7gwrp8/a7V7TNvNSGf+W1SJN6QTO8ssdUCycefMQIYCqrwIlK
 LNjj68o5OGF/yAmSEBJPGJpZUEsSooBLvW4IFEpcbXnN9m/fYjak9/56kkdDjfs+acB4FAIL7C
 +L0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2022 10:13:20 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M5PBQ5gdmz1RwqM
        for <linux-block@vger.kernel.org>; Sun, 14 Aug 2022 10:13:18 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660497198; x=1663089199; bh=X00vM0XAZLUKuxxe9zHqRF23LLYBwbFlSCV
        d0VEzTmI=; b=HYH0dMhMv2iUy28cxsk8l4CmPg6M6g07S3Ak0JO51cm0/fthka0
        uoFULVB+eCkGvWxfuiOGI1fk7Hs/ATE+mqJ4EiDcBmcOK6zXPUlIQBW0LEdS+3N9
        /5sfQmtuZiFZFdA9g9eF6F6KfXT0Msjr1blb9o+bXIGRkt4Z/ItlpQ/1iu1yLAQl
        94Rsuut8bPPScdIT0B41rutOWdI77FStKf3CAWwE+OZKfpc0QA071qdz42RiqLKp
        zdwutl02XEnXCq7hUa8Y0wumW8wYNqH2uzKgOpCBruqU10gI7SGazalFAdyCAprV
        +AfXis0TIfKxOF2+pugViJXFilQm0faQXqg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Z38bFb8hbVeN for <linux-block@vger.kernel.org>;
        Sun, 14 Aug 2022 10:13:18 -0700 (PDT)
Received: from [10.225.89.57] (cnd1221sqt.ad.shared [10.225.89.57])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M5PBP53lsz1RtVk;
        Sun, 14 Aug 2022 10:13:17 -0700 (PDT)
Message-ID: <f4e10a9a-313d-ce24-c610-f4e8d072d4f4@opensource.wdc.com>
Date:   Sun, 14 Aug 2022 10:13:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH] block: Submit flush requests to the I/O scheduler
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
References: <20220812210355.2252143-1-bvanassche@acm.org>
 <20220813064142.GA10753@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220813064142.GA10753@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/08/12 23:41, Christoph Hellwig wrote:
> On Fri, Aug 12, 2022 at 02:03:55PM -0700, Bart Van Assche wrote:
>> When submitting a REQ_OP_WRITE | REQ_FUA request to a zoned storage
>> device, these requests must be passed to the (mq-deadline) I/O scheduler
>> to ensure that these happen at the write pointer.
> 
> Yes.
> 
> But maybe I'm stupid, but how is the patch related to fixing that?
> blk_mq_plug_issue_direct is called from blk_mq_flush_plug_list for
> only the !has_elevator case.  How does that change a thing?

And writes to zoned drives never get plugged in the first place, scheduler
present or not.

> 
> Also please include a description of why these changes are otherwise
> good and won't regress other cases.
> 
>> +		blk_mq_sched_insert_request(rq, /*at_head=*/false,
>> +			/*run_queue=*/last, /*async=*/false);
> 
> I find thise comment style very hard to read.  Yes, maybe the three
> bools here should become flags, but this is even worse than just
> passing the arguments.


-- 
Damien Le Moal
Western Digital Research
