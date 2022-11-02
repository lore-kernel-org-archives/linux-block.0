Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CBAC4332F
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 18:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiKBSqO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 14:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbiKBSqM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 14:46:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5772CDC5
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 11:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667414714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o2V7PF5Cvb562gFELbc+jq3ofeoF6yfCR8t9uYJeyqA=;
        b=P5mABxfvdGEsQE17pXWBb/vT5r0aqr/QrFAzss4nox9CnvSadJOPinZHmPw2l/bzzzyd+6
        yACs8ehEh4k3utmlbLPnPH64OJTs4oDtScGe2DUQ8AMfolkDjfiCrAnY6AwDT0+c+mMQbW
        GM5m0D7F9Ln52+R7v4bdS+f3FD398P4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-IbZlgl5gMyaCrxxXFUndNQ-1; Wed, 02 Nov 2022 14:45:11 -0400
X-MC-Unique: IbZlgl5gMyaCrxxXFUndNQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D41973C0D1A7;
        Wed,  2 Nov 2022 18:45:10 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BCC101121320;
        Wed,  2 Nov 2022 18:45:10 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 2A2IjAgP003018;
        Wed, 2 Nov 2022 14:45:10 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 2A2IjATr003014;
        Wed, 2 Nov 2022 14:45:10 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 2 Nov 2022 14:45:10 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Eric Biggers <ebiggers@kernel.org>
cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [dm-devel] Regression: wrong DIO alignment check with dm-crypt
In-Reply-To: <Y2Hf08vIKBkl5tu0@sol.localdomain>
Message-ID: <alpine.LRH.2.21.2211021434180.2087@file01.intranet.prod.int.rdu2.redhat.com>
References: <Y2Hf08vIKBkl5tu0@sol.localdomain>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi


On Tue, 1 Nov 2022, Eric Biggers wrote:

> Hi,
> 
> I happened to notice the following QEMU bug report:
> 
> https://gitlab.com/qemu-project/qemu/-/issues/1290
> 
> I believe it's a regression from the following kernel commit:
> 
>     commit b1a000d3b8ec582da64bb644be633e5a0beffcbf
>     Author: Keith Busch <kbusch@kernel.org>
>     Date:   Fri Jun 10 12:58:29 2022 -0700
> 
>         block: relax direct io memory alignment

I suggest to revert this patch.

> The bug is that if a dm-crypt device is set up with a crypto sector size (and
> thus also a logical_block_size) of 4096, then the block layer now lets through
> direct I/O requests to dm-crypt when the user buffer has only 512-byte
> alignment, instead of the 4096-bytes expected by dm-crypt in that case.  This is
> because the dma_alignment of the device-mapper device is only 511 bytes.

Propagating dma_alignment through the device mapper stack would be hard 
(because it is not in struct queue_limits). Perhaps we could set 
dma_alignment to be the equivalent to logical_block_size, if the above 
patch could not be reverted - but the we would hit the issue again when 
someone stacks md or other devices over dm.

> This has two effects in this case:
> 
>     - The error code for DIO with a misaligned buffer is now EIO, instead of
>       EINVAL as expected and documented.  This is because the I/O reaches
>       dm-crypt instead of being rejected by the block layer.
> 
>     - STATX_DIOALIGN reports 512 bytes for stx_dio_mem_align, instead of the
>       correct value of 4096.  (Technically not a regression since STATX_DIOALIGN
>       is new in v6.1, but still a bug.)
> 
> Any thoughts on what the correct fix is here?  Maybe the device-mapper layer
> needs to set dma_alignment correctly?  Or maybe the block layer needs to set it
> to 'logical_block_size - 1' by default?
> 
> - Eric
> 
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://listman.redhat.com/mailman/listinfo/dm-devel

Mikulas

