Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B880C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 00:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1385820645
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 00:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1385820645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbeK2L6E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 06:58:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55116 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbeK2L6E (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 06:58:04 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6053630820EE;
        Thu, 29 Nov 2018 00:54:33 +0000 (UTC)
Received: from ming.t460p (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 980387A5EA;
        Thu, 29 Nov 2018 00:54:26 +0000 (UTC)
Date:   Thu, 29 Nov 2018 08:54:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "chenxiang (M)" <chenxiang66@hisilicon.com>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: DIF/DIX issue related to config CONFIG_SCSI_MQ_DEFAULT
Message-ID: <20181129005421.GA23249@ming.t460p>
References: <5d9bf51d-1ef9-b948-2168-9e7526d77225@hisilicon.com>
 <20181127130811.GA2780@ming.t460p>
 <6c573f36-60d8-0631-e9ac-dacd72f6c8ad@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c573f36-60d8-0631-e9ac-dacd72f6c8ad@hisilicon.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 29 Nov 2018 00:54:33 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 28, 2018 at 10:50:11AM +0800, chenxiang (M) wrote:
> Hi  Lei Ming,
> 
> 在 2018/11/27 21:08, Ming Lei 写道:
> > On Tue, Nov 27, 2018 at 05:55:45PM +0800, chenxiang (M) wrote:
> > > Hi all,
> > > 
> > > There is a issue which may be related to CONFIG_SCSI_MQ_DEFAULT: before we
> > > developed DIF/DIX feature on kernel 4.18 (disable CONFIG_SCSI_MQ_DEFAULT
> > > default), and
> > > it works well.
> > I guess you are testing hisi_sas_v3_hw, does 4.18 work with
> > 'scsi_mod.use_blk_mq=Y'? If yes, you may run 'git bisect' to figure out
> > which commit is the 1st bad one.
> 
> Yes, i am testing hisi_sas_v3_hw, if 4.18 with 'scsi_mod.use_blk_mq=Y' ,
> there is still a issue, and
> the log is as attached ;

OK, looks not a regression.

> 
> > 
> > > But when we switch to kernel 4.19-rc1 and 4.20-rc1, Call
> > > trace as follow occurs when running fio and if disable config
> > > CONFIG_SCSI_MQ_DEFAULT,
> > > then it works well. Also if switch ioengine=libaio to ioengine=psync, it
> > > seems also work well. Do you have any idea or encounter similar issue?
> > I tested scsi-debug via 'dix=1 dif=1', looks everything is fine, are you
> > using direct io or not?
> Yes, i use direct io.
> I also test scsi-debug on kernel 4.19, and there seems be some other issue,
> and i am not sure
> whethere there is something wrong my operation:
> 
> root@(none)$ insmod scsi_debug.ko dif=1 dix=1 virtual_gb=120
> [  319.255051] scsi_debug:scsi_debug_init: dif_storep 131072 bytes @
> 00000000ba5f1637
> [  319.255051] scsi_debug:scsi_debug_init: dif_storep 131072 bytes @
> 00000000ba5f1637
> [  319.270661] scsi_debug:sdebug_driver_probe: host protection DIF1 DIX1
> [  319.270661] scsi_debug:sdebug_driver_probe: host protection DIF1 DIX1
> [  319.283562] scsi host3: scsi_debug: version 0188 [20180128]
> [  319.283562]   dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0
> [  319.283562] scsi host3: scsi_debug: version 0188 [20180128]
> [  319.283562]   dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0
> [  319.307871] scsi 3:0:0:0: Direct-Access     Linux scsi_debug       0188
> PQ: 0 ANSI: 7
> [  319.307871] scsi 3:0:0:0: Direct-Access     Linux scsi_debug       0188
> PQ: 0 ANSI: 7
> [  319.324173] sd 3:0:0:0: Power-on or device reset occurred
> [  319.324173] sd 3:0:0:0: Power-on or device reset occurred
> [  319.324242] sd 3:0:0:0: Attached scsi generic sg0 type 0
> [  319.324242] sd 3:0:0:0: Attached scsi generic sg0 type 0
> [  319.343021] sd 3:0:0:0: [sda] Enabling DIF Type 1 protection
> [  319.343021] sd 3:0:0:0: [sda] Enabling DIF Type 1 protection
> [  319.356952] sd 3:0:0:0: [sda] 251658240 512-byte logical blocks: (129
> GB/120 GiB)
> [  319.356952] sd 3:0:0:0: [sda] 251658240 512-byte logical blocks: (129
> GB/120 GiB)
> [  319.375948] sd 3:0:0:0: [sda] Write Protect is off
> [  319.375948] sd 3:0:0:0: [sda] Write Protect is off
> [  319.393551] sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled,
> supports DPO and FUA
> [  319.393551] sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled,
> supports DPO and FUA
> [  319.467940] sd 3:0:0:0: [sda] Enabling DIX T10-DIF-TYPE1-CRC protection
> [  319.467940] sd 3:0:0:0: [sda] Enabling DIX T10-DIF-TYPE1-CRC protection
> [  319.481189] sd 3:0:0:0: [sda] DIF application tag size 2
> [  319.481189] sd 3:0:0:0: [sda] DIF application tag size 2
> [  319.527902] sd 3:0:0:0: [sda] Attached SCSI disk
> [  319.527902] sd 3:0:0:0: [sda] Attached SCSI disk
> root@(none)$
> root@(none)$
> root@(none)$
> root@(none)$
> root@(none)$ fio --ioengine=libaio --bs=4k --rw=rw --filename=/dev/sd a
> --size=10G  --runtime=100 --direct=1 -numjobs=1  -iodepth=1 --time_based
> --nam e=job
> job: (g=0): rw=rw, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=1
> fio 2.0.5
> Starting 1 process
> Jobs: 1 (f=1)
> Jobs: 1 (f=1)
> Jobs: 1 (f=1): [M] [4.0% done] [495K/520K /s] [121 /127  iops] [eta 01m:37s]
> Jobs: 1 (f=1): [M] [5.0% done] [507K/507K /s] [124 /124  iops] [eta 01m:36s]
> Jobs: 1 (f=1): [M] [5.9% done] [516K/499K /s] [126 /122  iops] [eta 01m:35s]
> Jobs: 1 (f=1): [M] [6.9% done] [479K/536K /s] [117 /131  iops] [eta 01m:34s]
> Jobs: 1 (f=1): [M] [7.9% done] [495K/520K /s] [121 /127  iops] [eta 01m:33s]
> Jobs: 1 (f=1): [M] [8.9% done] [499K/516K /s] [122 /126  iops] [eta 01m:32s]
> [  353.298158] scsi_debug:dif_verify: REF check failed on sector 16456
> [  353.298158] scsi_debug:dif_verify: REF check failed on sector 16456

That is the issue, I guess it is one ARM64 dependent issue. I will try
to find a arm64 machine to debug it, hope I am lucky. Or you may try to
investigate it and see why the REF check fails.


thanks,
Ming
