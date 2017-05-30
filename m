Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:34140 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdE3NDg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 May 2017 09:03:36 -0400
Received: by mail-yw0-f177.google.com with SMTP id l14so39543907ywk.1
        for <linux-block@vger.kernel.org>; Tue, 30 May 2017 06:03:35 -0700 (PDT)
Date: Tue, 30 May 2017 13:03:34 +0000
From: Josef Bacik <josef@toxicpanda.com>
To: Shaun McDowell <shaunjmcdowell@gmail.com>
Cc: linux-block@vger.kernel.org, jbacik@fb.com,
        nbd-general@lists.sourceforge.net, bsdkurt@gmail.com
Subject: Re: [PATCH] nbd: add FUA op support
Message-ID: <20170530130333.GC14918@li70-116.members.linode.com>
References: <20170526035554.GA31566@auir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170526035554.GA31566@auir>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, May 25, 2017 at 11:55:54PM -0400, Shaun McDowell wrote:
> NBD userland client and server have FUA (forced unit access) support
> and flags defined. Make NBD kernel module recognize NBD_FLAG_SEND_FUA,
> enable FUA on the queue, and forward FUA requests to the server.
> 
> Signed-off-by: Shaun McDowell <shaunjmcdowell@gmail.com>

Looks good to me, you can add

Reviewed-by: Josef Bacik <jbacik@fb.com>

Thanks,

Josef
