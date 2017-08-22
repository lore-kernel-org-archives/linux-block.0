Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33411 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932350AbdHVKxb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Aug 2017 06:53:31 -0400
Received: by mail-wr0-f196.google.com with SMTP id a47so1447270wra.0
        for <linux-block@vger.kernel.org>; Tue, 22 Aug 2017 03:53:31 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] loop: LO_FLAGS_BLOCKSIZE fixes
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Hannes Reinecke <hare@suse.de>,
        Ming Lei <ming.lei@redhat.com>, Karel Zak <kzak@redhat.com>
References: <cover.1503084216.git.osandov@fb.com>
From: Milan Broz <gmazyland@gmail.com>
Message-ID: <08f953e4-204d-a278-0021-09dfc77cae88@gmail.com>
Date: Tue, 22 Aug 2017 12:53:28 +0200
MIME-Version: 1.0
In-Reply-To: <cover.1503084216.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/18/2017 09:27 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Patches 1 and 3 are from the original series.
> 
> Patch 2 gets rid of the redundant struct loop_device.lo_logical_blocksize
> in favor of using the queue's own logical_block_size. Karel, I decided
> against adding another sysfs entry since it will always be the same as
> queue/logical_block_size, is that alright with you?
> 
> Omar Sandoval (3):
>   loop: fix hang if LOOP_SET_STATUS gets invalid blocksize or encrypt
>     type
>   loop: use queue limit instead of private lo_logical_blocksize
>   loop: always return block size in LOOP_GET_STATUS

I tested these with cryptsetup & loop mapping with added block size setting
and it fixes loop problems I see in 4.13.

I think all these patches should go to 4.13.

Thanks!
Milan
