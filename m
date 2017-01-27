Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam03on0054.outbound.protection.outlook.com ([104.47.42.54]:56798
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752090AbdA0V4Y (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2017 16:56:24 -0500
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "osandov@osandov.com" <osandov@osandov.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
CC: "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 01/10] blk-mq: create debugfs directory tree
Date: Fri, 27 Jan 2017 21:56:09 +0000
Message-ID: <1485554150.13218.3.camel@sandisk.com>
References: <cover.1485360145.git.osandov@fb.com>
         <cc8db53f5dbd7a488822f903b1a9cf6d20d5be24.1485360145.git.osandov@fb.com>
In-Reply-To: <cc8db53f5dbd7a488822f903b1a9cf6d20d5be24.1485360145.git.osandov@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2017-01-25 at 08:06 -0800, Omar Sandoval wrote:
> +=A0=A0=A0=A0=A0=A0=A0for (i =3D 0; i < ARRAY_SIZE(blk_mq_debugfs_ctx_att=
rs); i++) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0const struct blk_mq_debugfs=
_attr *attr;
> +
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0attr =3D &blk_mq_debugfs_ct=
x_attrs[i];
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (!debugfs_create_file(at=
tr->name, attr->mode, ctx_dir, ctx,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 attr->fops))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ret=
urn -ENOMEM;
> +=A0=A0=A0=A0=A0=A0=A0}

This loop occurs two times. Please consider introducing a helper function,
e.g. debugfs_create_files(). If you follow the same convention as for sysfs=
,
namely to use a sentinel at the end of an attribute array then that helper
function will only need a pointer to the attribute array and won't need the
size of that array.

Bart.=
