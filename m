Return-Path: <SRS0=Dgp+=T4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E9BC04AB6
	for <linux-block@archiver.kernel.org>; Tue, 28 May 2019 08:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E12E2075C
	for <linux-block@archiver.kernel.org>; Tue, 28 May 2019 08:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfE1I4R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 May 2019 04:56:17 -0400
Received: from m97179.mail.qiye.163.com ([220.181.97.179]:10709 "EHLO
        m97179.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfE1I4R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 May 2019 04:56:17 -0400
Received: from localhost (unknown [120.132.1.243])
        by m97179.mail.qiye.163.com (Hmail) with ESMTPA id 02FDBE01982;
        Tue, 28 May 2019 16:56:05 +0800 (CST)
Date:   Tue, 28 May 2019 02:29:25 +0800
From:   Yao Liu <yotta.liu@ucloud.cn>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH 3/3] nbd: mark sock as dead even if it's the last one
Message-ID: <20190527182925.GC20702@192-168-150-246.7~>
References: <1558691036-16281-1-git-send-email-yotta.liu@ucloud.cn>
 <1558691036-16281-3-git-send-email-yotta.liu@ucloud.cn>
 <20190524131714.i3lbkbokad6xmotv@MacBook-Pro-91.local.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524131714.i3lbkbokad6xmotv@MacBook-Pro-91.local.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-HM-Spam-Status: e1kIGBQJHllBWUtVQ01DQkJCTExCSUlPSEJNWVdZKFlBSUI3V1ktWUFJV1
        kJDhceCFlBWTU0KTY6NyQpLjc#WQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MFE6Qgw4IjgrCCNCIQscMQJR
        Iw9PFDRVSlVKTk5CS0hITE1OSk1MVTMWGhIXVQIUDw8aVRcSDjsOGBcUDh9VGBVFWVdZEgtZQVlK
        SUtVSkhJVUpVSU9IWVdZCAFZQUlISk83Bg++
X-HM-Tid: 0a6afda75c9820bdkuqy02fdbe01982
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 24, 2019 at 09:17:15AM -0400, Josef Bacik wrote:
> On Fri, May 24, 2019 at 05:43:56PM +0800, Yao Liu wrote:
> > When sock dead, nbd_read_stat should return a ERR_PTR and then we should
> > mark sock as dead and wait for a reconnection if the dead sock is the last
> > one, because nbd_xmit_timeout won't resubmit while num_connections <= 1.
> 
> num_connections is the total number of connections that the device was set up
> with, not how many are left.  Now since we have the dead_conn_timeout timeout
> stuff now which didn't exist when I originally wrote this code I'd be ok with
> doing that, but not the way you have it now.  It would be something more like
> 
> 	if (nbd_disconnected(config) ||
> 	    (config->num_connections <= 1 &&
> 	     !config->dead_conn_timeout)
> 
> instead.  Thanks,
> 
> Josef
> 

Your solution is better indeed.
