Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bl2nam02on0077.outbound.protection.outlook.com ([104.47.38.77]:21728
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752076AbdA0WGw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2017 17:06:52 -0500
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "osandov@osandov.com" <osandov@osandov.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
CC: "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v3 05/10] sbitmap: add helpers for dumping to a seq_file
Date: Fri, 27 Jan 2017 22:06:32 +0000
Message-ID: <1485554768.13218.8.camel@sandisk.com>
References: <adfbb141405c3c0697af61bc686d8ec7d9aa2b8d.1485360145.git.osandov@fb.com>
         <20a158eb0622e89cd16d1c112952908561f6b0e3.1485382647.git.osandov@fb.com>
In-Reply-To: <20a158eb0622e89cd16d1c112952908561f6b0e3.1485382647.git.osandov@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2017-01-25 at 14:32 -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
>=20
> This is useful debugging information that will be used in the blk-mq
> debugfs directory.
>=20
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
> Jens took offense to me making the bitmap dumps binary, so this turns the=
m into
> nicely formatted hex dumps, like this one:
>=20
> # cat /sys/kernel/debug/block/nvme0n1/mq/0/tags_bitmap
> 00000000: 0000 0000 0000 0000 0000 0000 0000 0000
> 00000010: 0000 2000 0000 0000 0000 0000 0000 0000
> 00000020: 0000 0000 0000 0000 0000 0000 0000 0000
> 00000030: 0000 0000 0000 0000 0000 0000 0000 0000
> 00000040: 0000 0000 0000 0000 0000 0000 0000 0000
> 00000050: 0000 0000 0000 0000 0000 0000 0000 0000
> 00000060: 0000 0000 0000 0000 0000 0000 0000 0000
> 00000070: 0000 0000 0000 0000 0000 0000 0000 0000
>=20
> I decided to go with this format because 1) it's consistent with
> print_hex_dump() already in the kernel, and 2) it's much easier to read
> than a string of bits or hex values. In the example above, it's easy to
> see that byte 0x12 is set to 0x20 (and do some arithmetic from there to
> figure out that the stuck bit is 149).

Hello Omar,

Have you considered to convert the bitmap into a contiguous bitmap first
and to format that bitmap with snprintf(..., "%*pb", ...)? I think that
will result in even easier to read output.

Bart.=
