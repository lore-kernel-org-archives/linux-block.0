Return-Path: <SRS0=3NZC=WI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDF3C31E40
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 10:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783F020820
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 10:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbfHLKwF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:52:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:64367 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727981AbfHLKwF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Aug 2019 06:52:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 03:52:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,377,1559545200"; 
   d="scan'208";a="204671674"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by fmsmga002.fm.intel.com with ESMTP; 12 Aug 2019 03:52:01 -0700
Subject: Re: [RFC PATCH 0/7] Add MMC packed function
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulf.hansson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org
References: <cover.1563782844.git.baolin.wang@linaro.org>
 <CAMz4ku+NjcqLY0tWRxrBCRUnkpyWih42LYieKaf0FO6WsqO2vA@mail.gmail.com>
 <8abff7d6-0a3e-efe7-e8ec-9309fada9121@intel.com>
 <CAMz4kuKri79CtVA=g7Mzoda_fQBYAEXDzL77RGw7g+e0F48jcw@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <8e447a05-a859-5c71-911f-b5a0a907e8a0@intel.com>
Date:   Mon, 12 Aug 2019 13:50:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMz4kuKri79CtVA=g7Mzoda_fQBYAEXDzL77RGw7g+e0F48jcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/08/19 12:44 PM, Baolin Wang wrote:
> Hi Adrian,
> 
> On Mon, 12 Aug 2019 at 16:59, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 12/08/19 8:20 AM, Baolin Wang wrote:
>>> Hi,
>>>
>>> On Mon, 22 Jul 2019 at 21:10, Baolin Wang <baolin.wang@linaro.org> wrote:
>>>>
>>>> Hi All,
>>>>
>>>> Now some SD/MMC controllers can support packed command or packed request,
>>>> that means it can package multiple requests to host controller to be handled
>>>> at one time, which can improve the I/O performence. Thus this patchset is
>>>> used to add the MMC packed function to support packed request or packed
>>>> command.
>>>>
>>>> In this patch set, I implemented the SD host ADMA3 transfer mode to support
>>>> packed request. The ADMA3 transfer mode can process a multi-block data transfer
>>>> by using a pair of command descriptor and ADMA2 descriptor. In future we can
>>>> easily expand the MMC packed function to support packed command.
>>>>
>>>> Below are some comparison data between packed request and non-packed request
>>>> with fio tool. The fio command I used is like below with changing the
>>>> '--rw' parameter and enabling the direct IO flag to measure the actual hardware
>>>> transfer speed.
>>>>
>>>> ./fio --filename=/dev/mmcblk0p30 --direct=1 --iodepth=20 --rw=read --bs=4K --size=512M --group_reporting --numjobs=20 --name=test_read
>>>>
>>>> My eMMC card working at HS400 Enhanced strobe mode:
>>>> [    2.229856] mmc0: new HS400 Enhanced strobe MMC card at address 0001
>>>> [    2.237566] mmcblk0: mmc0:0001 HBG4a2 29.1 GiB
>>>> [    2.242621] mmcblk0boot0: mmc0:0001 HBG4a2 partition 1 4.00 MiB
>>>> [    2.249110] mmcblk0boot1: mmc0:0001 HBG4a2 partition 2 4.00 MiB
>>>> [    2.255307] mmcblk0rpmb: mmc0:0001 HBG4a2 partition 3 4.00 MiB, chardev (248:0)
>>>>
>>>> 1. Non-packed request
>>>> I tested 3 times for each case and output a average speed.
>>>>
>>>> 1) Sequential read:
>>>> Speed: 28.9MiB/s, 26.4MiB/s, 30.9MiB/s
>>>> Average speed: 28.7MiB/s
>>
>> This seems surprising low for a HS400ES card.  Do you know why that is?
> 
> I've set the clock to 400M, but it seems the hardware did not output
> the corresponding clock. I will check my hardware.
> 
>>>>
>>>> 2) Random read:
>>>> Speed: 18.2MiB/s, 8.9MiB/s, 15.8MiB/s
>>>> Average speed: 14.3MiB/s
>>>>
>>>> 3) Sequential write:
>>>> Speed: 21.1MiB/s, 27.9MiB/s, 25MiB/s
>>>> Average speed: 24.7MiB/s
>>>>
>>>> 4) Random write:
>>>> Speed: 21.5MiB/s, 18.1MiB/s, 18.1MiB/s
>>>> Average speed: 19.2MiB/s
>>>>
>>>> 2. Packed request
>>>> In packed request mode, I set the host controller can package maximum 10
>>>> requests at one time (Actually I can increase the package number), and I
>>>> enabled read/write packed request mode. Also I tested 3 times for each
>>>> case and output a average speed.
>>>>
>>>> 1) Sequential read:
>>>> Speed: 165MiB/s, 167MiB/s, 164MiB/s
>>>> Average speed: 165.3MiB/s
>>>>
>>>> 2) Random read:
>>>> Speed: 147MiB/s, 141MiB/s, 144MiB/s
>>>> Average speed: 144MiB/s
>>>>
>>>> 3) Sequential write:
>>>> Speed: 87.8MiB/s, 89.1MiB/s, 90.0MiB/s
>>>> Average speed: 89MiB/s
>>>>
>>>> 4) Random write:
>>>> Speed: 90.9MiB/s, 89.8MiB/s, 90.4MiB/s
>>>> Average speed: 90.4MiB/s
>>>>
>>>> Form above data, we can see the packed request can improve the performance greatly.
>>>> Any comments are welcome. Thanks a lot.
>>>
>>> Any comments for this patch set? Thanks.
>>
>> Did you consider adapting the CQE interface?
> 
> I am not very familiar with CQE, since my controller did not support
> it. But the MMC packed function had introduced some callbacks to help
> for different controllers to do packed request, so I think it is easy
> to adapt the CQE interface.
> 

I meant did you consider using the CQE interface instead of creating another
one?
