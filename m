Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385D8C32773
	for <linux-block@archiver.kernel.org>; Wed, 17 Aug 2022 09:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbiHQJgi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Aug 2022 05:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbiHQJgg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Aug 2022 05:36:36 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EDA74E17
        for <linux-block@vger.kernel.org>; Wed, 17 Aug 2022 02:36:34 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M72rR43q4z687XH;
        Wed, 17 Aug 2022 17:33:27 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 17 Aug 2022 11:36:31 +0200
Received: from [10.48.158.152] (10.48.158.152) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 10:36:29 +0100
Message-ID: <af508bef-3e79-2af4-e3ef-3413f4cae935@huawei.com>
Date:   Wed, 17 Aug 2022 10:36:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 2/2] block: Change the return type of
 blk_mq_map_queues() into void
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        Jason Wang <jasowang@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        James Smart <james.smart@broadcom.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        "Sumit Saxena" <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Nilesh Javali <njavali@marvell.com>,
        <GR-QLogic-Storage-Upstream@marvell.com>,
        Don Brace <don.brace@microchip.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "Damien Le Moal" <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        Bean Huo <beanhuo@micron.com>,
        Avri Altman <avri.altman@wdc.com>,
        "Adrian Hunter" <adrian.hunter@intel.com>
References: <20220815170043.19489-1-bvanassche@acm.org>
 <20220815170043.19489-3-bvanassche@acm.org>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220815170043.19489-3-bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.158.152]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 15/08/2022 18:00, Bart Van Assche wrote:
> Since blk_mq_map_queues() and the .map_queues() callbacks always return 0,
> change their return type into void. Most callers ignore the returned value
> anyway.
> 
> Cc: Christoph Hellwig<hch@lst.de>
> Cc: Jason Wang<jasowang@redhat.com>
> Cc: Keith Busch<kbusch@kernel.org>
> Cc: Martin K. Petersen<martin.petersen@oracle.com>
> Cc: Doug Gilbert<dgilbert@interlog.com>
> Cc: Michael S. Tsirkin<mst@redhat.com>
> Signed-off-by: Bart Van Assche<bvanassche@acm.org>
> ---


Reviewed-by: John Garry <john.garry@huawei.com>
