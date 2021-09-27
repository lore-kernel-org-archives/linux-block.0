Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AD1C433F5
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 03:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8D6A60F3A
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 03:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbhI0DnT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Sep 2021 23:43:19 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:23073 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbhI0DnS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Sep 2021 23:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632714101; x=1664250101;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QEQ1r5p16Ui7D09NsmBKqop8Ex+gK0dn6HAotZgmffo=;
  b=hLkOVZCWQMtcAPwAN4a0SGNF1voFtV17sz1fHxMILVMGPB3OOnXUcRpm
   nK/A9tRrwv2k7KFwObB3+/1vkCP9LX+jGv+z19kYBLXjWYiLKmYDloRr4
   Q2xW7RqXVGX/Y3fJfNGbH0EnzUcqS0x1adlYysjbBbTdRWf0U1GUOKMg2
   o1oFXIm5rCSb8X4+RT1cV3h0wovmC5EJIBDM5V3hyAXRNX5NpvsUOoXFT
   IdXVRosd3D0bHxS+Tyx5ZE5SioY1S3R+ycDkCATmgl3eQQXkMsZT+ucH5
   gv891VfnBLdJZZuYBJk4XCBO+M+ZIjziCDe0NTNMwYh8b0Of3Cn5a4xS6
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,325,1624291200"; 
   d="scan'208";a="181035035"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2021 11:41:37 +0800
IronPort-SDR: E8PrO2yjHesfuYo9MGdLwUtHFH5RdQXOWXty/hWH1+P03Bn6mFm+mpe2Yr1xWFouVX2o7njIaI
 6MjbpqUCkMXDeNP5Tr0tVGEWQGstI/4USSR1bKznQalg+OicUyFlGkwdk0xukIvKdcw2OkkBIW
 suYiO0SBzB3kCPtc766sloVrRrSQAmL2Qdq+ZurQx5XEnqHvrH4WwQUoSuJvarqXZoLr4EZcPC
 Sl0cN8atMr3E2Flt/+VfynTmZgKSmhvAfc8Fip7IUdbR7VYZJ/CUkDAlDFUlLvCQGNwZIiaYUm
 jWKVWKg7qzeZuxVunRhpXcje
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 20:16:12 -0700
IronPort-SDR: OaAZy18bX7lofjA+DipOUocZjfG6XHfegeja5qEnKpjTnrPXvdxr2Nf3a2YmjlYj8y3d9Pnzi6
 5Ts+V/v+9rytgSYNMpwN5Xtcv+byjrT2KW+oQxUGkJym9pzTejwxkm+QfgKV5ExTVWlmiVOL1+
 +PFyfWAx4tGU+nZ/fk3JwhyW26w8oMEUpX0pBFqlrU+406Q4XHiJH4Zx1IV41BiwBeH9Sfpi+Z
 vaCzESxXuq9To6rhAuY4k1kxfjnDbD3R1CtRozDX9H4To2/mQxvKAmTHVJfnLc1daUqtZzqJcv
 Ew0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 20:41:39 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HHpN16D4rz1Rvlf
        for <linux-block@vger.kernel.org>; Sun, 26 Sep 2021 20:41:37 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1632714096; x=1635306097; bh=QEQ1r5p16Ui7D09NsmBKqop8Ex+gK0dn6HA
        otZgmffo=; b=Do627domueT7Oz76jkGKE5MSOyrpVf45I9Qy/UPpK6Vx3XSlhfZ
        N/xM0s474vNF36oUu2C5NBPMl0idmQNgYW1cAq385BQ0ooYEiU7w/eE1hDWkjQWV
        dqZzijj+cbK1gTIJ+9LEJq/b+JDusv8Zl/WzWmIHORRYFXH779Y++uI6pmRCR2+k
        W5BGsXe4ilRumJ8hjX7ICxXp+WZWVSS98cfY5k0A50IKMe1MRjuozQPF2Zew4uju
        +c/yXP6DNtrmPC3JZxASCemNiqUt//Z2lGatxo+RQ+vIu1SwCAewapy818QqEA47
        HQaGmJPmc2axvFZogxuBQNYMUCbxw+RPZOg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8DNyAuxbdeHf for <linux-block@vger.kernel.org>;
        Sun, 26 Sep 2021 20:41:36 -0700 (PDT)
Received: from [10.89.85.1] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.85.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HHpMz56bJz1RvTg;
        Sun, 26 Sep 2021 20:41:35 -0700 (PDT)
Message-ID: <2be46ef0-8848-a097-4099-31f8103b53ad@opensource.wdc.com>
Date:   Mon, 27 Sep 2021 12:41:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
Subject: Re: [PATCH 3/4] block/mq-deadline: Stop using per-CPU counters
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Hannes Reinecke <hare@suse.de>
References: <20210923232358.3907118-1-bvanassche@acm.org>
 <20210923232655.3907383-1-bvanassche@acm.org>
 <20210923232655.3907383-3-bvanassche@acm.org>
 <DM6PR04MB7081B7096944F8115A8BE2B6E7A49@DM6PR04MB7081.namprd04.prod.outlook.com>
 <81cd7cea-6060-4500-8af3-cd324aef61de@acm.org>
 <6d52ad94-36af-cce6-afaa-8d0a49939d2e@opensource.wdc.com>
 <9997e3dc-44f8-1884-04f9-fc43dc655d5d@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <9997e3dc-44f8-1884-04f9-fc43dc655d5d@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/09/27 11:38, Bart Van Assche wrote:
> On 9/26/21 17:19, Damien Le Moal wrote:
>> Another thing: in patch 3, you are actually not handling the overflows. So
>> dd_queued() may return some very weird number (temporarily) when the inserted
>> count overflows before the completed count does. Since
>> dd_dispatch_aged_requests() does not care about the actual value of dd_queued(),
>> only if it is 0 or not, I am not 100% sure if it is useful to fix. Except maybe
>> for sysfs attributes ?
> 
> Hmm ... I'm not following. I think it can be proven mathematically that
> dd_queued() returns a number in the range [0, max_queued_requests). Here is
> an example:
> * inserted = 1 (wrapped around).
> * completed = UINT32_MAX - 1 (about to wrap but has not yet wrapped around).
> * dd_queued() returns 2.

You mean 3, right ?
But yes... Slow Monday, I need more coffee :)

Cheers.

-- 
Damien Le Moal
Western Digital Research
