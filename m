Return-Path: <SRS0=fyvH=WM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28DFC3A59C
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 02:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87EBF2089E
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 02:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfHPCtr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Aug 2019 22:49:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfHPCtq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Aug 2019 22:49:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A2DA43082DDD;
        Fri, 16 Aug 2019 02:49:46 +0000 (UTC)
Received: from ming.t460p (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E9CE8841FD;
        Fri, 16 Aug 2019 02:49:40 +0000 (UTC)
Date:   Fri, 16 Aug 2019 10:49:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Ray, Mark C (Global Solutions Engineering (GSE))" <mark.ray@hpe.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: avoid sysfs buffer overflow by too many CPU cores
Message-ID: <20190816024934.GA27844@ming.t460p>
References: <20190815121518.16675-1-ming.lei@redhat.com>
 <20190815122419.GA31891@kroah.com>
 <20190815122909.GA28032@ming.t460p>
 <20190815123535.GA29217@kroah.com>
 <20190815124321.GB28032@ming.t460p>
 <AT5PR8401MB05784C37BAF2939B776103FC99AC0@AT5PR8401MB0578.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AT5PR8401MB05784C37BAF2939B776103FC99AC0@AT5PR8401MB0578.NAMPRD84.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 16 Aug 2019 02:49:46 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 15, 2019 at 11:10:35PM +0000, Ray, Mark C (Global Solutions Engineering (GSE)) wrote:
> Hi Ming,
> 
> In the customer case, the cpu_list file was not needed.   It was just part of a SAP Hana script to collect all the block device data (similar to sosreport).    So they were just dumping everything, and it picks up the mq-related files.  
> 
> I know with IRQs, we have bitmaps/mask, and can represent the list such as "0-27", without listing every CPU.   I'm sure there's lots of options to address this, and getting rid of the cpu_list is one of them.

Indeed, same with several attributes under /sys/devices/system/cpu/,
actually we can use cpumap_print_to_pagebuf() to print the CPUs.

Thanks,
Ming
