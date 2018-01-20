Return-Path: <linux-block-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:41264 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756718AbeATXkb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 Jan 2018 18:40:31 -0500
Date: Sat, 20 Jan 2018 18:40:28 -0500
From: Theodore Ts'o <tytso@mit.edu>
To: "Hongzhi, Song" <hongzhi.song@windriver.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: Panic with ext4,nbd,qemu-img,block
Message-ID: <20180120234028.GB4451@thunk.org>
References: <0555d0c0-1f42-e78f-28ab-6c7a00f0c020@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0555d0c0-1f42-e78f-28ab-6c7a00f0c020@windriver.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Jan 20, 2018 at 04:41:00PM +0800, Hongzhi, Song wrote:
> 
> 329.11 EXT4-fs (nbd0): mounted filesystem with ordered data mode. Opts:
> (null)
> 329.12 block nbd0: Connection timed out
> 329.13 block nbd0: shutting down sockets

That's your problem.  I'm guessing qemu-nbd is dying for some reason,
which is causing the nbd device to fail (hence the "connection timed
out").

						- Ted
