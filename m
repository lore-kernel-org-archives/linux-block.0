Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:40918 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbdHASGh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Aug 2017 14:06:37 -0400
Date: Tue, 1 Aug 2017 11:06:35 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Ethan Zhao <ethan.zhao@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        ethan.kernel@gmail.com
Subject: Re: [PATCH] sysfs: replace WARN() with pr_debug in
 sysfs_remove_group()
Message-ID: <20170801180635.GA31628@kroah.com>
References: <1501574545-15691-1-git-send-email-ethan.zhao@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1501574545-15691-1-git-send-email-ethan.zhao@oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Aug 01, 2017 at 05:02:25PM +0900, Ethan Zhao wrote:
> There is no enough error handling in block device adding/registration
> path, for example,
> 
> device_add_disk()
>   blk_register_queue()
> 
> When kernel returns from device_add_disk(), no return value to tell
> us it was successful or not --- that suggests it would always succeed,
> and according to this assumption, then during block device removal/
> unregistration steps,
> 
> sd_remove()
>   del_gendisk()
>     blk_unregister_queue()
> 
> dpm_sysfs_remove(), blk_trace_remove_sysfs() will be called blindly,
> though there is likely no 'trace' 'power' sysfs groups there because
> actually blk_register_queue()/device_add() failed somewhere. thus
> causes WARN flood emitted from sysfs_remove_group() as following triggered
> by unloading fnic driver:

Then fix the real issue here, don't paper over the issue by changing the
sysfs core please.  No other subsystem seems to be having this issue.

thanks,

greg k-h
