Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C85C4332F
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 23:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiJTXjc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 19:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJTXja (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 19:39:30 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4B815FFF
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 16:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666309169; x=1697845169;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/6WbSHvcY08SUGPoZeuB0MBuIsZEV4QotIRRgMadpsk=;
  b=pSjTNV5MQ0m6rJa9kPT7bNOLYldUDmGzBLk+3r+lcW6tQXnLshdMooS4
   XLkH8QHHGFG7EtU/1x+of+AUJqC0hPcXtavsRmO9YvEF97V0V3HMANH7O
   b8FmWqe52v7BApl4I7Qu2/qDc+vCed6GaQzqpelmLa/T9fO/y7+rke2TZ
   NSg6rKuNagJmmbalVTVnQR54kyqlC+PtBe7Rc+DkXMSgOXJ8pOW8dRlcP
   HLhRFfaaxed/Mv0HPLo001/5QK8mXlUhKYI62bYqvg2JEV2N+PncRdKug
   rCj7HQN4DmP2Rz5FY+Wr4HYWLURep9g5bCvqwgDrqG9nEJwtjsSSDdvGt
   w==;
X-IronPort-AV: E=Sophos;i="5.95,200,1661788800"; 
   d="scan'208";a="214379676"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2022 07:39:28 +0800
IronPort-SDR: rr/C64KkTzEovVwdo4v5PFtWkezeHXy+a8dwsZemmazNp89n3SlgJao+frMfSoe4iT5cG6aoVL
 cfHgiSZoKVOYnotWRVQsm76i7znu+BtHsQTdZDPPIyuWJDFlBFl9XMS6grVURbKp/CdaNpO4Bt
 l12il2U9qLqSljycs6GFkGZdNd2pThqLkURSWwrnVdw/f++p93xUPJ65YLkcuYrRSzuogUptBO
 vbvn/Jb8RnMHLjWekMxk72A1ymc5prC+lDEVTmpXGxa0N4SDbp6njf7PE52AyUKKwyNpuU8HgS
 iJkVrKCFqLHdZc5AQuaf5Sui
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2022 15:58:56 -0700
IronPort-SDR: ksqzdjJ+CjmLzEmpmxnDyViFcohyuCMt/hNgwvKZfu36mc8PDFkX6CvC/46FhHOQONodniO/a0
 /VgIAy1g5jXk8ASjHQDa8as+0LVjz7TWBtZmL2mHH/Vpvle59HJuQO7TcR0LpXxx0FZb9NbL1v
 n4T8iE2yf5B7tD2qbwFTk9bWSUn/DsZAQyseimt/fmWqezsQPE1WXvYC29L+Onez2YVeHaBF+s
 saJkuCz8951y1EaKJN0migVYb85PpU+7a69n/S8oSgYvcimVPIbSYKTewO5HMACU/qC4qwv/Tb
 roY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2022 16:39:28 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mtkb31cT0z1Rwt8
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 16:39:27 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666309166; x=1668901167; bh=/6WbSHvcY08SUGPoZeuB0MBuIsZEV4QotIR
        RgMadpsk=; b=n3sghBRg1vivlfTp2R9ErPMbbbLUhIOufkYm2QT0yd6y1Xwlgqt
        wnOM26xppJ8rwBjYhRc8Q4SufuitPIQOzELBL3igeV1YjeIKM04dN4xe1CNoXEbi
        XmcYGe+tMZ2rtWVeuJfdKG8HFGE0gkvIk3vgUAE0RwUj9neNzwMdNvXeLC15uiIm
        mphKsJqm5fTYhhr0UQbL8Q2tqKQayDmX7D1c9Vzt+MceX6OReFwkSkd50JpwnkA4
        c0H/0OpzVbZ8FdhHCLK4IFan5el8jlRJxfQFDqTPlr/OkmQyqIayNLjMluRzGnat
        mOHy1KshgJ8mamG8GCtqb+lvGvfaR5aiODA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NTm2GbVbHpy4 for <linux-block@vger.kernel.org>;
        Thu, 20 Oct 2022 16:39:26 -0700 (PDT)
Received: from [10.225.163.126] (unknown [10.225.163.126])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mtkb05z6hz1RvLy;
        Thu, 20 Oct 2022 16:39:24 -0700 (PDT)
Message-ID: <9dcee00a-90f6-c814-0e4e-51adc025b49f@opensource.wdc.com>
Date:   Fri, 21 Oct 2022 08:39:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 10/10] null_blk: Support configuring the maximum segment
 size
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Yu Kuai <yukuai3@huawei.com>
References: <20221019222324.362705-1-bvanassche@acm.org>
 <20221019222324.362705-11-bvanassche@acm.org>
 <6a72dd3a-2b84-9345-9782-1ef2fe9caa07@opensource.wdc.com>
 <5856bd90-9a7f-09c1-3749-2c98c42bfcde@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <5856bd90-9a7f-09c1-3749-2c98c42bfcde@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/21/22 08:34, Bart Van Assche wrote:
> On 10/20/22 16:13, Damien Le Moal wrote:
>> On 10/20/22 07:23, Bart Van Assche wrote:
>>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>>> index 1f154f92f4c2..bc811ab52c4a 100644
>>> --- a/drivers/block/null_blk/main.c
>>> +++ b/drivers/block/null_blk/main.c
>>> @@ -157,6 +157,10 @@ static int g_max_sectors;
>>>   module_param_named(max_sectors, g_max_sectors, int, 0444);
>>>   MODULE_PARM_DESC(max_sectors, "Maximum size of a command (in 512B sectors)");
>>>   
>>> +static unsigned int g_max_segment_size = 1UL << 31;
>>
>> Nit: UINT_MAX ?
> 
> Hi Damien,
> 
> That would be a valid alternative. I will consider changing the value 
> into UINT_MAX.
> 
>>> @@ -2088,6 +2100,7 @@ static int null_add_dev(struct nullb_device *dev)
>>>   	nullb->q->queuedata = nullb;
>>>   	blk_queue_flag_set(QUEUE_FLAG_NONROT, nullb->q);
>>>   	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, nullb->q);
>>> +	blk_queue_flag_set(QUEUE_FLAG_SUB_PAGE_SEGMENTS, nullb->q);
>>
>> Where is this defined ? I do not see this flag defined anywhere in Linus
>> tree nor in Jens for-next...
> 
> That flag has been defined in patch 05/10 of this series.
> 
> In case you would like to take a look, the code I used to test this 
> series is available here: 
> https://github.com/bvanassche/blktests/commits/master

Please always send full patch series. Hard to review a patch without the
context for it :)

> 
> Thanks,
> 
> Bart.

-- 
Damien Le Moal
Western Digital Research

