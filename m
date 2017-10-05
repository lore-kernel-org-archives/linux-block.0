Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:7496 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbdJEQHJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Oct 2017 12:07:09 -0400
Subject: Re: [Question] on blk_mq_map_queues()
To: Christoph Hellwig <hch@lst.de>
References: <f5280c3c-ffd9-bc3a-7e0b-226c4a1232c9@huawei.com>
 <20171005155901.GA30575@lst.de>
CC: <linux-block@vger.kernel.org>, <axboe@kernel.dk>,
        <maxg@mellanox.com>, Linuxarm <linuxarm@huawei.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <9f1e7e62-7d9d-199f-cb78-3dc4039b3042@huawei.com>
Date: Thu, 5 Oct 2017 17:06:54 +0100
MIME-Version: 1.0
In-Reply-To: <20171005155901.GA30575@lst.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/10/2017 16:59, Christoph Hellwig wrote:
> On Thu, Oct 05, 2017 at 02:28:43PM +0100, John Garry wrote:
>> I know that we can add our own per-driver mapping function to solve, but I
>> would expect that that generic mapper would cover a generic platform.
>
> Why aren't you using blk_mq_pci_map_queues?
>
> What kind of hardware are we talking about?
>
> .
>

It's a HiSilicon hip07 (D05) platform. For this platform, the integrated 
SAS controller is a platform device. This controller supports 16 hw queues.

In terms of core profile, the board has 2 sockets, each socket has 2 cpu 
die, and each die has 4 clusters of 4 cores (ARM A72), so a total of 64 
cores.

Cheers,
John
