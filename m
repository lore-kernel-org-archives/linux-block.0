Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD816C00140
	for <linux-block@archiver.kernel.org>; Thu, 18 Aug 2022 10:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239504AbiHRKEl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Aug 2022 06:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbiHRKEk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Aug 2022 06:04:40 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105F232DBC
        for <linux-block@vger.kernel.org>; Thu, 18 Aug 2022 03:04:39 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id o22so1218135edc.10
        for <linux-block@vger.kernel.org>; Thu, 18 Aug 2022 03:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=6SPSZ9WyMlXtP5e9ZemiFNvEgrxI8+9VNLCzjaFEiZ4=;
        b=RUeg41QOGC16wJE+VOq4icg9eHci9kVsMOv3fW+bf5Ir/vE84NtCWgxXccWLBUDQt5
         4xkhMXouz/8us1BxAovZGhtJUdABFG1rkfH8SSwKVoIjf2mzzqsrRZRKw4B+KDNHRXhS
         iexdo1SvtMRMTXDq3yDsj/WSHf/AQ4PGEkm7jgUA4MlZZFIjagfTc0yDfrsdjESAvD24
         BXahDEASYAvZkCMyYzbT7kS5Kv3x9q8sq0mo1WP+uiPVHpSAXED2Gte1E9mMKh5ZooaZ
         lP1IemqSgZzLrG4kzQNc3hBkRjpt+QjiUo+FVquLbVjQ28RNdYDcyrqgj4YyTPuPvFdi
         eyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=6SPSZ9WyMlXtP5e9ZemiFNvEgrxI8+9VNLCzjaFEiZ4=;
        b=krMKOtAUCeS+FafzbD6i7uQ6Refa1HgpdmcmVMbRehRMUkhl8iFYMziMyVyInNjJkI
         lDcpz/mrO4xbRLtRYX3endKgqFV8gpq2oZ+NWj69XitvjNHo46VE9HGahBNTj6FnTKIw
         H3F2ML1Z3KMn2ohdPGtc1c1eoPUEjiXNWT7F2ISjg6esHcxFboApyII7Bjq5wjixsjwc
         1vIP1Bk0tuDowWLFaYyKIya1+sBSQ+iTpNwMMs352MH6W+W//Ix3aAkoyDfKf2jMuuwj
         UedGocyoHCS2tDIb5+5QYiRuLM05GbOcXuR1SXed/ZhLMzXfObPKWWezdX37Qvii27DR
         h0ag==
X-Gm-Message-State: ACgBeo17V77fXF0qSe2al2Xhs6/Ad9RxmUUHc14x1/rkVWUCwglHByEH
        bmDZ0ari6YnspT1w9jW+gODgdo17RvuwlbjBrwYTDw==
X-Google-Smtp-Source: AA6agR5pb/TfpTGuZxLAto/Mx49IkcLxlNIu9YPH85jw4XOdpceDnmzkflQSGQxE4AQLLj1WhCZbMXHMEEP27cNRJTo=
X-Received: by 2002:a05:6402:2989:b0:43e:91be:fd20 with SMTP id
 eq9-20020a056402298900b0043e91befd20mr1701770edb.109.1660817077642; Thu, 18
 Aug 2022 03:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220815170043.19489-1-bvanassche@acm.org> <20220815170043.19489-3-bvanassche@acm.org>
 <69dcf8c1-814d-7f76-853f-aaa6c924c09a@grimberg.me>
In-Reply-To: <69dcf8c1-814d-7f76-853f-aaa6c924c09a@grimberg.me>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Thu, 18 Aug 2022 12:04:27 +0200
Message-ID: <CAJpMwyjfn14zN=KUUnJBPswrbWX5zbd6OUrMokuPW1qDTsB4RA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] block: Change the return type of
 blk_mq_map_queues() into void
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jason Wang <jasowang@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        James Smart <james.smart@broadcom.com>,
        John Garry <john.garry@huawei.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        Don Brace <don.brace@microchip.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        Bean Huo <beanhuo@micron.com>,
        Avri Altman <avri.altman@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 17, 2022 at 12:32 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

For RNBD changes,

Acked-by: Md Haris Iqbal <haris.iqbal@ionos.com>

Thanks
