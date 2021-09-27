Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D567DC433F5
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 00:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B449860F48
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 00:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhI0AV1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Sep 2021 20:21:27 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:8246 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbhI0AV0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Sep 2021 20:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632701989; x=1664237989;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iTw9IlallH8j6iEmVzFxn/bywFojbTAYvjtIGl1UK6g=;
  b=AyGmPHdIF5tV2+raiR7cCNdcBxB+9P+Yx4Mgvtf42bnMIVFHi8DCedZZ
   5/F9GM5aB3mN7X3+HestnuGyzxOwvRF4to6kzodRQQEHZ0G/vKtzcg4yz
   SrQPIJTwKRt6qCUVlZA8Q0b08uOjQ1lxtsZWfA7j5JKrlFFDXIOvOu9Q7
   s7ekIHYlmqxkxH8bDqeSbdVKPgI45QZH6gC9Am0wPXlfgkKv6te8TJM5v
   U72U1yHlrcdLm+/yv9GpZ1CysK5cZbhAwlRnoUVyIO3OrH6NIBoPZ9Wvv
   kY9h5cELtGTbVOiwoaIbCzYsqjucuJWmthqZGh7UKtb5WRVZNfe/G0itB
   g==;
X-IronPort-AV: E=Sophos;i="5.85,325,1624291200"; 
   d="scan'208";a="181019556"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2021 08:19:49 +0800
IronPort-SDR: vJX4Uee0XcFaB98bAQ5pnebCjgrAktCLMOGV7uTkI6gwdJ72ZCNxO2eOjKGn+FdMtiqpx33RyO
 Hne4ki//eKkC47x6PF9qfJPixXOVKKFyOZZYs0oGB/5gr+aswUZC82a9kLZVpq5pMwkfAE5Wdv
 S18KXAZrH0Q6SPHoFVl6yJ79CwTRMiZQoOpRvq2UGpkxlwRY65I0eFTZWcem+MJe3tTX3BQmn0
 HtWHv7mgQeonvg+3HTb7R+QnHbVtn+PbPq0fz02xHVczH5mciIyrApFvx5K+h/fISoAXpmGuRi
 Ec7O7aZqAtzt7I5s6ig7cMew
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 16:54:23 -0700
IronPort-SDR: ypL8HAkhzquND9bgsdATCqFNNsUS5Rog/SmJc0TTHiC6/qCBsrdg2APO2Um8Kmqqnw8ztb0Ad7
 U30t5vcifvIq5vMUJJNEDmwyF4XevFzkI6eoS4fSyQShjOqIKZ/FV58hBa/b6sKmtKY7NvSfD6
 bQtrTdOD+rd28+CI4a5xXxf2InqQJSqBz7NKKHKgdAVtJciKZXa/RC5Xu55KVyCC7U6QkimZS1
 I/QQ0NqJ4gpWBnzXyug8SjRs0iaiEruwY1iljiw1vGzQRH6rtDVjWT5GZUNqJ0WQb+KwBowUYq
 nBw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 17:19:50 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HHjv93K7tz1SHw0
        for <linux-block@vger.kernel.org>; Sun, 26 Sep 2021 17:19:49 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1632701989; x=1635293990; bh=iTw9IlallH8j6iEmVzFxn/bywFojbTAYvjt
        IGl1UK6g=; b=cQwz+Dx73yx6Nd4A3QY93xsDBd2OtkORiUXCHoEtOwRGT6LNxoQ
        c9iSHjLNtnkIDUqKWU7ktowIbZ5qkF1EGwIA4DcrM71/PS6yHe7MjX+eVdNbCAKk
        WsnrKuTKvclOPvAg3WWHXq95z/lGfM1muQpQlHwAeE3PcU4aRFUZ3gpQ2scoBj4E
        uolaU5bNGHmnwj+AH+kecbI/8shTEicPEJBU5Xu0K6eIAAnOL/S0WkGCbOGd+9i9
        TCwwsHXfsTfFLe0nCwA424bA/Qj+mqK5sd+0GfoyymeezuaLG/8bcx5c6GbKTjod
        ULYgIKft+TO4JikJZGLvpwsuPdWMsR65MdA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LZxfVcEVJEJm for <linux-block@vger.kernel.org>;
        Sun, 26 Sep 2021 17:19:49 -0700 (PDT)
Received: from [10.89.85.1] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.85.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HHjv75mQlz1RvTg;
        Sun, 26 Sep 2021 17:19:47 -0700 (PDT)
Message-ID: <6d52ad94-36af-cce6-afaa-8d0a49939d2e@opensource.wdc.com>
Date:   Mon, 27 Sep 2021 09:19:44 +0900
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <81cd7cea-6060-4500-8af3-cd324aef61de@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/09/25 11:59, Bart Van Assche wrote:
> On 9/24/21 03:58, Damien Le Moal wrote:
>> On 2021/09/24 8:27, Bart Van Assche wrote:
>>> -/* I/O statistics for all I/O priorities (enum dd_prio). */
>>> -struct io_stats {
>>> -	struct io_stats_per_prio stats[DD_PRIO_COUNT];
>>> +	uint32_t inserted;
>>> +	uint32_t merged;
>>> +	uint32_t dispatched;
>>> +	atomic_t completed;
>>
>> Why not use 64-bits types (regular unsigned long long and atomic64_t) ?
> 
> Even 64-bit counters can overflow. Using 32-bit counters makes it easier to
> trigger an overflow of these counters.

I was more thinking about the speed of additions/subtractions on 64-bits arch,
which is a large part (the majority ?) of mq-deadline users. Not sure if there
is a difference in speed for 32 bits and 64 bits simple math on 64 bits arch
though. Probably not.

Another thing: in patch 3, you are actually not handling the overflows. So
dd_queued() may return some very weird number (temporarily) when the inserted
count overflows before the completed count does. Since
dd_dispatch_aged_requests() does not care about the actual value of dd_queued(),
only if it is 0 or not, I am not 100% sure if it is useful to fix. Except maybe
for sysfs attributes ?



-- 
Damien Le Moal
Western Digital Research
