Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:45281 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751830AbdDNU4M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Apr 2017 16:56:12 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
CC: "hch@lst.de" <hch@lst.de>, "osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH 1/3] blk-mq: unify hctx delayed_run_work and run_work
Date: Fri, 14 Apr 2017 20:56:09 +0000
Message-ID: <1492203368.2644.16.camel@sandisk.com>
References: <1491839696-24783-1-git-send-email-axboe@fb.com>
         <1491839696-24783-2-git-send-email-axboe@fb.com>
         <1491933638.2654.12.camel@sandisk.com>
         <146849ab-b865-0ba7-b434-7101e013eafb@fb.com>
In-Reply-To: <146849ab-b865-0ba7-b434-7101e013eafb@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 2017-04-14 at 14:02 -0600, Jens Axboe wrote:
> I was waiting for further comments on patch 3/3.

Hello Jens,

Patch 3/3 is probably fine but I hope that you understand that the introduc=
tion
of a new race condition does not make me enthusiast. Should your explanatio=
n of
why that race is harmless perhaps be added as a comment?

Bart.=
