Return-Path: <SRS0=fyvH=WM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B35BC3A59E
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 07:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677152077C
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 07:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565939392;
	bh=Om/sSpg0RakxstiH26UedftlQSd8XlHEajLqjBLn0hc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kI2Tm6x26+jy4h3boer6ojZQY/lpliyV31gYBed3Zx+7thbp7tDu1T0F45V+MI0wd
	 aZVYmI6eoR8I5gEJu/BxB29erymh0j3xLUn8jaozmSDiLhQDiPX/nWiOAiZWKpCQo4
	 aJEzMosE4r5/HT81deMfrYDWDDBu4MORg2HF8y8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfHPHJv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Aug 2019 03:09:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbfHPHJv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Aug 2019 03:09:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A17D62077C;
        Fri, 16 Aug 2019 07:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565939391;
        bh=Om/sSpg0RakxstiH26UedftlQSd8XlHEajLqjBLn0hc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NhVlSvTCAq/dBXi4tMdsqmZAFsaSYfK8S5EZ0NXM7nbL3l7JwbtPf2W1BQI2dRe6y
         eKZUlLdmnDvOmrA463eRL9Fcbov5nlTFaCPgI+M3UikHXLh367wKGJn3dfykg2mKDH
         yMKef50iFpjke7tZkODhRMI1BX5fyzlIK6nDp+IM=
Date:   Fri, 16 Aug 2019 09:09:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        stable@vger.kernel.org, Mark Ray <mark.ray@hpe.com>
Subject: Re: [PATCH V2] blk-mq: avoid sysfs buffer overflow by too many CPU
 cores
Message-ID: <20190816070948.GD1368@kroah.com>
References: <20190816025417.28964-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816025417.28964-1-ming.lei@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 16, 2019 at 10:54:17AM +0800, Ming Lei wrote:
> It is reported that sysfs buffer overflow can be triggered in case
> of too many CPU cores(>841 on 4K PAGE_SIZE) when showing CPUs in
> blk_mq_hw_sysfs_cpus_show().
> 
> So use cpumap_print_to_pagebuf() to print the info and fix the potential
> buffer overflow issue.
> 
> Cc: stable@vger.kernel.org
> Cc: Mark Ray <mark.ray@hpe.com>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Fixes: 676141e48af7("blk-mq: don't dump CPU -> hw queue map on driver load")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq-sysfs.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)

No list of what changed from v1 under here?

Anyway, no, just delete the attribute please.

thanks,

greg k-h
