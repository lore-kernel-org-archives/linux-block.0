Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5F0C43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 13:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3C420989
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 13:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C3C420989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbeK1AGY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 19:06:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52760 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbeK1AGY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 19:06:24 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F8B2307EAA6;
        Tue, 27 Nov 2018 13:08:32 +0000 (UTC)
Received: from ming.t460p (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B791560C4C;
        Tue, 27 Nov 2018 13:08:24 +0000 (UTC)
Date:   Tue, 27 Nov 2018 21:08:19 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "chenxiang (M)" <chenxiang66@hisilicon.com>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: DIF/DIX issue related to config CONFIG_SCSI_MQ_DEFAULT
Message-ID: <20181127130811.GA2780@ming.t460p>
References: <5d9bf51d-1ef9-b948-2168-9e7526d77225@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d9bf51d-1ef9-b948-2168-9e7526d77225@hisilicon.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 27 Nov 2018 13:08:32 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 27, 2018 at 05:55:45PM +0800, chenxiang (M) wrote:
> Hi all,
> 
> There is a issue which may be related to CONFIG_SCSI_MQ_DEFAULT: before we
> developed DIF/DIX feature on kernel 4.18 (disable CONFIG_SCSI_MQ_DEFAULT
> default), and
> it works well.

I guess you are testing hisi_sas_v3_hw, does 4.18 work with
'scsi_mod.use_blk_mq=Y'? If yes, you may run 'git bisect' to figure out
which commit is the 1st bad one.

> But when we switch to kernel 4.19-rc1 and 4.20-rc1, Call
> trace as follow occurs when running fio and if disable config
> CONFIG_SCSI_MQ_DEFAULT,
> then it works well. Also if switch ioengine=libaio to ioengine=psync, it
> seems also work well. Do you have any idea or encounter similar issue?

I tested scsi-debug via 'dix=1 dif=1', looks everything is fine, are you
using direct io or not?

> 
> job1: (g=0): rw=rw, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=128
> job1: (g=0): rw=rw, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=128
> job1: (g=0): rw=rw, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=128
> job1: (g=0): rw=rw, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=128
> job1: (g=0): rw=rw, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=128
> job1: (g=0): rw=rw, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=128
> job1: (g=0): rw=rw, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=128
> job1: (g=0): rw=rw, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=128
> job1: (g=0): rw=rw, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=128
> job1: (g=0): rw=rw, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=128
> job1: (g=0): rw=rw, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=128
> job1: (g=0): rw=rw, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=128
> fio 2.0.5
> Starting 12 processes
> [  629.210506] Unable to handle kernel paging request at virtual address
> 0000ffff8027e048
> [  629.210506] Unable to handle kernel paging request at virtual address
> 0000ffff8027e048
> [  629.226373] Mem abort info:
> [  629.226373] Mem abort info:
> [  629.231952]   ESR = 0x96000006
> [  629.231952]   ESR = 0x96000006
> [  629.238052]   Exception class = DABT (current EL), IL = 32 bits
> [  629.238052]   Exception class = DABT (current EL), IL = 32 bits
> [  629.249898]   SET = 0, FnV = 0
> [  629.249898]   SET = 0, FnV = 0
> [  629.255998]   EA = 0, S1PTW = 0
> [  629.255998]   EA = 0, S1PTW = 0
> [  629.262272] Data abort info:
> [  629.262272] Data abort info:
> [  629.268023]   ISV = 0, ISS = 0x00000006
> [  629.268023]   ISV = 0, ISS = 0x00000006
> [  629.275690]   CM = 0, WnR = 0
> [  629.275690]   CM = 0, WnR = 0
> [  629.281617] user pgtable: 4k pages, 48-bit VAs, pgdp = 0000000085c91728
> [  629.281617] user pgtable: 4k pages, 48-bit VAs, pgdp = 0000000085c91728
> [  629.294857] [0000ffff8027e048] pgd=00000027a8644003,
> pud=00000027a85ea003, pmd=0000000000000000
> [  629.294857] [0000ffff8027e048] pgd=00000027a8644003,
> pud=00000027a85ea003, pmd=0000000000000000
> [  629.312278] Internal error: Oops: 96000006 [#1] PREEMPT SMP
> [  629.312278] Internal error: Oops: 96000006 [#1] PREEMPT SMP
> [  629.323427] Modules linked in: hisi_sas_v3_hw [last unloaded:
> hisi_sas_v3_hw]
> [  629.323427] Modules linked in: hisi_sas_v3_hw [last unloaded:
> hisi_sas_v3_hw]
> [  629.337713] CPU: 13 PID: 4465 Comm: fio Not tainted
> 4.20.0-rc1-15093-ge876dec #1067
> [  629.337713] CPU: 13 PID: 4465 Comm: fio Not tainted
> 4.20.0-rc1-15093-ge876dec #1067
> [  629.353040] Hardware name: Huawei D06/D06, BIOS Hisilicon D06 UEFI RC0 -
> B601 (V6.01) 11/08/2018
> [  629.353040] Hardware name: Huawei D06/D06, BIOS Hisilicon D06 UEFI RC0 -
> B601 (V6.01) 11/08/2018
> [  629.370633] pstate: 80400009 (Nzcv daif +PAN -UAO)
> [  629.370633] pstate: 80400009 (Nzcv daif +PAN -UAO)
> [  629.380218] pc : deadline_remove_request+0x2c/0xd0
> [  629.380218] pc : deadline_remove_request+0x2c/0xd0

Could you use gdb to find where 'deadline_remove_request+0x2c' points
to?

Thanks,
Ming
