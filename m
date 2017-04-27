Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10508 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964873AbdD0XT5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Apr 2017 19:19:57 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
CC: "hch@lst.de" <hch@lst.de>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH 1/6] mtip32xx: get rid of 'atomic' argument to
 mtip_exec_internal_command()
Date: Thu, 27 Apr 2017 23:19:54 +0000
Message-ID: <1493335193.2625.15.camel@sandisk.com>
References: <1493333494-600-1-git-send-email-axboe@fb.com>
         <1493333494-600-2-git-send-email-axboe@fb.com>
In-Reply-To: <1493333494-600-2-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 2017-04-27 at 16:51 -0600, Jens Axboe wrote:
> All callers can safely block. Kill the atomic/block argument, and
> remove the argument from all callers.

Reviewed-by: Bart Van Assche <Bart.VanAssche@sandisk.com>=
