Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24293 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbdEDXHB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2017 19:07:01 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "osandov@osandov.com" <osandov@osandov.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
CC: "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 03/12] blk-mq-debugfs: error on long write to queue
 "state" file
Date: Thu, 4 May 2017 23:06:58 +0000
Message-ID: <1493939217.2692.13.camel@sandisk.com>
References: <cover.1493882751.git.osandov@fb.com>
         <859ef1939e07171f902b4fbb5bebbb274d68df18.1493882751.git.osandov@fb.com>
In-Reply-To: <859ef1939e07171f902b4fbb5bebbb274d68df18.1493882751.git.osandov@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 2017-05-04 at 00:31 -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
>=20
> blk_queue_flags_store() currently truncates and returns a short write if
> the operation being written is too long. This can give us weird results,
> like here:
>=20
> $ echo "run            bar"
> echo: write error: invalid argument
> $ dmesg
> [ 1103.075435] blk_queue_flags_store: unsupported operation bar. Use eith=
er 'run' or 'start'
>=20
> Instead, return an error if the user does this. While we're here, make
> the argument names consistent with everywhere else in this file.

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>=
