Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33502 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752080AbdDFIaI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2017 04:30:08 -0400
Subject: Re: [PATCH rfc 6/6] nvme-rdma: use intelligent affinity based queue
 mappings
To: Christoph Hellwig <hch@lst.de>
References: <1491140492-25703-1-git-send-email-sagi@grimberg.me>
 <1491140492-25703-7-git-send-email-sagi@grimberg.me>
 <20170404063444.GF8978@lst.de>
Cc: linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, netdev@vger.kernel.org,
        Saeed Mahameed <saeedm@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d896e706-ae78-6be1-dd21-fa73150537b4@grimberg.me>
Date: Thu, 6 Apr 2017 11:30:02 +0300
MIME-Version: 1.0
In-Reply-To: <20170404063444.GF8978@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


>> Use the geneic block layer affinity mapping helper. Also,
>
>           generic
>
>>  	nr_io_queues = min(opts->nr_io_queues, num_online_cpus());
>> +	nr_io_queues = min_t(unsigned int, nr_io_queues,
>> +				ibdev->num_comp_vectors);
>> +
>
> Add a comment here?

Will do
