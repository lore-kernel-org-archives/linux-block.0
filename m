Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83947C76195
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 07:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjC1Hu5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 03:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjC1Hux (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 03:50:53 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CD73A89
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 00:50:37 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230328075032epoutp02073a6e563ca908e24115f87cdb819200~QhdojTx3_1246812468epoutp024
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 07:50:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230328075032epoutp02073a6e563ca908e24115f87cdb819200~QhdojTx3_1246812468epoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679989832;
        bh=lSBR1Ys+6OSEPSTE2FGqhntsR4WsCiVqTZVmRbAzS0M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p4ylQsa8ZJ3AVER/T+/wovgeemh3I/QS9gAseFSRD5k92qsX/zh4fTx8DAUf9lxUx
         aP5PGCpD5ixCtlf/wd/xfUEmNLuOCNylb6CJjn88w4nU+pQ56Nq8hwU+TjtAw9PsKe
         O0Z7g/8DlRqjAGjvuo14GphlAlxhwUult7uxx7ZY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230328075032epcas5p17df989408c79b4bda9413edc99840cba~Qhdn02wuL0732907329epcas5p1l;
        Tue, 28 Mar 2023 07:50:32 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Pm20k54JWz4x9QH; Tue, 28 Mar
        2023 07:50:30 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.E4.10528.64C92246; Tue, 28 Mar 2023 16:50:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230328075030epcas5p230db015f0e7d7ecdfc0da5865718c7a5~QhdmBcGYA0990309903epcas5p23;
        Tue, 28 Mar 2023 07:50:30 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230328075030epsmtrp14f54409368c755feac49bb5dd38d1bae~QhdmAsVUu1698016980epsmtrp1h;
        Tue, 28 Mar 2023 07:50:30 +0000 (GMT)
X-AuditID: b6c32a49-e75fa70000012920-f3-64229c467d3c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.97.31821.64C92246; Tue, 28 Mar 2023 16:50:30 +0900 (KST)
Received: from green5 (unknown [107.110.206.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230328075029epsmtip27b594a26f20e3de903a10398599a94e0~Qhdk9ZOdE1665716657epsmtip2G;
        Tue, 28 Mar 2023 07:50:28 +0000 (GMT)
Date:   Tue, 28 Mar 2023 13:19:39 +0530
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Kanchan Joshi <joshiiitr@gmail.com>, Keith Busch <kbusch@meta.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        axboe@kernel.dk, hch@lst.de
Subject: Re: [PATCH 2/2] nvme: use blk-mq polling for uring commands
Message-ID: <20230328074939.GA2800@green5>
MIME-Version: 1.0
In-Reply-To: <ZCI5XopTr7nJvVF1@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmpq7bHKUUg/s/VCxW3+1ns1i5+iiT
        xfm3h5ksJh26xmhx5upCFou9t7Qt5i97yu7A7rFz1l12j8tnSz02repk89i8pN5j980GNo9z
        Fys8Pm+SC2CPyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQ
        dcvMATpGSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqXrpeXWmJl
        aGBgZApUmJCd0TVzElPBPNGKE4/fsDcwLhDsYuTkkBAwkfg9ZSFLFyMXh5DAbkaJ6V3rWEAS
        QgKfGCU69xRB2J8ZJT6vtoJpmH51LhtEwy5GiSkHfrJDOE8YJRY8nscIUsUioCoxt6GPuYuR
        g4NNQFPiwuRSkLCIgLLE3fkzWUFsZoEljBJz5qSC2MICLhLrjmwAi/MKaEn0Ln/EDmELSpyc
        +QTsIE4Be4mzrzczg9iiQHMObDvOBLJXQmAqh8S6KZuYIa5zkdh9/zkjhC0s8er4FnYIW0ri
        ZX8blJ0scWnmOSYIu0Ti8Z6DULa9ROupfmaI4zIlHi/ZyAZh80n0/n7CBPKLhACvREebEES5
        osS9SU9ZIWxxiYczlkDZHhKzX+xhhgRcO7PE7QtsExjlZiF5ZxaSDRC2lUTnhyZWCFteonnr
        bOZZQNuYBaQllv/jgDA1Jdbv0l/AyLaKUTK1oDg3PbXYtMAwL7UcHtvJ+bmbGMEJVctzB+Pd
        Bx/0DjEycTAeYpTgYFYS4d3srZgixJuSWFmVWpQfX1Sak1p8iNEUGFMTmaVEk/OBKT2vJN7Q
        xNLAxMzMzMTS2MxQSZxX3fZkspBAemJJanZqakFqEUwfEwenVAOT8I/5azcYTj73+HJsQsEF
        T+XcLR/Zug/rHyz5Xr6pgcPegHHWN/7KvzKq9l1+0rUpr3t0vhdk1AaJzODY/GHP4kdRMvsu
        Bz20uHp2faFFbNCTnf7zbbbMtHuh+Ll5++2Jlhu4lvTWHWQ/NPVZ0VzrPTO+6fLZrlLKe9u6
        PyH+wCSFhIVrr0/dY75gw7VrO5w+OQp+nsn6o/DkUZX3J/zPBJsyXNv59WnKEruLh/5Obd3Y
        +tX1ft1D7R/sUyTv2U09eJfp/LuOVdFcwkd6RMo6PDgU9xrPvzyTb/LBh5sEYh0ueYZJtFo6
        9Z/VUi0xm69afFzoQejJqXO7GIqvxE1U+sLjdb/8nPO321/Xieeeq1NiKc5INNRiLipOBACk
        Ug+fMQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWy7bCSvK7bHKUUg1VLuSxW3+1ns1i5+iiT
        xfm3h5ksJh26xmhx5upCFou9t7Qt5i97yu7A7rFz1l12j8tnSz02repk89i8pN5j980GNo9z
        Fys8Pm+SC2CP4rJJSc3JLEst0rdL4Mr4/2sqW8EaoYrrjacYGxhP83UxcnJICJhITL86l62L
        kYtDSGAHo8SHaVdYIBLiEs3XfrBD2MISK/89Z4coesQosbtvH1gRi4CqxNyGPuYuRg4ONgFN
        iQuTS0HCIgLKEnfnz2QFsZkFljBKzJmTCmILC7hIrDuyASzOK6Al0bv8Edh8IYFOZoljd6Qh
        4oISJ2c+YYHoNZOYt/kh2HhmAWmJ5f84IMLyEs1bZzOD2JwC9hJnX28Gs0WB1h7YdpxpAqPQ
        LCSTZiGZNAth0iwkkxYwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiOHi2tHYx7
        Vn3QO8TIxMF4iFGCg1lJhHezt2KKEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tS
        s1NTC1KLYLJMHJxSDUzCQhwWP25LFlhVZG2rKui+liHx5ahF3LlZ50N37lA7K3wt6EPh9paY
        gx8aEje+rWI3t5qr1jtTTKRu98LjsTcOWWROak4pDlU9v094f8uDG0qH7P6crj/oGy495X17
        kFXlvMB7U+onTT7c03Us6bZ9eqlr/t3QirwvSvGKd24EzZF7f/FQum/vAWdmmXlcxQnB/7om
        njVYc3lJ1MtTjFvapb+eujfT5uEe48kbNBasuMrHW1XX+Hl6R3OxkXaV9OV1K5ifum78yddZ
        6Tsp42modfRSuXsvj1c4tijKL306W376P9Mj+tl7P39IsLp6fc/DzxOW7fBZ+m/Hgtu9Fwou
        rp3Fx3Lw2u7XT2RZ5vL7KrEUZyQaajEXFScCANxOooMNAwAA
X-CMS-MailID: 20230328075030epcas5p230db015f0e7d7ecdfc0da5865718c7a5
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----IPzR0Zmv7eUACe1AcPM4bhPiN.NxXwyEj5sj1OQa2HLEVOb4=_112ba8_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230324213124epcas5p331ea3c2e2a05ec6a6825e719e47d2427
References: <20230324212803.1837554-1-kbusch@meta.com>
        <CGME20230324213124epcas5p331ea3c2e2a05ec6a6825e719e47d2427@epcas5p3.samsung.com>
        <20230324212803.1837554-2-kbusch@meta.com> <20230327135810.GA8405@green5>
        <ZCG0O6RdlA/sUd7C@kbusch-mbp.dhcp.thefacebook.com>
        <CA+1E3rK2h9gyy26v1NmwTFtUsCwMkc1DgkDsCFME+HjZJPn5Hg@mail.gmail.com>
        <ZCI5XopTr7nJvVF1@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

------IPzR0Zmv7eUACe1AcPM4bhPiN.NxXwyEj5sj1OQa2HLEVOb4=_112ba8_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Mon, Mar 27, 2023 at 06:48:30PM -0600, Keith Busch wrote:
>On Mon, Mar 27, 2023 at 10:50:47PM +0530, Kanchan Joshi wrote:
>> On Mon, Mar 27, 2023 at 8:59 PM Keith Busch <kbusch@kernel.org> wrote:
>> > > >     rcu_read_lock();
>> > > > -   bio = READ_ONCE(ioucmd->cookie);
>> > > > -   ns = container_of(file_inode(ioucmd->file)->i_cdev,
>> > > > -                   struct nvme_ns, cdev);
>> > > > -   q = ns->queue;
>> > > > -   if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio && bio->bi_bdev)
>> > > > -           ret = bio_poll(bio, iob, poll_flags);
>> > > > +   req = READ_ONCE(ioucmd->cookie);
>> > > > +   if (req) {
>> > >
>> > > This is risky. We are not sure if the cookie is actually "req" at this
>> > > moment.
>> >
>> > What else could it be? It's either a real request from a polled hctx tag, or
>> > NULL at this point.
>>
>> It can also be a function pointer that gets assigned on irq-driven completion.
>> See the "struct io_uring_cmd" - we are tight on cacheline, so cookie
>> and task_work_cb share the storage.
>>
>> > It's safe to check the cookie like this and rely on its contents.
>> Hence not safe. Please try running this without poll-queues (at nvme
>> level), you'll see failures.
>
>Okay, you have a iouring polling instance used with a file that has poll
>capabilities, but doesn't have any polling hctx's. It would be nice to exclude
>these from io_uring's polling since they're wasting CPU time, but that doesn't
>look easily done.

Do you mean having the ring with IOPOLL set, and yet skip the attempt of
actively reaping the completion for certain IOs?

>This simple patch atop should work though.
>
>---
>diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
>index 369e8519b87a2..e3ff019404816 100644
>--- a/drivers/nvme/host/ioctl.c
>+++ b/drivers/nvme/host/ioctl.c
>@@ -612,6 +612,8 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>
> 	if (blk_rq_is_poll(req))
> 		WRITE_ONCE(ioucmd->cookie, req);
>+	else if (issue_flags & IO_URING_F_IOPOLL)
>+		ioucmd->flags |= IORING_URING_CMD_NOPOLL;

If IO_URING_F_IOPOLL would have come here as part of "ioucmd->flags", we
could have just cleared that here. That would avoid the need of NOPOLL flag.
That said, I don't feel strongly about new flag too. You decide.

------IPzR0Zmv7eUACe1AcPM4bhPiN.NxXwyEj5sj1OQa2HLEVOb4=_112ba8_
Content-Type: text/plain; charset="utf-8"


------IPzR0Zmv7eUACe1AcPM4bhPiN.NxXwyEj5sj1OQa2HLEVOb4=_112ba8_--
