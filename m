Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3D0C04EB9
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 01:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BE62082F
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 01:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15BE62082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbeK3M1T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 07:27:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeK3M1S (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 07:27:18 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 742C130833A4;
        Fri, 30 Nov 2018 01:19:48 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 66BAE601B9;
        Fri, 30 Nov 2018 01:19:40 +0000 (UTC)
Date:   Fri, 30 Nov 2018 09:19:36 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "chenxiang (M)" <chenxiang66@hisilicon.com>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: DIF/DIX issue related to config CONFIG_SCSI_MQ_DEFAULT
Message-ID: <20181130011935.GA7573@ming.t460p>
References: <5d9bf51d-1ef9-b948-2168-9e7526d77225@hisilicon.com>
 <20181127130811.GA2780@ming.t460p>
 <6c573f36-60d8-0631-e9ac-dacd72f6c8ad@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c573f36-60d8-0631-e9ac-dacd72f6c8ad@hisilicon.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 30 Nov 2018 01:19:48 +0000 (UTC)
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

Hi chenxiang,

For DIX/DIF test, I think you need to pass 'dev_size_mb=XXX' instead of
'virtual_gb'.

I just run FIO over 'scsi_debug dev_size_mb=896 max_luns=1 dif=1 dix=1'
on one apm-mustang-ev3 board, and looks everything is fine. You may run
the same test on your D06 and see if it is fine.

Please check if you may reproduce the list corruption issue on v4.18 with
hisi_sas_v3_hw.

Thanks,
Ming
