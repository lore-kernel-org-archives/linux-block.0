Return-Path: <SRS0=nCGH=T5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2939FC28CC1
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 09:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC1B2070D
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 09:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbfE2JiJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 May 2019 05:38:09 -0400
Received: from m9783.mail.qiye.163.com ([220.181.97.83]:2787 "EHLO
        m9783.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfE2JiJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 05:38:09 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 May 2019 05:38:06 EDT
Received: from localhost (unknown [120.132.1.243])
        by m9783.mail.qiye.163.com (Hmail) with ESMTPA id A1BD9C1A9B;
        Wed, 29 May 2019 17:31:24 +0800 (CST)
Date:   Wed, 29 May 2019 03:04:46 +0800
From:   Yao Liu <yotta.liu@ucloud.cn>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        nbd <nbd@other.debian.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] nbd: fix connection timed out error after
 reconnecting to server
Message-ID: <20190528190446.GA21513@192-168-150-246.7~>
References: <1558691036-16281-1-git-send-email-yotta.liu@ucloud.cn>
 <20190524130740.zfypc2j3q5e3gryr@MacBook-Pro-91.local.dhcp.thefacebook.com>
 <20190527180743.GA20702@192-168-150-246.7~>
 <20190528165758.zxfrv6fum4vwcv4e@MacBook-Pro-91.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528165758.zxfrv6fum4vwcv4e@MacBook-Pro-91.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-HM-Spam-Status: e1kIGBQJHllBWUtVQ01OQkJCQ0xMT05JQ05ZV1koWUFJQjdXWS1ZQUlXWQ
        kOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NAw6Hzo4Ezg3USJLOikVPU09
        OggaCRlVSlVKTk5CSklJSUNPQ05IVTMWGhIXVQIUDw8aVRcSDjsOGBcUDh9VGBVFWVdZEgtZQVlK
        SUtVSkhJVUpVSU9IWVdZCAFZQU5OSU43Bg++
X-HM-Tid: 0a6b02ee10a32085kuqya1bd9c1a9b
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 28, 2019 at 12:57:59PM -0400, Josef Bacik wrote:
> On Tue, May 28, 2019 at 02:07:43AM +0800, Yao Liu wrote:
> > On Fri, May 24, 2019 at 09:07:42AM -0400, Josef Bacik wrote:
> > > On Fri, May 24, 2019 at 05:43:54PM +0800, Yao Liu wrote:
> > > > Some I/O requests that have been sent succussfully but have not yet been
> > > > replied won't be resubmitted after reconnecting because of server restart,
> > > > so we add a list to track them.
> > > > 
> > > > Signed-off-by: Yao Liu <yotta.liu@ucloud.cn>
> > > 
> > > Nack, this is what the timeout stuff is supposed to handle.  The commands will
> > > timeout and we'll resubmit them if we have alive sockets.  Thanks,
> > > 
> > > Josef
> > > 
> > 
> > On the one hand, if num_connections == 1 and the only sock has dead,
> > then we do nbd_genl_reconfigure to reconnect within dead_conn_timeout,
> > nbd_xmit_timeout will not resubmit commands that have been sent
> > succussfully but have not yet been replied. The log is as follows:
> >  
> > [270551.108746] block nbd0: Receive control failed (result -104)
> > [270551.108747] block nbd0: Send control failed (result -32)
> > [270551.108750] block nbd0: Request send failed, requeueing
> > [270551.116207] block nbd0: Attempted send on invalid socket
> > [270556.119584] block nbd0: reconnected socket
> > [270581.161751] block nbd0: Connection timed out
> > [270581.165038] block nbd0: shutting down sockets
> > [270581.165041] print_req_error: I/O error, dev nbd0, sector 5123224 flags 8801
> > [270581.165149] print_req_error: I/O error, dev nbd0, sector 5123232 flags 8801
> > [270581.165580] block nbd0: Connection timed out
> > [270581.165587] print_req_error: I/O error, dev nbd0, sector 844680 flags 8801
> > [270581.166184] print_req_error: I/O error, dev nbd0, sector 5123240 flags 8801
> > [270581.166554] block nbd0: Connection timed out
> > [270581.166576] print_req_error: I/O error, dev nbd0, sector 844688 flags 8801
> > [270581.167124] print_req_error: I/O error, dev nbd0, sector 5123248 flags 8801
> > [270581.167590] block nbd0: Connection timed out
> > [270581.167597] print_req_error: I/O error, dev nbd0, sector 844696 flags 8801
> > [270581.168021] print_req_error: I/O error, dev nbd0, sector 5123256 flags 8801
> > [270581.168487] block nbd0: Connection timed out
> > [270581.168493] print_req_error: I/O error, dev nbd0, sector 844704 flags 8801
> > [270581.170183] print_req_error: I/O error, dev nbd0, sector 5123264 flags 8801
> > [270581.170540] block nbd0: Connection timed out
> > [270581.173333] block nbd0: Connection timed out
> > [270581.173728] block nbd0: Connection timed out
> > [270581.174135] block nbd0: Connection timed out
> >  
> > On the other hand, if we wait nbd_xmit_timeout to handle resubmission,
> > the I/O requests will have a big delay. For example, if timeout time is 30s,
> > and from sock dead to nbd_genl_reconfigure returned OK we only spend
> > 2s, the I/O requests will still be handled by nbd_xmit_timeout after 30s.
> 
> We have to wait for the full timeout anyway to know that the socket went down,
> so it'll be re-submitted right away and then we'll wait on the new connection.
> 
> Now we could definitely have requests that were submitted well after the first
> thing that failed, so their timeout would be longer than simply retrying them,
> but we have no idea of knowing which ones timed out and which ones didn't.  This
> way lies pain, because we have to matchup tags with handles.  This is why we
> rely on the generic timeout infrastructure, so everything is handled correctly
> without ending up with duplicate submissions/replies.  Thanks,
> 
> Josef
> 

But as I mentioned before, if num_connections == 1, nbd_xmit_timeout won't re-submit
commands and I/O error will occur. Should we change the condition
		if (config->num_connections > 1)
to
		if (config->num_connections >= 1)
?
