Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB38CC433F5
	for <linux-block@archiver.kernel.org>; Wed,  1 Dec 2021 07:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhLAHOk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Dec 2021 02:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347109AbhLAHOk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Dec 2021 02:14:40 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB13AC061574
        for <linux-block@vger.kernel.org>; Tue, 30 Nov 2021 23:11:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EC157CE1C91
        for <linux-block@vger.kernel.org>; Wed,  1 Dec 2021 07:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10A6C53FCC;
        Wed,  1 Dec 2021 07:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638342676;
        bh=Eu6q86jxzxhUQPoYNyhalPx1LxUiHi1MZSvHbSR96CE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VPqkfhRCo7jYRKdny71KtcOFOX07JRz+PfTnNBbKvV6TqB4rVTH0LmGTMwglGDpce
         /zMJVvONnyXNk1TsW1cvo23Kfgml8Ep5T/vbQVFRDa026VZl98y+F3CAcEz3U5aoBB
         Rgr1QbLUybUuPgho3Vq4v8diZCDqcJz7ou1Q3hu8=
Date:   Wed, 1 Dec 2021 08:11:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kumaravel.Thiagarajan@microchip.com
Cc:     lee.jones@linaro.org, Pragash.Mangalapandian@microchip.com,
        Sundararaman.H@microchip.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        LakshmiPraveen.Kopparthi@microchip.com, Ronnie.Kunin@microchip.com
Subject: Re: Reg: New MFD Driver for my PCIe Device
Message-ID: <YacgD5QXJPg/AwDH@kroah.com>
References: <YYkEP62JRb4rCuXQ@google.com>
 <YYkGkEiPb+6J62hn@kroah.com>
 <YYkJsbbHH6wdPvB9@google.com>
 <YYkR/szsDirtj1FP@kroah.com>
 <CH0PR11MB5380791976D5837E024D5679E9999@CH0PR11MB5380.namprd11.prod.outlook.com>
 <YZO+KktO3OhDEtlq@kroah.com>
 <CH0PR11MB5380439460BADE102D91C18AE99C9@CH0PR11MB5380.namprd11.prod.outlook.com>
 <YZe6TPrf4Drh7HpI@kroah.com>
 <CH0PR11MB5380DAC79E3D01C7D1D6008AE9609@CH0PR11MB5380.namprd11.prod.outlook.com>
 <BL1PR11MB538172ECC1F112D2F6E0D734E9679@BL1PR11MB5381.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR11MB538172ECC1F112D2F6E0D734E9679@BL1PR11MB5381.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 30, 2021 at 05:42:14PM +0000, Kumaravel.Thiagarajan@microchip.com wrote:
> Dear Greg KH,
> 
> In case you missed my last email below, I have tried to answer your questions in that email.
> Please let me know if you have any further questions or concerns.

At the moment, no, I was waiting for patches to comment further.

thanks,

greg k-h
