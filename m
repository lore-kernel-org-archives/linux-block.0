Return-Path: <SRS0=fyvH=WM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECED9C3A59E
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 07:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B989B2173E
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 07:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565939557;
	bh=hm54zHKSCIASDf9hCE6eR27gl//Kfc0OjNQywYmSlpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aeP4L7QpsFbz2MKXbIO7L2EL6MwIzbrNoKe07rsvb7OlqJ1n6prW31rMz0Ue1wcnc
	 W67Gsl4ha9ZuB6j5gx1SIkgyr82sOq1quKd01IsHmf+U1BoEkQ3Taishf3plzUdzOf
	 7GDR0682HHQJjA2LckBn+eR+X4DgVw8lVRiH23wc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfHPHMh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Aug 2019 03:12:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbfHPHMg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Aug 2019 03:12:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DACC52133F;
        Fri, 16 Aug 2019 07:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565939556;
        bh=hm54zHKSCIASDf9hCE6eR27gl//Kfc0OjNQywYmSlpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2lRvFbonDZVYz4dPOieZMjgflWbc0txk/HSOXP81HhMZTsHxdV3cJvEJQ/4zRjvdC
         v+jjzhjRzdCXoQk9JYwiW4uA14q5zVP23O2Mo7S5MfeYGoi0icmPGrfK3sN/R2ZxSU
         nEj+2x1j1MHrjm1uRdcWmQA7s4hlRSAI3o7PdeIk=
Date:   Fri, 16 Aug 2019 09:12:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "Ray, Mark C (Global Solutions Engineering (GSE))" <mark.ray@hpe.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: avoid sysfs buffer overflow by too many CPU cores
Message-ID: <20190816071234.GE1368@kroah.com>
References: <20190815121518.16675-1-ming.lei@redhat.com>
 <20190815122419.GA31891@kroah.com>
 <20190815122909.GA28032@ming.t460p>
 <20190815123535.GA29217@kroah.com>
 <20190815124321.GB28032@ming.t460p>
 <AT5PR8401MB05784C37BAF2939B776103FC99AC0@AT5PR8401MB0578.NAMPRD84.PROD.OUTLOOK.COM>
 <20190816024934.GA27844@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816024934.GA27844@ming.t460p>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 16, 2019 at 10:49:35AM +0800, Ming Lei wrote:
> On Thu, Aug 15, 2019 at 11:10:35PM +0000, Ray, Mark C (Global Solutions Engineering (GSE)) wrote:
> > Hi Ming,
> > 
> > In the customer case, the cpu_list file was not needed.   It was just part of a SAP Hana script to collect all the block device data (similar to sosreport).    So they were just dumping everything, and it picks up the mq-related files.  
> > 
> > I know with IRQs, we have bitmaps/mask, and can represent the list such as "0-27", without listing every CPU.   I'm sure there's lots of options to address this, and getting rid of the cpu_list is one of them.
> 
> Indeed, same with several attributes under /sys/devices/system/cpu/,
> actually we can use cpumap_print_to_pagebuf() to print the CPUs.

And that is changing the format of the file, which means it is obvious
no one is using it, so just please delete the thing.

thanks,

greg k-h
