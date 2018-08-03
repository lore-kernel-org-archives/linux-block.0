Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:11904 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbeHCC5Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Aug 2018 22:57:24 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v3 8/9] blk-mq: Insert blk_pm_{add,put}_request() calls
Date: Fri, 3 Aug 2018 01:03:36 +0000
Message-ID: <9223e26eee24d595cde189daa9c121d07c2260e4.camel@wdc.com>
References: <20180802182944.14442-1-bart.vanassche@wdc.com>
         <20180802182944.14442-9-bart.vanassche@wdc.com>
         <20180802235338.GB16047@ming.t460p>
         <51cfe7ab9e54013e278072e91b59b04432488dc7.camel@wdc.com>
         <20180803001142.GD16047@ming.t460p>
In-Reply-To: <20180803001142.GD16047@ming.t460p>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 2018-08-03 at 08:11 +-0800, Ming Lei wrote:
+AD4- On Fri, Aug 03, 2018 at 12:08:54AM +-0000, Bart Van Assche wrote:
+AD4- +AD4- On Fri, 2018-08-03 at 07:53 +-0800, Ming Lei wrote:
+AD4- +AD4- +AD4- blk+AF8-pm+AF8-add+AF8-request() calls pm+AF8-request+AF8=
-resume() for waking up device, but
+AD4- +AD4- +AD4- it is wrong because it is async request, which can't guar=
antee device
+AD4- +AD4- +AD4- will be ready before calling .queue+AF8-rq().
+AD4- +AD4-=20
+AD4- +AD4- That's a longstanding issue and not something that has been int=
roduced by this
+AD4- +AD4- patch series. Hence patch 6/9 that issues a warning if pm+AF8-r=
equest+AF8-resume() would
+AD4- +AD4- be called.
+AD4-=20
+AD4- It is introduced by your patch, please see blk+AF8-pm+AF8-allow+AF8-r=
equest().

Did you perhaps misread my patch? Please have a look at commit c8158819d506
(+ACI-block: implement runtime pm strategy+ACI-). I think that commit from =
2013
introduced the pm+AF8-request+AF8-resume() call in blk+AF8-pm+AF8-add+AF8-r=
equest().

By the way, if you would like to see that call removed, I'm fine with
removing that call.

Thanks,

Bart.
