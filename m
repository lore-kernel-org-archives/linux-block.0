Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A9BC43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 02:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E002089F
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 02:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsBALRO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfBUCQp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 21:16:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44182 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfBUCQp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 21:16:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id w2so13588518wrt.11
        for <linux-block@vger.kernel.org>; Wed, 20 Feb 2019 18:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BoCft2H3OOktGGBi1LGw9wYX/8gSnCATsKwxzfa2pYk=;
        b=VsBALRO6wqsGCOkN227rHKjdGjFv6G/dCE8I1ZetcQEA7EtpiFB/dMQiYXQuiO4nfB
         yWu/ghkRHJtLf66zt9tB+Wj0A5mxmmOKnLTFWp0W0bv8/tnRW8EX4XIjqcILP4kjEk40
         x5UBR7iUMHJ6CXeX77fozA3VNc8voV6mrVNy5HMz0Nblw2I6lw09uTK7dIZxGnvpuo5Z
         8VkBvvvq72v3MXsqiEVJelVHPBp9jrHeMAvicu1pgPxSA51N+rRIXjtjCNKuV5PqMmCS
         laI9aw3GkcPTOg1xFqKknWS/keWJDIuJ3pKgvGLEQXvLg4yJHycZjHQCAUYGxOSg09zq
         XCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BoCft2H3OOktGGBi1LGw9wYX/8gSnCATsKwxzfa2pYk=;
        b=KVZRBrxAgYrjqFQcq9B75kKaDoak9skXTlM2XUD9IoIy9msOltH3z4GgFqWXkZS1o0
         KyvYAAzg+xj1/pEb+RdJGyQJ3LNONeajcGngWIn0Y0Yb6+dAcnaXTHmEL+SyeagTQVZc
         Grey74LBOko0GzC9LkInGb5/KFh3oIeWK8Qq8flKWBafkjyOYCXaaVzk0/rhOJXiPLbX
         kt66zdo+In/fyns0n3iggNFN+OdDa+xpwPRtZNliiV+MOK3yTH8B4wKpJYlqAjWWZw78
         17N2IIjtWs/a0Ti4rZOX0SLI1Hgla5glPfmpziQZUOUiQciczEz1aCiSrOeKEfmaxJbV
         TZdQ==
X-Gm-Message-State: AHQUAuaJIsAvxwEHDoXooYDU+5gqY2Kn0WHX/70K9UIhNIMVIKi7YDLZ
        P0/aJk9+AK0MNc+gRloBmEzFSp+aM7Cwyg9CyxU=
X-Google-Smtp-Source: AHgI3Ia0SIvdCKqrs+Xch89wziXV9Zg1wG2JAKCETMnPNj8K3pbIUUtnI9Ri7sY1vNPT73C0JSbsa/mfan3h1Eonj9o=
X-Received: by 2002:a05:6000:10c1:: with SMTP id b1mr511501wrx.275.1550715403184;
 Wed, 20 Feb 2019 18:16:43 -0800 (PST)
MIME-Version: 1.0
References: <20190220031122.GA17298@ming.t460p> <20190220141701.GA26537@lst.de>
 <SN6PR04MB45276D80E3181896ABF39D1E867D0@SN6PR04MB4527.namprd04.prod.outlook.com>
In-Reply-To: <SN6PR04MB45276D80E3181896ABF39D1E867D0@SN6PR04MB4527.namprd04.prod.outlook.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Thu, 21 Feb 2019 10:16:31 +0800
Message-ID: <CACVXFVMkxPJsAKkJ0uopFPCpFiZDxA2qH11Yt8AsuKHEmVqGxA@mail.gmail.com>
Subject: Re: Regression: NVMe: kernel BUG at lib/sg_pool.c:103!
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 21, 2019 at 2:16 AM Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> On 02/20/2019 06:17 AM, Christoph Hellwig wrote:
> > We shouldn't be allocating a scatterlist for a command that doesn't
> > have a payload.
> >
> > The blk_rq_payload_bytes check in nvme_rdma_map_data is supposed to
> > prevent that.
> >
> > Chaitanya, can you try to debug why this is not working?  I'm on
> > vacation and don't have much time right now unfortunately.
> >
>
>
> Hi Ming,
>
> Can you please test following patch on your system ?

With this patch, the test can pass.

[root@ktest-04 blktests]# ./check nvmeof-mp/002
nvmeof-mp/002 (File I/O on top of multipath concurrently with logout
and login (mq)) [passed]
    runtime  75.478s  ...  54.317s

>
>
>
>  From 79e178a53a9f101d1f5f6a4923298bb1ffe936ef Mon Sep 17 00:00:00 2001
> From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Date: Wed, 20 Feb 2019 09:16:58 -0800
> Subject: [PATCH] nvme-rdma: use nr_phys_segments when map rq to sgl
>
> Use blk_rq_nr_phys_segments() instead of blk_rq_payload_bytes() to check
> if a command contains data to be mapped.  This fixes the case where
> a struct request contains LBAs, but it has no payload, such as
> Write Zeroes support.
>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>   drivers/nvme/host/rdma.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index ac365366c2ec..c6a489049fd5 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1150,7 +1150,7 @@ static void nvme_rdma_unmap_data(struct
> nvme_rdma_queue *queue,
>         struct nvme_rdma_device *dev = queue->device;
>         struct ib_device *ibdev = dev->dev;
>
> -       if (!blk_rq_payload_bytes(rq))
> +       if (!blk_rq_nr_phys_segments(rq))
>                 return;
>
>         if (req->mr) {
> @@ -1273,7 +1273,7 @@ static int nvme_rdma_map_data(struct
> nvme_rdma_queue *queue,
>
>         c->common.flags |= NVME_CMD_SGL_METABUF;
>
> -       if (!blk_rq_payload_bytes(rq))
> +       if (!blk_rq_nr_phys_segments(rq))
>                 return nvme_rdma_set_sg_null(c);
>
>         req->sg_table.sgl = req->first_sgl;
> --
> 2.17.0
>
>
> Also can you please share all the QEMU config/setup information that
> you have used to run the tests ? I want to add this test to the blktests
> with QEMU platform.

Just enable the required kernel config options and install
device-mapper-multipath,
then run './check nvmeof-mp/002', it will be started.

Thanks,
Ming Lei
