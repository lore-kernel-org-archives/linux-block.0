Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122A3C46467
	for <linux-block@archiver.kernel.org>; Mon, 16 Jan 2023 18:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjAPS26 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Jan 2023 13:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbjAPS2a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Jan 2023 13:28:30 -0500
Received: from smtp.tiscali.it (michael-notr.mail.tiscali.it [213.205.33.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 495AA41B64
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 10:14:46 -0800 (PST)
Received: from [192.168.178.50] ([79.40.78.92])
        by michael.mail.tiscali.it with 
        id 9WEh2900t1zVZtK01WEhD8; Mon, 16 Jan 2023 18:14:44 +0000
x-auth-user: fantonifabio@tiscali.it
Message-ID: <62a18c7d-93d9-657e-48fd-1af06d6d1d9e@tiscali.it>
Date:   Mon, 16 Jan 2023 19:14:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: fantonifabio@tiscali.it
Subject: Re: [PATCH v2] documentation: fix Generic Block Device Capability
To:     Christoph Hellwig <hch@infradead.org>
Cc:     corbet@lwn.net, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergei Shtepa <sergei.shtepa@veeam.com>
References: <20230110132104.12499-1-fantonifabio@tiscali.it>
 <Y8WPFMFxpfdZKs5a@infradead.org>
From:   Fabio Fantoni <fantonifabio@tiscali.it>
In-Reply-To: <Y8WPFMFxpfdZKs5a@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: Avast (VPS 230116-4, 16/1/2023), Outbound message
X-Antivirus-Status: Clean
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1673892884; bh=3U/UMDrt1ERP+4W8WcGd8ghmP5Kf8zFnC0ua/Movv7Y=;
        h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To;
        b=GXjGttE24bptT6Mg2kDVcWMNAS76gup0cyC7Zno3Cvyvsqc9YjaPFpJnVt0NHaxCO
         1SFRI/l3BW06lufYD9cNbvRrCflFMqvhAgrMtoewpkyL16okj5dOmRH8rHnMfm+pvF
         8DALWSyCTRrlzIw1VrSuh0Yt9g7RyA/9N0ckuGS0=
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Il 16/01/2023 18:53, Christoph Hellwig ha scritto:
> On Tue, Jan 10, 2023 at 02:21:04PM +0100, Fabio Fantoni wrote:
>> - * ``GENHD_FL_REMOVABLE``: indicates that the block device gives access to
>> + * ``GENHD_FL_REMOVABLE`` (0x01): indicates that the block device gives access to
> The numberic values really do not belong into the documentation.  They
> are just implementation details.
>
Thanks for reply, if values are not into the documentation see from 
/sys/block/<disk>/capability output what flags are enabled will require 
look to source code of include/linux/blkdev.h and 
Documentation/block/capability.rst will be less useful, or I'm wrong?

