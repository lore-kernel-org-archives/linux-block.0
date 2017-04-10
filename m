Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:47717 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752415AbdDJQRX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2017 12:17:23 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
CC: "hch@lst.de" <hch@lst.de>, "osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH 1/3] blk-mq: unify hctx delayed_run_work and run_work
Date: Mon, 10 Apr 2017 16:17:05 +0000
Message-ID: <1491841023.4199.9.camel@sandisk.com>
References: <1491839696-24783-1-git-send-email-axboe@fb.com>
         <1491839696-24783-2-git-send-email-axboe@fb.com>
In-Reply-To: <1491839696-24783-2-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 2017-04-10 at 09:54 -0600, Jens Axboe wrote:
> They serve the exact same purpose. Get rid of the non-delayed
> work variant, and just run it without delay for the normal case.

Reviewed-by: Bart Van Assche <Bart.VanAssche@sandisk.com>=
