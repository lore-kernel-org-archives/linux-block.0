Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:64396 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751900AbdEDXNp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2017 19:13:45 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "osandov@osandov.com" <osandov@osandov.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
CC: "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 06/12] blk-mq-debugfs: get rid of a bunch of
 boilerplate
Date: Thu, 4 May 2017 23:13:42 +0000
Message-ID: <1493939622.2692.16.camel@sandisk.com>
References: <cover.1493882751.git.osandov@fb.com>
         <fe05c2e075a1f02a952760f38a3854942f38478f.1493882751.git.osandov@fb.com>
In-Reply-To: <fe05c2e075a1f02a952760f38a3854942f38478f.1493882751.git.osandov@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 2017-05-04 at 00:31 -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
>=20
> A large part of blk-mq-debugfs.c is file_operations and seq_file
> boilerplate. This sucks as is but will suck even more when schedulers
> can define their own debugfs entries. Factor it all out into a single
> blk_mq_debugfs_fops which multiplexes as needed. We store the
> request_queue, blk_mq_hw_ctx, or blk_mq_ctx in the parent directory
> dentry, which is kind of hacky, but it works.

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>=
